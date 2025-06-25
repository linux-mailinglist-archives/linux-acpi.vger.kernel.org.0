Return-Path: <linux-acpi+bounces-14657-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB762AE9090
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C09A4A696A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCF726E6FC;
	Wed, 25 Jun 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUhMiOwC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF10C26E6F1;
	Wed, 25 Jun 2025 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888703; cv=none; b=RTMMH2qbFJf0RQ3xMl0P+l81147bAUSZgMsua2Utq2EpxicGphfaDUZWfvR5aJeDgRHLAYGgfmCELa4JskJQJfnVGiTAAgWFu8rqglwj12YrklLByLsizIdaMoCygLhdGd+W9UOYkmF3u/f1Ail91NAYGXQq2Azyhjs6ZbDmzOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888703; c=relaxed/simple;
	bh=Z2WKL168cXJ8F1NkWpzvfCAqJZ+WPM2aSSsA1qv2Rtg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvO23Z0WDpF5b5W6psnEdm23IApbPOZUR9V5jFDuG4F3qgHQOi1JkGeVrxYnCk50kExk1478+tTFhC8JwccqCJ8z4xx4uv0okjx0+lrjizIYCC/WRLMIxELz0MtxWm1Pzr6yjH4gkyIVteSZEVDKUGy4hz0XQSggi5CGNGQajFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUhMiOwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E6C4CEF0;
	Wed, 25 Jun 2025 21:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888702;
	bh=Z2WKL168cXJ8F1NkWpzvfCAqJZ+WPM2aSSsA1qv2Rtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUhMiOwCxguzA2NPceNmCZ36F5n51ixwaZ5MA57ysKCcLYMUy4cZSb/kzWVVSvYuw
	 gb0PsX5wFpjwAhRhV2b8LsToGcgvrex2BoGPmU9nZ4Trub9tGyFX7/mXeatbWOV2cn
	 ZE2lbuqIUJNDK42ZBx/NtLqtQKe68W9ybPxdq54jxQMSVS9ZpqWT90PGzRUh4BFVdj
	 iDwSc9DFyl3+2H7V5rhvt0ePBuBKuyZUZUHf+JyxRhIqglp8MfvcB0mg38ZBzKo/VL
	 jNzQVRjq1jZEDA/OfT8Qudmnh0n2Re5Gbdt+//tB8dX4EvP0pN9EWs+mczBmVdxwOL
	 8/NXOywovdmSA==
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
Subject: [PATCH v3 1/4] gpiolib: acpi: Add a helper for programming debounce
Date: Wed, 25 Jun 2025 16:58:10 -0500
Message-ID: <20250625215813.3477840-2-superm1@kernel.org>
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

Debounce is programmed in two places and considered non-fatal in one of
them. Introduce a helper for programming debounce and show a warning
when failing to program.  This is a difference in behavior for the call
in acpi_dev_gpio_irq_wake_get_by().

Reviewed-by: Hans de Goede <hansg@kernel.org>
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


