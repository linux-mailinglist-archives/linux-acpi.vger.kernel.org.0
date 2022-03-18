Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E694DE10F
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 19:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240147AbiCRSdk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 14:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240146AbiCRSdk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 14:33:40 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972FA123432
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:32:06 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id e16so1220435lfc.13
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhBJua4MwTn16uw9UYiJEFGtN/+A3wWm3ncEcAGAznM=;
        b=XveiTTIKo48Em6kpMiotlpRXPch6hY8GbRe9VEOQqpG6yRcjfb2uuLDWaH7MdWWew1
         gI8m6zGyXqGBYZXFfD6uchEnbTiGVAMKYwtrir4sHAJ8zGXz6qPjRYwKaVh1dIgoD5Dr
         p/bBCLdzfZWnm59rifezKBDWpY4ECydq3e1f6DbB9ztxomnVWx0X0OTb5N/R2NaqTfgh
         HSY7TAbH+g7cVRBh1555JHIrBWYm/QyxHdHW/QN+mYGR/M20VP46tUat0iTb3tTMVIZh
         6RAXHhN54Z3naU78SqEd065dR7pSMA9ePMsMcipIP7Ii0Q8haEBwngc91xEgEoxVmB9K
         BZzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhBJua4MwTn16uw9UYiJEFGtN/+A3wWm3ncEcAGAznM=;
        b=vPVqN7pH6I31N8qHzCsLq0dhK3qK0aHkwODifMfdpEDuhDo8aluyPu5rpd5Qgl+4MZ
         XINa40NWcM2tD3pCJCmBeqpHwzpvFc35KSJ3vuLzyyG5UW6djSQGYCxFSX4QCJ0y5gMJ
         jFJrXKep3xPaf32q5lpw9lHVhLVgtfjZiXEDa5zo5v3CQoVxlhsgsP2Lpav97byVl9yZ
         UHyBraNi32Me24DIcyw3K0f0M05Bb0uUKCauwQX3YkzPXSWmqyfwLW5anUodnGzdaT7U
         trw4sQQanAX/ZyYj6/QrYHhnzQq+x7Lbhu9i+gg7t8ubOoCG3QrvgqrdURwstJvl5ndA
         tbeQ==
X-Gm-Message-State: AOAM531Z+uf1XWDwNYuX8C0OU3ZHPCJ9sR94A0Y/6E99iRsADTR7jbh3
        cPrwELP+SETCrifJMJrAOZQ3dJNeVN7m3SWhE77XzA==
X-Google-Smtp-Source: ABdhPJzWbK0oJgZeNdqhptZp02Vl7ghfW80F6ZRIb/Zd4pWxJsRPSII+iAwnJeFfon+0mgclS0LLAq7EF/vEp3LrrtU=
X-Received: by 2002:a05:6512:b9e:b0:44a:10eb:9607 with SMTP id
 b30-20020a0565120b9e00b0044a10eb9607mr1450810lfv.626.1647628184755; Fri, 18
 Mar 2022 11:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
 <YjSROmYwwGhpsXMl@smile.fi.intel.com> <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
 <CAGG=3QVCkF7RdbQ85MtKgUjm8qP79BESAUiGU3wSQc0+ExO0gA@mail.gmail.com>
In-Reply-To: <CAGG=3QVCkF7RdbQ85MtKgUjm8qP79BESAUiGU3wSQc0+ExO0gA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Mar 2022 11:29:32 -0700
Message-ID: <CAKwvOd=1+JF6mxpM_K3xCYAr-R8nrj0s7tA9GwUybyiFdLpA2w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Bill Wendling <morbo@google.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 18, 2022 at 11:25 AM Bill Wendling <morbo@google.com> wrote:
>
> On Fri, Mar 18, 2022 at 11:01 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Fri, Mar 18, 2022 at 7:04 AM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Thu, Mar 17, 2022 at 11:11:21AM -0700, Nick Desaulniers wrote:
> > > > Our goal is to enable -Wformat for CC=clang.  Please see also:
> > > > commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> > > > unnecessary %h[xudi] and %hh[xudi]")
> > >
> > > Not that I agree on that commit for %h[h]x
> > >
> > >         signed char ch = -1;
> > >         printf("%x\n", ch);
> > >         printf("%hhx\n", ch);
> >
> > Will print:
> > ffffffff
> > ff
> >
> I noticed this. My first thought was to do something akin to:
>
>   printf("%x\n", (u8)ch);
>
> but went the route of removing the "h" qualifiers to be more in line
> with previous fixes. I will be happy to change this patch if that's
> what you would prefer.

Should we add a note diagnostic to clang suggesting the explicit cast
as one method of silencing the warning?
-- 
Thanks,
~Nick Desaulniers
