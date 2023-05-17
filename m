Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41B57061FB
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjEQH7K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjEQH6d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995004688
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310311; x=1715846311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rn1uDd4gyK5UYsik2MDAAYaqEAd+GMo475+hR8KSwqY=;
  b=LYVyt1+xo8ApdN74s27+2EW0qZ5sJi4mi0rx1UsGbGwK0sPDt+6xACLT
   V1b86GUXE0m/8ShQ5LOT2AkXD3CfTJguprG1wsW8zwEQ+UcR1YQTF52xC
   CMCeTyVLHNfiBXwMyFLwBLLZ66FLiu2th+EZiJWFnU06EyodpbOT+O4yE
   PBGkduuj8PNgsvtvpUezgMkiTEq3Fn4MulbBVrtSCgH5U/SYJlnyR3Fst
   Pkol/0vYRRUna+d4K54xNvbPwK6wqBEnXZAphgZsS/V5u28Fxe0SXtPt1
   kYeWtf8z3C4EfTJVocOoAbz6+3xmxmcfLMzX3X3W50U3Wd17arz0RYGpf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105453"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105453"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877425"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877425"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:25 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 19/34] platform/x86/dell/dell-rbtn: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:09 +0200
Message-Id: <20230517075724.153992-20-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230517075724.153992-1-michal.wilczynski@intel.com>
References: <20230517075724.153992-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Currently logic for installing notifications from ACPI devices is
implemented using notify callback in struct acpi_driver. Preparations
are being made to replace acpi_driver with more generic struct
platform_driver, which doesn't contain notify callback. Furthermore
as of now handlers are being called indirectly through
acpi_notify_device(), which decreases performance.

Call acpi_device_install_event_handler() at the end of .add() callback.
Call acpi_device_remove_event_handler() at the beginning of .remove()
callback. Change arguments passed to the notify callback to match with
what's required by acpi_device_install_event_handler().

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/platform/x86/dell/dell-rbtn.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-rbtn.c b/drivers/platform/x86/dell/dell-rbtn.c
index aa0e6c907494..679ff2d6adbf 100644
--- a/drivers/platform/x86/dell/dell-rbtn.c
+++ b/drivers/platform/x86/dell/dell-rbtn.c
@@ -293,7 +293,6 @@ static struct acpi_driver rbtn_driver = {
 	.ops = {
 		.add = rbtn_add,
 		.remove = rbtn_remove,
-		.notify = rbtn_notify,
 	},
 	.owner = THIS_MODULE,
 };
@@ -422,7 +421,10 @@ static int rbtn_add(struct acpi_device *device)
 		ret = -EINVAL;
 	}
 
-	return ret;
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
 
 }
 
@@ -430,6 +432,8 @@ static void rbtn_remove(struct acpi_device *device)
 {
 	struct rbtn_data *rbtn_data = device->driver_data;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, rbtn_notify);
+
 	switch (rbtn_data->type) {
 	case RBTN_TOGGLE:
 		rbtn_input_exit(rbtn_data);
@@ -445,9 +449,12 @@ static void rbtn_remove(struct acpi_device *device)
 	device->driver_data = NULL;
 }
 
-static void rbtn_notify(struct acpi_device *device, u32 event)
+static void rbtn_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct rbtn_data *rbtn_data = device->driver_data;
+	struct acpi_device *device = data;
+	struct rbtn_data *rbtn_data;
+
+	rbtn_data = device->driver_data;
 
 	/*
 	 * Some BIOSes send a notification at resume.
-- 
2.40.1

