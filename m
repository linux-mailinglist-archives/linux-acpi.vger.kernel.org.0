Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAD02B0923
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 16:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgKLP6P (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 10:58:15 -0500
Received: from mga18.intel.com ([134.134.136.126]:58415 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgKLP6O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 10:58:14 -0500
IronPort-SDR: IirpSRGGz+/NzKABwlHi2WqaUxzWoluEuQ9DAEkLCAZYgY3LYXSz4T5lg1y4h6oAAmkbbIcFyY
 Tm/kVv2Rh7Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="158107989"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="158107989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 07:57:57 -0800
IronPort-SDR: Xk2KyItgmpJUADWWR/tB5g2dDzZ3jS2DFMWGtVDCbYDxTyvZkvnOnWQ2I0V1TASCDpCXKO2eYS
 79M+BUnhNddg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="366396596"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Nov 2020 07:57:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 67F5F14B; Thu, 12 Nov 2020 17:57:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Date:   Thu, 12 Nov 2020 17:57:51 +0200
Message-Id: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added non-valid
ACPI IDs (all of them abusing ACPI specification). Moreover there is
no even a single evidence that vendor registered any of such device.

Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
with device tree defined bindings. The following patches will add support
of that to the driver.

Link: https://uefi.org/PNP_ACPI_Registry
Cc: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-ds1307.c | 36 +-----------------------------------
 1 file changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 9f5f54ca039d..fcb8e281abd5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -8,7 +8,6 @@
  *  Copyright (C) 2012 Bertrand Achard (nvram access fixes)
  */
 
-#include <linux/acpi.h>
 #include <linux/bcd.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
@@ -1169,31 +1168,6 @@ static const struct of_device_id ds1307_of_match[] = {
 MODULE_DEVICE_TABLE(of, ds1307_of_match);
 #endif
 
-#ifdef CONFIG_ACPI
-static const struct acpi_device_id ds1307_acpi_ids[] = {
-	{ .id = "DS1307", .driver_data = ds_1307 },
-	{ .id = "DS1308", .driver_data = ds_1308 },
-	{ .id = "DS1337", .driver_data = ds_1337 },
-	{ .id = "DS1338", .driver_data = ds_1338 },
-	{ .id = "DS1339", .driver_data = ds_1339 },
-	{ .id = "DS1388", .driver_data = ds_1388 },
-	{ .id = "DS1340", .driver_data = ds_1340 },
-	{ .id = "DS1341", .driver_data = ds_1341 },
-	{ .id = "DS3231", .driver_data = ds_3231 },
-	{ .id = "M41T0", .driver_data = m41t0 },
-	{ .id = "M41T00", .driver_data = m41t00 },
-	{ .id = "M41T11", .driver_data = m41t11 },
-	{ .id = "MCP7940X", .driver_data = mcp794xx },
-	{ .id = "MCP7941X", .driver_data = mcp794xx },
-	{ .id = "PT7C4338", .driver_data = ds_1307 },
-	{ .id = "RX8025", .driver_data = rx_8025 },
-	{ .id = "ISL12057", .driver_data = ds_1337 },
-	{ .id = "RX8130", .driver_data = rx_8130 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, ds1307_acpi_ids);
-#endif
-
 /*
  * The ds1337 and ds1339 both have two alarms, but we only use the first
  * one (with a "seconds" field).  For ds1337 we expect nINTA is our alarm
@@ -1794,14 +1768,7 @@ static int ds1307_probe(struct i2c_client *client,
 		chip = &chips[id->driver_data];
 		ds1307->type = id->driver_data;
 	} else {
-		const struct acpi_device_id *acpi_id;
-
-		acpi_id = acpi_match_device(ACPI_PTR(ds1307_acpi_ids),
-					    ds1307->dev);
-		if (!acpi_id)
-			return -ENODEV;
-		chip = &chips[acpi_id->driver_data];
-		ds1307->type = acpi_id->driver_data;
+		return -ENODEV;
 	}
 
 	want_irq = client->irq > 0 && chip->alarm;
@@ -2065,7 +2032,6 @@ static struct i2c_driver ds1307_driver = {
 	.driver = {
 		.name	= "rtc-ds1307",
 		.of_match_table = of_match_ptr(ds1307_of_match),
-		.acpi_match_table = ACPI_PTR(ds1307_acpi_ids),
 	},
 	.probe		= ds1307_probe,
 	.id_table	= ds1307_id,
-- 
2.28.0

