Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C37061FF
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjEQH7P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjEQH6f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618143C3A
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310314; x=1715846314;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=txzmCeCA/MPyNx/npYsx9yZon2/dCun/SRz4VGygQnU=;
  b=fNxb5hFv1o4GdSU088Tag/KvdrUpDA7P/TiHCThAE6LRIV6xufWvKXpW
   tU0bl5hgMuFGg57Kp8PZb+X3BnTXtiJT9zFPvmdot4mKY45xbJhBbL3jV
   PdjaKVHepR/IRvvWsYtx4RiYOphyTnyArYNw3KBYr9zThhHlg+SWPRRMt
   m9yD2Fs1B1tsQ4MDIsrVWToIWDlsP83DBt4K7nl8Wlmog2rSpi4/ubT2o
   O0EBPWo/jr0/5dyYhWQD6fzguU8XwiOjuO5hOMmxbZVjJIY9NrkQbJcvT
   I5Iq2pm1jJ5TFCL/bf34pE9Dm7lDMsUSwS0uYWGsDUqDY8VB1u0O4GoJ/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105477"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105477"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877463"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877463"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:32 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 24/34] platform/x86/system76_acpi: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:14 +0200
Message-Id: <20230517075724.153992-25-michal.wilczynski@intel.com>
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
 drivers/platform/x86/system76_acpi.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/system76_acpi.c b/drivers/platform/x86/system76_acpi.c
index 97f5a8255b91..3e729ec08b8b 100644
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
@@ -733,7 +734,11 @@ static int system76_add(struct acpi_device *acpi_dev)
 		system76_battery_init();
 	}
 
-	return 0;
+	err = acpi_device_install_event_handler(acpi_dev, ACPI_DEVICE_NOTIFY, system76_notify);
+	if (err)
+		goto error;
+
+	return err;
 
 error:
 	if (data->has_open_ec) {
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

