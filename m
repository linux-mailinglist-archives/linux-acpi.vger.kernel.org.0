Return-Path: <linux-acpi+bounces-14570-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA81AE7085
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8589917B371
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110852E88B3;
	Tue, 24 Jun 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4eC1VJh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C01C84DF;
	Tue, 24 Jun 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750796536; cv=none; b=tEjOvTZ7xPi3Kqr3WE72I4jLaC2peo4lFwwSDYHIqw8c3ilJA6YI1JLAQ6FhFGpmsejIL7xIOpB+Jvo97ZxFBkIQdkIATqr2V04xVypTOVjD0BZxRN4OcPlVqlHBgi1aGylkWy7tCX3L2cjSJXLhBeBsWhmPnu7CPdHyzkHl1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750796536; c=relaxed/simple;
	bh=6auYCtU+8baJ0FLq4ANhah9LDZ1XhBI5uIF6MnrAl54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n/udYdC0sYNbwoqlbvA8oA/Q+arWjo8gfSx2AolcFcV4FGUIV6Rhh95A+sA5z6HB14L2taNp23kxlMU/2xufDJ1B7JBO/NhjE8e/yAVOyluooMa/Iexsp53drX69XNhBG+yDPivnYpOfqLu7StdWE/ncnAhBtbMa/wWy0P7ejI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4eC1VJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E4C4CEEF;
	Tue, 24 Jun 2025 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750796535;
	bh=6auYCtU+8baJ0FLq4ANhah9LDZ1XhBI5uIF6MnrAl54=;
	h=From:To:Cc:Subject:Date:From;
	b=Y4eC1VJh4kgei481XqjkJ/ydH3v2V95pamb0n+1at0+9jrNNYNNIvE7CRH3gsRh14
	 zyjLSfOCXiwxX28mjgmV/ZxLkNdcc6jo8kfACM/gqX3T1O0eIx0aGhRL6hDgLKBF4T
	 HTjLDCJKJ5e3DGBHLlOvjGV6dLFJ7luv2cmPBqBlb/fJHE3/OcbVYDtsM6NiKEN7v1
	 JuhLbq5ESG+Z2HGFHeiErITWa2g5PkWTuSZi+fmgS+JNTcC5ZBVXE8EAsTmkAjM7r0
	 L9U/8N2DGOevqa/sl0g2fJM2ZucQdxwQiyFTdc6PQZoNdX55WjUJKtahlJV191FcOg
	 Wear+dm8dScMg==
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
Subject: [PATCH 0/2] Fix soc-button-array debounce
Date: Tue, 24 Jun 2025 15:22:09 -0500
Message-ID: <20250624202211.1088738-1-superm1@kernel.org>
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

This series add that programming path and then drops the hardcoded
value.  Hopefully Hans can confirm this continues to work on the
hardware that he originally developed the hardcoding for.

If it doesn't work on that hardware, I think it's more scalable
to introduce a quirk for it so that the kernel can at least set
the values intended by the firmware.

Mario Limonciello (2):
  gpiolib: acpi: Program debounce when finding GPIO
  Revert "Input: soc_button_array - debounce the buttons"

 drivers/gpio/gpiolib-acpi-core.c      | 4 ++++
 drivers/input/misc/soc_button_array.c | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.43.0


