Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E42719EA5
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjFANpx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjFANpv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:45:51 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2724A139;
        Thu,  1 Jun 2023 06:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627150; x=1717163150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eJQx9O0afpNtxcu6WUqjCRA7U7VMijE7JVpJGwdDK0g=;
  b=UC13wwg5RQqTLou5w/CwqtkHJ42BDN1+lAogg1VAHw7scwH+M0wAs50Z
   X2zZq5fvvyQVfY+g0MHGxFdQ/xiAQZteUmHtcMxKJWz0uIWf4VheoLCMG
   3wqT1Eg6ugj1WuQf1ooKsU30Or/2LllkXAYDugA+tlcUxkOF7GKe4yFKy
   1CNFuGcRV4S9094ecz4jfK1+plSmzVzNN1n/MKpYpvGJ1u+6TuBy0EuGn
   t9Q5F49nHCZceDrmvtLfceCMIQKru7Y+nlOqPTNOeVMKXgD6QJBm/eABG
   ovAinFfkFaI0PgTX4rUnm03GMdb4tG+Vz8IuAM4wqhfWG02J/rZjPQMJ7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068473"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068473"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602016"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602016"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:55 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Jeremy Soller <jeremy@system76.com>,
        System76 Product Development <productdev@system76.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 24/35] platform/x86/system76_acpi: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:27 +0200
Message-Id: <20230601131739.300760-25-michal.wilczynski@intel.com>
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
 drivers/platform/x86/system76_acpi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 97f5a8255b91..b08411b60993 100644
--- a/drivers/platform/x86/system76_acpi.c
+++ b/drivers/platform/x86/system76_acpi.c
@@ -627,29 +627,30 @@ static void input_key(struct system76_data *data, unsigned int code)
 }
 
 // Handle ACPI notification
-static void system76_notify(struct acpi_device *acpi_dev, u32 event)
+static void system76_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct system76_data *data;
+	struct acpi_device *acpi_dev = data;
+	struct system76_data *s_data;
 
-	data = acpi_driver_data(acpi_dev);
+	s_data = acpi_driver_data(acpi_dev);
 	switch (event) {
 	case 0x80:
-		kb_led_hotkey_hardware(data);
+		kb_led_hotkey_hardware(s_data);
 		break;
 	case 0x81:
-		kb_led_hotkey_toggle(data);
+		kb_led_hotkey_toggle(s_data);
 		break;
 	case 0x82:
-		kb_led_hotkey_down(data);
+		kb_led_hotkey_down(s_data);
 		break;
 	case 0x83:
-		kb_led_hotkey_up(data);
+		kb_led_hotkey_up(s_data);
 		break;
 	case 0x84:
-		kb_led_hotkey_color(data);
+		kb_led_hotkey_color(s_data);
 		break;
 	case 0x85:
-		input_key(data, KEY_SCREENLOCK);
+		input_key(s_data, KEY_SCREENLOCK);
 		break;
 	}
 }
@@ -733,6 +734,10 @@ static int system76_add(struct acpi_device *acpi_dev)
 		system76_battery_init();
 	}
 
+	err = acpi_device_install_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+	if (err)
+		goto error;
+
 	return 0;
 
 error:
@@ -750,6 +755,8 @@ static void system76_remove(struct acpi_device *acpi_dev)
 
 	data = acpi_driver_data(acpi_dev);
 
+	acpi_device_remove_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+
 	if (data->has_open_ec) {
 		system76_battery_exit();
 		kfree(data->nfan);
@@ -769,7 +776,6 @@ static struct acpi_driver system76_driver = {
 	.ops = {
 		.add = system76_add,
 		.remove = system76_remove,
-		.notify = system76_notify,
 	},
 };
 module_acpi_driver(system76_driver);
-- 
2.40.1

