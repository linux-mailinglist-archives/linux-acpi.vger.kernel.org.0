Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D584345F497
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbhKZSaH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 13:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbhKZS2E (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 13:28:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E59C061370;
        Fri, 26 Nov 2021 10:02:45 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id z8so20239314ljz.9;
        Fri, 26 Nov 2021 10:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ghk8UhoJL9jY8/O2iNT2jlf6L/Wn8kxWwQZa55OiZz4=;
        b=ZtU3y8ZBLbgg4lFcoxmy2KRv9A+Ii+W7F/YNfA4hr5aGa2A8h1XOOQ+3ZkaoAuRI8r
         vp3WDQpWqaUbrqJl5k89WHPfQrEQ/Ltq03M1Jmy8OPuRkuVfHuw43GDACIGadH395ZCu
         hF1Tkx6Ym4O70rPhvu86hz5l/K9yL/cfenkaUfwTVHJ2tIac4a6CVsjFFcBSCjPbyEN2
         gfILQUaZObJE5x+CtC3RAwLsx67a+c6/n129TlnphmsaDSRSL+mpCIUkrNZHM2IDnaAh
         eZuToqizQ4ETYDJrMJcfU5n8RucoyvMFRHyF/5zQGpSCtU8DU2FKn4QQ8sg+eWOVU7gM
         usKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ghk8UhoJL9jY8/O2iNT2jlf6L/Wn8kxWwQZa55OiZz4=;
        b=XVU0gy66yBzRLE9uA11EzRrcJS1joz/A9yii55L0bp7zQ4+0u7UVIZCSMDfBs5PjJe
         rwFJZESF2syQ+78fA+qCXIUSofkm5Czy96Ejsie46HS31JuDieAViRrhj9FcAJgvVcXz
         FnuftP5/Ws65+g7zcu+AMx5sW3F935IdX0fknRZVx0LQr0GXBUyCOKBmE9Nols9Jd63o
         SsLJvHiQuWl++tgFLFyO031oKS4Fh/pTNz9FL6zFvahorVoGLWmGvyR4eYIAp8Q0Rm0l
         DzRi3jgmJ9Wp420f5rJaGlDIBtAJ8OFORmLK9edsnioCCk2t2F67RWlXy3dsQXsrDD+D
         669A==
X-Gm-Message-State: AOAM530+5s9H5qB0hyglFrJUcTlZrcNPOTHd0RLGLlL4lZWaoCd+DEtg
        c7vZnDn5hk7rzX8GOg8Bg6c=
X-Google-Smtp-Source: ABdhPJwe+PZD5fugCmFfxz+jK98d8FG+5T7bYBVi5cf4oriJg0nQW1ZXKn9ET9XQ9fmBMy14JpwgMg==
X-Received: by 2002:a2e:97c5:: with SMTP id m5mr33717502ljj.503.1637949763992;
        Fri, 26 Nov 2021 10:02:43 -0800 (PST)
Received: from localhost.localdomain (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.gmail.com with ESMTPSA id i32sm553831lfv.295.2021.11.26.10.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:02:43 -0800 (PST)
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
Subject: [PATCH v4 25/25] reboot: Remove pm_power_off_prepare()
Date:   Fri, 26 Nov 2021 21:01:01 +0300
Message-Id: <20211126180101.27818-26-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211126180101.27818-1-digetx@gmail.com>
References: <20211126180101.27818-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All pm_power_off_prepare() users were converted to sys-off handler API.
Remove the obsolete callback.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/pm.h |  1 -
 kernel/reboot.c    | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 1d8209c09686..d9bf1426f81e 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -20,7 +20,6 @@
  * Callbacks for platform drivers to implement.
  */
 extern void (*pm_power_off)(void);
-extern void (*pm_power_off_prepare)(void);
 
 struct device; /* we have a circular dep with device.h */
 #ifdef CONFIG_VT_CONSOLE_SLEEP
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 4884204f9a31..a832bb660040 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -48,13 +48,6 @@ int reboot_cpu;
 enum reboot_type reboot_type = BOOT_ACPI;
 int reboot_force;
 
-/*
- * If set, this is used for preparing the system to power off.
- */
-
-void (*pm_power_off_prepare)(void);
-EXPORT_SYMBOL_GPL(pm_power_off_prepare);
-
 /**
  *	emergency_restart - reboot the system
  *
@@ -807,10 +800,6 @@ void do_kernel_power_off(void)
 
 static void do_kernel_power_off_prepare(void)
 {
-	/* legacy pm_power_off_prepare() is unchained and has highest priority */
-	if (pm_power_off_prepare)
-		return pm_power_off_prepare();
-
 	blocking_notifier_call_chain(&power_off_handler_list, POWEROFF_PREPARE,
 				     NULL);
 }
-- 
2.33.1

