Return-Path: <linux-acpi+bounces-13035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0A6A88D32
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 22:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A36017B5B6
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Apr 2025 20:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFD1DF723;
	Mon, 14 Apr 2025 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtOAHgUD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7B61C1F12;
	Mon, 14 Apr 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744662959; cv=none; b=NTq9QmGLy3OfD/QKjitep3axGJwllIcapIKy/ppNaHBIlEgXo0bMs2gv+eHcIqsfG6iXH+f99NiUQXC9GG4QoIf/n0mjOBOZAHly1/1YnzzPwpvPLoqYtckXyY9B5PyKUnnl44dxfU35RPo46kwt9H6hYk2MXmT+NFYVfydTfL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744662959; c=relaxed/simple;
	bh=1B27944GXEo7IiDxau3WWJV6prqJhzAOsq63BYWFyI8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRWBjxiA8m7fCR/CZtwcWqsKqGj7ahnX/kDj/nacrNjV2IejCDk8kPOauALvGkY9mgwOHTRDHlIWJ4nJOzAw3SWYQOchHKUJ2QDddHM5vqZnEnKED9Mlbk0Q1n2hmBdNNck64vl7kngvL32AvF02sEKBDQJGkFpY60c47LVDYmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtOAHgUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD20BC4CEE2;
	Mon, 14 Apr 2025 20:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744662958;
	bh=1B27944GXEo7IiDxau3WWJV6prqJhzAOsq63BYWFyI8=;
	h=From:To:Cc:Subject:Date:From;
	b=QtOAHgUDZTs9FgjlDAZ2wMj+qWH5Vdd14IzMyJ/7talSBKDgnfILZTXq+mkUGJ+mr
	 Q9hfDGMmrA6Pq9c9yIWOmr13rCBpJU/ZGGd1NwCSVx1F5HD15U+oG1boaZDSHEGJOV
	 tNa+vxVvE6q2JvV93wB5LrCSwx+rcSQVlq619hLUm92X91X+AW2+ih0LEV1MwExDQ6
	 jmBSYw8gNiCNCjlw9UdCJ0Cv7DF0pOJ5X3r6Ba9zC+NpN+bSeNTP/GZ7wfO7xVqQTq
	 qZFdaVbQ8nPn7OCwhxR2LXjo747Ofl+fq7zsF2Zd99PDDKbr1eCZSlin9jPNe+2bnp
	 CZ0jfpnjwaa6g==
From: Mario Limonciello <superm1@kernel.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	linux-acpi@vger.kernel.org,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] pinctrl: amd: Fix use of undeclared identifier 'pinctrl_amd_s2idle_dev_ops'
Date: Mon, 14 Apr 2025 15:35:51 -0500
Message-ID: <20250414203551.779320-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

`pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
`CONFIG_PM_SLEEP` so the functions that use it need the same scope.

Adjust checks to look for both, and while updating make it CONFIG_SUSPEND
instead as that's what the acpi header uses.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2:
 Use CONFIG_SUSPEND instead of CONFIG_PM_SLEEP
---
 drivers/pinctrl/pinctrl-amd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index b6fafed79b289..60252830ff410 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -37,7 +37,9 @@
 #include "pinctrl-utils.h"
 #include "pinctrl-amd.h"
 
+#ifdef CONFIG_SUSPEND
 static struct amd_gpio *pinctrl_dev;
+#endif
 
 static int amd_gpio_get_direction(struct gpio_chip *gc, unsigned offset)
 {
@@ -892,7 +894,7 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SUSPEND
 static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
 {
 	const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
@@ -1143,7 +1145,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 	if (gpio_dev->irq < 0)
 		return gpio_dev->irq;
 
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SUSPEND
 	gpio_dev->saved_regs = devm_kcalloc(&pdev->dev, amd_pinctrl_desc.npins,
 					    sizeof(*gpio_dev->saved_regs),
 					    GFP_KERNEL);
@@ -1209,7 +1211,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpio_dev);
 	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 #endif
 
@@ -1230,7 +1232,7 @@ static void amd_gpio_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
 #endif
 }
@@ -1249,7 +1251,7 @@ static struct platform_driver amd_gpio_driver = {
 	.driver		= {
 		.name	= "amd_gpio",
 		.acpi_match_table = ACPI_PTR(amd_gpio_acpi_match),
-#ifdef CONFIG_PM_SLEEP
+#ifdef CONFIG_SUSPEND
 		.pm	= &amd_gpio_pm_ops,
 #endif
 	},
-- 
2.43.0


