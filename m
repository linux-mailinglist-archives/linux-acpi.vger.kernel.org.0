Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463672163BF
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jul 2020 04:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgGGCPB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Jul 2020 22:15:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:43191 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgGGCPA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 6 Jul 2020 22:15:00 -0400
IronPort-SDR: ao2IcvZLKqW0dKQBir3MEnZxL1zfnpdsA2u4utpzsaonOFeQhKxT7NHtB1H6GymuXPpALN3xp8
 RiSCtiF1cjWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="147538400"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="147538400"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:15:00 -0700
IronPort-SDR: BH1mjJ/B/ZXJ/K236z/pNJE25AuuNZZWljJIPL/1jSnhHOWq0pKtnb4V351mAc4gDt0bxbZb4F
 06Vkq83pbWGg==
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="305492990"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 19:14:59 -0700
Subject: [PATCH v2 02/12] ACPI: NFIT: Move bus_dsm_mask out of generic
 nvdimm_bus_descriptor
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     vishal.l.verma@intel.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 06 Jul 2020 18:58:44 -0700
Message-ID: <159408712429.2385045.13491275997943890813.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

DSMs are strictly an ACPI mechanism, evict the bus_dsm_mask concept from
the generic 'struct nvdimm_bus_descriptor' object.

As a side effect the test facility ->bus_nfit_cmd_force_en is no longer
necessary. The test infrastructure can communicate that information
directly in ->bus_dsm_mask.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c         |    8 ++++----
 drivers/acpi/nfit/nfit.h         |    2 +-
 include/linux/libnvdimm.h        |    1 -
 tools/testing/nvdimm/test/nfit.c |   16 ++++++++--------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 1f72ce1a782b..9fdd655bdf0e 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -478,7 +478,7 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 
 		cmd_name = nvdimm_bus_cmd_name(cmd);
 		cmd_mask = nd_desc->cmd_mask;
-		dsm_mask = nd_desc->bus_dsm_mask;
+		dsm_mask = acpi_desc->bus_dsm_mask;
 		desc = nd_cmd_bus_desc(cmd);
 		guid = to_nfit_uuid(NFIT_DEV_BUS);
 		handle = adev->handle;
@@ -1238,8 +1238,9 @@ static ssize_t bus_dsm_mask_show(struct device *dev,
 {
 	struct nvdimm_bus *nvdimm_bus = to_nvdimm_bus(dev);
 	struct nvdimm_bus_descriptor *nd_desc = to_nd_desc(nvdimm_bus);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
-	return sprintf(buf, "%#lx\n", nd_desc->bus_dsm_mask);
+	return sprintf(buf, "%#lx\n", acpi_desc->bus_dsm_mask);
 }
 static struct device_attribute dev_attr_bus_dsm_mask =
 		__ATTR(dsm_mask, 0444, bus_dsm_mask_show, NULL);
@@ -2157,7 +2158,6 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 	int i;
 
 	nd_desc->cmd_mask = acpi_desc->bus_cmd_force_en;
-	nd_desc->bus_dsm_mask = acpi_desc->bus_nfit_cmd_force_en;
 	set_bit(ND_CMD_CALL, &nd_desc->cmd_mask);
 	set_bit(NVDIMM_BUS_FAMILY_NFIT, &nd_desc->bus_family_mask);
 
@@ -2180,7 +2180,7 @@ static void acpi_nfit_init_dsms(struct acpi_nfit_desc *acpi_desc)
 		(1 << NFIT_CMD_ARS_INJECT_GET);
 	for_each_set_bit(i, &dsm_mask, BITS_PER_LONG)
 		if (acpi_check_dsm(adev->handle, guid, 1, 1ULL << i))
-			set_bit(i, &nd_desc->bus_dsm_mask);
+			set_bit(i, &acpi_desc->bus_dsm_mask);
 }
 
 static ssize_t range_index_show(struct device *dev,
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 5c5e7ebba8dc..da097149d94d 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -237,7 +237,7 @@ struct acpi_nfit_desc {
 	unsigned long scrub_flags;
 	unsigned long dimm_cmd_force_en;
 	unsigned long bus_cmd_force_en;
-	unsigned long bus_nfit_cmd_force_en;
+	unsigned long bus_dsm_mask;
 	unsigned int platform_cap;
 	unsigned int scrub_tmo;
 	int (*blk_do_io)(struct nd_blk_region *ndbr, resource_size_t dpa,
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index bd39a2cf7972..ad9898ece7d3 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -76,7 +76,6 @@ typedef int (*ndctl_fn)(struct nvdimm_bus_descriptor *nd_desc,
 struct device_node;
 struct nvdimm_bus_descriptor {
 	const struct attribute_group **attr_groups;
-	unsigned long bus_dsm_mask;
 	unsigned long cmd_mask;
 	unsigned long dimm_family_mask;
 	unsigned long bus_family_mask;
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index a8ee5c4d41eb..a59174ba1d2a 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -2507,10 +2507,10 @@ static void nfit_test0_setup(struct nfit_test *t)
 	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_cmd_force_en);
 	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_cmd_force_en);
 	set_bit(ND_CMD_CALL, &acpi_desc->bus_cmd_force_en);
-	set_bit(NFIT_CMD_TRANSLATE_SPA, &acpi_desc->bus_nfit_cmd_force_en);
-	set_bit(NFIT_CMD_ARS_INJECT_SET, &acpi_desc->bus_nfit_cmd_force_en);
-	set_bit(NFIT_CMD_ARS_INJECT_CLEAR, &acpi_desc->bus_nfit_cmd_force_en);
-	set_bit(NFIT_CMD_ARS_INJECT_GET, &acpi_desc->bus_nfit_cmd_force_en);
+	set_bit(NFIT_CMD_TRANSLATE_SPA, &acpi_desc->bus_dsm_mask);
+	set_bit(NFIT_CMD_ARS_INJECT_SET, &acpi_desc->bus_dsm_mask);
+	set_bit(NFIT_CMD_ARS_INJECT_CLEAR, &acpi_desc->bus_dsm_mask);
+	set_bit(NFIT_CMD_ARS_INJECT_GET, &acpi_desc->bus_dsm_mask);
 	set_bit(ND_INTEL_FW_GET_INFO, &acpi_desc->dimm_cmd_force_en);
 	set_bit(ND_INTEL_FW_START_UPDATE, &acpi_desc->dimm_cmd_force_en);
 	set_bit(ND_INTEL_FW_SEND_DATA, &acpi_desc->dimm_cmd_force_en);
@@ -2731,11 +2731,11 @@ static int nfit_ctl_test(struct device *dev)
 			.module = THIS_MODULE,
 			.provider_name = "ACPI.NFIT",
 			.ndctl = acpi_nfit_ctl,
-			.bus_dsm_mask = 1UL << NFIT_CMD_TRANSLATE_SPA
-				| 1UL << NFIT_CMD_ARS_INJECT_SET
-				| 1UL << NFIT_CMD_ARS_INJECT_CLEAR
-				| 1UL << NFIT_CMD_ARS_INJECT_GET,
 		},
+		.bus_dsm_mask = 1UL << NFIT_CMD_TRANSLATE_SPA
+			| 1UL << NFIT_CMD_ARS_INJECT_SET
+			| 1UL << NFIT_CMD_ARS_INJECT_CLEAR
+			| 1UL << NFIT_CMD_ARS_INJECT_GET,
 		.dev = &adev->dev,
 	};
 

