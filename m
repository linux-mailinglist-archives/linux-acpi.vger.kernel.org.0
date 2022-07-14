Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10282574990
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Jul 2022 11:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237837AbiGNJuK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 14 Jul 2022 05:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237849AbiGNJtj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Jul 2022 05:49:39 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE1738E;
        Thu, 14 Jul 2022 02:48:34 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id r12so1054775qvm.3;
        Thu, 14 Jul 2022 02:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=R075R0kDVbePZmaFfl37Agcye6RwOXPcO6sxjSaWjMY=;
        b=iWBaJCPBbOJWl0KsDrDMbesQWUns2aHPJr1Hg9un2Xdp9beGINWgYHRCsmovKRG6b8
         VtAdjw78gRFwJF/5ckXtZ/OoFY9xVKorj9HNfwssg0FySgYrvkRaQGpzSyy6YI9KrOk1
         TXMFpsBP+OQ/D1vqRhTif9lRQGX4oSaiPLmW851MoZ05crtMQNvO4iMLet/p6xQlAx5I
         WDv/FTYKauTZHmlRYPkakksJbO+92i0Ca77rsnHGNDKGuKlpI8ZUzoOHw3TA2PHG60kO
         XCc3Z45huVUJHBvZ+SP9+h9BK863YuLUAkRxhiDZRA6KfUGtNMYB3DsYh9qWoefrjG8s
         qZ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=R075R0kDVbePZmaFfl37Agcye6RwOXPcO6sxjSaWjMY=;
        b=XvIaIog/6n4hBfRTItJMeF31d1g9lxplB38kXEwlRqWcQkbGtMgQwlL2kKq79X+vwz
         UAOrwxJB4AGgtFoaZgR2msjFj2lvlocyPfVsaO3Rs4SK54YcGAfAT25bVixwZwKzmqp4
         552ZfepXHTqOO8mcsibwPfYPmBpfVZl5NWjGolgxYzPB+2QFhCSBYLSZR9UqJN5J5K5t
         uiP23oN686jlSVXKIlX9CU89wFGBvVeffebWS08adXhLp5gPXHPEiWd2nqgxjJtfJT3/
         ljxpGbL1xUuny2hYhM+4cQ3Hws/mYL0AaitzBUK7knpDhdavY1+TuA59dy9V3l2i18lJ
         cNUg==
X-Gm-Message-State: AJIora8xO3Zbfae1tJqT9bYZ+sVDJFuJdO7rhm8fGdC+g8Ee6q7yzJcr
        84ZORE72kbYGjQEvEZQYXwzQfH3na2PAG5eq
X-Google-Smtp-Source: AGRyM1sqZfxNK09gmODT6UaDYNNehQMd//5RpmjYM+w0fxd0rh9X+HZZP3aVn5RPf2fx2MbM1ywb4Q==
X-Received: by 2002:a05:6214:23cb:b0:472:f1a5:5cea with SMTP id hr11-20020a05621423cb00b00472f1a55ceamr6624843qvb.13.1657792114009;
        Thu, 14 Jul 2022 02:48:34 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id c8-20020ac86608000000b0031eb6b42b26sm1028925qtp.73.2022.07.14.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:48:33 -0700 (PDT)
Message-ID: <fb3112dab2e614cba3feaf0b6a962186f07cb61b.camel@gmail.com>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Jul 2022 11:49:34 +0200
In-Reply-To: <CAHp75VcEBE3kMDi5Q+89GmS9V=aF+pOcyROY9MdfyB_5OaruPg@mail.gmail.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
         <Ys8DPCzRa1qo2AKJ@smile.fi.intel.com>
         <62ccf0c91d32df557a2bc91c45adb45593302534.camel@gmail.com>
         <CAHp75VcEBE3kMDi5Q+89GmS9V=aF+pOcyROY9MdfyB_5OaruPg@mail.gmail.com>
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

On Thu, 2022-07-14 at 11:12 +0200, Andy Shevchenko wrote:
> On Thu, Jul 14, 2022 at 9:10 AM Nuno S=C3=A1 <noname.nuno@gmail.com>
> wrote:
> > On Wed, 2022-07-13 at 20:39 +0300, Andy Shevchenko wrote:
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
> > >=20
> > > Isn't it enough?
> >=20
> > I might be missing something but don't think so. Look at this
> > driver
> > which seems a lot like the reference i put in the cover:
> >=20
> > https://elixir.bootlin.com/linux/v5.19-rc6/source/drivers/gpio/gpio-pca=
953x.c#L573
> >=20
> > I just don't see an in-kernel path (I'm aware now that we can get
> > here
> > through gpio cdev) to get to the point where we want to disable the
> > pin
> > BIAS.
>=20
> Ah, that driver should be converted to pin control. It's definitely a
> problem with the driver.
>=20

I'm not too familiar with pinctrl or even gpiochips to argue much in
here so just looking to better understand it...

The driver has it's own way to control the pin BIAS and does not rely
on any other pinctrl chip on the system. Are you pointing that this
driver should be converted in a pinctrl one which registers the
gpiochip and drops the 'set_config()' callback so pin consumers could
use pinctrl to let's say, disable BIAS? If so, then why do we have
PIN_CONFIG_BIAS_PULL_UP|DOWN in 'set_config()'? Legacy?=20

And for my test device which is an input keymap, having it converted
into a pinctrl driver does not make much sense  (and it also supports
pull-up pull-disable) and I guess that might make sense for other
devices that have some optional gpiochip support...

- Nuno S=C3=A1

