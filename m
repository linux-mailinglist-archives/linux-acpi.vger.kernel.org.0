Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D6447722
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhKHAuf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbhKHAue (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:50:34 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A001FC061570;
        Sun,  7 Nov 2021 16:47:50 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu18so32608769lfb.0;
        Sun, 07 Nov 2021 16:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wTvK5kO0FUcGnxCyVmK+GKrZNfPhZFNt57h0QWat/qo=;
        b=aCN9ngxNlSuTINh4RCPQ4NiaJQfaWgqOf+aRAmJkkpUuhaTskk16d6mLEB53d+EwRg
         2s7t+J4Bd+TYq/EXsMdm4K86cRKj3NZi6nWiQF6aQbgCPpCuvbwpFq4sXJn2XPr4GSG2
         Th3D5kSFp+oiICqSjiRaQ6JEqqHbq6GvlbMsD1k+WxWsk9ox4vhFrqiSSZariEfpk3/K
         NKYoWyNV67g+VntDwz5qg08D9ob5s1g4zeH1HG0CZIBJriUNPt7qdO5WhWhekDmPVGMJ
         IDvotTuyzH4cPVwERohWZwkZ/fa6HSeGhOA4LV/VuKel+YQjioIfxOgQanwFcDxsyY3E
         OrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wTvK5kO0FUcGnxCyVmK+GKrZNfPhZFNt57h0QWat/qo=;
        b=wAWv6E+vMAs8xZwkcE70xe8VaXIZNtAO4TALj4lUsmaa+IR8N2W9K0Em2ADbTx+gnT
         j8xzXSCTDtJCjyvLzq6Yb5/k0CQTI7OPTSXX1Wri4poQzSknBiJl/tolX5EcBYD/j67W
         7lSQNL7p/bQoKE+d7cRYT2ReIqwaEsBtTdDqLHqVDJLC0VUQjkwYL2g4i3mSF0NsqaeR
         D81SReyH9pH1v/9tzqNh7RE+sRQaBV28wsZ/0Kw9rxPbtQ2wpkiTIKE4lRqaYe29L64R
         iqjFpwLnapZcSllz5DgYxClvnpJ4yAtxxrnOFTJn1b8mzxMVUC6cexpwSb1yOYgJQ73v
         RILw==
X-Gm-Message-State: AOAM532Vva528zx6wnnZKmwhYEXEtLOCDq5fy4tPJSysZcHS8u/Xqd0F
        uP4WU2mKPaGHvDKHvIMATQ8=
X-Google-Smtp-Source: ABdhPJzV8tM9jJ+YM8h9UIDCNNzE6Z7H4gJwzI4RlG1cQ6QRWjIBy7LL+ION1D+Mvhxd950s2BQwnw==
X-Received: by 2002:ac2:424e:: with SMTP id m14mr51529749lfl.176.1636332469060;
        Sun, 07 Nov 2021 16:47:49 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:47:48 -0800 (PST)
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
Subject: [PATCH v3 01/25] notifier: Remove extern annotation from function prototypes
Date:   Mon,  8 Nov 2021 03:45:00 +0300
Message-Id: <20211108004524.29465-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

There is no need to annotate function prototypes with 'extern', it makes
code less readable. Remove unnecessary annotations from <notifier.h>.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/notifier.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 87069b8459af..4b80a815b666 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -90,7 +90,7 @@ struct srcu_notifier_head {
 	} while (0)
 
 /* srcu_notifier_heads must be cleaned up dynamically */
-extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
+void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 #define srcu_cleanup_notifier_head(name)	\
 		cleanup_srcu_struct(&(name)->srcu);
 
@@ -141,36 +141,36 @@ extern void srcu_init_notifier_head(struct srcu_notifier_head *nh);
 
 #ifdef __KERNEL__
 
-extern int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
+int atomic_notifier_chain_register(struct atomic_notifier_head *nh,
 		struct notifier_block *nb);
-extern int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
+int blocking_notifier_chain_register(struct blocking_notifier_head *nh,
 		struct notifier_block *nb);
-extern int raw_notifier_chain_register(struct raw_notifier_head *nh,
+int raw_notifier_chain_register(struct raw_notifier_head *nh,
 		struct notifier_block *nb);
-extern int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
+int srcu_notifier_chain_register(struct srcu_notifier_head *nh,
 		struct notifier_block *nb);
 
-extern int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
+int atomic_notifier_chain_unregister(struct atomic_notifier_head *nh,
 		struct notifier_block *nb);
-extern int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
+int blocking_notifier_chain_unregister(struct blocking_notifier_head *nh,
 		struct notifier_block *nb);
-extern int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
+int raw_notifier_chain_unregister(struct raw_notifier_head *nh,
 		struct notifier_block *nb);
-extern int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
+int srcu_notifier_chain_unregister(struct srcu_notifier_head *nh,
 		struct notifier_block *nb);
 
-extern int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
+int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 		unsigned long val, void *v);
-extern int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
+int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 		unsigned long val, void *v);
-extern int raw_notifier_call_chain(struct raw_notifier_head *nh,
+int raw_notifier_call_chain(struct raw_notifier_head *nh,
 		unsigned long val, void *v);
-extern int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
+int srcu_notifier_call_chain(struct srcu_notifier_head *nh,
 		unsigned long val, void *v);
 
-extern int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
+int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
-extern int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
+int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 
 #define NOTIFY_DONE		0x0000		/* Don't care */
-- 
2.33.1

