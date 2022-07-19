Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4115795E5
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jul 2022 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiGSJO4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jul 2022 05:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiGSJOu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2022 05:14:50 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95ED24F35
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jul 2022 02:14:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id t3so18760096edd.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 Jul 2022 02:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ACTSpTsTqX7A3W4uLC3rV5eMlRf/qILnDAzAz4VXdI=;
        b=d5D7ElkUQFzhtHOaEl/PtsmXs1fpH23EV43d/mkA4zlsjs4qkUl1933urX2GBWN35F
         nXKg+moRX3k/RiKRqaAFbhrxekFy+2o210oBH0kl+YEAcKpWU60pcdcImFxDbd5WoOHl
         MUySqWRBTNsIuvAsJgN6ZyQ8KflPOA3xWrNDw9O5cBMKzZJM+YwLX9HbSGzerb+1BmSI
         bbEgATU5tfLrfsgQ1OHoDuZS3UrI7TMAJ+S9CAW51DqZA/YnBkKavHAA9wgyqfflFvKZ
         MFtiD3Co16DqDhFDa2+BExkCZ5CgxCMtwZQXC1FMSAx8NCglskgyBOaH4kFoT63nyd4E
         L1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ACTSpTsTqX7A3W4uLC3rV5eMlRf/qILnDAzAz4VXdI=;
        b=cDXaiaVb8mqF+kDFV2dmkgp/OPswPcLHhvaKG9U7backJi1cUetxDutIYKQEmeM2UU
         dDCK0Zbcq82wCdXsyaXv09e72N+ZlPH5I3qvLbzXD5IzcR6zwXNvHsE8tTdNV7A36K+A
         t3QNsu9MIVc1MyCmVgyDaFTJ38uGU9sFneJDbU2A9jNRmKih1xOvGWdenPGWH7YK0VW/
         2sTtXk2J3hw+/ATnrTorctS5solsurP4rPui8EoPy3isdnb7XQg4+M3VO9THsYK2CQhg
         ci9kofnJM8LINldhgnHd9RI3cF/nWBoNZLI4GQGafsfrov7gYW0+jMYzcbt3S9jvTChg
         iDBQ==
X-Gm-Message-State: AJIora8mkbvprh3AicYggEbe45V9Vmx3eM3CSTlkoyztypd4nRmprBrw
        1L+tzLti11IeuCfzHTeaihEoEtq4LoEpS+2ocmxibQ==
X-Google-Smtp-Source: AGRyM1t15DGxlnJ8KDfBuNALNYBrQ/tIiuIFbbjsarwTCSGbhSYa64cau9lXmZT0YGKYCk+FR/ArnEPt0iEB0wCL5po=
X-Received: by 2002:a05:6402:4c3:b0:43a:f612:179d with SMTP id
 n3-20020a05640204c300b0043af612179dmr42764636edw.422.1658222087537; Tue, 19
 Jul 2022 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <CAMRc=Mf1w7DCGMAku0wPHAhTtDWoWkWOfvxkx=_b1pKp8U8yOg@mail.gmail.com>
 <14af555c630654d0a780dc3bf9ecca6f29dcf61a.camel@gmail.com>
In-Reply-To: <14af555c630654d0a780dc3bf9ecca6f29dcf61a.camel@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Jul 2022 11:14:36 +0200
Message-ID: <CAMRc=Mcgydibw_GXNS_S6=gFZuojo5bBb8ELUc1tTQhbQ2V7hA@mail.gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jul 19, 2022 at 10:51 AM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote=
:
>
> On Tue, 2022-07-19 at 10:25 +0200, Bartosz Golaszewski wrote:
> > On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:
> > >
> > > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of
> > > calling the
> > > gpiochip 'set_config()' hook. However, AFAICT, there's no way that
> > > this
> > > flag is set because there's no support for it in firwmare code.
> > > Moreover,
> > > in 'gpiod_configure_flags()', only pull-ups and pull-downs are
> > > being
> > > handled.
> > >
> > > On top of this, there are some users that are looking at
> > > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless
> > > I'm
> > > missing something, it looks like this was never working for these
> > > chips.
> > >
> > > Note that the ACPI case is only compiled tested. At first glance,
> > > it seems
> > > the current patch is enough but i'm not really sure...
> > >
> > > As a side note, this came to my attention during this patchset [1]
> > > (and, ofr OF,  was tested with it).
> > >
> > > [1]:
> > > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@an=
alog.com/
> > >
> > > Nuno S=C3=A1 (4):
> > >   gpiolib: add support for bias pull disable
> > >   gpiolib: of: support bias pull disable
> > >   gpiolib: acpi: support bias pull disable
> > >   dt-bindings: gpio: add pull-disable flag
> > >
> > >  drivers/gpio/gpiolib-acpi.c     | 3 +++
> > >  drivers/gpio/gpiolib-of.c       | 7 +++++++
> > >  drivers/gpio/gpiolib.c          | 8 ++++++--
> > >  include/dt-bindings/gpio/gpio.h | 3 +++
> > >  include/linux/gpio/machine.h    | 1 +
> > >  include/linux/of_gpio.h         | 1 +
> > >  6 files changed, 21 insertions(+), 2 deletions(-)
> > >
> > > --
> > > 2.37.0
> > >
> >
> > Series applied, thanks!
>
> Hi Bart,
>
> I was actually planning to spin a v2 with your suggestion for the
> naming of the new define... Did you changed it while applying or should
> I still send it? Or (last option), we just leave it like this :)?
>
> - Nuno S=C3=A1

Yeah, I'm alright with it how it is after a second though: uAPI uses
the BIAS_PULL_UP/DOWN/DISABLE notation while the in-kernel API uses
the same scheme but without the BIAS prefix. Unless you want to change
something else - let's keep it as you first submitted it.

Bart
