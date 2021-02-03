Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8755030D505
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 09:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhBCIQm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 03:16:42 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33114 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhBCIQl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 03:16:41 -0500
Received: by mail-oi1-f169.google.com with SMTP id j25so25937448oii.0;
        Wed, 03 Feb 2021 00:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMNMC+xpp5BmBErZ7DTtHEEdPkb5Qun0a5vbRXVX3vY=;
        b=POUgEegnMg7DMDQLrjEjgKdFHfrWjvwj8udpuPYIdEuwBzcLGEv0HtuWkrzYsb+pDp
         tlN79z4zrt40hE1IYgDWuENhJCz918W/sH0mLMrSfxsLIUyLrgD1qG7lNqjED5724oJH
         vek8NEL/52PkxUm4zmtpPvZ1hytLDkrzsE8QBafbdBtk5LcR1R7KSuiUicLK7lVTVNL3
         9ciUS1rXYHwp0aUL0ZCSx2EtRteN8N4iEXFwIMqHnKFrgkY5ue9Y41RztEzChWmCYyFK
         AaQJsrG42B8qWF9D7nvj1dNV7KbcqxxUlDs/6kXJ7qrhcdfn40soMnth7hUx5FcUNZuI
         jXDQ==
X-Gm-Message-State: AOAM532Rxdg1AKi+72YhT+dwmLpqXcsKy8bHewPPY+kqkcUr8KdovIZ4
        gpUbObOwOqQHnYsxhXfickEFxdI87+QKKGIcF8k=
X-Google-Smtp-Source: ABdhPJw59iItHayjaGX97phdW1sK3zjTtayzwJ1NUfqJOoKyyAHQO7+Dk/qcLkjM2SfB36dbgq0cCIFHKr1/YJuwhRk=
X-Received: by 2002:aca:4d8d:: with SMTP id a135mr1200672oib.153.1612340160027;
 Wed, 03 Feb 2021 00:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx> <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
 <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com> <CAGETcx8Yai=q+sHiixcv=D=T9r0+X1GZ8LRBc98SX_omYVhavQ@mail.gmail.com>
In-Reply-To: <CAGETcx8Yai=q+sHiixcv=D=T9r0+X1GZ8LRBc98SX_omYVhavQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Feb 2021 09:15:48 +0100
Message-ID: <CAMuHMdWyA3y1PYff5X9DoPaj0TREK3jFe_P+e+rNVb1K-kRDbA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Wed, Feb 3, 2021 at 9:11 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 2, 2021 at 11:55 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Feb 2, 2021 at 11:44 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Feb 2, 2021 at 1:22 PM Martin Kaiser <martin@kaiser.cx> wrote:
> > > > Thus wrote Saravana Kannan (saravanak@google.com):
> > > > All of those drivers have a gpio in
> > > > their device-tree node, such as
> > > >
> > > > my_driver {
> > > >    gpio_test1 = <&gpio1 0 0>;
> > > >    ...
> > > > };
> > > >
> > > > with gpio1 from arch/arm/boot/dts/imx25.dtsi.
> > > >
> > > > The probe function calls
> > > >
> > > > of_get_named_gpio(np, "gpio_test1", 0);
> > > >
> > > > to get the gpio. This fails with -EINVAL.
> > >
> > > And you didn't see this issue with the fsl,avic patch?
> > >
> > > The property you are using is not a standard GPIO binding (-gpios,
> > > gpio, gpios) and I'm not surprised it's not working. The gpio1 is
> > > probably getting probe deferred and ends up running after "my_driver".
> >
> > So my_driver doesn't support deferred probe, as of_get_named_gpio()
> > returns -EINVAL instead of -EPROBE_DEFER?
> > Converting my_driver from of_get_named_gpio() to the gpiod_*() API
> > should at least make the driver support probe deferral, after which I
> > expect it to start working again on reprobe?
>
> The way I understood the API/example, you can't just change the code
> and have it work. The DT itself isn't using standard bindings. And we

Oh, right.

> can't make kernel changes that assume the DT has been changed to match
> the code. So, the best we could do is have of_get_named_gpio() return
> -EPROBE_DEFER if it doesn't find the GPIO -- assuming that doesn't
> break other users. Or have this specific driver remap the -EINVAL to
> -EPROBE_DEFER.

The latter would hide real errors, too, and would cause futile reprobes.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
