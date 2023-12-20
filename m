Return-Path: <linux-acpi+bounces-2562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A72498196BE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 03:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DF0F288744
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Dec 2023 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291D179CD;
	Wed, 20 Dec 2023 02:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HWvjQfue"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B2A846B
	for <linux-acpi@vger.kernel.org>; Wed, 20 Dec 2023 02:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703038533; x=1734574533;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7kuQy2XaY9QSIQOfa23s1J3GFQKI9Dp4z6qxJXAn4Fc=;
  b=HWvjQfueNgLAKRwyEr94MvpkfbXIcAhsJHZLTkW2z4O9hbLITmVtGSvr
   l5NPzxjt50K8ameIUkBIOuqn40iIjsYTfwKMVjv0HMafWRedv2FPssybD
   ZM2Z88taCQd4WVHjgPnC7pPn3QqYuZLbMA7PC2mFe60FRv+6YoV7S5kNW
   9aPpIxHBpo4WDyvLbKVIM+Txo1c0nqkTt6EA0zzJ11pMj7MYWXlLlXTm/
   56+73eMUxSOFiuxKLiljeuo5sv+xCSUQSCohcqFh0NIYihh28+8wLgS8p
   H3LqyXEmUYMrYb0dBKFhWCqJAMM0mUdxI91bgz70vstwX9Xay0BShLIqU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="9212133"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="9212133"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:15:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023328612"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="1023328612"
Received: from amerwada-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.175.123])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 18:15:14 -0800
Subject: [PATCH] acpi/nfit: Use sysfs_emit() for all attributes
From: Dan Williams <dan.j.williams@intel.com>
To: nvdimm@lists.linux.dev
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
 Alison Schofield <alison.schofield@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-acpi@vger.kernel.org
Date: Tue, 19 Dec 2023 18:15:13 -0800
Message-ID: <170303851337.2238503.5103082574938957743.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

sysfs_emit() properly handles the PAGE_SIZE limitation of populating
sysfs attribute buffers. Clean up the deprecated usage of sprintf() in
all of nfit's sysfs show() handlers.

Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Closes: http://lore.kernel.org/0d1bf461-d9e8-88bc-b7e2-b03b56594213@codethink.co.uk
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 992385537757..9f44156c6181 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1186,7 +1186,7 @@ static ssize_t bus_dsm_mask_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%#lx\n", acpi_desc->bus_dsm_mask);
+	return sysfs_emit(buf, "%#lx\n", acpi_desc->bus_dsm_mask);
 }
 static struct device_attribute dev_attr_bus_dsm_mask =
 		__ATTR(dsm_mask, 0444, bus_dsm_mask_show, NULL);
@@ -1198,7 +1198,7 @@ static ssize_t revision_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%d\n", acpi_desc->acpi_header.revision);
+	return sysfs_emit(buf, "%d\n", acpi_desc->acpi_header.revision);
 }
 static DEVICE_ATTR_RO(revision);
 
@@ -1209,7 +1209,7 @@ static ssize_t hw_error_scrub_show(struct device *dev,
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%d\n", acpi_desc->scrub_mode);
+	return sysfs_emit(buf, "%d\n", acpi_desc->scrub_mode);
 }
 
 /*
@@ -1278,7 +1278,7 @@ static ssize_t scrub_show(struct device *dev,
 	mutex_lock(&acpi_desc->init_mutex);
 	busy = test_bit(ARS_BUSY, &acpi_desc->scrub_flags)
 		&& !test_bit(ARS_CANCEL, &acpi_desc->scrub_flags);
-	rc = sprintf(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
+	rc = sysfs_emit(buf, "%d%s", acpi_desc->scrub_count, busy ? "+\n" : "\n");
 	/* Allow an admin to poll the busy state at a higher rate */
 	if (busy && capable(CAP_SYS_RAWIO) && !test_and_set_bit(ARS_POLL,
 				&acpi_desc->scrub_flags)) {
@@ -1382,7 +1382,7 @@ static ssize_t handle_show(struct device *dev,
 {
 	struct acpi_nfit_memory_map *memdev = to_nfit_memdev(dev);
 
-	return sprintf(buf, "%#x\n", memdev->device_handle);
+	return sysfs_emit(buf, "%#x\n", memdev->device_handle);
 }
 static DEVICE_ATTR_RO(handle);
 
@@ -1391,7 +1391,7 @@ static ssize_t phys_id_show(struct device *dev,
 {
 	struct acpi_nfit_memory_map *memdev = to_nfit_memdev(dev);
 
-	return sprintf(buf, "%#x\n", memdev->physical_id);
+	return sysfs_emit(buf, "%#x\n", memdev->physical_id);
 }
 static DEVICE_ATTR_RO(phys_id);
 
@@ -1400,7 +1400,7 @@ static ssize_t vendor_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->vendor_id));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->vendor_id));
 }
 static DEVICE_ATTR_RO(vendor);
 
@@ -1409,7 +1409,7 @@ static ssize_t rev_id_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->revision_id));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->revision_id));
 }
 static DEVICE_ATTR_RO(rev_id);
 
