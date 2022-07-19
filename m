Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B8D579787
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jul 2022 12:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiGSKUe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jul 2022 06:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiGSKU2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2022 06:20:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70F13FA5;
        Tue, 19 Jul 2022 03:20:27 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id kh20so10714123qvb.5;
        Tue, 19 Jul 2022 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=w2ggDjwTVu+YFp9lbW40/ezM7FTqimjDcgzL0L7cezQ=;
        b=KDx+k+CwVkTR4lsP3WIXXRHa48gJvs0EjIGVLu6MKO4Xxr0LUeObRr/ycr4eR1atsj
         5gPDhiJmkiBqB3OZ95f95uIG9PTaIxt2Aw1yy+wPydPpBe8N0tj6Jv14pgbU1pjJ9AQf
         DozRu96ve+yLf8TQP0xBvK05ir6xXHw2DqVIuxJG7iRpDQoTRUEBiKe0WxWtUXWJlYMi
         LBt4EhbOc6l9Jsjd6BBkt+ZyYGRse6FaymskBaZhVvPyXrN4AObsOGRGcGYNQOhgb7+I
         tdhZG4UgRqLNl2bCQM0/SV1uhBWqtXMnfPHNvOYZ1Om6XZ1a8vbvzrluD/GXnW3eOOYT
         rfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=w2ggDjwTVu+YFp9lbW40/ezM7FTqimjDcgzL0L7cezQ=;
        b=HG0WJ0SDv99cnDe1xRS+ck2pKyzsW5+L5Vmay7ae4txcAikG8/0SK1XCTNrRZrQ4f6
         tDZodY/GGCOBwaEHmIV8xtTv83lV5VIGRMN+uLYYZtFpev02dAWptvnqpVz329sZsYwl
         sF183+ICcTNOxIftcTFKEqL2ba30AfksJAGEkYfEsQ4xxtDBA5R0Oclef+MDrRI4pkKK
         LNjZIBbBtS0GEw2gp3ve3IqdGCNTy1gSBWrBdxvKjV+yDADzjFFzVavpG85qW4KX69ve
         BLh0zDZf9oDgHO3AUy0Ti+8YpRVCNmlMaUH4hdfq6DdfUS7QoQP2bIX/foOl8uMxxWPJ
         XYAg==
X-Gm-Message-State: AJIora+hRqd/R5cu4mwAApPPYRLD6oUVebJWTLH2BWPYRbeiD5+toVuF
        nnq5vrRq9S5erJtoxd868MA=
X-Google-Smtp-Source: AGRyM1u4lD7kHp+/dXY/ChUfGSPgDGzDqwudNpn31eirT0/l7+rLmDCMYxgsdcSHsSNDhi075Scn4w==
X-Received: by 2002:a05:6214:19c8:b0:472:f250:2d97 with SMTP id j8-20020a05621419c800b00472f2502d97mr24127371qvc.13.1658226026062;
        Tue, 19 Jul 2022 03:20:26 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id x2-20020ac87002000000b0031ed3d79556sm10301644qtm.53.2022.07.19.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 03:20:25 -0700 (PDT)
Message-ID: <6539cb490bfc6fd0956505e9bcb51f84596b932e.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 12:21:27 +0200
In-Reply-To: <CAMRc=Mcgydibw_GXNS_S6=gFZuojo5bBb8ELUc1tTQhbQ2V7hA@mail.gmail.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <CAMRc=Mf1w7DCGMAku0wPHAhTtDWoWkWOfvxkx=_b1pKp8U8yOg@mail.gmail.com>
         <14af555c630654d0a780dc3bf9ecca6f29dcf61a.camel@gmail.com>
         <CAMRc=Mcgydibw_GXNS_S6=gFZuojo5bBb8ELUc1tTQhbQ2V7hA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 2022-07-19 at 11:14 +0200, Bartosz Golaszewski wrote:
> On Tue, Jul 19, 2022 at 10:51 AM Nuno S=C3=A1 <noname.nuno@gmail.com>
> wrote:
> >=20
> > On Tue, 2022-07-19 at 10:25 +0200, Bartosz Golaszewski wrote:
> > > On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com>
> > > wrote:
> > > >=20
> > > > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of
> > > > calling the
> > > > gpiochip 'set_config()' hook. However, AFAICT, there's no way
> > > > that
> > > > this
> > > > flag is set because there's no support for it in firwmare code.
> > > > Moreover,
> > > > in 'gpiod_configure_flags()', only pull-ups and pull-downs are
> > > > being
> > > > handled.
> > > >=20
> > > > On top of this, there are some users that are looking at
> > > > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So,
> > > > unless
> > > > I'm
> > > > missing something, it looks like this was never working for
> > > > these
> > > > chips.
> > > >=20
> > > > Note that the ACPI case is only compiled tested. At first
> > > > glance,
> > > > it seems
> > > > the current patch is enough but i'm not really sure...
> > > >=20
> > > > As a side note, this came to my attention during this patchset
> > > > [1]
> > > > (and, ofr OF,=C2=A0 was tested with it).
> > > >=20
> > > > [1]:
> > > > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@=
analog.com/
> > > >=20
> > > > Nuno S=C3=A1 (4):
> > > > =C2=A0 gpiolib: add support for bias pull disable
> > > > =C2=A0 gpiolib: of: support bias pull disable
> > > > =C2=A0 gpiolib: acpi: support bias pull disable
> > > > =C2=A0 dt-bindings: gpio: add pull-disable flag
> > > >=20
> > > > =C2=A0drivers/gpio/gpiolib-acpi.c=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> > > > =C2=A0drivers/gpio/gpiolib-of.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 7 +++++++
> > > > =C2=A0drivers/gpio/gpiolib.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 8 ++++++--
> > > > =C2=A0include/dt-bindings/gpio/gpio.h | 3 +++
> > > > =C2=A0include/linux/gpio/machine.h=C2=A0=C2=A0=C2=A0 | 1 +
> > > > =C2=A0include/linux/of_gpio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 1 +
> > > > =C2=A06 files changed, 21 insertions(+), 2 deletions(-)
> > > >=20
> > > > --
> > > > 2.37.0
> > > >=20
> > >=20
> > > Series applied, thanks!
> >=20
> > Hi Bart,
> >=20
> > I was actually planning to spin a v2 with your suggestion for the
> > naming of the new define... Did you changed it while applying or
> > should
> > I still send it? Or (last option), we just leave it like this :)?
> >=20
> > - Nuno S=C3=A1
>=20
> Yeah, I'm alright with it how it is after a second though: uAPI uses
> the BIAS_PULL_UP/DOWN/DISABLE notation while the in-kernel API uses
> the same scheme but without the BIAS prefix. Unless you want to
> change
> something else - let's keep it as you first submitted it.
>=20

Alright, works for me...

- Nuno S=C3=A1

