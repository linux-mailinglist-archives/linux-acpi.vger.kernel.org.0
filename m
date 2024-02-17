Return-Path: <linux-acpi+bounces-3659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0358592B5
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 025A92815D9
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Feb 2024 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D3F9E0;
	Sat, 17 Feb 2024 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DFRR8fhe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9F87F7C1;
	Sat, 17 Feb 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708201781; cv=none; b=kziM2eFp2PwkaY7CT+9dcfHAHFDGBBUTBR9LTl0hMJsY1fgRkkdyHPKWWKNAHFdmh3u4N5mssnHoEjr/BTG2mpA6kagN38nfgqGA3BQXobBxnv9yx7CEkXJO+ND8HUVjdDWt5XZIlJ7VRRLyMcWOfLrImFGQarTG7ujJ9sTSYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708201781; c=relaxed/simple;
	bh=HDAH2UmcW0hGy2T3vjbxkRM0fjDAjoUyVM54XtrTX9E=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=ociOBTCNsXI6lSjDHH65ECNrh5wdRP9IvKcIpSlHPzsQRzu+j0BzI+sCHLhXMJlxinQePh+z5FvyUJZfBq9muQTy38M5ZWsFEEusMMvp0VWfgIc91y96EJPHk/u2KHwqcqh+t6Dgny5f2yOSq3O7N1Xd99PLreSxWqKGLR7nyUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DFRR8fhe; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708201780; x=1739737780;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HDAH2UmcW0hGy2T3vjbxkRM0fjDAjoUyVM54XtrTX9E=;
  b=DFRR8fheqSPrGqRElh8XugbsMRwB4D8eBCqY0tFPmz7BLzkWKWPBfk/N
   ErE8Xlm81urTcmLot+iJwIU3UFdu9/809KHRe5uz5pdn9q5G+bY4fFN5+
   eVZEuCgWIOAtNSPgEvBufY5gyBy3RlqxXfG47TfYRG+bT8zZOcuZnCC+x
   q4E/K9p6AZR6RB4dh72Uw/Rk6T8r0xIntkb43v+uRk7xxNlABojTU7ncs
   9p7Uj/YdkOIhAyYxPKeOxUmuix/dffHUTClrSoB6I/Szn9soLB9XRAYpw
   fVT2s2XsGI9lFF4HOvGrcSJNBQQl9Dzz6pr/EEOlCd6tHRb/avgi/njjm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="27764459"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="27764459"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 12:29:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="8746320"
Received: from pyuvaraj-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.255.230.205])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 12:29:39 -0800
Subject: [PATCH] acpi/ghes: Remove CXL CPER notifications
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, vishal.l.verma@intel.com,
 alison.schofield@intel.com, linux-acpi@vger.kernel.org
Date: Sat, 17 Feb 2024 12:29:38 -0800
Message-ID: <170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Initial tests with the CXL CPER implementation identified that error
reports were being duplicated in the log and the trace event [1].  Then
it was discovered that the notification handler took sleeping locks
while the GHES event handling runs in spin_lock_irqsave() context [2]

Given multiple bugs to fix and how late it is in the development cycle,
remove the CXL hookup for now and try again during the next merge
window.

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: http://lore.kernel.org/r/20240108165855.00002f5a@Huawei.com [1]
Closes: http://lore.kernel.org/r/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain [2]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/apei/ghes.c  |   89 ---------------------------------------------
 drivers/cxl/pci.c         |   57 +----------------------------
 include/linux/cxl-event.h |   18 ---------
 3 files changed, 1 insertion(+), 163 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7b7c605166e0..ab2a82cb1b0b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
