Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB043D501
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJ0VYz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236274AbhJ0VYJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:24:09 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB9C0432D6;
        Wed, 27 Oct 2021 14:18:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id y26so8915758lfa.11;
        Wed, 27 Oct 2021 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C0CUDQ/mpKr8nQVI8ALn1ZNGlMYg+VmEWd/lyCBC2+I=;
        b=Z3brf9Hxnc2b6ua3/QaRBg13ceKk9pypP3vq3e3axfEBPvBW41vI/qfBl8+BwawzwO
         NlHu2lL93XTrvXoS8prTqJO+oc3t3LVioKZpz1/2twqHxmO2Rep4n956JPepAb55tnvu
         Yq8u1nymmyHqcHNTOwToESfBr2ALI5JLRcu8Vew43TUipSvAyYGlhtxcdEE10JjxQ8L7
         CgvM26J/cz900816o54jCXMSmEWOFUvtpqIxxDad09smC+hGdBM0SBN82Upy8AJEypnh
         RA0SpOKKidR5e2HsVPYqqyxDECtb4bl9tRIXX4QIA46Li7tlvPD9rk0WAJDNE7RcwF/Y
         YL9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C0CUDQ/mpKr8nQVI8ALn1ZNGlMYg+VmEWd/lyCBC2+I=;
        b=AVO+/vlfCQ20nsufuVN8h0TlDxDqllUNl6p+3teclMHshqWF0YlK54NDb/mf5smCbe
         SImScaYOH9DRjkGXKmMSKAWZpso9GJ9iqF5lVh3nQEEH7Jb4etgeaUpzkKhNDcP0ue8+
         2/r5RMdD0bUfHufmpianyv0Pyn9y2gHh4axgNLRGkeflOIk3ndD5x0ni2Gl+ZU4i2/ja
         QSQKnv6NAIaimT2f6wR5sy00spUBWukM+Y5MwnC6reW9E7J5mdmy40y9k+gXeBlWltJI
         qeiWXq57gxJRud/1rEPwvM5FffvmkZXtjEQDYpuzR/mi1MKchdFIRP73GlJyqz/y/nzI
         14rQ==
X-Gm-Message-State: AOAM532odDhY5tPoqZLh1ItaYCYOJYG4egx+tDV7uUwCz6jCX8+zaeWb
        MCpK2fyJG+IGun4d1gN55Gc=
X-Google-Smtp-Source: ABdhPJw9ag+XL4jMbHM8NK1hhlQp61Q60DmRHFpovh5w79ZSq7lT/XD7C7FFPkBUSvk0m7mbQoA/BQ==
X-Received: by 2002:a05:6512:31a:: with SMTP id t26mr125024lfp.280.1635369523122;
        Wed, 27 Oct 2021 14:18:43 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Pavel Machek <pavel@ucw.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-omap@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v2 27/45] mfd: ntxec: Use devm_register_power_handler()
Date:   Thu, 28 Oct 2021 00:16:57 +0300
Message-Id: <20211027211715.12671-28-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_power_handler() that replaces global pm_power_off
variable and allows to register multiple power-off handlers. It also
provides restart-handler support, i.e. all in one API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/ntxec.c | 50 ++++++++++-----------------------------------
 1 file changed, 11 insertions(+), 39 deletions(-)

diff --git a/drivers/mfd/ntxec.c b/drivers/mfd/ntxec.c
index b711e73eedcb..fd6410cbe153 100644
--- a/drivers/mfd/ntxec.c
+++ b/drivers/mfd/ntxec.c
@@ -32,12 +32,11 @@
 #define NTXEC_POWERKEEP_VALUE	0x0800
 #define NTXEC_RESET_VALUE	0xff00
 
-static struct i2c_client *poweroff_restart_client;
-
-static void ntxec_poweroff(void)
+static void ntxec_poweroff(struct power_off_data *data)
 {
 	int res;
 	u8 buf[3] = { NTXEC_REG_POWEROFF };
+	struct i2c_client *poweroff_restart_client = data->cb_data;
 	struct i2c_msg msgs[] = {
 		{
 			.addr = poweroff_restart_client->addr,
@@ -62,8 +61,7 @@ static void ntxec_poweroff(void)
 	msleep(5000);
 }
 
-static int ntxec_restart(struct notifier_block *nb,
-			 unsigned long action, void *data)
+static void ntxec_restart(struct restart_data *data)
 {
 	int res;
 	u8 buf[3] = { NTXEC_REG_RESET };
@@ -72,6 +70,7 @@ static int ntxec_restart(struct notifier_block *nb,
 	 * it causes an I2C error. (The reset handler in the downstream driver
 	 * does send the full two-byte value, but doesn't check the result).
 	 */
+	struct i2c_client *poweroff_restart_client = data->cb_data;
 	struct i2c_msg msgs[] = {
 		{
 			.addr = poweroff_restart_client->addr,
@@ -87,13 +86,11 @@ static int ntxec_restart(struct notifier_block *nb,
 	if (res < 0)
 		dev_warn(&poweroff_restart_client->dev,
 			 "Failed to restart (err = %d)\n", res);
-
-	return NOTIFY_DONE;
 }
 
-static struct notifier_block ntxec_restart_handler = {
-	.notifier_call = ntxec_restart,
-	.priority = 128,
+static struct power_handler ntxec_power_handler = {
+	.restart_cb = ntxec_restart,
+	.power_off_cb = ntxec_poweroff,
 };
 
 static int regmap_ignore_write(void *context,
@@ -208,25 +205,12 @@ static int ntxec_probe(struct i2c_client *client)
 		if (res < 0)
 			return res;
 
-		if (poweroff_restart_client)
-			/*
-			 * Another instance of the driver already took
-			 * poweroff/restart duties.
-			 */
-			dev_err(ec->dev, "poweroff_restart_client already assigned\n");
-		else
-			poweroff_restart_client = client;
-
-		if (pm_power_off)
-			/* Another driver already registered a poweroff handler. */
-			dev_err(ec->dev, "pm_power_off already assigned\n");
-		else
-			pm_power_off = ntxec_poweroff;
-
-		res = register_restart_handler(&ntxec_restart_handler);
+		ntxec_power_handler.cb_data = client;
+
+		res = devm_register_power_handler(ec->dev, &ntxec_power_handler);
 		if (res)
 			dev_err(ec->dev,
-				"Failed to register restart handler: %d\n", res);
+				"Failed to register power handler: %d\n", res);
 	}
 
 	i2c_set_clientdata(client, ec);
@@ -239,17 +223,6 @@ static int ntxec_probe(struct i2c_client *client)
 	return res;
 }
 
-static int ntxec_remove(struct i2c_client *client)
-{
-	if (client == poweroff_restart_client) {
-		poweroff_restart_client = NULL;
-		pm_power_off = NULL;
-		unregister_restart_handler(&ntxec_restart_handler);
-	}
-
-	return 0;
-}
-
 static const struct of_device_id of_ntxec_match_table[] = {
 	{ .compatible = "netronix,ntxec", },
 	{}
@@ -262,7 +235,6 @@ static struct i2c_driver ntxec_driver = {
 		.of_match_table = of_ntxec_match_table,
 	},
 	.probe_new = ntxec_probe,
-	.remove = ntxec_remove,
 };
 module_i2c_driver(ntxec_driver);
 
-- 
2.33.1

