Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA33579591
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Jul 2022 10:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiGSIvL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 Jul 2022 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiGSIvJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2022 04:51:09 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF5260EF;
        Tue, 19 Jul 2022 01:51:08 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id m10so6692492qvu.4;
        Tue, 19 Jul 2022 01:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=E6lM1chF28a0Zk3AHgaEtJ0vFiuldQCbVsy6yH3hEqc=;
        b=UmZrt4bq2Pq1GzNsMdv30nN312q78u9rNLLL46w2mAv3oeKz29rRNkzuFKzea1NthY
         DuyxnvXn2RwZ+RR+bWGOdp2ZZgu6EWkX+jzOhudklQIbP7Tx4Fa8ZZFcfS/DvKcPjVDH
         grK1cYnCkW+xFFfx5/KlSMPz2GLH0KbKilzSSZSTfh1eXI7yyRqvokWn0jqZQqbq10Fl
         K+4QRRkaKJq695sQbSKUecegLs/0pwI8v2gpuOH/XH2pSHGzhtqB+vt0FaQUPIK1XE85
         nQhbbl1cRjjNS+4EeaKyZJeLAUVFhoEXD6EiINZyiZ1NzV0LIFsxm+EhcE7+HF4LjmKb
         NRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=E6lM1chF28a0Zk3AHgaEtJ0vFiuldQCbVsy6yH3hEqc=;
        b=QgxB53yV8W3ZjjfDzN6RtbiquekCeHS+1IN95jQBsXMer5sn0remrdHhPaGdqZWT5D
         CcXg89qjpl/MJCyAKSH8PIry2hq0boVqNvrUfZZpMgzq5fL2CU3TD5j6bjnn5xGNw5mn
         UbKqbS3okWnhaz5CjV3k1zP2gRyw4sdIBaO/SJH4O5QJU+88+SFdJItzwdCCB0LNOKse
         N3KSruObZCcPQPfyV2ft7eAacoJm71kxyqjv4JpT331H00DjmFRdzIDWJa8PY5GOtHMP
         t54/xg5Cg//HUmVjOALV/TmEAUItr+UxjYUlwU5/Ll9NnKMgxYnRAAx3/o36SUs+udsP
         VpUg==
X-Gm-Message-State: AJIora9xzZYaiRJEfq3h19jS7VuSDaNlNB85UKgMiHpL2024/H2UDSzw
        4JBp9y3s/JOKlei/Xr9Jubc=
X-Google-Smtp-Source: AGRyM1u+49dGx2fFB4Gtqc/9zoYMu2f8ZbfFh6pDAAzYJZyrrVb+ekA4umc1NfD/jFy0R7d3Ov4TqQ==
X-Received: by 2002:a05:6214:246f:b0:473:4eba:93fb with SMTP id im15-20020a056214246f00b004734eba93fbmr23273971qvb.15.1658220667907;
        Tue, 19 Jul 2022 01:51:07 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id w18-20020a05620a0e9200b006b5ed1eccc5sm4375957qkm.44.2022.07.19.01.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 01:51:07 -0700 (PDT)
Message-ID: <14af555c630654d0a780dc3bf9ecca6f29dcf61a.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Jul 2022 10:52:09 +0200
In-Reply-To: <CAMRc=Mf1w7DCGMAku0wPHAhTtDWoWkWOfvxkx=_b1pKp8U8yOg@mail.gmail.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <CAMRc=Mf1w7DCGMAku0wPHAhTtDWoWkWOfvxkx=_b1pKp8U8yOg@mail.gmail.com>
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

On Tue, 2022-07-19 at 10:25 +0200, Bartosz Golaszewski wrote:
> On Wed, Jul 13, 2022 at 3:13 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >=20
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
> >=20
> > As a side note, this came to my attention during this patchset [1]
> > (and, ofr OF,=C2=A0 was tested with it).
> >=20
> > [1]:
> > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@anal=
og.com/
> >=20
> > Nuno S=C3=A1 (4):
> > =C2=A0 gpiolib: add support for bias pull disable
> > =C2=A0 gpiolib: of: support bias pull disable
> > =C2=A0 gpiolib: acpi: support bias pull disable
> > =C2=A0 dt-bindings: gpio: add pull-disable flag
> >=20
> > =C2=A0drivers/gpio/gpiolib-acpi.c=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> > =C2=A0drivers/gpio/gpiolib-of.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 7=
 +++++++
> > =C2=A0drivers/gpio/gpiolib.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 8 ++++++--
> > =C2=A0include/dt-bindings/gpio/gpio.h | 3 +++
> > =C2=A0include/linux/gpio/machine.h=C2=A0=C2=A0=C2=A0 | 1 +
> > =C2=A0include/linux/of_gpio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 1 +
> > =C2=A06 files changed, 21 insertions(+), 2 deletions(-)
> >=20
> > --
> > 2.37.0
> >=20
>=20
> Series applied, thanks!

Hi Bart,=20

I was actually planning to spin a v2 with your suggestion for the
naming of the new define... Did you changed it while applying or should
I still send it? Or (last option), we just leave it like this :)?

- Nuno S=C3=A1
