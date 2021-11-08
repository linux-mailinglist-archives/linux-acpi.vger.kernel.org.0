Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8B44778F
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237049AbhKHAwF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhKHAvK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:51:10 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D93C061767;
        Sun,  7 Nov 2021 16:48:12 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id i63so914905lji.3;
        Sun, 07 Nov 2021 16:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRRUcggihxuvvuxXR8avhK/eModbACqCMIG7s3bijm0=;
        b=KBhPxSaW9lrnwg/ZeqJS2nu0HdKIoak3A7KEcWoxjZ8ZDLYfXwp1aXhrc8oCufl4X9
         MKLsob6NFLsKmC3aak9WZhqpQvEY4rFz6TP5tCGr2UIze2Tsvqt8QYHF9D+yEMaBHVPm
         WBhljEA9GFAvFym8H3desu0Q0Qf41WaNht0kxdCTsPansaa3e36GY/Lm0YlrziYL6KTb
         2Adk6zJSc93DD9T+BiQ9AEP3Q9XzvbblhJVfx1e1iiRtap7ytYjo7dpjC41oxn8g8q8v
         R3FH/69p8KJwif6y9Y/ENfpHxQH9zh/vXioHmNWUl3BVDks73jxZaW9geoZzhNoBNZfA
         CVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRRUcggihxuvvuxXR8avhK/eModbACqCMIG7s3bijm0=;
        b=p0L/QrGEHym4Xu0lZ5yOVe74/tI25ku/UXlPZWYlTeMWlcViLf5blF5WaSqUiGDfps
         99bCLkugeqQKkM/6tWQWyJDcchZLLuqt/nEUI1NjFaHsgMicFmVU52eUGHOHXl+BFiiD
         WJ8utoBKx1Mp7JivclmwRb0FZXNrl++VAGFIR97her7sRRtHc//KvC67oSJowN24NEKd
         T3fi3hHFnkeu8MaYBuxFI5xlNmsS+JjMngrpDhj4BZ51hgO/kcnBvXaE+EAOAq5IT+lJ
         j3Ehn2tVoQLWfKz/nnbmpL5Mkzx5rHaxxzokN0JmLJPY554Qc0MJ+2/j43vHoe99eoVa
         pf3A==
X-Gm-Message-State: AOAM530/Q1P8AhBMjlKBFp4w6DWAUd0W1TS3TMQRmIkf3NmDQsQpiUXP
        YSYxn76V8hsQC07p5wLUIf4=
X-Google-Smtp-Source: ABdhPJyfH7OANNMfjdVl1/BvZl9WPVHDE8Bg86gEBvgA8TNGSwiw/Je54t6L5Ttvpi+gyGASQBIYuw==
X-Received: by 2002:a2e:a54b:: with SMTP id e11mr55909067ljn.157.1636332490552;
        Sun, 07 Nov 2021 16:48:10 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:10 -0800 (PST)
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
Subject: [PATCH v3 13/25] parisc: Use do_kernel_power_off()
Date:   Mon,  8 Nov 2021 03:45:12 +0300
Message-Id: <20211108004524.29465-14-digetx@gmail.com>
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

Acked-by: Helge Deller <deller@gmx.de> # parisc
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/parisc/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index ea3d83b6fb62..928201b1f58f 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/personality.h>
 #include <linux/ptrace.h>
+#include <linux/reboot.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/sched/task.h>
@@ -114,8 +115,7 @@ void machine_power_off(void)
 	pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
 
 	/* ipmi_poweroff may have been installed. */
-	if (pm_power_off)
-		pm_power_off();
+	do_kernel_power_off();
 		
 	/* It seems we have no way to power the system off via
 	 * software. The user has to press the button himself. */
-- 
2.33.1

