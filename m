Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E469D73219A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjFOVYN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbjFOVYL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:24:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA225296A;
        Thu, 15 Jun 2023 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864249; x=1718400249;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ecGVOs5G6lZVffQca67Oow2gDWwuCnZPay6VD5VG5Pw=;
  b=ja5qKA643ZliA9/oGNCWdtfBJD305WPlDpjlmxOFubQltAb9v7Pg/bvc
   c5XBZpeDfG3BmBSKxFTkJATWUK32vo9sjuDvIeTkj/iUdFlXvbgOMUc3Z
   c4CbJCu794EPr6HkhuR5OjLEH2R+0wBUTekaAU/k4fOi8jVK7Uw90zs/A
   cfiUy46CE0z9pyy1eO+yRyI+KB7Cx0rKVt4DCe+3klF+c5OXWUQJw97ue
   foFk/dZhS9qKiKUTgwtQLaOw+E2xaLP1suVzhBqCSV8PxkMsa8oquGZTV
   GEs5dC4UV3GSyFf5gB0oOBM4I2+QJ36c1yIwo9Z2YXW0i7GANWj91EDl+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424975474"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424975474"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="825457992"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="825457992"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:08 -0700
Subject: [PATCH v3 4/6] acpi: Break out nesting for hmat_parse_locality()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>, rafael@kernel.org,
        lenb@kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:24:07 -0700
Message-ID: <168686424781.2950427.15323220900348586144.stgit@djiang5-mobl3>
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

Refactor hmat_parse_locality() to break up the deep nesting of the
function.

Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |   32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index e2ab1cce0add..cb240f5233fe 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -320,11 +320,28 @@ static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
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
@@ -365,17 +382,8 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
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
 


