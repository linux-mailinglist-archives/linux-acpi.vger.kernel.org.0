Return-Path: <linux-acpi+bounces-14659-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132C6AE9097
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C57933BAB71
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4BC2701D2;
	Wed, 25 Jun 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBNgH64V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCC32701C3;
	Wed, 25 Jun 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888705; cv=none; b=PxLjWs+KPag5CULLENqThckxe3q9dehGnlZX5hgIugCWkvteyPkOxKfv9yu1bOTP6iZltMLaRV8rntNCllg9IZWEnCp2oSLOM4n7/MFp+uqFujZxFVYunfDCoIALjLZvn1EWvSZkTwOE3vozaJG+71XC/g/UOlay2+sbT3F+vCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888705; c=relaxed/simple;
	bh=uYfK5gcXtckktl54MQ0Vjufff0IqxKXcK1uEwsnJRbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOcIie+5z545vGcuSXQyPG0lGkjrn7qGjcw3C+NpzZunQTzKuH07hnP+esWHocNE17y8FI+51dWu6bjGal6KSv/VYEmeSHOLi9Rq6wL8AiMPmflXOUt8iRTMLRVnhrWoA1MmfzFrE0Y9uEyvihsqVHjw6M3nhJwWcEBqqBL3US4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBNgH64V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02598C4CEF3;
	Wed, 25 Jun 2025 21:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888705;
	bh=uYfK5gcXtckktl54MQ0Vjufff0IqxKXcK1uEwsnJRbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KBNgH64VxYsYMVytO8ODMMe9buwADtpHPn9QADnBldyYlmqS+0Ki+Nv1QeLwfeylu
	 g4txqHSSTIpNZBDBvJ2fD3FQGc+i9URzPelVllt0wC0awi6fJXuvXGw8pq7yhprQE5
	 IGEGAtsDkxAx4Oojb+e/Nc8WijIaWXmcTFCpgHy07czW55/aZLsiK8kKW404l6jbqS
	 DeHtqhTPhBJH9arzR6G+dJWP3MH2Bm9DtJ7F5Ch1dYD5TK4R93OjDEJ1cBOZZ7LXZP
	 VXURoNffeWxsA1VMls777kq3qngPL0AxsTZ2P8k8PQvmzQPD9gyPhPYCqo5iIiQVem
	 RLmtaPTJ1t3rA==
From: Mario Limonciello <superm1@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-gpio@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-acpi@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-kernel@vger.kernel.org (open list),
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 3/4] Input: Don't program hw debounce for soc_button_array devices
Date: Wed, 25 Jun 2025 16:58:12 -0500
Message-ID: <20250625215813.3477840-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625215813.3477840-1-superm1@kernel.org>
References: <20250625215813.3477840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Programming a hardware debounce of 50ms causes problems where a button
doesn't work properly anymore on some systems.  This debounce is intended
for compatibility with systems with a mechanical switch so soc_button_array
devices should only be using a sofware debounce.

Add support for indicating that a driver is only requesting gpio_keys
to use software debounce support and mark that in soc_button_array
accordingly.

Suggested-by: Hans de Goede <hansg@kernel.org>
Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/keyboard/gpio_keys.c    | 7 +++++--
 drivers/input/misc/soc_button_array.c | 1 +
 include/linux/gpio_keys.h             | 2 ++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818b..773aa5294d269 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bool active_low = gpiod_is_active_low(bdata->gpiod);
 
 		if (button->debounce_interval) {
-			error = gpiod_set_debounce(bdata->gpiod,
-					button->debounce_interval * 1000);
+			if (ddata->pdata->no_hw_debounce)
+				error = -EINVAL;
+			else
+				error = gpiod_set_debounce(bdata->gpiod,
+							   button->debounce_interval * 1000);
 			/* use timer if gpiolib doesn't provide debounce */
 			if (error < 0)
 				bdata->software_debounce =
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62ca..dac940455bea8 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -232,6 +232,7 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys_pdata->buttons = gpio_keys;
 	gpio_keys_pdata->nbuttons = n_buttons;
 	gpio_keys_pdata->rep = autorepeat;
+	gpio_keys_pdata->no_hw_debounce = TRUE;
 
 	pd = platform_device_register_resndata(&pdev->dev, "gpio-keys",
 					       PLATFORM_DEVID_AUTO, NULL, 0,
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index 80fa930b04c67..c99f74467fda6 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -48,6 +48,7 @@ struct gpio_keys_button {
  * @enable:		platform hook for enabling the device
  * @disable:		platform hook for disabling the device
  * @name:		input device name
+ * @no_hw_debounce:	avoid programming hardware debounce
  */
 struct gpio_keys_platform_data {
 	const struct gpio_keys_button *buttons;
@@ -57,6 +58,7 @@ struct gpio_keys_platform_data {
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
 	const char *name;
+	bool no_hw_debounce;
 };
 
 #endif
-- 
2.43.0


