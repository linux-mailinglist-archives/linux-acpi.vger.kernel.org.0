Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0763826B0DA
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Sep 2020 00:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgIOWUu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 15 Sep 2020 18:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgIOQ3P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 15 Sep 2020 12:29:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90A7C061223
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 09:03:18 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id o8so5816666ejb.10
        for <linux-acpi@vger.kernel.org>; Tue, 15 Sep 2020 09:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1lfPyfpR3MIdTzczk3F37y8kFkSG7QNcKC/F+53Umo=;
        b=hYng2VdXUMalsQlpbxvEaolvVrPXjjO1dg1IBNOJpR5POkg+h+5dS3w6ALmjl43QBv
         2kG3eFGBMkUjnyQkOgDNuJN6KiCSm2Xz+1UBa8swFgxPuWy5j8g7p8aPFbbzCNJUVgTi
         XTq9x3K52I7ybf36Z2pMDOaEp0SObYccGT0njIzOFGqscUVXUzET+d+qdoa70XNgeuIq
         ychiRQy9UO2BSe1I3ZkArwzDgmWXvpkEs/amhQ+IIrqVJ+u+TGU6vHxuH2Ocno64YMWW
         lWGLtShJwmSH8u00qJQXoTlVRtckLrfdDBCybJTNP4Ck/xv44l9uzkdhrjP9gzNWDaBx
         aRhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1lfPyfpR3MIdTzczk3F37y8kFkSG7QNcKC/F+53Umo=;
        b=H+Q18DfIZahrMwr1Oue0gVGVRnoQYwaXHTijIMcr09JN6P3IPA92OXSqUvsoyaNcxv
         eeeBJKJ171v2Y0DTDTXLIS+A7T78oAC41d51YMK/63R13kST0WJEi2r6SCYWigS4oM12
         Xc2JQLVFngFfSGitHepWiYHlSjaKXYBz+9AZvS+6iKgQ1dsy7+3nFl1Q/aQZEKkWbk2H
         GiRzbE139T1qtVfdOyWP4CDbTfYYKQF4rkHIfnsPHSe3cxctfSmrnen8pbgBqgAH6vre
         ClUsRdueqUfs2/4jMkwOp1l84H2SCJWX/5BDXABSSgYCFgACq1t+LaR7uJcvbA9IR2eP
         UQIA==
X-Gm-Message-State: AOAM531QFwHQoVv83SG2qdzrVNVxi0uj9LaGjtha3kZxEJXqbL00w8kU
        okbYf7h8wXL0RhzsoAensnJzOTg5SxtSgYhpDztc4g==
X-Google-Smtp-Source: ABdhPJxYCowJHvOnUFmc3bdVZqbBgmz4hRM4SON4OjzOoHFhBUb9Zqenf9cirxMo9cDeB/QVoD9ttHN6GESWUQ8YGig=
X-Received: by 2002:a17:906:6007:: with SMTP id o7mr21824842ejj.550.1600185797421;
 Tue, 15 Sep 2020 09:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200908125813.8809-1-brgl@bgdev.pl> <CADYN=9+3kHG0CexzZiMQoXdF2piN2ZhOTObhY=7VCKrnFVN0Kw@mail.gmail.com>
 <20200915131228.GX3956970@smile.fi.intel.com> <20200915131648.GY3956970@smile.fi.intel.com>
In-Reply-To: <20200915131648.GY3956970@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 15 Sep 2020 18:03:06 +0200
Message-ID: <CAMpxmJUOhFjmFFq3sKZSh3QTjgZSGLhRRFt=iSzYAmXzNzupaw@mail.gmail.com>
Subject: Re: [PATCH 0/3] gpiolib: generalize GPIO line names property
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Sep 15, 2020 at 3:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Sep 15, 2020 at 04:12:28PM +0300, Andy Shevchenko wrote:
> > On Tue, Sep 15, 2020 at 02:01:56PM +0200, Anders Roxell wrote:
> > > On Tue, 8 Sep 2020 at 18:40, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > I initially sent this as part of the gpio-mockup overhaul but since
> > > > these patches are indepentent and the work on gpio-mockup may become
> > > > more complicated - I'm sending these separately.
> > > >
> > > > The only change is adding additional property helpers to count strings
> > > > in array.
> > > >
> > > > Bartosz Golaszewski (3):
> > > >   device: property: add helpers to count items in string arrays
> > > >   gpiolib: generalize devprop_gpiochip_set_names() for device properties
> > > >   gpiolib: unexport devprop_gpiochip_set_names()
> >
> > Ha-ha, OF unittest is of_node centric. definitely there is no backed device.
> >
> > Bart, it seems we are stuck with fwnode interface.
>
> Hmm... There is a platform device. So, it means that it fails along these
> lines:
>   return IS_ENABLED(CONFIG_OF) && dev->of_node ? &dev->of_node->fwnode : dev->fwnode;
> so, who should set fwnode for of_node?
>

It's strange because the device for this unittest is registered
similarly to how we do it in gpio-mockup where this function works.
I've not investigated the internals but somewhere someone sets the
fwnode for these platform devices.

Bartosz
