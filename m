Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC4A719EAD
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbjFANqN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFANqM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC97107;
        Thu,  1 Jun 2023 06:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627171; x=1717163171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CHhVf9ySLsix+mE5RzK7lqt0XuxhrtmQCio3pLRwejA=;
  b=MNUHTVFRGBWtsH7sLRbIpkvRUmvfQPAPkjeuVADdDWYIYSHg4Kaj6kg9
   9WNCYzzHQpJEiioTMatLGcUADSG4BzBj0LJaC6OryykRgbETdCk1J/IXG
   c7imh0QTRJQVCfrIQjpH935hAqNAZfDDbEPPG8DK9mQfyzewqqLVk6inT
   MX+7TQ23ep51yqFGoBFUfMt86E9yURN/W/kYnU8uGaHHk4z51SYTXceFv
   FdCsRgDUGv1lB4gDZTZirHVYvTYUc0f5B8tDnvm+5RDAf1C5UiiwVr9De
   gvZZ3fRhXKAoVD1vNynRdsEZQeMqTxqEYcKXV+aGW89P2U1P4GZoifUAQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068683"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602095"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602095"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:05 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Azael Avalos <coproscefalo@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 27/35] platform/x86/toshiba_bluetooth: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:30 +0200
Message-Id: <20230601131739.300760-28-michal.wilczynski@intel.com>
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
 drivers/platform/x86/toshiba_bluetooth.c | 30 +++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/toshiba_bluetooth.c b/drivers/platform/x86/toshiba_bluetooth.c
index d8f81962a240..a717bd5fcc88 100644
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
+	return 0;
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

