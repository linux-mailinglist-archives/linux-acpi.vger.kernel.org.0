Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5043D515
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbhJ0VZ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241322AbhJ0VYY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:24:24 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E62C06122B;
        Wed, 27 Oct 2021 14:18:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x27so9005783lfu.5;
        Wed, 27 Oct 2021 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQWhTF0wBI+IugzPE3ghLHT129hypIGKpejDwrM3hyE=;
        b=RZvyurGZNweTiQS39Ean2OjgLccYrK032pC/dpD5TIetEdWActoZDZ0pbxUwZ65EB3
         f6HHqHOjaIJRkLRbNXFH+a9dD2g5xu+MxS8srOD+UoT89FXGbOpnIpBzsogwI4SrHnvI
         Xp4OXB4rFx2UJNCOe+1ontZRmKhqDl18fc0h55fLU7qhbVovqyZfQtN1oE2ZBblN4A6p
         LG+FlNBhlZ+ejJ/tR/o9Ca2I3+iU/ni7hPa9YCzdcCgi2bkMHewfSz0zfMDsoGnOZiG5
         WYH0N8y7+ABYK8jopd3eQsXttqeRRQN+xpWJ5QIjK2cUfd8tbZPE8negDAsL0a+gaJ2V
         fJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQWhTF0wBI+IugzPE3ghLHT129hypIGKpejDwrM3hyE=;
        b=WLlUGoInLqaiBg23maEMLGX20Hdf3sJDvkPaj8rA/56aXl9s0dM6IwEgSSrlYndHaC
         8GRHOidoT+UyyWKQWgQYs79KafPZMD4rgXSKRQZSCmlIYqzcR63QoXvoh6kufYoDLDJu
         b7kdIScCm1Lv9PcitNh07AUOuN/s7Zw37pnKjCw0oa52M9VO7TOmlE0nIm0Iz5K2hXUb
         YtQoMC/w6IMVk9gk/JTHZ1r/1afpXbrQj8Dhz3+FxYb0P7SCtsN1wvNkXRY91R/sIobI
         qvZVe7wwfVDVYTvvrgLUwIdEH0B+kA1HRaO3RjvheAfHiuQWo02/imSn/QYfiHH+IH+k
         qpuA==
X-Gm-Message-State: AOAM531geusyO+FT8H9w1GN4AQ+9Jg3SSWQhAmDmLhm/WtPnNxYINUPR
        ivCM5cVOibPZIbz6AoKctYI=
X-Google-Smtp-Source: ABdhPJyooWx5IN/z+hq1uWs5thGA811Cpi77JA6dUlt/XGnE5KIxJDhql9o1FzopBJlB1UrwswiMLg==
X-Received: by 2002:a05:6512:3f04:: with SMTP id y4mr131405lfa.180.1635369530580;
        Wed, 27 Oct 2021 14:18:50 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:50 -0700 (PDT)
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
Subject: [PATCH v2 31/45] mfd: axp20x: Use register_simple_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:01 +0300
Message-Id: <20211027211715.12671-32-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use register_simple_power_off_handler() that replaces global pm_power_off
variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/axp20x.c       | 22 +++++++++++-----------
 include/linux/mfd/axp20x.h |  1 +
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 8161a5dc68e8..db31fdb169e4 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -823,9 +824,10 @@ static const struct mfd_cell axp813_cells[] = {
 	},
 };
 
-static struct axp20x_dev *axp20x_pm_power_off;
-static void axp20x_power_off(void)
+static void axp20x_power_off(void *data)
 {
+	struct axp20x_dev *axp20x_pm_power_off = data;
+
 	if (axp20x_pm_power_off->variant == AXP288_ID)
 		return;
 
@@ -1000,10 +1002,12 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		return ret;
 	}
 
-	if (!pm_power_off) {
-		axp20x_pm_power_off = axp20x;
-		pm_power_off = axp20x_power_off;
-	}
+	axp20x->power_handler =
+		register_simple_power_off_handler(axp20x_power_off, axp20x);
+
+	if (IS_ERR(axp20x->power_handler))
+		dev_err(axp20x->dev, "failed to register power-off handler: %pe",
+			axp20x->power_handler);
 
 	dev_info(axp20x->dev, "AXP20X driver loaded\n");
 
@@ -1013,11 +1017,7 @@ EXPORT_SYMBOL(axp20x_device_probe);
 
 void axp20x_device_remove(struct axp20x_dev *axp20x)
 {
-	if (axp20x == axp20x_pm_power_off) {
-		axp20x_pm_power_off = NULL;
-		pm_power_off = NULL;
-	}
-
+	unregister_simple_power_off_handler(axp20x->power_handler);
 	mfd_remove_devices(axp20x->dev);
 	regmap_del_irq_chip(axp20x->irq, axp20x->regmap_irqc);
 }
diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
index 9ab0e2fca7ea..49319a0ac369 100644
--- a/include/linux/mfd/axp20x.h
+++ b/include/linux/mfd/axp20x.h
@@ -643,6 +643,7 @@ struct axp20x_dev {
 	const struct mfd_cell           *cells;
 	const struct regmap_config	*regmap_cfg;
 	const struct regmap_irq_chip	*regmap_irq_chip;
+	struct power_handler		*power_handler;
 };
 
 /* generic helper function for reading 9-16 bit wide regs */
-- 
2.33.1

