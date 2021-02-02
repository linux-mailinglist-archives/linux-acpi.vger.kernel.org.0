Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B50830C82B
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237633AbhBBRno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 12:43:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237750AbhBBRmF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 2 Feb 2021 12:42:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3559864F5F;
        Tue,  2 Feb 2021 17:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612287683;
        bh=XrqQUpQjK2B6Gy7MUmqLIy6ph4nA8RzfeE8HGNIUfNc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dknAJxgPhZ8OA5JCBRRCYStwLbZYN7Dm8Kyj4lWnbR+mNZkDbjGO3g2QEkTg/8hrt
         h/aZm0FtNwnF4EjexKOs3cDon7oWnaXvDwMDMqevnnme+IcuHmn0lNNzZAzUe+u2Qo
         MWc2d+/fH72UOZozQ/+wNyr0XkjxKncMMVmg00BQIx6NSGL5tynfaEOD6G2ddV9+JD
         SEAOVDboLbpuPsRJZUCIVWKwSVUsMcA8yFg+cE6JAd3izAMjkSByrqK/+hDwdgmaoK
         l6Me7J1kOdOF59yKRtqXe6IaAepk/yARBLZF5nXF9bDYxmTHP1GPXexD1/3gpkRljD
         8QnmVGbJFNDcQ==
Received: by mail-ej1-f45.google.com with SMTP id a9so12890158ejr.2;
        Tue, 02 Feb 2021 09:41:23 -0800 (PST)
X-Gm-Message-State: AOAM530ka2qXaOPzqNxZhGe4I8NIydeLyWi5eAMV+bCgQRn/3qDVfKrQ
        yqMbAgikNMn6GJrlMGaqfrfSRYmfIHvwQMYZRw==
X-Google-Smtp-Source: ABdhPJy7qlQzOEBJFERevS2s5A+17Y7LWXKTGTcLN/aIJ+lDn4tB+n0QfADEErfdMqiE4vPYS8qSp9wXnwGuOy+rUg0=
X-Received: by 2002:a17:907:16a2:: with SMTP id hc34mr4934241ejc.108.1612287681717;
 Tue, 02 Feb 2021 09:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <cb6edbd0-346b-0674-5b5c-7ce3a437736d@microchip.com>
In-Reply-To: <cb6edbd0-346b-0674-5b5c-7ce3a437736d@microchip.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Feb 2021 11:41:09 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKa5tHsKpOzkTjoiyQSJ+Q7_JOhkZ1m5tnOHK8dDGP7uA@mail.gmail.com>
Message-ID: <CAL_JsqKa5tHsKpOzkTjoiyQSJ+Q7_JOhkZ1m5tnOHK8dDGP7uA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 10:52 AM <Tudor.Ambarus@microchip.com> wrote:
>
> Hi, Saravana,
>
> On 2/2/21 6:33 AM, Saravana Kannan wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > This patch series solves two general issues with fw_devlink=on
> >
> > Patch 1/3 and 3/3 addresses the issue of firmware nodes that look like
> > they'll have struct devices created for them, but will never actually
> > have struct devices added for them. For example, DT nodes with a
> > compatible property that don't have devices added for them.
> >
> > Patch 2/2 address (for static kernels) the issue of optional suppliers
> > that'll never have a driver registered for them. So, if the device could
> > have probed with fw_devlink=permissive with a static kernel, this patch
> > should allow those devices to probe with a fw_devlink=on. This doesn't
> > solve it for the case where modules are enabled because there's no way
> > to tell if a driver will never be registered or it's just about to be
> > registered. I have some other ideas for that, but it'll have to come
> > later thinking about it a bit.
> >
> > Marek, Geert,
> >
> > I don't expect v2 to do any better for your cases.
> >
> > This series not making any difference for Marek is still a mystery to
> > me. I guess one of the consumers doesn't take too well to its probe (and
> > it's consumers' probe) being delayed till late_initcall(). I'll continue
> > looking into it.
> >
> > Marc,
> >
> > This v2 should do better than v1 with gpiolib stub driver reverted. I
> > forgot to take care of the case where more suppliers could link after I
> > went and deleted some of the links. v2 handles that now.
> >
> > Tudor,
> >
> > You should still make the clock driver fix (because it's a bug), but I
> > think this series will fix your issue too (even without the clock driver
> > fix). Can you please give this a shot?
> >
>
> Did the following tests (using sama5_defconfig and at91-sama5d2_xplained.dts):
> 1/ modular kernel with your v2 on top of next-20210202, and without the clock
> driver fix: the problem persists.
>
> 2/ static kernel with your v2 on top of next-20210202, and without the clock
> driver fix: the problem persists. Comparing to the previous test, I see that
> the links to pmc are dropped. I can see the following only with early printk
> enabled:
> platform fc008000.serial: Dropping the link to f0014000.pmc
> But later on, the serial still gets deferred waiting for the dma controller
> this time:
> platform f8020000.serial: probe deferral - supplier f0010000.dma-controller not ready
> I'll check what happens in the dma-controller.

Not sure if it's the case here, but some serial drivers use DMA only
when available and decide that on open() rather than probe. How is
devlinks going to deal with that?

Rob
