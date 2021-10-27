Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160CE43D3EC
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbhJ0VUu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbhJ0VU2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26C0C061225;
        Wed, 27 Oct 2021 14:17:59 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bi35so8955846lfb.9;
        Wed, 27 Oct 2021 14:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gfPQe0zgS4I4UWFZNFBbY1KeZFawP+pEpuBLVF6wdKM=;
        b=IF53pE4MG8dtqJfDztqJu8/A7a/y14/j36v2nKdiMw6iu4DWmrRW8MOeE8LURQLXaK
         Ga0+xYwPRFyxojC/znNrOvpLGs+k6KHlhVWadULFKWtX+mXFusF6mHh4CLs+vcnkJVbI
         sCT8nKeVlZGK2TnNZ10Uo/TFQPsaFWopDEGJma2V9OokstL1aGUJunbAvrHKFFxOtEwg
         lD8/h9mw7UJrhz8Lza29Xoci0CHBwnwZJdD56IRSRRGiIs4vKcta6w27872hpSmyCu02
         ZBL1gjD87s9mbzpJUGm1Sbte3r8qhTN12pgeySe/LAcZyKJ0wXtrJhOtFLQB3UvQJ2Q1
         ctBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gfPQe0zgS4I4UWFZNFBbY1KeZFawP+pEpuBLVF6wdKM=;
        b=WusnbDq8scAfF6uljTABSszEJsfU9tAsFlQ//2ykxPG0ip3r+6RmlFHZem6LU/rQoT
         L9hjXnnC7B7kQAf7LyS154mF/O9IkONvi/wbCdZPub1UCL0xR3suypowzng4/ontBBne
         z24eETrhY+BETRByrlwQx8QQoindv0kqJYXJ/o0AHxYYO/dXKmwJ6AUZGgRIDmE48Y47
         nXQy4Y8Vm2viI86U1D5fQAejHLY7kC7+65ixpgtxgSSvDDfeXgojjQ+3GifEi+7WXFOC
         fRySBZs3C+WL7gHqYjbJFvcy98Bg+pN2lL1X9ewpjdkVOfObgqO3+fenCUJVXdy0u6sF
         lbqQ==
X-Gm-Message-State: AOAM532slO0L+8YW+J7M9XVcNPFblBFj81zH0xfL0a3KNFUxk8JpXsIF
        cIxjFE68/ytKqJPwdh+rUnw=
X-Google-Smtp-Source: ABdhPJxkIyEtMiQViKWR5fwy6fiT3tpzf12+F4/RJZJ4BQVHBt5yXcPBTwu2lq74yYNLjaS3GsmWQQ==
X-Received: by 2002:a05:6512:1095:: with SMTP id j21mr130850lfg.274.1635369478293;
        Wed, 27 Oct 2021 14:17:58 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:17:57 -0700 (PDT)
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
Subject: [PATCH v2 03/45] notifier: Add atomic/blocking_notifier_has_unique_priority()
Date:   Thu, 28 Oct 2021 00:16:33 +0300
Message-Id: <20211027211715.12671-4-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add atomic/blocking_notifier_has_unique_priority() helpers which return
true if given handler has unique priority.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/notifier.h |  5 +++
 kernel/notifier.c        | 74 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 054271e9cb20..b782ce100022 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -175,6 +175,11 @@ int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 
 bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh);
 
+bool atomic_notifier_has_unique_priority(struct atomic_notifier_head *nh,
+		struct notifier_block *nb);
+bool blocking_notifier_has_unique_priority(struct blocking_notifier_head *nh,
+		struct notifier_block *nb);
+
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 1f7ba8988b90..cf0e1c4bd364 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -203,6 +203,40 @@ int atomic_notifier_call_chain(struct atomic_notifier_head *nh,
 EXPORT_SYMBOL_GPL(atomic_notifier_call_chain);
 NOKPROBE_SYMBOL(atomic_notifier_call_chain);
 
+/**
+ *	atomic_notifier_has_unique_priority - Checks whether notifier's priority is unique
+ *	@nh: Pointer to head of the atomic notifier chain
+ *	@n: Entry in notifier chain to check
+ *
+ *	Checks whether there is another notifier in the chain with the same priority.
+ *	Must be called in process context.
+ *
+ *	Returns true if priority is unique, false otherwise.
+ */
+bool atomic_notifier_has_unique_priority(struct atomic_notifier_head *nh,
+		struct notifier_block *n)
+{
+	struct notifier_block **nl = &nh->head;
+	unsigned long flags;
+	bool ret = true;
+
+	spin_lock_irqsave(&nh->lock, flags);
+
+	while ((*nl) != NULL && (*nl)->priority >= n->priority) {
+		if ((*nl)->priority == n->priority && (*nl) != n) {
+			ret = false;
+			break;
+		}
+
+		nl = &((*nl)->next);
+	}
+
+	spin_unlock_irqrestore(&nh->lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(atomic_notifier_has_unique_priority);
+
 /*
  *	Blocking notifier chain routines.  All access to the chain is
  *	synchronized by an rwsem.
@@ -336,6 +370,46 @@ bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh)
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_empty);
 
+/**
+ *	blocking_notifier_has_unique_priority - Checks whether notifier's priority is unique
+ *	@nh: Pointer to head of the blocking notifier chain
+ *	@n: Entry in notifier chain to check
+ *
+ *	Checks whether there is another notifier in the chain with the same priority.
+ *	Must be called in process context.
+ *
+ *	Returns true if priority is unique, false otherwise.
+ */
+bool blocking_notifier_has_unique_priority(struct blocking_notifier_head *nh,
+		struct notifier_block *n)
+{
+	struct notifier_block **nl = &nh->head;
+	bool ret = true;
+
+	/*
+	 * This code gets used during boot-up, when task switching is
+	 * not yet working and interrupts must remain disabled.  At
+	 * such times we must not call down_write().
+	 */
+	if (system_state != SYSTEM_BOOTING)
+		down_write(&nh->rwsem);
+
+	while ((*nl) != NULL && (*nl)->priority >= n->priority) {
+		if ((*nl)->priority == n->priority && (*nl) != n) {
+			ret = false;
+			break;
+		}
+
+		nl = &((*nl)->next);
+	}
+
+	if (system_state != SYSTEM_BOOTING)
+		up_write(&nh->rwsem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blocking_notifier_has_unique_priority);
+
 /*
  *	Raw notifier chain routines.  There is no protection;
  *	the caller must provide it.  Use at your own risk!
-- 
2.33.1

