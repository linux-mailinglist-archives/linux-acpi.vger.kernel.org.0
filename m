Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09B706206
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjEQH7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjEQH6n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC0DA
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310322; x=1715846322;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y0VBERQ5PR3nyeSq+O7hX0oeQ5wwm1bOcmrLZAB/n3I=;
  b=VwLv3sDRmRJndKJJl74fBhJOctNbjiDE/gVljblQEroeimYjAqAePHuc
   wKWWN/tIO65FG90Kp/gqcxxUL6YDW1S94zqWU3wMIJWKVAKaTc+AKAlGA
   pmc2O5lForxgDY62Lhv2owSclEUsiIq3j5HNC5L77j6342gnCM+21H/sF
   xLkEEt4hC/TgxQ1g1gugB2fpJzpjT2sYBjc5GIUUuQ3wb88f1yUgiu4Wi
   F6x+sbK8jQywq4/CA28qUWzI8dmNvFgy/mQoAu8mP1Uyckss2m7p/Q45w
   inJXVgRp/r5SSmIozBZVBQSn7cp3Revd3fgSySGcQaD3UsIJ4Qm/N7QFn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105501"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105501"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877532"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877532"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:41 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 30/34] platform/x86/xo15-ebook: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:20 +0200
Message-Id: <20230517075724.153992-31-michal.wilczynski@intel.com>
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
 drivers/platform/x86/xo15-ebook.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 391f7ea4431e..8b5b05429889 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -56,8 +56,9 @@ static int ebook_send_state(struct acpi_device *device)
 	return 0;
 }
 
-static void ebook_switch_notify(struct acpi_device *device, u32 event)
+static void ebook_switch_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	switch (event) {
 	case ACPI_FIXED_HARDWARE_EVENT:
 	case XO15_EBOOK_NOTIFY_STATUS:
@@ -134,7 +135,11 @@ static int ebook_switch_add(struct acpi_device *device)
 		device_set_wakeup_enable(&device->dev, true);
 	}
 
-	return 0;
+	error = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
+	if (error)
+		goto err_free_input;
+
+	return error;
 
  err_free_input:
 	input_free_device(input);
@@ -147,6 +152,7 @@ static void ebook_switch_remove(struct acpi_device *device)
 {
 	struct ebook_switch *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, ebook_switch_notify);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -158,7 +164,6 @@ static struct acpi_driver xo15_ebook_driver = {
 	.ops = {
 		.add = ebook_switch_add,
 		.remove = ebook_switch_remove,
-		.notify = ebook_switch_notify,
 	},
 	.drv.pm = &ebook_switch_pm,
 };
-- 
2.40.1

