Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9FF31A660
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Feb 2021 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhBLU6W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Feb 2021 15:58:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhBLU6Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Feb 2021 15:58:16 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4221DC061786
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 12:58:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id f4so725054ybk.11
        for <linux-acpi@vger.kernel.org>; Fri, 12 Feb 2021 12:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CqAzPT6VwnPBuxPka3afIBXbnCQbD8+pdFwxBKcHhXQ=;
        b=uBTJQG+mWgC2KaNYo1bb3HfZG5kNKJ7vb1CkEXXuyZyIlMIUmRy7u+Ui98xv5m6wXD
         R7N5LfNkcmh1NQ9NxgRQP3cWOkQFo7SAC+qn3I64HrXBzaGyP8UoGVC/bj+K+cZ8nSWe
         YQAtaHJyorTUUKIOxX53zOw5ATfxwx2KVYuQOmCF02rn7CG0N1rPqvKrBgWPiLi45FON
         shvjdCt7F02vXc8OsQJNlQ5Dg8hPGX1Xh3uWdinc2aBX3WWsUPVTakWNa4yKxhzAKQdV
         EuNXoz2GuhV1z+hCYh7JVx2iqHGoG2X6f6zTTF5209mcejt6xlzEddhC7ShsSohFBkLy
         xwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CqAzPT6VwnPBuxPka3afIBXbnCQbD8+pdFwxBKcHhXQ=;
        b=tySnQOMn/sv3GYbuh9MtSRqqpEMJGnUqTTe2x21UxxGD5i0lc5Ox2rBzWOUMwO3LzF
         3UA6gOXLMEMV3R4PpMXM8r828lhXXJph2s5Owc0Xx7prbNgypQnhXMZ9O3vPmZSJevO0
         HHpOapE+WreeMUA+WTrcs2FJw3KP1oqYHa1XK2OPbI5Cf6loqto7rgDVrqVMw2zhenl+
         Crb9+yZkeBihD8zpz5Tzw4C7z/bYOOMceJz1rUpGUHlOrjR+rSfOS+VOk2AgdklpMi0N
         2eUW++5KMHdn4DK879UWnhMjdlUQZoEdEOhKloxi+/Yj06eo3BUQ2LUzj+LDb/SrBZSC
         sp5A==
X-Gm-Message-State: AOAM533OY3RbgBmwq52A0FMO2EZ7wH9wZrn8q3G3hQBT2JIN1axy2HOt
        77Xdlp/23m1IJQZAcAbJmYjU5OPxl6qab+692bw/Aw==
X-Google-Smtp-Source: ABdhPJwK0fc2ml/1MYUHRvi8x2ga/wmAbYgOqo2Dy3Txjf3hoDchCtA5qthJoSF2yZyW//AH/pAR//MQ+c+2yrZOeqg=
X-Received: by 2002:a25:718b:: with SMTP id m133mr6949864ybc.412.1613163480367;
 Fri, 12 Feb 2021 12:58:00 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com> <CAMuHMdVG97Zjr1WO0554h9eUZhfeyxwUfNYuAdPoacpznkA6-Q@mail.gmail.com>
