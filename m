Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164E91FFE6C
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Jun 2020 01:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgFRXBQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Jun 2020 19:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbgFRXBL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 18 Jun 2020 19:01:11 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19C6C0613EF
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jun 2020 16:01:10 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id v3so1529605oot.1
        for <linux-acpi@vger.kernel.org>; Thu, 18 Jun 2020 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yc8mFXvH9+bvXdPbuCrBKeuEjVF5zsJFmzpNjkxHWMo=;
        b=F6Qzk43n9hOMr0F4NODTytpPzKoJejgC53DX0hNIAani5BvakYsEg5BYejBSfJJRFK
         Xveb1M2471hR5+hXD0nrRKJPWetO+Sm9CXdnLQ/354Jwx2+SAROf9zcH9nOj1f4r2BmG
         4OhP4aiWNVP3N1Z3PnwsXKCCcwprjP/r7yknNF074Mqx5ocK34Qoz+i0yhVtZqSNZl8E
         IbSthlYnPjQ4Ifcop0/QphEEIYcIl9WJqyKdM1ZE+wTYMUHzs/utKyK0LIdSCWoIkVRg
         TFlIL6ILcD4OJudkIbjNqm5Ppsq4BTPCwfwbR9kT+/5+LeKmP6bHS9Q4Wvj+BLy2p9Uj
         P1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yc8mFXvH9+bvXdPbuCrBKeuEjVF5zsJFmzpNjkxHWMo=;
        b=iKdVErMkhzvESZZo2JmhADLSy3kR0YBaRbAsIaCM1/VZ/5hoUn9m1hcZkoBJoCeIYc
         zavFGP3QL76FyPb3ZaHrCpGQm4JouGgyjyVTKwIsuMs8bQepe31GmonLkIKzEkwvGOtG
         NAhDl4rYtG5u7cIaW7/A8I6jw/3Agn5cn52vrd0n8gS+oSde23s/G0ZIl8X19QPGiCHb
         3IdG0Gav2eavwyb5Ai5zMVqzzuEdQFVTJ1Ufmsy13eIC6QjRYmqX5eowThOAcjXrUauB
         EP7eI1qci3xjbHF85coYGOgFzmQ7gpphgfiq4K2F363mWL4F0CVCrXIoxv7sckefU5tG
         8zvQ==
X-Gm-Message-State: AOAM531H9zt6QvJDkzNjdHhI+eNzPf+c5B5/TYg9L6o/rlNQd6F5bWVd
        tKMNjJY9dBvqWaAjTWj3FAjZWGBID9JuILVF1qxC9g==
X-Google-Smtp-Source: ABdhPJze5y3/R2DKImLZ7iiLzxaS6HhogUtDTZ6f6c1zd9yAOujkemUlEPJ8VwbBuyiv/TUaV+zXkBMoEOzKC1JUTAg=
X-Received: by 2002:a4a:7ac2:: with SMTP id a185mr1035246ooc.84.1592521269356;
 Thu, 18 Jun 2020 16:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200515053500.215929-1-saravanak@google.com> <20200515053500.215929-5-saravanak@google.com>
 <CAMuHMdUnbDvn6GdK51MN-+5iRp6zYRf-yzKY+OwcQOGrYqOZPA@mail.gmail.com>
 <CAGETcx9JKbNQWQwNah7pO5ppVSAe86R-OmMujZPYNkuTCLwKnQ@mail.gmail.com> <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
