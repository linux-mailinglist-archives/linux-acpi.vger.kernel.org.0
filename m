Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B88C575F3F
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 12:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbiGOKUA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 06:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiGOKT7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 06:19:59 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2D543E49;
        Fri, 15 Jul 2022 03:19:57 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c17so3193688qkl.4;
        Fri, 15 Jul 2022 03:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=yFhnVpPoN7xNfNUIT0Tla7dpxnLgU3UoQpR6t/sQcd8=;
        b=SRnEPfkmtdMK41jmSwCNgl11ytBuHkIJClCOXPokoVSUpfiXdxjOVuQGOI8L7FuGyP
         0V/1GbPKt7apuhtcjEuBu5WQao+I1RZC7tMErhwbZD2BZ89WK60llQR7RlvkH+FHdMtC
         s8sh5CZG9aDvrFaIZZRLZzrJmCDib2ZZuJfgXxYvkC+sgIYif7A4OHE1OYEk8xymJeqf
         NJe+HaqB6MEES0vXauw1zCtt6I85RXKcAnXyaQy5MoVwZAIHpR9A4FqLFQn40aLmAlZv
         WE62To2P0pE1d5QXQanqwCf1KEnZ+xp5rq7mrtwOVHcYd6KJ5pIVSTPsqn1dCAB/QK9/
         eI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=yFhnVpPoN7xNfNUIT0Tla7dpxnLgU3UoQpR6t/sQcd8=;
        b=BUMNPsU3creZXsXJGB3skcDlvd/Jg2hXzQSArJNIJRGVdfJ3EEZk50p/Yn4wdQ2jUr
         pTf9xZhnaAzvKJHLIdGZMH7GHVLaD87zoIk/aL9eUDuM7gkHR7erGKLPNEKkhPW084vp
         rfuxOuwLPBLGVfK0WTMuwR+qBPIGu1MQcSoqRTdf50ZlEDQ+gCJ3eP2ROdwQVx6gP9al
         b5kGgNknEX3TKoqiii88JIH/MhVhBBqAeFr/pX28pZsfuUUCw1CuKyMSshR6ynDoDGqw
         WUq5s74lGdN8RanYacNIC4OUV1GQfVGPhWsBdz218FPUeiZkai8nJZr71DacRxkQ2xz4
         sQyQ==
X-Gm-Message-State: AJIora+eKCU5EdC+wA7PeY1oPL5xsMfDVBPeUIplI9+VUxqU9yA8Mpn2
        D5nz+d1+SPvC8iwtCkxqQ6U=
X-Google-Smtp-Source: AGRyM1vmD8ixu8HvujKQdGpv550AD1C6omXqPRi3W/gOM7Mi7zC9Ibx1z8KesQv2tnnvK6KcG0uURg==
X-Received: by 2002:a05:620a:2845:b0:6ab:8e0c:1938 with SMTP id h5-20020a05620a284500b006ab8e0c1938mr8724176qkp.315.1657880396423;
        Fri, 15 Jul 2022 03:19:56 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id y13-20020a05620a44cd00b006b5a9e53105sm3857854qkp.91.2022.07.15.03.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 03:19:55 -0700 (PDT)
Message-ID: <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Jul 2022 12:20:56 +0200
In-Reply-To: <YtBnIxh6rDJMwpEm@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <YtAvHMmGay/3HACZ@smile.fi.intel.com>
         <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
         <YtBnIxh6rDJMwpEm@smile.fi.intel.com>
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

On Thu, 2022-07-14 at 21:57 +0300, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 05:43:41PM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2022-07-14 at 17:58 +0300, Andy Shevchenko wrote:
> > > On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno S=C3=A1 wrote:
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
> > >=20
> > > So, I looked closer to the issue you are trying to describe here.
> > >=20
> > > As far as I understand we have 4 state of BIAS in the hardware:
> > > 1/ AS IS (defined by firnware)
> > > 2/ Disabled (neither PU, not PD)
> > > 3/ PU
> > > 4/ PD
> > >=20
> > > The case when the default of bias is not disabled (for example
> > > specific, and I
> > > think very special, hardware may reset it to PD or PU), it's a
> > > hardware driver
> > > responsibility to inform the framework about the real state of
> > > the
> > > lines and
> > > synchronize it.
> > >=20
> > > Another case is when the firmware sets the line in non-disabled
> > > state
> > > and
> > > by some reason you need to disable it. The question is, why?
> >=20
> > Not getting this point...=20
>=20
> I understand that in your case "firmware" is what DTB provides.
> So taking into account that the default of hardware is PU, it needs
> a mechanism to override that, correct?
>=20

Exactly...

