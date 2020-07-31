Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12B23472F
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jul 2020 15:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgGaNtH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 31 Jul 2020 09:49:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59558 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgGaNtH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Jul 2020 09:49:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B7F431B;
        Fri, 31 Jul 2020 06:49:06 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EF2E23F66E;
        Fri, 31 Jul 2020 06:49:05 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-acpi@vger.kernel.org
Subject: [RESEND PATCH v13] ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records
Date:   Fri, 31 Jul 2020 13:48:42 +0000
Message-Id: <20200731134842.4832-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

CPER records describing a firmware-first error are identified by GUID.
The ghes driver currently logs, but ignores any unknown CPER records.
This prevents describing errors that can't be represented by a standard
entry, that would otherwise allow a driver to recover from an error.
The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of
version 2.8).

Add a notifier chain for these non-standard/vendor-records. Callers
must identify their type of records by GUID.

Record data is copied to memory from the ghes_estatus_pool to allow
us to keep it until after the notifier has run.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/apei/ghes.c | 63 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      | 27 +++++++++++++++++
 2 files changed, 90 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 81bf71b10d44..99df00f64306 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -79,6 +79,12 @@
 	((struct acpi_hest_generic_status *)				\
 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
 
+#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
+	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
+#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
+	((struct acpi_hest_generic_data *)                              \
+	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
+
 /*
  *  NMI-like notifications vary by architecture, before the compiler can prune
  *  unused static functions it needs a value for these enums.
@@ -123,6 +129,12 @@ static DEFINE_MUTEX(ghes_list_mutex);
  */
 static DEFINE_SPINLOCK(ghes_notify_lock_irq);
 
+struct ghes_vendor_record_entry {
+	struct work_struct work;
+	int error_severity;
+	char vendor_record[];
+};
+
 static struct gen_pool *ghes_estatus_pool;
 static unsigned long ghes_estatus_pool_size_request;
 
@@ -511,6 +523,56 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 #endif
 }
 
+static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
+
+int ghes_register_vendor_record_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
+
+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
+}
+EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
+
+static void ghes_vendor_record_work_func(struct work_struct *work)
+{
+	struct ghes_vendor_record_entry *entry;
+	struct acpi_hest_generic_data *gdata;
+	u32 len;
+
+	entry = container_of(work, struct ghes_vendor_record_entry, work);
+	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
+
+	blocking_notifier_call_chain(&vendor_record_notify_list,
+				     entry->error_severity, gdata);
+
+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
+	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len);
+}
+
+static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
+					  int sev)
+{
+	struct acpi_hest_generic_data *copied_gdata;
+	struct ghes_vendor_record_entry *entry;
+	u32 len;
+
+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
+	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
+	if (!entry)
+		return;
+
+	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
+	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
+	entry->error_severity = sev;
+
+	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
+	schedule_work(&entry->work);
+}
+
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -549,6 +611,7 @@ static bool ghes_do_proc(struct ghes *ghes,
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
+			ghes_defer_non_standard_event(gdata, sev);
 			log_non_standard_event(sec_type, fru_id, fru_text,
 					       sec_sev, err,
 					       gdata->error_data_length);
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index 517a5231cc1b..491bd8c6d600 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -53,6 +53,33 @@ enum {
 	GHES_SEV_PANIC = 0x3,
 };
 
+#ifdef CONFIG_ACPI_APEI_GHES
+/**
+ * ghes_register_vendor_record_notifier - register a notifier for vendor
+ * records that the kernel would otherwise ignore.
+ * @nb: pointer to the notifier_block structure of the event handler.
+ *
+ * return 0 : SUCCESS, non-zero : FAIL
+ */
+int ghes_register_vendor_record_notifier(struct notifier_block *nb);
+
+/**
+ * ghes_unregister_vendor_record_notifier - unregister the previously
+ * registered vendor record notifier.
+ * @nb: pointer to the notifier_block structure of the vendor record handler.
+ */
+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
+#else
+static inline int ghes_register_vendor_record_notifier(struct notifier_block *nb)
+{
+	return -ENODEV;
+}
+
+static inline void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
+{
+}
+#endif
+
 int ghes_estatus_pool_init(int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
-- 
2.27.0

