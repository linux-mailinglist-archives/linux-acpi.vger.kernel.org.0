Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFE743D48B
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbhJ0VXh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244440AbhJ0VVu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:21:50 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D116AC079788;
        Wed, 27 Oct 2021 14:18:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id l13so8990302lfg.6;
        Wed, 27 Oct 2021 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HObz0L7jYC33/Dxy7x3kt14KoppaRcQ+sU+HcRStgU=;
        b=juuYY7khswyJq9WLrD2Xv0L7DT3egfGiA3J+op4ykA5lhTUc4DxfT1yB0Oh88agPiv
         UhoKqT4ns2hfuw9gr/v0jAGL8GkGSlrTsMjRAQAm62Utk3Ft2TKiyIKDHiM1MbMECMuo
         YhNAqYcsFGhVw4jQXQFg7Xiu9P0ShsfWNYxHZwYj/2saBc/VAXVzxB4ozqBsrO+obQNg
         sFt44IAUuRDv+vAvbmBDNGqc/rVW0RxicCJ9k+jGGnO7zutAFJ4cO/39uMNR4REocLb+
         fT+JvIjl7o4XFJOJc5uobpc1ra4sZ3Uq0sG0p07pr/mfIHANj05r1FY541LLyuiyYuuI
         01TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HObz0L7jYC33/Dxy7x3kt14KoppaRcQ+sU+HcRStgU=;
        b=YiwkrX0/CdJJMkUSuyfecdARhViLhEieQM6nBhUrNuCzP89MGs5dHeZvVbQyqnb0RG
         azD24FB2ZFtTiZdMC/StFsEWjwTJ39ZnEjwPe7LU2q4U0QfySFcFsULMZ4hatAOxySCT
         Cl42GIF4xKUEcqa7QbSspKKyP+w7DqttOyJ5utQfsxNlJoUyyCs1SHqTobfG+GzoJsRi
         n4BwntRrevcZB3OA4iBUdbrJP6WaptfWhIjTht6qnUEM/tR4e2hZTVYY9qEmxPcItL7E
         kekrsQQ4XrrcV971DPpLcmG46EHSK2gn4G1/Tpek4CSfpD1p+Mzj9DsgOG73VprwSD7+
         611Q==
X-Gm-Message-State: AOAM5303bkkbz4w7MwyZc1BWgl1PWZYk3oFyZPM+Fg6optWVusrq3jyw
        +peCqufVAYXEf04d16KbP3s=
X-Google-Smtp-Source: ABdhPJwvis6SZ3kogk4xA1IHskuhNiRlAlBXPnsBTS3IAzxRcr2G+o3cy4E7zzZ6V+F8EKCBP2j+FA==
X-Received: by 2002:ac2:4ec4:: with SMTP id p4mr108449lfr.127.1635369510228;
        Wed, 27 Oct 2021 14:18:30 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:29 -0700 (PDT)
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
Subject: [PATCH v2 20/45] x86: Use do_kernel_power_off()
Date:   Thu, 28 Oct 2021 00:16:50 +0300
Message-Id: <20211027211715.12671-21-digetx@gmail.com>
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
 arch/x86/kernel/reboot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0a40df66a40d..cd7d9416d81a 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -747,10 +747,10 @@ static void native_machine_halt(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off) {
+	if (kernel_can_power_off()) {
 		if (!reboot_force)
 			machine_shutdown();
-		pm_power_off();
+		do_kernel_power_off();
 	}
 	/* A fallback in case there is no PM info available */
 	tboot_shutdown(TB_SHUTDOWN_HALT);
-- 
2.33.1

