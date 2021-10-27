Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A28F43D462
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbhJ0VWA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbhJ0VU6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:58 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C47C061230;
        Wed, 27 Oct 2021 14:18:24 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s19so6943083ljj.11;
        Wed, 27 Oct 2021 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQw7CI0X8q8oTyepUGNJOSZqk2PM67xqdSRvFtKKmiw=;
        b=h1ou+u32rU4cYIn0OrunTZVHH8PVsk/s4rO9s8rIgCD+KKjcifq4iXhOSD/tIm7Qin
         P6ARY8cS2LdXxM+CoAbgm367SWuzYvU7Z79bJYgTCDi7YlT7Y5yuy0qGD8YIp/7ys02d
         pQwjIRkz9TYZYOpAy67AqOhS7slV4KAtJVEBcoUUJ83/AZzv5dclkL7bTj62SJ6cw7H4
         UW+yIUAnRXLn6nWbS4xhDtCDZfNdRtv+xAYYROwA+IIcIffcm5Q9yfNkOiBLfH2Y/wmk
         oOdsC/qn1zU/au/+LxlGh/gFJDeofp5A7xGvQ93uStcIj752OCcUSwSsN/9T0qMY5YTe
         dvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQw7CI0X8q8oTyepUGNJOSZqk2PM67xqdSRvFtKKmiw=;
        b=aG+uBMZFg8N0YZ0oEpwDlPm46DrKyRiAX6OQTp4BKGxemuPd3+4L0iHmxljsCYgYhM
         JkWO34VVoZCgo4jNM3pwX8tK6Ynq+OiMiKHtSD2qIp6U4Ly6wwPRW7mQOqa9VW9RSxcv
         2IaJmXsmqgs+h40z89VFOJI5lmHjQ/3Ps3W6oUFfr7Hviq5HlyjiNEx16UDN1mQQFlcA
         utSWnsfAlkZ1OXpDGnbLcDHVHPHRfoy+qeVrV16GnANBYbAhia0he0drI7GyZUTe2tRO
         U8NtB6IJmMxA/S+f/xfo1HvXvywb3iA13pdWjUuixgFEvvvMFKJIPiJmP0Xy6oYiQXRw
         pzjg==
X-Gm-Message-State: AOAM531yhpQulrM3r4Ufc1GYz+NNrQmiQj7A+0pAYsUzi/hV3UH4RlxO
        lQ+ChGM9dzfNUsYOZF/xMcg=
X-Google-Smtp-Source: ABdhPJztZrtJsxWmkjJ9e0hDv7W0ZJONlmNUbIC8cbkqFySfq5YC9V4Azd52J8+C4kw5eLOToEAzlw==
X-Received: by 2002:a2e:bf1c:: with SMTP id c28mr359960ljr.150.1635369502589;
        Wed, 27 Oct 2021 14:18:22 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:22 -0700 (PDT)
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
Subject: [PATCH v2 16/45] parisc: Use do_kernel_power_off()
Date:   Thu, 28 Oct 2021 00:16:46 +0300
Message-Id: <20211027211715.12671-17-digetx@gmail.com>
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