In-Reply-To: <CAMuHMdVG97Zjr1WO0554h9eUZhfeyxwUfNYuAdPoacpznkA6-Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 12 Feb 2021 12:57:24 -0800
Message-ID: <CAGETcx9GAyWQTb1kuUpjAcYyPGYtxxWMRe9u0o5UOSMrryTdvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Fri, Feb 12, 2021 at 12:15 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >   1. R-Car Gen2 (Koelsch), R-Car Gen3 (Salvator-X(S), Ebisu).
> > >
> > >       - Commit 2dfc564bda4a31bc ("soc: renesas: rcar-sysc: Mark device
> > >         node OF_POPULATED after init") is no longer needed (but already
> > >         queued for v5.12 anyway)
> >
> > Rob doesn't like the proliferation of OF_POPULATED and we don't need
> > it anymore, so maybe work it out with him? It's a balance between some
> > wasted memory (struct device(s)) vs not proliferating OF_POPULATED.
>
> Rob: should it be reverted?  For v5.13?
> I guess other similar "fixes" went in in the mean time.
>
> > >       - Some devices are reprobed, despite their drivers returning
> > >         a real error code, and not -EPROBE_DEFER:
> >
> > Sorry, it's not obvious from the logs below where "reprobing" is
> > happening. Can you give more pointers please?
>
> My log was indeed not a full log, but just the reprobes happening.
> I'll send you a full log by private email.
>
> > Also, thinking more about this, the only way I could see this happen is:
> > 1. Device fails with error that's not -EPROBE_DEFER
> > 2. It somehow gets added to a device link (with AUTOPROBE_CONSUMER
> > flag) where it's a consumer.
> > 3. The supplier probes and the device gets added to the deferred probe
> > list again.
> >
> > But I can't see how this sequence can happen. Device links are created
> > only when a device is added. And is the supplier isn't added yet, the
> > consumer wouldn't have probed in the first place.
>
> The full log doesn't show any evidence of the device being added
> to a list in between the two probes.
>
> > Other than "annoying waste of time" is this causing any other problems?
>
> Probably not.  But see below.
>
> > >       - The PCI reprobing leads to a memory leak, for which I've sent a fix
> > >         "[PATCH] PCI: Fix memory leak in pci_register_io_range()"
> > >         https://lore.kernel.org/linux-pci/20210202100332.829047-1-geert+renesas@glider.be/
> >
> > Wrt PCI reprobing,
> > 1. Is this PCI never expected to probe, but it's being reattempted
> > despite the NOT EPROBE_DEFER error? Or
>
> There is no PCIe card present, so the failure is expected.
> Later it is reprobed, which of course fails again.
>
> > 2. The PCI was deferred probe when it should have probed and then when
> > it's finally reattemped and it could succeed, we are hitting this mem
> > leak issue?
>
> I think the leak has always been there, but it was just exposed by
> this unneeded reprobe.  I don't think a reprobe after that specific
> error path had ever happened before.
>
> > I'm basically trying to distinguish between "this stuff should never
> > be retried" vs "this/it's suppliers got probe deferred with
> > fw_devlink=on vs but didn't get probe deferred with
> > fw_devlink=permissive and that's causing issues"
>
> There should not be a probe deferral, as no -EPROBE_DEFER was
> returned.
>
> > >       - I2C on R-Car Gen3 does not seem to use DMA, according to
> > >         /sys/kernel/debug/dmaengine/summary:
> > >
> > >             -dma4chan0    | e66d8000.i2c:tx
> > >             -dma4chan1    | e66d8000.i2c:rx
> > >             -dma5chan0    | e6510000.i2c:tx
> >
> > I think I need more context on the problem before I can try to fix it.
> > I'm also very unfamiliar with that file. With fw_devlink=permissive,
> > I2C was using DMA? If so, the next step is to see if the I2C relative
> > probe order with DMA is getting changed and if so, why.
>
> Yes, I plan to dig deeper to see what really happens...

Try fw_devlink.strict (you'll need IOMMU enabled too). If that fixes
it and you also don't see this issue with fw_devlink=permissive, then
it means there's probably some unnecessary probe deferral that we
should try to avoid. At least, that's my hunch right now.

Thanks,
Saravana

>
> > >       - On R-Mobile A1, I get a BUG and a memory leak:
> > >
> > >             BUG: spinlock bad magic on CPU#0, swapper/1
>
> >
> > Hmm... I looked at this in bits and pieces throughout the day. At
> > least spent an hour looking at this. This doesn't make a lot of sense
> > to me. I don't even touch anything in this code path AFAICT.  Are
> > modules/kernel mixed up somehow? I need more info before I can help.
> > Does reverting my pm domain change make any difference (assume it
> > boots this far without it).
>
> I plan to dig deeper to see what really happens...
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
