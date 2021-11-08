Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3058E4477A1
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236239AbhKHAwy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbhKHAv2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:51:28 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3010C06118B;
        Sun,  7 Nov 2021 16:48:15 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id e9so5703884ljl.5;
        Sun, 07 Nov 2021 16:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=032w538UVpeATjNmIAIpxMVbSRQ+KkFSikcjH52Go7E=;
        b=CYX+rsWLev5P9iFzQc17Hii5aXl3X9I+N37IjUBPzT3fhs7ejibZMyODAFDdV6x7VJ
         5ZP+Hd71CAUWxtxryja3mUN+CaKHMdnjhX8yiRm1zru3VMaw1ejVu9ZClQmsYSpFhK78
         HJ592agYH/bCrPu2rETaR5XM30/EVbl3bPu5RbPwarWfT6a7OXYwpFfNN/bWsoOdhR5z
         4pjgJh0QLIxf0LagwrjW8fFOa+5fTJF5PXw0QY75bgP3vWV2t/oub8mHgmsVpyYpLQcn
         3aMRiOPeqIpjt7G8XmPwPxPRlc0uQlk6m3r7OnawAviMa5pFwVrm3wWEJl29tulXyA+Z
         C10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=032w538UVpeATjNmIAIpxMVbSRQ+KkFSikcjH52Go7E=;
        b=YtFKKQ2H1E1j8gLBTaBBuvzUpcFyVvKvfo+U9Vt342mjK85muRDSvwzw6kq1PIa4iF
         NrHjV9JAtR/MhreQOMc5ZnRK1svTi/l6+0OzrM7w8p2a+jhzgjDxonHUrjSM+X+ORA2m
         TN3uT9x42EenjuM8ptXG6AAsFvy21DjeOvyZSa+7KK98lKPAGVaO2ubq3Tl7eMAzswyX
         ANDs6r/2NSlURh7AKMmkNcbJpDC3bjkrJWZby26pZDetZvPL7sim8HTvqBQ4FVuCqZOa
         kjTDxKfOeJYtdLpaKz9QjCp9Xz71tojkBKSs57ImrCmvaRb4r/PGOsUOx5NTfPB1vQu3
         91wA==
X-Gm-Message-State: AOAM530tSvAn9BYE8aRLjUbHtCCbiqjPz3B8wmvEysecQEbcTCdYQaD9
        YPhpTC+HHCb3UTgctRNWrd0=
X-Google-Smtp-Source: ABdhPJw9pdaDkOXr3QmoCQ8lY8yPKwvYp6w85pF5+hYdZ4RiByLUnL5yspSV2AH/ECvDb66W5TciQA==
X-Received: by 2002:a2e:751a:: with SMTP id q26mr21102478ljc.168.1636332494070;
        Sun, 07 Nov 2021 16:48:14 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:13 -0800 (PST)
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
Subject: [PATCH v3 15/25] sh: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:14 +0300
Message-Id: <20211108004524.29465-16-digetx@gmail.com>
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
 arch/sh/kernel/reboot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
index 5c33f036418b..e8eeedc9b182 100644
--- a/arch/sh/kernel/reboot.c
+++ b/arch/sh/kernel/reboot.c
@@ -46,8 +46,7 @@ static void native_machine_shutdown(void)
 
 static void native_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 }
 
 static void native_machine_halt(void)
-- 
2.33.1