In-Reply-To: <CAMuHMdU2gF=aTeVxRvtzAMLGY=GyBDfBwrYZxoRkL1tV7dL56g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 18 Jun 2020 16:00:33 -0700
Message-ID: <CAGETcx-rHFthf-aLb_S-ST6Evozvgis5XX5u0LNxyvfMoJOLKQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] of: platform: Batch fwnode parsing when adding all
 top level devices
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ji Luo <ji.luo@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jun 18, 2020 at 12:32 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Jun 17, 2020 at 8:36 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Wed, Jun 17, 2020 at 5:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, May 15, 2020 at 7:38 AM Saravana Kannan <saravanak@google.com> wrote:
> > > > The fw_devlink_pause() and fw_devlink_resume() APIs allow batching the
> > > > parsing of the device tree nodes when a lot of devices are added. This
> > > > will significantly cut down parsing time (as much a 1 second on some
> > > > systems). So, use them when adding devices for all the top level device
> > > > tree nodes in a system.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > >
> > > This is now commit 93d2e4322aa74c1a ("of: platform: Batch fwnode parsing
> > > when adding all top level devices") in v5.8-rc1, and I have bisected a
> > > regression to it: on r8a7740/armadillo and sh73a0/kzm9g, the system can
> > > no longer be woken up from s2ram by a GPIO key. Reverting the commit
> > > fixes the issue.
> > >
> > > On these systems, the GPIO/PFC block has its interrupt lines connected
> > > to intermediate interrupt controllers (Renesas INTC), which are in turn
> > > connected to the main interrupt controller (ARM GIC).  The INTC block is
> > > part of a power and clock domain.  Hence if a GPIO is enabled as a
> > > wake-up source, the INTC is part of the wake-up path, and thus must be
> > > kept enabled when entering s2ram.
> > >
> > > While this commit has no impact on probe order for me (unlike in Marek's
> > > case), it does have an impact on suspend order:
> > >   - Before this commit:
> > >       1. The keyboard (gpio-keys) is suspended, and calls
> > >          enable_irq_wake() to inform the upstream interrupt controller
> > >          (INTC) that it is part of the wake-up path,
> > >       2. INTC is suspended, and calls device_set_wakeup_path() to inform
> > >          the device core that it must be kept enabled,
> > >       3. The system is woken by pressing a wake-up key.
> > >
> > >   - After this commit:
> > >       1. INTC is suspended, and is not aware it is part of the wake-up
> > >          path, so it is disabled by the device core,
> > >       2. gpio-keys is suspended, and calls enable_irq_wake() in vain,
> > >       3. Pressing a wake-up key has no effect, as INTC is disabled, and
> > >          the interrupt does not come through.
> > >
> > > It looks like no device links are involved, as both gpio-keys and INTC have
> > > no links.
> > > Do you have a clue?
> > >
> > > Thanks!
> >
> > That patch of mine defers probe on all devices added by the
> > of_platform_default_populate() call, and then once the call returns,
> > it immediately triggers a deferred probe.
> >
> > So all these devices are being probed in parallel in the deferred
> > probe workqueue while the main "initcall thread" continues down to
> > further initcalls. It looks like some of the drivers in subsequent
> > initcalls are assuming that devices in the earlier initcalls always
> > probe and can't be deferred?
> >
> > There are two options.
> > 1. Fix these drivers.
> > 2. Add a "flush deferred workqueue" in fw_devlink_resume()
> >
> > I'd rather we fix the drivers so that they handle deferred probes
> > correctly. Thoughts?
>
> While the affected drivers should handle deferred probe fine, none of
> the affected drivers is subject to deferred probing: they all probe
> successfully on first try (I had added debug prints to
> platform_drv_probe() to be sure).
> The affected drivers are still probed in the same order (INTC is one of
> the earliest drivers probed, gpio-keys is the last).

Thanks, this is useful info. Now I know that my patch isn't somehow
reordering devices that would have probed as soon as
of_platform_default_populate_init() added them.

When you say the "The affected drivers are still probed in the same
order", are you only referring to the devices that would have probed
before of_platform_default_populate_init() returns? Or ALL devices in
the system are probing in the same order?

I assume gpio-keys gets probed in the "normal init thread" and not by
the deferred probe workqueue? I'm guessing this because gpio_keys
driver seems to register during late_initcall() whereas
of_platform_default_populate_init() runs as an arch_initcall_sync().

> However, during
> system suspend, gpio-keys is suspended before INTC, which is wrong, as
> gpio-keys uses an interrupt provided by INTC.
>
> Perhaps the "in parallel" is the real culprit, and there is a race
> condition somewhere?

I tried digging into the gpio_keys driver code to see how it interacts
with INTC and if gpio-keys defers probe if INTC hasn't probed yet. But
it seems like a rabbit hole that'd be easier to figure out when you
have the device. Can you check if gpio-keys is probing before INTC in
the "bad" case?

Also, in general, can you see if there's a difference in the probe
order between all the devices in the system? Adding a log to
really_probe() would be better in case non-platform devices are
getting reordered (my change affects all devices that are created from
DT, not just platform devices).

I want to make sure we understand the real issue before we try to fix it.

Thanks,
Saravana
