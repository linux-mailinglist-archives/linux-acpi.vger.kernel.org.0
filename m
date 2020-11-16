Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F052B45DD
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 15:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgKPO3F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 09:29:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:42691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729485AbgKPO3E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 09:29:04 -0500
IronPort-SDR: vHjKuOBJXK/cANRzYh7gKIiK4w1ZvEl+Grx8Zdi7cxR6UAfQiOAmTdWMhYVmN/xD60+ecNmCIp
 AVq3IZ+KHNbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="169969414"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="169969414"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:29:03 -0800
IronPort-SDR: lwvGInTPoIdwnq4JdBG2NRX5T8dSJvZ81SK8Xfmn5aeuL7HmrMFNCAfzvdIt0HdDtpDLo3tKc9
 EAYSkUr0lScA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="367496880"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Nov 2020 06:29:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2CF3B11C; Mon, 16 Nov 2020 16:29:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tin Huynh <tnhuynh@apm.com>
Subject: [PATCH v2 1/3] rtc: ds1307: Remove non-valid ACPI IDs
Date:   Mon, 16 Nov 2020 16:28:57 +0200
Message-Id: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The commit 9c19b8930d2c ("rtc: ds1307: Add ACPI support") added invalid
ACPI IDs (all of them are abusing ACPI specification). Moreover there is
not even a single evidence that vendor registered any of such devices.

Remove broken ACPI IDs from the driver. For prototyping one may use PRP0001
with device properties adhering to a DT binding. The following patches
will add support of that to the driver.

Link: https://uefi.org/PNP_ACPI_Registry
Cc: Tin Huynh <tnhuynh@apm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: reworded commit message to clarify source of properties (Rafael)
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

