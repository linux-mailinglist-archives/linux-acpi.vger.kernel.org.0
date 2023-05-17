Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C857061F8
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjEQH7H (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjEQH6c (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60E95256
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310310; x=1715846310;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g78n4JtrV5AuyACtMRvoWGwc1OTpMBYSGKwkHgUu8Lc=;
  b=YnE8Ht4UMMZ0a6U5Tcn95cqn4XGmLdBYkPn0RYzP7VCoFCvZ7O/LBIS9
   aRjO+cvUQZ4rsK9LNFmCW6UOghYZ6O0vEnEx6JdckCbZMg0/bg68Omu1q
   1XGCJE9Z7CWLxK6z9dJkbhKyzH11Z0qHjf8BrH550fdOxo3/Cahm2DtvJ
   xrB5CdNzaINBW9bvSskayHNx9QtyzSftrZJS2De6rhkepmlZgJVVWRj8Y
   DVy8zn3KIAZD1xU+sIPm+i0fE5rVzG+JERs//DsnLFi8Dp50MulHfSy/g
   rHz+rYEc5+qnP/9ytfqclIQmylww1VsczWbh+/0Nocg4H181HYx2TCyyn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105431"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105431"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877401"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877401"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:20 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 16/34] platform/x86/asus-laptop: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:57:06 +0200
Message-Id: <20230517075724.153992-17-michal.wilczynski@intel.com>
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
 drivers/platform/x86/asus-laptop.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 761029f39314..fa348c96be16 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1515,11 +1515,14 @@ static void asus_input_exit(struct asus_laptop *asus)
 /*
  * ACPI driver
  */
-static void asus_acpi_notify(struct acpi_device *device, u32 event)
+static void asus_acpi_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct asus_laptop *asus = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct asus_laptop *asus;
 	u16 count;
 
+	asus = acpi_driver_data(device);
+
 	/* TODO Find a better way to handle events count. */
 	count = asus->event_count[event % 128]++;
 	acpi_bus_generate_netlink_event(asus->device->pnp.device_class,
@@ -1880,8 +1883,12 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result && result != -ENODEV)
 		goto fail_pega_rfkill;
 
+	result =  acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, asus_acpi_notify);
+	if (result)
+		goto fail_pega_rfkill;
+
 	asus_device_present = true;
-	return 0;
+	return result;
 
 fail_pega_rfkill:
 	pega_accel_exit(asus);
@@ -1905,6 +1912,7 @@ static void asus_acpi_remove(struct acpi_device *device)
 {
 	struct asus_laptop *asus = acpi_driver_data(device);
 
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY, asus_acpi_notify);
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
@@ -1928,11 +1936,9 @@ static struct acpi_driver asus_acpi_driver = {
 	.class = ASUS_LAPTOP_CLASS,
 	.owner = THIS_MODULE,
 	.ids = asus_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = asus_acpi_add,
 		.remove = asus_acpi_remove,
-		.notify = asus_acpi_notify,
 		},
 };
 
-- 
2.40.1

