Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7561447773
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbhKHAvi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbhKHAu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:50:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C8C06122C;
        Sun,  7 Nov 2021 16:48:06 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j10so6977479lfu.4;
        Sun, 07 Nov 2021 16:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLlXRmIj/zMVA0EiitKjc0V06oQPoMgvuV0WtFcoWEk=;
        b=H+uYC49dEjsHXqh8KjNtZs3ncLNuFdjuFGV7oRJa8IcUbOTh4rgkLFb7DBp88gShw2
         zYvh0zw5iSNGUiU1OYmfWOtmg2IDURIlyZp7DHy5riU2+lvrrppodyc822EM6fljmTUm
         0Krm+uv0X3ApPPhKiqBU3K8dWJVCDNZF+sadpYMeradsXhAynNY6RMShhE3ZI81hAGDL
         W15dDd5J4VvsLTGFr+bOqthsJObLlO7pTEkL8HfwppP5Ae4FzVmtvRUUtrW+yUHR7nyz
         Iw+UPoCdyZnTzm8hJEM+14oo+6u93uh0bdNvsyzcy9lNzz4qw54Q8qB66Iha1CL6iRDZ
         Lx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLlXRmIj/zMVA0EiitKjc0V06oQPoMgvuV0WtFcoWEk=;
        b=FZu5VinQtC3GOCfr06hSebs2GcNwcCcZ+5ykwJEP2mM1h9IyA8LindJJIK91LO1Lkn
         lBkRPcJmGJJLx/D4OscZ0VUWA1A2ZkkIezuYFEtZqvfJ6uz49R8tPsIxJ9PfnjxJgw8A
         1ewa80t6/u/lizFsSDA/01/gs/guDMkjX1rqU6VCl8Lhe1PMJJ5vrqKc9GYcxKlICgaO
         esQTnIhuRNcybuTOUQHUYIRrzmamHrFuLtmwngKAq8gAy3ecILYbVUHR0FszyGYT55ai
         mt8Z0BffkcIOSHXJQ5NfTu99o1f/K2GqVkP+v8niSap4Yq6+QG1Xdpt4Jng1+tHjM4X0
         mPMA==
X-Gm-Message-State: AOAM5322yunOrphiJoosSHqkdouHZPgg+T/vVNgm7sMWztbChAs38zUv
        /swvcxNPj3GMUtzGWEnzW94=
X-Google-Smtp-Source: ABdhPJw84ic5t+UCFbDuTh1KSNG4JWw1g+e5zhgjImye0iV+bKnXDlPlOLHIlmqdsqHdzJ3HYwGGrQ==
X-Received: by 2002:a19:c754:: with SMTP id x81mr26382574lff.70.1636332485172;
        Sun, 07 Nov 2021 16:48:05 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:04 -0800 (PST)
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
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 10/25] csky: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:09 +0300
Message-Id: <20211108004524.29465-11-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
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

