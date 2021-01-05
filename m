Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4002EB495
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Jan 2021 22:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbhAEVEH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 Jan 2021 16:04:07 -0500
Received: from mga17.intel.com ([192.55.52.151]:64592 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbhAEVEG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 Jan 2021 16:04:06 -0500
IronPort-SDR: rl9g/hLKnBOsatBpGbmdhTLPMC23qTH+KNR6AJPE0S1QolN4pMzwLG6DaFu6z2mZ+7ruR2ZSPB
 OVtM9PPa7NHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="156962453"
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="156962453"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 13:03:19 -0800
IronPort-SDR: HHvqg5rKiAvOOaGoYZGhk2rMNMXg0bn2ujWBoVnr7oh+QygsjX/ukrYvlmpXEKcZDYGvew7qMV
 FI1B+ANkrRtQ==
X-IronPort-AV: E=Sophos;i="5.78,478,1599548400"; 
   d="scan'208";a="496917642"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 13:03:18 -0800
Subject: [PATCH] ACPI: NFIT: Fix flexible_array.cocci warnings
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-nvdimm@lists.01.org
Cc:     Denis Efremov <efremov@linux.com>,
        kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 05 Jan 2021 13:03:18 -0800
Message-ID: <160988059854.2071197.11821323682102566548.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Julia and 0day report:

    Zero-length and one-element arrays are deprecated, see
    Documentation/process/deprecated.rst
    Flexible-array members should be used instead.

However, a straight conversion to flexible arrays yields:

    drivers/acpi/nfit/core.c:2276:4: error: flexible array member in a struct with no named members
    drivers/acpi/nfit/core.c:2287:4: error: flexible array member in a struct with no named members

Instead, just use plain arrays not embedded a flexible arrays.

Cc: Denis Efremov <efremov@linux.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/acpi/nfit/core.c |   75 +++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index b11b08a60684..8c5dde628405 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -2269,40 +2269,24 @@ static const struct attribute_group *acpi_nfit_region_attribute_groups[] = {
 
 /* enough info to uniquely specify an interleave set */
 struct nfit_set_info {
-	struct nfit_set_info_map {
-		u64 region_offset;
-		u32 serial_number;
-		u32 pad;
-	} mapping[0];
+	u64 region_offset;
+	u32 serial_number;
+	u32 pad;
 };
 
 struct nfit_set_info2 {
-	struct nfit_set_info_map2 {
-		u64 region_offset;
-		u32 serial_number;
-		u16 vendor_id;
-		u16 manufacturing_date;
-		u8  manufacturing_location;
-		u8  reserved[31];
-	} mapping[0];
+	u64 region_offset;
+	u32 serial_number;
+	u16 vendor_id;
+	u16 manufacturing_date;
+	u8 manufacturing_location;
+	u8 reserved[31];
 };
 
-static size_t sizeof_nfit_set_info(int num_mappings)
-{
-	return sizeof(struct nfit_set_info)
-		+ num_mappings * sizeof(struct nfit_set_info_map);
-}
-
-static size_t sizeof_nfit_set_info2(int num_mappings)
-{
-	return sizeof(struct nfit_set_info2)
-		+ num_mappings * sizeof(struct nfit_set_info_map2);
-}
-
 static int cmp_map_compat(const void *m0, const void *m1)
 {
-	const struct nfit_set_info_map *map0 = m0;
-	const struct nfit_set_info_map *map1 = m1;
+	const struct nfit_set_info *map0 = m0;
+	const struct nfit_set_info *map1 = m1;
 
 	return memcmp(&map0->region_offset, &map1->region_offset,
 			sizeof(u64));
@@ -2310,8 +2294,8 @@ static int cmp_map_compat(const void *m0, const void *m1)
 
 static int cmp_map(const void *m0, const void *m1)
 {
-	const struct nfit_set_info_map *map0 = m0;
-	const struct nfit_set_info_map *map1 = m1;
+	const struct nfit_set_info *map0 = m0;
+	const struct nfit_set_info *map1 = m1;
 
 	if (map0->region_offset < map1->region_offset)
 		return -1;
@@ -2322,8 +2306,8 @@ static int cmp_map(const void *m0, const void *m1)
 
 static int cmp_map2(const void *m0, const void *m1)
 {
-	const struct nfit_set_info_map2 *map0 = m0;
-	const struct nfit_set_info_map2 *map1 = m1;
+	const struct nfit_set_info2 *map0 = m0;
+	const struct nfit_set_info2 *map1 = m1;
 
 	if (map0->region_offset < map1->region_offset)
 		return -1;
@@ -2361,22 +2345,22 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 		return -ENOMEM;
 	import_guid(&nd_set->type_guid, spa->range_guid);
 
-	info = devm_kzalloc(dev, sizeof_nfit_set_info(nr), GFP_KERNEL);
+	info = devm_kcalloc(dev, nr, sizeof(*info), GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
 
-	info2 = devm_kzalloc(dev, sizeof_nfit_set_info2(nr), GFP_KERNEL);
+	info2 = devm_kcalloc(dev, nr, sizeof(*info2), GFP_KERNEL);
 	if (!info2)
 		return -ENOMEM;
 
 	for (i = 0; i < nr; i++) {
 		struct nd_mapping_desc *mapping = &ndr_desc->mapping[i];
-		struct nfit_set_info_map *map = &info->mapping[i];
-		struct nfit_set_info_map2 *map2 = &info2->mapping[i];
 		struct nvdimm *nvdimm = mapping->nvdimm;
 		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
-		struct acpi_nfit_memory_map *memdev = memdev_from_spa(acpi_desc,
-				spa->range_index, i);
+		struct nfit_set_info *map = &info[i];
+		struct nfit_set_info2 *map2 = &info2[i];
+		struct acpi_nfit_memory_map *memdev =
+			memdev_from_spa(acpi_desc, spa->range_index, i);
 		struct acpi_nfit_control_region *dcr = nfit_mem->dcr;
 
 		if (!memdev || !nfit_mem->dcr) {
@@ -2395,23 +2379,20 @@ static int acpi_nfit_init_interleave_set(struct acpi_nfit_desc *acpi_desc,
 	}
 
 	/* v1.1 namespaces */
-	sort(&info->mapping[0], nr, sizeof(struct nfit_set_info_map),
-			cmp_map, NULL);
-	nd_set->cookie1 = nd_fletcher64(info, sizeof_nfit_set_info(nr), 0);
+	sort(info, nr, sizeof(*info), cmp_map, NULL);
+	nd_set->cookie1 = nd_fletcher64(info, sizeof(*info) * nr, 0);
 
 	/* v1.2 namespaces */
-	sort(&info2->mapping[0], nr, sizeof(struct nfit_set_info_map2),
-			cmp_map2, NULL);
-	nd_set->cookie2 = nd_fletcher64(info2, sizeof_nfit_set_info2(nr), 0);
+	sort(info2, nr, sizeof(*info2), cmp_map2, NULL);
+	nd_set->cookie2 = nd_fletcher64(info2, sizeof(*info2) * nr, 0);
 
 	/* support v1.1 namespaces created with the wrong sort order */
-	sort(&info->mapping[0], nr, sizeof(struct nfit_set_info_map),
-			cmp_map_compat, NULL);
-	nd_set->altcookie = nd_fletcher64(info, sizeof_nfit_set_info(nr), 0);
+	sort(info, nr, sizeof(*info), cmp_map_compat, NULL);
+	nd_set->altcookie = nd_fletcher64(info, sizeof(*info) * nr, 0);
 
 	/* record the result of the sort for the mapping position */
 	for (i = 0; i < nr; i++) {
-		struct nfit_set_info_map2 *map2 = &info2->mapping[i];
+		struct nfit_set_info2 *map2 = &info2[i];
 		int j;
 
 		for (j = 0; j < nr; j++) {