> > > > As a side note, this came to my attention during this patchset
> > > > [1]
> > > > (and, ofr OF,=C2=A0 was tested with it).
> > > >=20
> > > > [1]:
> > > > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@=
analog.com/
> > >=20
> > > Since this provides a GPIO chip, correct?, it's responsibility of
> > > the
> > > driver to
> > > synchronize it, no? Basically if you really don't trust firmware,
> > > you
> > > may
> >=20
> > What do you mean by synchronize?
>=20
> Full duplex sync, i.e. setting flag to PU for the pins that should
> stay PU:ed
> and disabling bias for the ones, that want it to be disabled. (PD
> accordingly)
>=20
> > > go via all GPIO lines and switch them to the known (in software)
> > > state. This
> > > approach on the other hand is error prone, because firmware
> > > should
> > > know better
> > > which pin is used for which purpose, no? If you don't trust
> > > firwmare
> > > (in some
> > > cases), then it's a matter of buggy platform that has to be
> > > quirked
> > > out.
> >=20
> > I'm not getting what you mean by "firmware should know better"? So,
> > basically, and let's take OF as example, you can request a GPIO in
> > OF
> > by doing something like:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0foo-gpios =3D <&gpio 1 =
GPIO_PULL_UP>;
> >=20
> > In this way, when the consumer driver gets the gpio, all the flags
> > will
> > be properly set so that when we set a direction (for example) the
> > gpiochip's 'set_config()' will be called and the driver does what
> > it
> > needs to setup the pull-up. If we want BIAS_DISABLED on the pin,
> > there's no way to the same as the above. So basically, this can
> > ever
> > happen:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L=
2227
> >=20
> > (only possible from the gpiochip cdev interface)
> >=20
> > So, what I'm proposing is to be possible to do from OF:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0foo-gpios =3D <&gpio 1 =
GPIO_PULL_DISABLE>;
> >=20
> > And then we will get into the gpiochip's 'set_config()' to disable
> > the
> > pull-up or pull-down.
> >=20
> > As I said, my device is an input keymap that can export pins as
> > GPIOs
> > (to be consumed by gpio_keys). The pins by default have pull-ups
> > that
> > can be disabled by doing a device i2c write. I'm just trying to use
> > the
> > infrastructure that already exists in gpiolib (for pull-up|down) to
> > accomplish this. There's no pinctrl driver controlling the pins.
> > The
> > device itself controls them and having this device as a pinctrl one
> > is
> > not really applicable.
>=20
> Yes, I have got it eventually. The root cause is that after reset you
> have a
> hardware that doesn't disable bias.
>=20
> Now, we have DT properties for PD and PU, correct?
> For each requested pin you decide either to leave the state as it is,
> or
> apply bias.
>=20
> in ->probe() of your GPIO you reset hardware and for each GPIO
> descriptor you
> set PU flag.
> In ->request(), don;t know the name by heart, you disable BIAS based
> on absence
> of flags, it can be done without an additional properties, purely in
> the GPIO
> OF code. Do I understand this correctly?
>=20
>=20

Alright, I think now you got it and we are on the same page. If I
understood your suggestion, users would just use GPIO_PULL_UP in dtb if
wanting the default behavior. I would then use the gpiochip 'request()'
callback to test the for pull-up flag right?

If I'm getting this right, there's a problem with it...
gpiod_configure_flags() is called after gpiod_request() which means
that the gpiod descriptor won't still have the BIAS flags set. And I
don't think there's a way (at least clean and easy) to get the firmware
lookup flags from the request callback?

So, honestly the only option I see to do it without changing gpioblib
would be to hook this change in output/input callbacks which is far
from being optimal...

So, in the end having this explicitly like this feels the best option
to me. Sure, I can find some workaround in my driver but that does not
change this...


"
git grep "PIN_CONFIG_BIAS_DISABLE" drivers/gpio/

drivers/gpio/gpio-aspeed.c:963: else if (param =3D=3D
PIN_CONFIG_BIAS_DISABLE ||
drivers/gpio/gpio-merrifield.c:197:     if
((pinconf_to_config_param(config) =3D=3D PIN_CONFIG_BIAS_DISABLE) ||
drivers/gpio/gpio-omap.c:903:   case PIN_CONFIG_BIAS_DISABLE:
drivers/gpio/gpio-pca953x.c:573:        if (config =3D=3D
PIN_CONFIG_BIAS_DISABLE)
drivers/gpio/gpio-pca953x.c:592:        case PIN_CONFIG_BIAS_DISABLE:
"

AFAICT, the only way this path is possible for these drivers is through
gpiolib cdev which might not be what the authors of the drivers were
expecting...

- Nuno S=C3=A1



