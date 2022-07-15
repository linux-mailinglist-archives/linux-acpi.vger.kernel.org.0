Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67F857677D
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 21:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiGOTck (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 15:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiGOTc2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 15:32:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B017CB49
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 12:31:29 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ss3so10616485ejc.11
        for <linux-acpi@vger.kernel.org>; Fri, 15 Jul 2022 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uSPAlJmmriHlDlb3vXTxChyWNuSFJl3lViR/KmDCEp0=;
        b=mGQ/fC/afrlTfsP5AGy6ti26lz3ZJEevbJSIPBoI5ke1EdbM5NU4FiqqzwdhN7bXzq
         80j2Hl0EdfAA/b0i0EhSldowE9lrZfEvZQNTVvqv7LvLegUQ4v7Qu3UoHXBMVWxu1x/4
         HfhRrKFxk5XQ0zUluO2159GLvjRVy+PUbNvzpzrPu21KXgttTVP98xjkRYLdiHfI9IKU
         fUm8A9lGorzcdsZk+LH+rBk/N8sI4ixR44DEj6QmS41t5EEM/06XonnAspBpwAjt1M3T
         qvuMGdEvLbgE9yBAtm5bUdVLmmJ2sakdxJdiY7TQdsjyDmI9aSXF+Gr+kPxPTslKGCEU
         h3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uSPAlJmmriHlDlb3vXTxChyWNuSFJl3lViR/KmDCEp0=;
        b=1jfI3XNGSglThPQRJZi2VTT4lmVD2yZDg6dacNVtE4fEWffbYR+A14VUkk4rWsweCu
         QdBhcLaImdx76v3kOnTXT9AGFpUm6NvYlflbYxLI50H7PY9DcGHcun7eKjwqVF25LXDz
         GFnb88RwT+AumD36/Vvp0TV+d6aDGFxG2itaCWRzY8saqAkgS1Zbg4Pc4rAedRcAKFUv
         MmnJ/nB0xo0mzmSANcqEQ2mofZZpXdHTzJ3HsppfcdG7xQFwPoNY6h3hSsQ86pSviFsg
         wDc5UDzZ12fUZ9qgV7TW1Ty35duJneoFXgG6f6AHz+cTXj9O90c+VRRWICanVEzKmDg/
         TL8Q==
X-Gm-Message-State: AJIora+RHRpe7Qr6ROupTQKrAP81Od2gatxKRtfryJQPmWyYh37aEyy4
        RVeVKYg8fhjcmCg5V29bYLgav6f3FuhH/e/jIs6YIw==
X-Google-Smtp-Source: AGRyM1uqQkQx8LQQMZrsiH9jK3cummGrCvx8epOPfvpKc8lsZKZ8p2R43vjWolVg90hTjkOjFDYhL4Ut7psKzBzMsXA=
X-Received: by 2002:a17:907:87b0:b0:72b:9f0d:3f89 with SMTP id
 qv48-20020a17090787b000b0072b9f0d3f89mr13954400ejc.734.1657913483500; Fri, 15
 Jul 2022 12:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220713131421.1527179-1-nuno.sa@analog.com> <YtAvHMmGay/3HACZ@smile.fi.intel.com>
 <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
 <YtBnIxh6rDJMwpEm@smile.fi.intel.com> <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
 <YtFYFbP+xqAUUHZa@smile.fi.intel.com> <88114aeb10f7316cf3c1396179949f2fc351ad8f.camel@gmail.com>
In-Reply-To: <88114aeb10f7316cf3c1396179949f2fc351ad8f.camel@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 15 Jul 2022 21:31:12 +0200
Message-ID: <CAMRc=Mdz+8yfrATQPJ=uY33k2Dwt29g6vZbP3mSjkB_VAzP5+A@mail.gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
To:     =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 15, 2022 at 2:19 PM Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>
> On Fri, 2022-07-15 at 15:05 +0300, Andy Shevchenko wrote:
> > On Fri, Jul 15, 2022 at 12:20:56PM +0200, Nuno S=C3=A1 wrote:
> > > On Thu, 2022-07-14 at 21:57 +0300, Andy Shevchenko wrote:
> > > > On Thu, Jul 14, 2022 at 05:43:41PM +0200, Nuno S=C3=A1 wrote:
> > > > > On Thu, 2022-07-14 at 17:58 +0300, Andy Shevchenko wrote:
> > > > > > On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno S=C3=A1 wrote:
> > > > > > > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation
> > > > > > > of
> > > > > > > calling the
> > > > > > > gpiochip 'set_config()' hook. However, AFAICT, there's no
> > > > > > > way
> > > > > > > that
> > > > > > > this
> > > > > > > flag is set because there's no support for it in firwmare
> > > > > > > code.
> > > > > > > Moreover,
> > > > > > > in 'gpiod_configure_flags()', only pull-ups and pull-downs
> > > > > > > are
> > > > > > > being
> > > > > > > handled.
> > > > > > >
> > > > > > > On top of this, there are some users that are looking at
> > > > > > > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So,
> > > > > > > unless
> > > > > > > I'm
> > > > > > > missing something, it looks like this was never working for
> > > > > > > these
> > > > > > > chips.
> > > > > > >
> > > > > > > Note that the ACPI case is only compiled tested. At first
> > > > > > > glance,
> > > > > > > it seems
> > > > > > > the current patch is enough but i'm not really sure...
> > > > > >
> > > > > > So, I looked closer to the issue you are trying to describe
> > > > > > here.
> > > > > >
> > > > > > As far as I understand we have 4 state of BIAS in the
> > > > > > hardware:
> > > > > > 1/ AS IS (defined by firnware)
> > > > > > 2/ Disabled (neither PU, not PD)
> > > > > > 3/ PU
> > > > > > 4/ PD
> > > > > >
> > > > > > The case when the default of bias is not disabled (for
> > > > > > example
> > > > > > specific, and I
> > > > > > think very special, hardware may reset it to PD or PU), it's
> > > > > > a
> > > > > > hardware driver
> > > > > > responsibility to inform the framework about the real state
> > > > > > of
> > > > > > the
> > > > > > lines and
> > > > > > synchronize it.
> > > > > >
> > > > > > Another case is when the firmware sets the line in non-
> > > > > > disabled
> > > > > > state
> > > > > > and
> > > > > > by some reason you need to disable it. The question is, why?
> > > > >
> > > > > Not getting this point...
> > > >
> > > > I understand that in your case "firmware" is what DTB provides.
> > > > So taking into account that the default of hardware is PU, it
> > > > needs
> > > > a mechanism to override that, correct?
> > > >
> > >
> > > Exactly...
> > >
> > > > > > > As a side note, this came to my attention during this
> > > > > > > patchset
> > > > > > > [1]
> > > > > > > (and, ofr OF,  was tested with it).
> > > > > > >
> > > > > > > [1]:
> > > > > > > https://lore.kernel.org/linux-input/20220708093448.42617-5-nu=
no.sa@analog.com/
> > > > > >
> > > > > > Since this provides a GPIO chip, correct?, it's
> > > > > > responsibility of
> > > > > > the
> > > > > > driver to
> > > > > > synchronize it, no? Basically if you really don't trust
> > > > > > firmware,
> > > > > > you
> > > > > > may
> > > > >
> > > > > What do you mean by synchronize?
> > > >
> > > > Full duplex sync, i.e. setting flag to PU for the pins that
> > > > should
> > > > stay PU:ed
> > > > and disabling bias for the ones, that want it to be disabled. (PD
> > > > accordingly)
> > > >
> > > > > > go via all GPIO lines and switch them to the known (in
> > > > > > software)
> > > > > > state. This
> > > > > > approach on the other hand is error prone, because firmware
> > > > > > should
> > > > > > know better
> > > > > > which pin is used for which purpose, no? If you don't trust
> > > > > > firwmare
> > > > > > (in some
> > > > > > cases), then it's a matter of buggy platform that has to be
> > > > > > quirked
> > > > > > out.
> > > > >
> > > > > I'm not getting what you mean by "firmware should know better"?
> > > > > So,
> > > > > basically, and let's take OF as example, you can request a GPIO
> > > > > in
> > > > > OF
> > > > > by doing something like:
> > > > >
> > > > >         foo-gpios =3D <&gpio 1 GPIO_PULL_UP>;
> > > > >
> > > > > In this way, when the consumer driver gets the gpio, all the
> > > > > flags
> > > > > will
> > > > > be properly set so that when we set a direction (for example)
> > > > > the
> > > > > gpiochip's 'set_config()' will be called and the driver does
> > > > > what
> > > > > it
> > > > > needs to setup the pull-up. If we want BIAS_DISABLED on the
> > > > > pin,
> > > > > there's no way to the same as the above. So basically, this can
> > > > > ever
> > > > > happen:
> > > > >
> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiol=
ib.c#L2227
> > > > >
> > > > > (only possible from the gpiochip cdev interface)
> > > > >
> > > > > So, what I'm proposing is to be possible to do from OF:
> > > > >
> > > > >         foo-gpios =3D <&gpio 1 GPIO_PULL_DISABLE>;
> > > > >
> > > > > And then we will get into the gpiochip's 'set_config()' to
> > > > > disable
> > > > > the
> > > > > pull-up or pull-down.
> > > > >
> > > > > As I said, my device is an input keymap that can export pins as
> > > > > GPIOs
> > > > > (to be consumed by gpio_keys). The pins by default have pull-
> > > > > ups
> > > > > that
> > > > > can be disabled by doing a device i2c write. I'm just trying to
> > > > > use
> > > > > the
> > > > > infrastructure that already exists in gpiolib (for pull-
> > > > > up|down) to
> > > > > accomplish this. There's no pinctrl driver controlling the
> > > > > pins.
> > > > > The
> > > > > device itself controls them and having this device as a pinctrl
> > > > > one
> > > > > is
> > > > > not really applicable.
> > > >
> > > > Yes, I have got it eventually. The root cause is that after reset
> > > > you
> > > > have a
> > > > hardware that doesn't disable bias.
> > > >
> > > > Now, we have DT properties for PD and PU, correct?
> > > > For each requested pin you decide either to leave the state as it
> > > > is,
> > > > or
> > > > apply bias.
> > > >
> > > > in ->probe() of your GPIO you reset hardware and for each GPIO
> > > > descriptor you
> > > > set PU flag.
> > > > In ->request(), don;t know the name by heart, you disable BIAS
> > > > based
> > > > on absence
> > > > of flags, it can be done without an additional properties, purely
> > > > in
> > > > the GPIO
> > > > OF code. Do I understand this correctly?
> > > >
> > >
> > > Alright, I think now you got it and we are on the same page. If I
> > > understood your suggestion, users would just use GPIO_PULL_UP in
> > > dtb if
> > > wanting the default behavior. I would then use the gpiochip
> > > 'request()'
> > > callback to test the for pull-up flag right?
> >
> > Something like this, yes.
> >
> > > If I'm getting this right, there's a problem with it...
> > > gpiod_configure_flags() is called after gpiod_request() which means
> > > that the gpiod descriptor won't still have the BIAS flags set. And
> > > I
> > > don't think there's a way (at least clean and easy) to get the
> > > firmware
> > > lookup flags from the request callback?
> > >
> > > So, honestly the only option I see to do it without changing
> > > gpioblib
> > > would be to hook this change in output/input callbacks which is far
> > > from being optimal...
> > >
> > > So, in the end having this explicitly like this feels the best
> > > option
> > > to me. Sure, I can find some workaround in my driver but that does
> > > not
> > > change this...
> >
> > Ok, let me think about it. Meanwhile, maybe others have better ideas
> > already?
> >
>
> Sure, I'm still thinking that having this extra property and explicitly
> set it from OF is not that bad :)
>
> > > "
> > > git grep "PIN_CONFIG_BIAS_DISABLE" drivers/gpio/
> >
> > Hint: `git grep -lw "PIN_CONFIG_BIAS_DISABLE" -- drivers/gpio`
> >
>
> nice..
>
> > > drivers/gpio/gpio-aspeed.c:963: else if (param =3D=3D
> > > PIN_CONFIG_BIAS_DISABLE ||
> > > drivers/gpio/gpio-merrifield.c:197:     if
> > > ((pinconf_to_config_param(config) =3D=3D PIN_CONFIG_BIAS_DISABLE) ||
> > > drivers/gpio/gpio-omap.c:903:   case PIN_CONFIG_BIAS_DISABLE:
> > > drivers/gpio/gpio-pca953x.c:573:        if (config =3D=3D
> > > PIN_CONFIG_BIAS_DISABLE)
> > > drivers/gpio/gpio-pca953x.c:592:        case
> > > PIN_CONFIG_BIAS_DISABLE:
> > > "
> > >
> > > AFAICT, the only way this path is possible for these drivers is
> > > through
> > > gpiolib cdev which might not be what the authors of the drivers
> > > were
> > > expecting...
> >
> > gpio-merrifield is bad example, it has a pin control.
> > gpio-pca953x as I said should effectively be a pin control driver.
> >
> > For the two left it might be the case.
> >
>
> Well the thing is that even if we have pinctrl like for example,
> gpio-omap, it is still true that there's no way to get into
> 'omap_gpio_set_config()' for 'PIN_CONFIG_BIAS_DISABLE' and call
> 'gpiochip_generic_config()'.
>
> (naturally in this case, one can directly use pinctrl properties to
> control the pin but still...)
>
>
> - Nuno S=C3=A1
>

Ideologically I don't have anything against adding this flag (except
that it should be called BIAS_DISABLE not PULL_DISABLE IMO). Nuno is
right in that the character device is the only way to set this mode
ATM and. However I would like to see the first user added together
with the series because adding features nobody uses in the mainline
kernel tree is generally frowned upon and it's also not clear that
anyone actually wants to use it.

Bart
