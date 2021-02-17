Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34831E353
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Feb 2021 00:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBQX6i (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Feb 2021 18:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhBQX6g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2021 18:58:36 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E943FC061786
        for <linux-acpi@vger.kernel.org>; Wed, 17 Feb 2021 15:57:55 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id n195so392666ybg.9
        for <linux-acpi@vger.kernel.org>; Wed, 17 Feb 2021 15:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gyyd+fg6rE1jikDjwjComYSD9NHlv04HXSqrgjKmU18=;
        b=g74HmmdJSYKVCHRbytSRkHgd4z3jdETXm4uDfSzCa6DrvZZX/JtQKKxBIabrkWOhUx
         JzLhYIdmK9+4a+TIIIpgQpcTPa10bFzsd5Obcs+85Zd2729d+a79LfumiVXstLdfaFeX
         3PmgDObTOtKT2+StqbGtYMqk/V2b7H2RjvrEJZE8xbEFQvimTrlbT1Juz9HtX3utvtrx
         2tMaWKn9BEQ2GIPCsLDcVVnRIXv31H00A2I2ET5OzWRD0nJe1PzwB1JZPL3YCssCVygf
         7HuR5fDQf9DNuu2M8Ow1OdqHHmgf9NFSWIRYWIqVn9YTIynb5OGRcisVQcnO3WBoRasl
         1T+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyyd+fg6rE1jikDjwjComYSD9NHlv04HXSqrgjKmU18=;
        b=X5aq806Me9ZyGZ/M6TkguKyaPBQxvwf0EEo0GFeGTiN4QDEGwjHgK/ZrV6W0GRF2+9
         RkCX55rWkEaGgz1CZaD4b5ZO1Q9zuz6mMXLoMXzC9olmECQUMlmDU9YO7ZIPpb/8kbfk
         cj4C+N4HrdMLLfHVvWtycL7sEkMxSe4OJu3lW1KuMBPPfb+k9Xi2lk/jo03NgwuvxwY8
         N0EOq/m5fa/mf8r+Jk1xfZZKdbpogXl7uZuud+75+sc2Ku9hdbC3IQhEK82oBPGtk0X/
         WmXPqsW7/wfF6MKDrya9B4d2tNZNC7R+l5IH17JVL34GeX/wqi22X6p9zek2JRcMvHjx
         3sXw==
X-Gm-Message-State: AOAM53115eus7/u3vEHySPhRNj54/XeaGk7fSdeqYdijzJsBijoj5Lpd
        92jw41DnPXO2H2hfTcIu05OsHk7CSnrJ29+yXj2SNw==
X-Google-Smtp-Source: ABdhPJyOSQa4Jj9rh8MYWVVAqAFPqUPnVtB1UzPtZJ/GyByZHitchaJCswelIanrPLQJ+P5TzrwtxVaA8GlnZr7rWrE=
X-Received: by 2002:a25:8b8b:: with SMTP id j11mr2655973ybl.310.1613606274746;
 Wed, 17 Feb 2021 15:57:54 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
 <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
 <CAGETcx_4FGa-rzLp6bjXbm4F4R6H2W78+nM_kN=XPz5hswzANA@mail.gmail.com>
 <CAMuHMdVodauqBmLMxsfi0kQtAFT8ruJ36LJL9YuQgqwQNKwHHg@mail.gmail.com>
 <CAGETcx_-yBvhXDPtOiKjenvx83oMNr32UvpMN0Dt-qz5ToXEbw@mail.gmail.com> <CAMuHMdXTO8wQ3=woLMjDaf9g3tTr-dRB3Nu_XvZUrr+wGSXyeg@mail.gmail.com>
In-Reply-To: <CAMuHMdXTO8wQ3=woLMjDaf9g3tTr-dRB3Nu_XvZUrr+wGSXyeg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 17 Feb 2021 15:57:18 -0800
Message-ID: <CAGETcx8jXkbtdgMCr6KGT4ScoaoP=AwaW6MQeEv-gsDySiY35A@mail.gmail.com>
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

On Tue, Feb 16, 2021 at 12:31 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Tue, Feb 16, 2021 at 7:49 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Tue, Feb 16, 2021 at 12:05 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Mon, Feb 15, 2021 at 10:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > On Mon, Feb 15, 2021 at 4:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > >       - I2C on R-Car Gen3 does not seem to use DMA, according to
> > > > > > >         /sys/kernel/debug/dmaengine/summary:
> > > > > > >
> > > > > > >             -dma4chan0    | e66d8000.i2c:tx
> > > > > > >             -dma4chan1    | e66d8000.i2c:rx
> > > > > > >             -dma5chan0    | e6510000.i2c:tx
> > > > > >
> > > > > > I think I need more context on the problem before I can try to fix it.
> > > > > > I'm also very unfamiliar with that file. With fw_devlink=permissive,
> > > > > > I2C was using DMA? If so, the next step is to see if the I2C relative
> > > > > > probe order with DMA is getting changed and if so, why.
> > > > >
> > > > > More detailed log:
> > > > >
> > > > >     platform e66d8000.i2c: Linked as a consumer to e6150000.clock-controller
> > > > >     platform e66d8000.i2c: Linked as a sync state only consumer to e6055400.gpio
> > > > >
> > > > > Why is e66d8000.i2c not linked as a consumer to e6700000.dma-controller?
> > > >
> > > > Because fw_devlink.strict=1 is not set and dma/iommu is considered an
> > > > "optional"/"driver decides" dependency.
> > >
> > > Oh, I thought dma/iommu were considered mandatory initially,
> > > but dropped as dependencies in the late boot process?
> >
> > No, I didn't do that in case the drivers that didn't need the
> > IOMMU/DMA were sensitive to probe order.
> >
> > My goal was for fw_devlink=on to not affect probe order for devices
> > that currently don't need to defer probe. But see below...
> >
> > >
> > > >
> > > > >     platform e6700000.dma-controller: Linked as a consumer to
> > > > > e6150000.clock-controller
> > > >
> > > > Is this the only supplier of dma-controller?
> > >
> > > No, e6180000.system-controller is also a supplier.
> > >
> > > > >     platform e66d8000.i2c: Added to deferred list
> > > > >     platform e6700000.dma-controller: Added to deferred list
> > > > >
> > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > e6700000.dma-controller with driver rcar-dmac
> > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > device e6700000.dma-controller
> > > > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > > > >
> > > > >     bus: 'platform': driver_probe_device: matched device e66d8000.i2c
> > > > > with driver i2c-rcar
> > > > >     bus: 'platform': really_probe: probing driver i2c-rcar with device
> > > > > e66d8000.i2c
> > > > >
> > > > > I2C becomes available...
> > > > >
> > > > >     i2c-rcar e66d8000.i2c: request_channel failed for tx (-517)
> > > > >     [...]
> > > > >
> > > > > but DMA is not available yet, so the driver falls back to PIO.
> > > > >
> > > > >     driver: 'i2c-rcar': driver_bound: bound to device 'e66d8000.i2c'
> > > > >     bus: 'platform': really_probe: bound device e66d8000.i2c to driver i2c-rcar
> > > > >
> > > > >     platform e6700000.dma-controller: Retrying from deferred list
> > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > e6700000.dma-controller with driver rcar-dmac
> > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > device e6700000.dma-controller
> > > > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > > > >     platform e6700000.dma-controller: Added to deferred list
> > > > >     platform e6700000.dma-controller: Retrying from deferred list
> > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > e6700000.dma-controller with driver rcar-dmac
> > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > device e6700000.dma-controller
> > > > >     driver: 'rcar-dmac': driver_bound: bound to device 'e6700000.dma-controller'
> > > > >     bus: 'platform': really_probe: bound device
> > > > > e6700000.dma-controller to driver rcar-dmac
> > > > >
> > > > > DMA becomes available.
> > > > >
> > > > > Here userspace is entered. /sys/kernel/debug/dmaengine/summary shows
> > > > > that the I2C controllers do not have DMA channels allocated, as the
> > > > > kernel has performed no more I2C transfers after DMA became available.
> > > > >
> > > > > Using i2cdetect shows that DMA is used, which is good:
> > > > >
> > > > >     i2c-rcar e66d8000.i2c: got DMA channel for rx
> > > > >
> > > > > With permissive devlinks, the clock controller consumers are not added
> > > > > to the deferred probing list, and probe order is slightly different.
> > > > > The I2C controllers are still probed before the DMA controllers.
> > > > > But DMA becomes available a bit earlier, before the probing of the last
> > > > > I2C slave driver.
> > > >
> > > > This seems like a race? I'm guessing it's two different threads
> > > > probing those two devices? And it just happens to work for
> > > > "permissive" assuming the boot timing doesn't change?
> > > >
> > > > > Hence /sys/kernel/debug/dmaengine/summary shows that
> > > > > some I2C transfers did use DMA.
> > > > >
> > > > > So the real issue is that e66d8000.i2c not linked as a consumer to
> > > > > e6700000.dma-controller.
> > > >
> > > > That's because fw_devlink.strict=1 isn't set. If you need DMA to be
> > > > treated as a mandatory supplier, you'll need to set the flag.
> > > >
> > > > Is fw_devlink=on really breaking anything here? It just seems like
> > > > "permissive" got lucky with the timing and it could break at any point
> > > > in the future. Thought?
> > >
> > > I don't think there is a race.
> >
> > Can you explain more please? This below makes it sound like DMA just
> > sneaks in at the last minute.
>
> Yes it does, as the DMAC also has a consumer link to the IOMMU.
> If you ignore the consumer link from I2C to DMAC, the I2C device has
> less dependencies than the DMAC, so the I2C device, and the
> devices on the I2C bus, are probed much earlier than the DMAC.

Can you give this a shot?
https://lore.kernel.org/lkml/20210217235130.1744843-1-saravanak@google.com/T/#u

It should make sure fw_devlink doesn't add a device to the deferred
probe list too soon and change the probe ordering unnecessarily.

-Saravana
