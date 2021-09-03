Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F583FF89B
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Sep 2021 03:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345041AbhICBRG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 21:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhICBRF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 21:17:05 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9045FC061757
        for <linux-acpi@vger.kernel.org>; Thu,  2 Sep 2021 18:16:06 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id c6so7242471ybm.10
        for <linux-acpi@vger.kernel.org>; Thu, 02 Sep 2021 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzzSuK0IRJJ8j7IjF4RHdzQ2axPaXOOKA7M5m0rjvG4=;
        b=e5OiXxTSFHEQjQnefrd/x99LbKXTdAh833OrfGOCQ4IJx8sjWgnT6FqZNL6E9aeoLS
         H7r2UMbPKOng/y7D4VBkns6QLStpI4tUdgcK6jKTUjZC7sVkZBjYbpecQmIkYIez8xfR
         bSAKvV6rIWR72aTjVju8SWZ3VQ7FUzWAZvUS3Fnc9BkzxhKTZfVi+AzFvbw9YEUP3gsQ
         FSMOG7NcNdfUU0yBWLCaUYa557a5aWPSof/+N6XPkBtNDy94oyBbKlT1rg/2gyDhvkHh
         2C1m+4RVCbWanOeavC4Ki00Xr81Q3tJvIC+Rbw/pRjsPW9aLjSozfoCx3ZRmxxWDaozm
         DM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzzSuK0IRJJ8j7IjF4RHdzQ2axPaXOOKA7M5m0rjvG4=;
        b=MOrdcs6bpKlV1EtLwG3MVx3+tCoByY19GV+Y724QfGOzWIi0kz5XFmF4vKOYoYVkuK
         1EKSXU07Wp9MM/5SLy7n9BkUbxuP8uuzssvjFFIAFWXZaT6rJaH7eTTTDD4Tpy1SG8XP
         jKaVxXcJvnnd0Bl22I0zS3zw/cMt7W38logRjM2nVmg8Jtqh+xXNCYNsOrTCfBbbbgYL
         SOOddDJHljpn+vPqbYilMju/cEpNarFWWIthrLPFZXjJbNFbcERU+LfHauFF/T4OFpFm
         ATKUnY9eYxKrju1V0worBrR9tSRPKFaTGNTdTnv5KbehvtWhOm2Ll4+OyS2+zX8wvY8Y
         od8A==
X-Gm-Message-State: AOAM532O+UPjBcgNIA8/85UIaDaV4Iqp2Kcy5bTZrPxv5JrxvNEJhlf5
        AL1XImm52mklFYs3TP5TE5TAgC5gNywgxs3nKuTkJA==
X-Google-Smtp-Source: ABdhPJyB0+MCJ+1Lweg1HySQP2EHDPqMbfR85E+lrhVlrqCo165WbBzByDRVOXVsRVNHpnV01F+ycGRc9lpELkSUc5A=
X-Received: by 2002:a25:6746:: with SMTP id b67mr1858374ybc.96.1630631765457;
 Thu, 02 Sep 2021 18:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <20210902025528.1017391-3-saravanak@google.com> <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
 <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com>
 <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com>
 <CAGETcx9wY66TsFX_1rFUO+toE-OpkAvWSdcNVK7M=LYwa6xbAw@mail.gmail.com> <CAL_JsqJzt_duSkMm43dwpiGCmqW8PAQ1n6SeyiNkECP8CTcY=g@mail.gmail.com>
