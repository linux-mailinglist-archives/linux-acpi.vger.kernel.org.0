Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66206DB14E
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjDGRNi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjDGRNd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 13:13:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07416A57;
        Fri,  7 Apr 2023 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680887612; x=1712423612;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nb9cXS4op/kjmY5UIvlPea+yMzVt9eWRe9c+uNmvxck=;
  b=hdKeKpj6uf8ey4dMnHqcxvggZnDC8j14PLyDZzWRjdj5MKQ5zu63NZwO
   IzKi7Hdr5JYwCQuU4HiKr6RE9dhb4Vq7FIsLcIX5oi9Oj7t9XIrxr+bmn
   5EfF9/1Z7g7XifkSP1xU/vu8K0PyPJOKL1oejh9ixdIXfWDXOPe0fa3H7
   lYQFVFpWlV2p1pq9W2yBybeit5fRyjvNUG5nZDMgBj+hNRXp+2eDBIx1Y
   eQcUwzoEJwRAxYrjYGKTCLGts5PU32mmHp+SVdTFGUsJEvCDMlG1DREff
   2X+9r1bFXkiHERsaQUHHvFqhrXZ8biGfa2/zycCzy4SC3IQzbJbE2ktjE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="340519983"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="340519983"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="690119133"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="690119133"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.160.172])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 10:13:30 -0700
Subject: [PATCH 3 15/23] ACPI: NUMA: Add setting of generic port locality
 attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, lukas@wunner.de, Jonathan.Cameron@huawei.com
Date:   Fri, 07 Apr 2023 10:13:30 -0700
Message-ID: <168088761007.1441063.16227274190441918773.stgit@djiang5-mobl3>
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

Add generic port support for the parsing of HMAT locality sub-table. The
attributes will be added to the third array member of the hmem_attrs in
order to not mix with the existing memory attributes it only provides the
locality attributes from initator to the generic port targets and is
missing the rest of the data from the actual memory device.

The actual memory attributes will be updated when a memory device is
attached and the locality information is calculated end to end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5c53aa95d291..2596eb9eb419 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	ACCESS_NODE_MEM = 0,
 	ACCESS_NODE_CPU,
+	ACCESS_NODE_GENPORT,
 	ACCESS_NODE_MAX,
 };
 
@@ -367,6 +368,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
+					if (*(target->device_handle)) {
+						hmat_update_target_access(target, type, value,
+									  ACCESS_NODE_GENPORT);
+						continue;
+					}
+
 					hmat_update_target_access(target, type, value,
 								  ACCESS_NODE_MEM);
 					/* If the node has a CPU, update access 1 */


