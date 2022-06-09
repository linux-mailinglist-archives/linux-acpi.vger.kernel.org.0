Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCFA54572D
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jun 2022 00:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345712AbiFIWUs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 Jun 2022 18:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345787AbiFIWUV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Jun 2022 18:20:21 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30464CD5F
        for <linux-acpi@vger.kernel.org>; Thu,  9 Jun 2022 15:20:18 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id j8-20020a17090a3e0800b001e3425c05c4so286405pjc.0
        for <linux-acpi@vger.kernel.org>; Thu, 09 Jun 2022 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dB/VRnBqrla/uo3hQxagOMwn8rw3rKKNrg8KvvIMmrs=;
        b=NA8rGIzS2Lo/FSyJFJSopJzo3vj2qG+W/JBu2Td+wh8lNm3aGHNFbCPALJTDiKY3VZ
         BXYoT+Ww8rgiNjDcWDo8JWEIvIa789ch4uJ/akkx61GHrCbS4UYTLU+WBzXi0U6zqFg6
         WETSd0zF9UD0yrUhECgMgO4+3B7vaNDE5q4OxsAILit4vZz26MEF5lP7eGpObNUfQYZP
         qWyriCnElNMS5dBnlp4ECfJw4cwUWsda0JPVGIsCkMRh996FjTM9tl6X5Bjcl49Ex3bX
         056kN/4A+KMGFsvjat6Zhxnibo6NVJe0KQfbbqHffKzcdpAaOGAQ/5H1gcLRSIgsdnQd
         eZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dB/VRnBqrla/uo3hQxagOMwn8rw3rKKNrg8KvvIMmrs=;
        b=4hjMqT57HmttjMIvbbVdn3ZcCZ+N+BeUPsrMhtnEHOGPC/Xvv4MInzC7YMZyP2SFZK
         cu90elwc/G63gQB9Kc3yBsxIJcdz4rkdWfCXR7s3RLZAeq/JYBtos0k1qYQWb70IfNhP
         6oiZBbUW9keT/ok5i1epYGlrSkhNQ/UYB2G9XZkRANsTBOo92Dh1I1wglLaPBfMY5+Ym
         AUaHWINxvjrFmt+Pm6BB6j7vixQa+iwUIf6Jb9KIkEqeXBuCkO7Ug+MRXkY2/sX+qdFj
         VjZ9Xnxcd5B66+A0j+MbKDnPemAf+ulQOTsSMWiVLNuGCV+Kz7C6sV7dVChjw43of6EE
         UD3A==
X-Gm-Message-State: AOAM531IRWX2Ipg/hM1QnB3UlxiKNVEzu7tEQi83vtoxuVJ6M7zIi8C0
        8sielP1MIIxwwaKNLCtP8pGKtWCX
X-Google-Smtp-Source: ABdhPJye2mFQrzIepKAqLUDnC7IYTgWuIi+7I2qa8DRzQUgLX+2gR0oj+bp3uxnl8nOmUO9s5APs/msqoQ==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a62:e919:0:b0:51e:7b6e:5a3b with SMTP id
 j25-20020a62e919000000b0051e7b6e5a3bmr1529888pfh.78.1654813218119; Thu, 09
 Jun 2022 15:20:18 -0700 (PDT)
Date:   Thu,  9 Jun 2022 22:16:27 +0000
In-Reply-To: <20220609221702.347522-1-morbo@google.com>
Message-Id: <20220609221702.347522-9-morbo@google.com>
Mime-Version: 1.0
References: <20220609221702.347522-1-morbo@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 08/12] cdrom: use correct format characters
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

drivers/cdrom/cdrom.c:3454:48: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
        ret = scnprintf(info + *pos, max_size - *pos, header);
                                                      ^~~~~~

Use a string literal for the format string.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Bill Wendling <isanbard@gmail.com>
---
 drivers/cdrom/cdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 416f723a2dbb..52b40120c76e 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3451,7 +3451,7 @@ static int cdrom_print_info(const char *header, int val, char *info,
 	struct cdrom_device_info *cdi;
 	int ret;
 
-	ret = scnprintf(info + *pos, max_size - *pos, header);
+	ret = scnprintf(info + *pos, max_size - *pos, "%s", header);
 	if (!ret)
 		return 1;
 
-- 
2.36.1.255.ge46751e96f-goog

