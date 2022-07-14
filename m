Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9694C575218
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 17:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239891AbiGNPmn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240400AbiGNPml (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 11:42:41 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D4458854;
        Thu, 14 Jul 2022 08:42:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk26so3072816wrb.11;
        Thu, 14 Jul 2022 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=bnpFJd8QSKvRuqF+ONbpW7zWmPnlOlJlGzQrCzfEhCE=;
        b=Gmj8/laMak6NboDB9bOPP9zkkw944L5YylsYjwgf7h0YRah88DCIzwWD+P9ohFU50Z
         18lcrG5VTijt+LPb0xatx6nX8DCXK8i4Bbc6gGLvNSQboXuBVvBo5nZ7aS/6CeEoUtye
         8+cTrfxtc0a0a0qV1B6ArswTYcvE9i4JrTnt0eYsA0IzMZeGKKlXRFMmPYzZTqB1tGl+
         09BXC1WP/yvcgdJlkzLMmk9dUH6aB+gHVFJkOtmymWwJ+z+91IdPTd8BOHFdvH5wrpxU
         y0GpWY7dIVMrzWIKIu8RCnUUnlhEObqRQw+m28cPxKanZX7Yekdc12Z6pc67rrs2+Wzu
         T34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=bnpFJd8QSKvRuqF+ONbpW7zWmPnlOlJlGzQrCzfEhCE=;
        b=4E++0tZdJ2Biwz1dtK5LL3LZn4bVr0UfNzai0GqegWr5DVkt1/T0bAIvRIIH5cfolZ
         qazYxpaJpntAUKBQvZUAuvWba+4aIHmRqQObE+ZGHy14j6QjjdGzXvMc3y31ZlsIRKoJ
         cNzK3EsCKMVRR9VzpmF/C3RmjxzNzaj0Ml4TGpP5Bt1deYhoroTp3Cd6raOYLdqWkC+S
         pzCttvwCFVkfBwx5KR/f6+c8PglWdFN976eO7zqTrx/C1QbGbtPqX/vaVuvj8rxTbeEP
         ygR14rwDPTVQx53iVhnqcJEM+4G5qs4hPoZ/9vMy7nrNjwvfYp7NJEogdY1c9e5BcSmT
         9dvA==
X-Gm-Message-State: AJIora+0VMv+pk29gfK5PJQtvGNVE+Xgj2flYHBmR57en4I++3SFEtHe
        0cuuUWj4VK1rWUZk10voJBjt+WACL0xJZ+62
X-Google-Smtp-Source: AGRyM1shgMooIa8sFc+DZizRPdSiGS9W3Z+mKX+KdOxwfYeOryw41dv3ZIps+13q6cVSjgsVDFWaGQ==
X-Received: by 2002:a5d:6d8b:0:b0:21d:a6ac:b34b with SMTP id l11-20020a5d6d8b000000b0021da6acb34bmr8918979wrs.35.1657813358657;
        Thu, 14 Jul 2022 08:42:38 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id h7-20020adffd47000000b0021d650e4df4sm1823325wrs.87.2022.07.14.08.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 08:42:38 -0700 (PDT)
Message-ID: <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jul 2022 17:43:41 +0200
In-Reply-To: <YtAvHMmGay/3HACZ@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <YtAvHMmGay/3HACZ@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 2022-07-14 at 17:58 +0300, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno S=C3=A1 wrote:
> > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of
> > calling the
> > gpiochip 'set_config()' hook. However, AFAICT, there's no way that
> > this
> > flag is set because there's no support for it in firwmare code.
> > Moreover,
> > in 'gpiod_configure_flags()', only pull-ups and pull-downs are
> > being
> > handled.
> >=20
> > On top of this, there are some users that are looking at
> > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless
> > I'm
> > missing something, it looks like this was never working for these
> > chips.
> >=20
> > Note that the ACPI case is only compiled tested. At first glance,
> > it seems
> > the current patch is enough but i'm not really sure...
>=20
> So, I looked closer to the issue you are trying to describe here.
>=20
> As far as I understand we have 4 state of BIAS in the hardware:
> 1/ AS IS (defined by firnware)
> 2/ Disabled (neither PU, not PD)
> 3/ PU
> 4/ PD
>=20
> The case when the default of bias is not disabled (for example
> specific, and I
> think very special, hardware may reset it to PD or PU), it's a
> hardware driver
> responsibility to inform the framework about the real state of the
> lines and
> synchronize it.
>=20
> Another case is when the firmware sets the line in non-disabled state
> and
> by some reason you need to disable it. The question is, why?
>=20

Not getting this point...=20

> > As a side note, this came to my attention during this patchset [1]
> > (and, ofr OF,=C2=A0 was tested with it).
> >=20
> > [1]:
> > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@anal=
og.com/
>=20
> Since this provides a GPIO chip, correct?, it's responsibility of the
> driver to
> synchronize it, no? Basically if you really don't trust firmware, you
> may

What do you mean by synchronize?

> go via all GPIO lines and switch them to the known (in software)
> state. This
> approach on the other hand is error prone, because firmware should
> know better
> which pin is used for which purpose, no? If you don't trust firwmare
> (in some
> cases), then it's a matter of buggy platform that has to be quirked
> out.
>=20

I'm not getting what you mean by "firmware should know better"? So,
basically, and let's take OF as example, you can request a GPIO in OF
by doing something like:

	foo-gpios =3D <&gpio 1 GPIO_PULL_UP>;

In this way, when the consumer driver gets the gpio, all the flags will
be properly set so that when we set a direction (for example) the
gpiochip's 'set_config()' will be called and the driver does what it
needs to setup the pull-up. If we want BIAS_DISABLED on the pin,
there's no way to the same as the above. So basically, this can ever
happen:

https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2227

(only possible from the gpiochip cdev interface)

So, what I'm proposing is to be possible to do from OF:

	foo-gpios =3D <&gpio 1 GPIO_PULL_DISABLE>;

And then we will get into the gpiochip's 'set_config()' to disable the
pull-up or pull-down.

As I said, my device is an input keymap that can export pins as GPIOs
(to be consumed by gpio_keys). The pins by default have pull-ups that
can be disabled by doing a device i2c write. I'm just trying to use the
infrastructure that already exists in gpiolib (for pull-up|down) to
accomplish this. There's no pinctrl driver controlling the pins. The
device itself controls them and having this device as a pinctrl one is
not really applicable.



- Nuno S=C3=A1
