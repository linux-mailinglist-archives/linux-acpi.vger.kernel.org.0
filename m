Return-Path: <linux-acpi+bounces-21251-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AvcHCQGo2lo9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21251-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:13:40 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE001C3D47
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:13:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 87A053080BB1
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A77A45BD4F;
	Sat, 28 Feb 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXF+isbH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F52D6E55;
	Sat, 28 Feb 2026 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291600; cv=none; b=RPxBTGAogD9CRgGNaj/bJvfxdYk1GD6MLXFKG1+tqzKLM/d3ac8Yq3hVsWmrKz5IYiVtfYgP/HwRPoF35XN7Hr6KL9iHme7Hugz3jQsEnKITkuv4cTDiUPltWUgb7A1vDxfz0mOLmfrG1K6PhbUc/sorUcebCmnHOOd/ZFrqPJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291600; c=relaxed/simple;
	bh=XPL4mqgLGY6vNY7l/llJntbpi1bJPU3tIaucVp4nHXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkqhmRrdpDSXPlBYQO5KQEBA+VArZeehE2dOiiRWtdpYr+mjlmT+aKqEU8wQl7xKBjomsgUuqpyQp3l5eitVOemYG3yzl00/kV5vFJexWKFfJ4DDbixnlgco4l+F2bYTAAODijaLfyGJiRsTQV7qd1r0aSKmRBraHwEhbJGvftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXF+isbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D992C2BC86;
	Sat, 28 Feb 2026 15:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291600;
	bh=XPL4mqgLGY6vNY7l/llJntbpi1bJPU3tIaucVp4nHXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZXF+isbHtYhzvCGvY2+TPkywV10vzLQVLvPj5t+TmAfuxhYVl3ReL/VpM2jNiZKpT
	 sTocNcvYvy+yP6pyNS1y4eVrNRmEZx0ej2usTQ7/hgFSHXaOb0Wh3SPfj6XHH7M6DX
	 gHYLXenrCRjfbvnuZhnddCvZuUbqofTmgoUn+bnW9jse8n2cdtCF08huCSsvXRKUzx
	 Amua396ILI5pDFz4FxH2/U8D1IGtQnBd34vU4TIqozMRca54jL8HKna3nTB952uX4r
	 WsbG/9Mv7iichHm+E+X54TuZhFPatUGfz6Xb8gF2ntz2hcNJVZg8EEmSerTXj7fRxw
	 OlBYFVPjVl5BQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>,
 Denis Benato <benato.denis96@gmail.com>,
 =?ISO-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>
Subject:
 [PATCH v1 2/4] platform/x86: asus-laptop: Convert ACPI driver to a platform
 one
Date: Sat, 28 Feb 2026 16:11:10 +0100
Message-ID: <2402539.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5971620.DvuYhMxLoT@rafael.j.wysocki>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-21251-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 1EE001C3D47
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Asus laptop ACPI driver to a platform
one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/asus-laptop.c | 35 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index c927665dfa96..dbbb6292cd11 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -1824,8 +1824,9 @@ static void asus_dmi_check(void)
 
 static bool asus_device_present;
 
-static int asus_acpi_add(struct acpi_device *device)
+static int asus_acpi_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct asus_laptop *asus;
 	int result;
 
@@ -1837,7 +1838,6 @@ static int asus_acpi_add(struct acpi_device *device)
 	asus->handle = device->handle;
 	strscpy(acpi_device_name(device), ASUS_LAPTOP_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ASUS_LAPTOP_CLASS);
-	device->driver_data = asus;
 	asus->device = device;
 
 	asus_dmi_check();
@@ -1846,6 +1846,8 @@ static int asus_acpi_add(struct acpi_device *device)
 	if (result)
 		goto fail_platform;
 
+	platform_set_drvdata(pdev, asus);
+
 	/*
 	 * Need platform type detection first, then the platform
 	 * device.  It is used as a parent for the sub-devices below.
@@ -1907,11 +1909,12 @@ static int asus_acpi_add(struct acpi_device *device)
 	return result;
 }
 
-static void asus_acpi_remove(struct acpi_device *device)
+static void asus_acpi_remove(struct platform_device *pdev)
 {
-	struct asus_laptop *asus = acpi_driver_data(device);
+	struct asus_laptop *asus = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acpi_notify);
+	acpi_dev_remove_notify_handler(asus->device, ACPI_DEVICE_NOTIFY,
+				       asus_acpi_notify);
 	asus_backlight_exit(asus);
 	asus_rfkill_exit(asus);
 	asus_led_exit(asus);
@@ -1930,15 +1933,13 @@ static const struct acpi_device_id asus_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, asus_device_ids);
 
-static struct acpi_driver asus_acpi_driver = {
-	.name = ASUS_LAPTOP_NAME,
-	.class = ASUS_LAPTOP_CLASS,
-	.ids = asus_device_ids,
-	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
-	.ops = {
-		.add = asus_acpi_add,
-		.remove = asus_acpi_remove,
-		},
+static struct platform_driver asus_acpi_driver = {
+	.probe = asus_acpi_probe,
+	.remove = asus_acpi_remove,
+	.driver = {
+		.name = ASUS_LAPTOP_NAME,
+		.acpi_match_table = asus_device_ids,
+	},
 };
 
 static int __init asus_laptop_init(void)
@@ -1949,7 +1950,7 @@ static int __init asus_laptop_init(void)
 	if (result < 0)
 		return result;
 
-	result = acpi_bus_register_driver(&asus_acpi_driver);
+	result = platform_driver_register(&asus_acpi_driver);
 	if (result < 0)
 		goto fail_acpi_driver;
 	if (!asus_device_present) {
@@ -1959,7 +1960,7 @@ static int __init asus_laptop_init(void)
 	return 0;
 
 fail_no_device:
-	acpi_bus_unregister_driver(&asus_acpi_driver);
+	platform_driver_unregister(&asus_acpi_driver);
 fail_acpi_driver:
 	platform_driver_unregister(&platform_driver);
 	return result;
@@ -1967,7 +1968,7 @@ static int __init asus_laptop_init(void)
 
 static void __exit asus_laptop_exit(void)
 {
-	acpi_bus_unregister_driver(&asus_acpi_driver);
+	platform_driver_unregister(&asus_acpi_driver);
 	platform_driver_unregister(&platform_driver);
 }
 
-- 
2.51.0





