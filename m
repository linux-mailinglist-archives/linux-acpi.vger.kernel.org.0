Return-Path: <linux-acpi+bounces-21353-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIQ1H0mAqGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21353-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:56:09 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08416206B29
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AE4B33019454
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDD83D75BC;
	Wed,  4 Mar 2026 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XR4rE5tw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A233D5242;
	Wed,  4 Mar 2026 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772650541; cv=none; b=FS0lJattrsRNfaXMlJuhZstuQpgR/1BdaCY5aczivjeQOIKdbPTv82LBji+bmrtab25Lw3ytu4EsnvFSzwO1+gD9Aykbj0lncpYtn3tYLG4SFSWqUnCwG+V4w5IP7oN77wC9zu7Cz/1RXT0CeorsqL7DV60hen8wzObtzH3dS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772650541; c=relaxed/simple;
	bh=xlOHgIlUqmA12gHHyGdbJEDXoCNvppKOR28aBmcxNto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W4U43UQuactJ5012p8XWkaVRZk5dJUpCoUsPCbXzOegnXwTn8a/KHEaDY+bsmisoYpZoEmmGGtFh9KOZD/loRVvIi4+kPgFF1SuUWVFNI5xq9PIMGR0OpUazuYDQJCP+UEdfz7ZQsLS0OfHbaKFZrnYfGi4FNIVo6lf94mp5yWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XR4rE5tw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E8A3C2BC9E;
	Wed,  4 Mar 2026 18:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772650540;
	bh=xlOHgIlUqmA12gHHyGdbJEDXoCNvppKOR28aBmcxNto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XR4rE5twdqlrxeFlAxql36uzHVbcFdfwcf/we7RPyn5w9gWwNGjBQrTtpqcRzu357
	 ChcLldZdP7PTy0yy32CrzO0o74ScZ8E2Hxbxd61ufLqPK5pNGm8AknZo8NFM5lRERk
	 thuwEArIxMNxOxwaLET/cuiV0ibudNUtDX5OBVTz5+a6aQ6jpPiPySa1LBllIib8Bw
	 QNEhQi2aQ50L/SRXRzUuEkAaWI9IJ9CBKwAW+P4VdeZUrxJJX4HWfiLA3AAb2A0RwX
	 zh89XS5jlR1VvKqN8o/pEj3RLPRvH1dfcFyRQA4akFCgNCeDeUKZ/LNhEZ1icFbVXF
	 evAUrAa0H91CA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 3/3] platform/surface: surfacepro3_button: Convert to a platform
 driver
Date: Wed, 04 Mar 2026 19:55:28 +0100
Message-ID: <3207406.CbtlEUcBR6@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2909929.BEx9A2HvPv@rafael.j.wysocki>
References: <2909929.BEx9A2HvPv@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 08416206B29
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21353-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Surface Pro 3 button ACPI driver to a
platform one.

After this change, the subordinate input device and wakeup source class
device will be registered under the platform device used for driver
binding instead of its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/surface/surfacepro3_button.c | 67 +++++++++----------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/surface/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
index 6d394daf5bc4..0293bc517b54 100644
--- a/drivers/platform/surface/surfacepro3_button.c
+++ b/drivers/platform/surface/surfacepro3_button.c
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/input.h>
 #include <linux/acpi.h>
+#include <linux/platform_device.h>
 #include <acpi/button.h>
 
 #define SURFACE_PRO3_BUTTON_HID		"MSHW0028"
