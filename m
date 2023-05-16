Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED97704CF2
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjEPLuE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbjEPLts (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F349559DA
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237763; x=1715773763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x3AJ3PId6jIGtQB9vpaoOXEI4Ix+E0rg/cnm/msjsok=;
  b=CzPfacWDBDWqmMF+GJs++e+5AVdbaYlGc8nWIAuuuHVBO9NiYYfs04lg
   uAHYyxDYauNDK9/btylbY+gkvWatkCjnsW84ElEIc3zxVpLmnQ1rFu7e3
   ylaSv6Z7FPwhw5hnLCMnhJP2OG0TcFaDVljh8FgmmnqpibAJ7SwWmpo6K
   kxwAQsnobUqCNHp5FcOVySRgFTt8abaa4wDDwL3Ombk/ZAxn9h3qXSlMm
   PPVno3R1hE84xnM0ATEBpnj6J4QWrKSjZhY1hnhCnymEs9xIeUp8uW79J
   P2ZCTx9RpnTewwjvOw0IllZaDb8R+ImsL1EL+4A7Kaf9xoOMtfUsKNnW5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111722"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111722"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961966"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961966"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:08 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 27/34] platform/x86/toshiba_bluetooth: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:10 +0200
Message-Id: <20230516114617.148963-28-michal.wilczynski@intel.com>
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
 drivers/platform/x86/toshiba_bluetooth.c | 28 ++++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..78931c21608a 100644
--- a/drivers/platform/x86/toshiba_bluetooth.c
+++ b/drivers/platform/x86/toshiba_bluetooth.c
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

