Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87754319B0E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 09:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhBLIPx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 03:15:53 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44012 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhBLIPx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 03:15:53 -0500
Received: by mail-oi1-f178.google.com with SMTP id d20so9151874oiw.10;
        Fri, 12 Feb 2021 00:15:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUw6a0oNfUGx7sV9+BDmLKTx8i0omztJvVehVvMjp08=;
        b=qEjn8JdK1Eu6xmpC/dDmOyxGdCxYz6cG7isOBUjSog9jKu+/4yYVCZ7xTih0XFJacg
         sTWFGJGY2vwFMKVVL5ATbldDK+oNO3UpNFr57m7gX2mf9fBGSh7WdxOg731/NH6AthMg
         3N30EUfAWh5PBWE5hrMQYA+BFR5Si++VoWdvw0PBrRErEvGh290RjPjJGVSzvbQzjV4U
         IwKA1MpiWRo2zeidP+Ryicv8TCYipar4Y+MHA4ZZGYXuqutU/IELofxpXsUSZSFm3T5Q
         mJifoUgXTNsZN4C1r04D7nY1/xh44XirHAh2BaO/Ku9ZsBqPxyWCN4uYAqS3OKRIpYJL
         NAVw==
X-Gm-Message-State: AOAM533p/j7sNKmu7ry4URASVaHnkD0jijp0uE3V3TEz8lZtS6ropovO
        hohCXFxA7wtWCsdDDW654SS4Azsv9ly4c59CobE=
X-Google-Smtp-Source: ABdhPJy6z32m+bzOluIHnLsLpN1EyV/5RCGuvrp+ntL/2TP7Vc/kZ3Ry6sT9BbR+1Sm0fMQkDE9ovvBYq5nqPtBHZk8=
X-Received: by 2002:aca:d8c6:: with SMTP id p189mr1109394oig.54.1613117711336;
 Fri, 12 Feb 2021 00:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com> <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
In-Reply-To: <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 12 Feb 2021 09:14:59 +0100
Message-ID: <CAMuHMdVG97Zjr1WO0554h9eUZhfeyxwUfNYuAdPoacpznkA6-Q@mail.gmail.com>
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

Rob: should it be reverted?  For v5.13?
I guess other similar "fixes" went in in the mean time.

> >       - Some devices are reprobed, despite their drivers returning
> >         a real error code, and not -EPROBE_DEFER:
>
> Sorry, it's not obvious from the logs below where "reprobing" is
> happening. Can you give more pointers please?

My log was indeed not a full log, but just the reprobes happening.
I'll send you a full log by private email.

> Also, thinking more about this, the only way I could see this happen is:
> 1. Device fails with error that's not -EPROBE_DEFER
> 2. It somehow gets added to a device link (with AUTOPROBE_CONSUMER
> flag) where it's a consumer.
> 3. The supplier probes and the device gets added to the deferred probe
> list again.
>
> But I can't see how this sequence can happen. Device links are created
> only when a device is added. And is the supplier isn't added yet, the
> consumer wouldn't have probed in the first place.

The full log doesn't show any evidence of the device being added
to a list in between the two probes.

> Other than "annoying waste of time" is this causing any other problems?

Probably not.  But see below.

> >       - The PCI reprobing leads to a memory leak, for which I've sent a fix
> >         "[PATCH] PCI: Fix memory leak in pci_register_io_range()"
> >         https://lore.kernel.org/linux-pci/20210202100332.829047-1-geert+renesas@glider.be/
>
> Wrt PCI reprobing,
> 1. Is this PCI never expected to probe, but it's being reattempted
> despite the NOT EPROBE_DEFER error? Or

There is no PCIe card present, so the failure is expected.
Later it is reprobed, which of course fails again.

> 2. The PCI was deferred probe when it should have probed and then when
> it's finally reattemped and it could succeed, we are hitting this mem
> leak issue?

I think the leak has always been there, but it was just exposed by
this unneeded reprobe.  I don't think a reprobe after that specific
error path had ever happened before.

> I'm basically trying to distinguish between "this stuff should never
> be retried" vs "this/it's suppliers got probe deferred with
> fw_devlink=on vs but didn't get probe deferred with
> fw_devlink=permissive and that's causing issues"

There should not be a probe deferral, as no -EPROBE_DEFER was
returned.

> >       - I2C on R-Car Gen3 does not seem to use DMA, according to
> >         /sys/kernel/debug/dmaengine/summary:
> >
> >             -dma4chan0    | e66d8000.i2c:tx
> >             -dma4chan1    | e66d8000.i2c:rx
> >             -dma5chan0    | e6510000.i2c:tx
>
> I think I need more context on the problem before I can try to fix it.
> I'm also very unfamiliar with that file. With fw_devlink=permissive,
> I2C was using DMA? If so, the next step is to see if the I2C relative
> probe order with DMA is getting changed and if so, why.

Yes, I plan to dig deeper to see what really happens...

> >       - On R-Mobile A1, I get a BUG and a memory leak:
> >
> >             BUG: spinlock bad magic on CPU#0, swapper/1

>
> Hmm... I looked at this in bits and pieces throughout the day. At
> least spent an hour looking at this. This doesn't make a lot of sense
> to me. I don't even touch anything in this code path AFAICT.  Are
> modules/kernel mixed up somehow? I need more info before I can help.
> Does reverting my pm domain change make any difference (assume it
> boots this far without it).

I plan to dig deeper to see what really happens...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
