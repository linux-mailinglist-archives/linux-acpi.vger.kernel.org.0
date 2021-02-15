Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3955831BC22
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 16:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhBOPSC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 10:18:02 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33653 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbhBOPRT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 10:17:19 -0500
Received: by mail-oi1-f170.google.com with SMTP id g84so8087251oib.0;
        Mon, 15 Feb 2021 07:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C2sgcKj98aThSkMnimZCE29PrKW4uLBphZONfs+K+xs=;
        b=GL8qVu/2QTBsfRdMoMIHvkUU4iUVXOha82kbYR9qN8Nf8b6gTPQhfUdHU0I1bwRlKF
         t20BYYJwqe7QKtWoVUg5zw6yQxCxaodAYL9nBasg5lcRE7iv/YqxWm6CFFTiqfMi3Uf/
         ZvtLMfDYV5uFmYmvRZVSug5JXOwZTTeLzgGkWA7pOWNRaJf3BX8dxq6ZEO7VDRwimhTE
         i1TsszyPdRm7vAdOrYNR7SdlSX52bRePCYQ/G2DzLPIjxLJB0sQm6JqEKmZnvYt80aGz
         0D57e8wDeSF+jOgJpDGx/sygdw8qf1edXmUNKVHJkeeL/WibEoVOvM3pUddlAE9eIyFg
         fd3Q==
X-Gm-Message-State: AOAM5326NBA5QrFmJN1zf2V8wLD4mUAsN9Peu3tTwRM6txwul3Cqdn1o
        zxtKdnFNRt8qStDt33NUYzVGuUKMk7FiPBlhpUM=
X-Google-Smtp-Source: ABdhPJwotWAB2xGmxfLxbGS5Z/LD74rUcKxjHXAATycJb1YqtCg3KBlKdm2uoXg7aAcGCZii1QJxuPu4F9CREIowcj4=
X-Received: by 2002:aca:744:: with SMTP id 65mr8563823oih.153.1613402198301;
 Mon, 15 Feb 2021 07:16:38 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com> <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
In-Reply-To: <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Feb 2021 16:16:27 +0100
Message-ID: <CAMuHMdWFp_teT5Lgxe6BOpOb4UMM2_4FrKJm-2C6kuCH2YUMrw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >   1. R-Car Gen2 (Koelsch), R-Car Gen3 (Salvator-X(S), Ebisu).
> >
> >       - Commit 2dfc564bda4a31bc ("soc: renesas: rcar-sysc: Mark device
> >         node OF_POPULATED after init") is no longer needed (but already
> >         queued for v5.12 anyway)
>
> Rob doesn't like the proliferation of OF_POPULATED and we don't need
> it anymore, so maybe work it out with him? It's a balance between some
> wasted memory (struct device(s)) vs not proliferating OF_POPULATED.

> >   2. SH/R-Mobile AG5 (kzm9g), APE6 (ape6evm), A1 (armadillo800-eva)
> >
> >       - "PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
> >         reset handling" is no longer needed
> >         https://lore.kernel.org/linux-arm-kernel/20210205133319.1921108-1-geert+renesas@glider.be/
>
> Good to see more evidence that this series is fixing things at a more
> generic level.

I spoke too soon: if CONFIG_POWER_RESET_RMOBILE=n,
booting fails again, as everything is waiting on the system controller,
which never becomes available.
Rcar-sysc doesn't suffer from this problem, cfr. above.
Perhaps because the rmobile-sysc bindings use a hierarchical instead
of a linear PM domain description, and thus consumers point to the
children of the system controller node?
Cfr. system-controller@e6180000 in arch/arm/boot/dts/r8a7740.dtsi.

> >       - On R-Mobile A1, I get a BUG and a memory leak:
> >
> >             BUG: spinlock bad magic on CPU#0, swapper/1
> >              lock: lcdc0_device+0x10c/0x308, .magic: 00000000, .owner:
> > <none>/-1, .owner_cpu: 0
> >             CPU: 0 PID: 1 Comm: swapper Not tainted
> > 5.11.0-rc5-armadillo-00032-gf0a85c26907e #266
> >             Hardware name: Generic R8A7740 (Flattened Device Tree)
> >             [<c010c3c8>] (unwind_backtrace) from [<c010a49c>]
> > (show_stack+0x10/0x14)
> >             [<c010a49c>] (show_stack) from [<c0159534>]
> > (do_raw_spin_lock+0x20/0x94)
> >             [<c0159534>] (do_raw_spin_lock) from [<c04089d8>]
> > (dev_pm_get_subsys_data+0x30/0xa0)
> >             [<c04089d8>] (dev_pm_get_subsys_data) from [<c0413698>]
> > (genpd_add_device+0x34/0x1c0)
> >             [<c0413698>] (genpd_add_device) from [<c041389c>]
> > (of_genpd_add_device+0x34/0x4c)
> >             [<c041389c>] (of_genpd_add_device) from [<c0a1e9bc>]
> > (board_staging_register_device+0xf8/0x118)
> >             [<c0a1e9bc>] (board_staging_register_device) from

This is indeed a pre-existing problem.
of_genpd_add_device() is called before platform_device_register(),
as it needs to attach the genpd before the device is probed.
But the spinlock is only initialized when the device is registered.
This was masked before due to an unrelated wait context check failure,
which disabled any further spinlock checks, and exposed by fw_devlinks
changing probe order.
Patch sent.
"[PATCH] staging: board: Fix uninitialized spinlock when attaching genpd"
https://lore.kernel.org/r/20210215151405.2551143-1-geert+renesas@glider.be



Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
