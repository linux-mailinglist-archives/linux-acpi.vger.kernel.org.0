Return-Path: <linux-acpi+bounces-12811-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A85CA7EC0B
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 21:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEE71890B2A
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Apr 2025 19:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6305F25F790;
	Mon,  7 Apr 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYGDdjER"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC725F782;
	Mon,  7 Apr 2025 18:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051034; cv=none; b=fULPqvx0O0yST5GfW5LuzZFON/2Olw7+ouHi5eFdpkOoB7sHl4BB1Bw6AeWrbyEGGHmU5X3WSPQbb5UiEGyiiJxiChdc1Wr4D5vco5z7vKVTW9Hot6b87Brnksgacso7V6Y1G9GFeMNE9fX8DTJ7d0q2t8wkcKarzw29/P3rq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051034; c=relaxed/simple;
	bh=YYXERR+iiflyYXGubiy0158+C+GzFBpzfQ/WQYZTpao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n4wpL075SEEvsg1A79YHbCRzZaxOroOkU+fGjA8Y8elQfr6Jk4/e5oYZi80OwbzYiXqLQmP8IRRl9Vi7m+Qy4+7fMPsoQwkYdezxC112gI68i0wetAq7PUv0S1FAL4xvretMrqGBrez8glcJdrujeUa+S96h6vpbTpLnJQLop5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYGDdjER; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E62C4CEE7;
	Mon,  7 Apr 2025 18:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051034;
	bh=YYXERR+iiflyYXGubiy0158+C+GzFBpzfQ/WQYZTpao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mYGDdjERK6VRsDJ0dMJVoL4TJSxMaeqkgG3bAApjyxroGFZhhen2Oe4ecPq85EoJc
	 EtvPKqI7lDqwUiGJFmtWBZa6aitaxsN39TF56kw+2aJ5d036geVWCCq8ymRGefeGrW
	 /7nx+g2fBlxp++Cuf4BiYsBVCv3LdEDSe5bJwFaYx3z3lGVgiGw08kZSIl14QyrzDy
	 8Ia6QyqHpZFdYHIbvSAnt9FLyYtkjPywRsh6XWuqQbUr7YL9D6PywkGggWgU9vnapI
	 PE1DecTg2ERGHhR6xRl3IaFINI19xJFpur4xfdCfF8vrfoOOzvUghlBtIA0UibJCBH
	 kc4SRfvMZE67A==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v4 2/2] pinctrl: amd: Add an LPS0 check() callback
Date: Mon,  7 Apr 2025 13:36:56 -0500
Message-ID: <20250407183656.1503446-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250407183656.1503446-1-superm1@kernel.org>
References: <20250407183656.1503446-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

During suspend the pinctrl_amd driver disables the interrupts for
any GPIOs that are not marked as wake sources.

This however does not prevent them from changing the wake status
bit during suspend, it just stops the system from waking.

If the system wakes from hardware sleep for another reason (such
as plugging in the AC adapter) this wake bits might be active.

This could potentially cause problems with going back to hardware
sleep.  Add an extra debugging message when PM debugging is enabled
to help identify if this is happening.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4:
 * Add guards for CONFIG_ACPI (handle COMPILE_TEST build failure)
---
 drivers/pinctrl/pinctrl-amd.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1d7fdcdec4c85..b6fafed79b289 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -37,6 +37,8 @@
 #include "pinctrl-utils.h"
 #include "pinctrl-amd.h"
 
+static struct amd_gpio *pinctrl_dev;
+
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
 	unsigned long flags;
@@ -909,6 +911,31 @@ static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 	return false;
 }
 
+#ifdef CONFIG_ACPI
+static void amd_gpio_check_pending(void)
+{
+	struct amd_gpio *gpio_dev = pinctrl_dev;
+	struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
+	int i;
+
+	if (!pm_debug_messages_on)
+		return;
+
+	for (i = 0; i < desc->npins; i++) {
+		int pin = desc->pins[i].number;
+		u32 tmp;
+
+		tmp = readl(gpio_dev->base + pin * 4);
+		if (tmp & PIN_IRQ_PENDING)
+			pm_pr_dbg("%s: GPIO %d is active: 0x%x.\n", __func__, pin, tmp);
+	}
+}
+
+static struct acpi_s2idle_dev_ops pinctrl_amd_s2idle_dev_ops = {
+	.check = amd_gpio_check_pending,
+};
+#endif
+
 static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
@@ -942,6 +969,7 @@ static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend
 
 static int amd_gpio_suspend(struct device *dev)
 {
+	pinctrl_dev = dev_get_drvdata(dev);
 	return amd_gpio_suspend_hibernate_common(dev, true);
 }
 
@@ -1181,6 +1209,9 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_dev);
 	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
+#ifdef CONFIG_ACPI
+	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
+#endif
 
 	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
 	return ret;
@@ -1199,6 +1230,9 @@ static void amd_gpio_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
+#ifdef CONFIG_ACPI
+	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
+#endif
 }
 
 #ifdef CONFIG_ACPI
-- 
2.43.0


