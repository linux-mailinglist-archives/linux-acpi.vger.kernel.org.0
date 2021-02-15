Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2756931B968
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 13:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhBOMjM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 07:39:12 -0500
Received: from mail-oo1-f41.google.com ([209.85.161.41]:36915 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhBOMjK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 07:39:10 -0500
Received: by mail-oo1-f41.google.com with SMTP id e17so1495390oow.4;
        Mon, 15 Feb 2021 04:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YakQtSEFQoUcp92B7pBu7SXNAlj7zK9R9/BYJta3QcY=;
        b=fYzbxOmHBPssdE8OpfNAVvZ3nwkzRi9LWYn9izc/3vUMrd9JZ8p7LCkghwoYcqPAlx
         eokqIYxdKOagYeI6opI6H2zeaesDNM3N/VjHWTjHrKa39bouU0CN433W5wJjanxWZuG2
         8AhqtSAIl7UUTFwpEdktYtl1H9myKKoCjNZWTvjYGmQfLndwRnJNtuU2I/Xs81V4eSH3
         jOYhbzlmmhrU2qG+MO3UWLcIdBhBJzakASxvBFccF33L5aU82lSK78RAXxIG25toDC8T
         /8QL8HfQmNuItwC2J5BxOFUpHAQ0KPeWDxDHx6PvPVPttUmQHDbsvSyZiE8RlEUL3GmN
         ZTmQ==
X-Gm-Message-State: AOAM532S1139ilrF6reLvhj065dwYkR+goL0YUZDverx1DeoRXhtUexg
        DVJAzcaGXNZ4hKNmQE7vJ9ETuXyo3LhVfODmohY=
X-Google-Smtp-Source: ABdhPJzsOaXkky53goutSDt4s3Qrndo6ZxhMZ+k2llX7tHWrnfhh68oTGJsqDIbrVVqlcPFpeGNGsoMWNtvUxybCm7w=
X-Received: by 2002:a4a:3bcb:: with SMTP id s194mr10782339oos.1.1613392708214;
 Mon, 15 Feb 2021 04:38:28 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com> <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
In-Reply-To: <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Feb 2021 13:38:16 +0100
Message-ID: <CAMuHMdXduvBqjAqraXkEKErNJFyN6JNq5wqagc4yHHPpH5SPGQ@mail.gmail.com>
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

More detailed log:

    platform e66d8000.i2c: Linked as a consumer to e6150000.clock-controller
    platform e66d8000.i2c: Linked as a sync state only consumer to e6055400.gpio

Why is e66d8000.i2c not linked as a consumer to e6700000.dma-controller?

    platform e6700000.dma-controller: Linked as a consumer to
e6150000.clock-controller
    platform e66d8000.i2c: Added to deferred list
    platform e6700000.dma-controller: Added to deferred list

    bus: 'platform': driver_probe_device: matched device
e6700000.dma-controller with driver rcar-dmac
    bus: 'platform': really_probe: probing driver rcar-dmac with
device e6700000.dma-controller
    platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral

    bus: 'platform': driver_probe_device: matched device e66d8000.i2c
with driver i2c-rcar
    bus: 'platform': really_probe: probing driver i2c-rcar with device
e66d8000.i2c

I2C becomes available...

    i2c-rcar e66d8000.i2c: request_channel failed for tx (-517)
    [...]

but DMA is not available yet, so the driver falls back to PIO.

    driver: 'i2c-rcar': driver_bound: bound to device 'e66d8000.i2c'
    bus: 'platform': really_probe: bound device e66d8000.i2c to driver i2c-rcar

    platform e6700000.dma-controller: Retrying from deferred list
    bus: 'platform': driver_probe_device: matched device
e6700000.dma-controller with driver rcar-dmac
    bus: 'platform': really_probe: probing driver rcar-dmac with
device e6700000.dma-controller
    platform e6700000.dma-controller: Driver rcar-dmac requests probe deferral
    platform e6700000.dma-controller: Added to deferred list
    platform e6700000.dma-controller: Retrying from deferred list
    bus: 'platform': driver_probe_device: matched device
e6700000.dma-controller with driver rcar-dmac
    bus: 'platform': really_probe: probing driver rcar-dmac with
device e6700000.dma-controller
    driver: 'rcar-dmac': driver_bound: bound to device 'e6700000.dma-controller'
    bus: 'platform': really_probe: bound device
e6700000.dma-controller to driver rcar-dmac

DMA becomes available.

Here userspace is entered. /sys/kernel/debug/dmaengine/summary shows
that the I2C controllers do not have DMA channels allocated, as the
kernel has performed no more I2C transfers after DMA became available.

Using i2cdetect shows that DMA is used, which is good:

    i2c-rcar e66d8000.i2c: got DMA channel for rx

With permissive devlinks, the clock controller consumers are not added
to the deferred probing list, and probe order is slightly different.
The I2C controllers are still probed before the DMA controllers.
But DMA becomes available a bit earlier, before the probing of the last
I2C slave driver.  Hence /sys/kernel/debug/dmaengine/summary shows that
some I2C transfers did use DMA.

So the real issue is that e66d8000.i2c not linked as a consumer to
e6700000.dma-controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
