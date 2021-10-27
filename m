Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7A643D477
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbhJ0VWl (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244575AbhJ0VVM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:21:12 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3E3C06118B;
        Wed, 27 Oct 2021 14:18:27 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d23so5637879ljj.10;
        Wed, 27 Oct 2021 14:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+aSuiMovnmRlKPN5Rl3JuNmFHUt6skQo3O4wD7dX5JQ=;
        b=ehfhpJuO10tH0JJc+NToykiYU0vR9QNQWRGBFoJEmaOxGSK6IxZtCBEULR0W0LLrnh
         rWgUh4Kku73ZADq2I2DXfxnNngsudNBU15HzSYHJ5ZGaDy4yKkQqtcH85+TmIu3x8kh9
         Xstkp84P8gb9NHhImh/kkEu/eLRzihVMriWTiS1lyvVYlI0S9doH7srHH4uUDtgtagHH
         NnlFwVxtytB+YFKInQI4zlx/qw9ggp+d792cFqZ86NXSDRvmn2HsZCjK5JnAlXZtcFzO
         y6wwCc1x7j8EpGXUAyH+X2YWcF6tl/6iZWVr+mUSLKEmJFL/9H+FbFwe9fJf0ZNH5qP/
         q9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+aSuiMovnmRlKPN5Rl3JuNmFHUt6skQo3O4wD7dX5JQ=;
        b=SS7ePQk+dxXycLCsxOA2TRnFD4LEFP3J8QzupCIhs3T6pem699ztDiJArigp3y45h7
         doiLTijN+faN9AREIhxcHfUCvVe0ZSemBt1W9IjeCgTNu9CHr3+TIEsfsu2jn+epRmhk
         ++rmearHuco4deYs0SjAfOEhfgDksg+Q6jhJ0xbh/ugam+G6Ws+nkLm3ADDwqvNlnT6n
         QGNz5z1LBk2JwLyUk7ZhAP9B21ET6pmSsrt6e/7QfPuGqMfKxGnEnrRbyNcFWkcot1Zg
         FouHOx3okzQQUX/lEDAPZhyPGBc5ZchnahImPNV50ABzO4cHCC/N+ouffrt9RNJ/x3jB
         /PyQ==
X-Gm-Message-State: AOAM5305huWMHnU9/wdtYOLZqEV2AzTceIXs9O3kudrODT9Z5VXZ3Wdy
        QgKHcYhOJvcLUfrS4u5HiZE=
X-Google-Smtp-Source: ABdhPJySCnLdJnyefyOJzA6HMZEBF+hyXH0EM8QKUFyfoUHamOZK7R7lRqwGKBcRpuomVJFL6q66/Q==
X-Received: by 2002:a2e:891a:: with SMTP id d26mr331100lji.368.1635369506344;
        Wed, 27 Oct 2021 14:18:26 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:26 -0700 (PDT)
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
Subject: [PATCH v2 18/45] riscv: Use do_kernel_power_off()
Date:   Thu, 28 Oct 2021 00:16:48 +0300
Message-Id: <20211027211715.12671-19-digetx@gmail.com>
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
 arch/riscv/kernel/reset.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
index 9c842c41684a..912288572226 100644
--- a/arch/riscv/kernel/reset.c
+++ b/arch/riscv/kernel/reset.c
@@ -23,16 +23,12 @@ void machine_restart(char *cmd)
 
 void machine_halt(void)
 {
-	if (pm_power_off != NULL)
-		pm_power_off();
-	else
-		default_power_off();
+	do_kernel_power_off();
+	default_power_off();
 }
 
 void machine_power_off(void)
 {
-	if (pm_power_off != NULL)
-		pm_power_off();
-	else
-		default_power_off();
+	do_kernel_power_off();
+	default_power_off();
 }
-- 
2.33.1

