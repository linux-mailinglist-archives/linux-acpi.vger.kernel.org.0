Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A38574E85
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 15:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239680AbiGNNBJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238944AbiGNNBI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 09:01:08 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73015A47E;
        Thu, 14 Jul 2022 06:01:07 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r17so1313236qtx.6;
        Thu, 14 Jul 2022 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=mXtDzCxWNh7iEWHXLQDffRojHgGRBz6RPgAsQyqCl5A=;
        b=LXKR9rf/BxD3MfMsa59J/cSxxMpFBaVbFbsX4PGg/sciGPDHy+/1NYLD898c0ueghM
         yPX5NsnbFXtdAuKwS655f+uYdTdmb++ibKP7X1Njdp5Wj5kVNYxcX7I0v9j0rpGw3r45
         fMBSzvyo6mlK+6ZEweHo06a0Z9A8ElZ0li29JejjWQTynbq4NPbMltImpWrdR3P/YMm8
         9qfFTV3I+iJWYHGuNFAPFqGXKU02TryN2fKMkOxXq4nmEChm73uNRWvLapNx/ivPHiX4
         V1UYtZxMoba6Tc21/Hd3Tt5ZIlC2hi6b7RcKEZ37aRnDnWxA7DbK0FdIayQj6RFupQrU
         pimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=mXtDzCxWNh7iEWHXLQDffRojHgGRBz6RPgAsQyqCl5A=;
        b=w7gcc6Om5r6qJDkOcdL+a1f2RkrxNPIJgyC96YFtDlOA31tkg1lyqBmkqc0dV2Gi/9
         SMFoJivTDozRJoO3SVGUv45sCSAokMjB2e72u6Qzqjkh+1QUIf72BlTZRYhqEh+r9EBQ
         TXN9wJx5bEfqn7sd5CoUROenWYZi3O+TslH5u5J5XkzbTJJkQlqKAcdrbtFAmXzH+pHU
         htJ8XFNutl9LCStngkQcSt+wM5tF+9NN87boxMLtfxZRT9lPldH3DBZFf34zhuoqD2/M
         nw/y+IBVwXwagagLA5I/fn/BdNl9WZ3wBl6bQNf/7faT8Tdlst+Np3GrR9TZ6XA8JTGN
         Efuw==
X-Gm-Message-State: AJIora/LI59WWGmmgnG6Gt/qbPsZSMG6+c8+f72TWi3OlBOwaEvo4nwQ
        wYGBlsiwD/2sEoCrx7q26pb6Ub+vn2pWQKVK
X-Google-Smtp-Source: AGRyM1vxzWfrkORBRDBbxvxHbIK7yhQR9CED7F/H3bHvp4PToRRN6pw3UKJjmx2eq5EIeQgpjBEWsA==
X-Received: by 2002:ac8:7e8c:0:b0:31e:b643:c0d2 with SMTP id w12-20020ac87e8c000000b0031eb643c0d2mr7889689qtj.228.1657803666789;
        Thu, 14 Jul 2022 06:01:06 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id k11-20020a05620a0b8b00b006a6b374d8bbsm1294615qkh.69.2022.07.14.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:01:06 -0700 (PDT)
Message-ID: <fc0ce1235dce7303aac7bcc45b856fcca60fcb57.camel@gmail.com>
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
Date:   Thu, 14 Jul 2022 15:02:08 +0200
In-Reply-To: <20220714120005.GA105609@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <20220713131421.1527179-2-nuno.sa@analog.com>
         <Ys8CpqYhWp7zVNC8@smile.fi.intel.com> <20220714042050.GA76737@sol>
         <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
         <20220714082710.GA103849@sol>
         <35e8020f513a77b8a8eb12a45d48a2b1390cce7c.camel@gmail.com>
         <20220714120005.GA105609@sol>
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

