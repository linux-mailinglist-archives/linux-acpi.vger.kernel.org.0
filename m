Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7EF57458F
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 09:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiGNHNX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 03:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiGNHNW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 03:13:22 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CC3137E;
        Thu, 14 Jul 2022 00:13:21 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id cf13so756963qtb.13;
        Thu, 14 Jul 2022 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=3x5Z7sURPAiBBvhPNtgfhlp1hUKAN6RFhStnhJpbX54=;
        b=HKc4BqUfLrvgL7aqg30gqWbuhQCm4W8Xg59ytlVJc1RTXy3Q0B8f10eAC0nIGNXd7n
         GPIS8kyX72num3BvwrJYEsyJRsHtjT2Y2Kqkto5plh79a/0ssEQjuTq/gDGIyqLUTe3V
         uh6GHxx+2YIpUS9ouWst/xzk80Y8bKTUNjK0H+YWx2b+r0kiVtSFfuPwl4KPtUqa1jFr
         D46Q+i3chkIIhf/114xlrJlMCm01PiAguSn87T4yASMUMKQiSvFgyFobA2K77CWxPgeK
         LK7kMeTL/GonRe4mrfnhozUWoxzQjj9E8SWHd0487d9s88RlZ3szDvqy5rSJ/yv6v+j6
         juyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=3x5Z7sURPAiBBvhPNtgfhlp1hUKAN6RFhStnhJpbX54=;
        b=Lhbw+eKYYo/m1V8EnKuG681wyh8JgNk15QQNEhze7s47OCjdpNO9mPa5y0JoMKStkf
         01mH18ec+kyXJfgQ2lMH+DCscyKroPuAvgLAAhsDyNHh36I6lRGd9X+EQG2r/OdZAd1k
         iBEXWvuR1JRKcLlraZeMcN/Zbu3Oxzttt8gFYQOAmfqBElxwG5KqJ3+DHT9krMCOeOuW
         H/4Rk6CzQCYoTdm1bLm4C5eKPaJNhh0G/LcG+AI0JfZ2jmPqzx2vPWOqY0JF3MXYkRqE
         ICqvlkjXweq7P09zYA0scBUSV6EmEwKvQofRvGnfpIchhgV1B90iPCf6hMwpOOp6L1tw
         U8rw==
X-Gm-Message-State: AJIora81PsmYuxv/7H4z7mTmLmgMxBU36001E1JkymM8RUVr/zWq9BbL
        tvJ2C27YXxfeK9wdOaZBbYpuNm3+CvUbHTvL
X-Google-Smtp-Source: AGRyM1uc+CAK4DPBng3jHeXSpSnPAY8kVQG56zP4+6Qr+UlfQ7TIJDjGRQYEMutExjRKyRTozCqF6A==
X-Received: by 2002:a05:622a:1194:b0:31e:d3e5:3b3d with SMTP id m20-20020a05622a119400b0031ed3e53b3dmr100359qtk.398.1657782801066;
        Thu, 14 Jul 2022 00:13:21 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id x66-20020a376345000000b006a6d7c3a82esm744335qkb.15.2022.07.14.00.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:13:20 -0700 (PDT)
Message-ID: <4bf06ba5994f559499c45275cd7f44bfee1bbde1.camel@gmail.com>
Subject: Re: [PATCH 1/4] gpiolib: add support for bias pull disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Kent Gibson <warthog618@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jul 2022 09:14:21 +0200
In-Reply-To: <20220714042050.GA76737@sol>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <20220713131421.1527179-2-nuno.sa@analog.com>
         <Ys8CpqYhWp7zVNC8@smile.fi.intel.com> <20220714042050.GA76737@sol>
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

On Thu, 2022-07-14 at 12:20 +0800, Kent Gibson wrote:
> On Wed, Jul 13, 2022 at 08:36:38PM +0300, Andy Shevchenko wrote:
> > On Wed, Jul 13, 2022 at 03:14:18PM +0200, Nuno S=C3=A1 wrote:
> > > This change prepares the gpio core to look at firmware flags and
> > > set
> > > 'FLAG_BIAS_DISABLE' if necessary. It works in similar way to
> > > 'GPIO_PULL_DOWN' and 'GPIO_PULL_UP'.
> >=20
> > ...
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_UP=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 4),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DOWN=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D (1 << 5),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0GPIO_PULL_DISABLE=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=3D (1 << 6),
> >=20
> > To me it seems superfluous. You have already two flags:
> > PUp
> > PDown
> > When none is set --> Pdisable
> >=20
>=20
> Agree with Andy on this.=C2=A0 The FLAG_BIAS_DISABLE was added, by me, to
> allow the cdev interface to support bias.=C2=A0 cdev requires a "don't
> care"
> state, distinct from an explicit BIAS_DISABLE.
> The FLAG_BIAS_DISABLE allows gpiolib-cdev to communicate that to
> gpiolib, without altering the interpretation of the existing PULL_UP
> and
> PULL_DOWN flags.
> That is not an issue on the machine interface, where the two
> GPIO_PULL
> flags suffice.
>=20

I see, but this means we can only disable the pin BIAS through
userspace. I might be wrong but I don't see a reason why it wouldn't be
valid to do it from an in kernel path as we do for PULL-UPS and PULL-
DOWNS=20

> If you are looking for the place where FLAG_BIAS_DISABLE is set it is
> in
> gpio_v2_line_config_flags_to_desc_flags() in gpiolib-cdev.c.
>=20
> Referring to gpio_set_bias(), the only place in gpiolib the
> FLAG_BIAS_DISABLE is used, if neither FLAG_PULL_UP, FLAG_PULL_DOWN,
> nor FLAG_BIAS_DISABLE are set then the bias configuration remains
> unchanged (the don't care case) - no change is passed to the driver.
> Otherwise the corresponding PIN_CONFIG_BIAS flag is passed to the
> driver.
>=20

Exactly, but note FLAG_BIAS_DISABLE can only be set from userspace at
this point (IIUTC). If everyone agrees that should be case, so be it.
But as I said, I just don't see why it's wrong to do it within the
kernel.

> If there are cases of drivers not fully or correctly supporting those
> PIN_CONFIG_BIAS flags, then that is an issue with those drivers.
>=20

Look at my reply to Andy in the cover for more details

- Nuno S=C3=A1
