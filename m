Return-Path: <linux-acpi+bounces-18088-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E2BFC3E7
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75045540E58
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD8E30ACE3;
	Wed, 22 Oct 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5Ajyn6i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17B726ED2A;
	Wed, 22 Oct 2025 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140242; cv=none; b=s6Sw5zMupV3fB/UHPOo/tSOfBamdOKazZCIXLtKoTr8oQM/3Kf5qMYhAee67p/o/QTh6WPAGz/vLGuMVCISBqaLYVB/FDPT5/VWM5tBkVivZqKWFRDbaZT1+jgCinboIbqTJcLmCZLtNNgjjflETUEwHf230t59QvdWMBPv9TS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140242; c=relaxed/simple;
	bh=jbC9Sb3AKdA6ZHnElBfDO40DRbp3oq6m6FxraEOQX40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0gfJvjN4iGrcyLi43PLmQ5rXMfQMYw3OA6ZBH906DqbjskomSuhiNThPSPW41UDmJT4EdPMoSIEuQot3QwJxkYLVwGg/T2sTWXuhV9WLnIwY7MBFEW7pf5ps/UitVZrXGMO9u7OeJlTVDuRfO4O86PpmCeac5hAFPUrp3U1vzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5Ajyn6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6E8C4CEFF;
	Wed, 22 Oct 2025 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761140241;
	bh=jbC9Sb3AKdA6ZHnElBfDO40DRbp3oq6m6FxraEOQX40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5Ajyn6iWyJIJYkujtYJ74t7yoFj24fi7EU1MpKPhkjmxN28Zs+MpXR7zqi5v8XiL
	 S1bvo42iRe/ZHt/eXS/4SNtq/4XUYNJf1Hbx8syyrFTUtWp9xDqVV/7Xg2gfuganaJ
	 GFK48pAgWzxqGYwPezTwrX9rZaWTMio4hloWs5q9OpOCfNFsJbxPqx/o8jTOeOQUvA
	 bZQWNgGn1ahuiJTUX5rGWGDBOSurvNR6PX7LmKGOmgpSaRZ+W5W1yBxPAuXxpS38w9
	 aAhdUKTSP3tqY2IPxQaYXMKJoZ9D61JgmypQgUcnMOne8pcEY3jlKBAnSlWKBPO3E3
	 p7wz8Jfq9pp/g==
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
Subject: [REGRESSION FIX resend 1/1] gpiolib: acpi: Make set debounce errors non fatal
Date: Wed, 22 Oct 2025 15:37:15 +0200
Message-ID: <20251022133715.331241-2-hansg@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022133715.331241-1-hansg@kernel.org>
References: <20251022133715.331241-1-hansg@kernel.org>
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


