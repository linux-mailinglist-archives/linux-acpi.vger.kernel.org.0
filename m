Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6599E719E67
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjFANl4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjFANlz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:41:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7344C138;
        Thu,  1 Jun 2023 06:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685626914; x=1717162914;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J2m0TGOiRoBd/ax/IBNGAB4gn5LdAqZnUKRaqrOD26M=;
  b=fImHP365NyyfPVIZKULo3F4MPqxf1F+SMfphRvmXwBer0nkUReOgs+zj
   tR5yndRG72N3N4UBOrdg9mjnlki4urWbvv6qqQ7TT90d3GwcSDRG3pXkF
   7jHCT0aOszYT1U1Ua1AN/Bmnsmz24kX6I0FT2yQYh+Y5fkkt+Xnc1uZ9d
   +ecJ9l+157qYbX04SULUc/gk2VK3WYv2b9VrqBYggjtV+L1WKGNDwvdVn
   RJ+CJHjpToGG0wuSo4Q42gGI/9ceiRHflOWMUQ8eeX3TgwmnZUg3/7ONH
   MPhAKB4bK/c2j3VveqYTnjfQzFqVqLzLwyddU8EAU4UlUJAUnqGDpIDWk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419066480"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419066480"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601301"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601301"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:18 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 04/35] acpi/battery: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:07 +0200
Message-Id: <20230601131739.300760-5-michal.wilczynski@intel.com>
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
 drivers/acpi/battery.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9c67ed02d797..37449c33771b 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1034,11 +1034,14 @@ static void acpi_battery_refresh(struct acpi_battery *battery)
 }
 
 /* Driver Interface */
-static void acpi_battery_notify(struct acpi_device *device, u32 event)
+static void acpi_battery_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_battery *battery = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_battery *battery;
 	struct power_supply *old;
 
+	battery = acpi_driver_data(device);
+
 	if (!battery)
 		return;
 	old = battery->bat;
@@ -1212,7 +1215,11 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 1);
 
-	return result;
+	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, acpi_battery_notify);
+	if (result)
+		goto fail;
+
+	return 0;
 
 fail:
 	sysfs_remove_battery(battery);
@@ -1228,6 +1235,7 @@ static void acpi_battery_remove(struct acpi_device *device)
 
 	if (!device || !acpi_driver_data(device))
 		return;
+	acpi_device_remove_event_handler(device, ACPI_ALL_NOTIFY, acpi_battery_notify);
 	device_init_wakeup(&device->dev, 0);
 	battery = acpi_driver_data(device);
 	unregister_pm_notifier(&battery->pm_nb);
@@ -1264,11 +1272,9 @@ static struct acpi_driver acpi_battery_driver = {
 	.name = "battery",
 	.class = ACPI_BATTERY_CLASS,
 	.ids = battery_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
 	.ops = {
 		.add = acpi_battery_add,
 		.remove = acpi_battery_remove,
-		.notify = acpi_battery_notify,
 		},
 	.drv.pm = &acpi_battery_pm,
 };
-- 
2.40.1

