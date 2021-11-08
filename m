Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C756447815
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 02:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhKHAzS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhKHAyZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:54:25 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1CBC0432C5;
        Sun,  7 Nov 2021 16:48:33 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id e11so6951630ljo.13;
        Sun, 07 Nov 2021 16:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ghk8UhoJL9jY8/O2iNT2jlf6L/Wn8kxWwQZa55OiZz4=;
        b=m9lmCk/PNCVIe1iEnMmaqECXsitq8Ovx65V6clklfsjRBigZmz6/oAFi59I8Avu9aR
         /4oHJVMcszm/lvy0RA7NH61GOesoLhRm/H0MMNHdKaVxHA8Y772q/nC7qfVwr0BUWORd
         4n9sp6eaAevDNsWyzj2KL5GDRiCyib9OAhzwqEUyBVetNtsOWUjYXYfwC3XE/LWI6FF2
         5SCFiiSjMuXGcqeRPmGFYZomzzHY3sW/IAHf7uFJpoeDDsjSMY317bnTHbfVpyoi8oyB
         D1wPsFRzqjnVayOk5njS/b5J1LZTN95Kba7gv17JheCtxYvN4aHjfKGDExsNwEpn43PB
         8CzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ghk8UhoJL9jY8/O2iNT2jlf6L/Wn8kxWwQZa55OiZz4=;
        b=lXA/ZkfWKcdGcsMjTxbmjOAPfWFJD3xM6Gm4C4IpThw7Mf2J/BL/AVFr15vGYZ+j5M
         sUsulDve+i92gRaddW8OYcfanCpfndcK1uok8GpVU7nwU0/TY8XAIoEKCD5Vu0nXFfHH
         AfCyZ8xTGv99zLfDNQpE+zFY8bz0u1hU7wm4TqYZYzTU7SZS0QCm60MjcZyFbausnaLA
         IdrKGYJ0oDqvgU382/ETjByapZek6W5tgpx9kejXbkfz2ToLeEGVeaXJ/1eiW0v087tQ
         oLgoEXU+YMSd3DeLRyOjjM9deV2vgBRt+KLMOIZIBDLSdSdwMQ6bK2CRsfhWhp+KGmij
         yFoA==
X-Gm-Message-State: AOAM533jydtGYfi24TsLQQQpa7+n3SIrUuG9TNFzZfivbtymXV5pcTlt
        oRxGWagls5kkPDksx54Vros=
X-Google-Smtp-Source: ABdhPJxIhCbr+E8e4RgafYf7yr1n/XPTP0a1gz0z709HjiRW7R+OIC1zaIspIzluAFf9Nr8w4fNXhA==
X-Received: by 2002:a2e:7819:: with SMTP id t25mr76018090ljc.57.1636332512040;
        Sun, 07 Nov 2021 16:48:32 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:48:31 -0800 (PST)
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
Subject: [PATCH v3 25/25] reboot: Remove pm_power_off_prepare()
Date:   Mon,  8 Nov 2021 03:45:24 +0300
Message-Id: <20211108004524.29465-26-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
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

