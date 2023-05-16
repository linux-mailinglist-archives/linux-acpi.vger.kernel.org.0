Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839DC704CD5
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjEPLri (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbjEPLrV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:47:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49ECE6A55
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237616; x=1715773616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COrm5SufV9+SO+jyJOxyL8qDS/K+TLTiXG1AoI5AHxA=;
  b=LQ0mm/wxWqClsNfgJvun6ZuySg8WDtx3Ls9m8uQsXPZyFkOOE79i/8cp
   z13r263IVcs8bBoYegKjFyj5dnL7DPEgYNeYt5B443UrnRN89kXGVZi2+
   9GNStx5lDtsTN0iP8pdRbZxawIU1O/+pwqBIyJN4WhFxOaraPhY39VOG4
   SmQR4ZvZ7uaZCtI6Ej+e88RI8BzgSrcKCvueSzVr9c8C6KqDmPTs7oCnA
   hkiz4lec94SuQtlvoRe79Gj0J0d0HZzUTq8RnyVh3aR8LEbNXHq9DKJ/U
   qGrbDae/GkrMxEwM2oapFPAl7m2rgafk1mMJHbTUewBDGZfprqfHhBSLj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111604"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961786"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961786"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:39 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 04/34] acpi/battery: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:47 +0200
Message-Id: <20230516114617.148963-5-michal.wilczynski@intel.com>
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
 drivers/acpi/battery.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9c67ed02d797..0dafe6c14509 100644
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
@@ -1212,6 +1215,10 @@ static int acpi_battery_add(struct acpi_device *device)
 
 	device_init_wakeup(&device->dev, 1);
 
+	result = acpi_device_install_event_handler(device, ACPI_ALL_NOTIFY, acpi_battery_notify);
+	if (result)
+		goto fail;
+
 	return result;
 
 fail:
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

