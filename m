Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5BA531D075
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 19:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhBPSui (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 13:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbhBPSua (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 13:50:30 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2EFC06178B
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 10:49:07 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id p193so11440301yba.4
        for <linux-acpi@vger.kernel.org>; Tue, 16 Feb 2021 10:49:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulqwXrQZpRrYT3IHT4CJ8bN5l6f9WiL4VvK05t2vkhU=;
        b=GFVUZyY2+36xaWQOsBNcWeZvX9dgErqzir1orOVD41NTZeSKMP3B4a8JAZpGfpZNzN
         7bXyMp1VBKh/kAFxyiGVdzGSA28wFoRfpMTz2roVpux4P7yqn6bWrY2qK82Ppkov5uAu
         QUDkguqttvIFR+d3KCw1u52ojhCNVVQmY4DxpG/8ts2opf5bn67o4y7luRYhIOq2Pvlw
         IvqSqfN5YIBG35KA0rfgWvZir4VWpbMA8m7NKzrc+hEQ4W99fQF8YRU4P7ukvmPeARfm
         S0fkAUw88oh53rPVhsngwpmb43ayPtF8/Jb5qc2PUkdNqhbSgYiCedPXLmVT5cQJ805u
         S1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulqwXrQZpRrYT3IHT4CJ8bN5l6f9WiL4VvK05t2vkhU=;
        b=OQYBMIuvEcXPgrtBOJFNNPrns5JddnNwOnrMMqB+rFA3KQ99s8P3dw2dU+zfCmUfuC
         xhrFUaRYcqPfImrFKfbNkZAxuQ2iX1W18j5/288zngP5P7LC5bifENT88kyQQmJbHu8E
         3rbJ6ZhwYzu0s9W7pG9oyGRF9U5J7xWclX5BP36E17WbVoDaDWTVydky3okXN8md8kkE
         o4ovcW//HS7yltxnlqMf/5oLXOwOaSw4q5NARjwBqwd2xkoAkAsy7F7CCJaI3hpFyz2f
         lcijarLVq4klNVAjr1GMwQnJQgklzs1GnuTrhqIm3KGHN2NQzXzePOSljI8kLhqmLe+w
         QJmA==
X-Gm-Message-State: AOAM530QLBCllBTs4+3kMcXPknLhERtT0K0QtJVs7z4fZJl/+l8BzHHe
        84UDNxxmzBKJgwAVxAZ1JLxpdmZV13bizzTekFzf8g==
X-Google-Smtp-Source: ABdhPJy/W97Gt0DiNuOozzUVmxZ1k867IJaF8h5dqBDAKdPQOmZJZO6WvC505FeNpD/Kj6p1JVZxSHxHAj6xXqAAWDU=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr31500894ybt.96.1613501346147;
 Tue, 16 Feb 2021 10:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
 <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
 <CAGETcx_4FGa-rzLp6bjXbm4F4R6H2W78+nM_kN=XPz5hswzANA@mail.gmail.com> <CAMuHMdVodauqBmLMxsfi0kQtAFT8ruJ36LJL9YuQgqwQNKwHHg@mail.gmail.com>
In-Reply-To: <CAMuHMdVodauqBmLMxsfi0kQtAFT8ruJ36LJL9YuQgqwQNKwHHg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Feb 2021 10:48:30 -0800
Message-ID: <CAGETcx_-yBvhXDPtOiKjenvx83oMNr32UvpMN0Dt-qz5ToXEbw@mail.gmail.com>
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

On Tue, Feb 16, 2021 at 12:05 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Feb 15, 2021 at 10:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Feb 15, 2021 at 4:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > >       - I2C on R-Car Gen3 does not seem to use DMA, according to
> > > > >         /sys/kernel/debug/dmaengine/summary:
> > > > >
> > > > >             -dma4chan0    | e66d8000.i2c:tx
> > > > >             -dma4chan1    | e66d8000.i2c:rx
> > > > >             -dma5chan0    | e6510000.i2c:tx
> > > >
> > > > I think I need more context on the problem before I can try to fix it.
> > > > I'm also very unfamiliar with that file. With fw_devlink=permissive,
> > > > I2C was using DMA? If so, the next step is to see if the I2C relative
> > > > probe order with DMA is getting changed and if so, why.
> > >
> > > More detailed log:
> > >
> > >     platform e66d8000.i2c: Linked as a consumer to e6150000.clock-controller
> > >     platform e66d8000.i2c: Linked as a sync state only consumer to e6055400.gpio
> > >
> > > Why is e66d8000.i2c not linked as a consumer to e6700000.dma-controller?
> >
> > Because fw_devlink.strict=1 is not set and dma/iommu is considered an
> > "optional"/"driver decides" dependency.
>
> Oh, I thought dma/iommu were considered mandatory initially,
> but dropped as dependencies in the late boot process?

No, I didn't do that in case the drivers that didn't need the
IOMMU/DMA were sensitive to probe order.

My goal was for fw_devlink=on to not affect probe order for devices
that currently don't need to defer probe. But see below...

>
> >
> > >     platform e6700000.dma-controller: Linked as a consumer to
> > > e6150000.clock-controller
> >
> > Is this the only supplier of dma-controller?
>
> No, e6180000.system-controller is also a supplier.
>
> > >     platform e66d8000.i2c: Added to deferred list
> > >     platform e6700000.dma-controller: Added to deferred list
> > >
> > >     bus: 'platform': driver_probe_device: matched device
> > > e6700000.dma-controller with driver rcar-dmac
> > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > device e6700000.dma-controller
> > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > >
> > >     bus: 'platform': driver_probe_device: matched device e66d8000.i2c
> > > with driver i2c-rcar
> > >     bus: 'platform': really_probe: probing driver i2c-rcar with device
> > > e66d8000.i2c
> > >
> > > I2C becomes available...
> > >
> > >     i2c-rcar e66d8000.i2c: request_channel failed for tx (-517)
> > >     [...]
> > >
> > > but DMA is not available yet, so the driver falls back to PIO.
> > >
> > >     driver: 'i2c-rcar': driver_bound: bound to device 'e66d8000.i2c'
> > >     bus: 'platform': really_probe: bound device e66d8000.i2c to driver i2c-rcar
> > >
> > >     platform e6700000.dma-controller: Retrying from deferred list
> > >     bus: 'platform': driver_probe_device: matched device
> > > e6700000.dma-controller with driver rcar-dmac
> > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > device e6700000.dma-controller
> > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > >     platform e6700000.dma-controller: Added to deferred list
> > >     platform e6700000.dma-controller: Retrying from deferred list
> > >     bus: 'platform': driver_probe_device: matched device
> > > e6700000.dma-controller with driver rcar-dmac
> > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > device e6700000.dma-controller
> > >     driver: 'rcar-dmac': driver_bound: bound to device 'e6700000.dma-controller'
> > >     bus: 'platform': really_probe: bound device
> > > e6700000.dma-controller to driver rcar-dmac
> > >
> > > DMA becomes available.
> > >
> > > Here userspace is entered. /sys/kernel/debug/dmaengine/summary shows
> > > that the I2C controllers do not have DMA channels allocated, as the
> > > kernel has performed no more I2C transfers after DMA became available.
> > >
> > > Using i2cdetect shows that DMA is used, which is good:
> > >
> > >     i2c-rcar e66d8000.i2c: got DMA channel for rx
> > >
> > > With permissive devlinks, the clock controller consumers are not added
> > > to the deferred probing list, and probe order is slightly different.
> > > The I2C controllers are still probed before the DMA controllers.
> > > But DMA becomes available a bit earlier, before the probing of the last
> > > I2C slave driver.
> >
> > This seems like a race? I'm guessing it's two different threads
> > probing those two devices? And it just happens to work for
> > "permissive" assuming the boot timing doesn't change?
> >
> > > Hence /sys/kernel/debug/dmaengine/summary shows that
> > > some I2C transfers did use DMA.
> > >
> > > So the real issue is that e66d8000.i2c not linked as a consumer to
> > > e6700000.dma-controller.
> >
> > That's because fw_devlink.strict=1 isn't set. If you need DMA to be
> > treated as a mandatory supplier, you'll need to set the flag.
> >
> > Is fw_devlink=on really breaking anything here? It just seems like
> > "permissive" got lucky with the timing and it could break at any point
> > in the future. Thought?
>
> I don't think there is a race.

Can you explain more please? This below makes it sound like DMA just
sneaks in at the last minute.

> > > The I2C controllers are still probed before the DMA controllers.
> > > But DMA becomes available a bit earlier, before the probing of the last
> > > I2C slave driver.

>  fw_devlinks calling driver_deferred_probe_add()
> on all consumers has a big impact on probe order.

Ugh... yeah. That's the real issue. This is really a device links
issue that fw_devlink is exposing. I already have a bunch of things in
my TODO list to improve deferred probing and probe ordering. Since
this is not causing boot issues (only DMA issue) with fw_devlink=on,
can we treat this as not a blocking item for fw_devlink=on? Once I go
through my TODO list, it should be fixed (by not changing probe
ordering unnecessarily). And if not, I can help find out a different
solution at that point.

Also, if you have IOMMU drivers, then fw_devlink.strict is also
another solution that's available. On a separate note (not a final
fix), I was wondering if we should have a config for fw_devlink.strict
default value and then have it selected when IOMMU drivers configs are
enabled.

-Saravana
