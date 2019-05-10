Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6533D19B08
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 12:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfEJKJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 06:09:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:53503 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbfEJKJ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 06:09:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 03:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,453,1549958400"; 
   d="scan'208";a="170275100"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2019 03:09:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id A7B1F20800;
        Fri, 10 May 2019 13:09:26 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP2T7-0003p9-Pv; Fri, 10 May 2019 13:09:33 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rajmohan.mani@intel.com, linux-media@vger.kernel.org
Subject: [PATCH 5/5] at24: Support probing while off
Date:   Fri, 10 May 2019 13:09:30 +0300
Message-Id: <20190510100930.14641-6-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
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
 drivers/misc/eeprom/at24.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 63aa541c96088..b9dbe5b6a97be 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -579,6 +579,7 @@ static int at24_probe(struct i2c_client *client)
 	bool i2c_fn_i2c, i2c_fn_block;
 	unsigned int i, num_addresses;
 	struct at24_data *at24;
+	bool powered_off;
 	struct regmap *regmap;
 	size_t at24_size;
 	bool writable;
@@ -701,19 +702,24 @@ static int at24_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, at24);
 
-	/* enable runtime pm */
-	pm_runtime_set_active(dev);
+	powered_off = acpi_dev_powered_off_for_probe(&client->dev);
+	if (!powered_off)
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
-		err = -ENODEV;
-		goto err_clients;
+	if (!powered_off) {
+		err = at24_read(at24, 0, &test_byte, 1);
+		pm_runtime_idle(dev);
+		if (err) {
+			err = -ENODEV;
+			goto err_clients;
+		}
 	}
 
 	nvmem_config.name = dev_name(dev);
@@ -752,12 +758,15 @@ static int at24_probe(struct i2c_client *client)
 static int at24_remove(struct i2c_client *client)
 {
 	struct at24_data *at24;
+	bool powered_off;
 
 	at24 = i2c_get_clientdata(client);
 
 	at24_remove_dummy_clients(at24);
 	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
+	powered_off = acpi_dev_powered_off_for_probe(&client->dev);
+	if (!powered_off)
+		pm_runtime_set_suspended(&client->dev);
 
 	return 0;
 }
@@ -765,6 +774,7 @@ static int at24_remove(struct i2c_client *client)
 static struct i2c_driver at24_driver = {
 	.driver = {
 		.name = "at24",
+		.probe_powered_off = true,
 		.of_match_table = at24_of_match,
 		.acpi_match_table = ACPI_PTR(at24_acpi_ids),
 	},
-- 
2.11.0

