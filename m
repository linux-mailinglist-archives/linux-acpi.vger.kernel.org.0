Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26932B091E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Nov 2020 16:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgKLP6D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 10:58:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:26404 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728598AbgKLP6D (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 10:58:03 -0500
IronPort-SDR: Hq1toHhUh0J38OXDRTbO6m9jdyrNMdZRqitzFT8W5QZd54d19yJVyzh8eTdFeNg2Dq272EVwHS
 UQCWd2BCHTBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="157346372"
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="157346372"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 07:57:57 -0800
IronPort-SDR: wWUOPXpdA44KQZiiWQTdy0ismh+pqIiGs0dfH6IaZDsyuQg9LA7Ic++34DiZ2MWCYvxKMLW/wo
 6xFyVfdnZCMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,472,1596524400"; 
   d="scan'208";a="309257592"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 12 Nov 2020 07:57:55 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73F19D2; Thu, 12 Nov 2020 17:57:54 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Tin Huynh <tnhuynh@apm.com>,
        linux-acpi@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] rtc: ds1307: Make use of device properties
Date:   Thu, 12 Nov 2020 17:57:52 +0200
Message-Id: <20201112155753.36834-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
References: <20201112155753.36834-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Device property API allows to gather device resources from different sources,
such as ACPI. Convert the drivers to unleash the power of device property API.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/rtc/rtc-ds1307.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index fcb8e281abd5..40300c872337 100644
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
@@ -1613,8 +1615,11 @@ static struct clk_init_data ds3231_clks_init[] = {
 
 static int ds3231_clks_register(struct ds1307 *ds1307)
 {
-	struct device_node *node = ds1307->dev->of_node;
 	struct clk_onecell_data	*onecell;
+	const char *ds3231_clks_names[] = {
+		[DS3231_CLK_SQW] = ds3231_clks_init[DS3231_CLK_SQW].name,
+		[DS3231_CLK_32KHZ] = ds3231_clks_init[DS3231_CLK_32KHZ].name,
+	};
 	int i;
 
 	onecell = devm_kzalloc(ds1307->dev, sizeof(*onecell), GFP_KERNEL);
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
@@ -1648,10 +1656,9 @@ static int ds3231_clks_register(struct ds1307 *ds1307)
 			return PTR_ERR(onecell->clks[i]);
 	}
 
-	if (!node)
-		return 0;
-
-	of_clk_add_provider(node, of_clk_src_onecell_get, onecell);
+	if (ds1307->dev->of_node)
+		of_clk_add_provider(ds1307->dev->of_node,
+				    of_clk_src_onecell_get, onecell);
 
 	return 0;
 }
@@ -1735,6 +1742,7 @@ static int ds1307_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct ds1307		*ds1307;
+	const void		*match;
 	int			err = -ENODEV;
 	int			tmp;
 	const struct chip_desc	*chip;
@@ -1760,9 +1768,9 @@ static int ds1307_probe(struct i2c_client *client,
 
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
@@ -1786,7 +1794,6 @@ static int ds1307_probe(struct i2c_client *client,
 			     trickle_charger_setup);
 	}
 
-#ifdef CONFIG_OF
 /*
  * For devices with no IRQ directly connected to the SoC, the RTC chip
  * can be forced as a wakeup source by stating that explicitly in
@@ -1795,10 +1802,8 @@ static int ds1307_probe(struct i2c_client *client,
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

