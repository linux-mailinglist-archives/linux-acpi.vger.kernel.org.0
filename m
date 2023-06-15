Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70245732197
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjFOVXx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjFOVXw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:23:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC042962;
        Thu, 15 Jun 2023 14:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864231; x=1718400231;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RkrpnEslnIHArEq4KtW+ePeGuapp92/gzx81tLhXAU=;
  b=A+2lI++80SYUqmcljSNz5QRmJ0pt8VGB8EwUcXQm40rTvjdCyUb+7w4O
   9umVlnerfP5kz0LBbefYXGYHF75gZANxjLtti5sjZWdaqbYYOaPwplYrB
   vP2LlD6Eq9hk7GBHeXR/+GlK/14iK8n1vfCI6x+Fw07Bu5qFixhTlNFz1
   tUGDMXOwARM0x87sdpEi3d2QzQVTuC10cp6dB4NerlgCPuWGB6hsyuSX1
   ++RHyLhsjXgx6jPAvCJBD5XvoWuWLlmwPPCSTlyvDKKKVXNrDLrWiG4UA
   HugiOFsdp4Y11U+ctRHz8NpNQxZJqh63oJbZU79zLj7uUZsrrIlgwOHNU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424975401"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424975401"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825457848"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825457848"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:23:50 -0700
Subject: [PATCH v3 1/6] acpi: numa: Create enum for memory_target access
 coordinates indexing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:23:49 -0700
Message-ID: <168686422990.2950427.9266943892591920987.stgit@djiang5-mobl3>
In-Reply-To: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
References: <168686408822.2950427.16242077816997472103.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Create enums to provide named indexing for the access coordinate array.
This is in preparation for adding generic port support which will add a
third index in the array to keep the generic port attributes separate from
the memory attributes.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index f9ff992038fa..abed728bf09d 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -57,12 +57,18 @@ struct target_cache {
 	struct node_cache_attrs cache_attrs;
 };
 
+enum {
+	NODE_ACCESS_CLASS_0 = 0,
+	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_MAX,
+};
+
 struct memory_target {
 	struct list_head node;
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct access_coordinate coord[2];
+	struct access_coordinate coord[NODE_ACCESS_CLASS_MAX];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -338,10 +344,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
-					hmat_update_target_access(target, type, value, 0);
+					hmat_update_target_access(target, type, value,
+								  NODE_ACCESS_CLASS_0);
 					/* If the node has a CPU, update access 1 */
 					if (node_state(pxm_to_node(inits[init]), N_CPU))
-						hmat_update_target_access(target, type, value, 1);
+						hmat_update_target_access(target, type, value,
+									  NODE_ACCESS_CLASS_1);
 				}
 			}
 		}
@@ -600,10 +608,12 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							NODE_ACCESS_CLASS_0);
 		access0done = true;
 		if (node_state(cpu_nid, N_CPU)) {
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								NODE_ACCESS_CLASS_1);
 			return;
 		}
 	}
@@ -644,12 +654,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 			}
 			if (best)
 				hmat_update_target_access(target, loc->hmat_loc->data_type,
-							  best, 0);
+							  best, NODE_ACCESS_CLASS_0);
 		}
 
 		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 			cpu_nid = pxm_to_node(i);
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								NODE_ACCESS_CLASS_0);
 		}
 	}
 
@@ -681,11 +692,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
+			hmat_update_target_access(target, loc->hmat_loc->data_type, best,
+						  NODE_ACCESS_CLASS_1);
 	}
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 		cpu_nid = pxm_to_node(i);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							NODE_ACCESS_CLASS_1);
 	}
 }
 
@@ -746,8 +759,8 @@ static void hmat_register_target(struct memory_target *target)
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
-		hmat_register_target_perf(target, 0);
-		hmat_register_target_perf(target, 1);
+		hmat_register_target_perf(target, NODE_ACCESS_CLASS_0);
+		hmat_register_target_perf(target, NODE_ACCESS_CLASS_1);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);


