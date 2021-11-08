Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283DF447798
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237115AbhKHAwt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbhKHAvV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:51:21 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F7C061205;
        Sun,  7 Nov 2021 16:48:13 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d12so28934722lfv.6;
        Sun, 07 Nov 2021 16:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cQhCUMmxREqlb3fYFdUNP+80Jr1xwOUlupNd5E99mX4=;
        b=jxcQzJM1jm4ITIQpwF7sIniQUOmyyd20zqOX8gxsMFNa/9hDa05ywN9MS2er+nzvkg
         spQLArMiTvZtxNnWDJ75OE3dgnrkoS9MDkPRHte9gE6FXcTKHPRnED9qO9W3e99UZf7m
         A1KTZoJ6alj41Ktv2I90p7YOSa0dD0Xm01nBcRuWgbG3eKl6et6MW8gX9CSHBNjY/OC3
         kJ7vj4jBq+OBthAumKYplEumuBq+rAmZsUoI/K5B3YmlCl4VwV+iT25QjX+y2TUDFlkH
         MlXfPOA3xn9JRfWs9yq7NjBzJ+4COil84nQep1AFVFsZUKem8I6ABJP1Xx3rMMUJsPbu
         6R/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cQhCUMmxREqlb3fYFdUNP+80Jr1xwOUlupNd5E99mX4=;
        b=fUpj6oDkSRNjtRneXHbfy6/annni4HOq4MeMrjFB2410v7BFtCZ78+t84uU3dhmhzq
         wUBObgwAEfomBORMBOVZgCzKN/zQJ5HBziEeaAu+RZHE5pR2cLnGBopzeDjVxRIeYpdy
         n5nqhvayqWa7FvpeyuMf+IOyUVbPxz5yKCM/F/0QCAt7ms2yYtF+UJrfk/ABuDGjYqRH
         awROgBe0RHeiuYceW6OsTyD7TWqeZbMwH3C8G6Y+fQZLOjUQAmmf/xDsd6ZSxyAE8trZ
         v07n6z0jLr5u4TSzWRTACP+hMkkr6VsMU52K76fb7kMPl4SNgJH4Q5JNX0UfY7yVoyLf
         /XMw==
X-Gm-Message-State: AOAM531b5nd2APlUZCVvLCpufMrOtFdxJzjhyCNamq52shngospg2lb/
        lwVaMUU/BZkMKCO/rzKhtwI=
X-Google-Smtp-Source: ABdhPJw/xj7+vjQzmw+08eVs7NGwQQ7VzmtZSs0aqLXqTUoWrFUbxhrr0Z5KltUJyCDy5Y4kRFsHgg==
X-Received: by 2002:ac2:4570:: with SMTP id k16mr62980992lfm.611.1636332492292;
        Sun, 07 Nov 2021 16:48:12 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:12 -0800 (PST)
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
Subject: [PATCH v3 14/25] xen/x86: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:13 +0300
Message-Id: <20211108004524.29465-15-digetx@gmail.com>
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

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/x86/xen/enlighten_pv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5004feb16783..527fa545eb1f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -31,6 +31,7 @@
 #include <linux/gfp.h>
 #include <linux/edd.h>
 #include <linux/objtool.h>
+#include <linux/reboot.h>
 
 #include <xen/xen.h>
 #include <xen/events.h>
@@ -1068,8 +1069,7 @@ static void xen_machine_halt(void)
 
 static void xen_machine_power_off(void)
 {
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 	xen_reboot(SHUTDOWN_poweroff);
 }
 
-- 
2.33.1

