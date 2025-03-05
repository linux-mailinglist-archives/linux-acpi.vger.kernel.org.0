Return-Path: <linux-acpi+bounces-11873-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2882A50E47
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 23:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCECD169B73
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 22:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA534266596;
	Wed,  5 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6niMgHW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21F26658D;
	Wed,  5 Mar 2025 22:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741212118; cv=none; b=R1iIx8JSaQ2E7EOojR5bf5Am5VAaGQ3Rj+DaCs+wUZV0+4az7xKiBHzdvv01YLouNUXAkBNL/VpYIkETAXzCL2qXnZF8k5h5LUiqWHdj+Vp3G0x84eFOVS3HE3Se7DPwXCprRgwbfQWa0d/DsBDwT5d2b3A5iB6J4B2oFjlaFXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741212118; c=relaxed/simple;
	bh=FJi+gWQ0Qfes3r9kYf5ehvZnEEXi/93JmDdcFqoAk3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZUA4/0uLnhojVfTf8R8kXuJNJI4GIbJoVC5fZr6bYf3XOprCdhBj66s7Z/KnLJZFkU427c8uxT6p/vUryZl7UkXcQ9Rk+J4WMWH/C9nrnLuNO5Xsf96f8NRpP2iaB4Jvg2u5c9D7bo/I6vvOo5eCTwgFofN8hek4d/sJBR1LxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6niMgHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C374C4CED1;
	Wed,  5 Mar 2025 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741212118;
	bh=FJi+gWQ0Qfes3r9kYf5ehvZnEEXi/93JmDdcFqoAk3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6niMgHW0HCcXgv3n3l45rgrnWqNyNPy24UrRulyLbl9suCMcyXK9cKAZNJfmW3UT
	 aG3VBDTvwImVDIfzsNLWMfWeiX+IvQLMn5vmEX7v40oFWQwN+RiJdQOwvbo3cdAcgC
	 mDEFP3mlhoUl6LuBlA/yU7xPEYvE4gKAQECoJeBDLnZwAoixf1nqN0dvwI8co7yUop
	 SI0S+R1qnT6fwSaeKODb+jQEdovhhEx07sFqzqRPJSxK9pPiKzOtYpH9pwWT9NZs6Q
	 3ed9HFPjSk+9i1MUkxLjsMZvdiYd5xCZmbfcxaahe+0VyONQErROCvMnHN2iQxW3sA
	 UR3UNYv2AvdIw==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 RESEND 2/2] pinctrl: amd: Add an LPS0 check() callback
Date: Wed,  5 Mar 2025 16:01:46 -0600
Message-ID: <20250305220146.3932955-3-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305220146.3932955-1-superm1@kernel.org>
References: <20250305220146.3932955-1-superm1@kernel.org>
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
v3:
 * Add tag
---
 drivers/pinctrl/pinctrl-amd.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index 1d7fdcdec4c85..fdda8d1c4f344 100644
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
@@ -909,6 +911,29 @@ static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 	return false;
 }
 
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
+
 static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
@@ -942,6 +967,7 @@ static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend
 
 static int amd_gpio_suspend(struct device *dev)
 {
+	pinctrl_dev = dev_get_drvdata(dev);
 	return amd_gpio_suspend_hibernate_common(dev, true);
 }
 
@@ -1181,6 +1207,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_dev);
 	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
+	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 
 	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
 	return ret;
@@ -1199,6 +1226,7 @@ static void amd_gpio_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
+	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 }
 
 #ifdef CONFIG_ACPI
-- 
2.43.0


