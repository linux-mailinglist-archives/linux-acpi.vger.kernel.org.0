Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D643D542
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhJ0V00 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234416AbhJ0VYz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:24:55 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4452C0432E4;
        Wed, 27 Oct 2021 14:18:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id q16so7019892ljg.3;
        Wed, 27 Oct 2021 14:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vtt3o4MswiJ8Uwk5SbVoJldxGf1+YbPRO7EtWlQaYpw=;
        b=h9Sc10ekNHuFL9pzFR5ivr4ubnoV3ErBKpxwq8qtLnmmEwmpDGD4jSeaWauc76yLUe
         mSt4r4zCNyFKj4h5OR8HLlxF7zfIwR2mYZXQxAs/YUFPraXy5oJXAYRRb5XFp5DFvHId
         dp4uwopusQmPxwo8pBprt9hjoN+nwfiSLFgat9Xg5VUZGhfoEbJhN2yWrZJiei/Mb3oo
         mtgvsX4Y0EPIUr2yLJuO6jAqsOYLbfr0p9vS8kzfJK4fcF7aAzjiqNMDP4LlFTOflII0
         /Ozi7fljMZ5bdh0k27GOMuAQZgJbYkevh7WpkJcoo8VpN/Xp7c/9529BJm6xL6ZNrYi/
         VmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vtt3o4MswiJ8Uwk5SbVoJldxGf1+YbPRO7EtWlQaYpw=;
        b=LHMUt+bqb6vsWNgOhYiUjpd7PIZxB2t67atX224q3pezrfYCTNPkC9MrIiypDcYWbL
         IJvNMmPaeYD280I9BFuqGDntsCjSN+Fj2h8wV8m3M2rZiZ/g3/MtWy0427x1uqoWgr8V
         ZXrD237LdoWeXIwp9zkDWbV6QgjLelPBjBnnYJshVafrJkkXARethz4rTP4LAQjdj6ZQ
         LpEXy5hLZ1iJHfXKlumjZzBKBqNKQAiSGPUqecWJMvnKjHV69UBLBEuvkaRsBjL8iXu2
         AzNp0zX5Vg5T5ij5EatYO2P/9+N2jBfTrBqBk3wgmAO1FBmrPX3P2+8VNHDy5F9KdZPy
         W8+w==
X-Gm-Message-State: AOAM5335WwrGkjE4jxOrZ8U8BUnIpzDVKuScM+W8kJrnaapx440BGe3L
        UKLeMaC7551sO3PVpxCRIeU=
X-Google-Smtp-Source: ABdhPJyyBz+GAYvcNwhzUHtMKnc91wku7za2iucydPD6HlUd9fBk/92YnwCUeQIBB5tQ4kJ4zljd+g==
X-Received: by 2002:a2e:b804:: with SMTP id u4mr293626ljo.425.1635369534279;
        Wed, 27 Oct 2021 14:18:54 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:53 -0700 (PDT)
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
Subject: [PATCH v2 33/45] mfd: rk808: Use devm_register_simple_power_off_handler()
Date:   Thu, 28 Oct 2021 00:17:03 +0300
Message-Id: <20211027211715.12671-34-digetx@gmail.com>
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
 drivers/mfd/rk808.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index b181fe401330..3bf369469053 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -18,6 +18,7 @@
 #include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/reboot.h>
 #include <linux/regmap.h>
 
 struct rk808_reg_data {
@@ -526,12 +527,11 @@ static const struct regmap_irq_chip rk818_irq_chip = {
 	.init_ack_masked = true,
 };
 
-static struct i2c_client *rk808_i2c_client;
-
-static void rk808_pm_power_off(void)
+static void rk808_pm_power_off(void *data)
 {
 	int ret;
 	unsigned int reg, bit;
+	struct i2c_client *rk808_i2c_client = data;
 	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
 
 	switch (rk808->variant) {
@@ -725,8 +725,14 @@ static int rk808_probe(struct i2c_client *client,
 	}
 
 	if (of_property_read_bool(np, "rockchip,system-power-controller")) {
-		rk808_i2c_client = client;
-		pm_power_off = rk808_pm_power_off;
+		ret = devm_register_simple_power_off_handler(&client->dev,
+							     rk808_pm_power_off,
+							     client);
+		if (ret) {
+			dev_err(&client->dev,
+				"failed to register power-off handler %d\n", ret);
+			goto err_irq;
+		}
 	}
 
 	return 0;
@@ -742,13 +748,6 @@ static int rk808_remove(struct i2c_client *client)
 
 	regmap_del_irq_chip(client->irq, rk808->irq_data);
 
-	/**
-	 * pm_power_off may points to a function from another module.
-	 * Check if the pointer is set by us and only then overwrite it.
-	 */
-	if (pm_power_off == rk808_pm_power_off)
-		pm_power_off = NULL;
-
 	return 0;
 }
 
-- 
2.33.1

