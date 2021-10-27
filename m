Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6243D58B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhJ0V2t (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbhJ0V03 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:26:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE80C0432F9;
        Wed, 27 Oct 2021 14:19:08 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k13so6923473ljj.12;
        Wed, 27 Oct 2021 14:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyeKRcg+jY+d7mV074g++I9amtFxwmtCwLh3hlXwjuE=;
        b=QnkHqeqzRHJ5AsPp67EWmABUOzsGTZSEBDGiay4nrsnQYbRzqAwsk2Smx/z5LQ/pzF
         rdPrmuGWIQsGZY0bghrDq1od6/1Zl94Y7Qb1GFsmOOrt3AmEW7aEpgHOlwWIuWg9pF6h
         Oq2ibAnCelRGtOXc03WYR55PI40ZligMz8SFKQbuKJzels1J9jjvQqZYNvv/xzelX9Df
         3ooSIaYPCZ69IQLFRxzA4xs/vR6PqnP/beBugw1fOkkPovapvfxOsncNdJLVW4zeoK8b
         skyzHaRP9ZlGt9pP4tePYITTWnPX31LYoVXuqb9igbxjWGO6dkZHNW0xRIrqWzuV8p7l
         c4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyeKRcg+jY+d7mV074g++I9amtFxwmtCwLh3hlXwjuE=;
        b=P+FvQtAjfrSxOJdF3ox1OD/AFFDCb4BBTFHs+sIwx4Tg1NH/p152DjZWRbqZ4iGNOZ
         3YNfL6qEcqDb63vp2swmwsekwRyRuexZtrEjetuPMYzTm9WFKrHnAgGTn+K7YoVtWqjV
         MBMA+FBpMaVNTboPoW+KQDw1VoN2mlXEM+F7xTnOxk74Lay/J3pZdc3VbrSyl3hE3TKZ
         0Y6nam+vgj5chMb3rh0G/DYMaHSkwPanCfb1QfPbTw7L1VlMSIHIppx9mz3Z4xm6bYIF
         9T/eAx0hYmDzpyvbEiZPVmU0y3PX3FIBS4O5ZhylVsP8r2AcGQaRBLbZm2IY1L/Is32Y
         e0cQ==
X-Gm-Message-State: AOAM530ENqCjhOkOZ4bgt6TTYEM/biJvqM2B22GjmfAvx2RPT70lMwDq
        /NKVL6rcVOHvMB/Ud7j1vXI=
X-Google-Smtp-Source: ABdhPJy4ahVYxTGf2Y3bPKsNGZG7BdaFjyQVV1JaKCPUvFr94r9L7duD8TnIWNPTqCXGHbJewLuL1g==
X-Received: by 2002:a05:651c:1256:: with SMTP id h22mr358353ljh.348.1635369547137;
        Wed, 27 Oct 2021 14:19:07 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:19:06 -0700 (PDT)
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
Subject: [PATCH v2 40/45] mfd: twl4030: Use devm_register_trivial_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:10 +0300
Message-Id: <20211027211715.12671-41-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Use devm_register_trivial_power_off_handler() that replaces global
pm_power_off variable and allows to register multiple power-off handlers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/twl4030-power.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index 6b36932263ba..72df4735d628 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 
 #include <asm/mach-types.h>
 
@@ -923,7 +924,7 @@ static int twl4030_power_probe(struct platform_device *pdev)
 	}
 
 	/* Board has to be wired properly to use this feature */
-	if (twl4030_power_use_poweroff(pdata, node) && !pm_power_off) {
+	if (twl4030_power_use_poweroff(pdata, node)) {
 		/* Default for SEQ_OFFSYNC is set, lets ensure this */
 		err = twl_i2c_read_u8(TWL_MODULE_PM_MASTER, &val,
 				      TWL4030_PM_MASTER_CFG_P123_TRANSITION);
@@ -939,7 +940,12 @@ static int twl4030_power_probe(struct platform_device *pdev)
 			}
 		}
 
-		pm_power_off = twl4030_power_off;
+		err = devm_register_trivial_power_off_handler(&pdev->dev,
+							      twl4030_power_off);
+		if (err) {
+			dev_err(&pdev->dev, "Failed to register power-off handler\n");
+			goto relock;
+		}
 	}
 
 relock:
-- 
2.33.1

