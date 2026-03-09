Return-Path: <linux-acpi+bounces-21559-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLKzOUX/rmkLLgIAu9opvQ
	(envelope-from <linux-acpi+bounces-21559-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:11:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A0723D6CB
	for <lists+linux-acpi@lfdr.de>; Mon, 09 Mar 2026 18:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C442300D0DA
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Mar 2026 17:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CC83E558A;
	Mon,  9 Mar 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQIq1Zbq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B0BF4FA;
	Mon,  9 Mar 2026 17:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773076290; cv=none; b=kFGvUuJrk+fXniP8YDRg6ojw7+uvkKOEcvkIKoFvKvFlztOFNbx3gSrJNKUaywp4tO8ceiCk0hfh4KBrZrFrVEihZXKZyIY+LaL9XIIkXilyYsltz8bgPlmEvSlEo9VdPlfFnfFVAZwhABAtWc9hdwb/PdsrHVWG53Tbc6bn/BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773076290; c=relaxed/simple;
	bh=hbX4HZpjV9trFVb/nRaKQvCT/xYx7teIafASPPWCwy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o96rfGkdI4ew4IvcpnBNMdLA/8pC6ZwOUnBQTSjKJv0VO70plQpyIMhxWm02ExKq4F5Vaihxa2UvufCUPTyHP/LcuBwQznEqvq64hz/yiUdO71tw7u8xn9MRQMTakyGQFHA+bJTjPtlwY3lP44e11DZIN8ORBIw8iQ+9nxapyLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQIq1Zbq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D74AC4CEF7;
	Mon,  9 Mar 2026 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773076290;
	bh=hbX4HZpjV9trFVb/nRaKQvCT/xYx7teIafASPPWCwy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQIq1ZbqfvGUT4m0NGxwwK31hieuFGuBYHsCquOeE8XXli0PoQFJAcqcRSqR7Tnsh
	 y/a6vUGFvMDlN5qOkQPq8jQrsP/bYbXMdk9I6cakUYDPsXuQR0EzMU/iBlDrWBVBke
	 zMnjWU8UrNGaBBK/rfNO64nJTW3Y74l4ItFtE7zecKkp910n4k2EjLCxrskCtW0joj
	 KknmHAWN/8L/mBdrai9GyPJcg3zqvK5s3nCIniA54Oc0XwKsS82bQFEhghjngMC9ho
	 GLYIHBzY4QWmFzwpwTZuvZ2SwFQ8Eg7vDDU5YA//YSHlQk/U1Z022tj/MfbxEfmFSh
	 nUtTLojsLt00A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Robert Gerlach <khnz@gmx.de>, Hans de Goede <hansg@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, Jonathan Woithe <jwoithe@just42.net>
Subject:
 [PATCH v2 5/5] platform/x86: fujitsu: Convert laptop driver to a platform one
Date: Mon, 09 Mar 2026 18:09:49 +0100
Message-ID: <3411404.aeNJFYEL58@rafael.j.wysocki>
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
X-Rspamd-Queue-Id: 98A0723D6CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,vger.kernel.org,just42.net];
	TAGGED_FROM(0.00)[bounces-21559-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the main part of the Fujitsu laptop driver
from an ACPI driver to a platform one.

After this change, the subordinate LED and input devices will be
registered under the platform device used for driver binding instead of
its ACPI companion.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Rebase after updating patch [3/5]

---
 drivers/platform/x86/fujitsu-laptop.c | 202 +++++++++++++-------------
 1 file changed, 97 insertions(+), 105 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index b40260315f1e..fe835c243e93 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -144,11 +144,11 @@ struct fujitsu_laptop {
 	bool charge_control_supported;
 };
 
-static struct acpi_device *fext;
+static struct device *fext;
 
 /* Fujitsu ACPI interface function */
 
-static int call_fext_func(struct acpi_device *device,
+static int call_fext_func(struct device *dev,
 			  int func, int op, int feature, int state)
 {
 	union acpi_object params[4] = {
@@ -158,18 +158,17 @@ static int call_fext_func(struct acpi_device *device,
 		{ .integer.type = ACPI_TYPE_INTEGER, .integer.value = state }
 	};
 	struct acpi_object_list arg_list = { 4, params };
+	acpi_handle handle = ACPI_HANDLE(dev);
 	unsigned long long value;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(device->handle, "FUNC", &arg_list,
-				       &value);
+	status = acpi_evaluate_integer(handle, "FUNC", &arg_list, &value);
 	if (ACPI_FAILURE(status)) {
-		acpi_handle_err(device->handle, "Failed to evaluate FUNC\n");
+		acpi_handle_err(handle, "Failed to evaluate FUNC\n");
 		return -ENODEV;
 	}
 
-	acpi_handle_debug(device->handle,
-			  "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n",
+	acpi_handle_debug(handle, "FUNC 0x%x (args 0x%x, 0x%x, 0x%x) returned 0x%x\n",
 			  func, op, feature, state, (int)value);
 	return value;
 }
@@ -251,9 +250,9 @@ static struct acpi_battery_hook battery_hook = {
  * These functions are intended to be called from acpi_fujitsu_laptop_add and
  * acpi_fujitsu_laptop_remove.
  */
-static int fujitsu_battery_charge_control_add(struct acpi_device *device)
+static int fujitsu_battery_charge_control_add(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	int s006_cc_return;
 
 	priv->charge_control_supported = false;
@@ -274,9 +273,9 @@ static int fujitsu_battery_charge_control_add(struct acpi_device *device)
 	return 0;
 }
 
-static void fujitsu_battery_charge_control_remove(struct acpi_device *device)
+static void fujitsu_battery_charge_control_remove(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 
 	if (priv->charge_control_supported)
 		battery_hook_unregister(&battery_hook);
@@ -665,12 +664,13 @@ static const struct dmi_system_id fujitsu_laptop_dmi_table[] = {
 	{}
 };
 
-static int acpi_fujitsu_laptop_input_setup(struct acpi_device *device)
+static int acpi_fujitsu_laptop_input_setup(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	int ret;
 
-	priv->input = devm_input_allocate_device(&device->dev);
+	priv->input = devm_input_allocate_device(dev);
 	if (!priv->input)
 		return -ENOMEM;
 
@@ -689,9 +689,9 @@ static int acpi_fujitsu_laptop_input_setup(struct acpi_device *device)
 	return input_register_device(priv->input);
 }
 
-static int fujitsu_laptop_platform_add(struct acpi_device *device)
+static int fujitsu_laptop_platform_add(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	int ret;
 
 	priv->pf_device = platform_device_alloc("fujitsu-laptop", PLATFORM_DEVID_NONE);
@@ -719,9 +719,9 @@ static int fujitsu_laptop_platform_add(struct acpi_device *device)
 	return ret;
 }
 
-static void fujitsu_laptop_platform_remove(struct acpi_device *device)
+static void fujitsu_laptop_platform_remove(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 
 	sysfs_remove_group(&priv->pf_device->dev.kobj,
 			   &fujitsu_pf_attribute_group);
@@ -731,7 +731,7 @@ static void fujitsu_laptop_platform_remove(struct acpi_device *device)
 static int logolamp_set(struct led_classdev *cdev,
 			enum led_brightness brightness)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 	int poweron = FUNC_LED_ON, always = FUNC_LED_ON;
 	int ret;
 
@@ -741,23 +741,23 @@ static int logolamp_set(struct led_classdev *cdev,
 	if (brightness < LED_FULL)
 		always = FUNC_LED_OFF;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_POWERON, poweron);
+	ret = call_fext_func(parent, FUNC_LEDS, 0x1, LOGOLAMP_POWERON, poweron);
 	if (ret < 0)
 		return ret;
 
-	return call_fext_func(device, FUNC_LEDS, 0x1, LOGOLAMP_ALWAYS, always);
+	return call_fext_func(parent, FUNC_LEDS, 0x1, LOGOLAMP_ALWAYS, always);
 }
 
 static enum led_brightness logolamp_get(struct led_classdev *cdev)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 	int ret;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_ALWAYS, 0x0);
+	ret = call_fext_func(parent, FUNC_LEDS, 0x2, LOGOLAMP_ALWAYS, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_FULL;
 
-	ret = call_fext_func(device, FUNC_LEDS, 0x2, LOGOLAMP_POWERON, 0x0);
+	ret = call_fext_func(parent, FUNC_LEDS, 0x2, LOGOLAMP_POWERON, 0x0);
 	if (ret == FUNC_LED_ON)
 		return LED_HALF;
 
@@ -767,22 +767,21 @@ static enum led_brightness logolamp_get(struct led_classdev *cdev)
 static int kblamps_set(struct led_classdev *cdev,
 		       enum led_brightness brightness)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
+		return call_fext_func(parent, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
 				      FUNC_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
+		return call_fext_func(parent, FUNC_LEDS, 0x1, KEYBOARD_LAMPS,
 				      FUNC_LED_OFF);
 }
 
 static enum led_brightness kblamps_get(struct led_classdev *cdev)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device,
+	if (call_fext_func(cdev->dev->parent,
 			   FUNC_LEDS, 0x2, KEYBOARD_LAMPS, 0x0) == FUNC_LED_ON)
 		brightness = LED_FULL;
 
@@ -792,22 +791,22 @@ static enum led_brightness kblamps_get(struct led_classdev *cdev)
 static int radio_led_set(struct led_classdev *cdev,
 			 enum led_brightness brightness)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
+		return call_fext_func(parent, FUNC_FLAGS, 0x5, RADIO_LED_ON,
 				      RADIO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_FLAGS, 0x5, RADIO_LED_ON,
+		return call_fext_func(parent, FUNC_FLAGS, 0x5, RADIO_LED_ON,
 				      0x0);
 }
 
 static enum led_brightness radio_led_get(struct led_classdev *cdev)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
+	if (call_fext_func(parent, FUNC_FLAGS, 0x4, 0x0, 0x0) & RADIO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
@@ -816,60 +815,58 @@ static enum led_brightness radio_led_get(struct led_classdev *cdev)
 static int eco_led_set(struct led_classdev *cdev,
 		       enum led_brightness brightness)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 	int curr;
 
-	curr = call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0);
+	curr = call_fext_func(parent, FUNC_LEDS, 0x2, ECO_LED, 0x0);
 	if (brightness >= LED_FULL)
-		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
+		return call_fext_func(parent, FUNC_LEDS, 0x1, ECO_LED,
 				      curr | ECO_LED_ON);
 	else
-		return call_fext_func(device, FUNC_LEDS, 0x1, ECO_LED,
+		return call_fext_func(parent, FUNC_LEDS, 0x1, ECO_LED,
 				      curr & ~ECO_LED_ON);
 }
 
 static enum led_brightness eco_led_get(struct led_classdev *cdev)
 {
-	struct acpi_device *device = to_acpi_device(cdev->dev->parent);
+	struct device *parent = cdev->dev->parent;
 	enum led_brightness brightness = LED_OFF;
 
-	if (call_fext_func(device, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
+	if (call_fext_func(parent, FUNC_LEDS, 0x2, ECO_LED, 0x0) & ECO_LED_ON)
 		brightness = LED_FULL;
 
 	return brightness;
 }
 
-static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
+static int acpi_fujitsu_laptop_leds_register(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	struct led_classdev *led;
 	int ret;
 
-	if (call_fext_func(device,
-			   FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
-		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
+	if (call_fext_func(dev, FUNC_LEDS, 0x0, 0x0, 0x0) & LOGOLAMP_POWERON) {
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
 
 		led->name = "fujitsu::logolamp";
 		led->brightness_set_blocking = logolamp_set;
 		led->brightness_get = logolamp_get;
-		ret = devm_led_classdev_register(&device->dev, led);
+		ret = devm_led_classdev_register(dev, led);
 		if (ret)
 			return ret;
 	}
 
-	if ((call_fext_func(device,
-			    FUNC_LEDS, 0x0, 0x0, 0x0) & KEYBOARD_LAMPS) &&
-	    (call_fext_func(device, FUNC_BUTTONS, 0x0, 0x0, 0x0) == 0x0)) {
-		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
+	if ((call_fext_func(dev, FUNC_LEDS, 0x0, 0x0, 0x0) & KEYBOARD_LAMPS) &&
+	    (call_fext_func(dev, FUNC_BUTTONS, 0x0, 0x0, 0x0) == 0x0)) {
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
 
 		led->name = "fujitsu::kblamps";
 		led->brightness_set_blocking = kblamps_set;
 		led->brightness_get = kblamps_get;
-		ret = devm_led_classdev_register(&device->dev, led);
+		ret = devm_led_classdev_register(dev, led);
 		if (ret)
 			return ret;
 	}
@@ -884,7 +881,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	 * whether given model has a radio toggle button.
 	 */
 	if (priv->flags_supported & BIT(17)) {
-		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
 
@@ -892,7 +889,7 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 		led->brightness_set_blocking = radio_led_set;
 		led->brightness_get = radio_led_get;
 		led->default_trigger = "rfkill-any";
-		ret = devm_led_classdev_register(&device->dev, led);
+		ret = devm_led_classdev_register(dev, led);
 		if (ret)
 			return ret;
 	}
@@ -902,17 +899,16 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	 * bit 14 seems to indicate presence of said led as well.
 	 * Confirm by testing the status.
 	 */
-	if ((call_fext_func(device, FUNC_LEDS, 0x0, 0x0, 0x0) & BIT(14)) &&
-	    (call_fext_func(device,
-			    FUNC_LEDS, 0x2, ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
-		led = devm_kzalloc(&device->dev, sizeof(*led), GFP_KERNEL);
+	if ((call_fext_func(dev, FUNC_LEDS, 0x0, 0x0, 0x0) & BIT(14)) &&
+	    (call_fext_func(dev, FUNC_LEDS, 0x2, ECO_LED, 0x0) != UNSUPPORTED_CMD)) {
+		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
 		if (!led)
 			return -ENOMEM;
 
 		led->name = "fujitsu::eco_led";
 		led->brightness_set_blocking = eco_led_set;
 		led->brightness_get = eco_led_get;
-		ret = devm_led_classdev_register(&device->dev, led);
+		ret = devm_led_classdev_register(dev, led);
 		if (ret)
 			return ret;
 	}
@@ -920,9 +916,9 @@ static int acpi_fujitsu_laptop_leds_register(struct acpi_device *device)
 	return 0;
 }
 
-static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
+static void acpi_fujitsu_laptop_press(struct device *dev, int scancode)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	int ret;
 
 	ret = kfifo_in_locked(&priv->fifo, (unsigned char *)&scancode,
@@ -937,9 +933,9 @@ static void acpi_fujitsu_laptop_press(struct acpi_device *device, int scancode)
 		scancode);
 }
 
-static void acpi_fujitsu_laptop_release(struct acpi_device *device)
+static void acpi_fujitsu_laptop_release(struct device *dev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	int scancode, ret;
 
 	while (true) {
@@ -955,34 +951,30 @@ static void acpi_fujitsu_laptop_release(struct acpi_device *device)
 
 static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data)
 {
-	struct acpi_device *device = data;
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct device *dev = data;
+	struct fujitsu_laptop *priv = dev_get_drvdata(dev);
 	unsigned long flags;
 	int scancode, i = 0;
 	unsigned int irb;
 
 	if (event != ACPI_FUJITSU_NOTIFY_CODE) {
-		acpi_handle_info(device->handle, "Unsupported event [0x%x]\n",
-				 event);
+		acpi_handle_info(handle, "Unsupported event [0x%x]\n", event);
 		sparse_keymap_report_event(priv->input, -1, 1, true);
 		return;
 	}
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
-						   0x0);
+		priv->flags_state = call_fext_func(dev, FUNC_FLAGS, 0x4, 0x0, 0x0);
 
-	while ((irb = call_fext_func(device,
-				     FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
+	while ((irb = call_fext_func(dev, FUNC_BUTTONS, 0x1, 0x0, 0x0)) != 0 &&
 	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE) {
 		scancode = irb & 0x4ff;
 		if (sparse_keymap_entry_from_scancode(priv->input, scancode))
-			acpi_fujitsu_laptop_press(device, scancode);
+			acpi_fujitsu_laptop_press(dev, scancode);
 		else if (scancode == 0)
-			acpi_fujitsu_laptop_release(device);
+			acpi_fujitsu_laptop_release(dev);
 		else
-			acpi_handle_info(device->handle,
-					 "Unknown GIRB result [%x]\n", irb);
+			acpi_handle_info(handle, "Unknown GIRB result [%x]\n", irb);
 	}
 
 	/*
@@ -992,28 +984,30 @@ static void acpi_fujitsu_laptop_notify(acpi_handle handle, u32 event, void *data
 	 * status flags queried using FUNC_FLAGS.
 	 */
 	if (priv->flags_supported & (FLAG_SOFTKEYS)) {
-		flags = call_fext_func(device, FUNC_FLAGS, 0x1, 0x0, 0x0);
+		flags = call_fext_func(dev, FUNC_FLAGS, 0x1, 0x0, 0x0);
 		flags &= (FLAG_SOFTKEYS);
 		for_each_set_bit(i, &flags, BITS_PER_LONG)
 			sparse_keymap_report_event(priv->input, BIT(i), 1, true);
 	}
 }
 
-static int acpi_fujitsu_laptop_add(struct acpi_device *device)
+static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
 {
+	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct fujitsu_laptop *priv;
 	int ret, i = 0;
 
-	priv = devm_kzalloc(&device->dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
-	fext = device;
+	fext = &pdev->dev;
 
 	strscpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
 	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
-	device->driver_data = priv;
+
+	platform_set_drvdata(pdev, priv);
 
 	/* kfifo */
 	spin_lock_init(&priv->fifo_lock);
@@ -1025,14 +1019,13 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
 
-	while (call_fext_func(device, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
+	while (call_fext_func(fext, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
 	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
 		; /* No action, result is discarded */
 	acpi_handle_debug(device->handle, "Discarded %i ringbuffer entries\n",
 			  i);
 
-	priv->flags_supported = call_fext_func(device, FUNC_FLAGS, 0x0, 0x0,
-					       0x0);
+	priv->flags_supported = call_fext_func(fext, FUNC_FLAGS, 0x0, 0x0, 0x0);
 
 	/* Make sure our bitmask of supported functions is cleared if the
 	   RFKILL function block is not implemented, like on the S7020. */
@@ -1040,12 +1033,12 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 		priv->flags_supported = 0;
 
 	if (priv->flags_supported)
-		priv->flags_state = call_fext_func(device, FUNC_FLAGS, 0x4, 0x0,
+		priv->flags_state = call_fext_func(fext, FUNC_FLAGS, 0x4, 0x0,
 						   0x0);
 
 	/* Suspect this is a keymap of the application panel, print it */
 	acpi_handle_info(device->handle, "BTNI: [0x%x]\n",
-			 call_fext_func(device, FUNC_BUTTONS, 0x0, 0x0, 0x0));
+			 call_fext_func(fext, FUNC_BUTTONS, 0x0, 0x0, 0x0));
 
 	/* Sync backlight power status */
 	if (fujitsu_bl && fujitsu_bl->bl_device &&
@@ -1057,26 +1050,26 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 			fujitsu_bl->bl_device->props.power = BACKLIGHT_POWER_ON;
 	}
 
-	ret = acpi_fujitsu_laptop_input_setup(device);
+	ret = acpi_fujitsu_laptop_input_setup(fext);
 	if (ret)
 		goto err_free_fifo;
 
-	ret = acpi_fujitsu_laptop_leds_register(device);
+	ret = acpi_fujitsu_laptop_leds_register(fext);
 	if (ret)
 		goto err_free_fifo;
 
-	ret = fujitsu_laptop_platform_add(device);
+	ret = fujitsu_laptop_platform_add(fext);
 	if (ret)
 		goto err_free_fifo;
 
 	ret = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
-					      acpi_fujitsu_laptop_notify, device);
+					      acpi_fujitsu_laptop_notify, fext);
 	if (ret) {
-		fujitsu_laptop_platform_remove(device);
+		fujitsu_laptop_platform_remove(fext);
 		goto err_free_fifo;
 	}
 
-	ret = fujitsu_battery_charge_control_add(device);
+	ret = fujitsu_battery_charge_control_add(fext);
 	if (ret < 0)
 		pr_warn("Unable to register battery charge control: %d\n", ret);
 
@@ -1088,16 +1081,16 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	return ret;
 }
 
-static void acpi_fujitsu_laptop_remove(struct acpi_device *device)
+static void acpi_fujitsu_laptop_remove(struct platform_device *pdev)
 {
-	struct fujitsu_laptop *priv = acpi_driver_data(device);
+	struct fujitsu_laptop *priv = platform_get_drvdata(pdev);
 
-	fujitsu_battery_charge_control_remove(device);
+	fujitsu_battery_charge_control_remove(&pdev->dev);
 
-	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev), ACPI_DEVICE_NOTIFY,
 				       acpi_fujitsu_laptop_notify);
 
-	fujitsu_laptop_platform_remove(device);
+	fujitsu_laptop_platform_remove(&pdev->dev);
 
 	kfifo_free(&priv->fifo);
 }
@@ -1123,14 +1116,13 @@ static const struct acpi_device_id fujitsu_laptop_device_ids[] = {
 	{"", 0},
 };
 
-static struct acpi_driver acpi_fujitsu_laptop_driver = {
-	.name = ACPI_FUJITSU_LAPTOP_DRIVER_NAME,
-	.class = ACPI_FUJITSU_CLASS,
-	.ids = fujitsu_laptop_device_ids,
-	.ops = {
-		.add = acpi_fujitsu_laptop_add,
-		.remove = acpi_fujitsu_laptop_remove,
-		},
+static struct platform_driver acpi_fujitsu_laptop_driver = {
+	.probe = acpi_fujitsu_laptop_probe,
+	.remove = acpi_fujitsu_laptop_remove,
+	.driver = {
+		.name = ACPI_FUJITSU_LAPTOP_DRIVER_NAME,
+		.acpi_match_table = fujitsu_laptop_device_ids,
+	},
 };
 
 static const struct acpi_device_id fujitsu_ids[] __used = {
@@ -1156,7 +1148,7 @@ static int __init fujitsu_init(void)
 
 	/* Register laptop driver */
 
-	ret = acpi_bus_register_driver(&acpi_fujitsu_laptop_driver);
+	ret = platform_driver_register(&acpi_fujitsu_laptop_driver);
 	if (ret)
 		goto err_unregister_platform_driver;
 
@@ -1174,7 +1166,7 @@ static int __init fujitsu_init(void)
 
 static void __exit fujitsu_cleanup(void)
 {
-	acpi_bus_unregister_driver(&acpi_fujitsu_laptop_driver);
+	platform_driver_unregister(&acpi_fujitsu_laptop_driver);
 
 	platform_driver_unregister(&fujitsu_pf_driver);
 
-- 
2.51.0





