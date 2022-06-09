Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43F654571B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 00:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345625AbiFIWS3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 18:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345614AbiFIWS2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 18:18:28 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523133D1C3
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 15:18:26 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id d125-20020a636883000000b003db5e24db27so12341713pgc.13
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 15:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zQ6igRU/lPsPPjITd4pdT0XeOfhGOx4hu6xL7AAJoM8=;
        b=QJYSL92EGHv0Glqefsz+fZAyuHXsVDJ+MxqtY38p/rJWyzN9tqq38im0/nAHSSrAcw
         XMQ6nAGoVVakkYRIOxtqwHJW03YmZH40gkW7E/YkdAEWc9hWN2V7ngXOGdkLxNXXFPVz
         MM6SoDd9zGDwN7h4y2Zv5sUmYXsKm79QEart8XywqgYgGMlR5uKSmr2M8zPPYELNG0fC
         sjbVW5cOWu2CabVPyhNOvTWLIe4OkL9eosbWQbgqXLmWmjLl4VHTPCfxGjF9R4eBYA8S
         SWfDBEXFQ0GXfeXiQjFQ4xktd6Mieq2x7asfEjehSXBFdpIoHP2WaOku4Aej/pIaybf5
         FCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zQ6igRU/lPsPPjITd4pdT0XeOfhGOx4hu6xL7AAJoM8=;
        b=qVhjE0UoDrNG5TUMteHBlFgOriIEPDx2cnLI4MLdpIWKYfIB2BKFor28kzTrMPde7+
         IqLoMxH+YEK7z2iLU5IQMAX5ju5S51Hpnaky5qcSkS5WKQRG0I8aQO+tcfRcHaGAr5md
         f07YHYYQbYqRVU6uQJMk3WhOhHStzR5hbK79912bzrS8Sl2fQJEzdbaLxq6FprQF0SUO
         z925oIkGEFPxQCWH+LarwJJn9v95yBLj8ICgWNUHdgkdsmawalRb3yTnxAs8N0CDpXDK
         Kor6vwniHyciB+HsBgWqnp6yzMUBgFWSoACp9gPlBdx8S8NsuRTvq72Ej9cf+LuXVPp9
         bu4A==
X-Gm-Message-State: AOAM533SvqxCgB/3qY5jnhyg5NWTaoXjc+4HYB7+J6HcmNvMDxL+xsbM
        d7mM7EbLoKlzHaf5E3HNToxfyjgx
X-Google-Smtp-Source: ABdhPJwaaQIFrsaGRD2eHE0bL/iy5r4Z+mF9XLusw0L85/0I2ggYu7uuJziQ3x377wlgzuNlbfNxKB4Iyw==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr114285pje.0.1654813104885; Thu, 09 Jun
 2022 15:18:24 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:22 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-4-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 03/12] x86/e820: use correct format characters
From:   Bill Wendling <morbo@google.com>
To:     isanbard@gmail.com
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jan Kara <jack@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, alsa-devel@alsa-project.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bill Wendling <isanbard@gmail.com>

When compiling with -Wformat, clang emits the following warnings:

arch/x86/kernel/e820.c:877:15: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        early_printk(msg);
                     ^~~
arch/x86/kernel/e820.c:878:8: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        panic(msg);
              ^~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 arch/x86/kernel/e820.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index f267205f2d5a..ca4634a0bdb5 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -874,8 +874,8 @@ unsigned long __init e820__end_of_low_ram_pfn(void)
 
 static void __init early_panic(char *msg)
 {
-	early_printk(msg);
-	panic(msg);
+	early_printk("%s", msg);
+	panic("%s", msg);
 }
 
 static int userdef __initdata;
-- 
2.36.1.255.ge46751e96f-goog

