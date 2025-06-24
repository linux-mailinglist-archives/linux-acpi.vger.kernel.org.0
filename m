Return-Path: <linux-acpi+bounces-14572-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210D5AE708E
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A9917E014
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EAD2EBBAE;
	Tue, 24 Jun 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYZK8vQi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610162EB5D6;
	Tue, 24 Jun 2025 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796538; cv=none; b=h7H2NDHMH3eszKBhnwQuGwpniyXOHgvPAu8ozl6Ka6QYkwB3DLvLTEhj0N70rFAXGLBkZEw9XsYwQromeQL3tB48EOAIaYEU7tSz3F1LOrG4p65SkD/lBlrTpB1kPF+aIDSDU6Ex4chVVqHjCe/KdVOCm8i34qv3uY8Uh7QBYHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796538; c=relaxed/simple;
	bh=HLXNIk3gpWw9VgeSDEKEQ32I2877gEB7XVEX8am4+r8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pX3bkRyRan7sGMoHWueHSk6PEDr4Ox+NMhFVP6paG64m6+OHVa3nWhbqUxFRGOunrFlt5HoU9Wo8zEX0AJXa7a8FmIzP9MXZXsYf3lIvN63dV74Lf/RVMMHuYIuL2JSLHIDPF+PhPIPjA5IDgkCrMTBY1oge9GKY2z01dblyVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYZK8vQi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFE3C4CEF0;
	Tue, 24 Jun 2025 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750796537;
	bh=HLXNIk3gpWw9VgeSDEKEQ32I2877gEB7XVEX8am4+r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYZK8vQiyMKWg476/O3PIE7nh0t8GIDBtr+BJalqkM7iohocAkb/DCBc4YjTrXKzZ
	 CIhBnz/m7FvUSamvM4dX84TatEImTjOdjr1v4lWl4lnfDMeJHpDFHA8IIvwrmEWPnK
	 dAJHOsOKms8yZYTVswEvx5PuxJP7VhqRwdcW4yy+Aw2u2UZ9q5iaflSDF2Dx1cpxj4
	 Kx/ZdH0w9lR57R/0lChbAMtcyiIvd9LaAHVWc9ZHuXdQbsZK2OxPQpDG1KdOo3l/St
	 XmccVxedMMoy8Q6hK9HmzQMvHRfa23orORuLOZce0LLLfzajFUL/pNvkvWJIB1AGdI
	 FB0QhAvew2phw==
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
Subject: [PATCH 2/2] Revert "Input: soc_button_array - debounce the buttons"
Date: Tue, 24 Jun 2025 15:22:11 -0500
Message-ID: <20250624202211.1088738-3-superm1@kernel.org>
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

commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
hardcoded all soc-button-array devices to use a 50ms debounce timeout
but this doesn't work on all hardware.  The hardware I have on hand
actually prescribes in the ASL that the timeout should be 0:

GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
         "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
{   // Pin list
    0x0000
}

Let the GPIO core program the debounce instead of hardcoding it into a
driver.

This reverts commit 5c4fa2a6da7fbc76290d1cb54a7e35633517a522.

Cc: Hans de Goede <hansg@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/misc/soc_button_array.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b8cad415c62ca..99490df42b6f2 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -219,8 +219,6 @@ soc_button_device_create(struct platform_device *pdev,
 		gpio_keys[n_buttons].active_low = info->active_low;
 		gpio_keys[n_buttons].desc = info->name;
 		gpio_keys[n_buttons].wakeup = info->wakeup;
-		/* These devices often use cheap buttons, use 50 ms debounce */
-		gpio_keys[n_buttons].debounce_interval = 50;
 		n_buttons++;
 	}
 
-- 
2.43.0


