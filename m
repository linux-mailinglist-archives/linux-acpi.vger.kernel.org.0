Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6636D43D518
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239623AbhJ0VZ2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241345AbhJ0VYY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:24:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16815C0432DE;
        Wed, 27 Oct 2021 14:18:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j9so8980268lfu.7;
        Wed, 27 Oct 2021 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tizDJEeWC2iLbZdJm6My4oRtC+CKaYmiKRSIM6veO0=;
        b=P2SMTBdUazDV2Wnt33aO9FM2Ioz84SezmWonZoC9di4gBNxmpSDTZT6tEbAs+vJh3H
         Fl3mZiziafsNnSwbT1iMyr0r9bKbxSiHP3xJiOBIo4ewxSS3FiLigSFoEgJOcOsMECFU
         Ealy6ndYpUfciCkbDSvwvbDJBaKQyOcr0jiZpeL2e0iKkV4AQLDVCHRPOCPCDpkazzgq
         BERHUZw176GWVNNNOqpmpYaLAn7f4joDeIeKRo11vDGHWht2ujkzv0CrGvSNdzJe9tR3
         GFiFAzCfeg61A5JBu27BdMdrz99RW2oVhEudj/a2XZux9KH22qJjawF87cCiFM6fKipn
         F+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tizDJEeWC2iLbZdJm6My4oRtC+CKaYmiKRSIM6veO0=;
        b=g94owpKKRRPcgJfPyB2QZFBBLd2nSYMvzLFLDXCJGylerSJTxf9CghzBWfzthzxZNp
         NLTQ2XYkyUZgIyuHGHdAlx+sWvU3z/hEqgQ8pHHNyL69tZwONzGup43tBqJxnwNq9jXv
         6Ckc38CpFY9FNP6n5rOr6UaeZFh2nU4dx8cPCTFG2mc6I3Z/Femq0RSufUuHM1CN4Q8i
         wU71TviYGbXjTcWtoRdZHTGzy4h8VKcUYM1f7rl4RjROG7zirWxlEboDx05gxkPML1PC
         xK3pGqkeXq/U3O2ohaC+xPtVNYanoaI3lVIxGL7VaJZS+3r1ZVZkSYPk1RQl+F6NXZEQ
         /UrQ==
X-Gm-Message-State: AOAM532iXolfbnxXjteiHZAYKM8888fX5FDIKuSLYkNItj1AzwiOxYDY
        y6XbKrh/nMg45jhwsUzJwLgm7JpxQ9E=
X-Google-Smtp-Source: ABdhPJw7dGE4iKe+cyeyTSJFUn+l5q/Abxrr3B6KYrOVBl1p66aP04j6vH2fcBbUhHRs8nFJgDlWqw==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr134174lfg.274.1635369532441;
        Wed, 27 Oct 2021 14:18:52 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:52 -0700 (PDT)
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
Subject: [PATCH v2 32/45] mfd: retu: Use devm_register_simple_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:02 +0300
Message-Id: <20211027211715.12671-33-digetx@gmail.com>
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
 drivers/mfd/retu-mfd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
index c748fd29a220..d18f05c1f095 100644
--- a/drivers/mfd/retu-mfd.c
+++ b/drivers/mfd/retu-mfd.c
@@ -22,6 +22,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/retu.h>
@@ -81,9 +82,6 @@ static struct regmap_irq_chip retu_irq_chip = {
 	.ack_base	= RETU_REG_IDR,
 };
 
-/* Retu device registered for the power off. */
-static struct retu_dev *retu_pm_power_off;
-
 static const struct resource tahvo_usb_res[] = {
 	{
 		.name	= "tahvo-usb",
@@ -165,12 +163,12 @@ int retu_write(struct retu_dev *rdev, u8 reg, u16 data)
 }
 EXPORT_SYMBOL_GPL(retu_write);
 
-static void retu_power_off(void)
+static void retu_power_off(void *data)
 {
-	struct retu_dev *rdev = retu_pm_power_off;
+	struct retu_dev *rdev = data;
 	int reg;
 
-	mutex_lock(&retu_pm_power_off->mutex);
+	mutex_lock(&rdev->mutex);
 
 	/* Ignore power button state */
 	regmap_read(rdev->regmap, RETU_REG_CC1, &reg);
@@ -183,7 +181,7 @@ static void retu_power_off(void)
 	for (;;)
 		cpu_relax();
 
-	mutex_unlock(&retu_pm_power_off->mutex);
+	mutex_unlock(&rdev->mutex);
 }
 
 static int retu_regmap_read(void *context, const void *reg, size_t reg_size,
@@ -261,6 +259,17 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		 (ret & RETU_REG_ASICR_VILMA) ? rdat->companion_name : "",
 		 (ret >> 4) & 0x7, ret & 0xf);
 
+	if (i2c->addr == 1) {
+		ret = devm_register_simple_power_off_handler(&i2c->dev,
+							     retu_power_off,
+							     rdev);
+		if (ret) {
+			dev_err(rdev->dev,
+				"could not register power-off handler: %d\n", ret);
+			return ret;
+		}
+	}
+
 	/* Mask all interrupts. */
 	ret = retu_write(rdev, rdat->irq_chip->mask_base, 0xffff);
 	if (ret < 0)
@@ -279,10 +288,6 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
 		return ret;
 	}
 
-	if (i2c->addr == 1 && !pm_power_off) {
-		retu_pm_power_off = rdev;
-		pm_power_off	  = retu_power_off;
-	}
 
 	return 0;
 }
@@ -291,10 +296,6 @@ static int retu_remove(struct i2c_client *i2c)
 {
 	struct retu_dev *rdev = i2c_get_clientdata(i2c);
 
-	if (retu_pm_power_off == rdev) {
-		pm_power_off	  = NULL;
-		retu_pm_power_off = NULL;
-	}
 	mfd_remove_devices(rdev->dev);
 	regmap_del_irq_chip(i2c->irq, rdev->irq_data);
 
-- 
2.33.1

