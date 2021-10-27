Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E2043D55A
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237433AbhJ0V1W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbhJ0VZW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:25:22 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2BDC0432ED;
        Wed, 27 Oct 2021 14:18:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u21so8959212lff.8;
        Wed, 27 Oct 2021 14:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Hqy/1scbv2xgSJ+Pfjnwd9vR5EU0n/d3WfB2tugTgE=;
        b=fdXEajT5ReWU0k76RL+UMQexWX6+dI9dqZX5MdJXsVZcuokskYVO71+oKjzDY4A2wc
         hJ1YtaH4eNeZaWabxSPD6IdHvppV9tDUjSfbiCZ9pzJbnyd1ILGvgPlaBo02Y2jjZnzD
         JbO/7oiPSFxLAQwFLHGGO2Gfwy8dZZlQdidry7vBInQu2wS67Np/bBN1rUC/SIaULQAp
         mZSgP8kJbrDoclvDh2sRCaJ+wiPArCAPZMKwm6/7+fwfn1T4SmuQIaJDkhw4NUU2izwl
         4ikxIWp8MhgEKidppyJcozjOV5jYdL31Pn9EYMxWJrcs7VGZ0QCvDnuFIw51Kr2focF2
         kW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Hqy/1scbv2xgSJ+Pfjnwd9vR5EU0n/d3WfB2tugTgE=;
        b=dlk8G6a/OXTvdm9kZIKCGG7EVGMe24Hbd6KVARrZQBhz/G6+Sir0LJIejOsdZ5Di0x
         wVIES+JoLJRpQHN+RfdgLM4CLgLBe8aw34bU1f6OyYko/7H6lasE0Tg2kkOrb70Asw9h
         MJw+nirNXkMx98TefHNoFkDXM2eLgCRqZgb2k9uVPcMAbpjZheXTvv6JZ56FZSqrgjqX
         nvag1ykqMXmBvy5mavmxYfINqAP1aX4Qj6YbNs6lAhK5Jg41wSgRMGKtpF5sZRkSO1eS
         ubt52X/IqVK5XoR/OPgCbrOIs91Znld7n9WWjjj76pIZaukHEsn3kJB+zVrNbHe96TcY
         nfSA==
X-Gm-Message-State: AOAM530J54wgU0CvDmaD11R+i6Lr2jRntdgXdrwTVZhm+CI6XBuyh6LD
        yvqOU8JH91Z94MrpOuJMv6U=
X-Google-Smtp-Source: ABdhPJxErOfbgWaHoJDyROU+wtxCyzAJwEEk/21TSkl3Wl7+6OTCwc5MbFi2KTtZM0ExVMRMX2XJDw==
X-Received: by 2002:a05:6512:344a:: with SMTP id j10mr78084lfr.653.1635369538003;
        Wed, 27 Oct 2021 14:18:58 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:57 -0700 (PDT)
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
Subject: [PATCH v2 35/45] mfd: max8907: Use devm_register_simple_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:05 +0300
Message-Id: <20211027211715.12671-36-digetx@gmail.com>
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

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mfd/max8907.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index 41f566e6a096..58699510311b 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 
@@ -174,9 +175,10 @@ static const struct regmap_irq_chip max8907_rtc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
-static struct max8907 *max8907_pm_off;
-static void max8907_power_off(void)
+static void max8907_power_off(void *data)
 {
+	struct max8907 *max8907_pm_off = data;
+
 	regmap_update_bits(max8907_pm_off->regmap_gen, MAX8907_REG_RESET_CNFG,
 			MAX8907_MASK_POWER_OFF, MAX8907_MASK_POWER_OFF);
 }
@@ -214,6 +216,17 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_regmap_gen;
 	}
 
+	if (pm_off) {
+		ret = devm_register_simple_power_off_handler(&i2c->dev,
+							     max8907_power_off,
+							     max8907);
+		if (ret) {
+			dev_err(&i2c->dev,
+				"failed to register power-off handler: %d\n", ret);
+			return ret;
+		}
+	}
+
 	max8907->i2c_rtc = i2c_new_dummy_device(i2c->adapter, MAX8907_RTC_I2C_ADDR);
 	if (IS_ERR(max8907->i2c_rtc)) {
 		ret = PTR_ERR(max8907->i2c_rtc);
@@ -260,11 +273,6 @@ static int max8907_i2c_probe(struct i2c_client *i2c,
 		goto err_add_devices;
 	}
 
-	if (pm_off && !pm_power_off) {
-		max8907_pm_off = max8907;
-		pm_power_off = max8907_power_off;
-	}
-
 	return 0;
 
 err_add_devices:
-- 
2.33.1

