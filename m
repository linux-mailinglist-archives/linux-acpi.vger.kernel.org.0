Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A367976DD
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbjIGQRk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237735AbjIGQRZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:17:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3521FA29
        for <linux-acpi@vger.kernel.org>; Thu,  7 Sep 2023 08:57:16 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-5922b96c5fcso11027357b3.0
        for <linux-acpi@vger.kernel.org>; Thu, 07 Sep 2023 08:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694102160; x=1694706960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BYCw6MjcMH0VBXX64k2n7JI1Ap28j06fLMRRfYT33EM=;
        b=BRqZElGab5b/oiykmUUbqQPSfFhLdPgnkbWhExMQbICigmtqZxOGekOcDTfYhSWAyY
         TllYd5ZnnRLPeJkmw0poVqF3MjbQ8g1A+2zbfHZy4kHgBTRB71CFtzl87tsGXKd5Ds9p
         KqnFjFT4KGwg/OVW/SXGHXou4Vk/h6z1XEXQElsCz7xV5hOojd+5Sevcb+eUe9wtoPsd
         B/KpBK/unllONhlLfXnXQE14OOzadiGacLiDRH1Vy8gBc463i8O20lI0aQLYz28gu9Zf
         hz1AUsWRDUxKAg63jiHNzkOBZGsZ5pkYaALtM5zJdDMiM35zARiyUWQOMgvYw72Y1WgW
         PyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102160; x=1694706960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYCw6MjcMH0VBXX64k2n7JI1Ap28j06fLMRRfYT33EM=;
        b=CAnZQXgR94SL1vi3f4G8e/toKJXwuBq/1ijjmTjebTfG0DVtWcH+9Ksz+G9EhTmjiT
         FuqEjeqKLHYUppVNx/ZE1DIDlGNk+2RLT/VgDCJ2owDcdNAnR6+JMkS331DWilisF/d5
         VoSaGf2Svv+j4R3LKHXnVTYh6wv6wcvc5lxNXPVlQ8jftCgTyRUzQvvhqpbPLPAUV4ZC
         8YCvR3fut8poiJb5iYeZrjDrm3e6fu0l86GcUT/PTdetPM0tPSyVjb8zM0171tWgt6n5
         E5KHpqk3e0OvCSEWrfW2QQ7RPiMjcemW19V3vwrtpr2Dv8Ci15rtpvSFHGgC2zl2WcQs
         Z2MA==
X-Gm-Message-State: AOJu0YxdAE9aZv+tCLJXzlL9x0s7SNYrU0iNa0zVxDyy8GST5EQSX3Zc
        ZZXcXvOjmgaJiKqsryVgaczPv7MeLMxsHjnSt6sLZV1l/hOplvOV
X-Google-Smtp-Source: AGHT+IEKK3pIZHt2QRqcId7nWRc2DLGZhZ7BIVl+nPAXJnwX2Sf45+9R0pQFVmMx9pkduIAsjCSxAhDM52WNmcfhZPQ=
X-Received: by 2002:a67:fa11:0:b0:44d:6290:e422 with SMTP id
 i17-20020a67fa11000000b0044d6290e422mr4850316vsq.35.1694073434785; Thu, 07
 Sep 2023 00:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230905185309.131295-1-brgl@bgdev.pl> <20230905185309.131295-8-brgl@bgdev.pl>
 <CACRpkdbdcPv1LHL2W-enKBJ2OARpduoOJkQ64oL6GSOfmmD3qQ@mail.gmail.com>
In-Reply-To: <CACRpkdbdcPv1LHL2W-enKBJ2OARpduoOJkQ64oL6GSOfmmD3qQ@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 7 Sep 2023 09:57:03 +0200
Message-ID: <CAMRc=McSBBeHi5jDVYOF6s1etfQzYRNLo25LeY+DWG_2tEf7=w@mail.gmail.com>
Subject: Re: [PATCH 07/21] gpiolib: provide gpio_device_get_base()
To:     Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 7, 2023 at 9:17=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Tue, Sep 5, 2023 at 8:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Let's start adding getters for the opaque struct gpio_device. Start wit=
h
> > a function allowing to retrieve the base GPIO number.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> I guess you have a solid usecase for drivers needing to do this
> crazy thing, because I suppose you feel as much as me that
> this should rather be gpiolib-internal and confined to
> drivers/gpio/gpiolib.h?
>
> If you add a valid reason for making this globally visible outside
> of drivers/[gpio|pinctrl] to the commit message I guess I can live
> with it because we need to think of the bigger picture:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> It brings to mind the now confusing "base" inside of
> struct gpio_chip. We all know it should go away, but since it
> is never used during the lifetime of the gpio_chip - or SHOULD
> never be used - it should rather be an argument to
> [devm_]gpiochip_add_data( .... int base);...
>
> Maybe something we should add to our TODO file.
>
> Yours,
> Linus Walleij

For this series it's the HTE driver that uses it and I don't have a
good idea about how to change it. Dipen?

I would also love to make pinctrl not use the internal GPIOLIB header
so it'll be another user, unless you can figure out a way to not use
gc->base? :)

I think we're stuck with it for now.

Bart
