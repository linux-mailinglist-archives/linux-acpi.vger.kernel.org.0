Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48464704CDF
	for <lists+linux-acpi@lfdr.de>; Tue, 16 May 2023 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbjEPLsD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 May 2023 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjEPLro (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 May 2023 07:47:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F5D59DA
        for <linux-acpi@vger.kernel.org>; Tue, 16 May 2023 04:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684237643; x=1715773643;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTtEgtuB7nC6p1iY52ItdEqRFLO2UPsRXmc9tJlW4cs=;
  b=UxzWjxArYdgc/VziQFvoFRTzBXIe8eiw7IGqR7fKn2Uic9V2b5rWkm8+
   auaQp+AEIW5OHN3r+R2FwLr3LkAkrTyDV2DY9briVcQ6IvmIHIb3FtoGd
   5bRmq581fSeVHkg2hSUM0NK7VZIDMjwtwS16uilIIEbag+UV1yzn1LrZS
   eHTL0ncPTYX7jm75WzipqprbYOMeyuBde/z61sij+Psb/a/Hn65RjNhRg
   lH6HZrqZEAkoqkikIDNR3SmcXH8wMPPOSNfbDTPdsUXshU3v8vWqjAykC
   CDK3s4tIOc2js8j/38BrayUKOqVLQ26l3BHj1cnt5sGV8wjFF907UfyE2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="417111626"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="417111626"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="731961800"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="731961800"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 04:46:44 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rafael@kernel.org, Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 08/34] acpi/thermal: Move handler installing logic to driver
Date:   Tue, 16 May 2023 13:45:51 +0200
Message-Id: <20230516114617.148963-9-michal.wilczynski@intel.com>
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
 drivers/acpi/thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 4720a3649a61..f1fbe15ca360 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -75,7 +75,7 @@ static struct workqueue_struct *acpi_thermal_pm_queue;
 
 static int acpi_thermal_add(struct acpi_device *device);
 static void acpi_thermal_remove(struct acpi_device *device);
-static void acpi_thermal_notify(struct acpi_device *device, u32 event);
+static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data);
 
 static const struct acpi_device_id  thermal_device_ids[] = {
 	{ACPI_THERMAL_HID, 0},
@@ -99,7 +99,6 @@ static struct acpi_driver acpi_thermal_driver = {
 	.ops = {
 		.add = acpi_thermal_add,
 		.remove = acpi_thermal_remove,
-		.notify = acpi_thermal_notify,
 		},
 	.drv.pm = &acpi_thermal_pm,
 };
@@ -894,9 +893,12 @@ static void acpi_queue_thermal_check(struct acpi_thermal *tz)
 		queue_work(acpi_thermal_pm_queue, &tz->thermal_check_work);
 }
 
-static void acpi_thermal_notify(struct acpi_device *device, u32 event)
+static void acpi_thermal_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_thermal *tz = acpi_driver_data(device);
+	struct acpi_device *device = data;
+	struct acpi_thermal *tz;
+
+	tz = acpi_driver_data(device);
 
 	if (!tz)
 		return;
@@ -1067,11 +1069,16 @@ static int acpi_thermal_add(struct acpi_device *device)
 
 	pr_info("%s [%s] (%ld C)\n", acpi_device_name(device),
 		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temperature));
-	goto end;
+
+	result = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						   acpi_thermal_notify);
+	if (result)
+		goto free_memory;
+
+	return result;
 
 free_memory:
 	kfree(tz);
-end:
 	return result;
 }
 
@@ -1082,6 +1089,7 @@ static void acpi_thermal_remove(struct acpi_device *device)
 	if (!device || !acpi_driver_data(device))
 		return;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_thermal_notify);
 	flush_workqueue(acpi_thermal_pm_queue);
 	tz = acpi_driver_data(device);
 
-- 
2.40.1