On Thu, 2022-07-14 at 20:00 +0800, Kent Gibson wrote:
> On Thu, Jul 14, 2022 at 10:47:27AM +0200, Nuno S=C3=A1 wrote:
> > On Thu, 2022-07-14 at 16:27 +0800, Kent Gibson wrote:
> > > On Thu, Jul 14, 2022 at 09:14:21AM +0200, Nuno S=C3=A1 wrote:
> > > > On Thu, 2022-07-14 at 12:20 +0800, Kent Gibson wrote:
> > > > > On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko
> > > > > wrote:
> > > > > > On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno S=C3=A1 wrote:
> > > > > > > This change prepares the gpio core to look at firmware
> > > > > > > flags
> > > > > > > and
> > > > > > > set
> > > > > > > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way
> > > > > > > to
> > > > > > > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> > > > > >=20
> > > > > > ...
> > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_UP=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 4),
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DOW=
N=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 5),
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DISABLE=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D (1 << 6),
> > > > > >=20
> > > > > > To me it seems superfluous. You have already two flags:
> > > > > > PUp
> > > > > > PDown
> > > > > > When none is set --> Pdisable
> > > > > >=20
> > > > >=20
> > > > > Agree with Andy on this.=C2=A0 The FLAG_BIAS_DISABLE was added, b=
y
> > > > > me,
> > > > > to
> > > > > allow the cdev interface to support bias.=C2=A0 cdev requires a
> > > > > "don't
> > > > > care"
> > > > > state, distinct from an explicit BIAS_DISABLE.
> > > > > The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that
> > > > > to
> > > > > gpiolib, without altering the interpretation of the existing
> > > > > PULL_UP
> > > > > and
> > > > > PULL_DOWN flags.
> > > > > That is not an issue on the machine interface, where the two
> > > > > GPIO_PULL
> > > > > flags suffice.
> > > > >=20
> > > >=20
> > > > I see, but this means we can only disable the pin BIAS through
> > > > userspace. I might be wrong but I don't see a reason why it
> > > > wouldn't be
> > > > valid to do it from an in kernel path as we do for PULL-UPS and
> > > > PULL-
> > > > DOWNS=20
> > > >=20
> > >=20
> > > > > If you are looking for the place where FLAG_BIAS_DISABLE is
> > > > > set
> > > > > it is
> > > > > in
> > > > > gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.
> > > > >=20
> > > > > Referring to gpio_set_bias(), the only place in gpiolib the
> > > > > FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP,
> > > > > FLAG_PULL_DOWN,
> > > > > nor FLAG_BIAS_DISABLE are set then the bias configuration
> > > > > remains
> > > > > unchanged (the don't care case) - no change is passed to the
> > > > > driver.
> > > > > Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to
> > > > > the
> > > > > driver.
> > > > >=20
> > > >=20
> > > > Exactly, but note FLAG_BIAS_DISABLE can only be set from
> > > > userspace
> > > > at
> > > > this point (IIUTC). If everyone agrees that should be case, so
> > > > be
> > > > it.
> > > > But as I said, I just don't see why it's wrong to do it within
> > > > the
> > > > kernel.
> > > >=20
> > >=20
> > > Believe it or not gpiolib-cdev is part of the kernel, not
> > > userspace -
> > > it
> > > just provides an interface to userspace.
> > >=20
> >=20
> > Yes, I do know that. But don't you still need a userspace process
> > to
> > open the cdev and do the ioctl()?
> >=20
>=20
> Only if you want to drive the cdev interface, so not in this case.
> You would not use cdev, you would use gpiolib directly.
>=20

That's what I'm trying to do :). Without having to change gpiod
consumers to have to explicitly set this flag.

> > > Bias can be disabled by calling gpiod_direction_input() or
> > > gpiod_direction_output() after setting the FLAG_BIAS_DISABLE, as
> > > gpiolib-cdev does.
> > >=20
> > > Does that work for you?
> > >=20
> >=20
> > I'm not seeing how would this work... We would need to make gpiod
> > consumers having to do this. Something like:
> >=20
> >=20
> > desc =3D giod_get();
> > set_bit(FLAG_BIAS_DISABLE, &desc->flags);
> > set_direction...
> >=20
> >=20
>=20
> In a nutshell.
>=20
> If that solves your immediate problem then you need to decide what
> problem your patch is trying to address.
>=20
>=20

So my patch is trying to solve exactly this case because (IMO), it does
not make sense for consumers drivers to have to do the above code.
Moreover, they would need some custom firmware property (eg:
devicetree) for the cases where we want to disable BIAS since we cannot
just assume we want to do it.

Well, maybe we can just assume FLAG_BIAS_DISABLE in gpiolib (when
trying to get the gpiod) if no PULL is specified. However, I do have
some concerns with it (see my conversation with Andy in the cover).

- Nuno S=C3=A1

