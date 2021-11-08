Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AAA44773E
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Nov 2021 01:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhKHAuz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 7 Nov 2021 19:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236934AbhKHAul (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 7 Nov 2021 19:50:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB272C0613F5;
        Sun,  7 Nov 2021 16:47:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o18so32428789lfu.13;
        Sun, 07 Nov 2021 16:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS83fHvJX20ICn8zHYRDKvqQ1GY72vd2riIHxwkjweU=;
        b=KpydubZgLJ3vuCT00hrCdbf3OtAnjru1YwdDJxo9+hC27tQN3Q4KiomzYSDJMCZXbA
         EhaYZwalwwy91+aZLY1TS0S40bR84eElruKYesdGlVKFC/aUwPezwIPn/067lWyDW0+Z
         x4XmqT3PESi2/Nn4WIINCY94V/zeTchenrXpu2fqnWvEylnT7LN71F2WHWj7NjlVp0tD
         ugoKO0gc6fQ1WUgdslo/PfvFMxmzh/vxeeDZA6/emihAeEIqzA/7Lk07cW3q8vRXpO5g
         t/bVMWqe23nOV5HEFivxqx8tKkAzcIdw5EiLLiV/QpkyUezErBQd+Ycn225L15v7txub
         fGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS83fHvJX20ICn8zHYRDKvqQ1GY72vd2riIHxwkjweU=;
        b=VGKtjmiQl7jGj1JJWdXbqikFFueEAOPVP9o9uQs4ND/yftLzBpzeB25iTxlNL6XG2j
         uIXxoDlmQkERqD2OYMbPtfsiB5MCPce/pGbSBAAjDp8TT8nXBXp5r73z/ot+HgQq0Ikl
         jV4TG/INzCafMl8q1sZ5QQrIjZfqqhaJ5iRyRVV10C10Z+o4BCKbCfMfG12wtShaJYxs
         ymgN1gQOBaa2qA8oYH1EHwbSb5eDHyGnJe0OrCAFkfqGulES8F3ZWtgM2/KF2bvirFAm
         13q804+sGa9bFQIeREAm/NRnILg067GPdQHxxhDn8IB1rdMt/jTp9EaHAa9xpahx2Byx
         W6ug==
X-Gm-Message-State: AOAM533qu4h+/rWfGzzB6bA8YOdayoc9BsK4tSfajsALz/ZrfboSgrDl
        +GGe6u/ZE7KA/lRAsLqkcoA=
X-Google-Smtp-Source: ABdhPJxCboLcXN9lEOmhNp5QiL1yAnh5Fr04KXxv3nzMPaKilPbSu8P/FkJk3gpH04kDYFe9UJDOXg==
X-Received: by 2002:a05:6512:1323:: with SMTP id x35mr74261803lfu.613.1636332476232;
        Sun, 07 Nov 2021 16:47:56 -0800 (PST)
Received: from localhost.localdomain (79-139-188-96.dynamic.spd-mgts.ru. [79.139.188.96])
        by smtp.gmail.com with ESMTPSA id p17sm1625266lfu.209.2021.11.07.16.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Nov 2021 16:47:55 -0800 (PST)
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
Subject: [PATCH v3 05/25] reboot: Warn if restart handler has duplicated priority
Date:   Mon,  8 Nov 2021 03:45:04 +0300
Message-Id: <20211108004524.29465-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211108004524.29465-1-digetx@gmail.com>
References: <20211108004524.29465-1-digetx@gmail.com>
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

