Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5080A7009DD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbjELODr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbjELODi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:38 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623F9106CB
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900208; x=1715436208;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PJi/rzJx0JG0jTlQQjDqVY9CNtM024TPNfwM6gh0Gug=;
  b=C9Dk4xrXZBA998H1lMdvjujJcgcn/UwJWL+SGV+v9JJ3fnfjh2SUjAgf
   Zafb0K71SUfQ0JMZlrl3pjpTKGTXckMvWsslLtNfg2ck6j1A+ztMcg54B
   zb75FSl+EmiBI7zHJidj1Gg/6o+1dx6caWrUDYhr7CP0kWDfBrTt/+fVX
   oAB1JlNPuq49cqJx4CwPM0e2rXNmKqH5eLETUq+rj7hW3zG3tkMHhSNeF
   RsaCy+U83AQk4kaDOv6+SH0aDxpeJvgIAj++H8oHKWPGfZ8xICaWPJwJx
   IGCiEwx22+OGZkv0pC4YpYhJMSPxXAdJZhZY7m6OK5tbW1pP9Aqmrg96Z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931181"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931181"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650649002"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650649002"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:26 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 26/34] platform/x86/toshiba_acpi: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:14 +0200
Message-Id: <20230512140222.124868-27-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230512140222.124868-1-michal.wilczynski@intel.com>
References: <20230512140222.124868-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/platform/x86/toshiba_acpi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index b34984bbee33..29980c84d189 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3190,6 +3190,8 @@ static void toshiba_acpi_remove(struct acpi_device *acpi_dev)
 {
 	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
 
+	acpi_device_remove_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_acpi_notify);
+
 	misc_deregister(&dev->miscdev);
 
 	remove_toshiba_proc_entries(dev);
@@ -3473,16 +3475,23 @@ static int toshiba_acpi_add(struct acpi_device *acpi_dev)
 	if (dev->battery_charge_mode_supported)
 		battery_hook_register(&battery_hook);
 
-	return 0;
+	ret = acpi_device_install_event_handler(acpi_dev, ACPI_ALL_NOTIFY, toshiba_acpi_notify);
+	if (ret)
+		goto error;
+
+	return ret;
 
 error:
 	toshiba_acpi_remove(acpi_dev);
 	return ret;
 }
 
-static void toshiba_acpi_notify(struct acpi_device *acpi_dev, u32 event)
+static void toshiba_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct toshiba_acpi_dev *dev = acpi_driver_data(acpi_dev);
+	struct acpi_device *acpi_dev = data;
+	struct toshiba_acpi_dev *dev;
+
+	dev = acpi_driver_data(acpi_dev);
 
 	switch (event) {
 	case 0x80: /* Hotkeys and some system events */
@@ -3583,11 +3592,9 @@ static struct acpi_driver toshiba_acpi_driver = {
 	.name	= "Toshiba ACPI driver",
 	.owner	= THIS_MODULE,
 	.ids	= toshiba_device_ids,
-	.flags	= ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops	= {
 		.add		= toshiba_acpi_add,
 		.remove		= toshiba_acpi_remove,
-		.notify		= toshiba_acpi_notify,
 	},
 	.drv.pm	= &toshiba_acpi_pm,
 };
-- 
2.38.1

