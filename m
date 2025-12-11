Return-Path: <linux-acpi+bounces-19553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED5FCB6352
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 196553089722
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323E52550DD;
	Thu, 11 Dec 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts9qwkmC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406C2727F5;
	Thu, 11 Dec 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462939; cv=none; b=thy6ngR0UQnSIql6uTff87oVb64wc//MxnB0CU+SeIqWUyMm0Q9JPXVJC1UF89Yd0yHxNukABY3D5eZBjhq/n3DPUkeetPQtwKEH8JaRSNin9WEi4szqWIHvAyWHek55bt4rSO0rAWpBHq0n+4iwdFFXmyBFz3SDOc6CR/EaX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462939; c=relaxed/simple;
	bh=lwmdgimdxLKUafRbbMz1KWXXUFLSaf7P7PJIeIKBRrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rby0aKfQKiFbktu70Jl+MDY9O2boENQi76cOT/SZ5dmFBesRgMIWBVl94N9G3ywxnBYvGI+Yt3Ns4polMF42PtDZhcW46kp9/YCwMwNnx7FrTeBrUeIoXL/9lfEQohvlFvirWHxxY+e5TQJti36YIBAf2USTAM7QcyRVEMhnohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts9qwkmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA709C113D0;
	Thu, 11 Dec 2025 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462938;
	bh=lwmdgimdxLKUafRbbMz1KWXXUFLSaf7P7PJIeIKBRrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ts9qwkmCPni7zX64fIF6Mx/CRp9BO1n3C7KwkJ9sLoIgLjmtJjH7My8ftvE9YbqA1
	 fPgnz0kcgE2V6ayfRdUpOnjSphybhg1vRloVJxvUoEZsQfVEGMv4y6zJtxEqhQuHDn
	 XsufzZsh5c/1i/ulDe0nDJaJqNgVj7YZh3sF/NwOJ1h0Y/jnAUWae+OBwsptPtuZun
	 aMlyGsRLwhG5b80G0VDrlTNqqHJpSQQlwlO8YzBNqISuCkO8nTV56hragQr6aKyiIJ
	 lx5939GqVSbASzOPo6vJ2b9dIWBUddH5JIftmj4GoPCPlPkkx7YXt9LfWABT9k2sC4
	 mhqAriRDbeB9g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject:
 [RFT][PATCH v1 3/6] ACPI: SMBUS HC: Convert the driver to a platform one
Date: Thu, 11 Dec 2025 15:17:58 +0100
Message-ID: <13909645.uLZWGnKmhe@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI SMBUS HC driver to a platform one.

After this conversion, acpi_ec_probe() does not need to populate the
driver_data pointer of the EC platform device's ACPI companion any
more, so update it accordingly.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c    |    2 --
 drivers/acpi/sbshc.c |   43 +++++++++++++++++++++----------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1733,8 +1733,6 @@ static int acpi_ec_probe(struct platform
 			 "EC: Used to handle transactions and events\n");
 
 	platform_set_drvdata(pdev, ec);
-	/* This is needed for the SMBUS HC driver to work. */
-	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
 	WARN(!ret, "Could not request EC data io port 0x%lx", ec->data_addr);
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -13,6 +13,8 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
 #include "sbshc.h"
 #include "internal.h"
 
@@ -30,8 +32,8 @@ struct acpi_smb_hc {
 	bool done;
 };
 
-static int acpi_smbus_hc_add(struct acpi_device *device);
-static void acpi_smbus_hc_remove(struct acpi_device *device);
+static int acpi_smbus_hc_probe(struct platform_device *pdev);
+static void acpi_smbus_hc_remove(struct platform_device *pdev);
 
 static const struct acpi_device_id sbs_device_ids[] = {
 	{"ACPI0001", 0},
@@ -41,14 +43,13 @@ static const struct acpi_device_id sbs_d
 
 MODULE_DEVICE_TABLE(acpi, sbs_device_ids);
 
-static struct acpi_driver acpi_smb_hc_driver = {
-	.name = "smbus_hc",
-	.class = ACPI_SMB_HC_CLASS,
-	.ids = sbs_device_ids,
-	.ops = {
-		.add = acpi_smbus_hc_add,
-		.remove = acpi_smbus_hc_remove,
-		},
+static struct platform_driver acpi_smb_hc_driver = {
+	.probe = acpi_smbus_hc_probe,
+	.remove = acpi_smbus_hc_remove,
+	.driver = {
+		.name = "acpi-smbus-hc",
+		.acpi_match_table = sbs_device_ids,
+	},
 };
 
 union acpi_smb_status {
@@ -237,15 +238,13 @@ static int smbus_alarm(void *context)
 	return 0;
 }
 
-static int acpi_smbus_hc_add(struct acpi_device *device)
+static int acpi_smbus_hc_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	int status;
 	unsigned long long val;
 	struct acpi_smb_hc *hc;
 
-	if (!device)
-		return -EINVAL;
-
 	status = acpi_evaluate_integer(device->handle, "_EC", NULL, &val);
 	if (ACPI_FAILURE(status)) {
 		pr_err("error obtaining _EC.\n");
@@ -261,9 +260,12 @@ static int acpi_smbus_hc_add(struct acpi
 	mutex_init(&hc->lock);
 	init_waitqueue_head(&hc->wait);
 
-	hc->ec = acpi_driver_data(acpi_dev_parent(device));
+	platform_set_drvdata(pdev, hc);
+
+	hc->ec = dev_get_drvdata(pdev->dev.parent);
 	hc->offset = (val >> 8) & 0xff;
 	hc->query_bit = val & 0xff;
+	/* This is needed for the SBS driver to work. */
 	device->driver_data = hc;
 
 	acpi_ec_add_query_handler(hc->ec, hc->query_bit, NULL, smbus_alarm, hc);
@@ -273,21 +275,18 @@ static int acpi_smbus_hc_add(struct acpi
 	return 0;
 }
 
-static void acpi_smbus_hc_remove(struct acpi_device *device)
+static void acpi_smbus_hc_remove(struct platform_device *pdev)
 {
-	struct acpi_smb_hc *hc;
-
-	if (!device)
-		return;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_smb_hc *hc = platform_get_drvdata(pdev);
 
-	hc = acpi_driver_data(device);
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	acpi_os_wait_events_complete();
 	kfree(hc);
 	device->driver_data = NULL;
 }
 
-module_acpi_driver(acpi_smb_hc_driver);
+module_platform_driver(acpi_smb_hc_driver);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexey Starikovskiy");




