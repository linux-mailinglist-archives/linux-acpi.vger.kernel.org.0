Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6280C43D408
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244514AbhJ0VVC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244303AbhJ0VU3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:29 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A620EC061745;
        Wed, 27 Oct 2021 14:18:03 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id f3so803531lfu.12;
        Wed, 27 Oct 2021 14:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O+IvQoJf2OjzCPAk90L+IlIvsTQGqRsS8A3mVG9thss=;
        b=BbS8+/zxVJ00rr3ixtYTd3bTdxqjkUjnBr55DaOxzJArvyNX4521PAqPigYX/BjB1N
         aGylVDFiYrs5wRaWuZx6L52it/PPywema7yDnahBHenwiuFnc4S3m//ivsOGtXuUlPNB
         ubXOhenNVEu1KXB2mXMptIWVwaeJRf3hxW3c8R68HPPg3pjoH3MM7xhUxuphpty83aFx
         DGHamMHIXY7/zgP3wsKkRhZ7yEHgmahY/byikn8BiZjEw2DWUQkjcB5nYo+Xgh+eH8p4
         oVpJycq4ZWi1GYj36y1/HBYlXfcjUxN5WpbpwFTT0cF/PRko7dGul5P66XpFeKCAINSY
         8XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O+IvQoJf2OjzCPAk90L+IlIvsTQGqRsS8A3mVG9thss=;
        b=U20ivDQwPCbYsfj9u1nt9yIAxHAUWd6+0MZj+RkD5Boi8OC550GbYlsfggopQApCSp
         80adqRwpYlNOasBV1fAZz1aoHxwhedMwfPeAz+AtlFstVXuhbkux/WUwZjdx8e0cSI/p
         z1YrRq92yc2QPScqgx47eI6VndxMrHiC9buop91TsmFTki7LsAoTBGx7g0vV76kqg++E
         6/JkYZufSbAnH1xIWOogGUB5N6Nylfnc6pEn2qtlf8NQ/3NDvix6DMnSK3rkN7AqSduV
         qWVCc/+1qaMEB/5GnspLAnNQxFF0kGlRbo+bAj1R7nExDZ88ejRE/5wlmYxUNZTt3GvG
         yotg==
X-Gm-Message-State: AOAM533O7w1dYBuMoH7+TOfmWWCMiLEUs+qr9hoSGpN9oaS54OywWVS1
        IQbrX/GPUFpjLI+Jb6aT1i0=
X-Google-Smtp-Source: ABdhPJxyJaCNELbykyJ8mI+u0lU4wtjMFWua0Lm4EEmjlSiKb32hiTjDEQ+OHhGC/feOlGuy6qCfSA==
X-Received: by 2002:ac2:4285:: with SMTP id m5mr140041lfh.86.1635369481970;
        Wed, 27 Oct 2021 14:18:01 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:01 -0700 (PDT)
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
Subject: [PATCH v2 05/45] reboot: Warn if restart handler has duplicated priority
Date:   Thu, 28 Oct 2021 00:16:35 +0300
Message-Id: <20211027211715.12671-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add sanity check which ensures that there are no two restart handlers
registered with the same priority. Normally it's a direct sign of a
problem if two handlers use the same priority.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 kernel/reboot.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index efb40d095d1e..d39e599c3c99 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -182,7 +182,20 @@ static ATOMIC_NOTIFIER_HEAD(restart_handler_list);
  */
 int register_restart_handler(struct notifier_block *nb)
 {
-	return atomic_notifier_chain_register(&restart_handler_list, nb);
+	int ret;
+
+	ret = atomic_notifier_chain_register(&restart_handler_list, nb);
+	if (ret)
+		return ret;
+
+	/*
+	 * Handler must have unique priority. Otherwise invocation order is
+	 * determined by the registration order, which is presumed to be
+	 * unreliable.
+	 */
+	WARN_ON(!atomic_notifier_has_unique_priority(&restart_handler_list, nb));
+
+	return 0;
 }
 EXPORT_SYMBOL(register_restart_handler);
 
-- 
2.33.1

