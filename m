Return-Path: <linux-acpi+bounces-21558-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMxRKzMAr2kLLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21558-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:15:31 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 200BF23D7FC
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12BE13008793
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C03B8BC4;
	Mon,  9 Mar 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bp2Yk19I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5BF4FA;
	Mon,  9 Mar 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076286; cv=none; b=fMp0GG5+kG3wD1Li/4EXxOSolPL5GeLmNL47WwqqYqPY46ANkFccqbw5RtYlpKOEKg8x89nx5l4tabk4cFfAaX3oKziDvWwnt+eQftcg3jwd23hHuyc5Edkiy0jCcq4SlBYKQfQuRtTBh4L+UAZa7O5czTd0AUA7uzKAyb6UngQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076286; c=relaxed/simple;
	bh=lwFUyCFNfLj6i8UXbxMhxL+LzqZHguq3Q9TpRinR5Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPV1y6Of/vFOyHGxkMbdUKRur1m9fCN4+X4N0wfEBGjckg67UqeObGtO8h/63rpe6YX3VvKWTEtSsuXcF5IuIg1VxjMp2IRMgQ7GmxfUo61cP+ix1nPeUyfUb+/7kCitO4//CNXKOjOwAzFHDtBvFcq9lKZM6zAObDnK5vcTIv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bp2Yk19I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DEEC4CEF7;
	Mon,  9 Mar 2026 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076285;
	bh=lwFUyCFNfLj6i8UXbxMhxL+LzqZHguq3Q9TpRinR5Iw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bp2Yk19IoVbxpy022atIf9F1djsyjDKKqyPEBsAxyBi/qiGoaagbJTCy79jBpTezv
	 UTf8Svm5bh48/rVR3BdYL4dE2l7nhcPHPid/n/Q0vlXIS6EvUyRlmJtDtoDrvfxoZs
	 wPxN6PcFOLJ5hpytqqJ7Lc2Q3OfWloA1zwfzAFK3hrQwbED22LqD1d5y3/sOIlaqUd
	 g/jH5hx9uOXUdnv1nHt+ofjJkr9VnaQoHkeXp3bLXVPE7wPLsfGgVqF7OfBTVUalr+
	 mxxQ49WQPHOcJroGODxxmLO5qu/JGSPS0ZQZ4q8SuV43t5s92f/eG04ZppDCoNkpFB
	 3E3xnoAad0PPg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 4/5] platform/x86: fujitsu: Convert backlight driver to a platform
 one
Date: Mon, 09 Mar 2026 18:10:27 +0100
Message-ID: <8663859.T7Z3S40VBb@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12863082.O9o76ZdvQC@rafael.j.wysocki>
References: <12863082.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 200BF23D7FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21558-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the backlight part of the Fujitsu laptop
driver from an ACPI driver to a platform one.

After this change, the backlight and input subordinate devices will be
registered under the platform device used for driver binding instead of
its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/platform/x86/fujitsu-laptop.c | 117 +++++++++++++-------------
 1 file changed, 58 insertions(+), 59 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 7816a867a60c..b40260315f1e 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -284,15 +284,16 @@ static void fujitsu_battery_charge_control_remove(struct acpi_device *device)
 
 /* Hardware access for LCD brightness control */
 
-static int set_lcd_level(struct acpi_device *device, int level)
+static int set_lcd_level(struct device *dev, int level)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	acpi_status status;
 	char *method;
 
 	switch (use_alt_lcd_levels) {
 	case -1:
-		if (acpi_has_method(device->handle, "SBL2"))
+		if (acpi_has_method(handle, "SBL2"))
 			method = "SBL2";
 		else
 			method = "SBLL";
@@ -305,16 +306,14 @@ static int set_lcd_level(struct acpi_device *device, int level)
 		break;
 	}
 
-	acpi_handle_debug(device->handle, "set lcd level via %s [%d]\n", method,
-			  level);
+	acpi_handle_debug(handle, "set lcd level via %s [%d]\n", method, level);
 
 	if (level < 0 || level >= priv->max_brightness)
 		return -EINVAL;
 
-	status = acpi_execute_simple_method(device->handle, method, level);
+	status = acpi_execute_simple_method(handle, method, level);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(device->handle, "Failed to evaluate %s\n",
-				method);
+		acpi_handle_err(handle, "Failed to evaluate %s\n", method);
 		return -ENODEV;
 	}
 
