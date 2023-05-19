Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726A3709C5F
	for <lists+linux-acpi@lfdr.de>; Fri, 19 May 2023 18:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjESQYv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 May 2023 12:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjESQYs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 19 May 2023 12:24:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC858F;
        Fri, 19 May 2023 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684513487; x=1716049487;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nOX1pXIcJVFKfYATZ1eoWbPglDzG33/gwY/u+oUeM0M=;
  b=GoX++jcztCU/C9VikiGqg9d0IXWyGgBvDVC39iPul8vLqR+rhZh/7UVI
   fQqXpTjFdzJI6NDm3ZL92c7LuJW6eyuCGiRnB1EfZEN42IjzPhjildRJE
   krEOKnnIpFaJfFUzrSTeXuMQCW3i5cRve8Pdd3dnjjkWqrtSr1UFrbI+Q
   klU+I5A8MUZnzPNipRYPhBBUtGEsnBcgKriMNx13TWAnvHDxEE8aNWTRe
   +sN1HNkWKL4EsLVldYsPTbbpd/12Ol7y3wgggNmfctvXs1b8FpIyxUis6
   RfXsnlqY8eXXkyJ3epgJaNrQ9s+KHGFl0xNu3L9KM9sk5MRrudQBC50rZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="415878707"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="415878707"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 09:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="949171295"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="949171295"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.29.189])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 09:24:39 -0700
Subject: [PATCH v2 3/4] acpi: numa: Add setting of generic port system
 locality attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 19 May 2023 09:24:38 -0700
Message-ID: <168451347867.3465146.10428399827479313906.stgit@djiang5-mobl3>
In-Reply-To: <168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3>
References: <168451341624.3465146.15355962690295941676.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It only
provides the system locality attributes from initator to the generic port
targets and is missing the rest of the data to the actual memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

v2:
- Fix commit log runon sentence. (Jonathan)
- Add a check for memory type for skipping other access levels. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
---
 drivers/acpi/numa/hmat.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index e2ab1cce0add..82320c92abed 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -368,6 +369,15 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
+					if (*target->device_handle) {
+						hmat_update_target_access(target, type, value,
+								NODE_ACCESS_CLASS_GENPORT_SINK);
+						if ((hmat_loc->flags &
+						     ACPI_HMAT_MEMORY_HIERARCHY) ==
+						    ACPI_HMAT_MEMORY)
+							continue;
+					}
+
 					hmat_update_target_access(target, type, value,
 								  NODE_ACCESS_CLASS_0);
 					/* If the node has a CPU, update access 1 */


