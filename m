Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B813C57457F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 09:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiGNHIv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 03:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiGNHIo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 03:08:44 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4DD6565;
        Thu, 14 Jul 2022 00:08:41 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mi10so852554qvb.1;
        Thu, 14 Jul 2022 00:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=h/n6yRbBlHUfm041rTAam4vX/bLCIOQ4TLdRwuztXQg=;
        b=C8kV4VFBw7fJd0KgbO1DYsWALtwNT8CsTBzpmGFtbWN+91+TY/g6o9LSUYmlnLl4Dn
         YnFqhYfeGKCSoo+eL6/kHbwK/pbCjRwVdETmeAJsHU0lKG+pyISdPKr/M7naODnwGz3c
         MgSTBb2nz0SNZI+Jwt1n0T6OmAa1nh/XljGVTlOTCQlI+pDdURwfhJ/r0JH/sUHZHpyF
         5wg324vi396sK4dy8horSxpXkkERfjx+APOrOqhrE0H5kaKwRhal29S25lhsWIhjsJak
         /m/VYIFA5uadKp8bnFD9wvGjkEnCJIzGD0oxOnCnpzULShl00ENbfCIS4w9DIzxz4OQA
         BKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=h/n6yRbBlHUfm041rTAam4vX/bLCIOQ4TLdRwuztXQg=;
        b=uiAWV4IfTp5YdOdxNBkBet1fNtoqeNurkXt1isKOMDN1vEr8sedYrcPL3TAQU+Oqdh
         N9R9eWsMfp6EMpip9jXI5UC1OiP39dpCO2Qv6UXI3G9hL3v4KFJpAA1WcUAaMf/fZOeq
         QcOjsZQam0iAeD7GColnd5LiggTXgcVk2G0UpbdcxmPpaURSdxohGRuDlHrpVQuVbpx9
         AhwPM4pJsBW1SZUloWp242ntpMHjVfbgBYXvFPuG5vmqybqPuXLZHGCIt6K5TVESEwSz
         pd/ehBgIQYvx32o0b4ueoaM7o6f2ra9La0ffoUpGeTWG19RzFC4gv4ChRhDevt5F3IxD
         xWBA==
X-Gm-Message-State: AJIora9DVIRlNl6BBTy2YMVvpZ93XoZcJikufe2W1mQByibU0DBZSiFI
        KmSzq1ca/h2lDpeDisrEl6c=
X-Google-Smtp-Source: AGRyM1tn1OC1q6j/kWhFPuKSBUrFYSuQPYLM8IV0m5aPu98EjIYTj90fCMiBKVssI8sFkV0LlE6iSw==
X-Received: by 2002:a05:6214:2302:b0:470:2d10:b6e4 with SMTP id gc2-20020a056214230200b004702d10b6e4mr6713306qvb.72.1657782520109;
        Thu, 14 Jul 2022 00:08:40 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0031eb393aa45sm819392qtb.40.2022.07.14.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:08:39 -0700 (PDT)
Message-ID: <62ccf0c91d32df557a2bc91c45adb45593302534.camel@gmail.com>
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
Date:   Thu, 14 Jul 2022 09:09:40 +0200
In-Reply-To: <Ys8DPCzRa1qo2AKJ@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <Ys8DPCzRa1qo2AKJ@smile.fi.intel.com>
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

On Wed, 2022-07-13 at 20:39 +0300, Andy Shevchenko wrote:
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
>=20
> Isn't it enough?
>=20

I might be missing something but don't think so. Look at this driver
which seems a lot like the reference i put in the cover:

https://elixir.bootlin.com/linux/v5.19-rc6/source/drivers/gpio/gpio-pca953x=
.c#L573

I just don't see an in-kernel path (I'm aware now that we can get here
through gpio cdev) to get to the point where we want to disable the pin
BIAS.

> > On top of this, there are some users that are looking at
> > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So, unless
> > I'm
> > missing something, it looks like this was never working for these
> > chips.
>=20
> It seems you are looking into wrong source of issues. Isn't it a
> issue of
> particular pin control driver?
>=20
>=20
>=20

Think about gpio expanders on, eg, an i2c bus which don't really have
any pinmuxing capability [1]. For example, my device is an i2c keyboard
which has the capability of exposing pins as gpios (to be consumed by
gpio_keys). The pins, by default are PULL-UPs but we can disable them
doing an i2c write on the device. So to me, the way to do it is via the
gpiochip 'set_config()' hook but as things are, there's no way to get
into the callback with 'PIN_CONFIG_BIAS_DISABLE'. And the driver cannot
just assume that the default case is to disable bias...

Now taking your words (on patch 1 comments)

"
To me it seems superfluous. You have already two flags:
PUp
PDown
When none is set --> Pdisable
"

I guess we could do that assumption in 'gpiod_configure_flags()' and
extend the following code:


if (lflags & GPIO_PULL_UP)
	set_bit(FLAG_PULL_UP, &desc->flags);
else if (lflags & GPIO_PULL_DOWN)
	set_bit(FLAG_PULL_DOWN, &desc->flags);

with an else clause where we do 'set_bit(FLAG_BIAS_DISABLE, &desc-
>flags)' by default. As gpiolib does not consider '-ENOTSUPP' as an
error, this would not "explicitly" break existing drivers.

But I do have some concerns with making such an assumption. This
*might* change behavior on existing systems. Think on a system using
for example gpio-pca953x I linked before. If the default state of the
pins is PULL-UP (or down), it's legit to think that, for example,
devicetrees of such a system are not explicitly setting 'GPIO_PULL_UP'.
That's it, this change would break it because now the pins will have
BIAS disabled by default...

Note the above is just me speculating but might be a valid concern.
=20
1: https://github.com/torvalds/linux/commit/ede033e1e863c


- Nuno S=C3=A1
