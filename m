Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA264E1902
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Mar 2022 00:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244381AbiCSXWx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 19 Mar 2022 19:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244385AbiCSXWv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 19 Mar 2022 19:22:51 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03BA8AE6E
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 16:21:28 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id o6so15648314ljp.3
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 16:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rxIG59hWE7fTLM08POLwmSdeNPdfOcqzklKto3ZaqJc=;
        b=XnkMxz93PO3rdLFMI2lfYthrx7Lhicsol4Os8Fj8YenRH3QMiQ9WWxjUZSSXfu1bCA
         Zu4bWFkMfbjR+kCRc6DeIxpawOp55NhpZN2blZQ3VrbtvmdZrekC3NuWFiV+OFJG0yiT
         KyGpY+qQqYk6OKrG/+Gvp83pCOZpDRi2uUqfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rxIG59hWE7fTLM08POLwmSdeNPdfOcqzklKto3ZaqJc=;
        b=K3w9UPp6IKsOQlof1QPzVsL3f7FVxsjaFgX3VX+fsVp9TzFqklzN7PcERoysMWRnqi
         TNNNzdA+jQw49ZwqALJk7g+6fVPH8pAu7iSiMmi+ziTOh29i7IReMc3kjVD40k6q9CNh
         XoJplHuACT5VNAGeskj3lgV3l4c4E5pKxDEhicNomoIoqjUclAunjTg+R2zETKHvXR2I
         EwVbk1rVw/T+msDtxPwt2Sg4wcZqIFtyOZwP3u/Y9+nPqFGz8sMdxKgtUmWrf/PS5Zs7
         OpOr6CRKwiITc1NMpBSHI2T60xfChQqvJZBzlWqrOR62MEEZVowiV+jGdK4AjLLi7D5I
         o++A==
X-Gm-Message-State: AOAM533vrt7NKbdRfZWCXIt6HgvSkCVMGzAElgazr9PTELILYqKj+Cy3
        A3a3j0EsSXPcmBjIRoIhW4bmaVgvrsvbY4oqxwM=
X-Google-Smtp-Source: ABdhPJw9aLC9pThUxe8vUGoSMw0IekSCk1yFPSRfwrWm3q+NZ1T0aW0OEEqBx+amdIfj/TOSt8aJrQ==
X-Received: by 2002:a05:651c:511:b0:249:2492:24ae with SMTP id o17-20020a05651c051100b00249249224aemr10578800ljp.51.1647732087019;
        Sat, 19 Mar 2022 16:21:27 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id o15-20020a2e730f000000b00247eae1ebe7sm1673211ljc.75.2022.03.19.16.21.25
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 16:21:25 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id bx44so9114457ljb.13
        for <linux-acpi@vger.kernel.org>; Sat, 19 Mar 2022 16:21:25 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr10548961lji.152.1647732085458; Sat, 19
 Mar 2022 16:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <20220319222228.4160598-1-morbo@google.com>
 <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
In-Reply-To: <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Mar 2022 16:21:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgH3kbKcNwBO7os3BuU523Gd2aqdu0dVvf50bJbLKrLJg@mail.gmail.com>
Message-ID: <CAHk-=wgH3kbKcNwBO7os3BuU523Gd2aqdu0dVvf50bJbLKrLJg@mail.gmail.com>
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

On Sat, Mar 19, 2022 at 3:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So warning that '%hhX' is paired with an 'int' is all just completely
> mindless and wrong.

Sadly, I can see a different bogus warning reason why people would
want to use '%02hhX'.

Again, the *sane* thing from a human perspective is to use '%02X. But
if the compiler doesn't do any range analysis at all, it could decide
that "Oh, that print format could need up to 8 bytes of space in the
result". Using '%02hhX' would cut that down to two.

And since we use

        char ev_name[5];

and currently use "_%c%02hhX" as the format string, even a compiler
that doesn't notice that "pin <= 255" test that guards this all will
go "ok, that's at most 4 bytes and the final NUL termination, so it's
fine".

While a compiler - like gcc - that only sees that the original source
of the 'pin' value is a 'unsigned short' array, and then doesn't take
the "pin <= 255" into account, will warn like this:

    drivers/gpio/gpiolib-acpi.c: In function 'acpi_gpiochip_request_interrupt':
    drivers/gpio/gpiolib-acpi.c:206:24: warning: '%02X' directive
writing between 2 and 4 bytes into a region of size 3
[-Wformat-overflow=]
       sprintf(ev_name, "_%c%02X",
                            ^~~~
    drivers/gpio/gpiolib-acpi.c:206:20: note: directive argument in
the range [0, 65535]

because gcc isn't being very good at that argument range analysis either.

In other words, the original use of 'hhx' was bogus to begin with, and
due to *another* compiler warning being bad, and we had that bad code
being written back in 2016 to work around _that_ compiler warning
(commit e40a3ae1f794: "gpio: acpi: work around false-positive
-Wstring-overflow warning").

Sadly, two different bad compiler warnings together does not make for
one good one.

It just makes for even more pain.

End result: I think the simplest and cleanest option is simply this:

  --- a/drivers/gpio/gpiolib-acpi.c
  +++ b/drivers/gpio/gpiolib-acpi.c
  @@ -387,8 +387,8 @@ static acpi_status
acpi_gpiochip_alloc_event(struct acpi_resource *ares,
        pin = agpio->pin_table[0];

        if (pin <= 255) {
  -             char ev_name[5];
  -             sprintf(ev_name, "_%c%02hhX",
  +             char ev_name[8];
  +             sprintf(ev_name, "_%c%02X",
                        agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
                        pin);
                if (ACPI_SUCCESS(acpi_get_handle(handle, ev_name, &evt_handle)))

which undoes that '%hhX' change for gcc, and replaces it with just
using a slightly bigger stack allocation. It's not like a 5-byte
allocation is in any way likely to have saved any actual stack, since
all the other variables in that function are 'int' or bigger.

False-positive compiler warnings really do make people write worse
code, and that's a problem. But on a scale of bad code, I feel that
extending the buffer trivially is better than adding a pointless cast
that literally makes no sense.

At least in this case the end result isn't unreadable or buggy. We've
had several cases of bad compiler warnings that caused changes that
were actually horrendously wrong.

                  Linus
