Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14913FF3BC
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 21:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347304AbhIBTER (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 15:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347218AbhIBTEL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Sep 2021 15:04:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F23DC610FB;
        Thu,  2 Sep 2021 19:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630609393;
        bh=qge/1wRptOM7qKmyeVs6L3b7+ZyQhTZtXGQZKA7Cg6A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Eh+I7fFVsSngU5/wMlBN8fHRhfJ/c/l8qMc6bhoXlSYRgT3jhYezpeFMm4XObvYZD
         eBY7RQuow1bJ0lZ9WlJpBweJcoJ/9CkD+BMDRlu6MBbr47C3dzMAiplcOQHV5kTbj/
         65/Giina+oK5mLj9F7IF3B495mt1hmvRhn0tJlZfM5l9n/9RsTy4xrhhJEXP06ic1O
         xN6C4Q78wELlVHJog0kOVvE6yiDsCd2Cy3cOibmu3OqjNxifsxr7NBMhcKpHptTZCf
         Ug9KXtGc7LTv9y8eXGrJvLEC8OrNLCUMxFXtN6T2evwKcdy75zche0RonQaAPUDOhX
         iK/OJKmVtQ/ZA==
Received: by mail-ej1-f45.google.com with SMTP id jg16so3618604ejc.1;
        Thu, 02 Sep 2021 12:03:12 -0700 (PDT)
X-Gm-Message-State: AOAM530yD4qqfTpA36GQEKbpsg+AYORXZj60pEFzaybub2fkseJ/JZG+
        KvDM3r7lP2XmBl0XJBEC8NJ1W4+wsmutSyJktA==
X-Google-Smtp-Source: ABdhPJw/U5UN1QoZlj+vN/kmaYOsUEshTeFwCb5cw1o8g+gkV2zt4YgSlmZ5IXTGPfZg5fFk+l3zW1htGkmNhm2b/wA=
X-Received: by 2002:a17:906:25db:: with SMTP id n27mr5327532ejb.108.1630609391487;
 Thu, 02 Sep 2021 12:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <20210902025528.1017391-3-saravanak@google.com> <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
 <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com>
In-Reply-To: <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Sep 2021 14:02:58 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com>
Message-ID: <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
To:     Saravana Kannan <saravanak@google.com>
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

On Thu, Sep 2, 2021 at 11:57 AM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Sep 2, 2021 at 7:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > We don't want fw_devlink creating device links for bus devices as
> > > they'll never probe. So mark those device node with this flag.
> > >
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/of/platform.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > index 74afbb7a4f5e..42b3936d204a 100644
> > > --- a/drivers/of/platform.c
> > > +++ b/drivers/of/platform.c
> > > @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
> > >         if (!dev || !of_match_node(matches, bus))
> > >                 return 0;
> > >
> > > +       /*
> > > +        * If the bus node has only one compatible string value and it has
> > > +        * matched as a bus node, it's never going to get probed by a device
> > > +        * driver. So flag it as such so that fw_devlink knows not to create
> > > +        * device links with this device.
> > > +        *
> > > +        * This doesn't catch all devices that'll never probe, but this is good
> > > +        * enough for now.
> > > +        *
> > > +        * This doesn't really work for PPC because of how it uses
> > > +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> > > +        */
> > > +       if (!IS_ENABLED(CONFIG_PPC) &&
> > > +           of_property_count_strings(bus, "compatible") == 1)
> > > +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
> >
> > This looks fragile relying on 1 compatible string, and the DT flags in
> > this code have been fragile too. I'm pretty sure we have cases of
> > simple-bus or simple-mfd that also have another compatible.
> >
> > Couldn't we solve this with a simple driver?
>
> Oh, I didn't think you'd like that. I'd lean towards that option too
> if we can address some of the other concerns below.
>
> > Make 'simple-pm-bus'
> > driver work for other cases?
>
> > BTW, this patch doesn't even work for
> > simple-pm-bus.
>
> How do you mean? Because simple-pm-bus already has a driver and
> doesn't set "matches" param when it calls of_platform_populate() and
> this flag won't be set. So at least for simple-pm-bus I don't see any
> issue.

You're right.

> I was trying to reuse of_default_bus_match_table without explicitly
> referring to it, but if it's confusing I can add a separate list of
> compatible strings and use those here instead of using "matches".

What happens with a non-default table? I'm not sure we can assume the
same behavior.

> > A driver for simple-bus may cause issues if there's a
> > more specific driver to bind to as we don't handle that. It's simply
> > whichever matches first.
>
> Right, this is my worry. Especially for devices like this (there are
> plenty of cases like this) which have a driver that probes them but
> also lists simple-bus
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/arm-realview-pb11mp.dts?id=73f3af7b4611d77bdaea303fb639333eb28e37d7#n299

Uhh, that one is certainly a leakage of wanting an soc_device in the
hierarchy, not any real bus structure reflecting the h/w. I'm not a
fan of the soc_device stuff and its optional nature. Everything is an
SoC, so it should always be there? Or your device hierarchy should
change when you decide to add a soc_device?

> So as long as there's a compatible string that's not one of the
> "transparent" busses, this driver shouldn't match. So, I don't think I
> can get away from checking the compatible strings.
>
> How about I check here to make sure all the "compatible" strings are
> from an approved transparent bus list, and if it's true, I use
> driver_override to force match it to a transparent bus driver? Would
> you be okay with that?

Can't we do that within a driver? We check this and fail probe if
there's a more specific compatible.  Then another driver can match and
probe.

Rob
