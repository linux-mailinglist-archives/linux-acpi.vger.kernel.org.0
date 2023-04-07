Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0030A6DB14C
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjDGRNd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjDGRNc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:32 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFFF6A57;
        Fri,  7 Apr 2023 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887610; x=1712423610;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fQi+31r++DvDJmP4KQ6/yCYwz1hjnYjtCci1BBEzq/o=;
  b=hRz54xyDQJA+N8vXbolSMkjaUjcS5E/HtD/b6Lz99N2p2yHLKDrmk/1T
   7WBbuBvYD8AzsEtsKritA1lf8LAJ0r+TcvRkstBT9+lGD3U5FviQ877RP
   7h45XVQbjlWAmA0nkMCjOgtX36ID1m+XKvB9iOoApW/GqUXLkAgRsfUuN
   NcnZODkxgnuRiX6OJ8yfZC//uK9qu0XEYMBAcTDEzFeBMQa8mpVdIBZWt
   sINXdZdsgh4UIjjLBK5/isL9IPuW8IKbX6cp0vQYZSD21oWP61wSF2v5N
   TvwodaBYq3leDJfG2UeY8CUZCooh9NM4ElGB0Gy8juP6Sx/9bsDqJFFQS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340519948"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340519948"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690119074"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690119074"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:18 -0700
Subject: [PATCH 3 13/23] ACPI: NUMA: Create enum for memory_target hmem_attrs
 indexing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:14 -0700
Message-ID: <168088759491.1441063.12824154767581292588.stgit@djiang5-mobl3>
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

Create enums to provide named indexing for the hmem_attrs array. This is in
preparation for adding generic port support which will add a third member
in the array to keep the generic port attributes separate from the memory
attributes.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index bba268ecd802..4ce56b6f42da 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -57,12 +57,18 @@ struct target_cache {
 	struct node_cache_attrs cache_attrs;
 };
 
+enum {
+	ACCESS_NODE_MEM = 0,
+	ACCESS_NODE_CPU,
+	ACCESS_NODE_MAX,
+};
+
 struct memory_target {
 	struct list_head node;
 	unsigned int memory_pxm;
 	unsigned int processor_pxm;
 	struct resource memregions;
-	struct node_hmem_attrs hmem_attrs[2];
+	struct node_hmem_attrs hmem_attrs[ACCESS_NODE_MAX];
 	struct list_head caches;
 	struct node_cache_attrs cache_attrs;
 	bool registered;
@@ -338,10 +344,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
-					hmat_update_target_access(target, type, value, 0);
+					hmat_update_target_access(target, type, value,
+								  ACCESS_NODE_MEM);
 					/* If the node has a CPU, update access 1 */
 					if (node_state(pxm_to_node(inits[init]), N_CPU))
-						hmat_update_target_access(target, type, value, 1);
+						hmat_update_target_access(target, type, value,
+									  ACCESS_NODE_CPU);
 				}
 			}
 		}
@@ -600,10 +608,12 @@ static void hmat_register_target_initiators(struct memory_target *target)
 	 */
 	if (target->processor_pxm != PXM_INVAL) {
 		cpu_nid = pxm_to_node(target->processor_pxm);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							ACCESS_NODE_MEM);
 		access0done = true;
 		if (node_state(cpu_nid, N_CPU)) {
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								ACCESS_NODE_CPU);
 			return;
 		}
 	}
@@ -644,12 +654,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 			}
 			if (best)
 				hmat_update_target_access(target, loc->hmat_loc->data_type,
-							  best, 0);
+							  best, ACCESS_NODE_MEM);
 		}
 
 		for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 			cpu_nid = pxm_to_node(i);
-			register_memory_node_under_compute_node(mem_nid, cpu_nid, 0);
+			register_memory_node_under_compute_node(mem_nid, cpu_nid,
+								ACCESS_NODE_MEM);
 		}
 	}
 
@@ -681,11 +692,13 @@ static void hmat_register_target_initiators(struct memory_target *target)
 				clear_bit(initiator->processor_pxm, p_nodes);
 		}
 		if (best)
-			hmat_update_target_access(target, loc->hmat_loc->data_type, best, 1);
+			hmat_update_target_access(target, loc->hmat_loc->data_type, best,
+						  ACCESS_NODE_CPU);
 	}
 	for_each_set_bit(i, p_nodes, MAX_NUMNODES) {
 		cpu_nid = pxm_to_node(i);
-		register_memory_node_under_compute_node(mem_nid, cpu_nid, 1);
+		register_memory_node_under_compute_node(mem_nid, cpu_nid,
+							ACCESS_NODE_CPU);
 	}
 }
 
@@ -746,8 +759,8 @@ static void hmat_register_target(struct memory_target *target)
 	if (!target->registered) {
 		hmat_register_target_initiators(target);
 		hmat_register_target_cache(target);
-		hmat_register_target_perf(target, 0);
-		hmat_register_target_perf(target, 1);
+		hmat_register_target_perf(target, ACCESS_NODE_MEM);
+		hmat_register_target_perf(target, ACCESS_NODE_CPU);
 		target->registered = true;
 	}
 	mutex_unlock(&target_lock);


