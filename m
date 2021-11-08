Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA924477C4
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbhKHAxW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbhKHAwC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:52:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE08C06120F;
        Sun,  7 Nov 2021 16:48:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bi35so32429178lfb.9;
        Sun, 07 Nov 2021 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IgdEY3brdUGAcbkVUTuopyRaDKQjmT9IOiG4donLZPs=;
        b=AKIY+4xb1sWzNTKdYR9NcCA9nDsvVUAMrOa/pXIgGailTXdsd+OVCw+Koek3pHfBqJ
         4ZQOd6MwFFWPWC7KG9VEbez4WQtuknCOGX0XGfcVeOd0k/AirXGq3JV8H9M3HoQjnUEB
         5yc9E8fCxUKwoy7fXSoJF3o8asvLPJ3i7Wlt6gJXYUYT1/Br/Yi0vQ22lOcFezSfWmeY
         JsjDkrCbKFHg51L3iwnMUHprusvjyZ3cw3o2/6LWF9aHfeW5pVu6j34yiWWtPm+QVN9o
         jHhRVa5ywZi5XLhvHrQyiH8ZKNBGehC9gt8XwUnxLFvnAY5aOF9BBZ49pR16xMX4NuF1
         Juug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IgdEY3brdUGAcbkVUTuopyRaDKQjmT9IOiG4donLZPs=;
        b=0m7/Xp/GkcKgu3N3txscXWwmpSozd9NyGlbdUO63poayQ63SO/Z7R9P0LYZQFE8Y2v
         CWbapS3ffJf0YBmL1oLHNOX8XutYyZ8pznLaGi+Lf1Ol0X7eiit7qVigxufXmr9CmuJn
         OO6Mh0gy0ReInBlFRbfKVV68I4ICmhlQQ2iEp1JxFrpT78hwro5WWeoHReLJIAHhHcZ2
         mShq3EznRkNde2x/0vsMMByTxvGa9iEIlIczaqvuXcm33Yof8R7c3Ta5oIuXCbWTXNFG
         LgkCj0m83YfZ1pmJHf9M+Bdm/8uHJoAmlFPpwBKiMBYPdoQAaVwPVru+/ZP27Fxy13zP
         z8ng==
X-Gm-Message-State: AOAM531R6Xw5DOD9w79yyoOKeA0Fkdu4wVgXRAUf2iEK+PHXG6TSwt5L
        gdVR6PP0as7bEUrXeHbvrBQ=
X-Google-Smtp-Source: ABdhPJwfARF3TH9rZWcpaUE1nQXpkqsXRoZVLVjj133yavIVMqkztZQTRFFE6m4kFZqTCd13G82vxQ==
X-Received: by 2002:a05:6512:2351:: with SMTP id p17mr53027954lfu.432.1636332501137;
        Sun, 07 Nov 2021 16:48:21 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:20 -0800 (PST)
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
Subject: [PATCH v3 19/25] nds32: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:18 +0300
Message-Id: <20211108004524.29465-20-digetx@gmail.com>
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

