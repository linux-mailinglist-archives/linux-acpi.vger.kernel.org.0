Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E17009DB
	for <lists+linux-acpi@lfdr.de>; Fri, 12 May 2023 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbjELODp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 May 2023 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbjELOD0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2023 10:03:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3C259D0
        for <linux-acpi@vger.kernel.org>; Fri, 12 May 2023 07:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683900205; x=1715436205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8f1zF/CYjsR0VEmhcV9UTOXYcizlKE93MgFKQdhrbi4=;
  b=A+YeB2pNc8gfH4szWA7Vd5YhtBPo8HFk2iUEF3aPRr+9nBS78zpeqROm
   481XIereQeRXdVHEW5ko9Mqp0rbiXMQIjfHq4s9LQOxgmO0Es+1HXh1AS
   tt8joCvIyNyq7d27lAIXz7MdGpc25RK3Z+E+3lO0VjIf9eyu97wFiOqH3
   8O2Jl2AkVU01y5yn2G7/Ak7gLPMDUCWIxZHPN1Jat9earQmiptkLoZqYj
   cbz0DLz0CvUL/bRc7mTAo4/nXqSXUG7hijOU5ww3VwOJQJydS9y+n0Pai
   NJFjuEwA/RTpXOuQ5ct4OgTRndJ3t15krFFf7bII39/6Un5AkaWFppQ/s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="378931159"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="378931159"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="650648996"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="650648996"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 07:03:24 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v1 24/34] platform/x86/system76_acpi: Move handler installing logic to driver
Date:   Fri, 12 May 2023 16:02:12 +0200
Message-Id: <20230512140222.124868-25-michal.wilczynski@intel.com>
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
2.38.1

