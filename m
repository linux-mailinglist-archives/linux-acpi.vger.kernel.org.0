Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCB4704CE8
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbjEPLtI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjEPLs7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:48:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304D6E9B
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237703; x=1715773703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrB7/4kncfIBImWpl4e3Fx27E14xF2xq5M7od+acmrA=;
  b=m55FO5bfeolT83+GOW9M2zZZPCiZThUqeCSTw0NkzJT15u2wPuJjTp5q
   tiZFvnQrXbGmq8qstlkJTy08jc0I5nshz1pMxI7wx8Ed3mqtFVPnecZ1x
   gY+4BS8Vo1RMGSeC82bmsX5uNQ7fX1YMipCJZuXHEYPyXMi8OPebndUxJ
   DTkVV8zN8oyUJPMQzqr9yFLl+N5auPKjsTeu9gx1IEBzHGQJv5bwcz2kr
   bBf0DcDkOb4N/MWgXpQBU0d7h9ao/2ZJp1/aW/ZXOyMOEbMZvMgAABiMe
   PMsop6PWZSVj/zg8+B27kh77EO4zaKO1ld8xVrP9fsxlKfavYuNz2asHB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111664"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111664"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961838"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961838"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:55 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 17/34] platform/x86/asus-wireless: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:00 +0200
Message-Id: <20230516114617.148963-18-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230516114617.148963-1-michal.wilczynski@intel.com>
References: <20230516114617.148963-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

