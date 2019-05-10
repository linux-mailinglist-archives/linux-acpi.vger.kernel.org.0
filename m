Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4568619B0A
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 12:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfEJKJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 06:09:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:53503 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727348AbfEJKJb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 06:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 03:09:28 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga006.fm.intel.com with ESMTP; 10 May 2019 03:09:27 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 7CD8420E12;
        Fri, 10 May 2019 13:09:25 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP2T6-0003p3-EL; Fri, 10 May 2019 13:09:32 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rajmohan.mani@intel.com, linux-media@vger.kernel.org
Subject: [PATCH 3/5] ov5670: Support probe whilst the device is off
Date:   Fri, 10 May 2019 13:09:28 +0300
Message-Id: <20190510100930.14641-4-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Tell ACPI device PM code that the driver supports the device being powered
off when the driver's probe function is entered.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/ov5670.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/ov5670.c b/drivers/media/i2c/ov5670.c
index 041fcbb4eebdf..57e8b92f90e09 100644
--- a/drivers/media/i2c/ov5670.c
+++ b/drivers/media/i2c/ov5670.c
@@ -2444,6 +2444,7 @@ static int ov5670_probe(struct i2c_client *client)
 	struct ov5670 *ov5670;
 	const char *err_msg;
 	u32 input_clk = 0;
+	bool powered_off;
 	int ret;
 
 	device_property_read_u32(&client->dev, "clock-frequency", &input_clk);
@@ -2460,11 +2461,14 @@ static int ov5670_probe(struct i2c_client *client)
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&ov5670->sd, client, &ov5670_subdev_ops);
 
-	/* Check module identity */
-	ret = ov5670_identify_module(ov5670);
-	if (ret) {
-		err_msg = "ov5670_identify_module() error";
-		goto error_print;
+	powered_off = acpi_dev_powered_off_for_probe(&client->dev);
+	if (!powered_off) {
+		/* Check module identity */
+		ret = ov5670_identify_module(ov5670);
+		if (ret) {
+			err_msg = "ov5670_identify_module() error";
+			goto error_print;
+		}
 	}
 
 	mutex_init(&ov5670->mutex);
@@ -2500,11 +2504,9 @@ static int ov5670_probe(struct i2c_client *client)
 
 	ov5670->streaming = false;
 
-	/*
-	 * Device is already turned on by i2c-core with ACPI domain PM.
-	 * Enable runtime PM and turn off the device.
-	 */
-	pm_runtime_set_active(&client->dev);
+	/* Don't set the device's state to active if it's powered off. */
+	if (!powered_off)
+		pm_runtime_set_active(&client->dev);
 	pm_runtime_enable(&client->dev);
 	pm_runtime_idle(&client->dev);
 
@@ -2546,7 +2548,7 @@ static const struct dev_pm_ops ov5670_pm_ops = {
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id ov5670_acpi_ids[] = {
-	{"INT3479"},
+	{ "INT3479" },
 	{ /* sentinel */ }
 };
 
@@ -2556,6 +2558,7 @@ MODULE_DEVICE_TABLE(acpi, ov5670_acpi_ids);
 static struct i2c_driver ov5670_i2c_driver = {
 	.driver = {
 		.name = "ov5670",
+		.probe_powered_off = true,
 		.pm = &ov5670_pm_ops,
 		.acpi_match_table = ACPI_PTR(ov5670_acpi_ids),
 	},
-- 
2.11.0