@@ -74,8 +75,8 @@ struct surface_button {
 
 static void surface_button_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct surface_button *button = acpi_driver_data(device);
+	struct device *dev = data;
+	struct surface_button *button = dev_get_drvdata(dev);
 	struct input_dev *input;
 	int key_code = KEY_RESERVED;
 	bool pressed = false;
@@ -110,18 +111,17 @@ static void surface_button_notify(acpi_handle handle, u32 event, void *data)
 		key_code = KEY_VOLUMEDOWN;
 		break;
 	case SURFACE_BUTTON_NOTIFY_TABLET_MODE:
-		dev_warn_once(&device->dev, "Tablet mode is not supported\n");
+		dev_warn_once(dev, "Tablet mode is not supported\n");
 		break;
 	default:
-		dev_info_ratelimited(&device->dev,
-				     "Unsupported event [0x%x]\n", event);
+		dev_info_ratelimited(dev, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 	input = button->input;
 	if (key_code == KEY_RESERVED)
 		return;
 	if (pressed)
-		pm_wakeup_dev_event(&device->dev, 0, button->suspended);
+		pm_wakeup_dev_event(dev, 0, button->suspended);
 	if (button->suspended)
 		return;
 	input_report_key(input, key_code, pressed?1:0);
@@ -131,8 +131,7 @@ static void surface_button_notify(acpi_handle handle, u32 event, void *data)
 #ifdef CONFIG_PM_SLEEP
 static int surface_button_suspend(struct device *dev)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct surface_button *button = acpi_driver_data(device);
+	struct surface_button *button = dev_get_drvdata(dev);
 
 	button->suspended = true;
 	return 0;
@@ -140,8 +139,7 @@ static int surface_button_suspend(struct device *dev)
 
 static int surface_button_resume(struct device *dev)
 {
-	struct acpi_device *device = to_acpi_device(dev);
-	struct surface_button *button = acpi_driver_data(device);
+	struct surface_button *button = dev_get_drvdata(dev);
 
 	button->suspended = false;
 	return 0;
@@ -156,9 +154,8 @@ static int surface_button_resume(struct device *dev)
  * Returns true if the driver should bind to this device, i.e. the device is
  * either MSWH0028 (Pro 3) or MSHW0040 on a Pro 4 or Book 1.
  */
-static bool surface_button_check_MSHW0040(struct acpi_device *dev)
+static bool surface_button_check_MSHW0040(struct device *dev, acpi_handle handle)
 {
-	acpi_handle handle = dev->handle;
 	union acpi_object *result;
 	u64 oem_platform_rev = 0;	// valid revisions are nonzero
 
@@ -180,14 +177,15 @@ static bool surface_button_check_MSHW0040(struct acpi_device *dev)
 		ACPI_FREE(result);
 	}
 
-	dev_dbg(&dev->dev, "OEM Platform Revision %llu\n", oem_platform_rev);
+	dev_dbg(dev, "OEM Platform Revision %llu\n", oem_platform_rev);
 
 	return oem_platform_rev == 0;
 }
 
 
-static int surface_button_add(struct acpi_device *device)
+static int surface_button_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct surface_button *button;
 	struct input_dev *input;
 	const char *hid = acpi_device_hid(device);
@@ -197,14 +195,14 @@ static int surface_button_add(struct acpi_device *device)
 	    strlen(SURFACE_BUTTON_OBJ_NAME)))
 		return -ENODEV;
 
-	if (!surface_button_check_MSHW0040(device))
+	if (!surface_button_check_MSHW0040(&pdev->dev, device->handle))
 		return -ENODEV;
 
 	button = kzalloc_obj(struct surface_button);
 	if (!button)
 		return -ENOMEM;
 
-	device->driver_data = button;
+	platform_set_drvdata(pdev, button);
 	button->input = input = input_allocate_device();
 	if (!input) {
 		error = -ENOMEM;
@@ -217,7 +215,7 @@ static int surface_button_add(struct acpi_device *device)
 	input->name = acpi_device_name(device);
 	input->phys = button->phys;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &device->dev;
+	input->dev.parent = &pdev->dev;
 	input_set_capability(input, EV_KEY, KEY_POWER);
 	input_set_capability(input, EV_KEY, KEY_LEFTMETA);
 	input_set_capability(input, EV_KEY, KEY_VOLUMEUP);
@@ -227,17 +225,17 @@ static int surface_button_add(struct acpi_device *device)
 	if (error)
 		goto err_free_input;
 
-	device_init_wakeup(&device->dev, true);
+	device_init_wakeup(&pdev->dev, true);
 
 	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-						surface_button_notify, device);
+						surface_button_notify, &pdev->dev);
 	if (error) {
-		device_init_wakeup(&device->dev, false);
+		device_init_wakeup(&pdev->dev, false);
 		input_unregister_device(input);
 		goto err_free_button;
 	}
 
-	dev_info(&device->dev, "%s [%s]\n", acpi_device_name(device),
+	dev_info(&pdev->dev, "%s [%s]\n", acpi_device_name(device),
 		 acpi_device_bid(device));
 	return 0;
 
@@ -248,13 +246,13 @@ static int surface_button_add(struct acpi_device *device)
 	return error;
 }
 
-static void surface_button_remove(struct acpi_device *device)
+static void surface_button_remove(struct platform_device *pdev)
 {
-	struct surface_button *button = acpi_driver_data(device);
+	struct surface_button *button = platform_get_drvdata(pdev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
-				       surface_button_notify);
-	device_init_wakeup(&device->dev, false);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, surface_button_notify);
+	device_init_wakeup(&pdev->dev, false);
 	input_unregister_device(button->input);
 	kfree(button);
 }
@@ -262,15 +260,14 @@ static void surface_button_remove(struct acpi_device *device)
 static SIMPLE_DEV_PM_OPS(surface_button_pm,
 		surface_button_suspend, surface_button_resume);
 
-static struct acpi_driver surface_button_driver = {
-	.name = "surface_pro3_button",
-	.class = "SurfacePro3",
-	.ids = surface_button_device_ids,
-	.ops = {
-		.add = surface_button_add,
-		.remove = surface_button_remove,
+static struct platform_driver surface_button_driver = {
+	.probe = surface_button_probe,
+	.remove = surface_button_remove,
+	.driver = {
+		.name = "surface_pro3_button",
+		.acpi_match_table = surface_button_device_ids,
+		.pm = &surface_button_pm,
 	},
-	.drv.pm = &surface_button_pm,
 };
 
-module_acpi_driver(surface_button_driver);
+module_platform_driver(surface_button_driver);
-- 
2.51.0





