Return-Path: <linux-acpi+bounces-14620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9613AE8C15
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B3718998EB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E7A2D8789;
	Wed, 25 Jun 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvrcL3GG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A42D663F;
	Wed, 25 Jun 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875230; cv=none; b=WHRGV4k4ctCah/lp13CLIz5KM8dbOYPofQstwrstAZIpXuckkz+BN4f8pbyknITxun6WbfQTGB2hwG9t/rYCymUw8X2lhDLsKo4xnxNCKEugieFn+78F+D5NR8j0B3DZzgXX+NImHUiixCIv5oLQxOu9DyOGGcV0HNFNX6eyEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875230; c=relaxed/simple;
	bh=mb/3i/lDJ5rX96P4Q2bvnD9bITtVi/z63alFGix49io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMFng0ThqMrOgpxahXWmmMv43R4HfCVQDo4XVwP2VcBtZq6FIw31rAQA9Dt1tNjhQKybBwf2WbAdePtEQjzI79vdTchZgoJSAy2CQIZlYUAeBnT0AOHZJc5NQHPVJm/YW6V39NEfPjSirezk9SW6uPgCjo843Gk9EYiIBhuKFFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvrcL3GG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF3EC4CEF0;
	Wed, 25 Jun 2025 18:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750875230;
	bh=mb/3i/lDJ5rX96P4Q2bvnD9bITtVi/z63alFGix49io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvrcL3GG+ahqPBaAf6bTgPmLTgv6W6/ibHK+rm7S0ngtM/L8cwn9B48CsmX7TJHeM
	 n8jLnzWeKqTo9vGs9CTA4Lj23M27uhsRNjDQ2XIB5khbURsWwlysfyAGiDg9EtP1Z8
	 j10RrPAo1NAvUWdXuS5YULf/jB25AMfymg8b1bPe4L/biFhNV/rNDagzDj/5oHmqGa
	 35EnEbQKAS7C48gAxN6wBMfRk5n5V8OReRWrnndotQ7+oH/ViiF7mPFDyufRKWOIOR
	 P0THkKuKfhakMUWjiJ5EQfL5b13Y6pG8erxx29CKSEof0T1T9s8khKSY+nH8Rc9J4J
	 CwRCMembYonPA==
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
Subject: [PATCH v2 1/3] gpiolib: acpi: Add a helper for programming debounce
Date: Wed, 25 Jun 2025 13:13:40 -0500
Message-ID: <20250625181342.3175969-2-superm1@kernel.org>
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

Debounce is programmed in two places and considered non-fatal in one of
them. Introduce a helper for programming debounce and show a warning
when failing to program.  This is a difference in behavior for the call
in acpi_dev_gpio_irq_wake_get_by().

Cc: Hans de Goede <hansg@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi-core.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43f..1895e45bd9f16 100644
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
@@ -1025,10 +1030,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
 			if (ret < 0)
 				return ret;
 
-			/* ACPI uses hundredths of milliseconds units */
-			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
-			if (ret)
-				return ret;
+			acpi_set_debounce_timeout(desc, info.debounce);
 
 			irq_flags = acpi_dev_get_irq_type(info.triggering,
 							  info.polarity);
-- 
2.43.0


