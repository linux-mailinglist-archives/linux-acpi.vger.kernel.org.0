Return-Path: <linux-acpi+bounces-14656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C461BAE908C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41AB64A6A02
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D929B26E179;
	Wed, 25 Jun 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxLG2Fsh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105626E16C;
	Wed, 25 Jun 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888701; cv=none; b=jqpX3tJISRzA6Mv+LzIQ2MEX1Ai0LYbC9AgExf7xxmW1IinlZrzDbxzdgMpb3iVn6pJLNFRFcF5JfO6mID4ltdtyYBL8jBIcoa+rilNVe4rPquZLaIpA9OgGaBp3Mo+r4DPLUp3LwMA6QXwGllOm+QG2KwLj5Uq+UKOEQ/4gJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888701; c=relaxed/simple;
	bh=2hn641omImvYU5gLtEpaq8RLDoVT/VHEiycegqsfvlk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7pKOL/vPTXZ3tQ2ycE9zcZz5vBKyStbzU0Ieih6y82xga/+PUttHR1aUmFuXauTddqCLODOJ6ZyhDpqq7f7Q0wtVnbljKF+jomIN+NdSbP3M4p6ZGjRwqGi02D2R7xVY6uaQN4Ak0HRyep+6GYS/QQlTgTac779SYebMuZ7G9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxLG2Fsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF3FC4CEEA;
	Wed, 25 Jun 2025 21:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888701;
	bh=2hn641omImvYU5gLtEpaq8RLDoVT/VHEiycegqsfvlk=;
	h=From:To:Cc:Subject:Date:From;
	b=mxLG2FshFo6jEwPQpg9c5Hpjvy/mrynHZoMJxOWA1rGV9rYsRGVLCb36OyG7zZwTI
	 ubPm5a/hm7BjJOOhDqmpqXMn9skGhLNqd42a+IXPtJ01dGOHXTzx84TuFVEmbnCEPu
	 coQm9DaXHhtEAnoeM98sh9iYXVl61Ls+i4pA0rnar+CfDV8gRT+MmDNtnpw103NLvG
	 iUWRgiySlDgtuY8BLBBLHQ9pvwQ5rKBs6uFo423iUHc5MCQuUE4m7mIrTsewck/ZNW
	 u+bmGb8AmK2aWzDwO23CPg26XiWR50Ob5SvfcHUIZXb6MU2vQFbPd1nbGP8PKD2anS
	 bxxxd4gg9Ii2Q==
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
Subject: [PATCH v3 0/4] Fix soc-button-array debounce
Date: Wed, 25 Jun 2025 16:58:09 -0500
Message-ID: <20250625215813.3477840-1-superm1@kernel.org>
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
v3:
 * Use Hans suggestion to force software debounce instead of a quirk
 * Fix a resume issue identified from testing this series

Mario Limonciello (4):
  gpiolib: acpi: Add a helper for programming debounce
  gpiolib: acpi: Program debounce when finding GPIO
  Input: Don't program hw debounce for soc_button_array devices
  Input: Don't send fake button presses to wake system

 drivers/gpio/gpiolib-acpi-core.c      | 25 ++++++++++++++-----------
 drivers/input/keyboard/gpio_keys.c    | 14 ++++++--------
 drivers/input/misc/soc_button_array.c |  1 +
 include/linux/gpio_keys.h             |  2 ++
 4 files changed, 23 insertions(+), 19 deletions(-)

-- 
2.43.0


