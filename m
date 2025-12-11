Return-Path: <linux-acpi+bounces-19554-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 530D9CB6355
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34A1E3095AAF
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A2625B30D;
	Thu, 11 Dec 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j0KREb4H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBB256C6C;
	Thu, 11 Dec 2025 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462942; cv=none; b=e+wScr2HXswMuNZzYc4ZkbDgujXJIhJPRkXiZDUAVrlcIINCxet/Pnrtn32bA7eATzB8zd2X5DtwSGa/IrXRZRGlG/lFeLUDWFmIGQOsJOWA+XqpGcbdk7v3VyPEoyCTt9HLrpWyrEcAQjIw9d4I6acAkeTsFCfLvK3V57BXgYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462942; c=relaxed/simple;
	bh=W2EF82Cjj3+BHF9+YE3VgUwJ+FezTZ9RN5jcpkz29Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aKRmNPWDGN54dGL05Q+tuEGFk6E1PLekHWowKOha+odhqiSTLaCLk+3SQj7SUyObAxh2rRcz+Jqpk9LNMTyogNtWnZbUaFtNaqs9Gv3RWtmjztkAOg1hwxSutL46pWjs8Tv3cpUdl3CMDDstVFDv7DeNvUZ2rbaL35D2pqPym4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j0KREb4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CDCC19423;
	Thu, 11 Dec 2025 14:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462941;
	bh=W2EF82Cjj3+BHF9+YE3VgUwJ+FezTZ9RN5jcpkz29Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j0KREb4Hf04e+iFpG6abrd9jT8BXUs3TRq9K6XlcYeICjqQbok/nSi9DklSJG+wJo
	 azPNCR1CuWZA+zbeenemmQNvJRpD5POKZAq8i7AWX3PNXskgdzqD4TdlOFbRzJnaEq
	 fsVtJPb92LSlLL713g1VqwTztkXnjpPNJJf5tP6rPOxJMXTXsebOBSofa7gtPpydso
	 6VxnRSGM2V123v/KXv0ywAekOpSI5b7Z6L1uYpzDkFHUCRl4RiEX6kT8OC/bElNafl
	 OXT83Tvza5tyVhy1KtJHj8GVqYrP9jW1w4l59f2ltcVgCSpkK3FnRuiDjVhUiD88Bf
	 qIh6FVgxGnTLw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [RFT][PATCH v1 2/6] ACPI: EC: Convert the driver to a platform one
Date: Thu, 11 Dec 2025 15:17:23 +0100
Message-ID: <1946304.tdWV9SEqCh@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI embedded controller (EC) driver
to a platform one.

After this conversion, acpi_bus_register_early_device() does not need
to attempt to bind an ACPI driver to the struct acpi_device created by
it, so update it accordingly.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/ec.c   |   54 ++++++++++++++++++++--------------------------------
 drivers/acpi/scan.c |    6 +----
 2 files changed, 23 insertions(+), 37 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
@@ -1674,8 +1675,9 @@ static int acpi_ec_setup(struct acpi_ec
 	return ret;
 }
 
-static int acpi_ec_add(struct acpi_device *device)
+static int acpi_ec_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_ec *ec;
 	int ret;
 
@@ -1730,6 +1732,8 @@ static int acpi_ec_add(struct acpi_devic
 	acpi_handle_info(ec->handle,
 			 "EC: Used to handle transactions and events\n");
 
+	platform_set_drvdata(pdev, ec);
+	/* This is needed for the SMBUS HC driver to work. */
 	device->driver_data = ec;
 
 	ret = !!request_region(ec->data_addr, 1, "EC data");
@@ -1750,14 +1754,11 @@ err:
 	return ret;
 }
 
-static void acpi_ec_remove(struct acpi_device *device)
+static void acpi_ec_remove(struct platform_device *pdev)
 {
-	struct acpi_ec *ec;
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+	struct acpi_ec *ec = platform_get_drvdata(pdev);
 
-	if (!device)
-		return;
-
-	ec = acpi_driver_data(device);
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
 	device->driver_data = NULL;
@@ -2095,8 +2096,7 @@ out:
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ec_suspend(struct device *dev)
 {
-	struct acpi_ec *ec =
-		acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ec *ec = dev_get_drvdata(dev);
 
 	if (!pm_suspend_no_platform() && ec_freeze_events)
 		acpi_ec_disable_event(ec);
@@ -2105,7 +2105,7 @@ static int acpi_ec_suspend(struct device
 
 static int acpi_ec_suspend_noirq(struct device *dev)
 {
-	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ec *ec = dev_get_drvdata(dev);
 
 	/*
 	 * The SCI handler doesn't run at this point, so the GPE can be
@@ -2122,7 +2122,7 @@ static int acpi_ec_suspend_noirq(struct
 
 static int acpi_ec_resume_noirq(struct device *dev)
 {
-	struct acpi_ec *ec = acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ec *ec = dev_get_drvdata(dev);
 
 	acpi_ec_leave_noirq(ec);
 
@@ -2135,8 +2135,7 @@ static int acpi_ec_resume_noirq(struct d
 
 static int acpi_ec_resume(struct device *dev)
 {
-	struct acpi_ec *ec =
-		acpi_driver_data(to_acpi_device(dev));
+	struct acpi_ec *ec = dev_get_drvdata(dev);
 
 	acpi_ec_enable_event(ec);
 	return 0;
@@ -2265,15 +2264,14 @@ module_param_call(ec_event_clearing, par
 		  NULL, 0644);
 MODULE_PARM_DESC(ec_event_clearing, "Assumed SCI_EVT clearing timing");
 
-static struct acpi_driver acpi_ec_driver = {
-	.name = "ec",
-	.class = ACPI_EC_CLASS,
-	.ids = ec_device_ids,
-	.ops = {
-		.add = acpi_ec_add,
-		.remove = acpi_ec_remove,
-		},
-	.drv.pm = &acpi_ec_pm,
+static struct platform_driver acpi_ec_driver = {
+	.probe = acpi_ec_probe,
+	.remove = acpi_ec_remove,
+	.driver = {
+		.name = "acpi-ec",
+		.acpi_match_table = ec_device_ids,
+		.pm = &acpi_ec_pm,
+	},
 };
 
 static void acpi_ec_destroy_workqueues(void)
@@ -2378,17 +2376,7 @@ void __init acpi_ec_init(void)
 	}
 
 	/* Driver must be registered after acpi_ec_init_workqueues(). */
-	acpi_bus_register_driver(&acpi_ec_driver);
+	platform_driver_register(&acpi_ec_driver);
 
 	acpi_ec_ecdt_start();
 }
-
-/* EC driver currently not unloadable */
-#if 0
-static void __exit acpi_ec_exit(void)
-{
-
-	acpi_bus_unregister_driver(&acpi_ec_driver);
-	acpi_ec_destroy_workqueues();
-}
-#endif	/* 0 */
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2643,10 +2643,8 @@ int acpi_bus_register_early_device(int t
 	if (result)
 		return result;
 
-	acpi_default_enumeration(device);
-
-	device->flags.match_driver = true;
-	return device_attach(&device->dev);
+	acpi_default_enumeration(device);;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(acpi_bus_register_early_device);
 




