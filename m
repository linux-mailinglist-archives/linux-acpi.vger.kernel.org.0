Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB645F40B
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 19:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbhKZS1r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 13:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhKZSZq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 13:25:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6F1C0698E5;
        Fri, 26 Nov 2021 10:02:12 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m27so26046283lfj.12;
        Fri, 26 Nov 2021 10:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLlXRmIj/zMVA0EiitKjc0V06oQPoMgvuV0WtFcoWEk=;
        b=dwQkjQc8XJ9Zv7re/xh1WQ2UESbNnOIjv44tV2yYkTMSfE9Pw4ixbam1sYNjgU1ziC
         YsjSnbkQEYOmSOD/fv2OcaoktyLva3BRmUT1f1EHzpHOs1H4O5FRr9HjwLwmIJ0kwol4
         En1ylnQpmG3ktfI1Fg/Q/EuJpzuzjUdYaT7dPWgdOpPbhofgmKEPmXbgYeO1l98bR8OD
         7+AULvyVTAbuaPQqm0dZB4n1ycZXUvc6CpxX2dZaHQaHbP8ogu2BN4iuPHoYBKRTBq6b
         tgYxssEnkU5biyG5fZrNPOs0vGjei7DrFVluWj41isSbTpsczS+9OOm9yoDDpdejZQ4Y
         d6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLlXRmIj/zMVA0EiitKjc0V06oQPoMgvuV0WtFcoWEk=;
        b=4iRoGrPHgHtce/zqiOBnkXOnu5rhFQpGSiSXTPRBQVPQSBwuSy/AGN/rXimp6INmDS
         42a0dr427OFs9Zkuy99K6oMjsMDCt+GeWV0lZzTErJ3uakXBeEcseqtu7RcFBG5wabdh
         5fVJbeis81S6/dhPO24qsXbTq6nYKu7AtpqljJO/H/sQH+WHU1VFV6i+qPFQBdAfAmNL
         /bNcHjr+e4r5a87CKrFPE01W6IF38peeP4Mo6kQx+lvKKrhrCbeQ3jUv8305kq0JITBU
         JTIXGwXLYdmdS1mQES1LnsNzKwqmS5/IiYlFc9avc28JYWW2qg2V5U7YZfBUMW/JUmqH
         dY9g==
X-Gm-Message-State: AOAM5320lKyiRTwnelheya05/SLSrJKMpnEVdTHSNaoynJVMj4QAd1IN
        1f7Semdx00Msq/iAszb6IEw=
X-Google-Smtp-Source: ABdhPJxQTNSOwCEIeWTILMI5rMPmmxh09mM/FdZM/5H+6ue5hatuq9sGyT0G3QPFh5axuTAZ8BDbdg==
X-Received: by 2002:a05:6512:3456:: with SMTP id j22mr31418434lfr.89.1637949730890;
        Fri, 26 Nov 2021 10:02:10 -0800 (PST)
Received: from localhost.localdomain (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.gmail.com with ESMTPSA id i32sm553831lfv.295.2021.11.26.10.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:02:10 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v4 10/25] csky: Use do_kernel_power_off()
Date:   Fri, 26 Nov 2021 21:00:46 +0300
Message-Id: <20211126180101.27818-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211126180101.27818-1-digetx@gmail.com>
References: <20211126180101.27818-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel now supports chained power-off handlers. Use do_kernel_power_off()
that invokes chained power-off handlers. It also invokes legacy
pm_power_off() for now, which will be removed once all drivers will
be converted to the new power-off API.

Acked-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/csky/kernel/power.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/power.c b/arch/csky/kernel/power.c
index 923ee4e381b8..86ee202906f8 100644
--- a/arch/csky/kernel/power.c
+++ b/arch/csky/kernel/power.c
@@ -9,16 +9,14 @@ EXPORT_SYMBOL(pm_power_off);
 void machine_power_off(void)
 {
 	local_irq_disable();
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 	asm volatile ("bkpt");
 }
 
 void machine_halt(void)
 {
 	local_irq_disable();
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 	asm volatile ("bkpt");
 }
 
-- 
2.33.1

