Return-Path: <linux-acpi+bounces-21254-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBHMK2sHo2mg9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21254-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:19:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A51C3DC9
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88B5A3095264
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046E5466B6B;
	Sat, 28 Feb 2026 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pO3MQTA2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D586123C4F4;
	Sat, 28 Feb 2026 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772291943; cv=none; b=YauURE7TduZJ4+ThDAipXaEkkFCRp+PxYKOfknhXdkGwuNdgD8MzH89LNOU1Mosd153tq4f0uA4+UO/LmwFmy5TMEtT1za/PhuQfrctI9B9LjR+IVfZfvSQMzImvrIuZssz34MNW84bv+8m6R8nCGYuynXvwBJFKBgRHXmvnk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772291943; c=relaxed/simple;
	bh=Rr5TD5NdhUYjcoYr2ImaVRMfC03mmktXUBf4TRjvCp0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HK/wZht2PKs1GBhsynCUXTQdYVjLwYilJyyaUbKPuLyTHZMmTOBFzDyJXoFnMMuOdDmZWSLfulW65yLQ1AKYjI8KOxa4m3Lw2XkcLwBOmom5JH5F6uUBMbtQguZlcnAGrYGmsDBQinTZZGF85ej5S5ea/mmIqd5BvoJY16yR2N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pO3MQTA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893CAC2BC86;
	Sat, 28 Feb 2026 15:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772291943;
	bh=Rr5TD5NdhUYjcoYr2ImaVRMfC03mmktXUBf4TRjvCp0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pO3MQTA2ySwcnylR0pNsGm93L5F8XVh1HRDZeIArpf0zPGtgQgF9h/gZmpiMcUcuH
	 edou1xLEYlbBSCmPMu2VeuB6F/tJZyFNIX+qyiBmuV8DmPyB8ZCBjX1wmkKG6bqvZQ
	 qtXa8AKm2/6yiIZD0mk80dn327AgHjptr0lQK1gx40VcsI7x1oxa/V7DCILyAOfEHw
	 JfPYt4ayE741G2iMOkPw0fFP+UlJJnaGcyrO6TaPuZgX5d4PTFT5mLsD3Jz/LEQPSq
	 W3X+TGwgjAMTfFrEWSeAlTs29CHyHuZRuEbi+juap98iwjkwzUVwXiHKx9eW2w76CQ
	 kK05lTU0YPh2Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 2/2] platform/x86: acer-wireless: Convert ACPI driver to a platform
 one
Date: Sat, 28 Feb 2026 16:18:52 +0100
Message-ID: <2032103.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3406021.44csPzL39Z@rafael.j.wysocki>
References: <3406021.44csPzL39Z@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21254-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 537A51C3DC9
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Acer wireless ACPI driver to a platform
one.

After this change, the subordinate input device will be registered
under the platform device used for driver binding instead of its ACPI
companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/acer-wireless.c | 41 +++++++++++++++-------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/x86/acer-wireless.c b/drivers/platform/x86/acer-wireless.c
index f44d65d97023..f464b13a58af 100644
--- a/drivers/platform/x86/acer-wireless.c
+++ b/drivers/platform/x86/acer-wireless.c
@@ -10,6 +10,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci_ids.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 
 static const struct acpi_device_id acer_wireless_acpi_ids[] = {
@@ -20,12 +21,12 @@ MODULE_DEVICE_TABLE(acpi, acer_wireless_acpi_ids);
 
 static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *adev = data;
-	struct input_dev *idev = acpi_driver_data(adev);
+	struct device *dev = data;
+	struct input_dev *idev = dev_get_drvdata(dev);
 
-	dev_dbg(&adev->dev, "event=%#x\n", event);
+	dev_dbg(dev, "event=%#x\n", event);
 	if (event != 0x80) {
-		dev_notice(&adev->dev, "Unknown SMKB event: %#x\n", event);
+		dev_notice(dev, "Unknown SMKB event: %#x\n", event);
 		return;
 	}
 	input_report_key(idev, KEY_RFKILL, 1);
@@ -34,16 +35,16 @@ static void acer_wireless_notify(acpi_handle handle, u32 event, void *data)
 	input_sync(idev);
 }
 
-static int acer_wireless_add(struct acpi_device *adev)
+static int acer_wireless_probe(struct platform_device *pdev)
 {
 	struct input_dev *idev;
 	int ret;
 
-	idev = devm_input_allocate_device(&adev->dev);
+	idev = devm_input_allocate_device(&pdev->dev);
 	if (!idev)
 		return -ENOMEM;
 
-	adev->driver_data = idev;
+	platform_set_drvdata(pdev, idev);
 	idev->name = "Acer Wireless Radio Control";
 	idev->phys = "acer-wireless/input0";
 	idev->id.bustype = BUS_HOST;
@@ -56,26 +57,28 @@ static int acer_wireless_add(struct acpi_device *adev)
 	if (ret)
 		return ret;
 
-	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
-					       acer_wireless_notify, adev);
+	return acpi_dev_install_notify_handler(ACPI_COMPANION(&pdev->dev),
+					       ACPI_DEVICE_NOTIFY,
+					       acer_wireless_notify,
+					       &pdev->dev);
 }
 
-static void acer_wireless_remove(struct acpi_device *adev)
+static void acer_wireless_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY,
 				       acer_wireless_notify);
 }
 
-static struct acpi_driver acer_wireless_driver = {
-	.name = "Acer Wireless Radio Control Driver",
-	.class = "hotkey",
-	.ids = acer_wireless_acpi_ids,
-	.ops = {
-		.add = acer_wireless_add,
-		.remove = acer_wireless_remove,
+static struct platform_driver acer_wireless_driver = {
+	.probe = acer_wireless_probe,
+	.remove = acer_wireless_remove,
+	.driver = {
+		.name = "Acer Wireless Radio Control Driver",
+		.acpi_match_table = acer_wireless_acpi_ids,
 	},
 };
-module_acpi_driver(acer_wireless_driver);
+module_platform_driver(acer_wireless_driver);
 
 MODULE_DESCRIPTION("Acer Wireless Radio Control Driver");
 MODULE_AUTHOR("Chris Chiu <chiu@gmail.com>");
-- 
2.51.0





