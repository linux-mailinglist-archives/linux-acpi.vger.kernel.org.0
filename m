Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845AE30D4C6
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhBCINM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 03:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhBCIMY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 03:12:24 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAC7C0613ED
        for <linux-acpi@vger.kernel.org>; Wed,  3 Feb 2021 00:11:43 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id k4so23159044ybp.6
        for <linux-acpi@vger.kernel.org>; Wed, 03 Feb 2021 00:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUW6cgsXf2s6Tfa7ZBwWDiC0Ybs+CZP4Y/WyzJM6xdE=;
        b=e4o9+Iyhhng61ZUBiTQVSh0YIC0WX0YQgbFG2JnC5OgJOmU1TEsv8rXj6O2YpEGlCM
         9qIibJPLK6Q9+r61vBxCXm6ocA0gA97OT91LTSX/cL2XFjDlSKMsm1NK1Rh+BRRuUwNX
         5c1vyQTmzKRfILyNQ1haSJBHeeaKqEy40Ke8vM0IWFqYWiJEIEESlqqeXj2OB3LiXZe2
         RGFgc0S89nCMKyRBrba7gM9N2+ltBHH8H7HzAetoBmDDbumeWOL8sLe5ZcHsipLYZefD
         7CKAk6Ztd9GpYKhL0vw8Q2XaK83O0lSyg3vXi51F1Ittn+v7Qs6xJIno+8rmrHdbA5E1
         PwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUW6cgsXf2s6Tfa7ZBwWDiC0Ybs+CZP4Y/WyzJM6xdE=;
        b=k9E9T7KUwYACqYH+c7voir4wHnmvarQ3RO9p0ERX/QJjsfORR3s3QPacq5SNff1ceg
         sDiFZj+0NbWCbCrvciGPEkSkRGLl0X00j4mLUNX5yh63JNFpSAMwpjfuRMoJHo3EEduz
         zKbobx2P8NuJzlZpJbBATAlOc4KAJLA6ROAW15XTQ54mFgxurDF38C9XXiRoa6Y/dNo9
         tTONnJnWTN6LzJBT3tqsGelmuJWjxasX2kOfISQ4lom1kTEZdlJmTDYTwwIMTAVPzC2E
         +mJVQcG0EDCus9NgjiUVXVVQcAd4XP854S6nNuRtLiMFk7GxYe9Llhpl3orjA8Yy0+LG
         Nr6Q==
X-Gm-Message-State: AOAM533ai6+Rfr2mk0ucwqNS9GBcWtrTaG3xl0KI3PAeIIZ+we3sx6/H
        jDgClhh2qVEVLLr9mWUppOx+OIabBQamtNSc2Gdhug==
X-Google-Smtp-Source: ABdhPJxG0tdpeOwp+/0CnIheHpmshoirdWiOvrrQQqDY3qUnb995QukB+klHmqncq/Osq2uTrFf3VxC9z/v7/ADpl/4=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr2735437ybf.346.1612339902716;
 Wed, 03 Feb 2021 00:11:42 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx> <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
 <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Feb 2021 00:11:06 -0800
Message-ID: <CAGETcx8Yai=q+sHiixcv=D=T9r0+X1GZ8LRBc98SX_omYVhavQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 11:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Tue, Feb 2, 2021 at 11:44 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 2, 2021 at 1:22 PM Martin Kaiser <martin@kaiser.cx> wrote:
> > > Thus wrote Saravana Kannan (saravanak@google.com):
> > > All of those drivers have a gpio in
> > > their device-tree node, such as
> > >
> > > my_driver {
> > >    gpio_test1 = <&gpio1 0 0>;
> > >    ...
> > > };
> > >
> > > with gpio1 from arch/arm/boot/dts/imx25.dtsi.
> > >
> > > The probe function calls
> > >
> > > of_get_named_gpio(np, "gpio_test1", 0);
> > >
> > > to get the gpio. This fails with -EINVAL.
> >
> > And you didn't see this issue with the fsl,avic patch?
> >
> > The property you are using is not a standard GPIO binding (-gpios,
> > gpio, gpios) and I'm not surprised it's not working. The gpio1 is
> > probably getting probe deferred and ends up running after "my_driver".
>
> So my_driver doesn't support deferred probe, as of_get_named_gpio()
> returns -EINVAL instead of -EPROBE_DEFER?
> Converting my_driver from of_get_named_gpio() to the gpiod_*() API
> should at least make the driver support probe deferral, after which I
> expect it to start working again on reprobe?

The way I understood the API/example, you can't just change the code
and have it work. The DT itself isn't using standard bindings. And we
can't make kernel changes that assume the DT has been changed to match
the code. So, the best we could do is have of_get_named_gpio() return
-EPROBE_DEFER if it doesn't find the GPIO -- assuming that doesn't
break other users. Or have this specific driver remap the -EINVAL to
-EPROBE_DEFER.

-Saravana
