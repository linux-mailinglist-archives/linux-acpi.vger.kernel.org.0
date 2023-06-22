Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B26D73ABB6
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jun 2023 23:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjFVVj4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Jun 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjFVVj4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Jun 2023 17:39:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555921FF9;
        Thu, 22 Jun 2023 14:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687469993; x=1719005993;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bY2gOLUmvznxH+TixmfijqEv/4Bid4wIyFOTxxQQmPc=;
  b=SGgN4aKzTzD6bX5UR+jzdIOl/QOj6iHqacFLTWx8lSLED67KVJLd9LYw
   YnGIhK3y0zh+Srz+BVSTr3m98pSYAT81641+LbaUEjOImdBvA7tAxvqhV
   iQjAkZA3s+gm+oqX0j92595ggjn5vWVbXcqltBdB1nfU8sEl8gF/uxjZM
   YhYNOwFriJZhmuQCUG4+Jpi6YGpxMAYirdcU2CbvU7QfD9xAlB/Pbnlbf
   vf4ysKrMnG7bFVrLyX5K9+GvMT0TPzjPNoKYzlBaaUbDVzCEWrPmFFpzV
   0Tn8a+9OwwwKULIq0pPGhoDrvOHmFogzOeWA8y9CjoqkSzXptzQMBrx2Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="345381352"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="345381352"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="715088952"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="715088952"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.53.238])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 14:39:52 -0700
Subject: [PATCH v4 4/6] acpi: Break out nesting for hmat_parse_locality()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 22 Jun 2023 14:39:51 -0700
Message-ID: <168746999176.4115467.17754893275430962012.stgit@djiang5-mobl3>
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

Refactor hmat_parse_locality() to break up the deep nesting of the
function.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 8380460cfee2..957a38137c7e 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -321,11 +321,28 @@ static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
 	}
 }
 
+static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_pxm,
+				      u8 mem_hier, u8 type, u32 value)
+{
+	struct memory_target *target = find_mem_target(tgt_pxm);
+
+	if (mem_hier != ACPI_HMAT_MEMORY)
+		return;
+
+	if (target && target->processor_pxm == init_pxm) {
+		hmat_update_target_access(target, type, value,
+					  NODE_ACCESS_CLASS_0);
+		/* If the node has a CPU, update access 1 */
+		if (node_state(pxm_to_node(init_pxm), N_CPU))
+			hmat_update_target_access(target, type, value,
+						  NODE_ACCESS_CLASS_1);
+	}
+}
+
 static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				      const unsigned long end)
 {
 	struct acpi_hmat_locality *hmat_loc = (void *)header;
-	struct memory_target *target;
 	unsigned int init, targ, total_size, ipds, tpds;
 	u32 *inits, *targs, value;
 	u16 *entries;
@@ -366,17 +383,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 				inits[init], targs[targ], value,
 				hmat_data_type_suffix(type));
 
-			if (mem_hier == ACPI_HMAT_MEMORY) {
-				target = find_mem_target(targs[targ]);
-				if (target && target->processor_pxm == inits[init]) {
-					hmat_update_target_access(target, type, value,
-								  NODE_ACCESS_CLASS_0);
-					/* If the node has a CPU, update access 1 */
-					if (node_state(pxm_to_node(inits[init]), N_CPU))
-						hmat_update_target_access(target, type, value,
-									  NODE_ACCESS_CLASS_1);
-				}
-			}
+			hmat_update_target(targs[targ], inits[init],
+					   mem_hier, type, value);
 		}
 	}
 