-#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -674,78 +673,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
-/*
- * Only a single callback can be registered for CXL CPER events.
- */
-static DECLARE_RWSEM(cxl_cper_rw_sem);
-static cxl_cper_callback cper_callback;
-
-/* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
-
-/*
- * General Media Event Record
- * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
- */
-#define CPER_SEC_CXL_GEN_MEDIA_GUID					\
-	GUID_INIT(0xfbcd0a77, 0xc260, 0x417f,				\
-		  0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6)
-
-/*
- * DRAM Event Record
- * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
- */
-#define CPER_SEC_CXL_DRAM_GUID						\
-	GUID_INIT(0x601dcbb3, 0x9c06, 0x4eab,				\
-		  0xb8, 0xaf, 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24)
-
-/*
- * Memory Module Event Record
- * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
- */
-#define CPER_SEC_CXL_MEM_MODULE_GUID					\
-	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
-		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
-
-static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
-{
-	if (rec->hdr.length <= sizeof(rec->hdr) ||
-	    rec->hdr.length > sizeof(*rec)) {
-		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
-		       rec->hdr.length);
-		return;
-	}
-
-	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
-		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
-	}
-
-	guard(rwsem_read)(&cxl_cper_rw_sem);
-	if (cper_callback)
-		cper_callback(event_type, rec);
-}
-
-int cxl_cper_register_callback(cxl_cper_callback callback)
-{
-	guard(rwsem_write)(&cxl_cper_rw_sem);
-	if (cper_callback)
-		return -EINVAL;
-	cper_callback = callback;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
-
-int cxl_cper_unregister_callback(cxl_cper_callback callback)
-{
-	guard(rwsem_write)(&cxl_cper_rw_sem);
-	if (callback != cper_callback)
-		return -EINVAL;
-	cper_callback = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
-
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -780,22 +707,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
-		} else if (guid_equal(sec_type,
-				      &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 233e7c42c161..2ff361e756d6 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -974,61 +974,6 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
-#define CXL_EVENT_HDR_FLAGS_REC_SEVERITY GENMASK(1, 0)
-static void cxl_cper_event_call(enum cxl_event_type ev_type,
-				struct cxl_cper_event_rec *rec)
-{
-	struct cper_cxl_event_devid *device_id = &rec->hdr.device_id;
-	struct pci_dev *pdev __free(pci_dev_put) = NULL;
-	enum cxl_event_log_type log_type;
-	struct cxl_dev_state *cxlds;
-	unsigned int devfn;
-	u32 hdr_flags;
-
-	devfn = PCI_DEVFN(device_id->device_num, device_id->func_num);
-	pdev = pci_get_domain_bus_and_slot(device_id->segment_num,
-					   device_id->bus_num, devfn);
-	if (!pdev)
-		return;
-
-	guard(pci_dev)(pdev);
-	if (pdev->driver != &cxl_pci_driver)
-		return;
-
-	cxlds = pci_get_drvdata(pdev);
-	if (!cxlds)
-		return;
-
-	/* Fabricate a log type */
-	hdr_flags = get_unaligned_le24(rec->event.generic.hdr.flags);
-	log_type = FIELD_GET(CXL_EVENT_HDR_FLAGS_REC_SEVERITY, hdr_flags);
-
-	cxl_event_trace_record(cxlds->cxlmd, log_type, ev_type,
-			       &uuid_null, &rec->event);
-}
-
-static int __init cxl_pci_driver_init(void)
-{
-	int rc;
-
-	rc = cxl_cper_register_callback(cxl_cper_event_call);
-	if (rc)
-		return rc;
-
-	rc = pci_register_driver(&cxl_pci_driver);
-	if (rc)
-		cxl_cper_unregister_callback(cxl_cper_event_call);
-
-	return rc;
-}
-
-static void __exit cxl_pci_driver_exit(void)
-{
-	pci_unregister_driver(&cxl_pci_driver);
-	cxl_cper_unregister_callback(cxl_cper_event_call);
-}
-
-module_init(cxl_pci_driver_init);
-module_exit(cxl_pci_driver_exit);
+module_pci_driver(cxl_pci_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 91125eca4c8a..03fa6d50d46f 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -140,22 +140,4 @@ struct cxl_cper_event_rec {
 	union cxl_event event;
 } __packed;
 
-typedef void (*cxl_cper_callback)(enum cxl_event_type type,
-				  struct cxl_cper_event_rec *rec);
-
-#ifdef CONFIG_ACPI_APEI_GHES
-int cxl_cper_register_callback(cxl_cper_callback callback);
-int cxl_cper_unregister_callback(cxl_cper_callback callback);
-#else
-static inline int cxl_cper_register_callback(cxl_cper_callback callback)
-{
-	return 0;
-}
-
-static inline int cxl_cper_unregister_callback(cxl_cper_callback callback)
-{
-	return 0;
-}
-#endif
-
 #endif /* _LINUX_CXL_EVENT_H */


