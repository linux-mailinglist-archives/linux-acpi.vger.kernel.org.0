Return-Path: <linux-acpi+bounces-13388-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D5AA53A3
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 20:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83A7500295
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Apr 2025 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCB264F96;
	Wed, 30 Apr 2025 18:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="Ckf6iXag"
X-Original-To: linux-acpi@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD8D264637;
	Wed, 30 Apr 2025 18:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746037671; cv=none; b=lHuY8wN1aHwFil6gIfeyZhuZZyQDI8PNlxg5nUAFKAPSaqkC6MD1FK9+GAizK/ZkG9vgEkAIRXT5oVuJixHx9HKXpS4ThDd/nq3SIvqWBGXno4akZ00h2Vib66rzKp7Cp3+Grim/8ntgdVRGf4nzb7Pf0uIowxOuz5zP3kniV7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746037671; c=relaxed/simple;
	bh=BAnu53X6LUhNIJoXvEr0FZYi1TI93lQ+xX62tTdscNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HO+KlPRYjATbORfkxx/8/fOgiYsWVeaVhDZY6eq/PDaLNEZTcw9J+sfqcMiYwcKoRgOsDvQt13C18lfHgYNCYXCdeiSs+Umfjrr/2BHD+T4Bn7fxiMyX8hGySvt4KzEpsxT2+6/pxj/8INLVX5TWSpKP2ZERUE4J42OTOaYYPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=Ckf6iXag; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [217.114.34.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 5A6FE666854;
	Wed, 30 Apr 2025 20:27:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1746037661;
	bh=BAnu53X6LUhNIJoXvEr0FZYi1TI93lQ+xX62tTdscNE=;
	h=From:Subject:Date;
	b=Ckf6iXagpU23zp9V/WVAVTY/2vc3c9NUaz4YTy+UK6EfUYSysN/pgMpEbPMkXfAIn
	 BinPDShn4fU7MmcdwlnXXH3ZcVEhPAAqkepYfoYMd1R8y4vurcKhmvl1bR10wwpRei
	 Mln2Uzvl+6EkDu2iGHJBEjN3OIZT8bck/1nWpSnUDfG4kYaGaXrj5bLM23eU5lTAxV
	 LohGuSqf+CdU/QHD1mKFV3vUYqb/SOlC1p4ZEEHyi19qctA5N27rvW2/2wtQBk4rxD
	 6gjVeHyUZIxzPxfTtEXjAwwxCRl6JBuVwdb0BNU6BAw5PmHBgxUpyIFWw4UkXr1n8y
	 rHsXP5Z8LWJhQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Mario Limonciello <superm1@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Subject:
 [PATCH v1] pinctrl: amd: Fix hibernation support with CONFIG_SUSPEND unset
Date: Wed, 30 Apr 2025 20:27:41 +0200
Message-ID: <5889368.DvuYhMxLoT@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 217.114.34.19
X-CLIENT-HOSTNAME: 217.114.34.19
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejgedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepgeffhfdujeelhfdtgeffkeetudfhtefhhfeiteethfekvefgvdfgfeeikeeigfehnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddujedruddugedrfeegrdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvudejrdduudegrdefgedrudelpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrjhifsehrjhifhihsohgtkhhirdhnvghtpdhnsggprhgtphhtthhopeekpdhrtghpthhtohepshhuphgvrhhmudeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushd
X-DCC--Metrics: v370.home.net.pl 1024; Body=8 Fuz1=8 Fuz2=8

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After recent changes, pinctrl-amd will not support hibernation when
CONFIG_HIBERNATION is set and CONFIG_SUSPEND isn't because it will not
register amd_gpio_pm_ops then.

Address this by restoring dependencies on CONFIG_PM_SLEEP where
necessary for hibernation support.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Mario, this is on top of:

https://patchwork.kernel.org/project/linux-acpi/patch/20250414203551.779320-1-superm1@kernel.org/

which is currently in my bleeding-edge branch only.

---
 drivers/pinctrl/pinctrl-amd.c |   63 ++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 27 deletions(-)

--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -894,26 +894,7 @@
 	}
 }
 
-#ifdef CONFIG_SUSPEND
-static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
-{
-	const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
-
-	if (!pd)
-		return false;
-
-	/*
-	 * Only restore the pin if it is actually in use by the kernel (or
-	 * by userspace).
-	 */
-	if (pd->mux_owner || pd->gpio_owner ||
-	    gpiochip_line_is_irq(&gpio_dev->gc, pin))
-		return true;
-
-	return false;
-}
-
-#ifdef CONFIG_ACPI
+#if defined(CONFIG_SUSPEND) && defined(CONFIG_ACPI)
 static void amd_gpio_check_pending(void)
 {
 	struct amd_gpio *gpio_dev = pinctrl_dev;
@@ -936,8 +917,40 @@
 static struct acpi_s2idle_dev_ops pinctrl_amd_s2idle_dev_ops = {
 	.check = amd_gpio_check_pending,
 };
+
+static void amd_gpio_register_s2idle_ops(void)
+{
+	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
+}
+
+static void amd_gpio_unregister_s2idle_ops(void)
+{
+	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
+}
+#else
+static inline void amd_gpio_register_s2idle_ops(void) {}
+static inline void amd_gpio_unregister_s2idle_ops(void) {}
 #endif
 
+#ifdef CONFIG_PM_SLEEP
+static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
+{
+	const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
+
+	if (!pd)
+		return false;
+
+	/*
+	 * Only restore the pin if it is actually in use by the kernel (or
+	 * by userspace).
+	 */
+	if (pd->mux_owner || pd->gpio_owner ||
+	    gpiochip_line_is_irq(&gpio_dev->gc, pin))
+		return true;
+
+	return false;
+}
+
 static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
 {
 	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
@@ -1211,9 +1224,7 @@
 
 	platform_set_drvdata(pdev, gpio_dev);
 	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
-#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
-	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
-#endif
+	amd_gpio_register_s2idle_ops();
 
 	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
 	return ret;
@@ -1232,9 +1243,7 @@
 
 	gpiochip_remove(&gpio_dev->gc);
 	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
-#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
-	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
-#endif
+	amd_gpio_unregister_s2idle_ops();
 }
 
 #ifdef CONFIG_ACPI
@@ -1251,7 +1260,7 @@
 	.driver		= {
 		.name	= "amd_gpio",
 		.acpi_match_table = ACPI_PTR(amd_gpio_acpi_match),
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 		.pm	= &amd_gpio_pm_ops,
 #endif
 	},




