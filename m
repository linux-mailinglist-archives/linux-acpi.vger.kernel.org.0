Return-Path: <linux-acpi+bounces-14622-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 802AAAE8C19
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DD454A6AEE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B1F2DA771;
	Wed, 25 Jun 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW0BvXZi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0472DA760;
	Wed, 25 Jun 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875233; cv=none; b=PsALwW/waKWYe6Yg9EWFErkXeNvif08UkZliozQeRbbQ5TEtf7xpdqNXUmt4m51M9NgFYOXc2Z3MLbxfs+VFyGiA3fXoEwlPsZSi4nelhBrOYKDB0qG2g7Uu+xSmxuR8zolsFiG99EaFGSieqoUcYPuyn5EjZziAl4NfFIcRiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875233; c=relaxed/simple;
	bh=G1QCpjfavpigKy+ema2A3AXCLD86KSvFQwQbDAd0FQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVQPSHZx17BtsSyMQG8aXZ0Z5vaKPSlb52gcb/kv52/7LCYY9iO2IFPF1MfKtu4+9n7tYrmzPOS5+yEjeL7mzeZl3pux6Q4QeXIIwJczuH3seYG34CMBydqCKsU3SKPqfh6BgnnDhs5gn/NxcNjoqBN9hr5+QX4vmIsGjLVIwGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW0BvXZi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69D1C4CEF1;
	Wed, 25 Jun 2025 18:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750875232;
	bh=G1QCpjfavpigKy+ema2A3AXCLD86KSvFQwQbDAd0FQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pW0BvXZiDoFTLUm0j/12DOdmLhl3f11YBe3wVzjVP3/yWprEgLU+rTyrZ6ZybQyY+
	 z+7VKJTEl0FL504v2CDIMpR05YFHxE/3ee2WzSiY7jJE0vDC1dpQhm9g2HwSQuaVAg
	 y4JToDY+vSUl0Nj34PsqkvwDoWqwbepxGjgNvg3Z4lNEnuDr7vCM4idN+lAc6WltAQ
	 SygA2RH46bZkLaa/GSp5Cj5VfWlpNJf3kOqm7j7zkTAyiN5DMsVqq7KLmIY1+eQpN5
	 3JFQUhS6yXJXpBefePLzhbF1RLwl3bkS4LNDLA3WYr+KOQJsFXkfhMO0IJqtkBzOaF
	 MSl2HucufuCjg==
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
Subject: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview and baytrail systems
Date: Wed, 25 Jun 2025 13:13:42 -0500
Message-ID: <20250625181342.3175969-4-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625181342.3175969-1-superm1@kernel.org>
References: <20250625181342.3175969-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
hardcoded all soc-button-array devices to use a 50ms debounce timeout
but this doesn't work on all hardware.  The hardware I have on hand
actually prescribes in the ASL that the timeout should be 0:

GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
         "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
{   // Pin list
    0x0000
}

Many cherryview and baytrail systems don't have accurate values in the
ASL for debouncing and thus use software debouncing in gpio_keys. The
value to use is programmed in soc_button_array.  Detect Cherry View
and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
the 50ms only for those systems.

Cc: Hans de Goede <hansg@kernel.org>
Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * commit message
 * quirk systems instead of revert
---
 drivers/input/misc/soc_button_array.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62ca..56abc93f23e0c 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -129,6 +129,13 @@ static const struct dmi_system_id dmi_invalid_acpi_index[] = {
 	{} /* Terminating entry */
 };
 
+static const struct acpi_device_id force_software_debounce_ids[] = {
+	{ "INT33FF" },
+	{ "INT33B2" },
+	{ "INT33FC" },
+	{ }
+};
+
 /*
  * Get the Nth GPIO number from the ACPI object.
  */
@@ -149,11 +156,17 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
 	return 0;
 }
 
+static int soc_button_match_acpi_device_ids(struct device *dev, const void *data)
+{
+	return acpi_match_device(data, dev) ? 1 : 0;
+}
+
 static struct platform_device *
 soc_button_device_create(struct platform_device *pdev,
 			 const struct soc_button_info *button_info,
 			 bool autorepeat)
 {
+	struct device *quirkdev __free(put_device) = NULL;
 	const struct soc_button_info *info;
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
@@ -181,6 +194,10 @@ soc_button_device_create(struct platform_device *pdev,
 	if (dmi_id)
 		invalid_acpi_index = (long)dmi_id->driver_data;
 
+	quirkdev = bus_find_device(&platform_bus_type, NULL,
+				   force_software_debounce_ids,
+				   soc_button_match_acpi_device_ids);
+
 	for (info = button_info; info->name; info++) {
 		if (info->autorepeat != autorepeat)
 			continue;
@@ -220,7 +237,8 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
 		/* These devices often use cheap buttons, use 50 ms debounce */
-		gpio_keys[n_buttons].debounce_interval = 50;
+		if (quirkdev)
+			gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
 	}
 
-- 
2.43.0


