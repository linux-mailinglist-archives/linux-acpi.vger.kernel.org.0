Return-Path: <linux-acpi+bounces-19551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE7ECB62D3
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 15:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B788C301AB14
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Dec 2025 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC92625B31B;
	Thu, 11 Dec 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8iQ3UV0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9111325A334;
	Thu, 11 Dec 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765462933; cv=none; b=LdhqEoEIKhzB70KIWOWWQbfnkCfT/2lFc1b2LaGxq3fQaxBty0ebruKU+Z1IX8n4yBJcHjC33fLaSNYxRD9GeyIFQl0xUg5VbmJOf2BdCHTW88vFHjXdkhxHWXka5oz30mvyjKdfy8oLfGKAdPlEoKkWx+I19oQ86OekA7DNuw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765462933; c=relaxed/simple;
	bh=C4eck/j/A8pgk0VowI5vbISPy+4ZHMAlnKPAAHQgCeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xq3ZqDN5j9btSraVbKLJfMopW7s0mxEdjEj+EHyuk60kaIRXKsLJiDURayimBqWMx+DuvE6/80fLazoEgLHM/cP4qZiySiyWQY0lVKQdsx7/RdnHcjUUf1UmLZ4+1NympmFhbE2IRJx0qS6KxAaljwbiEMkbH0H9LuhOTA0I1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8iQ3UV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE00C113D0;
	Thu, 11 Dec 2025 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765462933;
	bh=C4eck/j/A8pgk0VowI5vbISPy+4ZHMAlnKPAAHQgCeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b8iQ3UV0VCfvugokQPy58+1f9zd/h4QGA6T3HtBiqfL5G0t6n0wUTQ+53qA0vZYnB
	 TxcgIvvBMkhSFSanAu6SvhkeyTGhmU4NxZI6fuStp3A/c2oVhvRzyKjejDzZJZZ7M2
	 OxiPobOx6WNXT6iKgNi7dv3IKb7zwy2o6jGp4hBI/t1k0hAUzF/sGqomDNe5AX4JMe
	 Jkuxp/fZUQxgfBjF5d7BBGzeUJb3l9ngraf0Q5neacHNDrwJgAPgnEkAdegcBr1xfq
	 42qKNLmHxYTT1sg8kamWftbv23nzprt/d7B2pMfILgotjGH7msItnVr3EOGceV5fH0
	 z8LahKZ/weZkQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>, Hans de Goede <hansg@kernel.org>
Subject: [RFT][PATCH v1 5/6] ACPI: HED: Convert the driver to a platform one
Date: Thu, 11 Dec 2025 15:19:08 +0100
Message-ID: <8620378.T7Z3S40VBb@rafael.j.wysocki>
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
ACPI companions, so convert the ACPI hardware error device (HED) driver
to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/hed.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/acpi/hed.c
+++ b/drivers/acpi/hed.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <acpi/hed.h>
 
 static const struct acpi_device_id acpi_hed_ids[] = {
@@ -47,8 +48,9 @@ static void acpi_hed_notify(acpi_handle
 	blocking_notifier_call_chain(&acpi_hed_notify_list, 0, NULL);
 }
 
-static int acpi_hed_add(struct acpi_device *device)
+static int acpi_hed_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	int err;
 
 	/* Only one hardware error device */
@@ -64,26 +66,27 @@ static int acpi_hed_add(struct acpi_devi
 	return err;
 }
 
-static void acpi_hed_remove(struct acpi_device *device)
+static void acpi_hed_remove(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
 	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
 				       acpi_hed_notify);
 	hed_handle = NULL;
 }
 
-static struct acpi_driver acpi_hed_driver = {
-	.name = "hardware_error_device",
-	.class = "hardware_error",
-	.ids = acpi_hed_ids,
-	.ops = {
-		.add = acpi_hed_add,
-		.remove = acpi_hed_remove,
+static struct platform_driver acpi_hed_driver = {
+	.probe = acpi_hed_probe,
+	.remove = acpi_hed_remove,
+	.driver = {
+		.name = "acpi-hardware-error-device",
+		.acpi_match_table = acpi_hed_ids,
 	},
 };
 
 static int __init acpi_hed_driver_init(void)
 {
-	return acpi_bus_register_driver(&acpi_hed_driver);
+	return platform_driver_register(&acpi_hed_driver);
 }
 subsys_initcall(acpi_hed_driver_init);
 




