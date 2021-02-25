Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E595E324CB1
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 10:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhBYJYH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 04:24:07 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44576 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbhBYJXI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Feb 2021 04:23:08 -0500
Received: by mail-ot1-f53.google.com with SMTP id f33so5017649otf.11;
        Thu, 25 Feb 2021 01:22:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qn/i3Xq3eFPWh+oxu0OZHPlZ+USKUqVpHsfRFlr5yAs=;
        b=IjQK1Jw32OSdFLTgEU6l9MEedPVJA/d+qPr8XLQR5AMYD6M8rG15HNANzI8MrVGQk5
         +O8y6xZgPMbOpvL57cZavfOKuYynpb3G6eevo5oFbMyW7EOu7oSB0KwEJwYdXQXgtcX1
         SxbsfYn3dhmejw+jM06zxA7CadUr5/WNosap5GPh4yhFtR6aVcCNnOqHaiS/7xKg+1Ba
         7LNRULq7CGLaTs7i6kY/71FY47YoPcdRXKFoY33e114hOVnKJ43EJKu+y0IxAcdqfPes
         cW5uw+LvDh/4eobtqZZdx3ryJn8VovUgAGHFhOKjEYNwC9SKM1p9epntoqc/T4xuXRLS
         OdhA==
X-Gm-Message-State: AOAM532CE1ikjqpZGszA/c85rFzeh5rjn+EL1XpdIkmLzhzWw9AWFCS7
        KtqIqCCJIavT1ojaErdNy9q2oPI1wbhZxO6aFlg=
X-Google-Smtp-Source: ABdhPJzA05EhCSKn+fa5olOgbUVwt4c5dphmMfcyJtaw5b2dV5HM2Ob4uwlqTZro9SBDH4FPxRWzTQvs6RjzGS5/u7c=
X-Received: by 2002:a05:6830:119:: with SMTP id i25mr1515253otp.107.1614244927765;
 Thu, 25 Feb 2021 01:22:07 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
 <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
 <CAGETcx_4FGa-rzLp6bjXbm4F4R6H2W78+nM_kN=XPz5hswzANA@mail.gmail.com>
 <CAMuHMdVodauqBmLMxsfi0kQtAFT8ruJ36LJL9YuQgqwQNKwHHg@mail.gmail.com>
 <CAGETcx_-yBvhXDPtOiKjenvx83oMNr32UvpMN0Dt-qz5ToXEbw@mail.gmail.com>
 <CAMuHMdXTO8wQ3=woLMjDaf9g3tTr-dRB3Nu_XvZUrr+wGSXyeg@mail.gmail.com> <CAGETcx8jXkbtdgMCr6KGT4ScoaoP=AwaW6MQeEv-gsDySiY35A@mail.gmail.com>
In-Reply-To: <CAGETcx8jXkbtdgMCr6KGT4ScoaoP=AwaW6MQeEv-gsDySiY35A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 25 Feb 2021 10:21:56 +0100
Message-ID: <CAMuHMdUVVr8jES51_8_yPoicr-nwad_2nKLYUKweY8mbxx9GJw@mail.gmail.com>
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

