Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6AD349604
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 16:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCYPsS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 11:48:18 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:38665 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhCYPrp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Mar 2021 11:47:45 -0400
Received: by mail-ua1-f46.google.com with SMTP id h34so646723uah.5;
        Thu, 25 Mar 2021 08:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VORyg37KyhTM2pEju2vrHYnS2b444LAJS39AyI1tLyU=;
        b=NIbnJ/1DUbHA/K0FQzgEn+Ml5S10WVEPFyT3/1vYjTjpW6U7GEpOwvhiMco+9NXhUn
         pM8GXczkW4Y+qLQv1zdt3fRLRdpmBulI+eYp9vlx1uUh7Ze2zmwdIVUbIYzVwkSjK2nE
         XdzH1O5k/IaC7hnqpDWr9Je+wFj7T7EwkhTp77XknpPIhumlQIuI2QqP6K9tB9s7M1N/
         n+sT0E/xaUFXeVhmMoF2VeKcg7306o62/30lfniz+RxDsd6psnA7u8Cts4LD7E9Vn5MP
         Ga02gLhpGFlRTMhcgphZpOk0rNhH+gqPzrGRCt80N8pQKRbiOjnKsp6qKsNXwNb2f10k
         FOQg==
X-Gm-Message-State: AOAM532az4ky0wLWB4fzXHMsA1IsqEZ5xy9OqfmLSj0GtIpE0Z8nTwgC
        qVTxrGTkph8BWpxvBKMfCwjTKFuPIIu1Q34jfVc=
X-Google-Smtp-Source: ABdhPJz9ribtsSNo45nfPsfI32D2+XmTQUPrUgHfSYuhDyGOQqll7eBC8nUPPybEDHZ0rx9LbEO15UIVaXecG/fpF7Q=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr5452914uar.100.1616687264304;
 Thu, 25 Mar 2021 08:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com> <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
 <20210210114435.122242-2-tudor.ambarus@microchip.com> <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com>
In-Reply-To: <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Mar 2021 16:47:33 +0100
Message-ID: <CAMuHMdUaROcMbjAM1fu8und4g=BFZe3C3f8-rbB3q+85RWvgeA@mail.gmail.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Saravana Kannan <saravanak@google.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Marek,

On Thu, Mar 25, 2021 at 2:32 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> On 10.02.2021 12:44, Tudor Ambarus wrote:
> > This is a follow-up for:
> > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> >
> > The above commit updated the deprecated of_clk_add_provider(),
> > but missed to update the preferred of_clk_add_hw_provider().
> > Update it now.
> >
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>
> This patch, which landed in linux-next as commit 6579c8d97ad7 ("clk:
> Mark fwnodes when their clock provider is added") causes the following
> NULL pointer dereference on Raspberry Pi 3b+ boards:
>
> --->8---
>
> raspberrypi-firmware soc:firmware: Attached to firmware from
> 2020-01-06T13:05:25
> Unable to handle kernel NULL pointer dereference at virtual address
> 0000000000000050
> Mem abort info:
>    ESR = 0x96000004
>    EC = 0x25: DABT (current EL), IL = 32 bits
>    SET = 0, FnV = 0
>    EA = 0, S1PTW = 0
> Data abort info:
>    ISV = 0, ISS = 0x00000004
>    CM = 0, WnR = 0
> [0000000000000050] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 5.12.0-rc4+ #2764
> Hardware name: Raspberry Pi 3 Model B (DT)
> Workqueue: events deferred_probe_work_func
> pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> pc : of_clk_add_hw_provider+0xac/0xe8
> lr : of_clk_add_hw_provider+0x94/0xe8
> sp : ffff8000130936b0
> x29: ffff8000130936b0 x28: ffff800012494e04
> x27: ffff00003b18cb05 x26: ffff00003aa5c010
> x25: 0000000000000000 x24: 0000000000000000
> x23: ffff00003aa1e380 x22: ffff8000106830d0
> x21: ffff80001233f180 x20: 0000000000000018
> x19: 0000000000000000 x18: ffff8000124d38b0
> x17: 0000000000000013 x16: 0000000000000014
> x15: ffff8000125758b0 x14: 00000000000184e0
> x13: 000000000000292e x12: ffff80001258dd98
> x11: 0000000000000001 x10: 0101010101010101
> x9 : ffff80001233f288 x8 : 7f7f7f7f7f7f7f7f
> x7 : fefefefeff6c626f x6 : 5d636d8080808080
> x5 : 00000000006d635d x4 : 0000000000000000
> x3 : 0000000000000000 x2 : 540eb5edae191600
> x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>   of_clk_add_hw_provider+0xac/0xe8
>   devm_of_clk_add_hw_provider+0x5c/0xb8
>   raspberrypi_clk_probe+0x110/0x210
>   platform_probe+0x90/0xd8
>   really_probe+0x108/0x3c0
>   driver_probe_device+0x60/0xc0
>   __device_attach_driver+0x9c/0xd0
>   bus_for_each_drv+0x70/0xc8
>   __device_attach+0xec/0x150
>   device_initial_probe+0x10/0x18
>   bus_probe_device+0x94/0xa0
>   device_add+0x47c/0x780
>   platform_device_add+0x110/0x248
>   platform_device_register_full+0x120/0x150
>   rpi_firmware_probe+0x158/0x1f8

> This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls
> devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL
> dev->of_node. I'm not sure if adding a check for a NULL np in
> of_clk_add_hw_provider() is a right fix, though.

raspberrypi_clk_probe():

        /*
         * We can be probed either through the an old-fashioned
         * platform device registration or through a DT node that is a
         * child of the firmware node. Handle both cases.
         */

So the real issue is rpi_register_clk_driver() creating a platform
device for the firmware clocks if they're missing in DT.

Then, the clock driver calls devm_of_clk_add_hw_provider(),
regardless of a DT node being present or not.
I'm wondering how power consumers are supposed to refer
to these firmware clocks, without a DT node?

> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -4594,6 +4594,8 @@ int of_clk_add_hw_provider(struct device_node *np,
> >       if (ret < 0)
> >               of_clk_del_provider(np);
> >
> > +     fwnode_dev_initialized(&np->fwnode, true);
> > +
> >       return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(of_clk_add_hw_provider);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
