Return-Path: <linux-acpi+bounces-14660-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8A8AE909C
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4643F3BACD3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAF9270EB3;
	Wed, 25 Jun 2025 21:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHKKCO8J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F5270EA9;
	Wed, 25 Jun 2025 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888706; cv=none; b=Yz5Kn+4ZWKGa0mJYto6OaDUqPifxyyEylT/KC4+yLNIYmDgkFQs8Ldau3GaSZNxLrjceiXhRZAbjynsV4f21VFXJDnKbLAx+fZPY2PFx7izQWNOmf9lopVFEer6R7v+vhNs16lpDQEymkPjXboaIYzKbUis4z/oOmWykQaLVaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888706; c=relaxed/simple;
	bh=/KGAfdZApRqdSBJiStS7lAI+cxyl0kdckHot23fdv4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPhPpBHaAHGZiwVoMlEXO8srCO+t6+4QrDOykH4sprbkA43a5neXxn4NAOeA3ralyOt6CBmrXYmYKeW69ld8jJBh8po323pTful1SMBJwpSf6HSvoC+N6PIN3pk1TcRM0cAvtWhMoGf+9OTyxycW6XS1C53vXM00D+BbBja/H9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHKKCO8J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F417C4CEF0;
	Wed, 25 Jun 2025 21:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888706;
	bh=/KGAfdZApRqdSBJiStS7lAI+cxyl0kdckHot23fdv4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qHKKCO8J3xCyk5qZosNv/nKsmSRr/2T6uVS1g1YU229s4OndgCWhZB6kk/3euHOU6
	 KCZlvXUPFYUldf391z7keLSUi5k05KynMqMLQVs3QK74sEk0TQKnKhIrQEFS1ba2P0
	 36jRSqpTgYavOTXeaLvxE3tidnUggCJTfk0KmSYdAO5gMp0OQRlOt5rI0he00La14e
	 7LX1UQdE4+wscnODknuqUO/Va/lF28toVNV7CPzGO/GkuDlS7BZbRXpkIdRiuE04aG
	 tBI76hkmNvBlVn4KVJh+mWbZZq1acmiogagLnDCi4Mmwc8ypbO9vUKf06hUvvzdYuJ
	 jFDhGwTYC9mow==
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
Subject: [PATCH v3 4/4] Input: Don't send fake button presses to wake system
Date: Wed, 25 Jun 2025 16:58:13 -0500
Message-ID: <20250625215813.3477840-5-superm1@kernel.org>
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

Sending an input event to wake a system does wake it, but userspace picks
up the keypress and processes it.  This isn't the intended behavior as it
causes a suspended system to wake up and then potentially turn off if
userspace is configured to turn off on power button presses.

Instead send a PM wakeup event for the PM core to handle waking the system.

Cc: Hans de Goede <hansg@kernel.org>
Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/input/keyboard/gpio_keys.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 773aa5294d269..4c6876b099c43 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 		pm_stay_awake(bdata->input->dev.parent);
 		if (bdata->suspended  &&
 		    (button->type == 0 || button->type == EV_KEY)) {
-			/*
-			 * Simulate wakeup key press in case the key has
-			 * already released by the time we got interrupt
-			 * handler to run.
-			 */
-			input_report_key(bdata->input, button->code, 1);
+			pm_wakeup_event(bdata->input->dev.parent, 0);
 		}
 	}
 
-- 
2.43.0


