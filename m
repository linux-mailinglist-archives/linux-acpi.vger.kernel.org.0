Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6543D456
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbhJ0VVu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244471AbhJ0VU4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:56 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7ABC061243;
        Wed, 27 Oct 2021 14:18:22 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq11so8954700lfb.10;
        Wed, 27 Oct 2021 14:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgdEY3brdUGAcbkVUTuopyRaDKQjmT9IOiG4donLZPs=;
        b=A3JO6VvJimX2FDA0dLxQreYnwNBhx07tWQqQ/SXHhnBPoY3sXPbkG7/+E3nQpmOX0A
         xlWT2EkBKpC8k8ZWfgyhIneFn7gx6l3JU5mZMCJ9Gg2YcXAy3/1zaAAc5fiz8vpe6tlD
         ZvghxSem0XLQoHwdT6xVe9kcSCqZDVrl06JyyBvtaA4P5y8CnmEwrM6jHVXlGrSBhDO0
         o8SePrtzTGOU2c+h0yCzi7vHVuNfd1Z0T1OIQTsX0utpaovYy+QkExsu3rsU1LEkDfsA
         b8P9cl2mQ3B7fspke5UfEwNdCDRC5NS7RaIYXDvPpdxxluddWoVhn2i0iC+LZc0Zjzjl
         nizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgdEY3brdUGAcbkVUTuopyRaDKQjmT9IOiG4donLZPs=;
        b=eWzNyfhdIzdMdwNCFTu0yEX1dHc68lEjvmqkMcQyMgwwai6GL8IGJyO9xl0lmd8bbb
         ynQy+x+crDosNxOGLjTHRg0+cyZfh3lTUMr7WoweHyOu1m05HNf07YBrKRteeQhvhaGj
         mZRTpX9cfUkSzeGDm6MnUgyWNaFIldW6kmOsk5VxWyLwSICBqlRgW0b2RSHcgPPZcl9o
         eVV0DU2sQsTxvme+AjHJg1Vsz4syeOo1EwMiOh3EpRyye/6KRYfy/dnanaypbo1wTEOP
         s5Gm1WGmu+5GDZWGpVielEGVBh3RKU52eKGLnVVtUgBLl7vfCHFh0Ob1BRq01z5frdk/
         FOeQ==
X-Gm-Message-State: AOAM533SN7oxcPcWIlN2zaQwIaAzJYWN6Kt2wCudzdyWGLt79UTNd8EY
        0aHLU85WLMVCvA0OofnIMZQ=
X-Google-Smtp-Source: ABdhPJwtMjA7PlvcFRu5kz6vTDm0WOPOzzhi40W0Cp5+CpUA24meJt6Drh8JDJU/Rr1wsTlEzin4/g==
X-Received: by 2002:a05:6512:401f:: with SMTP id br31mr96058lfb.169.1635369500752;
        Wed, 27 Oct 2021 14:18:20 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:20 -0700 (PDT)
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
Subject: [PATCH v2 15/45] nds32: Use do_kernel_power_off()
Date:   Thu, 28 Oct 2021 00:16:45 +0300
Message-Id: <20211027211715.12671-16-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel now supports chained power-off handlers. Use do_kernel_power_off()
that invokes chained power-off handlers. It also invokes legacy
pm_power_off() for now, which will be removed once all drivers will
be converted to the new power-off API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/nds32/kernel/process.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/nds32/kernel/process.c b/arch/nds32/kernel/process.c
index 49fab9e39cbf..0936dcd7db1b 100644
--- a/arch/nds32/kernel/process.c
+++ b/arch/nds32/kernel/process.c
@@ -54,8 +54,7 @@ EXPORT_SYMBOL(machine_halt);
 
 void machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 }
 
 EXPORT_SYMBOL(machine_power_off);
-- 
2.33.1

