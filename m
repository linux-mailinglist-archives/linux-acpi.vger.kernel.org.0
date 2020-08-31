Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA99A258389
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Aug 2020 23:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgHaVar (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 31 Aug 2020 17:30:47 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728753AbgHaVaq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 31 Aug 2020 17:30:46 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 0D83A7512EBB5A31CFD2;
        Mon, 31 Aug 2020 22:30:45 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.250) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 31 Aug 2020 22:30:44 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rjw@rjwysocki.net>,
        <helgaas@kernel.org>, <bp@alien8.de>, <james.morse@arm.com>,
        <lorenzo.pieralisi@arm.com>, <robh@kernel.org>, <lenb@kernel.org>,
        <tony.luck@intel.com>, <dan.carpenter@oracle.com>,
        <andriy.shevchenko@linux.intel.com>
CC:     <yangyicong@hisilicon.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <linuxarm@huawei.com>
Subject: [RESEND PATCH v14 1/2] ACPI / APEI: Add a notifier chain for unknown (vendor) CPER records
Date:   Mon, 31 Aug 2020 22:26:05 +0100
Message-ID: <20200831212606.1718-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20200831212606.1718-1-shiju.jose@huawei.com>
References: <20200831212606.1718-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.25.250]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

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

Co-developed-by: James Morse <james.morse@arm.com>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 drivers/acpi/apei/ghes.c | 63 ++++++++++++++++++++++++++++++++++++++++
 include/acpi/ghes.h      | 18 ++++++++++++
 2 files changed, 81 insertions(+)

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
index 517a5231cc1b..34fb3431a8f3 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -53,6 +53,24 @@ enum {
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
+#endif
+
 int ghes_estatus_pool_init(int num_ghes);
 
 /* From drivers/edac/ghes_edac.c */
-- 
2.17.1


