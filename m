Return-Path: <linux-acpi+bounces-15710-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85B2B26EFB
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 20:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10828AA5A62
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 18:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820F0230D0E;
	Thu, 14 Aug 2025 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elnkcXlZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F12230278;
	Thu, 14 Aug 2025 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755196485; cv=none; b=AZ1UmUsXvHYaXYaHt12oRb4j630hWHGVGk5z1NVGaXZhOZG8V+ZmQ1Ou+0ae2qMTYhqhce1kaE+j7K36ugNrJcpIqLzX+MI71MjvZ7C7LrClr0CkKjMUZ8a/SOUo3RqGoQtaIK4Zv1gDuWMm2dw7Yh7jbp505eQ/wZ1dafJHhjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755196485; c=relaxed/simple;
	bh=JsrkGH+OfXdxRlOlkiGQUh/gOET2RUTxQk3rIzAsfM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugXrZODvR8N2m6eVrE8yPAeN+Qf9N5WtEJuN7qZ8xEdCogiM/PBaCYxBjZNOx6EIRQDP1w/w+IWI6jml+113XrVn9ulZ8772CzecOaWMXD5iGWt94XqwKGWEgMAn8EJbYLeycHy8owOo5G32fISAQX0ARdlxZhFTylQFWmN3AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elnkcXlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2310DC4CEEF;
	Thu, 14 Aug 2025 18:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755196483;
	bh=JsrkGH+OfXdxRlOlkiGQUh/gOET2RUTxQk3rIzAsfM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=elnkcXlZjn32P4I1NmJ2HPHacZKcNBcYaqNMImjpW2t2rXwmONtRArJ36kvZ7779S
	 6683O39QN4jaO1v3AIY43MgqWwaGuLGRyN/iS7sJ0vdXCP1xH1uXkGMZDEr4gVu1EM
	 YYPayhxoBwnnFXNe9ryUXKzCdhrVEfoe2yxmqodSTZVb/eeIMaGV0TZ9zowemwRf2C
	 SQ/UgDBUmrha5cykhygt28FuzqzwQCJqXsFRYvMEc1ZaR1DdQC7iPaZRcT4Y44yzdd
	 4viOoyjlgzxk18oyOkX1ttC302PFOYesFaGlmFB0GnfsLafh99qH/S52ty3gVQgh5G
	 rbFLPFLJHRlog==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mika Westerberg <westeri@kernel.org>,
	linux-gpio@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-acpi@vger.kernel.org (open list:GPIO ACPI SUPPORT),
	linux-input@vger.kernel.org (open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)...),
	"Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 2/2] pinctrl: amd: Add PM debugging message for turning on/off wakes
Date: Thu, 14 Aug 2025 13:34:30 -0500
Message-ID: <20250814183430.3887973-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814183430.3887973-1-superm1@kernel.org>
References: <20250814183430.3887973-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GPIOs for devices not in _AEI/_EVT such as touchpad or touchscreen
won't have wakeup turned on until the suspend sequence starts.

Due to code in amd_gpio_suspend_hibernate_common() masking the interrupt
can make this difficult to follow what's going on.  Add an explicit
debugging message to tell when that was turned on/off.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/pinctrl/pinctrl-amd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 09a5425d54ba3..127eeb0104d85 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -448,6 +448,9 @@ static int amd_gpio_irq_set_wake(struct irq_data *d, unsigned int on)
 	u32 wake_mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
 	int err;
 
+	pm_pr_dbg("Setting wake for GPIO %lu to %s\n",
+		   d->hwirq, str_enable_disable(on));
+
 	raw_spin_lock_irqsave(&gpio_dev->lock, flags);
 	pin_reg = readl(gpio_dev->base + (d->hwirq)*4);
 
-- 
2.43.0


