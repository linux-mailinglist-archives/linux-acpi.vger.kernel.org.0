Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F126C34AE9D
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 19:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhCZSaf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 14:30:35 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:43834 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhCZSaH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Mar 2021 14:30:07 -0400
Received: by mail-ua1-f43.google.com with SMTP id b7so1844635uam.10;
        Fri, 26 Mar 2021 11:30:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZGkD+4E2RmAMLxrWzBsZkwCCLapq9ZQRvLGJF4GNDc=;
        b=Ng12zlhcQH5p6RIHSBG/HvQCahO/IW1jmW9irIsuJTz/p/TIUDg8IHrOtlDulB5Lf4
         SWB6W/F4bvanRi11K3rmYDZHVkakKsnOFJc//pRRum1Hm7N7qqIzU9FMOU5U4oEPo90T
         lTac3W8p3JPxMGOKEDJByB1wU6uCZSMLSi7h2gapO+CKIZMP2liVVX8F4Up5l3Coz3zf
         QUtrSUq6e1gdWx7urXAphTI5EGiBD8J9gzQxkuVFoLHrdf/a7M+hHOI0WJxbkh8Ighn+
         BWbPCHU0/ARpkogu3ciROCpYz/+omyk2lQR3ycGtymFpK1HW8arJine0zTekrIvLOerT
         SqTg==
X-Gm-Message-State: AOAM531JKz+K7XuRtq/5cnGtjxTheEN+OShArhzDCTa5ctz2Bj+tb/GE
        ofXCPZzKY3Oh67LxBKlBwHYsfrDtzx2KLjMn83c=
X-Google-Smtp-Source: ABdhPJx0IhSE3AkZ3+3lDyKkbS3EoEFfE4627qSgDTDKiNvMtRzb4w4kqJdMTUKAhyc0CMv4LBbwcP4qpaDf7XslJk0=
X-Received: by 2002:ab0:30b3:: with SMTP id b19mr9108849uam.58.1616783406884;
 Fri, 26 Mar 2021 11:30:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210205222644.2357303-9-saravanak@google.com>
 <20210210114435.122242-1-tudor.ambarus@microchip.com> <20210210114435.122242-2-tudor.ambarus@microchip.com>
 <CGME20210325133159eucas1p297b769beb681743fb32d362a86cc6e3e@eucas1p2.samsung.com>
 <d24bebc5-0f78-021f-293f-e58defa32531@samsung.com> <9b206c4d00dfe8b7f941260f18909914b2b2eecb.camel@suse.de>
 <161678243444.3012082.5031467952132861429@swboyd.mtv.corp.google.com>
In-Reply-To: <161678243444.3012082.5031467952132861429@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Mar 2021 19:29:55 +0100
Message-ID: <CAMuHMdV5PGUujsFP2TXMxij4UxVnrrurh_qVhq8+480w21jJAg@mail.gmail.com>
Subject: Re: [PATCH] clk: Mark fwnodes when their clock provider is added
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
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
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Stephen,

