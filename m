Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C05545729
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 00:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345406AbiFIWVT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 18:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345687AbiFIWVG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 18:21:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66424E3BB
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 15:21:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e5-20020a255005000000b0065cb3669fe9so21343189ybb.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v4Xn62a8gwv09PX197f2KX5K6c68JUg+Unaoh5Rs3zU=;
        b=rIM31hja6TacLFy83ekGaYY6NocbE3+qp06k1AYSWqT3YCOM3vKnexoLoVRg3/QFrC
         NK6lDPMraatUaGV4ysDVq7Ma73A8ej30mShvcnMynXPj4q1s4HwLXHsyE5NReacxVqEF
         SN/r5DNjRMP1h9Yx1PS5+t5PqoRBJ1DmF1KeRqex3FpyMoNRbYlXt2tQwLA6Cftv+3aS
         xU6s22QmO1Pl1Kwrbe6vsMz+d3Z4FRfHNfEK9twj222QTX3BVZNBOKgun1MV8xBDAQQA
         +IscNJZzBGaDfdE3Gg++zvAyvxAsnUQ0EJis1knVDwKv7m2aWEOPArINp5NiPyNi+Z2n
         h4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v4Xn62a8gwv09PX197f2KX5K6c68JUg+Unaoh5Rs3zU=;
        b=1Z/h0IMBqQQItJuLua5X34y2fLs0XOW+juicC3vc3R46grTX9/ZwIqRG4BCNQu0xdP
         YnAUr/oZgbxxTM/4Q8YnJmc2WDFEvSBwAQ2hBO7QQNRnLrHTZ0S3qMxINPswWfUnkuam
         690k7raBSW7ZrrccfvHtYdjkNmzo9FuUMOK2WXcsMirNSnWEgNldWuOqfoqCJSqRtkj1
         80SFKn9nQJ8xbHMGXLLuQqukP59hgZVueVFIw7DLKDV4Ijg5QGEb2YuWsKr1VXzAsgiK
         CPdhseeuDmgb/5QhHTkJ43UgxIDxP4HnsUtinbHM6xErJVSi2x0yESmflHWiBeilDi71
         y3OQ==
X-Gm-Message-State: AOAM532XaKP0x1zTR5lA+q1sZucfLC1Az/50VlxjnHl4QynRpm2C9Idf
        UEZBd5R8V1rme0u5QpPkG4r1h39b
X-Google-Smtp-Source: ABdhPJwSDxouzP8D6734EA8fpYrXSwixl1FJKKaGzKk8Ee6TEpQt79esVExDoO3PJGM+WWqOyJq6+ArWEg==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a25:76d5:0:b0:663:ad77:8d48 with SMTP id
 r204-20020a2576d5000000b00663ad778d48mr18678005ybc.633.1654813262959; Thu, 09
 Jun 2022 15:21:02 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:29 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-11-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 10/12] ALSA: seq: use correct format characters
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

sound/core/sound.c:79:17: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        request_module(str);
                       ^~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 sound/core/sound.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/sound.c b/sound/core/sound.c
index df5571d98629..7866f29621bf 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -76,7 +76,7 @@ static void snd_request_other(int minor)
 	case SNDRV_MINOR_TIMER:		str = "snd-timer";	break;
 	default:			return;
 	}
-	request_module(str);
+	request_module("%s", str);
 }
 
 #endif	/* modular kernel */
-- 
2.36.1.255.ge46751e96f-goog

