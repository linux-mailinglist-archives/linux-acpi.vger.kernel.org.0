Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D6704CEE
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbjEPLte (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjEPLtW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:22 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2A6E97
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237730; x=1715773730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hb8gvHab4mv8wwQQFbmgRq9TQ5IHGsf0Qrw+0dkQ4s=;
  b=TUYAYn0CYsARcaBJNdhsHGgSFwRNR0DmaoESk9Nmepi72FaQH5mQjQfB
   /hCmbuiA4XDJ2Ofc4yMtuWCxi5DrvKhuzA3NCgclOtII0tKETQoxfX3nU
   BmqL8L2FNnXV5lArVo8xdy3UjhOxjHhanZNPcULK5fDpAgSYkA97dqP0K
   GGnpOxTooljSZgZ+e3V3cRHP8HAB9PwdkF6YnKdfp8YWDTpPEQcQ/qY8P
   P5ir/L3Q3E/GVDHOZ4K1v74kkj4d4qJwiZJeby/sryuw66Yn3fa0uf7HH
   t5BEqTP1ccW1Y3WatLCGw/xfcwyIsL2/TmStzJxWBO68uL8CedoVWYJrG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111687"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111687"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961886"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961886"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:00 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 21/34] platform/x86/fujitsu-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:04 +0200
Message-Id: <20230516114617.148963-22-michal.wilczynski@intel.com>
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
 drivers/platform/x86/fujitsu-laptop.c | 103 ++++++++++++++------------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 085e044e888e..41b5bdca859a 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -769,6 +769,54 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	return 0;
 }
 
+static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
+{
+	struct acpi_device *device = data;
+	struct fujitsu_laptop *priv;
+	unsigned long flags;
+	int scancode, i = 0;
+	unsigned int irb;
+
+	priv = acpi_driver_data(device);
+
+	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
+		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
+				 event);
+		sparse_keymap_report_event(priv->input, -1, 1, true);
+		return;
+	}
+
+	if (priv->flags_supported)
+		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
+						   0x0);
+
+	while ((irb = call_fext_func(device,
+				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
+	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
+		scancode = irb & 0x4ff;
+		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
+			acpi_fujitsu_laptop_press(device, scancode);
+		else if (scancode == 0)
+			acpi_fujitsu_laptop_release(device);
+		else
+			acpi_handle_info(device->handle,
+					 "Unknown GIRB result [%x]\n", irb);
+	}
+
+	/*
+	 * First seen on the Skylake-based Lifebook E736/E746/E756), the
+	 * touchpad toggle hotkey (Fn+F4) is handled in software. Other models
+	 * have since added additional "soft keys". These are reported in the
+	 * status flags queried using FUNC_FLAGS.
+	 */
+	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
+		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
+		flags &= (FLAG_SOFTKEYS);
+		for_each_set_bit(i, &flags, BITS_PER_LONG)
+			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
+	}
+}
+
 static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv;
@@ -839,7 +887,12 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	if (ret)
 		goto err_free_fifo;
 
-	return 0;
+	ret = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						acpi_fujitsu_laptop_notify);
+	if (ret)
+		goto err_free_fifo;
+
+	return ret;
 
 err_free_fifo:
 	kfifo_free(&priv->fifo);
@@ -851,6 +904,8 @@ static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
 {
 	struct fujitsu_laptop *priv = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_fujitsu_laptop_notify);
+
 	fujitsu_laptop_platform_remove(device);
 
 	kfifo_free(&priv->fifo);
@@ -889,51 +944,6 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 	}
 }
 
-static void acpi_fujitsu_laptop_notify(struct acpi_device *device, u32 event)
-{
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
-	unsigned long flags;
-	int scancode, i = 0;
-	unsigned int irb;
-
-	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
-				 event);
-		sparse_keymap_report_event(priv->input, -1, 1, true);
-		return;
-	}
-
-	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
-						   0x0);
-
-	while ((irb = call_fext_func(device,
-				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
-	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
-		scancode = irb & 0x4ff;
-		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
-			acpi_fujitsu_laptop_press(device, scancode);
-		else if (scancode == 0)
-			acpi_fujitsu_laptop_release(device);
-		else
-			acpi_handle_info(device->handle,
-					 "Unknown GIRB result [%x]\n", irb);
-	}
-
-	/*
-	 * First seen on the Skylake-based Lifebook E736/E746/E756), the
-	 * touchpad toggle hotkey (Fn+F4) is handled in software. Other models
-	 * have since added additional "soft keys". These are reported in the
-	 * status flags queried using FUNC_FLAGS.
-	 */
-	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
-		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
-		flags &= (FLAG_SOFTKEYS);
-		for_each_set_bit(i, &flags, BITS_PER_LONG)
-			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
-	}
-}
-
 /* Initialization */
 
 static const struct acpi_device_id fujitsu_bl_device_ids[] = {
@@ -963,7 +973,6 @@ static struct acpi_driver acpi_fujitsu_laptop_driver = {
 	.ops = {
 		.add = acpi_fujitsu_laptop_add,
 		.remove = acpi_fujitsu_laptop_remove,
-		.notify = acpi_fujitsu_laptop_notify,
 		},
 };
 
-- 
2.40.1

