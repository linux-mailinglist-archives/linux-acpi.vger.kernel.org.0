Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23AB719EA1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjFANpg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjFANpf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A859139;
        Thu,  1 Jun 2023 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627134; x=1717163134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SZOg5MeriDI2PyRVKq7mP5oQrEzUGwUAhmDMpbWonIQ=;
  b=jq1n9VW/NOJfeX8PD5yPoveBoPEYjMDdu90DQl5/k6JrLR1a++PQm0tb
   WnRH+pFpIvHbY+lWilHzThD9oA+FdD13AN22iS8eHISU3hYzDu6P05zRe
   QyG/jpWtZ1FbN5PnAuRPKBqBZ1NdTCbqKKmVextqg1P8qyXy/XSRe+tyb
   PrfLe59Md81uqKPvCeZwv/fRD/IH2VEfZqZ9rQ59m3YBUbDekf0frVod0
   GxSZLpVHwgiY962sRYCfib5rHeDxadAom71Mc+Tyb+51uP0x+EiIu3NSg
   rSGKjSdXKDTlclb5rhxuGM8xZXHdPtctHZ72pyuo2cYnFtTaefOFMnTyJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068325"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068325"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601956"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601956"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:48 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Matan Ziv-Av <matan@svgalib.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 22/35] platform/x86/lg-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:25 +0200
Message-Id: <20230601131739.300760-23-michal.wilczynski@intel.com>
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
 drivers/platform/x86/lg-laptop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-laptop.c
index ad3c39e9e9f5..7469354c84d6 100644
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
@@ -752,6 +753,10 @@ static int acpi_add(struct acpi_device *device)
 	wmi_input_setup();
 	battery_hook_register(&battery_hook);
 
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_notify);
+	if (ret)
+		goto out_platform_device;
+
 	return 0;
 
 out_platform_device:
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

