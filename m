Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592A7706203
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEQH7T (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjEQH6j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8289195
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310318; x=1715846318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=03LCjjGLj3CDjtFoUcBeTaz93VJNeNUPZuk1//yrl6Q=;
  b=Mez1SDw4rBm86I1dJFUEFhmyUCtYeiRQNKvUjPs4Ij8sliOGqlov478/
   hEWkk96LGy36QZnetU9d6bL54hC39psR9niidF9WsKnxi6ANCgCASiYdO
   ClfK7SQVfryWi+n0jf0v9C0WZZ92V56eMxiNG6wzIqGSkdlgftCZKk7md
   7XmZb2Jl0L2z/KJBWxAjpsPkAYlJHNd0URvxQZCaM9TOsLvOi8y62bAgh
   r7aJfMDnWDW6nkBTOroENb3A3WKgJXYrs6kTFGRIK/xxvDy9XCj3poLCS
   TGLE1FBkT3ojNV62nOTMAhzanQaZ2pUco/F7DxJS+gnxyvQ/MwYOoZks4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105491"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105491"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877500"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877500"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:37 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 27/34] platform/x86/toshiba_bluetooth: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:17 +0200
Message-Id: <20230517075724.153992-28-michal.wilczynski@intel.com>
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
 drivers/platform/x86/toshiba_bluetooth.c | 30 +++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..18d6b6d568e0 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
@@ -37,7 +37,7 @@ struct toshiba_bluetooth_dev {
 
 static int toshiba_bt_rfkill_add(struct acpi_device *device);
 static void toshiba_bt_rfkill_remove(struct acpi_device *device);
-static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event);
+static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id bt_device_ids[] = {
 	{ "TOS6205", 0},
@@ -57,7 +57,6 @@ static struct acpi_driver toshiba_bt_rfkill_driver = {
 	.ops =		{
 				.add =		toshiba_bt_rfkill_add,
 				.remove =	toshiba_bt_rfkill_remove,
-				.notify =	toshiba_bt_rfkill_notify,
 			},
 	.owner = 	THIS_MODULE,
 	.drv.pm =	&toshiba_bt_pm,
@@ -204,9 +203,12 @@ static const struct rfkill_ops rfk_ops = {
 };
 
 /* ACPI driver functions */
-static void toshiba_bt_rfkill_notify(struct acpi_device *device, u32 event)
+static void toshiba_bt_rfkill_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
+	struct toshiba_bluetooth_dev *bt_dev;
+	struct acpi_device *device = data;
+
+	bt_dev = acpi_driver_data(device);
 
 	if (toshiba_bluetooth_sync_status(bt_dev))
 		return;
@@ -263,8 +265,8 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 				   bt_dev);
 	if (!bt_dev->rfk) {
 		pr_err("Unable to allocate rfkill device\n");
-		kfree(bt_dev);
-		return -ENOMEM;
+		result = -ENOMEM;
+		goto fail_allocate;
 	}
 
 	rfkill_set_hw_state(bt_dev->rfk, !bt_dev->killswitch);
@@ -272,10 +274,20 @@ static int toshiba_bt_rfkill_add(struct acpi_device *device)
 	result = rfkill_register(bt_dev->rfk);
 	if (result) {
 		pr_err("Unable to register rfkill device\n");
-		rfkill_destroy(bt_dev->rfk);
-		kfree(bt_dev);
+		goto fail_register;
 	}
 
+	result = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						   toshiba_bt_rfkill_notify);
+	if (result)
+		goto fail_register;
+
+	return result;
+
+fail_register:
+	rfkill_destroy(bt_dev->rfk);
+fail_allocate:
+	kfree(bt_dev);
 	return result;
 }
 
@@ -283,6 +295,8 @@ static void toshiba_bt_rfkill_remove(struct acpi_device *device)
 {
 	struct toshiba_bluetooth_dev *bt_dev = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, toshiba_bt_rfkill_notify);
+
 	/* clean up */
 	if (bt_dev->rfk) {
 		rfkill_unregister(bt_dev->rfk);
-- 
2.40.1

