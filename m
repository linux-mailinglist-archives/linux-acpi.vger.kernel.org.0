Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25BD704CEC
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjEPLte (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbjEPLtX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25866E9E
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237730; x=1715773730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hp1lB//t2Bsx0u8JILnk3h+MQwffMBtXiOCz8DTIxD4=;
  b=GwmVFaNx2AcGw0SW0JiGABvv5MKjAZt3E1QladuBgsMBhZBbUc2hmDw/
   tk46C1seXWNb97e5xWn+6aL/N+FVz9OOCb+j91ab7KDJ2BkmGp2JlMbbo
   op0rly/wFsJ8Y26XE7w4Qsy5LiMp0L1VKBfgKRAU1eEOBLm7VC/9ktecK
   Wuxdv+5YbKQJ2sS3d1GTf7rw2JPblPcqS2wM/R/J2blINlEZmRgJHLuev
   DiJKG4YEpYMhBQckgAlR/GsRU5xvadCn6sxV9sBida9/wm8FCp8yhUCTw
   ezGNbPKYjfh0iJWlvkynmlxsKn4pGcHxRbEtBeMnkbcsvZ53O4B9zev9Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111695"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111695"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961897"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961897"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:02 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 22/34] platform/x86/lg-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:05 +0200
Message-Id: <20230516114617.148963-23-michal.wilczynski@intel.com>
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
 drivers/platform/x86/lg-laptop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index ad3c39e9e9f5..79c02df3cb11 100644
--- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -270,8 +270,9 @@ static void wmi_input_setup(void)
 	}
 }
 
-static void acpi_notify(struct acpi_device *device, u32 event)
+static void acpi_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct key_entry *key;
 
 	acpi_handle_debug(device->handle, "notify: %d\n", event);
@@ -752,7 +753,11 @@ static int acpi_add(struct acpi_device *device)
 	wmi_input_setup();
 	battery_hook_register(&battery_hook);
 
-	return 0;
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_notify);
+	if (ret)
+		goto out_platform_device;
+
+	return ret;
 
 out_platform_device:
 	platform_device_unregister(pf_device);
@@ -763,6 +768,8 @@ static int acpi_add(struct acpi_device *device)
 
 static void acpi_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_notify);
+
 	sysfs_remove_group(&pf_device->dev.kobj, &dev_attribute_group);
 
 	led_classdev_unregister(&tpad_led);
@@ -788,7 +795,6 @@ static struct acpi_driver acpi_driver = {
 	.ops = {
 		.add = acpi_add,
 		.remove = acpi_remove,
-		.notify = acpi_notify,
 		},
 	.owner = THIS_MODULE,
 };
-- 
2.40.1

