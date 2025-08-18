Return-Path: <linux-acpi+bounces-15756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61365B29660
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 03:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F332171418
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB6822F76B;
	Mon, 18 Aug 2025 01:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXdC9qmk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024722A817;
	Mon, 18 Aug 2025 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755481944; cv=none; b=UO4f4AEuRIrgh6hMGHnEdQr3ZrFLMfYwUlkTWEYNXIqrcYAl6Z6wAD6HQ1xJkb5j8BGOtM4J+niMCZmzU0jmUcJww1G3jGFL2H6N/u5m6ikchom1IcNxLs+ZDEkUW7y68QwDfxIUXcgWaFih1Ta9r/skFm/jJnopxgWzNP01d/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755481944; c=relaxed/simple;
	bh=eXQkZ2Lv1D+oMa+sk/PjVmJUjE55kmzBr6nmJ2/KlhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AxBEtmoatGPdOWiAwUya6Ry1c3515M+qTLJ8e5E9req0bQr2ZwU0w5qF/ytriCqaQTgDHWqsQxl3mukSfa7J+LDrJfyELdvzU16Dteyq0KeAvU/gebmdJBI26iFtTJe58ZZ5HrdDFjyY3JjSj3XGXJTL9HzqR24of8Q64OegIG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXdC9qmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07666C4CEEB;
	Mon, 18 Aug 2025 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755481943;
	bh=eXQkZ2Lv1D+oMa+sk/PjVmJUjE55kmzBr6nmJ2/KlhY=;
	h=From:To:Cc:Subject:Date:From;
	b=IXdC9qmkO0KOQTAs+cU/bW60Vm9oPA4TLDOdMprJS5QlAc/04Wom4Dgoe66T8AuPe
	 iTQ0nAZW2KvVU9e8atwDV/cukoIIRl4T+/igXoQy3lhmWq95JRsOezL9gCs5jOeA3l
	 N4WjoWhEVL41/mp1ouG9z7Onoy/LnsufpRILklQloMRvgHWtuAiKzAC2/R7Vdtl8e2
	 /E6yUMFBy1mGPDavyNhU9jfZlNRkq7kl6z9rUDuR7R0yqTQb6W4jhoK+qSJq/vYLI9
	 nHldzfHUzta/iNCuwuZhzVYH0UG6ZMXfZIQSF4SzV4wmY0cYwmP37eL+szS05SluAj
	 0n8zTX7DJg81Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Program debounce when finding GPIO
Date: Sun, 17 Aug 2025 20:52:07 -0500
Message-ID: <20250818015219.3604648-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
which will parse _CRS.

acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
gpiod_get_index (drivers/gpio/gpiolib.c:4877)

The GPIO is setup basically, but the debounce information is discarded.
The platform will assert what debounce should be in _CRS, so program it
at the time it's available.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v4:
 * Just add a direct call instead
 * drop tag
 * update commit message
---
 drivers/gpio/gpiolib-acpi-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43f..6388e8e363dee 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
+	int ret;
 
 	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
 	if (IS_ERR(desc))
@@ -957,6 +958,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
+	/* ACPI uses hundredths of milliseconds units */
+	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
+	if (ret)
+		return ERR_PTR(ret);
+
 	return desc;
 }
 
-- 
2.43.0


