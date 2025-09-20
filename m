Return-Path: <linux-acpi+bounces-17151-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5E9B8D085
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 22:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAA9F7C7EA8
	for <lists+linux-acpi@lfdr.de>; Sat, 20 Sep 2025 20:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810AF2749DF;
	Sat, 20 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeHwIeJR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7F2144D7;
	Sat, 20 Sep 2025 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758399124; cv=none; b=QstfjZ82cI/vi7T6LbW9ogy4GUo30kyuW7AQ7lRCqFMHfNWu614FEAh4Bq/0M+V5GqrLCPREvxlFMEyiS4cz/lKluQhQTKsyuwrQIuBc4ZTzmCn3bn5/8LPE7YrhrvvyAOiqZzqIfTnNunpPcAo5wg4Wbjj9mnV/Ve25KmhtjVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758399124; c=relaxed/simple;
	bh=jbC9Sb3AKdA6ZHnElBfDO40DRbp3oq6m6FxraEOQX40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aEwSzefTaKUhMewg1QM+nM2mcdTXFsouqGYCBS0eP9ndHK1PvBYZCVfVLqAeBMYDZb4EpOs5kJHS2Zyd8/3vMHgjK4zw1G+YjGKx8Q86AkyQEHmdf7O53ACFNvbgDGMjxDQWW7QD2wrzu4TwI5CE85mJy4n/n+D7NeMxSKR7PpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeHwIeJR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253F4C4CEEB;
	Sat, 20 Sep 2025 20:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758399124;
	bh=jbC9Sb3AKdA6ZHnElBfDO40DRbp3oq6m6FxraEOQX40=;
	h=From:To:Cc:Subject:Date:From;
	b=aeHwIeJRuqfEzBkIR0JTCSXB7SN1/5B1adA8YIqaTXA677pyfckwqeeAZsURVJ7rC
	 /uIGoTOjPujKZxW0JSXMhBQhT3pAJc0RQbI8lZz5Yl3MMvIOGlNiSUgxEioTytpc/f
	 iGWezFyvCvo34vcsROUuVQ4JkvdzmYVaQNImx0J4dVMA0aeCwFYj/V+mz5YuSY/Dwa
	 vLYa4lI5Uh+qwPzKHZlYCPI+pljDOIKcd8rga3J8Haa7qvp04OCKIO+AoG1XQJ6wXg
	 xWZftzQPXTUcMtdP57I0Qfz9979UxZgzGgf8X1SacnjbLZQmdSmvHTy4tpodOjYT44
	 VV9axEbLG+ckQ==
From: Hans de Goede <hansg@kernel.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce errors non fatal
Date: Sat, 20 Sep 2025 22:12:00 +0200
Message-ID: <20250920201200.20611-1-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
adds a gpio_set_debounce_timeout() call to acpi_find_gpio() and makes
acpi_find_gpio() fail if this fails.

But gpio_set_debounce_timeout() failing is a somewhat normal occurrence,
since not all debounce values are supported on all GPIO/pinctrl chips.

Making this an error for example break getting the card-detect GPIO for
the micro-sd slot found on many Bay Trail tablets, breaking support for
the micro-sd slot on these tablets.

acpi_request_own_gpiod() already treats gpio_set_debounce_timeout()
failures as non-fatal, just warning about them.

Add a acpi_gpio_set_debounce_timeout() helper which wraps
gpio_set_debounce_timeout() and warns on failures and replace both existing
gpio_set_debounce_timeout() calls with the helper.

Since the helper only warns on failures this fixes the card-detect issue.

Fixes: 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
---
 drivers/gpio/gpiolib-acpi-core.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 284e762d92c4..67c4c38afb86 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -291,6 +291,19 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
 	return GPIOD_ASIS;
 }
 
+static void acpi_gpio_set_debounce_timeout(struct gpio_desc *desc,
+					   unsigned int acpi_debounce)
+{
+	int ret;
+
+	/* ACPI uses hundredths of milliseconds units */
+	acpi_debounce *= 10;
+	ret = gpio_set_debounce_timeout(desc, acpi_debounce);
+	if (ret)
+		gpiod_warn(desc, "Failed to set debounce-timeout %u: %d\n",
+			   acpi_debounce, ret);
+}
+
 static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 						struct acpi_resource_gpio *agpio,
 						unsigned int index,
@@ -300,18 +313,12 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
 	unsigned int pin = agpio->pin_table[index];
 	struct gpio_desc *desc;
-	int ret;
 
 	desc = gpiochip_request_own_desc(chip, pin, label, polarity, flags);
 	if (IS_ERR(desc))
 		return desc;
 
-	/* ACPI uses hundredths of milliseconds units */
-	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
-	if (ret)
-		dev_warn(chip->parent,
-			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
-			 pin, ret);
+	acpi_gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
 
 	return desc;
 }
@@ -944,7 +951,6 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
 	struct acpi_gpio_info info = {};
 	struct gpio_desc *desc;
-	int ret;
 
 	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
 	if (IS_ERR(desc))
@@ -959,10 +965,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
 
-	/* ACPI uses hundredths of milliseconds units */
-	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
-	if (ret)
-		return ERR_PTR(ret);
+	acpi_gpio_set_debounce_timeout(desc, info.debounce);
 
 	return desc;
 }
-- 
2.51.0


