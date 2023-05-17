Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE547061ED
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjEQH67 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 03:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjEQH6b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 03:58:31 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A9AE0
        for <linux-acpi@vger.kernel.org>; Wed, 17 May 2023 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684310302; x=1715846302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=COrm5SufV9+SO+jyJOxyL8qDS/K+TLTiXG1AoI5AHxA=;
  b=nvs+Cfe3qiS4NZKd85ppeUs5NumMEQuEhMleVU6NB5z2FauXU2y1Rqgn
   UYrEZRZOI10Z+E1HkmK3XSObfRloCeQOdliTOuIXM+W2WNIIFFVQCZE1q
   Qpyu+SPwwho6uGuLntnrGofGnCBzQUmFSR+O6/xcGeJUdd1shgGnJ0Uaa
   b9oRQnmhVEH4W9MqWoLqU1pcs48F1NueMXW2Kc4agEXbIYCF69YQKLVfR
   ieljXk8zZTkg4jRfF8dQcXlI70d6A6fjg50UVn9yhPoHNw7L9pFr7Bqlq
   Kd8ZEOu7apRc2nVabHBY89l6jCe+yvw7syAqYiPgPs7B2Dwtu6Q/Qq80y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415105371"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="415105371"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="825877269"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="825877269"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 00:58:03 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v3 04/34] acpi/battery: Move handler installing logic to driver
Date:   Wed, 17 May 2023 09:56:54 +0200
Message-Id: <20230517075724.153992-5-michal.wilczynski@intel.com>
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