On Fri, Mar 26, 2021 at 7:13 PM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Nicolas Saenz Julienne (2021-03-25 11:25:24)
> > On Thu, 2021-03-25 at 14:31 +0100, Marek Szyprowski wrote:
> > > On 10.02.2021 12:44, Tudor Ambarus wrote:
> > > > This is a follow-up for:
> > > > commit 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> > > >
> > > > The above commit updated the deprecated of_clk_add_provider(),
> > > > but missed to update the preferred of_clk_add_hw_provider().
> > > > Update it now.
> > > >
> > > > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > >
> > > This patch, which landed in linux-next as commit 6579c8d97ad7 ("clk:
> > > Mark fwnodes when their clock provider is added") causes the following
> > > NULL pointer dereference on Raspberry Pi 3b+ boards:
> > >
> > > --->8---
> > >
> > > raspberrypi-firmware soc:firmware: Attached to firmware from
> > > 2020-01-06T13:05:25
> > > Unable to handle kernel NULL pointer dereference at virtual address
> > > 0000000000000050
> > > Mem abort info:
> > >    ESR = 0x96000004
> > >    EC = 0x25: DABT (current EL), IL = 32 bits
> > >    SET = 0, FnV = 0
> > >    EA = 0, S1PTW = 0
> > > Data abort info:
> > >    ISV = 0, ISS = 0x00000004
> > >    CM = 0, WnR = 0
> > > [0000000000000050] user address but active_mm is swapper
> > > Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > > Modules linked in:
> > > CPU: 0 PID: 10 Comm: kworker/0:1 Not tainted 5.12.0-rc4+ #2764
> > > Hardware name: Raspberry Pi 3 Model B (DT)
> > > Workqueue: events deferred_probe_work_func
> > > pstate: 00000005 (nzcv daif -PAN -UAO -TCO BTYPE=--)
> > > pc : of_clk_add_hw_provider+0xac/0xe8
> > > lr : of_clk_add_hw_provider+0x94/0xe8
> > > sp : ffff8000130936b0
> > > x29: ffff8000130936b0 x28: ffff800012494e04
> > > x27: ffff00003b18cb05 x26: ffff00003aa5c010
> > > x25: 0000000000000000 x24: 0000000000000000
> > > x23: ffff00003aa1e380 x22: ffff8000106830d0
> > > x21: ffff80001233f180 x20: 0000000000000018
> > > x19: 0000000000000000 x18: ffff8000124d38b0
> > > x17: 0000000000000013 x16: 0000000000000014
> > > x15: ffff8000125758b0 x14: 00000000000184e0
> > > x13: 000000000000292e x12: ffff80001258dd98
> > > x11: 0000000000000001 x10: 0101010101010101
> > > x9 : ffff80001233f288 x8 : 7f7f7f7f7f7f7f7f
> > > x7 : fefefefeff6c626f x6 : 5d636d8080808080
> > > x5 : 00000000006d635d x4 : 0000000000000000
> > > x3 : 0000000000000000 x2 : 540eb5edae191600
> > > x1 : 0000000000000000 x0 : 0000000000000000
> > > Call trace:
> > >   of_clk_add_hw_provider+0xac/0xe8
> > >   devm_of_clk_add_hw_provider+0x5c/0xb8
> > >   raspberrypi_clk_probe+0x110/0x210
> > >   platform_probe+0x90/0xd8
> > >   really_probe+0x108/0x3c0
> > >   driver_probe_device+0x60/0xc0
> > >   __device_attach_driver+0x9c/0xd0
> > >   bus_for_each_drv+0x70/0xc8
> > >   __device_attach+0xec/0x150
> > >   device_initial_probe+0x10/0x18
> > >   bus_probe_device+0x94/0xa0
> > >   device_add+0x47c/0x780
> > >   platform_device_add+0x110/0x248
> > >   platform_device_register_full+0x120/0x150
> > >   rpi_firmware_probe+0x158/0x1f8
> > >   platform_probe+0x90/0xd8
> > >   really_probe+0x108/0x3c0
> > >   driver_probe_device+0x60/0xc0
> > >   __device_attach_driver+0x9c/0xd0
> > >   bus_for_each_drv+0x70/0xc8
> > >   __device_attach+0xec/0x150
> > >   device_initial_probe+0x10/0x18
> > >   bus_probe_device+0x94/0xa0
> > >   deferred_probe_work_func+0x70/0xa8
> > >   process_one_work+0x2a8/0x718
> > >   worker_thread+0x48/0x460
> > >   kthread+0x134/0x160
> > >   ret_from_fork+0x10/0x18
> > > Code: b1006294 540000c0 b140069f 54000088 (3940e280)
> > > ---[ end trace 7ead5ec2f0c51cfe ]---
> > >
> > > This patch mainly revealed that clk/bcm/clk-raspberrypi.c driver calls
> > > devm_of_clk_add_hw_provider(), with a device pointer, which has a NULL
> > > dev->of_node. I'm not sure if adding a check for a NULL np in
> > > of_clk_add_hw_provider() is a right fix, though.
> >
> > I believe the right fix is not to call 'devm_of_clk_add_hw_provider()' if
> > 'pdev->dev.of_node == NULL'. In such case, which is RPi3's, only the CPU clock
> > is used, and it's defined and queried later through
> > devm_clk_hw_register_clkdev().
> >
> > @Marek, I don't mind taking care of it if it's OK with you.
> >
>
> Ah I see this is related to the patch I just reviewed. Can you reference
> this in the commit text? And instead of putting the change into the clk
> provider let's check for NULL 'np' in of_clk_add_hw_provider() instead
> and return 0 if there's nothing to do. That way we don't visit this
> problem over and over again.

I'm not sure the latter is what we reall want: shouldn't calling
*of*_clk_add_hw_provider() with a NULL np be a bug in the provider?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
