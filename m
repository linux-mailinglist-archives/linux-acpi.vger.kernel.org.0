Return-Path: <linux-acpi+bounces-14621-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31415AE8C14
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12A03B75D3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416E62D9EE1;
	Wed, 25 Jun 2025 18:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwIc5LG2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101DC2D9EC7;
	Wed, 25 Jun 2025 18:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875232; cv=none; b=kpns5b1YYGWXxM3gvg7123nvo99bX+vKNAaeiZUP2f4hPzuapUOje+qCabsJVF/SqqgV06F7NRO/Z5NEg2GPb8hGp80Mzw5cnzFJ/wxWcvTp8Ur5r7yHsOXA3zZBkh9TOO7gDtiIBie3vp/rjHntNIc4zmFDfuCX45Im1iz724c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875232; c=relaxed/simple;
	bh=lksmwFiNMaOB0EB1yOrYNkbcqmcTRwmvkj9Sp2AXrWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGQj2WkjegpQNZ3mFSaIeSNLZwkAkD5yXDfoDxkc6NmFBkVuXjlQfHHyXtjO7YgV8Oe7cE1ppVSA2BqTFpg/qbv9ml8lTLU5JhCst/+3e4wsIRgIqD19JAdkpFF4zWgelHD8QLOeuWipM2c+IdmO1LWhUlhNTqnFPNTspgr2cqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwIc5LG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A86CC4CEEA;
	Wed, 25 Jun 2025 18:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750875231;
	bh=lksmwFiNMaOB0EB1yOrYNkbcqmcTRwmvkj9Sp2AXrWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PwIc5LG275lM9HXjvC3gfbsPDz8jwR15yC4lm2dhfKfen1qpGGafAuqZ0hsHkpZsc
	 7QtQe8T5k4J45msYv3AsAYcWpjJxbTYni80ZqJfpjNLSh9qMRIwd3XCgN9+KcHYHp4
	 PQVT6MdWKe8nNU4ZKjk1ICPBPkVfdpjsOl4qnftk2l2XFsCPdleIP4fc06c6uOlP2Y
	 JKC68QCxTa/oqur2rGvhAQL2FLFGinbuknB8225sRWnZyNpZM0Ke6tHmW7Mk8pTi11
	 F3hu/VnmFFXWsXJyUW0JWltamOH9/X2BnHj3RVdEGi+zwMTDt3FoTHHd9nYfbbsTrK
	 Fo0SjTeb7SciQ==
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
Subject: [PATCH v2 2/3] gpiolib: acpi: Program debounce when finding GPIO
Date: Wed, 25 Jun 2025 13:13:41 -0500
Message-ID: <20250625181342.3175969-3-superm1@kernel.org>
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

When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
which will parse _CRS.

acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
gpiod_get_index (drivers/gpio/gpiolib.c:4877)

The GPIO is setup basically, but the debounce information is discarded.
The platform will assert what debounce should be in _CRS, so program it
at the time it's available.

Cc: Hans de Goede <hansg@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 * Make non fatal by using helper from patch 1 (Andy)
---
 drivers/gpio/gpiolib-acpi-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 1895e45bd9f16..15222bfc25bb2 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -962,6 +962,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
+	acpi_set_debounce_timeout(desc, info.debounce);
 	return desc;
 }
 
-- 
2.43.0


