Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17A9CBA1
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2019 10:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbfHZIdB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Aug 2019 04:33:01 -0400
Received: from mga12.intel.com ([192.55.52.136]:51354 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbfHZIdA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Aug 2019 04:33:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:33:00 -0700
X-IronPort-AV: E=Sophos;i="5.64,431,1559545200"; 
   d="scan'208";a="380462601"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Aug 2019 01:32:58 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id B9CED20B51;
        Mon, 26 Aug 2019 11:32:23 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1i2APB-0002KN-8u; Mon, 26 Aug 2019 11:31:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 5/5] at24: Support probing while off
Date:   Mon, 26 Aug 2019 11:31:12 +0300
Message-Id: <20190826083112.8888-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
References: <20190826083112.8888-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In certain use cases (where the chip is part of a camera module, and the
camera module is wired together with a camera privacy LED), powering on
the device during probe is undesirable. Add support for the at24 to
execute probe while being powered off. For this to happen, a hint in form
of a device property is required from the firmware.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/misc/eeprom/at24.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 518945b2f7374..a56cd6a6105c0 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -565,6 +565,7 @@ static int at24_probe(struct i2c_client *client)
 	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	bool low_power;
 	struct regmap *regmap;
 	bool writable;
 	u8 test_byte;
@@ -702,19 +703,24 @@ static int at24_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, at24);
 
-	/* enable runtime pm */
-	pm_runtime_set_active(dev);
+	low_power = acpi_dev_low_power_state_probe(&client->dev);
+	if (!low_power)
+		pm_runtime_set_active(dev);
+
 	pm_runtime_enable(dev);
 
 	/*
-	 * Perform a one-byte test read to verify that the
-	 * chip is functional.
+	 * Perform a one-byte test read to verify that the chip is functional,
+	 * unless powering on the device is to be avoided during probe (i.e.
+	 * it's powered off right now).
 	 */
-	err = at24_read(at24, 0, &test_byte, 1);
-	pm_runtime_idle(dev);
-	if (err) {
-		pm_runtime_disable(dev);
-		return -ENODEV;
+	if (!low_power) {
+		err = at24_read(at24, 0, &test_byte, 1);
+		pm_runtime_idle(dev);
+		if (err) {
+			pm_runtime_disable(dev);
+			return -ENODEV;
+		}
 	}
 
 	dev_info(dev, "%u byte %s EEPROM, %s, %u bytes/write\n",
@@ -726,8 +732,12 @@ static int at24_probe(struct i2c_client *client)
 
 static int at24_remove(struct i2c_client *client)
 {
+	bool low_power;
+
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	low_power = acpi_dev_low_power_state_probe(&client->dev);
+	if (!low_power)
+		pm_runtime_set_suspended(&client->dev);
 
 	return 0;
 }
@@ -735,6 +745,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.probe_low_power = true,
 		.of_match_table = at24_of_match,
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
-- 
2.20.1

