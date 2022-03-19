Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982644E18E7
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Mar 2022 23:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244312AbiCSW40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Mar 2022 18:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiCSW4Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Mar 2022 18:56:25 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB812F166
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 15:55:03 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id u3so15668209ljd.0
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 15:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2RcfPrB/V6uUl/QMOUTM8niNIWsvBXQJjvqEWbLTeEM=;
        b=KFXZqangAD/YFTarQejH6BpymNsRw63gr0TokRCxZVPSQGhHCuRkX1gEKlnnSt3JXI
         AJ18NWnU4U+DEIWZqAZWnrEOrWu/femC+tgbzZKWiHdJXmpM0TAyJZzVAdCucZoCKym2
         Gx8C5V/POiGMWGGwUJvnHQF7WQzLZJCrhqA2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2RcfPrB/V6uUl/QMOUTM8niNIWsvBXQJjvqEWbLTeEM=;
        b=WvZGctTFz1HwdUPL9tDD1sm9KO511nxy6FDjRdDbwtRlosYCwb30pi9d4hppvzvKeV
         Vy/3v2pdUQnVqOAJpF5LGj7kElM6r/7kPzZ0W92yQAVlSAxMNYx4oxW2PS5zvknw1QK1
         BmBgjBDj3YJQXpl+L6/v55vtc2owiDUTUCf0FCqlTUROK5sgAjXMry/ZdcnMGxdXKjdP
         F033WKjjFu0UCIEUqr+lBjPNVZzpZ+YSMlsIz6h0iNLJexo77ZRQbY8N5sKhOpmXnzpE
         KI6XHeq71Oz+ydl5hZ60DkOF1H7roooTMUNd2v1iCnwpKZFbLRsAlPht9fBq1zaXmAGP
         Myuw==
X-Gm-Message-State: AOAM531EIN08bqiFrgc3edsrJWcX0yeOg1dFGLC0UFmt2tXfK44Ed6Bq
        l95oCRS7c37pmAqLQKn5ywbJtX/9FQWyL/6j3gA=
X-Google-Smtp-Source: ABdhPJyQ0QM/3i0YnS7vPajG14aeZPcnulKdGbUv7DG8vRR0YvhpgFwZulR4LmzOTjC/4/O/+JcMyw==
X-Received: by 2002:a2e:9e13:0:b0:247:e32a:ddce with SMTP id e19-20020a2e9e13000000b00247e32addcemr10567676ljk.9.1647730501867;
        Sat, 19 Mar 2022 15:55:01 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u1-20020a2eb801000000b002494252ff07sm1659768ljo.112.2022.03.19.15.55.00
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 15:55:00 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id m3so7371926lfj.11
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 15:55:00 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr9683258lfu.531.1647730500067; Sat, 19
 Mar 2022 15:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <20220319222228.4160598-1-morbo@google.com>
In-Reply-To: <20220319222228.4160598-1-morbo@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Mar 2022 15:54:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
Message-ID: <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: acpi: use correct format characters
To:     Bill Wendling <morbo@google.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

So I think that clang warning is only annoying, not helpful, but:

On Sat, Mar 19, 2022 at 3:22 PM Bill Wendling <morbo@google.com> wrote:
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index a5495ad31c9c..92dd9b8784f2 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -388,9 +388,9 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
>
>         if (pin <= 255) {
>                 char ev_name[5];
> -               sprintf(ev_name, "_%c%02hhX",
> +               sprintf(ev_name, "_%c%02X",

This part I approve of.

>                         agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
> -                       pin);
> +                       (unsigned char)pin);

But this cast seems pointless and wrong.

Casts in general are bad, and should be avoided unless there's a real
reason for them. And that reason doesn't seem to exist. We don't
actually want to truncate the value of 'pin', and just a few lines
earlier actually checked that it is in range.

And if 'pin' can't be negative - it comes from a 'u16' table
dereference - but even if it could have been that would have been a
different bug here anyway (and should have been fixed by tightening
the check).

So the cast doesn't add anything - not for humans, and not for a
compiler that could just optimize it away because it saw the range
check.

End result: just fix the pointless 'hh' in the print specifier. It
doesn't add anything, and only causes problems. Anybody who uses '%02X
to print a byte should only use it for byte values - and the code
already does.

Of course, the _reason_ for this all was a warning that was pointless
to begin with, and should never have existed. Clang was not smart
enough to take the range knowledge that it _could_ have taken into
account, and instead wrote out a completely bogus warning.

It's completely bogus not just because clang didn't do a sufficiently
good job of range analysis - it's completely bogus because a 'varargs'
function DOES NOT TAKE arguments of type 'char'.

So the *only* reason to use '%hhX' in the first place is that you
*want* the sprintf() to actually limit the value to a byte for you
(possibly because you have a signed char, know it will sign-extend to
'int', and want to limit it back to 8 bits).

If you *actually* had a 'unsigned char' to begin with, you'd be
completely insane to use %hhX. It's just pointless.

So warning that '%hhX' is paired with an 'int' is all just completely
mindless and wrong.

              Linus
