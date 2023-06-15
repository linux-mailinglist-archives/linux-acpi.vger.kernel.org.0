Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B43D73219B
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jun 2023 23:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjFOVYT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jun 2023 17:24:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236328AbjFOVYR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jun 2023 17:24:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E832962;
        Thu, 15 Jun 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864256; x=1718400256;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q4ziEryFgyJR9cosgZsCGy/yodFJHsc4BKpTkEQZwQc=;
  b=FtpBetF0sHPiLtA3MZ0k+Fv/1Jci5ZBknHlGjHFj60KIkZnhgwKlGy/4
   5Q2jewXkLgHxQuUPFB26k71ov4sCQGLTWw6HtIV8oDDYevJ6osMXtiFEs
   nUh0u48YwlytrSPFkjuWv2YOb5ewf9atawk7IxEL9aaaFkynscBL2ilYq
   2AufxgMvqELGwbH3dpxyEXpkiIglYr57D+WI2jBjbbfRowyeW5/yE8ITe
   I9HJ6YNAzR9lkTxK+E0foD+WgUB/8GVL70eopWNjz7Chpy/ejgGWHmrNd
   1eXB7SK0xWv/5cVlXfSZxxfZRH5tCFqoJaUdIrgUvRLRzn6ACr3rD4iir
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339385825"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339385825"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689962071"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689962071"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.110.129])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:24:14 -0700
Subject: [PATCH v3 5/6] acpi: numa: Add setting of generic port system
 locality attributes
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, lukas@wunner.de,
        Jonathan.Cameron@huawei.com
Date:   Thu, 15 Jun 2023 14:24:13 -0700
Message-ID: <168686425375.2950427.10184250250033053574.stgit@djiang5-mobl3>
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

Add generic port support for the parsing of HMAT system locality sub-table.
The attributes will be added to the third array member of the access
coordinates in order to not mix with the existing memory attributes. It only
provides the system locality attributes from initator to the generic port
targets and is missing the rest of the data to the actual memory device.

The complete attributes will be updated when a memory device is
attached and the system locality information is calculated end to end.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v3:
- Drop continue after setting gen target access data. (Jonathan)
v2:
- Fix commit log runon sentence. (Jonathan)
- Add a check for memory type for skipping other access levels. (Jonathan)
- NODE_ACCESS_CLASS_GENPORT to NODE_ACCESS_CLASS_GENPORT_SINK. (Jonathan)
---
 drivers/acpi/numa/hmat.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index cb240f5233fe..32b951cd5ee4 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -60,6 +60,7 @@ struct target_cache {
 enum {
 	NODE_ACCESS_CLASS_0 = 0,
 	NODE_ACCESS_CLASS_1,
+	NODE_ACCESS_CLASS_GENPORT_SINK,
 	NODE_ACCESS_CLASS_MAX,
 };
 
@@ -329,6 +330,9 @@ static __init void hmat_update_target(unsigned int tgt_pxm, unsigned int init_px
 		return;
 
 	if (target && target->processor_pxm == init_pxm) {
+		if (*target->device_handle)
+			hmat_update_target_access(target, type, value,
+						  NODE_ACCESS_CLASS_GENPORT_SINK);
 		hmat_update_target_access(target, type, value,
 					  NODE_ACCESS_CLASS_0);
 		/* If the node has a CPU, update access 1 */


