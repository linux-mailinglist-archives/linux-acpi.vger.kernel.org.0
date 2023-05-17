Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E73706205
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjEQH7o (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjEQH6m (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:42 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3FC12F
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310321; x=1715846321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X4jzIxNcptBRjTuITcQhS+P6UWBqr7/Y+dzVNs5Qp3I=;
  b=HDUg8dwzCsP6XTYmij2sM3ITA8nn0FiDph0Q7rgNjavZ4m1uRc6Ly+ct
   IPoZ4NrzNJKDlbdVdxIPCcZ9tX/bJ0FyV1HE78cof4JTVzTEXiwrLsUfQ
   WqEDh4rg5sdsSNxqZlsSLDtAjQ0LT5l3zHVf13VByiDGq7t+97ZZpSzlz
   k/CKAS5hMrPDaH4Ta892OE+dWF4P2isvz750cny9XJU3CJPsrWv1rTwWY
   ca7RCTh06n9G2H5vh9AbBC2KdADFDuePZeVTGSuX85qaUDr9x4pAxvQbW
   sv/yIh/AMHvoSP/ke0Hdudq11HUrzPby5sCA+3YcghURiACK7g9JUjxjd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105499"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105499"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877525"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877525"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:39 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 29/34] platform/x86/wireless-hotkey: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:19 +0200
Message-Id: <20230517075724.153992-30-michal.wilczynski@intel.com>
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
 drivers/platform/x86/wireless-hotkey.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wireless-hotkey.c b/drivers/platform/x86/wireless-hotkey.c
index 4422863f47bb..51169509fea1 100644
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
+	return err;
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
 
-- 
2.40.1

