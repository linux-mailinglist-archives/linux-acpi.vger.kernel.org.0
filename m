Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EB621D1D7
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jul 2020 10:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGMIfv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 13 Jul 2020 04:35:51 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726491AbgGMIfu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 13 Jul 2020 04:35:50 -0400
Received: from lhreml716-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id F12E3F5484FE336CEA52;
        Mon, 13 Jul 2020 09:35:48 +0100 (IST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 lhreml716-chm.china.huawei.com (10.201.108.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 13 Jul 2020 09:35:48 +0100
Received: from lhreml715-chm.china.huawei.com ([10.201.108.66]) by
 lhreml715-chm.china.huawei.com ([10.201.108.66]) with mapi id 15.01.1913.007;
 Mon, 13 Jul 2020 09:35:48 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "zhangliguang@linux.alibaba.com" <zhangliguang@linux.alibaba.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "jroedel@suse.de" <jroedel@suse.de>
CC:     Linuxarm <linuxarm@huawei.com>, yangyicong <yangyicong@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        tanxiaofei <tanxiaofei@huawei.com>,
        Shiju Jose <shiju.jose@huawei.com>
Subject: RE: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Topic: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
 (vendor) CPER records
Thread-Index: AQHWSI3SBRG6MT5ZnEeiXXWtP5HqWakFTx6g
Date:   Mon, 13 Jul 2020 08:35:48 +0000
Message-ID: <05c8916f4f85421f871e9cbff112512b@huawei.com>
References: <20200622120527.690-1-shiju.jose@huawei.com>
 <20200622120527.690-2-shiju.jose@huawei.com>
In-Reply-To: <20200622120527.690-2-shiju.jose@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.47.82.58]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Rafael, Hi James,

Can you help to merge this patch because I added and tested all the suggestions from James.

Thanks,
Shiju

>-----Original Message-----
>From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
>owner@vger.kernel.org] On Behalf Of Shiju Jose
>Sent: 22 June 2020 13:05
>To: linux-acpi@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>kernel@vger.kernel.org; rjw@rjwysocki.net; helgaas@kernel.org;
>bp@alien8.de; james.morse@arm.com; lenb@kernel.org;
>tony.luck@intel.com; dan.carpenter@oracle.com;
>zhangliguang@linux.alibaba.com; andriy.shevchenko@linux.intel.com;
>Wangkefeng (OS Kernel Lab) <wangkefeng.wang@huawei.com>;
>jroedel@suse.de
>Cc: Linuxarm <linuxarm@huawei.com>; yangyicong
><yangyicong@huawei.com>; Jonathan Cameron
><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>
>Subject: [PATCH v11 1/2] ACPI / APEI: Add a notifier chain for unknown
>(vendor) CPER records
>
>CPER records describing a firmware-first error are identified by GUID.
>The ghes driver currently logs, but ignores any unknown CPER records.
>This prevents describing errors that can't be represented by a standard entry,
>that would otherwise allow a driver to recover from an error.
>The UEFI spec calls these 'Non-standard Section Body' (N.2.3 of version 2.8).
>
>Add a notifier chain for these non-standard/vendor-records. Callers must
>identify their type of records by GUID.
>
>Record data is copied to memory from the ghes_estatus_pool to allow us to
>keep it until after the notifier has run.
>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com> [ Removed kfifo and
>ghes_gdata_pool. Expanded commit message ]
>Signed-off-by: James Morse <james.morse@arm.com>
>---
> drivers/acpi/apei/ghes.c | 63
>++++++++++++++++++++++++++++++++++++++++
> include/acpi/ghes.h      | 27 +++++++++++++++++
> 2 files changed, 90 insertions(+)
>
>diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c index
>81bf71b10d44..99df00f64306 100644
>--- a/drivers/acpi/apei/ghes.c
>+++ b/drivers/acpi/apei/ghes.c
>@@ -79,6 +79,12 @@
> 	((struct acpi_hest_generic_status *)				\
> 	 ((struct ghes_estatus_node *)(estatus_node) + 1))
>
>+#define GHES_VENDOR_ENTRY_LEN(gdata_len)                               \
>+	(sizeof(struct ghes_vendor_record_entry) + (gdata_len))
>+#define GHES_GDATA_FROM_VENDOR_ENTRY(vendor_entry)                     \
>+	((struct acpi_hest_generic_data *)                              \
>+	((struct ghes_vendor_record_entry *)(vendor_entry) + 1))
>+
> /*
>  *  NMI-like notifications vary by architecture, before the compiler can prune
>  *  unused static functions it needs a value for these enums.
>@@ -123,6 +129,12 @@ static DEFINE_MUTEX(ghes_list_mutex);
>  */
> static DEFINE_SPINLOCK(ghes_notify_lock_irq);
>
>+struct ghes_vendor_record_entry {
>+	struct work_struct work;
>+	int error_severity;
>+	char vendor_record[];
>+};
>+
> static struct gen_pool *ghes_estatus_pool;  static unsigned long
>ghes_estatus_pool_size_request;
>
>@@ -511,6 +523,56 @@ static void ghes_handle_aer(struct
>acpi_hest_generic_data *gdata)  #endif  }
>
>+static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
>+
>+int ghes_register_vendor_record_notifier(struct notifier_block *nb) {
>+	return blocking_notifier_chain_register(&vendor_record_notify_list,
>+nb); } EXPORT_SYMBOL_GPL(ghes_register_vendor_record_notifier);
>+
>+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb)
>+{
>+	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
>}
>+EXPORT_SYMBOL_GPL(ghes_unregister_vendor_record_notifier);
>+
>+static void ghes_vendor_record_work_func(struct work_struct *work) {
>+	struct ghes_vendor_record_entry *entry;
>+	struct acpi_hest_generic_data *gdata;
>+	u32 len;
>+
>+	entry = container_of(work, struct ghes_vendor_record_entry, work);
>+	gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
>+
>+	blocking_notifier_call_chain(&vendor_record_notify_list,
>+				     entry->error_severity, gdata);
>+
>+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
>+	gen_pool_free(ghes_estatus_pool, (unsigned long)entry, len); }
>+
>+static void ghes_defer_non_standard_event(struct acpi_hest_generic_data
>*gdata,
>+					  int sev)
>+{
>+	struct acpi_hest_generic_data *copied_gdata;
>+	struct ghes_vendor_record_entry *entry;
>+	u32 len;
>+
>+	len = GHES_VENDOR_ENTRY_LEN(acpi_hest_get_record_size(gdata));
>+	entry = (void *)gen_pool_alloc(ghes_estatus_pool, len);
>+	if (!entry)
>+		return;
>+
>+	copied_gdata = GHES_GDATA_FROM_VENDOR_ENTRY(entry);
>+	memcpy(copied_gdata, gdata, acpi_hest_get_record_size(gdata));
>+	entry->error_severity = sev;
>+
>+	INIT_WORK(&entry->work, ghes_vendor_record_work_func);
>+	schedule_work(&entry->work);
>+}
>+
> static bool ghes_do_proc(struct ghes *ghes,
> 			 const struct acpi_hest_generic_status *estatus)  {
>@@ -549,6 +611,7 @@ static bool ghes_do_proc(struct ghes *ghes,
> 		} else {
> 			void *err = acpi_hest_get_payload(gdata);
>
>+			ghes_defer_non_standard_event(gdata, sev);
> 			log_non_standard_event(sec_type, fru_id, fru_text,
> 					       sec_sev, err,
> 					       gdata->error_data_length);
>diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h index
>517a5231cc1b..ae0e8847fdd5 100644
>--- a/include/acpi/ghes.h
>+++ b/include/acpi/ghes.h
>@@ -53,6 +53,33 @@ enum {
> 	GHES_SEV_PANIC = 0x3,
> };
>
>+#ifdef CONFIG_ACPI_APEI_GHES
>+/**
>+ * ghes_register_vendor_record_notifier - register a notifier for
>+vendor
>+ * records that the kernel would otherwise ignore.
>+ * @nb: pointer to the notifier_block structure of the event handler.
>+ *
>+ * return 0 : SUCCESS, non-zero : FAIL
>+ */
>+int ghes_register_vendor_record_notifier(struct notifier_block *nb);
>+
>+/**
>+ * ghes_unregister_vendor_record_notifier - unregister the previously
>+ * registered vendor record notifier.
>+ * @nb: pointer to the notifier_block structure of the vendor record
>handler.
>+ */
>+void ghes_unregister_vendor_record_notifier(struct notifier_block *nb);
>+#else static inline int ghes_register_vendor_record_notifier(struct
>+notifier_block *nb) {
>+	return -ENODEV;
>+}
>+
>+static inline void ghes_unregister_vendor_record_notifier(struct
>+notifier_block *nb) { } #endif
>+
> int ghes_estatus_pool_init(int num_ghes);
>
> /* From drivers/edac/ghes_edac.c */
>--
>2.17.1
>

