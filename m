Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBC719E9E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbjFANpJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjFANpH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8364019F;
        Thu,  1 Jun 2023 06:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627103; x=1717163103;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WoghFPLJJmwA8gTZVBZZPRlBetblz1Bh8YAjwgqBN48=;
  b=HlSomfq3qIzluzrQ7/jaNDMkTnxVWTMzTIGSr+jiIXHqcNXgB3Ar02TA
   a5FR8J8odidjr4phy3auSRYYh/1BF3fDnRF/gNhasV0yQBw/ZZYKnweCV
   TJbJUJODxEDr2/pXq+b0IJvFSDsKS5BuXm9dlxpW81mQdXMjsm4v7FDZD
   4rOmA7dvMtSSxqCi6ck/RkCk6/xYikende8CFMgVJ8VZb+HTZWCZ+zWst
   t+i6VVIJAl+hJ4JhFPxQQreJWVBKlBtHC3x1+Dy8yZ54RJVkJBE/8SsNO
   1LDQBcRiGh1VIo1aDYrpttfkzWph2kNKNWuPdm9vdGgcSI69m68D2JRIK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068022"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068022"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601868"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601868"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:34 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
        Daniel Oliveira Nascimento <don@syst.com.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 18/35] platform/x86/classmate-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:21 +0200
Message-Id: <20230601131739.300760-19-michal.wilczynski@intel.com>
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
 drivers/platform/x86/classmate-laptop.c | 53 +++++++++++++++++++------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/classmate-laptop.c b/drivers/platform/x86/classmate-laptop.c
index 2edaea2492df..2d36abf5ecfe 100644
--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -180,8 +180,9 @@ static acpi_status cmpc_get_accel_v4(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_accel_handler_v4(struct acpi_device *dev, u32 event)
+static void cmpc_accel_handler_v4(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	if (event == 0x81) {
 		int16_t x, y, z;
 		acpi_status status;
@@ -407,6 +408,11 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
+	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
+						  cmpc_accel_handler_v4);
+	if (error)
+		goto failed_input;
+
 	return 0;
 
 failed_input:
@@ -420,6 +426,7 @@ static int cmpc_accel_add_v4(struct acpi_device *acpi)
 
 static void cmpc_accel_remove_v4(struct acpi_device *acpi)
 {
+	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr_v4);
 	device_remove_file(&acpi->dev, &cmpc_accel_g_select_attr_v4);
 	cmpc_remove_acpi_notify_device(acpi);
@@ -441,7 +448,6 @@ static struct acpi_driver cmpc_accel_acpi_driver_v4 = {
 	.ops = {
 		.add = cmpc_accel_add_v4,
 		.remove = cmpc_accel_remove_v4,
-		.notify = cmpc_accel_handler_v4,
 	},
 	.drv.pm = &cmpc_accel_pm,
 };
@@ -523,8 +529,10 @@ static acpi_status cmpc_get_accel(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_accel_handler(struct acpi_device *dev, u32 event)
+static void cmpc_accel_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
+
 	if (event == 0x81) {
 		unsigned char x, y, z;
 		acpi_status status;
@@ -639,6 +647,11 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 	inputdev = dev_get_drvdata(&acpi->dev);
 	dev_set_drvdata(&inputdev->dev, accel);
 
+	error = acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
+						  cmpc_accel_handler);
+	if (error)
+		goto failed_input;
+
 	return 0;
 
 failed_input:
@@ -650,6 +663,7 @@ static int cmpc_accel_add(struct acpi_device *acpi)
 
 static void cmpc_accel_remove(struct acpi_device *acpi)
 {
+	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_accel_handler);
 	device_remove_file(&acpi->dev, &cmpc_accel_sensitivity_attr);
 	cmpc_remove_acpi_notify_device(acpi);
 }
@@ -667,7 +681,6 @@ static struct acpi_driver cmpc_accel_acpi_driver = {
 	.ops = {
 		.add = cmpc_accel_add,
 		.remove = cmpc_accel_remove,
-		.notify = cmpc_accel_handler,
 	}
 };
 
@@ -693,8 +706,9 @@ static acpi_status cmpc_get_tablet(acpi_handle handle,
 	return status;
 }
 
-static void cmpc_tablet_handler(struct acpi_device *dev, u32 event)
+static void cmpc_tablet_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	unsigned long long val = 0;
 	struct input_dev *inputdev = dev_get_drvdata(&dev->dev);
 
@@ -723,12 +737,20 @@ static void cmpc_tablet_idev_init(struct input_dev *inputdev)
 
 static int cmpc_tablet_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
-					   cmpc_tablet_idev_init);
+	int ret;
+
+	ret = cmpc_add_acpi_notify_device(acpi, "cmpc_tablet",
+					  cmpc_tablet_idev_init);
+	if (ret)
+		return ret;
+
+	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
+						 cmpc_tablet_handler);
 }
 
 static void cmpc_tablet_remove(struct acpi_device *acpi)
 {
+	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_tablet_handler);
 	cmpc_remove_acpi_notify_device(acpi);
 }
 
@@ -761,7 +783,6 @@ static struct acpi_driver cmpc_tablet_acpi_driver = {
 	.ops = {
 		.add = cmpc_tablet_add,
 		.remove = cmpc_tablet_remove,
-		.notify = cmpc_tablet_handler,
 	},
 	.drv.pm = &cmpc_tablet_pm,
 };
@@ -1026,8 +1047,9 @@ static int cmpc_keys_codes[] = {
 	KEY_MAX
 };
 
-static void cmpc_keys_handler(struct acpi_device *dev, u32 event)
+static void cmpc_keys_handler(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *dev = data;
 	struct input_dev *inputdev;
 	int code = KEY_MAX;
 
@@ -1049,12 +1071,20 @@ static void cmpc_keys_idev_init(struct input_dev *inputdev)
 
 static int cmpc_keys_add(struct acpi_device *acpi)
 {
-	return cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
-					   cmpc_keys_idev_init);
+	int error;
+
+	error = cmpc_add_acpi_notify_device(acpi, "cmpc_keys",
+					    cmpc_keys_idev_init);
+	if (error)
+		return error;
+
+	return acpi_device_install_event_handler(acpi, ACPI_DEVICE_NOTIFY,
+						 cmpc_keys_handler);
 }
 
 static void cmpc_keys_remove(struct acpi_device *acpi)
 {
+	acpi_device_remove_event_handler(acpi, ACPI_DEVICE_NOTIFY, cmpc_keys_handler);
 	cmpc_remove_acpi_notify_device(acpi);
 }
 
@@ -1071,7 +1101,6 @@ static struct acpi_driver cmpc_keys_acpi_driver = {
 	.ops = {
 		.add = cmpc_keys_add,
 		.remove = cmpc_keys_remove,
-		.notify = cmpc_keys_handler,
 	}
 };
 
-- 
2.40.1

