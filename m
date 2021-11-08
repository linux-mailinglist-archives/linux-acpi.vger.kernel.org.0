Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7132944773B
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236930AbhKHAuy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:50:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbhKHAun (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:50:43 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF71C061205;
        Sun,  7 Nov 2021 16:47:59 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id m5so7885248ljp.4;
        Sun, 07 Nov 2021 16:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idp+KUM0Lads56hMjVdKoUEucrYOLC8M0llXkHYfiR0=;
        b=MSIokg9fBl5wCKU+YCh/ZsTnRbPxtyYkn0IXkmz1QgysWSCzedTHzXunmbe5h3S6bm
         UnVL+wV6mqmFlzA/9Cm1DjvGCGyG1UlF0UpjGzAyekOseWLiiFHuU/rzzoJCNBaI+Ut+
         tXv3jqiyClz8c/yGI+0sql8rliP5FMVBt2m13PFdeI0ncEKECxTJKTD2uIvZxfhnpZtc
         pTtiL6yFqIiWFaztPJXKxizN2sS1pJLHyx55ZI+6yNFLo/Lx5fkTcHCO0Wef47K1i5ee
         hCd51zpj+5nuMAdYUzdECYDopq77neBqCsiLrTGv9/feFU5+CZJd4t4x88wQvcjrAxlc
         1+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idp+KUM0Lads56hMjVdKoUEucrYOLC8M0llXkHYfiR0=;
        b=WTN5HucQjccnrhqIAKdJFQCfsHA4/olGNNkDo872sDbnvVatDtJoGwq3R+WO18rmls
         Hku4nfENJ+lR69Ipbhu9v1jFbDdokesFUcbsBU/LvToidqVl17nzNKrCvw9St9ER7lmZ
         ZYTKMhmK/v8Ce4FkyIL18NZJGoMz77Mo6Q3C1F7FLfT8XrQeV7BN1YsIqGzmsIys8iba
         9Q8p+l2V4pGiVLp42NX5kzgS2F9QLo7+A20sw3g3I9T7i/wt+RHS6FgVAmAtVxPH62C8
         SUlb8K4TC+RXYHgrJyriAxgh4MG125E1awDPqyh/+nm99YsuRJnWHLNLI8ifaiw+fHDv
         NHZQ==
X-Gm-Message-State: AOAM533mNPasfhDvFiqkWSuYP673ZtjkCoh6T0IghvvSix64qtQhuLzA
        3extZLkJ7ilXU4qnGq7+iTg=
X-Google-Smtp-Source: ABdhPJxSy/O3ZKQtb6VfZ0yaPaYZOmyzwu5OdP3V3ve+XGbVnBVt+toWzoBqdj+8FoRHXqlPFKwvJw==
X-Received: by 2002:a2e:b88f:: with SMTP id r15mr57944203ljp.309.1636332477998;
        Sun, 07 Nov 2021 16:47:57 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:47:57 -0800 (PST)
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
Subject: [PATCH v3 06/25] reboot: Warn if unregister_restart_handler() fails
Date:   Mon,  8 Nov 2021 03:45:05 +0300
Message-Id: <20211108004524.29465-7-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Emit warning if unregister_restart_handler() fails since it never should
fail. This will ease further API development by catching mistakes early.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 kernel/reboot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index e6659ae329f1..f0e7b9c13f6b 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -210,7 +210,7 @@ EXPORT_SYMBOL(register_restart_handler);
  */
 int unregister_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_unregister(&restart_handler_list, nb);
+	return WARN_ON(atomic_notifier_chain_unregister(&restart_handler_list, nb));
 }
 EXPORT_SYMBOL(unregister_restart_handler);
 
-- 
2.33.1

