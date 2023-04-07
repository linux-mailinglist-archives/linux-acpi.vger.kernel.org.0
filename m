Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE7B6DB14D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjDGRNe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDGRNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A599729F;
        Fri,  7 Apr 2023 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887612; x=1712423612;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pqvHrq3JTEcbP4F03/9y6x1mUWiES3JePROGlFjOIsk=;
  b=JoidxRhuv7yHsSwSrAyQt4c12okMhH0kD4C4g5kIAlV4dJyPgh6twpJt
   QtY6Maf/7grhe/tqYSrVSdt/a4XmgNPHuT8LqXSRTsSQjiOX+2em1r52m
   BFA3++oUznfZUR6RV0zOviBecqO8wgDh+BAiFcN/FB4ims8XAbcLV93wt
   NSelOBuMl4ECtGg3oNUV1HhRC6qk8qdy7Ougeqd1d73khO6Osu6JISOYr
   FXtZmvqGJF9chnAR5AHrHaXWluo6dysSdsf9RIx5gptkiVzLNK5EwQHD5
   F3sXXYQ0p82FNJksInIiAFKXZwbxA1IK3QxGVOqgFpWAygiCKiQeUagIa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340519973"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340519973"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690119130"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690119130"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:24 -0700
Subject: [PATCH 3 14/23] ACPI: NUMA: Add genport target allocation to the HMAT
 parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:24 -0700
Message-ID: <168088760432.1441063.8987031206713273633.stgit@djiang5-mobl3>
In-Reply-To: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
References: <168088732996.1441063.10107817505475386072.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add SRAT parsing for the HMAT init in order to collect the device handle
from the Generic Port Affinity Structure. The devie handle will serve as
the key to search for target data.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Refactored to share common code
---
 drivers/acpi/numa/hmat.c |   52 +++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/actbl3.h    |    2 ++
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 4ce56b6f42da..5c53aa95d291 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -71,6 +71,7 @@ struct memory_target {
 	struct node_hmem_attrs hmem_attrs[ACCESS_NODE_MAX];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
+	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	bool registered;
 };
 
@@ -125,8 +126,7 @@ static __init void alloc_memory_initiator(unsigned int cpu_pxm)
 	list_add_tail(&initiator->node, &initiators);
 }
 
-static __init void alloc_memory_target(unsigned int mem_pxm,
-		resource_size_t start, resource_size_t len)
+static __init struct memory_target *alloc_target(unsigned int mem_pxm)
 {
 	struct memory_target *target;
 
@@ -134,7 +134,7 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 	if (!target) {
 		target = kzalloc(sizeof(*target), GFP_KERNEL);
 		if (!target)
-			return;
+			return NULL;
 		target->memory_pxm = mem_pxm;
 		target->processor_pxm = PXM_INVAL;
 		target->memregions = (struct resource) {
@@ -147,6 +147,18 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 		INIT_LIST_HEAD(&target->caches);
 	}
 
+	return target;
+}
+
+static __init void alloc_memory_target(unsigned int mem_pxm,
+		resource_size_t start, resource_size_t len)
+{
+	struct memory_target *target;
+
+	target = alloc_target(mem_pxm);
+	if (!target)
+		return;
+
 	/*
 	 * There are potentially multiple ranges per PXM, so record each
 	 * in the per-target memregions resource tree.
@@ -157,6 +169,17 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 				start, start + len, mem_pxm);
 }
 
+static __init void alloc_genport_target(unsigned int mem_pxm, u8 *handle)
+{
+	struct memory_target *target;
+
+	target = alloc_target(mem_pxm);
+	if (!target)
+		return;
+
+	memcpy(target->device_handle, handle, ACPI_SRAT_DEVICE_HANDLE_SIZE);
+}
+
 static __init const char *hmat_data_type(u8 type)
 {
 	switch (type) {
@@ -498,6 +521,22 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
 	return 0;
 }
 
+static __init int srat_parse_genport_affinity(union acpi_subtable_headers *header,
+					      const unsigned long end)
+{
+	struct acpi_srat_generic_affinity *ga = (void *)header;
+
+	if (!ga)
+		return -EINVAL;
+
+	if (!(ga->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
+		return 0;
+
+	alloc_genport_target(ga->proximity_domain, (u8 *)ga->device_handle);
+
+	return 0;
+}
+
 static u32 hmat_initiator_perf(struct memory_target *target,
 			       struct memory_initiator *initiator,
 			       struct acpi_hmat_locality *hmat_loc)
@@ -848,6 +887,13 @@ static __init int hmat_init(void)
 				ACPI_SRAT_TYPE_MEMORY_AFFINITY,
 				srat_parse_mem_affinity, 0) < 0)
 		goto out_put;
+
+	if (acpi_table_parse_entries(ACPI_SIG_SRAT,
+				     sizeof(struct acpi_table_srat),
+				     ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY,
+				     srat_parse_genport_affinity, 0) < 0)
+		goto out_put;
+
 	acpi_put_table(tbl);
 
 	status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
diff --git a/include/acpi/actbl3.h b/include/acpi/actbl3.h
index 832c6464f063..0daf5a94f08a 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -289,6 +289,8 @@ struct acpi_srat_generic_affinity {
 	u32 reserved1;
 };
 
+#define ACPI_SRAT_DEVICE_HANDLE_SIZE		16
+
 /* Flags for struct acpi_srat_generic_affinity */
 
 #define ACPI_SRAT_GENERIC_AFFINITY_ENABLED     (1)	/* 00: Use affinity structure */


