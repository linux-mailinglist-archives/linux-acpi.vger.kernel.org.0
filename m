Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55B719EB2
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjFANq0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFANqZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:46:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A1F107;
        Thu,  1 Jun 2023 06:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627184; x=1717163184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UULP+c5xPWJ1lE10ag6xk4cqPGnw0HUxyzNsldjYr/M=;
  b=kF3ogZy7nHXUDdJsyKb2zuRTg/LGY/KrnzTEkSuVn1RNrpLhZ5oCPg8E
   C0QAX9lVrSbxEhHnZqtg+BKQp5s85eOXlbaspHTwsLH4T42CMZIuviI+8
   0Qv9ygt2GTalnyKnErZeeWukvi11Kve9AlMcQcjZx7FZJ2VwGlpfImyzj
   yuo83ZuOAchAPbrJ5T7babzgkOQ84JgOoJzjxDWttXQiyozETE6hiWpHm
   IYdkNWNEBLAgfUbSGO/iHrV8U0v1HcD3FiZfVufUYYaDAYYuSSucAPoTj
   TDnEMltQrUolQqcRtruaTs6ryD/pKusvkLDk7rcC41Cfw1rwGu6r1zT/i
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419068812"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419068812"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881602132"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881602132"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:20:11 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 29/35] platform/x86/wireless-hotkey: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:32 +0200
Message-Id: <20230601131739.300760-30-michal.wilczynski@intel.com>
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
 drivers/platform/x86/wireless-hotkey.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..6554ef2e9c70 100644
--- a/drivers/platform/x86/wireless-hotkey.c
+++ b/drivers/platform/x86/wireless-hotkey.c
@@ -68,9 +68,12 @@ static void wireless_input_destroy(struct acpi_device *device)
 	kfree(button);
 }
 
-static void wl_notify(struct acpi_device *acpi_dev, u32 event)
+static void wl_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct wl_button *button = acpi_driver_data(acpi_dev);
+	struct acpi_device *acpi_dev = data;
+	struct wl_button *button;
+
+	button = acpi_driver_data(acpi_dev);
 
 	if (event != 0x80) {
 		pr_info("Received unknown event (0x%x)\n", event);
@@ -95,16 +98,24 @@ static int wl_add(struct acpi_device *device)
 	device->driver_data = button;
 
 	err = wireless_input_setup(device);
-	if (err) {
-		pr_err("Failed to setup wireless hotkeys\n");
-		kfree(button);
-	}
+	if (err)
+		goto fail;
 
+	err = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
+	if (err)
+		goto fail;
+
+	return 0;
+
+fail:
+	pr_err("Failed to setup wireless hotkeys\n");
+	kfree(button);
 	return err;
 }
 
 static void wl_remove(struct acpi_device *device)
 {
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, wl_notify);
 	wireless_input_destroy(device);
 }
 
@@ -115,7 +126,6 @@ static struct acpi_driver wl_driver = {
 	.ops	= {
 		.add	= wl_add,
 		.remove	= wl_remove,
-		.notify	= wl_notify,
 	},
 };
 
-- 
2.40.1

