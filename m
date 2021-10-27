Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6FBE43D405
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Oct 2021 23:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbhJ0VVA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 Oct 2021 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244318AbhJ0VUb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 Oct 2021 17:20:31 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2DDC061767;
        Wed, 27 Oct 2021 14:18:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id bp15so9012015lfb.4;
        Wed, 27 Oct 2021 14:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iOJthmuPEC7IB5L8OM1uajmE3s/Ei+DiZXNIsEtdoSk=;
        b=M6DsUnX+Dqnnl5/0WkKsChXFOe/dRyATOHCL/N/d/DYRaMuFNhNXN2y8l/5KKDdvO8
         HePUBv3ijZ6wA1hQMS8r/8Dy8p8fDstfsgPNvYzogEnoiN08aVSWSCzuevGifeB4Cbsl
         JU+F7xYiyB1f3JwKGti4sTNyf7tgTKcPyJdN2KeBPBno+Y11B21cmAzeN1UTCPeELLZl
         qo9vl+NLInil/J95xFZK38OdgQBYthlLceqQb/6Zg0gcqPneeFesfA544/Mc5a4V8TTa
         vBfOArxwV6NLDS9FtxVb4oHCbiHa9QgKi34nHbfFFiWQfKG+GQY4kpTfJykuXmLPssEZ
         NnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iOJthmuPEC7IB5L8OM1uajmE3s/Ei+DiZXNIsEtdoSk=;
        b=3c9xsRLj1vOzgH/l9+UGfkD8BYkecAwoSSwPvbmezZsaeolGVnwTM59+EWwcaedK93
         olxQ1BfS00Hxhj0ES/+E+Ha3Jo6fVaKUKDyxQRTqV9VxKWHZQiZoofDiBM26VU94xlst
         GEIw6XvtrYNX+3lBKIx0oqvf4gF+mxJ5sTk0lwGLKqahI8FLTOQxJukcTvExrQ0kk3Q1
         F4YmJKUl6DxnD/XZ9qFD/mIMhL5eiB0+7rTiPD65piWL85f9rNw6Dnus5IJIWzTIINqA
         tLKx+Vbyq0qbJQWX9wzyjipDUetTxTJqehYn9iVGpHkkLW+WD/9LgTmy+NHGLE5X/Irn
         Q/hQ==
X-Gm-Message-State: AOAM5302iJo1dClCKmlrXXYeXK7avc/g11ixDkVINvqwDo3YlxJ6SucV
        VR64kz/WX5+ahHdw8R2pS78=
X-Google-Smtp-Source: ABdhPJySbOm+27yOjORJjCzB1RrKvb62o79gukvdjDZzwYphfPzvlvqWgT3cY5UK3KGllNbg7CmL+w==
X-Received: by 2002:a05:6512:344a:: with SMTP id j10mr74981lfr.653.1635369483872;
        Wed, 27 Oct 2021 14:18:03 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id d7sm104336ljl.18.2021.10.27.14.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 14:18:03 -0700 (PDT)
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
Subject: [PATCH v2 06/45] reboot: Warn if unregister_restart_handler() fails
Date:   Thu, 28 Oct 2021 00:16:36 +0300
Message-Id: <20211027211715.12671-7-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211027211715.12671-1-digetx@gmail.com>
References: <20211027211715.12671-1-digetx@gmail.com>
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
index d39e599c3c99..291d44082f42 100644
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

