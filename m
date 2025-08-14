Return-Path: <linux-acpi+bounces-15709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F11B26EFA
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 20:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80B0FAA484C
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 18:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F906229B12;
	Thu, 14 Aug 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0Ur2pFm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525B81F17E8;
	Thu, 14 Aug 2025 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196483; cv=none; b=Cui/EjLMwk/qDU3AmgkpmSlYJp0L6Tz060rKBbV6FKvgZyvEv+lSFs6lSHKmbP52L88pIaAeAIT0MOJE3ZQFMXj52juuE41nytVCjGSQ4/wZRAm4OqhWsLWK4UikzsFrd86pOmGjNgF+mtXcnfAJl/kTgM8IXPc2+8ljy0WNHKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196483; c=relaxed/simple;
	bh=KcnvQ+2Mg7vqTBYoonDuT8ouwkhD3sgg4o8J43s5bSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrpOtm7wffHscG+AZVBB5o4YXBhJKS/MK4+0eFZsGAMUddE0AAJ6zSyeVyYi9KJG7gEDPwWKj5HlOdpydSe5os7QdzX7dBiEMCmLskydij1y+7r9tjH0yu2vQnjbL5X8rQmqTFhEyd5MHl4DxJ7TPOHu0TTdo5Tzxr5kRNj2bPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0Ur2pFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E19C4CEED;
	Thu, 14 Aug 2025 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196482;
	bh=KcnvQ+2Mg7vqTBYoonDuT8ouwkhD3sgg4o8J43s5bSQ=;
	h=From:To:Cc:Subject:Date:From;
	b=d0Ur2pFm0ZP48Mw6klRUT8j4koklQmINneOZBM7M5dfae+6v8ZqRi/KGun4X0D1ey
	 vYfm773Qp8KgVi0PpWPScg+WOyabQAkTLQNUpJB2eG4SXib+hicKjTxBx2rPOa79jf
	 GMemwmadrn2pLHjvOdMgCmz9jciSqBDzYLaCrFksagieUX0s9fExRVTAGrQdTWYFyE
	 9LuWYUEwIb1L0To58Etd2rV9DyTttfj5rQXcNO3qbECfavmGO7ChvvKIsqoHrLkwyh
	 rNYkkWjbkT6RIL0B92Z3JNTh3t+NboiLIeGuztoyaWnBWCP6YqAYSSpgHxlAh8Baem
	 R5N818YY9pFeg==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <westeri@kernel.org>,
	linux-gpio@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-acpi@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Amit Chaudhari <amitchaudhari@mac.com>
Subject: [PATCH 1/2] gpiolib: acpi: Add quirk for ASUS ProArt PX13
Date: Thu, 14 Aug 2025 13:34:29 -0500
Message-ID: <20250814183430.3887973-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ASUS ProArt PX13 has a spurious wakeup event from the touchpad
a few moments after entering hardware sleep.  This can be avoided
by preventing the touchpad from being a wake source.

Add to the wakeup ignore list.

Reported-by: Amit Chaudhari <amitchaudhari@mac.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4482
Tested-by: Amit Chaudhari <amitchaudhari@mac.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpio/gpiolib-acpi-quirks.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpio/gpiolib-acpi-quirks.c b/drivers/gpio/gpiolib-acpi-quirks.c
index c13545dce3492..bfb04e67c4bc8 100644
--- a/drivers/gpio/gpiolib-acpi-quirks.c
+++ b/drivers/gpio/gpiolib-acpi-quirks.c
@@ -344,6 +344,20 @@ static const struct dmi_system_id gpiolib_acpi_quirks[] __initconst = {
 			.ignore_interrupt = "AMDI0030:00@8",
 		},
 	},
+	{
+		/*
+		 * Spurious wakeups from TP_ATTN# pin
+		 * Found in BIOS 5.35
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/4482
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt PX13"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "ASCP1A00:00@8",
+		},
+	},
 	{} /* Terminating entry */
 };
 
-- 
2.43.0


