Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B9D719E89
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjFANoW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFANoV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:21 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83013E;
        Thu,  1 Jun 2023 06:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627060; x=1717163060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUrLdSuup874aht3aizw4YqD6Igyfos0v1Ki2V0RotQ=;
  b=ivyDkiUxKTLVwSC7sn3linnHQKyZrMhr9/qiNFxNzRaOz4DFQT8NI/2u
   P+pGgxnNpc+AnnHpvNP0hVL7sIGnhwOKxrUvzwaq4NU/XRJ6wPva/kqu2
   TYpHMbOtV6paO23FAVt/5u+oLOc6VCwMpGC4pMewKIMx50A9DcGB9I1my
   XtH85KnwiE9RUbkfhjHxK/HlCFwrnP4wcMlJbbrhaTbK5GtMZsogpXquI
   RVaQ7s7fBRNAtVFdYnP4cK8NdhP8kNTihx140i+x//UdZbKIZgInqudqy
   1YXhLOk2v59gPxiHFf1fR5ut50HBX3atp0+qODBx0qZKhLv0GQ6GBCHSr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067612"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067612"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601741"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601741"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:15 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 14/35] platform/surface/button: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:17 +0200
Message-Id: <20230601131739.300760-15-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230601131739.300760-3-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/platform/surface/surfacepro3_button.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 2755601f979c..fa5f1e4c4abc 100644
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
@@ -230,6 +233,12 @@ static int surface_button_add(struct acpi_device *device)
 	device_init_wakeup(&device->dev, true);
 	dev_info(&device->dev,
 			"%s [%s]\n", name, acpi_device_bid(device));
+
+	error = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						  surface_button_notify);
+	if (error)
+		goto err_free_input;
+
 	return 0;
 
  err_free_input:
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

