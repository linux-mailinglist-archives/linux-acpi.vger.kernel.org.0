Return-Path: <linux-acpi+bounces-15590-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93427B21270
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CD4F3AA3D9
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 16:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2831296BB4;
	Mon, 11 Aug 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXpxlSif"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969EE149C51;
	Mon, 11 Aug 2025 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930644; cv=none; b=ePMxtMiZ9auqLVT2hqOECVYITGdH7lUfKJ4+jJC7dt/DLGfxyTE+3URQwux9ghqM2eOE0Hjf+e3WrYCIyXkc0g8NjEpfey3rP22ichosWuF7mTzjuxZgUf6wcmPHjnz1K1NVpz5xfl7v7Hf9l45SzlVOwKXuaW8/x6jaZtUh0Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930644; c=relaxed/simple;
	bh=3sXWJihKNVBypgFDATYECBKDVC9786a2MikM5Ss4168=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oH/b65/KhzfpJoH76nEo3DKaJ6sbR39Kdvlu6giqeh5xqhEIuK1o0pZpNqUZBNKd3vOEiL4KhyUmFc3SwsPSRf6jwUI9PIE8AKYZBtbfzYCI1LSoFh22YfShtuxbRZTsTbl0OXeSF5ulZhoP27iu1jSpkzZvE4vspDzM6XguKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXpxlSif; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE7C4CEED;
	Mon, 11 Aug 2025 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930644;
	bh=3sXWJihKNVBypgFDATYECBKDVC9786a2MikM5Ss4168=;
	h=From:To:Cc:Subject:Date:From;
	b=qXpxlSifAbFbou+u3ZGrldWcQT1/zlF4WxNOKZA5CVlRFbBnMaV3V8kI5DNawSrxZ
	 6swFvYeYR2L8tu0QEXoJHod4hgISbwSEjgtZiHRpAQCclBpAvDwjZvo/HvhBN7iz39
	 fXaRoVvUEwk7rxptvy4JDoobv8aRWf8BbLQhHqNhwRe+s0luMz3yOH96OizPuhNL5g
	 2zYSyUQyP3U8o2jhQFT2cxP/tBzl107qojUJJ6czBUIjrhtG9HETqr2q7uwHQkfVEE
	 t/Ax5KjjjgRmktlYmY7XbBsY4yzXjXOehC8rQSnZr/+mS7rC5RVEhS5Q8Mu16DCPef
	 BiwTQBy9CwWtA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
	Mika Westerberg <westeri@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-acpi@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v3] gpiolib: acpi: Program debounce when finding GPIO
Date: Mon, 11 Aug 2025 11:43:56 -0500
Message-ID: <20250811164356.613840-1-superm1@kernel.org>
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

As this is considered non fatal if it fails, introduce a helper for
programming debounce and show a warning when failing to program.

Reviewed-by: Hans de Goede <hansg@kernel.org>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
v3:
 * squash patches 1 and 2 together and drop the extra fatal hunk
v2:
 * https://lore.kernel.org/all/20250625181342.3175969-1-superm1@kernel.org/
---
 drivers/gpio/gpiolib-acpi-core.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43..15222bfc25bb 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -291,6 +291,17 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
 	return GPIOD_ASIS;
 }
 
+static void acpi_set_debounce_timeout(struct gpio_desc *desc, unsigned int timeout)
+{
+	int ret;
+
+	/* ACPI uses hundredths of milliseconds units */
+	ret = gpio_set_debounce_timeout(desc, timeout * 10);
+	if (ret)
+		dev_warn(&desc->gdev->dev,
+			 "Failed to set debounce-timeout: %d\n", ret);
+}
+
 static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
 						struct acpi_resource_gpio *agpio,
 						unsigned int index,
@@ -300,18 +311,12 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
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
+	acpi_set_debounce_timeout(desc, agpio->debounce_timeout);
 
 	return desc;
 }
@@ -957,6 +962,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
+	acpi_set_debounce_timeout(desc, info.debounce);
 	return desc;
 }
 
@@ -1025,10 +1031,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 			if (ret < 0)
 				return ret;
 
-			/* ACPI uses hundredths of milliseconds units */
-			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
-			if (ret)
-				return ret;
+			acpi_set_debounce_timeout(desc, info.debounce);
 
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
 							  info.polarity);

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.1


