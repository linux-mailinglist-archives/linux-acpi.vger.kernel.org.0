Return-Path: <linux-acpi+bounces-14658-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C356FAE9094
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B49E4A6BFA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF3026FA46;
	Wed, 25 Jun 2025 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce+eLsJ7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A67826F449;
	Wed, 25 Jun 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888704; cv=none; b=e6PAZLCagyDUFLZadkzW0YDdW9ALWpi8w1d03eClOTZYkkfTY9D5HJBio15vJZTRyNDasiv4sGjbkiqc7nAH0jP9LxbDHe5hriwlFu75HuDNV6nO32Y2avxr1Z/d9ZZeaa2zkvLq9DX9iY71bL/Nr8w7IN06Rz2DMdgiE23miuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888704; c=relaxed/simple;
	bh=z815aTTUMjos3+EejYF0XH/3lvGqimvdDnLP8EgVhNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to21Sa18HbzEyPXmWa/FTxDtZ+cUqpmcmSSHVDT2hv2G3c2F17w9wfTIxtgP5x36QDhM8mwcLdSNscCXy+W7IPCPtmClQV9Roch0dihobGlNoG9+ebNcLsGnoIMH4/v8NoDFe3j1YkNz3yc2iO51zi4FPu2LYgqPObsEjK3+FSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce+eLsJ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9F5C4CEF1;
	Wed, 25 Jun 2025 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888703;
	bh=z815aTTUMjos3+EejYF0XH/3lvGqimvdDnLP8EgVhNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce+eLsJ78eGecQH2UWxGYFxV0DQSZbvw6d5URzDd4dqiCEncOsTjSuBZGsN56O1Rf
	 kmmXau1GUR3qu6+vXJ3GH0rE+NGPYTt4P17waXAF4sPYGr0jD1JOUbbpLYfZRRsXec
	 DpvlCOKozIHyoJT7pAE8KJxTUPVlCVhsl+7lqXR+/VX5wSM7nfmkVlOlr5s9TFFpsG
	 WLRHYiR9uZQiO0hN1svPZbORGvdC8r3WsA5bDIcY2HLM9MwOUtQ+TaenteFQMQ6XZs
	 8ZQ3OFTcHC6lv35pWZPKdjJbUBd8HBytwUdaJG8XgLNw0+VviBRHSr/dac7XH1N2ZG
	 2DplRri/Lsmkw==
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
Subject: [PATCH v3 2/4] gpiolib: acpi: Program debounce when finding GPIO
Date: Wed, 25 Jun 2025 16:58:11 -0500
Message-ID: <20250625215813.3477840-3-superm1@kernel.org>
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

When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
which will parse _CRS.

acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
gpiod_get_index (drivers/gpio/gpiolib.c:4877)

The GPIO is setup basically, but the debounce information is discarded.
The platform will assert what debounce should be in _CRS, so program it
at the time it's available.

Reviewed-by: Hans de Goede <hansg@kernel.org>
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


