Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986F730C9E0
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 19:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhBBSbe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 13:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238698AbhBBS33 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 13:29:29 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078DBC0617A9
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 10:28:48 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id s61so18115850ybi.4
        for <linux-acpi@vger.kernel.org>; Tue, 02 Feb 2021 10:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lNJbMXdW5NhHjyCId8HTqd13CNsq/Z1nn+1X4OrWEfw=;
        b=G4bS+HtEVOYuA7OOzdnpQ/V32sCFCZ18daV1mH17GoydeQwgUsittgg63qpXUrVy6R
         UjBz9ydicELIrB/h49LrQyds0I3p3jK6779AjQrjh55dbRDCBxI+XUhlCVgloKrHxTq3
         t2Ihd6qUZPG4w2Z5bjscgkKILXQBfwRRfXToiliDvOrAzZdBIPeALDn765Ui8i9Aomrh
         gmGyjY9aNLQJ3XrPqYGLaa1LXgSuFULtt/udI3V8dbSP9g5tvQSQIiZmFZ/9BG3oIulj
         PTWEZQkNqaB/Kz3joOqRb+7NVGjMbl1oGXGvalX8sxCNiCP484H72xGwxVOcDsXYRklI
         2jjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lNJbMXdW5NhHjyCId8HTqd13CNsq/Z1nn+1X4OrWEfw=;
        b=KnyxrShy/Ke7GWrKSjIyXYafX0jHQsVCPSAJ4np06CAYrD9TjztwVhVmAsbtEtMkGi
         2NAy039X4BsB4M6I1b6Czb7iXSZ2ss1Hq7PR9Vxk2EkMieZg5INNddGw+sH2yQuhwuQu
         q0f2hooPsOUA8651FQaIkUjp4f0faCdlIbvyV5yZhjc2bVBeE/RWLT+5gfMx17yUrRbr
         KeJ0RyQ7gZxYyNwTRXkjy8cjTCzOd4FBPIdPFLT6yETDs/n66Ji/M7u76UWNn5TDc3bY
         Ql2ttzJtUJC8peyDc2kSmQDmiLvW9lmaauO0xORyjliutAaMFCf54yIAKoisd+3c0TnH
         2Mow==
X-Gm-Message-State: AOAM5302FselhpvIrM6Bt/QegqiigqtVP2yCT0iUi8FeEpWhDS7cULGy
        TZbBekcdxSxrK2S+r5zz7v3ZQmr3cSufjX+kQWnWUg==
X-Google-Smtp-Source: ABdhPJzw4AXagK88h3IvA01AciBUdKDaE3KyCS8Lz/IMvU52NU66GWMWXgJ7wvKfGw+PVx8X1AL4krqmBRohWpAIHck=
X-Received: by 2002:a25:c683:: with SMTP id k125mr36522770ybf.32.1612290528066;
 Tue, 02 Feb 2021 10:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com>
 <cb6edbd0-346b-0674-5b5c-7ce3a437736d@microchip.com> <CAL_JsqKa5tHsKpOzkTjoiyQSJ+Q7_JOhkZ1m5tnOHK8dDGP7uA@mail.gmail.com>
In-Reply-To: <CAL_JsqKa5tHsKpOzkTjoiyQSJ+Q7_JOhkZ1m5tnOHK8dDGP7uA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Feb 2021 10:28:11 -0800
Message-ID: <CAGETcx9w5mnPzB=+xgApNiDkAup4+4Axi3P+H51t82RK2oAbhw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 2, 2021 at 9:41 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Feb 2, 2021 at 10:52 AM <Tudor.Ambarus@microchip.com> wrote:
> >
> > Hi, Saravana,
> >
> > On 2/2/21 6:33 AM, Saravana Kannan wrote:
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > This patch series solves two general issues with fw_devlink=on
> > >
> > > Patch 1/3 and 3/3 addresses the issue of firmware nodes that look like
> > > they'll have struct devices created for them, but will never actually
> > > have struct devices added for them. For example, DT nodes with a
> > > compatible property that don't have devices added for them.
> > >
> > > Patch 2/2 address (for static kernels) the issue of optional suppliers
> > > that'll never have a driver registered for them. So, if the device could
> > > have probed with fw_devlink=permissive with a static kernel, this patch
> > > should allow those devices to probe with a fw_devlink=on. This doesn't
> > > solve it for the case where modules are enabled because there's no way
> > > to tell if a driver will never be registered or it's just about to be
> > > registered. I have some other ideas for that, but it'll have to come
> > > later thinking about it a bit.
> > >
> > > Marek, Geert,
> > >
> > > I don't expect v2 to do any better for your cases.
> > >
> > > This series not making any difference for Marek is still a mystery to
> > > me. I guess one of the consumers doesn't take too well to its probe (and
> > > it's consumers' probe) being delayed till late_initcall(). I'll continue
> > > looking into it.
> > >
> > > Marc,
> > >
> > > This v2 should do better than v1 with gpiolib stub driver reverted. I
> > > forgot to take care of the case where more suppliers could link after I
> > > went and deleted some of the links. v2 handles that now.
> > >
> > > Tudor,
> > >
> > > You should still make the clock driver fix (because it's a bug), but I
> > > think this series will fix your issue too (even without the clock driver
> > > fix). Can you please give this a shot?
> > >
> >
> > Did the following tests (using sama5_defconfig and at91-sama5d2_xplained.dts):
> > 1/ modular kernel with your v2 on top of next-20210202, and without the clock
> > driver fix: the problem persists.
> >
> > 2/ static kernel with your v2 on top of next-20210202, and without the clock
> > driver fix: the problem persists. Comparing to the previous test, I see that
> > the links to pmc are dropped. I can see the following only with early printk
> > enabled:
> > platform fc008000.serial: Dropping the link to f0014000.pmc
> > But later on, the serial still gets deferred waiting for the dma controller
> > this time:
> > platform f8020000.serial: probe deferral - supplier f0010000.dma-controller not ready
> > I'll check what happens in the dma-controller.
>
> Not sure if it's the case here, but some serial drivers use DMA only
> when available and decide that on open() rather than probe. How is
> devlinks going to deal with that?

That's kinda what I'm trying to work out here :) but in a more generic fashion.

-Saravana
