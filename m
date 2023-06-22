Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792373ABB3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFVVjg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFVVjf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:39:35 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96F21FED;
        Thu, 22 Jun 2023 14:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687469974; x=1719005974;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5RkrpnEslnIHArEq4KtW+ePeGuapp92/gzx81tLhXAU=;
  b=iITmdlEmdSxF7D7vgNf4lMjOk/H+y6foZKBmxqEg7jbszBx2B9slwUTO
   JrRzH83Br+0XiRm9O0AKHWzihgdaV9papBBKrh0S5Poe+v49aIXQJm3tJ
   Pj57btn4bkQyjCZ8ptzHDnyFnr0eOs0O6Q+nq8goF6YvpLT6UnMwJPVzO
   LHoTtFQFXLstR0pHKq7E902O8zO3OGYE/XTXoZDUZC/IyRLQs5GmQ+Zg8
   w8Pini/Vvdf4smVifBPRpw5v34gmgI4oPl+WlX63zhZdsdGBN907h3MIg
   2tS9d5gh261vfz7J/oesqT8xETia81Kpma/B+eStG7a0BfLFN0glsdGF5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345381219"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="345381219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715088854"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715088854"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:33 -0700
Subject: [PATCH v4 1/6] acpi: numa: Create enum for memory_target access
 coordinates indexing
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:39:32 -0700
Message-ID: <168746997272.4115467.12889336174992481226.stgit@djiang5-mobl3>
In-Reply-To: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
References: <168746993412.4115467.1442857478644914777.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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


