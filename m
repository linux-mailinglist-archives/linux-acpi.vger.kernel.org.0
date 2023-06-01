Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F347719E99
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjFANpA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234110AbjFANo5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:57 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A3B107;
        Thu,  1 Jun 2023 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627095; x=1717163095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrB7/4kncfIBImWpl4e3Fx27E14xF2xq5M7od+acmrA=;
  b=lqT2R7cND7IrYvGV+4wPpkRESYDmlJ1IupDwq4TQrbAtnTmk1cvFg7hN
   rm/O1zRxb0W1jgjWkCOI6XFEkiaAYjwcUgAp6O+4X0lc3d36L7gimCJFo
   VEVxFwXBJWj5+i9PigQ26Dhc80sC6QlUdFtNmiAwMTX5g7YbVlYrq8a/X
   P6GNfMhNolIEW8EhQG5ngdJQEr6sSWoulkB9YgkJHtOvVi7DFrKCUtvJT
   jpPQ2g6ykWoB06PEG+OZvpLIx4pXsL2iRRU9q+DTCg5UQeafgzvJH8z7w
   +mOvWS4dCkBAtONRNzxbrDFyE4L0RPNcNry47qZY0wHX60D6n+QOwoSQn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067942"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067942"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601848"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601848"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:30 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 17/35] platform/x86/asus-wireless: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:20 +0200
Message-Id: <20230601131739.300760-18-michal.wilczynski@intel.com>
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
 drivers/platform/x86/asus-wireless.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index abf01e00b799..6544e3419ae4 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -108,19 +108,22 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
 	queue_work(data->wq, &data->led_work);
 }
 
-static void asus_wireless_notify(struct acpi_device *adev, u32 event)
+static void asus_wireless_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct asus_wireless_data *data = acpi_driver_data(adev);
+	struct asus_wireless_data *w_data;
+	struct acpi_device *adev = data;
+
+	w_data = acpi_driver_data(adev);
 
 	dev_dbg(&adev->dev, "event=%#x\n", event);
 	if (event != 0x88) {
 		dev_notice(&adev->dev, "Unknown ASHS event: %#x\n", event);
 		return;
 	}
-	input_report_key(data->idev, KEY_RFKILL, 1);
-	input_sync(data->idev);
-	input_report_key(data->idev, KEY_RFKILL, 0);
-	input_sync(data->idev);
+	input_report_key(w_data->idev, KEY_RFKILL, 1);
+	input_sync(w_data->idev);
+	input_report_key(w_data->idev, KEY_RFKILL, 0);
+	input_sync(w_data->idev);
 }
 
 static int asus_wireless_add(struct acpi_device *adev)
@@ -169,16 +172,20 @@ static int asus_wireless_add(struct acpi_device *adev)
 	data->led.max_brightness = 1;
 	data->led.default_trigger = "rfkill-none";
 	err = devm_led_classdev_register(&adev->dev, &data->led);
-	if (err)
+	if (err) {
 		destroy_workqueue(data->wq);
+		return err;
+	}
 
-	return err;
+	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, asus_wireless_notify);
 }
 
 static void asus_wireless_remove(struct acpi_device *adev)
 {
 	struct asus_wireless_data *data = acpi_driver_data(adev);
 
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, asus_wireless_notify);
+
 	if (data->wq) {
 		devm_led_classdev_unregister(&adev->dev, &data->led);
 		destroy_workqueue(data->wq);
@@ -192,7 +199,6 @@ static struct acpi_driver asus_wireless_driver = {
 	.ops = {
 		.add = asus_wireless_add,
 		.remove = asus_wireless_remove,
-		.notify = asus_wireless_notify,
 	},
 };
 module_acpi_driver(asus_wireless_driver);
-- 
2.40.1

