Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3825B3FF87C
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Sep 2021 02:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhICAyz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 20:54:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231161AbhICAyy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Sep 2021 20:54:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A7FB610A1;
        Fri,  3 Sep 2021 00:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630630435;
        bh=ESjKUQjilvoa8yjcHYk5EoAu/HqzJrgOoao4t51tuiw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nsSWW2fkARm1CWQfjsfE++kELQD2ttwaVF9egcUeuuj9jVYLq36tV0rz6t8wFYtRP
         2juWr+f/e1Ssr1R2giu7AnqFFxuQjkLVhSKy+2CcrNpSRx9iHohbtsILxhfWGYmBWx
         GcIvIJ4ww3t1ViFiHKBoRuJtyvt3v6UhiwYkWLByCDo/Rk5kmge/zDa7fOPn6fYso7
         JoHLMD9B21ruCSO3aXpFVPWY2FNJS8EFTVtsxob8nAnMV9lUzH4N7UcO4Nl8dfdRqI
         AyST0OPRZhX4XtC/jazwJi/QciXL4oWdNdxyvRmi7x8Qi+RIPIj23xPXbfyoYOT+wL
         NriLUtk351bVw==
Received: by mail-ej1-f53.google.com with SMTP id x11so8592405ejv.0;
        Thu, 02 Sep 2021 17:53:55 -0700 (PDT)
X-Gm-Message-State: AOAM531nvtHlTY+4UNopt7eUytx3Z10UnhkNpj0nirBY4LjZIlRuJOD4
        EZ8LGNrFC2Dr13vCQ3YAuwgMsa2Ke9L/imruMw==
X-Google-Smtp-Source: ABdhPJzgXCEgW8AMIrdDuiVErt8Lcc+lHdjEl4dO9chPIYkQnJOqKI0bLvrmBj8SJrt1vZKVVzTI79Sk1om36yhSsd4=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr1086206eje.341.1630630433827;
 Thu, 02 Sep 2021 17:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <20210902025528.1017391-3-saravanak@google.com> <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
 <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com>
 <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com> <CAGETcx9wY66TsFX_1rFUO+toE-OpkAvWSdcNVK7M=LYwa6xbAw@mail.gmail.com>
In-Reply-To: <CAGETcx9wY66TsFX_1rFUO+toE-OpkAvWSdcNVK7M=LYwa6xbAw@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Sep 2021 19:53:42 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJzt_duSkMm43dwpiGCmqW8PAQ1n6SeyiNkECP8CTcY=g@mail.gmail.com>
Message-ID: <CAL_JsqJzt_duSkMm43dwpiGCmqW8PAQ1n6SeyiNkECP8CTcY=g@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 2:29 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Thu, Sep 2, 2021 at 12:03 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Thu, Sep 2, 2021 at 11:57 AM Saravana Kannan <saravanak@google.com> wrote:
> > >
> > > On Thu, Sep 2, 2021 at 7:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> > > >
> > > > On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > >
> > > > > We don't want fw_devlink creating device links for bus devices as
> > > > > they'll never probe. So mark those device node with this flag.
> > > > >
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > ---
> > > > >  drivers/of/platform.c | 16 ++++++++++++++++
> > > > >  1 file changed, 16 insertions(+)
> > > > >
> > > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > > index 74afbb7a4f5e..42b3936d204a 100644
> > > > > --- a/drivers/of/platform.c
> > > > > +++ b/drivers/of/platform.c
> > > > > @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
> > > > >         if (!dev || !of_match_node(matches, bus))
> > > > >                 return 0;
> > > > >
> > > > > +       /*
> > > > > +        * If the bus node has only one compatible string value and it has
> > > > > +        * matched as a bus node, it's never going to get probed by a device
> > > > > +        * driver. So flag it as such so that fw_devlink knows not to create
> > > > > +        * device links with this device.
> > > > > +        *
> > > > > +        * This doesn't catch all devices that'll never probe, but this is good
> > > > > +        * enough for now.
> > > > > +        *
> > > > > +        * This doesn't really work for PPC because of how it uses
> > > > > +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> > > > > +        */
> > > > > +       if (!IS_ENABLED(CONFIG_PPC) &&
> > > > > +           of_property_count_strings(bus, "compatible") == 1)
> > > > > +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
> > > >
> > > > This looks fragile relying on 1 compatible string, and the DT flags in
> > > > this code have been fragile too. I'm pretty sure we have cases of
> > > > simple-bus or simple-mfd that also have another compatible.
> > > >
> > > > Couldn't we solve this with a simple driver?
> > >
> > > Oh, I didn't think you'd like that. I'd lean towards that option too
> > > if we can address some of the other concerns below.
> > >
> > > > Make 'simple-pm-bus'
> > > > driver work for other cases?
> > >
> > > > BTW, this patch doesn't even work for
> > > > simple-pm-bus.
> > >
> > > How do you mean? Because simple-pm-bus already has a driver and
> > > doesn't set "matches" param when it calls of_platform_populate() and
> > > this flag won't be set. So at least for simple-pm-bus I don't see any
> > > issue.
> >
> > You're right.
> >
> > > I was trying to reuse of_default_bus_match_table without explicitly
> > > referring to it, but if it's confusing I can add a separate list of
> > > compatible strings and use those here instead of using "matches".
> >
> > What happens with a non-default table? I'm not sure we can assume the
> > same behavior.
> >
> > > > A driver for simple-bus may cause issues if there's a
> > > > more specific driver to bind to as we don't handle that. It's simply
> > > > whichever matches first.
> > >
> > > Right, this is my worry. Especially for devices like this (there are
> > > plenty of cases like this) which have a driver that probes them but
> > > also lists simple-bus
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/arm-realview-pb11mp.dts?id=73f3af7b4611d77bdaea303fb639333eb28e37d7#n299
> >
> > Uhh, that one is certainly a leakage of wanting an soc_device in the
> > hierarchy, not any real bus structure reflecting the h/w. I'm not a
> > fan of the soc_device stuff and its optional nature. Everything is an
> > SoC, so it should always be there? Or your device hierarchy should
> > change when you decide to add a soc_device?
> >
> > > So as long as there's a compatible string that's not one of the
> > > "transparent" busses, this driver shouldn't match. So, I don't think I
> > > can get away from checking the compatible strings.
> > >
> > > How about I check here to make sure all the "compatible" strings are
> > > from an approved transparent bus list, and if it's true, I use
> > > driver_override to force match it to a transparent bus driver? Would
> > > you be okay with that?
> >
> > Can't we do that within a driver? We check this and fail probe if
> > there's a more specific compatible.  Then another driver can match and
> > probe.
>
> I was thinking that initially, but if we fail a probe, the driver core
> will permanently give up (won't search further) or might end up
> retrying with the same driver and never get to the other driver. I'll
> send out a v2 with what I described above. It's not too bad and it
> will also allow us to handle the PPC cases (we'll just need to keep
> adding the simple-bus equivalent entries to a table).

I wasn't sure, but I traced the calls and it looks like based on
__driver_attach() that if a driver fails probe another one matching
should get to probe:

        /*
         * Ignore errors returned by ->probe so that the next driver can try
         * its luck.
         */

The PPC case is about descending nodes without a compatible string.

Rob
