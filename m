Return-Path: <linux-acpi+bounces-19552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E64DCB62DF
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D2A304A280
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E6824EA90;
	Thu, 11 Dec 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0iX6Twj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C725EFB6;
	Thu, 11 Dec 2025 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462936; cv=none; b=tFiTDL2BTeZ+Xah42n+vKq6DtJrNmEwgjQqsMUOCp4TCEXgDalv/6iUPo0RwGdTOGXFUrmAoyROWVwe4Q5WXFOfdZMURWJOJJ06X6qHBAL0hwzCUJbNSUgIN6o1Q+Q3l60vb2RxLCcDgT1NUNfNyvjYf8Xh4qVSgxUu46y3awVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462936; c=relaxed/simple;
	bh=1/8SE652MvSeEaLNxWa90CR0QINdrStZTYLN2nRa0Kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVtrOxzFmUjtXSCTHpGfl8MRyGcuX81SKa3dE8WBNtzdrO3xYfR6p9MlOKKYlxLbSNW9ZX0wjVe9DD2VxvC5cnmFO63bDHUCFkeT7cWM+JVZYajaqUghr3RvW1fKoA657+su6iJ01oVpaDPi2Gg3mX62/rCZI0h3V2fxJDhu/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0iX6Twj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8343C4CEF7;
	Thu, 11 Dec 2025 14:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462935;
	bh=1/8SE652MvSeEaLNxWa90CR0QINdrStZTYLN2nRa0Kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0iX6TwjaGamO+1vd5XeFiy72YFbMH9pdKWEsRxOSF/zdUCdbBwXec9IDVepOmYjd
	 5awD3Br6k+g8XrTCe8Kq+mZaouaN3A/eXP5DN1ai+7Quex7T/OTnowuewEGeLplEVS
	 fXhMKqC2F740T9Nt52e43oEpBTbxmLjD1lLn5GEFkk6Ylpt6znb6DpQos989P4mXkn
	 AtHFAftchLW+4/3N3a+TsaGIa65xiPtfxRESZX6b0gXyqKOSBpvobTbKXGJEREYATi
	 Cfb+OLLkei2m9VH/Zq3XR18mzENhXi+7fYvHhzfNaXUfG8oqPRrCyfws2tpXQFew0G
	 QDhvMLAWIMBJA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [RFT][PATCH v1 4/6] ACPI: SBS: Convert the driver to a platform one
Date: Thu, 11 Dec 2025 15:18:33 +0100
Message-ID: <3390477.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5066996.31r3eYUQgx@rafael.j.wysocki>
References: <5066996.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

While binding drivers directly to struct acpi_device objects allows
basic functionality to be provided, at least in the majority of cases,
there are some problems with it, related to general consistency, sysfs
layout, power management operation ordering, and code cleanliness.

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the ACPI smart battery subsystem (SBS)
driver to a platform one.

After this conversion, acpi_smbus_hc_probe() does not need to populate the
driver_data pointer of the SMBUS HC platform device's ACPI companion any
more, so update it accordingly.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/sbs.c   |   48 +++++++++++++++++++++---------------------------
 drivers/acpi/sbshc.c |    2 --
 2 files changed, 21 insertions(+), 29 deletions(-)

--- a/drivers/acpi/sbs.c
+++ b/drivers/acpi/sbs.c
@@ -19,6 +19,7 @@
 #include <linux/timer.h>
 #include <linux/jiffies.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <linux/power_supply.h>
 #include <linux/platform_data/x86/apple.h>
 #include <acpi/battery.h>
@@ -95,7 +96,7 @@ struct acpi_sbs {
 
 #define to_acpi_sbs(x) power_supply_get_drvdata(x)
 
-static void acpi_sbs_remove(struct acpi_device *device);
+static void acpi_sbs_remove(struct platform_device *pdev);
 static int acpi_battery_get_state(struct acpi_battery *battery);
 
 static inline int battery_scale(int log)
@@ -628,8 +629,9 @@ static void acpi_sbs_callback(void *cont
 	}
 }
 
-static int acpi_sbs_add(struct acpi_device *device)
+static int acpi_sbs_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_sbs *sbs;
 	int result = 0;
 	int id;
@@ -642,11 +644,12 @@ static int acpi_sbs_add(struct acpi_devi
 
 	mutex_init(&sbs->lock);
 
-	sbs->hc = acpi_driver_data(acpi_dev_parent(device));
+	platform_set_drvdata(pdev, sbs);
+
+	sbs->hc = dev_get_drvdata(pdev->dev.parent);
 	sbs->device = device;
 	strscpy(acpi_device_name(device), ACPI_SBS_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_SBS_CLASS);
-	device->driver_data = sbs;
 
 	result = acpi_charger_add(sbs);
 	if (result && result != -ENODEV)
@@ -670,20 +673,15 @@ static int acpi_sbs_add(struct acpi_devi
 	acpi_smbus_register_callback(sbs->hc, acpi_sbs_callback, sbs);
 end:
 	if (result)
-		acpi_sbs_remove(device);
+		acpi_sbs_remove(pdev);
 	return result;
 }
 
-static void acpi_sbs_remove(struct acpi_device *device)
+static void acpi_sbs_remove(struct platform_device *pdev)
 {
-	struct acpi_sbs *sbs;
+	struct acpi_sbs *sbs = platform_get_drvdata(pdev);
 	int id;
 
-	if (!device)
-		return;
-	sbs = acpi_driver_data(device);
-	if (!sbs)
-		return;
 	mutex_lock(&sbs->lock);
 	acpi_smbus_unregister_callback(sbs->hc);
 	for (id = 0; id < MAX_SBS_BAT; ++id)
@@ -697,11 +695,7 @@ static void acpi_sbs_remove(struct acpi_
 #ifdef CONFIG_PM_SLEEP
 static int acpi_sbs_resume(struct device *dev)
 {
-	struct acpi_sbs *sbs;
-	if (!dev)
-		return -EINVAL;
-	sbs = to_acpi_device(dev)->driver_data;
-	acpi_sbs_callback(sbs);
+	acpi_sbs_callback(dev_get_drvdata(dev));
 	return 0;
 }
 #else
@@ -710,14 +704,14 @@ static int acpi_sbs_resume(struct device
 
 static SIMPLE_DEV_PM_OPS(acpi_sbs_pm, NULL, acpi_sbs_resume);
 
-static struct acpi_driver acpi_sbs_driver = {
-	.name = "sbs",
-	.class = ACPI_SBS_CLASS,
-	.ids = sbs_device_ids,
-	.ops = {
-		.add = acpi_sbs_add,
-		.remove = acpi_sbs_remove,
-		},
-	.drv.pm = &acpi_sbs_pm,
+static struct platform_driver acpi_sbs_driver = {
+	.probe = acpi_sbs_probe,
+	.remove = acpi_sbs_remove,
+	.driver = {
+		.name = "acpi-sbs",
+		.acpi_match_table = sbs_device_ids,
+		.pm = &acpi_sbs_pm,
+	},
 };
-module_acpi_driver(acpi_sbs_driver);
+
+module_platform_driver(acpi_sbs_driver);
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -265,8 +265,6 @@ static int acpi_smbus_hc_probe(struct pl
 	hc->ec = dev_get_drvdata(pdev->dev.parent);
 	hc->offset = (val >> 8) & 0xff;
 	hc->query_bit = val & 0xff;
-	/* This is needed for the SBS driver to work. */
-	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
 	dev_info(&device->dev, "SBS HC: offset = 0x%0x, query_bit = 0x%0x\n",




