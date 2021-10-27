Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6F43D3C3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244308AbhJ0VUa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhJ0VUY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:24 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED8C061348;
        Wed, 27 Oct 2021 14:17:57 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c28so8884713lfv.13;
        Wed, 27 Oct 2021 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4OzDm5Q6AH2k+PTLkkEFou1ZT7VKkxRv+kE3WUpAOf8=;
        b=UQ/1aCiL3zbAzp7+64ENWMFEP+bdpmbq+KH3NTi7hX2kN+fFVrO8S32QtOPwQfMxxS
         B4dmeXUf/BzuJhhzqG8VnHaUgY25bdcGnTrwxpDILzBPa9fYkIseD/FA90YqGQJP6GXZ
         PaIGof4Fo+LwMmngjVzKDktvBb6N6F/Oq7yFljDHwAcSrBHnke6Ooi6gGMrQtQGLY6gt
         DkEqtfwDzQkavBqxwLa+DWQ8L/Pn42h6a2KO1Y5kAXNNdt6/bA2gpVm767XfMu2cU+ZD
         8088MqymRILm5tETDMubwXrrDQl/PbR2eeFdMLFjmwWobAMprcx5uRuWc88/LBbNkX13
         zK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4OzDm5Q6AH2k+PTLkkEFou1ZT7VKkxRv+kE3WUpAOf8=;
        b=ADb0TPjlLpgbCSFF0VyAibL6TGJbBgUPBAzakbfhWHDpINkpQGCNVRikFND+zsLJic
         LiM2PkB754d+vbjzK+j6R46zpUP7jH0HswBi29OZ0AhJk5FCzFmcmtB+h78wmUFj0/1F
         QVyVIlsnyLIy5EkJsLcnvz6JAJr6sY6F5LoIKzKA8tF6YffLAZXM/nYPEYc8GXaZmRC9
         84f6DEaFsRLRyrufKMCP5H5wHt2nO82afRhOjOBBDXmFxWoHvlTSNYW9toY7GplelBby
         1c5j9CUQ+n1GELUWu0c+NEfPHj83t9QvCFVpUZaXdpTH1wRukWNteETrcK2pIvIQvo0F
         80CQ==
X-Gm-Message-State: AOAM530NvOip+WqUu9lvqmu5SWastDPeajUMTCUcAVDeiiNQ3Vgz4AjG
        ox1mz6ScRArORzzDsOn66pw=
X-Google-Smtp-Source: ABdhPJyeN/kGQE6WfHsDgri2jvM3EdB0FfWjlbwbrCss0fAIUEYOe9Prwt7QavBIliqBuOmpkw05Og==
X-Received: by 2002:a05:6512:3f04:: with SMTP id y4mr128266lfa.180.1635369476308;
        Wed, 27 Oct 2021 14:17:56 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:17:56 -0700 (PDT)
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
Subject: [PATCH v2 02/45] notifier: Add blocking_notifier_call_chain_empty()
Date:   Thu, 28 Oct 2021 00:16:32 +0300
Message-Id: <20211027211715.12671-3-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add blocking_notifier_call_chain_empty() that returns true if call chain
is empty.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/linux/notifier.h |  2 ++
 kernel/notifier.c        | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 4b80a815b666..054271e9cb20 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -173,6 +173,8 @@ int blocking_notifier_call_chain_robust(struct blocking_notifier_head *nh,
 int raw_notifier_call_chain_robust(struct raw_notifier_head *nh,
 		unsigned long val_up, unsigned long val_down, void *v);
 
+bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh);
+
 #define NOTIFY_DONE		0x0000		/* Don't care */
 #define NOTIFY_OK		0x0001		/* Suits me */
 #define NOTIFY_STOP_MASK	0x8000		/* Don't call further */
diff --git a/kernel/notifier.c b/kernel/notifier.c
index b8251dc0bc0f..1f7ba8988b90 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -322,6 +322,20 @@ int blocking_notifier_call_chain(struct blocking_notifier_head *nh,
 }
 EXPORT_SYMBOL_GPL(blocking_notifier_call_chain);
 
+/**
+ *	blocking_notifier_call_chain_empty - Check whether notifier chain is empty
+ *	@nh: Pointer to head of the blocking notifier chain
+ *
+ *	Checks whether notifier chain is empty.
+ *
+ *	Returns true is notifier chain is empty, false otherwise.
+ */
+bool blocking_notifier_call_chain_empty(struct blocking_notifier_head *nh)
+{
+	return !rcu_access_pointer(nh->head);
+}
+EXPORT_SYMBOL_GPL(blocking_notifier_call_chain_empty);
+
 /*
  *	Raw notifier chain routines.  There is no protection;
  *	the caller must provide it.  Use at your own risk!
-- 
2.33.1

