Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2622B4DE144
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 19:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbiCRSm2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 14:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbiCRSm1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 14:42:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D782EA0F5
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:41:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id l20so15397749lfg.12
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T68So5s+Mvf8Yxsi6hpGLQhvBaydZiJJcf2u3DNH8AQ=;
        b=ZmBvasPMchpBJ8mkRKb7R3RhkkeHi7XstG7ccVRfInSia4wxmHPc+1XSCMLTTbtwoD
         iBBZhG8pLYhyN+/NcRaXQ6YvBWpZBO0b6qFsSWL8b/QpLIBN/MEi/ZFczp9fnO89TfiE
         WjskrGL3deHU2C25PjWZUp+gAg6DG/SMTBWTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T68So5s+Mvf8Yxsi6hpGLQhvBaydZiJJcf2u3DNH8AQ=;
        b=xTt7a8u55+KjqmiC1q3pmPU9GOOD5CLzs0L4lrjfGITBXkYDMv2fh+jjneYNXbcRhs
         H+QL8oxZAXTW3YJASdIVP0jLYuKcByM+PwzhxqvHmCBtPhLE52EWKRdJEidXdqmhb3/d
         AXw7LddEULcop+zBOkG1QtE87+wqfFzsQWbVI9ZpwBpl3lsW3e+jNcDlwvC+JSJp03tg
         xesifKc5klrTauP1Cl3IHAdYIqDxFvudszbC4bG16lvaHL2GO9dIzLT7rF2JOYjwDLqr
         8uDcRRGeNsq+Y5MJ/K7SDGoRSNfmfCy/LP/x22LTD6QJc65bSvUVnHwEremqzQau7xGv
         0F/w==
X-Gm-Message-State: AOAM533BpmCbpiHLrJ13xxapKUFFkphgaD1U0UfX2D97DjjC8UY4Tkyf
        45Zuz9yM3ZdUv3iIzRWgklXnIyYMDWUyZ/trg5U=
X-Google-Smtp-Source: ABdhPJzWAk6YPjBsAbYdq+9DSgPFNzAWCc5XC38lwwB9cXkbHW3qWfGaAdQ1THY+uMejx6T0rOEmHQ==
X-Received: by 2002:a05:6512:3a6:b0:44a:120d:370d with SMTP id v6-20020a05651203a600b0044a120d370dmr1153832lfp.437.1647628866206;
        Fri, 18 Mar 2022 11:41:06 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id a15-20020ac2520f000000b00445bcfca45fsm961709lfl.248.2022.03.18.11.41.03
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:41:04 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id r22so12402416ljd.4
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:41:03 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr7192968ljg.176.1647628863338; Fri, 18
 Mar 2022 11:41:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com>
 <YjSROmYwwGhpsXMl@smile.fi.intel.com> <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
 <CAGG=3QVCkF7RdbQ85MtKgUjm8qP79BESAUiGU3wSQc0+ExO0gA@mail.gmail.com> <CAKwvOd=1+JF6mxpM_K3xCYAr-R8nrj0s7tA9GwUybyiFdLpA2w@mail.gmail.com>
In-Reply-To: <CAKwvOd=1+JF6mxpM_K3xCYAr-R8nrj0s7tA9GwUybyiFdLpA2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:40:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wis4P8-=-0jmcDzGGuttZ3ESnq0LA5PMOVmKkPRwK1kEA@mail.gmail.com>
Message-ID: <CAHk-=wis4P8-=-0jmcDzGGuttZ3ESnq0LA5PMOVmKkPRwK1kEA@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Bill Wendling <morbo@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 18, 2022 at 11:29 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Should we add a note diagnostic to clang suggesting the explicit cast
> as one method of silencing the warning?

On the compiler side, I would love to see warnings about the ambiguity
of the sign of 'char' in the general case.

That said, I tried to add that to 'sparse' long long ago, and couldn't
make it work sanely. All the approaches I tried all get _way_ too many
false positives.

I tried to come up with some way of figuring out "this code acts
differently depending on whether 'char' is signed or not" and warning
about it, and never could.

And I suspect the same is true even for the much moire limited case of
only format warnings.

Because it's a *bad* idea to use '%d' (or almost any other format
specifier) together with a 'char' argument, but only if you don't know
the range of the char argument.

But the other side of the argument is that quite often, people *do*
know the range of the 'char' argument. If your 'char' type thing comes
from some array or string that you control, and you used 'char' simply
because you know you have small values (typical example: use it for an
array of booleans etc), then it would be very annoying if the compiler
warned you about using '%d'.

There is no reason to use '%hhd' when you know your data range is [0,1].

So honestly, I don't think you can come up with a sane warning that
doesn't cause *way* too many false positives and just annoys people.

I'd love to be proven wrong. In fact, I'd _really_ love to be proven
wrong for that generic case. The "sometimes 'char' is signed,
sometimes it is unsigned, and it depends on the architecture and the
compiler flags" can be a real problem.

                Linus
