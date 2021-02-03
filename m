Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52AB30D470
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 08:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbhBCHzx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 02:55:53 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45654 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbhBCHzv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 02:55:51 -0500
Received: by mail-ot1-f41.google.com with SMTP id o12so871931ote.12;
        Tue, 02 Feb 2021 23:55:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CiVkUnX1rF7MfRbPuBk59y3JgbJm++nqR8KpbyKln9E=;
        b=Jaja+bThwGxU7TwK8cfXJYhoYqmi/Z17M7s/FoD9Z51y4qxqEPmSlUyUkP3XdsBsga
         CG85REYrCghUAJv21AGGsoRZ5bu3/k7GBrXf1OyQcrmtNNSPDtiytlNFdOYJvmPc1snx
         Y1mB9air9vLTeD61tEXLCcLBnDPQz6S6oYIH9IfaBYVH8BsWv26Cw5cHUXsOhBQiRaYZ
         CaEvBNR9xoBnr7/v9UnUMaiBCgBYqX6LXmb08n1vI9qKze0TjJUhY/bjiVvDV+gWWmU6
         hbzj2hnoaXLSo6FIEcZeV1GXZ05R6iyU8Wm1HhCG12x1Ni7yLRxo8yhSHChzDRLrNSh/
         NIWA==
X-Gm-Message-State: AOAM531AIwMHXHbHOA4asId5JgZwHg1dNruIKn5xJJW0umerubraL6Vt
        egNrLx5J3ZBEKno4VP2CMrPR/danqD22sigS7Rw=
X-Google-Smtp-Source: ABdhPJxc3BQwrIRlIATWeCLFrLCFZibhWXfsRO1E9PPrbBHdptbcNVEi+ZoVF3PUaTBfdWY3rke88vmuJdbnB7koodw=
X-Received: by 2002:a05:6830:1489:: with SMTP id s9mr1207916otq.250.1612338910673;
 Tue, 02 Feb 2021 23:55:10 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx> <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
In-Reply-To: <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Feb 2021 08:54:59 +0100
Message-ID: <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
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

On Tue, Feb 2, 2021 at 11:44 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 2, 2021 at 1:22 PM Martin Kaiser <martin@kaiser.cx> wrote:
> > Thus wrote Saravana Kannan (saravanak@google.com):
> > All of those drivers have a gpio in
> > their device-tree node, such as
> >
> > my_driver {
> >    gpio_test1 = <&gpio1 0 0>;
> >    ...
> > };
> >
> > with gpio1 from arch/arm/boot/dts/imx25.dtsi.
> >
> > The probe function calls
> >
> > of_get_named_gpio(np, "gpio_test1", 0);
> >
> > to get the gpio. This fails with -EINVAL.
>
> And you didn't see this issue with the fsl,avic patch?
>
> The property you are using is not a standard GPIO binding (-gpios,
> gpio, gpios) and I'm not surprised it's not working. The gpio1 is
> probably getting probe deferred and ends up running after "my_driver".

So my_driver doesn't support deferred probe, as of_get_named_gpio()
returns -EINVAL instead of -EPROBE_DEFER?
Converting my_driver from of_get_named_gpio() to the gpiod_*() API
should at least make the driver support probe deferral, after which I
expect it to start working again on reprobe?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