@@ -323,15 +322,16 @@ static int set_lcd_level(struct acpi_device *device, int level)
 	return 0;
 }
 
-static int get_lcd_level(struct acpi_device *device)
+static int get_lcd_level(struct device *dev)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	unsigned long long state = 0;
 	acpi_status status = AE_OK;
 
-	acpi_handle_debug(device->handle, "get lcd level via GBLL\n");
+	acpi_handle_debug(handle, "get lcd level via GBLL\n");
 
-	status = acpi_evaluate_integer(device->handle, "GBLL", NULL, &state);
+	status = acpi_evaluate_integer(handle, "GBLL", NULL, &state);
 	if (ACPI_FAILURE(status))
 		return 0;
 
@@ -340,15 +340,16 @@ static int get_lcd_level(struct acpi_device *device)
 	return priv->brightness_level;
 }
 
-static int get_max_brightness(struct acpi_device *device)
+static int get_max_brightness(struct device *dev)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
+	acpi_handle handle = ACPI_HANDLE(dev);
 	unsigned long long state = 0;
 	acpi_status status = AE_OK;
 
-	acpi_handle_debug(device->handle, "get max lcd level via RBLL\n");
+	acpi_handle_debug(handle, "get max lcd level via RBLL\n");
 
-	status = acpi_evaluate_integer(device->handle, "RBLL", NULL, &state);
+	status = acpi_evaluate_integer(handle, "RBLL", NULL, &state);
 	if (ACPI_FAILURE(status))
 		return -1;
 
@@ -361,15 +362,13 @@ static int get_max_brightness(struct acpi_device *device)
 
 static int bl_get_brightness(struct backlight_device *b)
 {
-	struct acpi_device *device = bl_get_data(b);
+	struct device *dev = bl_get_data(b);
 
-	return b->props.power == BACKLIGHT_POWER_OFF ? 0 : get_lcd_level(device);
+	return b->props.power == BACKLIGHT_POWER_OFF ? 0 : get_lcd_level(dev);
 }
 
 static int bl_update_status(struct backlight_device *b)
 {
-	struct acpi_device *device = bl_get_data(b);
-
 	if (fext) {
 		if (b->props.power == BACKLIGHT_POWER_OFF)
 			call_fext_func(fext, FUNC_BACKLIGHT, 0x1,
@@ -379,7 +378,7 @@ static int bl_update_status(struct backlight_device *b)
 				       BACKLIGHT_PARAM_POWER, BACKLIGHT_ON);
 	}
 
-	return set_lcd_level(device, b->props.brightness);
+	return set_lcd_level(bl_get_data(b), b->props.brightness);
 }
 
 static const struct backlight_ops fujitsu_bl_ops = {
@@ -455,12 +454,13 @@ static const struct key_entry keymap_backlight[] = {
 	{ KE_END, 0 }
 };
 
-static int acpi_fujitsu_bl_input_setup(struct acpi_device *device)
+static int acpi_fujitsu_bl_input_setup(struct device *dev)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	int ret;
 
-	priv->input = devm_input_allocate_device(&device->dev);
+	priv->input = devm_input_allocate_device(dev);
 	if (!priv->input)
 		return -ENOMEM;
 
@@ -479,9 +479,9 @@ static int acpi_fujitsu_bl_input_setup(struct acpi_device *device)
 	return input_register_device(priv->input);
 }
 
-static int fujitsu_backlight_register(struct acpi_device *device)
+static int fujitsu_backlight_register(struct device *dev)
 {
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
 	const struct backlight_properties props = {
 		.brightness = priv->brightness_level,
 		.max_brightness = priv->max_brightness - 1,
@@ -489,9 +489,8 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 	};
 	struct backlight_device *bd;
 
-	bd = devm_backlight_device_register(&device->dev, "fujitsu-laptop",
-					    &device->dev, device,
-					    &fujitsu_bl_ops, &props);
+	bd = devm_backlight_device_register(dev, "fujitsu-laptop",
+					    dev, dev, &fujitsu_bl_ops, &props);
 	if (IS_ERR(bd))
 		return PTR_ERR(bd);
 
@@ -504,73 +503,74 @@ static int fujitsu_backlight_register(struct acpi_device *device)
 
 static void acpi_fujitsu_bl_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct fujitsu_bl *priv = acpi_driver_data(device);
+	struct device *dev = data;
+	struct fujitsu_bl *priv = dev_get_drvdata(dev);
 	int oldb, newb;
 
 	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "unsupported event [0x%x]\n",
-				 event);
+		acpi_handle_info(handle, "unsupported event [0x%x]\n", event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
 		return;
 	}
 
 	oldb = priv->brightness_level;
