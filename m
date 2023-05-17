Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9547061F6
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbjEQH7F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjEQH6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C7A448C
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310310; x=1715846310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sUDWyX/uI73hT1c0+d8t2xHxeHNXiv2b+eO60dyWbj0=;
  b=YC6YPh3+BiJoKOyzYjmNzkTu6UJNHPAkhicgkCVCarL5RiLwpIMrMDwN
   5LD/As6rwPmoy3gjGAudcXfU3qrT3wgd2+B/a5Sal2BCZEo3Dr+xuaejf
   V72uOuI3tND/6OgT2QsjMfF3RiyXftgHR59LfJQlRc37OKYGmyQQv7g1Q
   b35rbhYrKayGtw7MgVy+FlHdpyFBSMi7B1awWMBe4P01ygfz2uTu22Pf1
   Z8+PdMK3RYgTOGi9asGut3Qyh2cZniDjh20/KyfZ4YQpJ/GO142gBhNrB
   jJ7cirgd59kr/0avFoqpcE++A6jL72A72of1TaKdV7TjUnNo66/FEp3js
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105419"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105419"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877387"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877387"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:17 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 14/34] platform/surface/button: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:04 +0200
Message-Id: <20230517075724.153992-15-michal.wilczynski@intel.com>
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
 drivers/platform/surface/surfacepro3_button.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 2755601f979c..a6892242f747 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -71,13 +71,16 @@ struct surface_button {
 	bool suspended;
 };
 
-static void surface_button_notify(struct acpi_device *device, u32 event)
+static void surface_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct surface_button *button = acpi_driver_data(device);
-	struct input_dev *input;
+	struct acpi_device *device = data;
+	struct surface_button *button;
 	int key_code = KEY_RESERVED;
+	struct input_dev *input;
 	bool pressed = false;
 
+	button = acpi_driver_data(device);
+
 	switch (event) {
 	/* Power button press,release handle */
 	case SURFACE_BUTTON_NOTIFY_PRESS_POWER:
@@ -230,7 +233,13 @@ static int surface_button_add(struct acpi_device *device)
 	device_init_wakeup(&device->dev, true);
 	dev_info(&device->dev,
 			"%s [%s]\n", name, acpi_device_bid(device));
-	return 0;
+
+	error = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						  surface_button_notify);
+	if (error)
+		goto err_free_input;
+
+	return error;
 
  err_free_input:
 	input_free_device(input);
@@ -243,6 +252,7 @@ static void surface_button_remove(struct acpi_device *device)
 {
 	struct surface_button *button = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, surface_button_notify);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -257,7 +267,6 @@ static struct acpi_driver surface_button_driver = {
 	.ops = {
 		.add = surface_button_add,
 		.remove = surface_button_remove,
-		.notify = surface_button_notify,
 	},
 	.drv.pm = &surface_button_pm,
 };
-- 
2.40.1

