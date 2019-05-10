Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2E19B0C
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2019 12:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfEJKJb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 10 May 2019 06:09:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:51551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbfEJKJ2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 10 May 2019 06:09:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 May 2019 03:09:27 -0700
X-ExtLoop1: 1
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga008.fm.intel.com with ESMTP; 10 May 2019 03:09:26 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTPS id 3B44D201EF;
        Fri, 10 May 2019 13:09:26 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1hP2T7-0003p6-2J; Fri, 10 May 2019 13:09:33 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     linux-acpi@vger.kernel.org
Cc:     rajmohan.mani@intel.com, linux-media@vger.kernel.org
Subject: [PATCH 4/5] media: i2c: imx319: Support probe while the device is off
Date:   Fri, 10 May 2019 13:09:29 +0300
Message-Id: <20190510100930.14641-5-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
References: <20190510100930.14641-1-sakari.ailus@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Rajmohan Mani <rajmohan.mani@intel.com>

Tell ACPI device PM code that the driver supports the device being powered
off when the driver's probe function is entered.

Signed-off-by: Rajmohan Mani <rajmohan.mani@intel.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/media/i2c/imx319.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/media/i2c/imx319.c b/drivers/media/i2c/imx319.c
index 17c2e4b41221e..e929de86a8e22 100644
--- a/drivers/media/i2c/imx319.c
+++ b/drivers/media/i2c/imx319.c
@@ -2424,6 +2424,7 @@ static struct imx319_hwcfg *imx319_get_hwcfg(struct device *dev)
 static int imx319_probe(struct i2c_client *client)
 {
 	struct imx319 *imx319;
+	bool powered_off;
 	int ret;
 	u32 i;
 
@@ -2436,11 +2437,14 @@ static int imx319_probe(struct i2c_client *client)
 	/* Initialize subdev */
 	v4l2_i2c_subdev_init(&imx319->sd, client, &imx319_subdev_ops);
 
-	/* Check module identity */
-	ret = imx319_identify_module(imx319);
-	if (ret) {
-		dev_err(&client->dev, "failed to find sensor: %d", ret);
-		goto error_probe;
+	powered_off = acpi_dev_powered_off_for_probe(&client->dev);
+	if (!powered_off) {
+		/* Check module identity */
+		ret = imx319_identify_module(imx319);
+		if (ret) {
+			dev_err(&client->dev, "failed to find sensor: %d", ret);
+			goto error_probe;
+		}
 	}
 
 	imx319->hwcfg = imx319_get_hwcfg(&client->dev);
@@ -2492,11 +2496,9 @@ static int imx319_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto error_media_entity;
 
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
 
@@ -2536,7 +2538,7 @@ static const struct dev_pm_ops imx319_pm_ops = {
 };
 
 static const struct acpi_device_id imx319_acpi_ids[] = {
-	{ "SONY319A" },
+	{ "SONY319A", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(acpi, imx319_acpi_ids);
@@ -2544,6 +2546,7 @@ MODULE_DEVICE_TABLE(acpi, imx319_acpi_ids);
 static struct i2c_driver imx319_i2c_driver = {
 	.driver = {
 		.name = "imx319",
+		.probe_powered_off = true,
 		.pm = &imx319_pm_ops,
 		.acpi_match_table = ACPI_PTR(imx319_acpi_ids),
 	},
-- 
2.11.0

