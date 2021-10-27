Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3426943D50B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240114AbhJ0VZX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241181AbhJ0VYU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:24:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D950C06122A;
        Wed, 27 Oct 2021 14:18:48 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j2so9016174lfg.3;
        Wed, 27 Oct 2021 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpMTaQaJ0cjNLgvNqh3di7liIGTew7KcJqDZRitT+Gs=;
        b=IWwdEP2zbLaLlU4mCU5s8PpqrkaIWlck+oA3xnCuAzsOirLY91m5COquObIzRO/SOa
         ZZIFcDLGTP22p0/7Hcw3xr55ftJZWhQ4nU6sBNGCfWjV2gTeJrHUPc9jLo/fr5xO0l0l
         0SNS1n6R63fMlbNJFT3gbKkQCc0Ia7/EAvKfYLtASP95KzfXrWNNTSb1yRqxn8x5d6xD
         hciHreIyBYgx6dcdUlzTSBb07ys9RFpq3Y5/l5Vd2vvkqxnAXOO/WD9ek4xsO4aDTsfM
         H41ne9Olkj2NqvJkNPysdfnoteByPeCFY3T52VBJFYJ9FKDG6+cEspYVw2UY7y4ppIDD
         pOHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpMTaQaJ0cjNLgvNqh3di7liIGTew7KcJqDZRitT+Gs=;
        b=fwy9dH9CHv+Ow9BtWYaZ0GSWGKlXqXS94k5WXkdAevuWiFHA6gGkVG6Hrmh0RXBo2V
         C+UZvfp3/cd6MEKDRiDbeuRSPjMqVsbu5MgGiT93y3mKzEQFlVVVeHHjq4hA5jIr5Ooy
         43Q3zXB0ac5qmsSwEDx3xGYKBcRnSRjwkd/jImehPR/0/2UgrBf2pmItbR+P092GoLLs
         WSmtrb5CqHk/J6E+uSiq5Ra4PauTjR7SYYkCox6rJnpGSs4SE8xBSszTBTI4xc/le6Mt
         5v+nQCZAfZ8/SUiz7Z9vEwpMGh+WOWrDdyqs9Fiv8QMv1j00d3KW/d4J7cAN/cuNjPEf
         nSmw==
X-Gm-Message-State: AOAM533uRov04WuqxJlVws2g3MIrDxfXuZH7VIpRfx44u4itTEJY36G9
        9LYHK06jwcALa1tbyObQFXQ=
X-Google-Smtp-Source: ABdhPJys0u/+wFsWDr/9j4b/C5x8WEos0EuABuOI0MYqETh3mbRQO/mjL91g1gnGx/4TO6/Fje2n8g==
X-Received: by 2002:ac2:4c9a:: with SMTP id d26mr128014lfl.344.1635369526848;
        Wed, 27 Oct 2021 14:18:46 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:46 -0700 (PDT)
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
Subject: [PATCH v2 29/45] mfd: acer-a500: Use devm_register_power_handler()
Date:   Thu, 28 Oct 2021 00:16:59 +0300
Message-Id: <20211027211715.12671-30-digetx@gmail.com>
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
 drivers/mfd/acer-ec-a500.c | 52 ++++++++++++++------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/acer-ec-a500.c b/drivers/mfd/acer-ec-a500.c
index 80c2fdd14fc4..fc864abc0049 100644
--- a/drivers/mfd/acer-ec-a500.c
+++ b/drivers/mfd/acer-ec-a500.c
@@ -31,8 +31,6 @@ enum {
 	REG_COLD_REBOOT = 0x55,
 };
 
-static struct i2c_client *a500_ec_client_pm_off;
-
 static int a500_ec_read(void *context, const void *reg_buf, size_t reg_size,
 			void *val_buf, size_t val_sizel)
 {
@@ -104,32 +102,35 @@ static const struct regmap_bus a500_ec_regmap_bus = {
 	.max_raw_read = 2,
 };
 
-static void a500_ec_poweroff(void)
+static void a500_ec_power_off_handler(struct power_off_data *data)
 {
-	i2c_smbus_write_word_data(a500_ec_client_pm_off,
-				  REG_SHUTDOWN, CMD_SHUTDOWN);
+	struct i2c_client *client = data->cb_data;
+
+	i2c_smbus_write_word_data(client, REG_SHUTDOWN, CMD_SHUTDOWN);
 
 	mdelay(A500_EC_POWER_CMD_TIMEOUT);
 }
 
-static int a500_ec_restart_notify(struct notifier_block *this,
-				  unsigned long reboot_mode, void *data)
+static void a500_ec_restart_handler(struct restart_data *data)
 {
-	if (reboot_mode == REBOOT_WARM)
-		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+	struct i2c_client *client = data->cb_data;
+
+	if (data->mode == REBOOT_WARM)
+		i2c_smbus_write_word_data(client,
 					  REG_WARM_REBOOT, CMD_WARM_REBOOT);
 	else
-		i2c_smbus_write_word_data(a500_ec_client_pm_off,
+		i2c_smbus_write_word_data(client,
 					  REG_COLD_REBOOT, CMD_COLD_REBOOT);
 
 	mdelay(A500_EC_POWER_CMD_TIMEOUT);
-
-	return NOTIFY_DONE;
 }
 
-static struct notifier_block a500_ec_restart_handler = {
-	.notifier_call = a500_ec_restart_notify,
-	.priority = 200,
+static struct power_handler a500_ec_power_handler = {
+	.restart_cb = a500_ec_restart_handler,
+	.restart_priority = RESTART_PRIO_HIGH,
+
+	.power_off_cb = a500_ec_power_off_handler,
+	.power_off_priority = POWEROFF_PRIO_HIGH,
 };
 
 static const struct mfd_cell a500_ec_cells[] = {
@@ -156,26 +157,12 @@ static int a500_ec_probe(struct i2c_client *client)
 	}
 
 	if (of_device_is_system_power_controller(client->dev.of_node)) {
-		a500_ec_client_pm_off = client;
+		a500_ec_power_handler.cb_data = client;
 
-		err = register_restart_handler(&a500_ec_restart_handler);
+		err = devm_register_power_handler(&client->dev,
+						  &a500_ec_power_handler);
 		if (err)
 			return err;
-
-		if (!pm_power_off)
-			pm_power_off = a500_ec_poweroff;
-	}
-
-	return 0;
-}
-
-static int a500_ec_remove(struct i2c_client *client)
-{
-	if (of_device_is_system_power_controller(client->dev.of_node)) {
-		if (pm_power_off == a500_ec_poweroff)
-			pm_power_off = NULL;
-
-		unregister_restart_handler(&a500_ec_restart_handler);
 	}
 
 	return 0;
@@ -193,7 +180,6 @@ static struct i2c_driver a500_ec_driver = {
 		.of_match_table = a500_ec_match,
 	},
 	.probe_new = a500_ec_probe,
-	.remove = a500_ec_remove,
 };
 module_i2c_driver(a500_ec_driver);
 
-- 
2.33.1

