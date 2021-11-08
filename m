Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51DC447776
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhKHAvm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:51:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbhKHAu7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:50:59 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9348EC06122E;
        Sun,  7 Nov 2021 16:48:08 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i63so914753lji.3;
        Sun, 07 Nov 2021 16:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKgqav8a8uS+JOYHQI8KBeK4UU43xCMXoqbNcSGFyUw=;
        b=AwJ4FjhZ4uu7Jeadgfe6E5PAdvbICZi/KQGBT5wtWDtpLQCHSuyQii3g8r6pSQIUa2
         LLP/5Ap/Hl0WEPh7xDoz4PaKuVu8acWl/Lrp3owoIRv8bnEjLc6DrINyfILK4sLPa4FA
         TzZracA1tQgQQmzzAozP9oEbAedvpeZNvOmd4r0/GU+RMsqZ8usg0Z1d6BGb5kC/Q8Oi
         092NDC0niu668uYvxs3HRB8I3gSXOvRJLX3+MnU/iBw4aXQabK5GKn4kFRVxx/BZQrgY
         SPfzDlTHPyUyIQ2h7FurvVltaeMoh7kLT95TlZb5fI4FdYpIu9Nno84DCMbZIPC5f3Sq
         OG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKgqav8a8uS+JOYHQI8KBeK4UU43xCMXoqbNcSGFyUw=;
        b=ukXz/d8w7EakW4/E1mPHId+yLkyM5b+oazrPDpSEcdG8cE+nwet08eiGmWmw2ZmNRY
         s3Pw0AIuuL0AGw29iDTsksfZt+8kfSK4R6TmajLaR1cQd9hgtb5X7qT+cGMoItjpdiWb
         ig+mls+kJIqeRt6yL2sOe6LKOLrQHPj6ShNK7kYQhAkuKjD4B0E1iJYRPgUPSzxhj0dw
         r3+5qdXh0/BSw084GSYHhzyV0G16duJEarPons54xQPJKgMkNMqOpNL025KunYt7R9ns
         Kpi2+McY30yXUbhnxgcjr4qwV7lhMwM0FBmG5bpKC0YC6IP2fxoVa+LOTKyahK2FNZw0
         G4Mw==
X-Gm-Message-State: AOAM530xgI1CcnMUcBjqk/Ow5l/AW1PEUmcJbmzaP5q0bzqmycQ+0Yk5
        B8eaKahc3q2RfOAZswrEJbw=
X-Google-Smtp-Source: ABdhPJwsYRcvq5lWlknwDGI1giubbuaVFPAkTxLB10aRQ7aivLUihqphCNvbqZqfSKq7V2Eu9b9sFQ==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr55138383ljp.474.1636332487004;
        Sun, 07 Nov 2021 16:48:07 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:06 -0800 (PST)
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
Subject: [PATCH v3 11/25] riscv: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:10 +0300
Message-Id: <20211108004524.29465-12-digetx@gmail.com>
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

Acked-by: Palmer Dabbelt <palmer@dabbelt.com>
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

