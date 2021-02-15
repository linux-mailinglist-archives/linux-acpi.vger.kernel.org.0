Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A4E31C38F
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 22:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOV2E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhBOV2D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 16:28:03 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B70C06178A
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 13:27:07 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id x19so8546301ybe.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t3E5HIvJpmCJKKGhV4yDRws8HLa9LQ9/qceNMUiRu8c=;
        b=bBgXGWTdYcTDa8t6fcMwsRlWYc5Y1TndEDFz/4eUixRrAgdkN6ePgJPXLrrmqIxYLw
         O5MoN8JfVBRNfEIhRNi/KBC742zudWpRI+9MhLKpaQNk6wWiXhIhRgFrimbPfkANmE2c
         BraA/rL0wKABCMoJqHk8DujPL3of9VYIU/8liiheFaU4qONbc88zCdUs7n2iYYA3dWD1
         v3zMpC38CXHGX/+UhDhge2zo58nLARKKkBmSLiaTeAfVCGuYHTBXLOaQrQYf3LPmfvSd
         yGTSvYpRXgTYiu7L/tvsRDR+M7ETuPeR+khsiLlhCsCUW+BSb0mBpaF1C5U9NLOGzzx6
         qTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t3E5HIvJpmCJKKGhV4yDRws8HLa9LQ9/qceNMUiRu8c=;
        b=YkTPa3IKUiRwAC4uVP7wH1w1b3q5xcj1SszIBbnEqlxC1drcyGoCqs5k2dmdMSiiIP
         KPTVPi2Ty6htvXuHrooWjdn0UFWhqiRWx3EGz6WWhilVfWc0g5c7N9fHB/QWvHOUh0mh
         iXsHjGHYbrnnhoQApL5YdOZeQHKCI3PHeTjEjBYk+XV1AyTHLVMFaygQQ+P1g0tSxTBK
         V4TR5b9UWJzzGriyiGUWs5X1pzccxwm4rylJYPUoUnCRT12SI23fLcFhrCKSicNTZSW0
         LKLlejA5N3pvJGIcsW8z8zQmFV6IfsLTwVIWZsea5WBtXXjeer7mJLHm65E9GO1Xrp+Y
         Jswg==
X-Gm-Message-State: AOAM530aNpy7Egcfhv3OUuO/L72i3MYbajxIJRaV3NhDHZBM7onam0fI
        JaS6oKMl6TjV2YpckHfDWwtqbay3vIDYTE8GllQMEA==
X-Google-Smtp-Source: ABdhPJxX0RZwX9HWNB/HlZa/4ApbKsvCwfTglop0LrMflmMdROIaq+FilrrCNr6DVAAhj4RkRzXxMPx0xYtjVuYe/xg=
X-Received: by 2002:a05:6902:1025:: with SMTP id x5mr25256350ybt.96.1613424426724;
 Mon, 15 Feb 2021 13:27:06 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com> <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Feb 2021 13:26:30 -0800
Message-ID: <CAGETcx_4FGa-rzLp6bjXbm4F4R6H2W78+nM_kN=XPz5hswzANA@mail.gmail.com>
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

On Mon, Feb 15, 2021 at 4:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
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
> More detailed log:
>
>     platform e66d8000.i2c: Linked as a consumer to e6150000.clock-controller
>     platform e66d8000.i2c: Linked as a sync state only consumer to e6055400.gpio
>
> Why is e66d8000.i2c not linked as a consumer to e6700000.dma-controller?

Because fw_devlink.strict=1 is not set and dma/iommu is considered an
"optional"/"driver decides" dependency.

>     platform e6700000.dma-controller: Linked as a consumer to
> e6150000.clock-controller

Is this the only supplier of dma-controller?

>     platform e66d8000.i2c: Added to deferred list
>     platform e6700000.dma-controller: Added to deferred list
>
>     bus: 'platform': driver_probe_device: matched device
> e6700000.dma-controller with driver rcar-dmac
>     bus: 'platform': really_probe: probing driver rcar-dmac with
> device e6700000.dma-controller
>     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
>
>     bus: 'platform': driver_probe_device: matched device e66d8000.i2c
> with driver i2c-rcar
>     bus: 'platform': really_probe: probing driver i2c-rcar with device
> e66d8000.i2c
>
> I2C becomes available...
>
>     i2c-rcar e66d8000.i2c: request_channel failed for tx (-517)
>     [...]
>
> but DMA is not available yet, so the driver falls back to PIO.
>
>     driver: 'i2c-rcar': driver_bound: bound to device 'e66d8000.i2c'
>     bus: 'platform': really_probe: bound device e66d8000.i2c to driver i2c-rcar
>
>     platform e6700000.dma-controller: Retrying from deferred list
>     bus: 'platform': driver_probe_device: matched device
> e6700000.dma-controller with driver rcar-dmac
>     bus: 'platform': really_probe: probing driver rcar-dmac with
> device e6700000.dma-controller
>     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
>     platform e6700000.dma-controller: Added to deferred list
>     platform e6700000.dma-controller: Retrying from deferred list
>     bus: 'platform': driver_probe_device: matched device
> e6700000.dma-controller with driver rcar-dmac
>     bus: 'platform': really_probe: probing driver rcar-dmac with
> device e6700000.dma-controller
>     driver: 'rcar-dmac': driver_bound: bound to device 'e6700000.dma-controller'
>     bus: 'platform': really_probe: bound device
> e6700000.dma-controller to driver rcar-dmac
>
> DMA becomes available.
>
> Here userspace is entered. /sys/kernel/debug/dmaengine/summary shows
> that the I2C controllers do not have DMA channels allocated, as the
> kernel has performed no more I2C transfers after DMA became available.
>
> Using i2cdetect shows that DMA is used, which is good:
>
>     i2c-rcar e66d8000.i2c: got DMA channel for rx
>
> With permissive devlinks, the clock controller consumers are not added
> to the deferred probing list, and probe order is slightly different.
> The I2C controllers are still probed before the DMA controllers.
> But DMA becomes available a bit earlier, before the probing of the last
> I2C slave driver.

This seems like a race? I'm guessing it's two different threads
probing those two devices? And it just happens to work for
"permissive" assuming the boot timing doesn't change?

> Hence /sys/kernel/debug/dmaengine/summary shows that
> some I2C transfers did use DMA.
>
> So the real issue is that e66d8000.i2c not linked as a consumer to
> e6700000.dma-controller.

That's because fw_devlink.strict=1 isn't set. If you need DMA to be
treated as a mandatory supplier, you'll need to set the flag.

Is fw_devlink=on really breaking anything here? It just seems like
"permissive" got lucky with the timing and it could break at any point
in the future. Thought?

-Saravana
