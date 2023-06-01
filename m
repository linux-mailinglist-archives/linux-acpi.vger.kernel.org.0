Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD6719E7E
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jun 2023 15:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjFANno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 1 Jun 2023 09:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjFANnj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 1 Jun 2023 09:43:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F3139;
        Thu,  1 Jun 2023 06:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685627018; x=1717163018;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jrn9jLUoNqgpgWSIlur6vSPLt4iltvZpRWGlDjKGO+w=;
  b=QJjTzim7JAl8VDpCUT6TyeZ4XB/xa0iyA8y1vBdqBeWtroIqCSWaic2z
   SZI4YdRFjAggYwIjmcoKsO6gaaBLcxXJ5hJqY87G2UY78k7TFE8ND/1dd
   LbqWfVwjNyELdg0gIflId1vL3kkC8HPEhma0DLo39kvSO8yRz/0TbWI/e
   kT5Ur6ZudmGg/HTA7g7+HvrG+6sd34g7Qvz0cc+f7Asf/p0lDJZjMFBQ3
   uXZGcdYFH13LoRqGRiQ4pW4lTAIwyLCjtq6PzP+KEbVFoD8a2rTIvrvR3
   2PD7l6UE7NbaeQgOYX0yS0qH8hdinT8BQF8OtjHnaU6Ar1Em+wXnnUKgV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="419067202"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="419067202"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="881601623"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="881601623"
Received: from hextor.igk.intel.com ([10.123.220.6])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 06:18:55 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Michal Wilczynski <michal.wilczynski@intel.com>,
        linux-hwmon@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, rafael@kernel.org
Subject: [PATCH v4 10/35] hwmon/acpi_power_meter: Move handler installing logic to driver
Date:   Thu,  1 Jun 2023 15:17:13 +0200
Message-Id: <20230601131739.300760-11-michal.wilczynski@intel.com>
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
 drivers/hwmon/acpi_power_meter.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index fa28d447f0df..7410ee8693ba 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -817,9 +817,10 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 }
 
 /* Handle ACPI event notifications */
-static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
+static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_power_meter_resource *resource;
+	struct acpi_device *device = data;
 	int res;
 
 	if (!device || !acpi_driver_data(device))
@@ -897,8 +898,12 @@ static int acpi_power_meter_add(struct acpi_device *device)
 		goto exit_remove;
 	}
 
-	res = 0;
-	goto exit;
+	res = acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY,
+						acpi_power_meter_notify);
+	if (res)
+		goto exit_remove;
+
+	return 0;
 
 exit_remove:
 	remove_attrs(resource);
@@ -906,7 +911,7 @@ static int acpi_power_meter_add(struct acpi_device *device)
 	free_capabilities(resource);
 exit_free:
 	kfree(resource);
-exit:
+
 	return res;
 }
 
@@ -917,6 +922,7 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 	if (!device || !acpi_driver_data(device))
 		return;
 
+	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_power_meter_notify);
 	resource = acpi_driver_data(device);
 	hwmon_device_unregister(resource->hwmon_dev);
 
@@ -953,7 +959,6 @@ static struct acpi_driver acpi_power_meter_driver = {
 	.ops = {
 		.add = acpi_power_meter_add,
 		.remove = acpi_power_meter_remove,
-		.notify = acpi_power_meter_notify,
 		},
 	.drv.pm = pm_sleep_ptr(&acpi_power_meter_pm),
 };
-- 
2.40.1

