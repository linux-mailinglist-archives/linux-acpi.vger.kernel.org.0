Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FA92B45D7
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Nov 2020 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgKPO3E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Nov 2020 09:29:04 -0500
Received: from mga14.intel.com ([192.55.52.115]:42691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgKPO3E (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Nov 2020 09:29:04 -0500
IronPort-SDR: XS5HSQk1EUkihkpp2RLXRYJ1wJfW4dWLBvQAF82SsDO1sUXsFGoyoWY+t8bYvgv5BH8IC6hdWP
 t8X5Fcx/YbEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="169969410"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="169969410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 06:29:03 -0800
IronPort-SDR: IgLTJ36l3Tzsp3/4Ha+z8cTstKVDV0yKnyzbMJQ23VdDYTr7ZHuoG8BsEBynfnhZ//om+sP5Uv
 jbm2+OLmASKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="531865896"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2020 06:29:02 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3C33AA7; Mon, 16 Nov 2020 16:29:01 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] rtc: ds1307: Make use of device properties
Date:   Mon, 16 Nov 2020 16:28:58 +0200
Message-Id: <20201116142859.31257-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
References: <20201116142859.31257-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: moved ds3231_clks_names to be global and static
 drivers/rtc/rtc-ds1307.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index fcb8e281abd5..49260bc260e3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -12,7 +12,8 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/rtc/ds1307.h>
 #include <linux/rtc.h>
 #include <linux/slab.h>
@@ -30,6 +31,7 @@
  * That's a natural job for a factory or repair bench.
  */
 enum ds_type {
+	unknown_ds_type, /* always first and 0 */
 	ds_1307,
 	ds_1308,
 	ds_1337,
@@ -1600,13 +1602,16 @@ static const struct clk_ops ds3231_clk_32khz_ops = {
 	.recalc_rate = ds3231_clk_32khz_recalc_rate,
 };
 
+static const char *ds3231_clks_names[] = {
+	[DS3231_CLK_SQW] = "ds3231_clk_sqw",
+	[DS3231_CLK_32KHZ] = "ds3231_clk_32khz",
+};
+
 static struct clk_init_data ds3231_clks_init[] = {
 	[DS3231_CLK_SQW] = {
-		.name = "ds3231_clk_sqw",
 		.ops = &ds3231_clk_sqw_ops,
 	},
 	[DS3231_CLK_32KHZ] = {
-		.name = "ds3231_clk_32khz",
 		.ops = &ds3231_clk_32khz_ops,
 	},
 };
@@ -1627,6 +1632,11 @@ static int ds3231_clks_register(struct ds1307 *ds1307)
 	if (!onecell->clks)
 		return -ENOMEM;
 
+	/* optional override of the clockname */
+	device_property_read_string_array(ds1307->dev, "clock-output-names",
+					  ds3231_clks_names,
+					  ARRAY_SIZE(ds3231_clks_names));
+
 	for (i = 0; i < ARRAY_SIZE(ds3231_clks_init); i++) {
 		struct clk_init_data init = ds3231_clks_init[i];
 
@@ -1637,9 +1647,7 @@ static int ds3231_clks_register(struct ds1307 *ds1307)
 		if (i == DS3231_CLK_SQW && test_bit(HAS_ALARM, &ds1307->flags))
 			continue;
 
-		/* optional override of the clockname */
-		of_property_read_string_index(node, "clock-output-names", i,
-					      &init.name);
+		init.name = ds3231_clks_names[i];
 		ds1307->clks[i].init = &init;
 
 		onecell->clks[i] = devm_clk_register(ds1307->dev,
@@ -1648,10 +1656,8 @@ static int ds3231_clks_register(struct ds1307 *ds1307)
 			return PTR_ERR(onecell->clks[i]);
 	}
 
-	if (!node)
-		return 0;
-
-	of_clk_add_provider(node, of_clk_src_onecell_get, onecell);
+	if (node)
+		of_clk_add_provider(node, of_clk_src_onecell_get, onecell);
 
 	return 0;
 }
@@ -1735,6 +1741,7 @@ static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
+	const void		*match;
 	int			err = -ENODEV;
 	int			tmp;
 	const struct chip_desc	*chip;
@@ -1760,9 +1767,9 @@ static int ds1307_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, ds1307);
 
-	if (client->dev.of_node) {
-		ds1307->type = (enum ds_type)
-			of_device_get_match_data(&client->dev);
+	match = device_get_match_data(&client->dev);
+	if (match) {
+		ds1307->type = (enum ds_type)match;
 		chip = &chips[ds1307->type];
 	} else if (id) {
 		chip = &chips[id->driver_data];
@@ -1786,7 +1793,6 @@ static int ds1307_probe(struct i2c_client *client,
 			     trickle_charger_setup);
 	}
 
-#ifdef CONFIG_OF
 /*
  * For devices with no IRQ directly connected to the SoC, the RTC chip
  * can be forced as a wakeup source by stating that explicitly in
@@ -1795,10 +1801,8 @@ static int ds1307_probe(struct i2c_client *client,
  * This will guarantee the 'wakealarm' sysfs entry is available on the device,
  * if supported by the RTC.
  */
-	if (chip->alarm && of_property_read_bool(client->dev.of_node,
-						 "wakeup-source"))
+	if (chip->alarm && device_property_read_bool(&client->dev, "wakeup-source"))
 		ds1307_can_wakeup_device = true;
-#endif
 
 	switch (ds1307->type) {
 	case ds_1337:
-- 
2.28.0

