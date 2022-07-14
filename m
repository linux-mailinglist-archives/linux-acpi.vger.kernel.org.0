Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB65574784
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 10:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiGNIqe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 04:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiGNIq3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 04:46:29 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04CE402E3;
        Thu, 14 Jul 2022 01:46:27 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id p14so952016qvo.9;
        Thu, 14 Jul 2022 01:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=AQM3d9GGe4QO9GR8naQccVzLum+tvH/H4+/A6J4Tk+I=;
        b=dDmm7RsMmk0U5XAbGa5oDaEIdi9M5FS1mgrJph3NwF5OEnwvoZaINbCady4nlOoPMO
         Dwh7PWjG47bDUArevKjgvuEj1RBiFKAVKlJsDfkBnQ0yDDF2TSenlpqdfIKC6exHiVoV
         ilE2DTO9rnvuReZx+pzcOArX4/RYB3/dpGE+eNfetdUT+k43q03bd0DaeN3BSf4u60un
         SFJz7kNcLuDRdxl7BcSZ7/XvawEtc1HitH4nxqgjm0h85UDbOzsDmcK47Cj7FBnkobgq
         rkDasp8RVdGOyt9Xd13erGL4D1R5kyGl/Hcb7UNhcuj+KEnaqMnDShlTgU9Fqx5yL8k3
         s4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=AQM3d9GGe4QO9GR8naQccVzLum+tvH/H4+/A6J4Tk+I=;
        b=RVhIFsNMjTnOV8i/eQpIzimJjtCTjKaXQZqoCldU/mRwSDfpAtZrIpPVRClchUPqaA
         dWr8XQw3cJO56B3K7Q9H3PZPlpgFLFuQnNo/alj3DF7B2BcRdPj75OMfCRnnVgc37nY9
         slhXJujWfS20mXem6fQDz7VIKcQpxzuiTUcN4Oh6+hSLX2jbxp5XNFFuDHqoBSV6QgZy
         XxwmcIxCzo0/C6HllgNIVItn8MY//uT3Gin1X8kfdZI3GdY4aRctdsTcD6RNQFOiQmJy
         Xle0Ul0xZTEiI4qy0PlxbaS/DgSlx6efLWcvGpa8zSmO3C+3+1lQUb+hNwAexSlMIl5S
         2BYQ==
X-Gm-Message-State: AJIora9/Tw9ojDn9gU+ZrE5Ez+nkVRKGoyuasQtcP8qTzA6kJ8Llr7LW
        ybYC3bC/QVxBO5CmAif2dhQPSYDCEzghA41j
X-Google-Smtp-Source: AGRyM1vB+Yyk8KgmN6HpnITzNyFe7dEXkEg0UsQzD832fkIjzljFzGNTgtuUT7xQ+827AytCJuJZtw==
X-Received: by 2002:a05:6214:ccb:b0:472:f2a2:dd73 with SMTP id 11-20020a0562140ccb00b00472f2a2dd73mr7015993qvx.0.1657788386956;
        Thu, 14 Jul 2022 01:46:26 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id br44-20020a05620a462c00b006b593410fd8sm847892qkb.87.2022.07.14.01.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 01:46:26 -0700 (PDT)
Message-ID: <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jul 2022 10:47:27 +0200
In-Reply-To: <20220714082710.GA103849@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <20220713131421.1527179-2-nuno.sa@analog.com>
         <Ys8CpqYhWp7zVNC8@smile.fi.intel.com> <20220714042050.GA76737@sol>
         <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
         <20220714082710.GA103849@sol>
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

On Thu, 2022-07-14 at 16:27 +0800, Kent Gibson wrote:
> On Thu, Jul 14, 2022 at 09:14:21AM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2022-07-14 at 12:20 +0800, Kent Gibson wrote:
> > > On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno S=C3=A1 wrote:
> > > > > This change prepares the gpio core to look at firmware flags
> > > > > and
> > > > > set
> > > > > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > > > > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> > > >=20
> > > > ...
> > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_UP=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 4),
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DOWN=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 5),
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DISABLE=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D (1 << 6),
> > > >=20
> > > > To me it seems superfluous. You have already two flags:
> > > > PUp
> > > > PDown
> > > > When none is set --> Pdisable
> > > >=20
> > >=20
> > > Agree with Andy on this.=C2=A0 The FLAG_BIAS_DISABLE was added, by me=
,
> > > to
> > > allow the cdev interface to support bias.=C2=A0 cdev requires a "don'=
t
> > > care"
> > > state, distinct from an explicit BIAS_DISABLE.
> > > The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that to
> > > gpiolib, without altering the interpretation of the existing
> > > PULL_UP
> > > and
> > > PULL_DOWN flags.
> > > That is not an issue on the machine interface, where the two
> > > GPIO_PULL
> > > flags suffice.
> > >=20
> >=20
> > I see, but this means we can only disable the pin BIAS through
> > userspace. I might be wrong but I don't see a reason why it
> > wouldn't be
> > valid to do it from an in kernel path as we do for PULL-UPS and
> > PULL-
> > DOWNS=20
> >=20
>=20
> > > If you are looking for the place where FLAG_BIAS_DISABLE is set
> > > it is
> > > in
> > > gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.
> > >=20
> > > Referring to gpio_set_bias(), the only place in gpiolib the
> > > FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP,
> > > FLAG_PULL_DOWN,
> > > nor FLAG_BIAS_DISABLE are set then the bias configuration remains
> > > unchanged (the don't care case) - no change is passed to the
> > > driver.
> > > Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to the
> > > driver.
> > >=20
> >=20
> > Exactly, but note FLAG_BIAS_DISABLE can only be set from userspace
> > at
> > this point (IIUTC). If everyone agrees that should be case, so be
> > it.
> > But as I said, I just don't see why it's wrong to do it within the
> > kernel.
> >=20
>=20
> Believe it or not gpiolib-cdev is part of the kernel, not userspace -
> it
> just provides an interface to userspace.
>=20

Yes, I do know that. But don't you still need a userspace process to
open the cdev and do the ioctl()?

> Bias can be disabled by calling gpiod_direction_input() or
> gpiod_direction_output() after setting the FLAG_BIAS_DISABLE, as
> gpiolib-cdev does.
>=20
> Does that work for you?
>=20

I'm not seeing how would this work... We would need to make gpiod
consumers having to do this. Something like:


desc =3D giod_get();
set_bit(FLAG_BIAS_DISABLE, &desc->flags);
set_direction...


Having in mind that we can already specify the direction in gpiod_get,
I don't really think this is something that consumers should have to
worry. Moreover, I would say this means special devicetree properties
for all the consumers of such a gpiochip which want to disable bias...

...

Or do you have something else in mind?

- Nuno S=C3=A1
