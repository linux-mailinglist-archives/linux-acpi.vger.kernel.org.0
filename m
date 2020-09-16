Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A021F26CB31
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 22:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgIPUX3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Sep 2020 16:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbgIPR2k (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2020 13:28:40 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239C4C008769
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2020 06:30:11 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id e14so4002808vsa.9
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2020 06:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZiMEy//1kayA505gPczbbN35iqby1CxZE5VK4t65mE=;
        b=P+7V4bFUf/RvjRpWfeP0Q4K/T92HZyPjcVMWkmfGy57XXUfRJKnm1EGaEcP5cRrl7p
         Vhi4lQHLZ1gtEfPyzRIkaQr7wrvN0paQCK7DUr4relNqRTPL0FBHzXIuSuVK7O7hhfjs
         dAb9yJZAU+pLPFk5XCPwa0SeyGaNYVIb7hD2ism9V/CEklXP+joCcO4HTKedEr+eazu4
         SgXo3wOlXCgn/qlBQVaMnCCgle7zOtPkF4/9FZWQRza3iwMHSPGXcd8N693DeGnFcVz0
         CimWVVGuBiRlsBsUnlKtmIu/gj0nxYxqH4ZGwjnYvK9oBKmzHKrVFJQWKaFYY16dESS7
         I1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZiMEy//1kayA505gPczbbN35iqby1CxZE5VK4t65mE=;
        b=lCYkRRXt2cPSndF6ROwLH82ThpcLVkdwSlWMsyUUksyF11YhESxzBKlWoFo+yocAe/
         24MJEOO4++8oegYlZQ/HZ76TBBf/jh8K7IcnZrq7LfJfSsXXOlIE0XCGY8urPuzpQqyu
         hiPn9yyxNHqUiLWYszQTLkrCp4q3gfjb6kNLZ7pyIAD2WUyDWT15Y3PD+AESWkcyEv1J
         JTDKDGoi4wJlgVaelsI7YdJOGVuRV0u7Zd2xEmzIWvECw3Zh83JDpmJUN98n9VCfzJbV
         l+jORU0UNLKEI2/frUAVQ+qGHywCv3I7CNdZTm6vMrggoyBu2RXUleaSdPwKgO9axXpH
         DJTg==
X-Gm-Message-State: AOAM530C+PZkvghOMx/KnQ60RWl+LDhaAj/STxngbrrWbvltVQAmwAF3
        uH7pes5FUqCbf+w+qtFcd/Oojsh90WdNl29jqey8Cw==
X-Google-Smtp-Source: ABdhPJwGKLu0z/dTDqySAlqgfg7vIw00CAxMAF/n/hdDKH4w89Jgg8+PYleCXBvx1Bvv7Pek2lkAhCyQonJy7yX90Kg=
X-Received: by 2002:a67:e290:: with SMTP id g16mr4591851vsf.56.1600263009036;
 Wed, 16 Sep 2020 06:30:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl> <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
In-Reply-To: <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Sep 2020 15:29:58 +0200
Message-ID: <CAMRc=MdNxxAHQK5i4rZo3d4iy5JNco-f0V-UzVNTTJQyH6AZpA@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 2:02 PM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > I initially sent this as part of the gpio-mockup overhaul but since
> > these patches are indepentent and the work on gpio-mockup may become
> > more complicated - I'm sending these separately.
> >
> > The only change is adding additional property helpers to count strings
> > in array.
> >
> > Bartosz Golaszewski (3):
> >   device: property: add helpers to count items in string arrays
> >   gpiolib: generalize devprop_gpiochip_set_names() for device properties
> >   gpiolib: unexport devprop_gpiochip_set_names()
>
> I do an arm64 allmodconfig build fron linux-next (tag: next-20200915) and
> run that in qemu. When I run I see the following output (see full log [1]):
> "BUG: KASAN: null-ptr-deref in device_property_read_string_array".
>
>

FYI: this fails because someone passes a NULL struct device * to
dev_fwnode() - this is probably caused by some ordering issues in this
patch. I'm working on it.

Bartosz
