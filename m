Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B634DE0A0
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Mar 2022 19:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239949AbiCRSCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Mar 2022 14:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239944AbiCRSCq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Mar 2022 14:02:46 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8322A1298
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:01:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id w12so15269932lfr.9
        for <linux-acpi@vger.kernel.org>; Fri, 18 Mar 2022 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i1Ms63NIkd6E7s+RusloWQgZ7ue4LhJ4QsLqeHtSUJw=;
        b=UmJ7ZODw+NbFnzVmsyjuDdBgu4T/BwFBuS2/0+3MpNrwys8fTBTfkYBO1USQX87RCc
         GytlT2Sz0odsaeGpYDGyMwEBtfolTTfoXe/0/w8shAKFDO+IRj1la0blGBdQOVphsqY7
         M3IJWHcNUuY3XpphtwP3Ccs3F0vVtc7X4tupL6zeR1RE0r6kEUnLdV6sv6abGBSKuAvT
         qsz62NmNx+qchrEYSrn3OzEydIzwRraHZ8mwieJYb1vuVoLB/731mnpJMslLxnJ/Q8em
         PiirQtwAVuwulvHUk2tiS2Du+CYiHYNqBE/RFHLy24dEqp6UfqUw5Ii145O69Lw/vjea
         Ly/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1Ms63NIkd6E7s+RusloWQgZ7ue4LhJ4QsLqeHtSUJw=;
        b=O62SggyDgSrWnD/9axentmLAcNSoAMs9TVlecPCncLoG2mqyhdk7TxfwofNIsQHgwv
         D7ZaZ6m3HyIHlFExcyhpPfza2GsGNfKtphMx6t8AWuWti1AFsWoCPU6lMnJBGfPSuwBV
         Y3BbagDiwI6xg8MoVMEP+Gck+LhYatTY1uErQBgfQ6uj+0k15ubJpJ1dAxEIEy42iU9J
         EMGEUxmce/Cv2ihQvtu4Jr8SDxNYJRvbZznHgg5AcW5uT1TOEQsuOEoxZ0GkVZoO1CUI
         h88ibuz6GEfGJqqRvYQ5gbOvKVfO/VEI8uTrRIhzoWgx4wfB+nTB1D418Pgha5pdmaBP
         emBg==
X-Gm-Message-State: AOAM533IBo10K6DOPJPge5d0itJih4F0OtOj+heHR2lVCr+zRQ+t12Ik
        y41DryyMsUdQkBYfxe/cAK3L0nzDHRqDoabc9kug9Q==
X-Google-Smtp-Source: ABdhPJz6aj15Mk032FInyJsNGaIzC0VM6EnNcglPQg/SUnzZ2trHPqDTPq6Y0J4vC0VxLXeRF9Apc6TRZUmywwUSrg0=
X-Received: by 2002:a05:6512:b9e:b0:44a:10eb:9607 with SMTP id
 b30-20020a0565120b9e00b0044a10eb9607mr1382981lfv.626.1647626485133; Fri, 18
 Mar 2022 11:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <YjL6K49CkH+YC4FQ@smile.fi.intel.com>
 <CAKwvOdkjb3uR+kqjfdKL5gqA8R+00c5=3E7uGGW+mGZ3QRsjqg@mail.gmail.com> <YjSROmYwwGhpsXMl@smile.fi.intel.com>
In-Reply-To: <YjSROmYwwGhpsXMl@smile.fi.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 18 Mar 2022 11:01:13 -0700
Message-ID: <CAKwvOdkEjrPUL4HuO3UKaUZAzVw=XV1bEOSj6HR5R1WTUSSZ4w@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use correct format characters
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bill Wendling <morbo@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 18, 2022 at 7:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 17, 2022 at 11:11:21AM -0700, Nick Desaulniers wrote:
> > Our goal is to enable -Wformat for CC=clang.  Please see also:
> > commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of
> > unnecessary %h[xudi] and %hh[xudi]")
>
> Not that I agree on that commit for %h[h]x
>
>         signed char ch = -1;
>         printf("%x\n", ch);
>         printf("%hhx\n", ch);

Will print:
ffffffff
ff

Maybe we should reconsider our recommendations for signed types?

It's probably worth adding `signed char` explicitly to
Documentation/core-api/printk-formats.rst, as it is a distinct type
from `char` in C.
-- 
Thanks,
~Nick Desaulniers
