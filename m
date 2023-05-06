Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307B26F8CFF
	for <lists+linux-acpi@lfdr.de>; Sat,  6 May 2023 02:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjEFAFb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 20:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjEFAFa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 20:05:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4875FE4;
        Fri,  5 May 2023 17:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683331529; x=1714867529;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f8yFnFLsax1Ks7JXCfx3qmwpqgmKNMTcEQPgTkNYO1I=;
  b=cJKHig1Kbx36AiUInClVLCEaltSj2NTC5VRKD+brMkr7Dm0SYIooLxkV
   wK4l7GA7FUVD/YbmAXdvPm0g2pJTJ43YFofqbkrDce+M1Asi87ZYWXZYN
   KmoJWG54cGiYKVFKBiLYdzCMpEAKiXD0hYZJP+vJM6XnYjUOJKAtsoNNa
   CZPXMGdguAp75F134n6aDw3fNkIznZ6VUeXmuxojxMDIAmUBoHh9DSX6y
   HLW13Bjdshy3A4CtfPvmSYtglKfjI9NcZijISf9A/TN6Nf9/Ho6AKghQA
   GSCg78cOfrvuoei/YwF4qpQX8f7KLKMUcKrCnARmStwXEhQzLCVejL/BG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="338525770"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="338525770"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="841969330"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="841969330"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.77.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 17:05:28 -0700
Subject: [PATCH 3/4] acpi: numa: Add setting of generic port system locality
 attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Fri, 05 May 2023 17:05:28 -0700
Message-ID: <168333152832.2290593.17409054392013117865.stgit@djiang5-mobl3>
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

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes it only
provides the system locality attributes from initator to the generic port
targets and is missing the rest of the data to the actual memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index e2ab1cce0add..951579e903cf 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -368,6 +369,12 @@ static __init int hmat_parse_locality(union acpi_subtable_headers *header,
 			if (mem_hier == ACPI_HMAT_MEMORY) {
 				target = find_mem_target(targs[targ]);
 				if (target && target->processor_pxm == inits[init]) {
+					if (*target->device_handle) {
+						hmat_update_target_access(target, type, value,
+								NODE_ACCESS_CLASS_GENPORT);
+						continue;
+					}
+
 					hmat_update_target_access(target, type, value,
 								  NODE_ACCESS_CLASS_0);
 					/* If the node has a CPU, update access 1 */