In-Reply-To: <CAL_JsqJzt_duSkMm43dwpiGCmqW8PAQ1n6SeyiNkECP8CTcY=g@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 18:15:29 -0700
Message-ID: <CAGETcx-VkJXTXCwh_ctMg_-VDUb4WFxLLYt0ht8tv8yn+kCH6Q@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Sep 2, 2021 at 5:53 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 2, 2021 at 2:29 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Sep 2, 2021 at 12:03 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Thu, Sep 2, 2021 at 11:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > On Thu, Sep 2, 2021 at 7:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > > >
> > > > > > We don't want fw_devlink creating device links for bus devices as
> > > > > > they'll never probe. So mark those device node with this flag.
> > > > > >
> > > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > > ---
> > > > > >  drivers/of/platform.c | 16 ++++++++++++++++
> > > > > >  1 file changed, 16 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > > > index 74afbb7a4f5e..42b3936d204a 100644
> > > > > > --- a/drivers/of/platform.c
> > > > > > +++ b/drivers/of/platform.c
> > > > > > @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
> > > > > >         if (!dev || !of_match_node(matches, bus))
> > > > > >                 return 0;
> > > > > >
> > > > > > +       /*
> > > > > > +        * If the bus node has only one compatible string value and it has
> > > > > > +        * matched as a bus node, it's never going to get probed by a device
> > > > > > +        * driver. So flag it as such so that fw_devlink knows not to create
> > > > > > +        * device links with this device.
> > > > > > +        *
> > > > > > +        * This doesn't catch all devices that'll never probe, but this is good
> > > > > > +        * enough for now.
> > > > > > +        *
> > > > > > +        * This doesn't really work for PPC because of how it uses
> > > > > > +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> > > > > > +        */
> > > > > > +       if (!IS_ENABLED(CONFIG_PPC) &&
> > > > > > +           of_property_count_strings(bus, "compatible") == 1)
> > > > > > +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
> > > > >
> > > > > This looks fragile relying on 1 compatible string, and the DT flags in
> > > > > this code have been fragile too. I'm pretty sure we have cases of
> > > > > simple-bus or simple-mfd that also have another compatible.
> > > > >
> > > > > Couldn't we solve this with a simple driver?
> > > >
> > > > Oh, I didn't think you'd like that. I'd lean towards that option too
> > > > if we can address some of the other concerns below.
> > > >
> > > > > Make 'simple-pm-bus'
> > > > > driver work for other cases?
> > > >
> > > > > BTW, this patch doesn't even work for
> > > > > simple-pm-bus.
> > > >
> > > > How do you mean? Because simple-pm-bus already has a driver and
> > > > doesn't set "matches" param when it calls of_platform_populate() and
> > > > this flag won't be set. So at least for simple-pm-bus I don't see any
> > > > issue.
> > >
> > > You're right.
> > >
> > > > I was trying to reuse of_default_bus_match_table without explicitly
> > > > referring to it, but if it's confusing I can add a separate list of
> > > > compatible strings and use those here instead of using "matches".
> > >
> > > What happens with a non-default table? I'm not sure we can assume the
> > > same behavior.
> > >
> > > > > A driver for simple-bus may cause issues if there's a
> > > > > more specific driver to bind to as we don't handle that. It's simply
> > > > > whichever matches first.
> > > >
> > > > Right, this is my worry. Especially for devices like this (there are
> > > > plenty of cases like this) which have a driver that probes them but
> > > > also lists simple-bus
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/arm-realview-pb11mp.dts?id=73f3af7b4611d77bdaea303fb639333eb28e37d7#n299
> > >
> > > Uhh, that one is certainly a leakage of wanting an soc_device in the
> > > hierarchy, not any real bus structure reflecting the h/w. I'm not a
> > > fan of the soc_device stuff and its optional nature. Everything is an
> > > SoC, so it should always be there? Or your device hierarchy should
> > > change when you decide to add a soc_device?
> > >
> > > > So as long as there's a compatible string that's not one of the
> > > > "transparent" busses, this driver shouldn't match. So, I don't think I
> > > > can get away from checking the compatible strings.
> > > >
> > > > How about I check here to make sure all the "compatible" strings are
> > > > from an approved transparent bus list, and if it's true, I use
> > > > driver_override to force match it to a transparent bus driver? Would
> > > > you be okay with that?
> > >
> > > Can't we do that within a driver? We check this and fail probe if
> > > there's a more specific compatible.  Then another driver can match and
> > > probe.
> >
> > I was thinking that initially, but if we fail a probe, the driver core
> > will permanently give up (won't search further) or might end up
> > retrying with the same driver and never get to the other driver. I'll
> > send out a v2 with what I described above. It's not too bad and it
> > will also allow us to handle the PPC cases (we'll just need to keep
> > adding the simple-bus equivalent entries to a table).
>
> I wasn't sure, but I traced the calls and it looks like based on
> __driver_attach() that if a driver fails probe another one matching
> should get to probe:

__driver_attach() is called over every device already in a bus. It's
called only when a new driver is registered. So it makes sense that
one ignores the error returned from probe(). You don't want to fail
driver registration because one specific device needs to defer probe.

The comment is actually from __device_attach_driver()

>
>         /*
>          * Ignore errors returned by ->probe so that the next driver can try
>          * its luck.
>          */

I saw that comment too, but isn't the comment wrong/stale?

bus_probe_device() -> device_initial_probe() -> __device_attach().

In __device_attach() we have:
ret = bus_for_each_drv(dev->bus, NULL, &data, __device_attach_driver);

If you look at bus_for_each_drv()'s comment:
 * ...... If @fn returns anything but 0, we break out
 * and return it. If @start is not NULL, we use it as the head
 * of the list.

Inside __device_attach_driver() we see:
        /*
         * Ignore errors returned by ->probe so that the next driver can try
         * its luck.
         */
        ret = driver_probe_device(drv, dev);
        if (ret < 0)
                return ret;

So if probe() returned an error, we'd return it right back out. And
then bus_for_each_drv() will stop searching for more drivers that
match.

So I don't think one driver can give up after a match and have another
driver give a device a shot.

>
> The PPC case is about descending nodes without a compatible string.

That whole thing is kinda confusing, but if PPC has more "simple"
busses, they can just add to the list I'm maintaining in the v2
series.

-Saravana
