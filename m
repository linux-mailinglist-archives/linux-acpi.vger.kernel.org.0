Return-Path: <linux-acpi+bounces-14619-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158CAE8C0F
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D483A3B6AF7
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0C02D5C8B;
	Wed, 25 Jun 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHnfUBdM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783B91DDC23;
	Wed, 25 Jun 2025 18:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875229; cv=none; b=TrEQXN8RLTf6+ujMaH746VTA3ouGiOQbsM/198WTAk9DLLOg/AbVViNiHoznl01F+zfMHOVOQ3+hLU89BAWjb2NfaVOY0IdZ8Wi3m+C54rjn61ZblAmybq8VzPbfB51gjKLPE+QPuatGzujJd5iIyrpRVC0BvMhxpVNXQ+bVelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875229; c=relaxed/simple;
	bh=9Im5M2S8mlD2pXkykOB+QJIaR/5k4oONgap9yEggcXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJTi9ezScGwDkKEOWECfL4Y6S4gLYdSsig4ragc7ZKtslJnmWmiiGsfn1kt7/ocj1Sk2MowLPPFI/3oDuSZf2RqpKevYZBrlEdhJA4m2jfIjvlL3dBYm6dmaM2ViSNiVsjBPcx2X+5Mo7QX/IkSL/pgRZyCljuVLP+sTo44GVig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHnfUBdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0A8C4CEEA;
	Wed, 25 Jun 2025 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750875229;
	bh=9Im5M2S8mlD2pXkykOB+QJIaR/5k4oONgap9yEggcXI=;
	h=From:To:Cc:Subject:Date:From;
	b=XHnfUBdMGsSmFYJdp/T6JXkW7DnIsO/NiSpIw9DyZT0Szy22sbpwExmBaDtOXBery
	 3+SSP0vWIYC3zadLUklxlC/WH/f5DSiUZ9HdvVJHVBS7uSgiW6z9XOqYeZJjvJbV+N
	 zs9o3ncrHu8ANEHCvcWegdG58IGd8sIu5gDU2TpQJoVdD1U5JLSSZHWE0eWH90su1n
	 aQPx4ut8FmkKeE+c6TMxVO9K5Z9ijW4efGmktk5EAMcwJMUSDyOqyrnNeXuqeIp1HM
	 y2PG7xvcK+vn6kN6rP/1H/yWQrZceqPbDE4yyXw9W+5bUE2uyxwAkMMrAAE/ZH0AlP
	 lDFpSsZLoXmhA==
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
Subject: [PATCH v2 0/3] Fix soc-button-array debounce
Date: Wed, 25 Jun 2025 13:13:39 -0500
Message-ID: <20250625181342.3175969-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

I have some hardware in front of me that uses the soc-button-array
driver but the power button doesn't work.

Digging into it, it's because the ASL prescribes a debounce of 0 for
the power button, but the soc-button-array driver hardcodes 50ms.

Hardcoding it to what the ASL expects the power button works.

I looked at the callpath into the GPIO core and I believe it's
because the debounce value from _CRS is never programmed to the
hardware the way that the GPIO gets setup.

This series add that programming path and then sets the hardcoded
value on on some quirked systems.  Hopefully Hans can confirm this
continues to work on the hardware that he originally developed the
hardcoding for.

---
v2:
 * Add a helper for making ACPI debounce program nonfatal
 * Use a quirk instead of a revert

Mario Limonciello (3):
  gpiolib: acpi: Add a helper for programming debounce
  gpiolib: acpi: Program debounce when finding GPIO
  Input: soc_button_array: Only debounce cherryview and baytrail systems

 drivers/gpio/gpiolib-acpi-core.c      | 25 ++++++++++++++-----------
 drivers/input/misc/soc_button_array.c | 21 ++++++++++++++++++++-
 2 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.43.0


