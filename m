Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10C645F3D5
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 19:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241153AbhKZS0A (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 13:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbhKZSX6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 13:23:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A614C0698CE;
        Fri, 26 Nov 2021 10:02:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id t26so26071836lfk.9;
        Fri, 26 Nov 2021 10:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS83fHvJX20ICn8zHYRDKvqQ1GY72vd2riIHxwkjweU=;
        b=d2rBY2F8FZR6fxo+AWivP8d/aANzXuwHT+cg69g6mn5w1PrR2Sa1IDulp20ge0kF/A
         cHnbxdSmlImW4wjqRz81zw3X1kevspbs+ZSvuFeqFssl7QkZMhAYxFVlnhJC7t+o5Ekh
         eNtRL2ojA7gJWr57oxbZKqm22O40Yv/rsDGA/NeWMpTdjAZIOo1PA/WaWBgnC2ALY5RA
         62bhQhoX5OCa7ZShxw0qrygSKSdJKJGDVnCPcPOzYsdIdpEoCBnHtdYY6e8ZoWq4VDFh
         N3S4qSVEELp33r/g+I5VvFht9D09Xj+u4OjF/0z+Ek8MwK4vNOYgNJskWndj6bmjKPsl
         6oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS83fHvJX20ICn8zHYRDKvqQ1GY72vd2riIHxwkjweU=;
        b=7fsancj0mtXR1vA55h92AGUyw2R/ptP2LljkF7RV49pkh0Ggjt0K6LlGHLIC5HEwze
         +DyHygxnQrMVzLjxJsLQytVrvorK90hw0DAzM4RwqQLz+fi2rCGGr7/DRUvf5T5zuei9
         XXUf0/hPR15BPEsct9Kn9QHCIha5EBngD+n00vyELaa1tX/9KvwYHJb5g2N2E3aFF7/U
         KdHDLW5LF0nsIrIZV9Yng7YZU31iwAsyGXSEFIhdkVpvjQVazFHAkoQtMpCMOYRIdwXX
         vu+l518IWZ8jy+gNgjNupMpOxqIhLyBY75vEsCTdhaBFvc49j8kR4pG6FQdoISMS4NgX
         WTnQ==
X-Gm-Message-State: AOAM533LA67jJD9eJr8NDO22lVkqqiwrcJF1L5ZH2PboR8Gz7JEJ/yQ0
        I/jzSIZbfAUTxPKAKrIDih4=
X-Google-Smtp-Source: ABdhPJyHlWHAIH2qsXkt3ruT7+BLFA3v5nYyOKPdcFWdHrRv9Oght1lKgGW/OoNNNMfJWGOCYURP8w==
X-Received: by 2002:a05:6512:32ca:: with SMTP id f10mr32489980lfg.364.1637949720361;
        Fri, 26 Nov 2021 10:02:00 -0800 (PST)
Received: from localhost.localdomain (94-29-48-99.dynamic.spd-mgts.ru. [94.29.48.99])
        by smtp.gmail.com with ESMTPSA id i32sm553831lfv.295.2021.11.26.10.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:01:59 -0800 (PST)
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
Subject: [PATCH v4 05/25] reboot: Warn if restart handler has duplicated priority
Date:   Fri, 26 Nov 2021 21:00:41 +0300
Message-Id: <20211126180101.27818-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211126180101.27818-1-digetx@gmail.com>
References: <20211126180101.27818-1-digetx@gmail.com>
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
index 6bcc5d6a6572..e6659ae329f1 100644
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
+	 * Handler must have unique priority. Otherwise call order is
+	 * determined by registration order, which is unreliable.
+	 */
+	WARN(!atomic_notifier_has_unique_priority(&restart_handler_list, nb),
+	     "restart handler must have unique priority\n");
+
+	return 0;
 }
 EXPORT_SYMBOL(register_restart_handler);
 
-- 
2.33.1

