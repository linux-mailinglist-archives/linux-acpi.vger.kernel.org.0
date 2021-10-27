Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726C943D57A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241148AbhJ0V1k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbhJ0VZ2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:25:28 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184B3C0432F4;
        Wed, 27 Oct 2021 14:19:05 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s19so6945790ljj.11;
        Wed, 27 Oct 2021 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu7tO95vXROZ9xbCJkoDzGl64HT6xR31EdIoyaMnKtk=;
        b=kPE91xXN+stBc0ha+PSjaOkkNGKlDTid0pZMJS4/z0xuWbbpv+/mX7oe8gzrFGsnxt
         knUKantyHU6PWIePiCnlFQ4UN8ZQdQP1oXKoJzSLIKv1lTDAhiLZjpDPc+aijhkrEZAj
         Xd8HN8BgZu0o5hpIxMQVtpuABAaRE4DHHXJZzo4Dy3xXk62gjG4MyDoYUHzKrSYuupRB
         lCz2OE27nWCjWUb+PHoI0yIS0mi3esed5R8cO+FhwY/2Rv4/jyVsNkj3xtgaoN5/YStc
         dCcP9WUacf6ElBGM42XMwNMMkAZqDoGVD/aHJJj9Cz/Tk9wj2JFlAJdIXkKMwT6cvxA3
         e31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu7tO95vXROZ9xbCJkoDzGl64HT6xR31EdIoyaMnKtk=;
        b=VKbLBmB2+WXU92YcEI4YUPhNoNjmlqc9o6RUYF5WTOLDYZO1qpRn5k8wcJYKf7DyXV
         MJo1/ELHYe6RYh9ujbwXi14dXhgIg6LB1SofTv7AUA3XgDXstA3p6W2yE6cTPZth3MIT
         yXjQNKAQVJ5jvWEpjcqxBAcvAjE+E7QwS4LjQIWnZ/OyLF6wIsz9+4/HAyHGpj/0mSqk
         /lQfmrLPUGvs2yQCqyOUyreZhG+l4wiFPaxiCuGXBhyx7Ynpqt2lCRCYKRhBpJX9fNtw
         nClX7x0Lyad/Vy66kAyEILXknDL80u+tbX/qEqLvepVV5QR2IAUcjGPJKqFD3oO5JLIF
         Rmqw==
X-Gm-Message-State: AOAM532VLfst8oM+N1/qDEHbtZgcOxVLwCHHZzOtrJd3wzgAagv6O9UA
        Gv/rxej/fXGJ0INVtJIo2tk=
X-Google-Smtp-Source: ABdhPJx+pRFjcRYPR1om8nKBpIgAHoRaPbEg7vS4nL7YKN3yH6zq2Ajomu3cvpnY+yAbJLhjtqI1TQ==
X-Received: by 2002:a2e:bb98:: with SMTP id y24mr344716lje.168.1635369543476;
        Wed, 27 Oct 2021 14:19:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:19:03 -0700 (PDT)
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
Subject: [PATCH v2 38/45] mfd: max77620: Use devm_register_simple_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:08 +0300
Message-Id: <20211027211715.12671-39-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_simple_power_off_handler() that replaces global
pm_power_off variable and allows to register multiple power-off handlers.

Nexus 7 Android tablet can be powered off using MAX77663 PMIC and using
a special bootloader command. At first the bootloader option should be
tried, it will have a higher priority than of PMIC that uses default
priority.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max77620.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
index fec2096474ad..29487ccc191a 100644
--- a/drivers/mfd/max77620.c
+++ b/drivers/mfd/max77620.c
@@ -31,11 +31,10 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
-static struct max77620_chip *max77620_scratch;
-
 static const struct resource gpio_resources[] = {
 	DEFINE_RES_IRQ(MAX77620_IRQ_TOP_GPIO),
 };
@@ -483,13 +482,13 @@ static int max77620_read_es_version(struct max77620_chip *chip)
 	return ret;
 }
 
-static void max77620_pm_power_off(void)
+static void max77620_pm_power_off(void *data)
 {
-	struct max77620_chip *chip = max77620_scratch;
+	struct max77620_chip *chip = data;
 
 	regmap_update_bits(chip->rmap, MAX77620_REG_ONOFFCNFG1,
-			   MAX77620_ONOFFCNFG1_SFT_RST,
-			   MAX77620_ONOFFCNFG1_SFT_RST);
+				   MAX77620_ONOFFCNFG1_SFT_RST,
+				   MAX77620_ONOFFCNFG1_SFT_RST);
 }
 
 static int max77620_probe(struct i2c_client *client,
@@ -566,9 +565,13 @@ static int max77620_probe(struct i2c_client *client,
 	}
 
 	pm_off = of_device_is_system_power_controller(client->dev.of_node);
-	if (pm_off && !pm_power_off) {
-		max77620_scratch = chip;
-		pm_power_off = max77620_pm_power_off;
+	if (pm_off) {
+		ret = devm_register_simple_power_off_handler(chip->dev,
+							     max77620_pm_power_off,
+							     chip);
+		if (ret < 0)
+			dev_err(chip->dev,
+				"Failed to register power-off handler: %d\n", ret);
 	}
 
 	return 0;
-- 
2.33.1