@@ -1418,7 +1418,7 @@ static ssize_t device_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->device_id));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->device_id));
 }
 static DEVICE_ATTR_RO(device);
 
@@ -1427,7 +1427,7 @@ static ssize_t subsystem_vendor_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_vendor_id));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_vendor_id));
 }
 static DEVICE_ATTR_RO(subsystem_vendor);
 
@@ -1436,7 +1436,7 @@ static ssize_t subsystem_rev_id_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n",
+	return sysfs_emit(buf, "0x%04x\n",
 			be16_to_cpu(dcr->subsystem_revision_id));
 }
 static DEVICE_ATTR_RO(subsystem_rev_id);
@@ -1446,7 +1446,7 @@ static ssize_t subsystem_device_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_device_id));
+	return sysfs_emit(buf, "0x%04x\n", be16_to_cpu(dcr->subsystem_device_id));
 }
 static DEVICE_ATTR_RO(subsystem_device);
 
@@ -1465,7 +1465,7 @@ static ssize_t format_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%04x\n", le16_to_cpu(dcr->code));
+	return sysfs_emit(buf, "0x%04x\n", le16_to_cpu(dcr->code));
 }
 static DEVICE_ATTR_RO(format);
 
@@ -1498,7 +1498,7 @@ static ssize_t format1_show(struct device *dev,
 				continue;
 			if (nfit_dcr->dcr->code == dcr->code)
 				continue;
-			rc = sprintf(buf, "0x%04x\n",
+			rc = sysfs_emit(buf, "0x%04x\n",
 					le16_to_cpu(nfit_dcr->dcr->code));
 			break;
 		}
@@ -1515,7 +1515,7 @@ static ssize_t formats_show(struct device *dev,
 {
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 
-	return sprintf(buf, "%d\n", num_nvdimm_formats(nvdimm));
+	return sysfs_emit(buf, "%d\n", num_nvdimm_formats(nvdimm));
 }
 static DEVICE_ATTR_RO(formats);
 
@@ -1524,7 +1524,7 @@ static ssize_t serial_show(struct device *dev,
 {
 	struct acpi_nfit_control_region *dcr = to_nfit_dcr(dev);
 
-	return sprintf(buf, "0x%08x\n", be32_to_cpu(dcr->serial_number));
+	return sysfs_emit(buf, "0x%08x\n", be32_to_cpu(dcr->serial_number));
 }
 static DEVICE_ATTR_RO(serial);
 
@@ -1536,7 +1536,7 @@ static ssize_t family_show(struct device *dev,
 
 	if (nfit_mem->family < 0)
 		return -ENXIO;
-	return sprintf(buf, "%d\n", nfit_mem->family);
+	return sysfs_emit(buf, "%d\n", nfit_mem->family);
 }
 static DEVICE_ATTR_RO(family);
 
@@ -1548,7 +1548,7 @@ static ssize_t dsm_mask_show(struct device *dev,
 
 	if (nfit_mem->family < 0)
 		return -ENXIO;
-	return sprintf(buf, "%#lx\n", nfit_mem->dsm_mask);
+	return sysfs_emit(buf, "%#lx\n", nfit_mem->dsm_mask);
 }
 static DEVICE_ATTR_RO(dsm_mask);
 
@@ -1562,7 +1562,7 @@ static ssize_t flags_show(struct device *dev,
 	if (test_bit(NFIT_MEM_DIRTY, &nfit_mem->flags))
 		flags |= ACPI_NFIT_MEM_FLUSH_FAILED;
 
-	return sprintf(buf, "%s%s%s%s%s%s%s\n",
+	return sysfs_emit(buf, "%s%s%s%s%s%s%s\n",
 		flags & ACPI_NFIT_MEM_SAVE_FAILED ? "save_fail " : "",
 		flags & ACPI_NFIT_MEM_RESTORE_FAILED ? "restore_fail " : "",
 		flags & ACPI_NFIT_MEM_FLUSH_FAILED ? "flush_fail " : "",
@@ -1579,7 +1579,7 @@ static ssize_t id_show(struct device *dev,
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 
-	return sprintf(buf, "%s\n", nfit_mem->id);
+	return sysfs_emit(buf, "%s\n", nfit_mem->id);
 }
 static DEVICE_ATTR_RO(id);
 
@@ -1589,7 +1589,7 @@ static ssize_t dirty_shutdown_show(struct device *dev,
 	struct nvdimm *nvdimm = to_nvdimm(dev);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 
-	return sprintf(buf, "%d\n", nfit_mem->dirty_shutdown);
+	return sysfs_emit(buf, "%d\n", nfit_mem->dirty_shutdown);
 }
 static DEVICE_ATTR_RO(dirty_shutdown);
 
@@ -2172,7 +2172,7 @@ static ssize_t range_index_show(struct device *dev,
 	struct nd_region *nd_region = to_nd_region(dev);
 	struct nfit_spa *nfit_spa = nd_region_provider_data(nd_region);
 
-	return sprintf(buf, "%d\n", nfit_spa->spa->range_index);
+	return sysfs_emit(buf, "%d\n", nfit_spa->spa->range_index);
 }
 static DEVICE_ATTR_RO(range_index);
 