On Thu, Feb 18, 2021 at 12:57 AM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 16, 2021 at 12:31 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Feb 16, 2021 at 7:49 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Tue, Feb 16, 2021 at 12:05 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Feb 15, 2021 at 10:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > On Mon, Feb 15, 2021 at 4:38 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > > > > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > >       - I2C on R-Car Gen3 does not seem to use DMA, according to
> > > > > > > >         /sys/kernel/debug/dmaengine/summary:
> > > > > > > >
> > > > > > > >             -dma4chan0    | e66d8000.i2c:tx
> > > > > > > >             -dma4chan1    | e66d8000.i2c:rx
> > > > > > > >             -dma5chan0    | e6510000.i2c:tx
> > > > > > >
> > > > > > > I think I need more context on the problem before I can try to fix it.
> > > > > > > I'm also very unfamiliar with that file. With fw_devlink=permissive,
> > > > > > > I2C was using DMA? If so, the next step is to see if the I2C relative
> > > > > > > probe order with DMA is getting changed and if so, why.
> > > > > >
> > > > > > More detailed log:
> > > > > >
> > > > > >     platform e66d8000.i2c: Linked as a consumer to e6150000.clock-controller
> > > > > >     platform e66d8000.i2c: Linked as a sync state only consumer to e6055400.gpio
> > > > > >
> > > > > > Why is e66d8000.i2c not linked as a consumer to e6700000.dma-controller?
> > > > >
> > > > > Because fw_devlink.strict=1 is not set and dma/iommu is considered an
> > > > > "optional"/"driver decides" dependency.
> > > >
> > > > Oh, I thought dma/iommu were considered mandatory initially,
> > > > but dropped as dependencies in the late boot process?
> > >
> > > No, I didn't do that in case the drivers that didn't need the
> > > IOMMU/DMA were sensitive to probe order.
> > >
> > > My goal was for fw_devlink=on to not affect probe order for devices
> > > that currently don't need to defer probe. But see below...
> > >
> > > >
> > > > >
> > > > > >     platform e6700000.dma-controller: Linked as a consumer to
> > > > > > e6150000.clock-controller
> > > > >
> > > > > Is this the only supplier of dma-controller?
> > > >
> > > > No, e6180000.system-controller is also a supplier.
> > > >
> > > > > >     platform e66d8000.i2c: Added to deferred list
> > > > > >     platform e6700000.dma-controller: Added to deferred list
> > > > > >
> > > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > > e6700000.dma-controller with driver rcar-dmac
> > > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > > device e6700000.dma-controller
> > > > > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > > > > >
> > > > > >     bus: 'platform': driver_probe_device: matched device e66d8000.i2c
> > > > > > with driver i2c-rcar
> > > > > >     bus: 'platform': really_probe: probing driver i2c-rcar with device
> > > > > > e66d8000.i2c
> > > > > >
> > > > > > I2C becomes available...
> > > > > >
> > > > > >     i2c-rcar e66d8000.i2c: request_channel failed for tx (-517)
> > > > > >     [...]
> > > > > >
> > > > > > but DMA is not available yet, so the driver falls back to PIO.
> > > > > >
> > > > > >     driver: 'i2c-rcar': driver_bound: bound to device 'e66d8000.i2c'
> > > > > >     bus: 'platform': really_probe: bound device e66d8000.i2c to driver i2c-rcar
> > > > > >
> > > > > >     platform e6700000.dma-controller: Retrying from deferred list
> > > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > > e6700000.dma-controller with driver rcar-dmac
> > > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > > device e6700000.dma-controller
> > > > > >     platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
> > > > > >     platform e6700000.dma-controller: Added to deferred list
> > > > > >     platform e6700000.dma-controller: Retrying from deferred list
> > > > > >     bus: 'platform': driver_probe_device: matched device
> > > > > > e6700000.dma-controller with driver rcar-dmac
> > > > > >     bus: 'platform': really_probe: probing driver rcar-dmac with
> > > > > > device e6700000.dma-controller
> > > > > >     driver: 'rcar-dmac': driver_bound: bound to device 'e6700000.dma-controller'
> > > > > >     bus: 'platform': really_probe: bound device
> > > > > > e6700000.dma-controller to driver rcar-dmac
> > > > > >
> > > > > > DMA becomes available.
> > > > > >
> > > > > > Here userspace is entered. /sys/kernel/debug/dmaengine/summary shows
> > > > > > that the I2C controllers do not have DMA channels allocated, as the
> > > > > > kernel has performed no more I2C transfers after DMA became available.
> > > > > >
> > > > > > Using i2cdetect shows that DMA is used, which is good:
> > > > > >
> > > > > >     i2c-rcar e66d8000.i2c: got DMA channel for rx
> > > > > >
> > > > > > With permissive devlinks, the clock controller consumers are not added
> > > > > > to the deferred probing list, and probe order is slightly different.
> > > > > > The I2C controllers are still probed before the DMA controllers.
> > > > > > But DMA becomes available a bit earlier, before the probing of the last
> > > > > > I2C slave driver.
> > > > >
> > > > > This seems like a race? I'm guessing it's two different threads
> > > > > probing those two devices? And it just happens to work for
> > > > > "permissive" assuming the boot timing doesn't change?
> > > > >
> > > > > > Hence /sys/kernel/debug/dmaengine/summary shows that
> > > > > > some I2C transfers did use DMA.
> > > > > >
> > > > > > So the real issue is that e66d8000.i2c not linked as a consumer to
> > > > > > e6700000.dma-controller.
> > > > >
> > > > > That's because fw_devlink.strict=1 isn't set. If you need DMA to be
> > > > > treated as a mandatory supplier, you'll need to set the flag.
> > > > >
> > > > > Is fw_devlink=on really breaking anything here? It just seems like
> > > > > "permissive" got lucky with the timing and it could break at any point
> > > > > in the future. Thought?
> > > >
> > > > I don't think there is a race.
> > >
> > > Can you explain more please? This below makes it sound like DMA just
> > > sneaks in at the last minute.
> >
> > Yes it does, as the DMAC also has a consumer link to the IOMMU.
> > If you ignore the consumer link from I2C to DMAC, the I2C device has
> > less dependencies than the DMAC, so the I2C device, and the
> > devices on the I2C bus, are probed much earlier than the DMAC.
>
> Can you give this a shot?
> https://lore.kernel.org/lkml/20210217235130.1744843-1-saravanak@google.com/T/#u
>
> It should make sure fw_devlink doesn't add a device to the deferred
> probe list too soon and change the probe ordering unnecessarily.

(FTR, to keep all info in this thread)
Yes, this makes I2C use DMA again on Salvator-XS during kernel boot-up.
I haven't run any more elaborate tests on other platforms.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
