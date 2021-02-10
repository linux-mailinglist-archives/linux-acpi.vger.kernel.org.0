Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C36A3160F0
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Feb 2021 09:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhBJI1K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 10 Feb 2021 03:27:10 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42596 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbhBJI0W (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 10 Feb 2021 03:26:22 -0500
Received: by mail-oi1-f169.google.com with SMTP id u66so1137800oig.9;
        Wed, 10 Feb 2021 00:26:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGjLISWJ+fszvKmcvo2/oB8kqSJgVo4mq+414YKd0ak=;
        b=tTM6x9WvBKj6CCIlz5RGq1bETqJFXJYJAyrAXjmBzr16syAZxbUCQOGezwW2g727mV
         w614B9nQnvXZ8OYELXXA+2fURs4cGDkRsj/f66PXoqNUY5tY8ZpgyahSXVf8kBX0L/sE
         WDjWyDtsCnZofUMxrngqtSJ2clsWhMoo+KtFahwp8HtKKFJiaA/MhFZb+gkY7qLNnHzs
         oLjEvT1FJW58acYBABkf7kLGPUpra3CoZtS+Ul8ViCMgUNv/4hzy3yRVOXff/MuTvPPd
         wVBu46NiyjJc3trNDdKRUYqvPe3wVCdyXiay6CbPlbN/K/EHZ2Bi9E8+uurDFardRwmZ
         /j4g==
X-Gm-Message-State: AOAM530czFG4/8pl89E0IAj34w1s5I0BFI7K9LTibSdoee0QrQpUkjP1
        JT9cbPZ8rztGkspJ0aSdxBnTfklbLzCSp3+DHaE=
X-Google-Smtp-Source: ABdhPJw76RbbTdIjOWOYdNuMSRd5sBeR2j0014yZb4MdeOrBQA1HjGlwkbMtEPnZoE9rsvsL6sEmWZSBR33/719FBhk=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr1277055oiy.148.1612945537621;
 Wed, 10 Feb 2021 00:25:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-5-saravanak@google.com> <20210209213320.GA219007@robh.at.kernel.org>
 <CAGETcx_gHRd9UYHvSsHX_=NFF+HEJkamJp3JcpojuJob_a8_DA@mail.gmail.com>
In-Reply-To: <CAGETcx_gHRd9UYHvSsHX_=NFF+HEJkamJp3JcpojuJob_a8_DA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 10 Feb 2021 09:25:26 +0100
Message-ID: <CAMuHMdXi9s_b0xjaQ3n_-qFfdwfBtxnrhYfVuRENJM5UJ9TUwg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] of: property: Add fw_devlink support for optional properties
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

CC iommu

On Tue, Feb 9, 2021 at 10:55 PM Saravana Kannan <saravanak@google.com> wrote:
> On Tue, Feb 9, 2021 at 1:33 PM Rob Herring <robh@kernel.org> wrote:
> > On Fri, Feb 05, 2021 at 02:26:40PM -0800, Saravana Kannan wrote:
> > > Not all DT bindings are mandatory bindings. Add support for optional DT
> > > bindings and mark iommus, iommu-map, dmas as optional DT bindings.
> >
> > I don't think we can say these are optional or not. It's got to be a
> > driver decision somehow.
>
> Right, so maybe the word "optional" isn't a good name for it. I can
> change that if you want.
>
> The point being, fw_devlink can't block the probe of this driver based
> on iommu property. We let the driver decide if it wants to
> -EPROBE_DEFER or not or however it wants to handle this.

The driver cannot make that decision, cfr. below.

> > For example, if IOMMU is optional, what happens with this sequence:
> >
> > driver probes without IOMMU
> > driver calls dma_map_?()
> > IOMMU driver probes
> > h/w accesses DMA buffer --> BOOM!

Does it really behave that way? Or does it continue without IOMMU?

> Right. But how is this really related to fw_devlink? AFAICT, this is
> an issue even today. If the driver needs the IOMMU, then it needs to
> make sure the IOMMU has probed? What am I missing?

Individual I/O (IOMMU slave) drivers are completely unaware of the
presence or absence of an IOMMU; they just use the DMA API, which is the
same regardless of an IOMMU being used or not.
While for GPIO/IRQ/CLK/DMA/... have request/get_{gpio,irq,clk,dma,...}
APIs for a driver to get a reference, which can return -EPROBE_DEFER, no
such thing exists for IOMMUs.  This is handled by the IOMMU core
instead.

Using the IOMMU or not is more like a system policy decision.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
