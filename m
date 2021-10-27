Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD88B43D4D7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbhJ0VYX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhJ0VXf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:23:35 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B19C0432C4;
        Wed, 27 Oct 2021 14:18:39 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s19so6944119ljj.11;
        Wed, 27 Oct 2021 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsN03A/v4Sm7hW8tBAQNfAIwim2Ix+phU87uldQTcUU=;
        b=aSBcb4MObsGcKwVtxhkQi6r6MrllJ5Wvhx4AXr7+3ZZIOmNeNayjB4H7wS3yJIQaI0
         vfLkw8dEY0bAB5FpyHupYLxHHW8temP9OImGFFR4LDmE7/mvPRk5uTYf1q52vThLv1Ot
         CBrv1hpmeU5p/gGow8523dqz9J8N1faFeN/IXFxxWyp7mhT8fq2Z7acBEZ06y9nx6CF2
         oI6Bf+jKcKCu1O6+i0B6l4EesA9cDqHIJQrezIg8dnd+TlutJ/VurnoBCjdUW8FVuBfF
         rgIrNrWNCUTYVjuoeGUx+HMg9DODFrvmZsdKkZzK15Dx1U5yq0D3h61n1EAZrJfufwr8
         qWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsN03A/v4Sm7hW8tBAQNfAIwim2Ix+phU87uldQTcUU=;
        b=Bd6Zw+u/xaPxbaaPSZJtfBmSEa9503cfi6kdlw3Hc0AQMw0tjlCYQc71xDyS6tCNJY
         tzZYhCoXXll3+ne170KDCXMjw5ppgq4c9SQ3CM9tTJrh/fjPqesOI3Vun3RE/MaEkmUk
         t8F3IEZVwoBwarQAEKj6CN+g8MFziGC0iUhGMZBWYQybtPvJ0++VXxoJjveFOFaW0Lng
         HW+00TrcVghflPnS73EQvj/knFcdXx7Er//wQRg7B8/cnhznY1tRdVSL612ENcwDYv1n
         SNop4MofC8jgfdWzyxbRMWyUobMUUoL2q1uUtRrsNZDFaLbBVhoS8LEdeRc0tYOh51/i
         bcXw==
X-Gm-Message-State: AOAM530Vne3hMD0SxMzEaEUs+koFOV5SUnccQmpXQQvLjGlmYCIt9uz8
        3kOG2VdcRoMwsVhhnuiZ4gs=
X-Google-Smtp-Source: ABdhPJwvRw65HVRl6UYG4kSDngjOw+VDWoznyGC0SQFAdeVNXxGihIuJGUkpMtbqNUFYMuUZsUPclw==
X-Received: by 2002:a2e:3e08:: with SMTP id l8mr351596lja.194.1635369517590;
        Wed, 27 Oct 2021 14:18:37 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:37 -0700 (PDT)
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
Subject: [PATCH v2 24/45] regulator: pfuze100: Use devm_register_power_handler()
Date:   Thu, 28 Oct 2021 00:16:54 +0300
Message-Id: <20211027211715.12671-25-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_power_handler() that replaces global pm_power_off_prepare
variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/pfuze100-regulator.c | 39 ++++++++++----------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/regulator/pfuze100-regulator.c b/drivers/regulator/pfuze100-regulator.c
index d60d7d1b7fa2..73d5baf9d3ea 100644
--- a/drivers/regulator/pfuze100-regulator.c
+++ b/drivers/regulator/pfuze100-regulator.c
@@ -10,6 +10,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/of_regulator.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/pfuze100.h>
@@ -76,6 +77,7 @@ struct pfuze_chip {
 	struct pfuze_regulator regulator_descs[PFUZE100_MAX_REGULATOR];
 	struct regulator_dev *regulators[PFUZE100_MAX_REGULATOR];
 	struct pfuze_regulator *pfuze_regulators;
+	struct power_handler power_handler;
 };
 
 static const int pfuze100_swbst[] = {
@@ -569,10 +571,10 @@ static inline struct device_node *match_of_node(int index)
 	return pfuze_matches[index].of_node;
 }
 
-static struct pfuze_chip *syspm_pfuze_chip;
-
-static void pfuze_power_off_prepare(void)
+static void pfuze_power_off_prepare(struct power_off_prep_data *data)
 {
+	struct pfuze_chip *syspm_pfuze_chip = data->cb_data;
+
 	dev_info(syspm_pfuze_chip->dev, "Configure standby mode for power off");
 
 	/* Switch from default mode: APS/APS to APS/Off */
@@ -611,24 +613,24 @@ static void pfuze_power_off_prepare(void)
 
 static int pfuze_power_off_prepare_init(struct pfuze_chip *pfuze_chip)
 {
+	int err;
+
 	if (pfuze_chip->chip_id != PFUZE100) {
 		dev_warn(pfuze_chip->dev, "Requested pm_power_off_prepare handler for not supported chip\n");
 		return -ENODEV;
 	}
 
-	if (pm_power_off_prepare) {
-		dev_warn(pfuze_chip->dev, "pm_power_off_prepare is already registered.\n");
-		return -EBUSY;
-	}
+	pfuze_chip->power_handler.power_off_prepare_cb = pfuze_power_off_prepare;
+	pfuze_chip->power_handler.cb_data = pfuze_chip;
 
-	if (syspm_pfuze_chip) {
-		dev_warn(pfuze_chip->dev, "syspm_pfuze_chip is already set.\n");
-		return -EBUSY;
+	err = devm_register_power_handler(pfuze_chip->dev,
+					  &pfuze_chip->power_handler);
+	if (err) {
+		dev_err(pfuze_chip->dev,
+			"failed to register power handler: %d\n", err);
+		return err;
 	}
 
-	syspm_pfuze_chip = pfuze_chip;
-	pm_power_off_prepare = pfuze_power_off_prepare;
-
 	return 0;
 }
 
@@ -837,23 +839,12 @@ static int pfuze100_regulator_probe(struct i2c_client *client,
 	return 0;
 }
 
-static int pfuze100_regulator_remove(struct i2c_client *client)
-{
-	if (syspm_pfuze_chip) {
-		syspm_pfuze_chip = NULL;
-		pm_power_off_prepare = NULL;
-	}
-
-	return 0;
-}
-
 static struct i2c_driver pfuze_driver = {
 	.driver = {
 		.name = "pfuze100-regulator",
 		.of_match_table = pfuze_dt_ids,
 	},
 	.probe = pfuze100_regulator_probe,
-	.remove = pfuze100_regulator_remove,
 };
 module_i2c_driver(pfuze_driver);
 
-- 
2.33.1

