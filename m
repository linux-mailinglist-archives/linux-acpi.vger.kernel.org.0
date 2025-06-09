Return-Path: <linux-acpi+bounces-14228-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32CAD16DE
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 04:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03B431690BA
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Jun 2025 02:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1252E2459F2;
	Mon,  9 Jun 2025 02:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIVMU2oK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6322459D8;
	Mon,  9 Jun 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749436477; cv=none; b=m/HLRlK5YF8vx23v3ZAnr6jVczECDjc4BrcqkYlo8HN0ACpI8RDHZyFLi0BHlUm1hmQcyI6SVIba2YePUZr1h0sVaoLOCLrdbbJsRkRv1DJ9N51YEUXT1P1KMF+oxJZT9VjjPBm75mmA7fDGJ0NLrLSorLSXe+2GQI1hbOo4zIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749436477; c=relaxed/simple;
	bh=UiTxvyaWkJtVvCM1n2gSps6GKf91xTUWK+4KWKfKPY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EtXkMjySYdStW7tcE9pX+sG/I6WgO5G4e2ZuQFjB/e5j7Xon8EekRlTkHu221a/THWTIhl1WfvP//9G6C6zPHO8XMae8arvIPJpm6ktds2M9RGxT5Ibn8eRCrAGw9/Tpc0KH4HyALGGouQPvVSFUANyRdQ1keLjISosMkIiZls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIVMU2oK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C898BC4CEEE;
	Mon,  9 Jun 2025 02:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749436476;
	bh=UiTxvyaWkJtVvCM1n2gSps6GKf91xTUWK+4KWKfKPY8=;
	h=From:To:Cc:Subject:Date:From;
	b=OIVMU2oKh2pYkrlRrBk2DoHQ6NkXiG72dcFcXHdjt0qwSi76lckGvrZQjDrDoXgp8
	 mM2LvgFU/1iQ2eESkFOlM8wB9wqvxzs6zsCM8vKvayOzniRkb6cU2W3eqIYb9O438Z
	 k+3nydtf7T/xVI+qpVdACsbt9pDJ7gQB5BMF7HMLlbtZUQNpR5TZgD3USxCTGNxVQ3
	 7J/dqpH6oIPtoTFTyvuO+oGBthF5h/Zh+lFZrDP3RVcAV9dIqO/tdheT5yiQVSqcMO
	 UbsKbyBj1jMFllNU8oSNzW0KM1rB7Fk9H0BAOsw5gaG4D7fegmzEasGHUZiMwLGb2m
	 v/RuJbyg1/IHQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	westeri@kernel.org,
	andriy.shevchenko@linux.intel.com,
	linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] gpiolib: acpi: Add a quirk for Acer Nitro V15
Date: Sun,  8 Jun 2025 21:34:08 -0500
Message-ID: <20250609023424.372827-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

It is reported that on Acer Nitro V15 suspend only works properly if the
keyboard backlight is turned off. In looking through the issue Acer Nitro
V15 has a GPIO (#8) specified in _AEI but it has no matching notify device
in _EVT. The values for GPIO #8 change as keyboard backlight is turned on
and off.

This makes it seem that GPIO #8 is actually supposed to be solely for
keyboard backlight.  Turning off the interrupt for this GPIO fixes the issue.
Add a quirk that does just that.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4169
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index 219667315b2c5..c13545dce3492 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -331,6 +331,19 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@11",
 		},
 	},
+	{
+		/*
+		 * Wakeup only works when keyboard backlight is turned off
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4169
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Acer Nitro V 15"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_interrupt = "AMDI0030:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.43.0


