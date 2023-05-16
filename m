Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D0704CEB
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbjEPLtW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjEPLtN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:49:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1C7526A
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237722; x=1715773722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=L+W8B416betY3pqtyNCrz01Ylcyoo+b3s7flkA4LBNY=;
  b=YXpZzPdye8WvGYCeQJZfctzVHLeGop0LjjI+S2WLkdIOp5P2OHJTAf5p
   w692jKf6997nZOjk05IKPgHPV49AeqrZVoYaJshUg1JjZxNHSnK7sbK4i
   1c/X279kjtdAYNRbaLsJ9P1RnaERJA/8HCG17ey1xGANz3l7dO0h8Rvyo
   PCKjT2x48qeZUtWgV3vVstXIRi1E9qnsOtJQHgWaXHvXGsFKcjTF9jQaU
   hXQ8zdRMvX+6UyPTB4Kv9cnDei8bQu79pSeX4quxWxY+2gVDgoi3DjYbM
   +rkes5ImvOZ8KDju7/SOleIZZW/OlVY/s0kXciVkkQwS6Qq8TzVV3M1J0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111679"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:47:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961877"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961877"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:59 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 20/34] platform/x86/eeepc-laptop: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:46:03 +0200
Message-Id: <20230516114617.148963-21-michal.wilczynski@intel.com>
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
 drivers/platform/x86/eeepc-laptop.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 62b71e8e3567..bd7f4f6f2dbd 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -1204,12 +1204,15 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
 		pr_info("Unknown key %x pressed\n", event);
 }
 
-static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
+static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 	int old_brightness, new_brightness;
+	struct acpi_device *device = data;
+	struct eeepc_laptop *eeepc;
 	u16 count;
 
+	eeepc = acpi_driver_data(device);
+
 	if (event > ACPI_MAX_SYS_NOTIFY)
 		return;
 	count = eeepc->event_count[event % 128]++;
@@ -1423,7 +1426,12 @@ static int eeepc_acpi_add(struct acpi_device *device)
 		goto fail_rfkill;
 
 	eeepc_device_present = true;
-	return 0;
+	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY,
+						   eeepc_acpi_notify, device);
+	if (result)
+		goto fail_rfkill;
+
+	return result;
 
 fail_rfkill:
 	eeepc_led_exit(eeepc);
@@ -1444,6 +1452,8 @@ static void eeepc_acpi_remove(struct acpi_device *device)
 {
 	struct eeepc_laptop *eeepc = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY,
+					 eeepc_acpi_notify);
 	eeepc_backlight_exit(eeepc);
 	eeepc_rfkill_exit(eeepc);
 	eeepc_input_exit(eeepc);
@@ -1465,11 +1475,9 @@ static struct acpi_driver eeepc_acpi_driver = {
 	.class = EEEPC_ACPI_CLASS,
 	.owner = THIS_MODULE,
 	.ids = eeepc_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = eeepc_acpi_add,
 		.remove = eeepc_acpi_remove,
-		.notify = eeepc_acpi_notify,
 	},
 };
 
-- 
2.40.1

