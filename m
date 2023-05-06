Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A246F8CFE
	for <lists+linux-acpi@lfdr.de>; Sat,  6 May 2023 02:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjEFAF0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 20:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjEFAFZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 20:05:25 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8705FD1;
        Fri,  5 May 2023 17:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683331523; x=1714867523;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZI2rwyxv02U6S6FCDM2uV1OUnQqBBN8LRYdyhFzxiXU=;
  b=GNoP0u/8LzP+zUIup38xKJmdM3GJpdY4k7UFYUJqghKr4aCPW6tfnWjZ
   l9lyXXcRvM871NGucemDsIO32nsOa7wxSr1SkyV0DBxYQpyUMDr164DlN
   bCjfNSJuH5PUdgERdyB26dxWn420T5n10LozoXFWYtY6+6p5n0DkXvwFw
   x/4YXTMn5XSH8KkUljoGJhEPeGJHCdZ1sA0fHkBCwZvg2dgnbOIMpqvyg
   h0w81CoiVgkFo1t5Yoa81tf4dTTr9j+6rORVs2d1ajdix3ji9SOUrmRjH
   48tUiiB/PdaTGKDoTme+RJ3vVdgIzSNpDQKCYevJlGWtcjGNJAfxd2eYa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338525741"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338525741"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841969325"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841969325"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:22 -0700
Subject: [PATCH 2/4] acpi: numa: Add genport target allocation to the HMAT
 parsing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 17:05:22 -0700
Message-ID: <168333152242.2290593.10366412793734184870.stgit@djiang5-mobl3>
In-Reply-To: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
References: <168333141100.2290593.16294670316057617744.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add SRAT parsing for the HMAT init in order to collect the device handle
from the Generic Port Affinity Structure. The devie handle will serve as
the key to search for target data.

Consoliate the common code with alloc_memory_target() in a helper function
alloc_target().

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   53 +++++++++++++++++++++++++++++++++++++++++++---
 include/acpi/actbl3.h    |    4 +++
 2 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index abed728bf09d..e2ab1cce0add 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -71,6 +71,7 @@ struct memory_target {
 	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
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
@@ -147,6 +147,19 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
 		INIT_LIST_HEAD(&target->caches);
 	}
 
+	return target;
+}
+
+static __init void alloc_memory_target(unsigned int mem_pxm,
+				       resource_size_t start,
+				       resource_size_t len)
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
@@ -157,6 +170,17 @@ static __init void alloc_memory_target(unsigned int mem_pxm,
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
@@ -498,6 +522,22 @@ static __init int srat_parse_mem_affinity(union acpi_subtable_headers *header,
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
@@ -848,6 +888,13 @@ static __init int hmat_init(void)
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
index 832c6464f063..ed293d041211 100644
--- a/include/acpi/actbl3.h
+++ b/include/acpi/actbl3.h
@@ -279,12 +279,14 @@ struct acpi_srat_gic_its_affinity {
  * 6: ACPI_SRAT_TYPE_GENERIC_PORT_AFFINITY
  */
 
+#define ACPI_SRAT_DEVICE_HANDLE_SIZE		16
+
 struct acpi_srat_generic_affinity {
 	struct acpi_subtable_header header;
 	u8 reserved;
 	u8 device_handle_type;
 	u32 proximity_domain;
-	u8 device_handle[16];
+	u8 device_handle[ACPI_SRAT_DEVICE_HANDLE_SIZE];
 	u32 flags;
 	u32 reserved1;
 };