-	get_lcd_level(device);
+	get_lcd_level(dev);
 	newb = priv->brightness_level;
 
-	acpi_handle_debug(device->handle,
-			  "brightness button event [%i -> %i]\n", oldb, newb);
+	acpi_handle_debug(handle, "brightness button event [%i -> %i]\n",
+			  oldb, newb);
 
 	if (oldb == newb)
 		return;
 
 	if (!disable_brightness_adjust)
-		set_lcd_level(device, newb);
+		set_lcd_level(dev, newb);
 
 	sparse_keymap_report_event(priv->input, oldb < newb, 1, true);
 }
 
-static int acpi_fujitsu_bl_add(struct acpi_device *device)
+static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct fujitsu_bl *priv;
 	int ret;
 
 	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
 		return -ENODEV;
 
-	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	fujitsu_bl = priv;
 	strscpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
-	device->driver_data = priv;
+
+	platform_set_drvdata(pdev, priv);
 
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	if (get_max_brightness(device) <= 0)
+	if (get_max_brightness(&pdev->dev) <= 0)
 		priv->max_brightness = FUJITSU_LCD_N_LEVELS;
-	get_lcd_level(device);
+	get_lcd_level(&pdev->dev);
 
-	ret = acpi_fujitsu_bl_input_setup(device);
+	ret = acpi_fujitsu_bl_input_setup(&pdev->dev);
 	if (ret)
 		return ret;
 
-	ret = fujitsu_backlight_register(device);
+	ret = fujitsu_backlight_register(&pdev->dev);
 	if (ret)
 		return ret;
 
 	return acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					       acpi_fujitsu_bl_notify, device);
+					       acpi_fujitsu_bl_notify, &pdev->dev);
 }
 
-static void acpi_fujitsu_bl_remove(struct acpi_device *device)
+static void acpi_fujitsu_bl_remove(struct platform_device *pdev)
 {
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
-				       acpi_fujitsu_bl_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, acpi_fujitsu_bl_notify);
 }
 
 /* ACPI device for hotkey handling */
@@ -1109,14 +1109,13 @@ static const struct acpi_device_id fujitsu_bl_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver acpi_fujitsu_bl_driver = {
-	.name = ACPI_FUJITSU_BL_DRIVER_NAME,
-	.class = ACPI_FUJITSU_CLASS,
-	.ids = fujitsu_bl_device_ids,
-	.ops = {
-		.add = acpi_fujitsu_bl_add,
-		.remove = acpi_fujitsu_bl_remove,
-		},
+static struct platform_driver acpi_fujitsu_bl_driver = {
+	.probe = acpi_fujitsu_bl_probe,
+	.remove = acpi_fujitsu_bl_remove,
+	.driver = {
+		.name = ACPI_FUJITSU_BL_DRIVER_NAME,
+		.acpi_match_table = fujitsu_bl_device_ids,
+	},
 };
 
 static const struct acpi_device_id fujitsu_laptop_device_ids[] = {
@@ -1145,7 +1144,7 @@ static int __init fujitsu_init(void)
 {
 	int ret;
 
-	ret = acpi_bus_register_driver(&acpi_fujitsu_bl_driver);
+	ret = platform_driver_register(&acpi_fujitsu_bl_driver);
 	if (ret)
 		return ret;
 
@@ -1168,7 +1167,7 @@ static int __init fujitsu_init(void)
 err_unregister_platform_driver:
 	platform_driver_unregister(&fujitsu_pf_driver);
 err_unregister_acpi:
-	acpi_bus_unregister_driver(&acpi_fujitsu_bl_driver);
+	platform_driver_unregister(&acpi_fujitsu_bl_driver);
 
 	return ret;
 }
@@ -1179,7 +1178,7 @@ static void __exit fujitsu_cleanup(void)
 
 	platform_driver_unregister(&fujitsu_pf_driver);
 
-	acpi_bus_unregister_driver(&acpi_fujitsu_bl_driver);
+	platform_driver_unregister(&acpi_fujitsu_bl_driver);
 
 	pr_info("driver unloaded\n");
 }
-- 
2.51.0





