Return-Path: <linux-acpi+bounces-14571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A02D1AE708A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30FB51BC4605
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5030A2EACE2;
	Tue, 24 Jun 2025 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRLXlF+n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CA2EAB69;
	Tue, 24 Jun 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796537; cv=none; b=rKFpnfsLe+GZP3sGk4UKOmKu/k7lSfNIt40fr7s5C3TI5Utka/Gv+ZqPYrGKAKikZAuVeqiwkenh9hJmZM9/XoFTSWLDQbPMjTlusXA0vIwsnxR+QzzQdD3bfkGaEakkF+NT20Zww3ib4QjQzaV6O4eB2XCx++O1qhu+me8rFiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796537; c=relaxed/simple;
	bh=HiLl58F6Gv2AQo/z0g4rJ+hxjMfSBzxFLpUEA7pHzgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prvlaAqJEau4AvS38wMxIba/bILX0KhLDohu3jFXp1iEEX2djLbQZ4WUN+TIrqEYQTPR1vuMpEASOxNVd/o2jWyqtSIBL3/iSP+qVpHwBXPzrZ7YvjiP+9CbR/lv1oAy+iAuOsI3xiqgSHJkbz9AwOgHQaStzNv1F/LvOxjH8Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRLXlF+n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACC9C4CEE3;
	Tue, 24 Jun 2025 20:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750796536;
	bh=HiLl58F6Gv2AQo/z0g4rJ+hxjMfSBzxFLpUEA7pHzgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dRLXlF+nhiaHGE841A+FdiMl4r6RM1w7sZg4FsEISW/XvT9xSQergzUypFrPW6lrA
	 MUKFeSV3Yl3gqHOmd1V27pO3CKF2Ad322yC7KPypBGjhV6USPDsVb+QJKfrOKreMz/
	 j7IJAduibsoWEyYf8srB/oxHqwAaq5oVkCGP+iWNmyvB6FV2K1hZllZ1+91jmsGsz4
	 y6R9R1arj3nnYlLIBaApeLrP6I+7zVRt8kUrhJGfK7shq1stOpsv6lbiNLQfnJ5dOU
	 W3j0dn2Hekxyp20cAMaUD75mQw5b+4EX2BokP2pdFj9yEDdY1aL9JdoCZvcBwq7Czc
	 oUnPLgLYeXTDg==
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
Subject: [PATCH 1/2] gpiolib: acpi: Program debounce when finding GPIO
Date: Tue, 24 Jun 2025 15:22:10 -0500
Message-ID: <20250624202211.1088738-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250624202211.1088738-1-superm1@kernel.org>
References: <20250624202211.1088738-1-superm1@kernel.org>
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
 drivers/gpio/gpiolib-acpi-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
index 12b24a717e43f..475cac2d95aa1 100644
--- a/drivers/gpio/gpiolib-acpi-core.c
+++ b/drivers/gpio/gpiolib-acpi-core.c
@@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
 	struct acpi_gpio_info info;
 	struct gpio_desc *desc;
+	int ret;
 
 	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
 	if (IS_ERR(desc))
@@ -957,6 +958,9 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
 
 	acpi_gpio_update_gpiod_flags(dflags, &info);
 	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
+	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
+	if (ret)
+		return ERR_PTR(ret);
 	return desc;
 }
 
-- 
2.43.0


