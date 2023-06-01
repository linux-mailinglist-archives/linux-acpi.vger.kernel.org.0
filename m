Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5643A719E8B
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjFANof (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFANoe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB4139;
        Thu,  1 Jun 2023 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627074; x=1717163074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ou2d7WNU5iGtvXSJSbVni3WkhDwCgDRi6B+45IXWcX4=;
  b=BB977zxOP3D7L6t+mqXOOZIx6I4MOkTwGG65M8yaL84E7wOUjtSfiBo2
   nCEtpbV9GCSF0LePZeUZyS5vj2O6OKB3JZj2B+Ylmnf4flol1BSymd/WE
   eEj3iKCZvE/9+6C7mf53fiROHgcR7d7/PwSm+xthbzRkYmkNwJ4LpJoI3
   VwWXIBfQ6lEYPHmq6amdckbGDp7L5qbgrOThaVFTOoSBcScNOWl0569mi
   aLRe7HiavbaivgwCAGmD03yCm/6Q0pR4TwrcIEFMH0FCG2ZTFH0P9QDLX
   TPVXR+T8WXWNdfNKWHd+6DOpEEg1iGGBHfc50GZBaT9WkMjk48up0ubbG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067737"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067737"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601793"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601793"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:21 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 15/35] platform/x86/acer-wireless: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:18 +0200
Message-Id: <20230601131739.300760-16-michal.wilczynski@intel.com>
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
 drivers/platform/x86/acer-wireless.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index 1b5d935d085a..af7aef27cdff 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -18,9 +18,12 @@ static const struct acpi_device_id acer_wireless_acpi_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, acer_wireless_acpi_ids);
 
-static void acer_wireless_notify(struct acpi_device *adev, u32 event)
+static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct input_dev *idev = acpi_driver_data(adev);
+	struct acpi_device *adev = data;
+	struct input_dev *idev;
+
+	idev = acpi_driver_data(adev);
 
 	dev_dbg(&adev->dev, "event=%#x\n", event);
 	if (event != 0x80) {
@@ -36,6 +39,7 @@ static void acer_wireless_notify(struct acpi_device *adev, u32 event)
 static int acer_wireless_add(struct acpi_device *adev)
 {
 	struct input_dev *idev;
+	int ret;
 
 	idev = devm_input_allocate_device(&adev->dev);
 	if (!idev)
@@ -50,7 +54,17 @@ static int acer_wireless_add(struct acpi_device *adev)
 	set_bit(EV_KEY, idev->evbit);
 	set_bit(KEY_RFKILL, idev->keybit);
 
-	return input_register_device(idev);
+	ret = input_register_device(idev);
+
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(adev, ACPI_DEVICE_NOTIFY, acer_wireless_notify);
+}
+
+static void acer_wireless_remove(struct acpi_device *adev)
+{
+	acpi_device_remove_event_handler(adev, ACPI_DEVICE_NOTIFY, acer_wireless_notify);
 }
 
 static struct acpi_driver acer_wireless_driver = {
@@ -59,7 +73,7 @@ static struct acpi_driver acer_wireless_driver = {
 	.ids = acer_wireless_acpi_ids,
 	.ops = {
 		.add = acer_wireless_add,
-		.notify = acer_wireless_notify,
+		.remove = acer_wireless_remove,
 	},
 };
 module_acpi_driver(acer_wireless_driver);
-- 
2.40.1

