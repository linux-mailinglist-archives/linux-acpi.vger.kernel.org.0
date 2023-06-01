Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA8719E8D
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjFANoo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFANon (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:44:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6802107;
        Thu,  1 Jun 2023 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627082; x=1717163082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjmFYoUk3ppWyxuHsT01mpbXu3uCoDZy5oj2DUuL4FI=;
  b=Rwm52EWNB6OZkjog/K3r13bXmzb+XSpT7t4yhMQJwLsliVvAPG29zNUt
   P+H7VQD6NF5zS/1sdG0rpZsoBf1cyxlOaVaTECvPzB1Zbrp2kU7+uJb8w
   9nCZx+PDvG06D6aVx39CT9KN6L6CtDPgmzrBezrmLJMxpZbMba0e9pVOr
   dXAbwdlLgQIt1omzDKIAOsz2U+jtlxAx8quys9tm1t4f7O1Z0fl41riwZ
   5LwJ2uxmvh94f9MYwxUGHNWfcr6aqylMrBpO1A1H+hn0W3FAUNKDQJCdr
   i2zUYr4WDMnBgu5Nbdlbx8MyKXOB7cuu1sjtzG/Ult+kx6PgfC/TWrGWv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067813"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067813"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601822"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601822"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:19:24 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org
Subject: [PATCH v4 16/35] platform/x86/asus-laptop: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:19 +0200
Message-Id: <20230601131739.300760-17-michal.wilczynski@intel.com>
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
 drivers/platform/x86/asus-laptop.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index 761029f39314..6d2f5767bf70 100644
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
@@ -1880,6 +1883,10 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result && result != -ENODEV)
 		goto fail_pega_rfkill;
 
+	result =  acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, asus_acpi_notify);
+	if (result)
+		goto fail_pega_rfkill;
+
 	asus_device_present = true;
 	return 0;
 
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

