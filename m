Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9863FF433
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 21:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347383AbhIBTaY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 15:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347371AbhIBTaX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 15:30:23 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA27AC061575
        for <linux-acpi@vger.kernel.org>; Thu,  2 Sep 2021 12:29:24 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id n126so5926637ybf.6
        for <linux-acpi@vger.kernel.org>; Thu, 02 Sep 2021 12:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6hx1TLChVu3Xib6wqsnsKYGm7+kh5wmG/kTdmIBWwZA=;
        b=pCy+LvikQOzafTsIDf1jhSBUsaa4z1gSDIb5NPlrmQ0dAU2iDuI+m+meN9VKC30Q5s
         4n6Usl3d8sfl2KUQwI02L5x3qfh6XFGTNsBg4yQ5vDZnhFRIAEnAMAmbHIqPZqC5c5Lo
         ok6T67ZxpsaYearZS8C4j7alQ2DeE+FtwjQ+TPDcfiOXdQEfabHbCTFk6brgPY3Ib2g4
         vumaK+GK5aGj1axDkPs/sNQwNbpXnl8Q/FmiQ3kB7JGT/H/3qmRuAn1Dob7jLdJuJfq3
         HBDVbF10zguNCTJ9GqY7ys3WgeCYOUtHh7NigmaE5tUvqwdeWDCR/CjsoedT7daQTF3j
         Aw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6hx1TLChVu3Xib6wqsnsKYGm7+kh5wmG/kTdmIBWwZA=;
        b=a39JPJ6rdnnVaZDvfVFpH+H0EUVedCoOmsECdtQli7r/G4j/30polwBUnWjnIyCO1P
         RJziyjj85OfIeMfmCALWKBhx8b0NSSCdEfYfzwMGENSF54eSUQMIsnwfKE7XQYo+mgSk
         +FwQKsgirDyJghGf8+6s8Zrn71Y3f4jT5Lj+yH6ShzpFlLanSY5wPctQ9+Xi9X5j3ELA
         H3ySwYWwMbKH2CLnqSV8wuo7UgZhKhAaUHkSE/RAtEAdwt2HZCsY+a1i2mQ8Lc4pMpVr
         xyC6gJBtkxMDEmphdQhVw4Fr9+vBe/0OrEZYwWQ3dg31jCr5DzKRS3KvD3+5P97RVeMP
         DKcQ==
X-Gm-Message-State: AOAM533hkSkRYhGMLljCMFhQlh8fezGJxBvE8zKCZpKTPhU8aS5k8CLl
        LQW8/4GOuhjE1GQVWUIFfoNIj2WfR+71H78e2OEjEw==
X-Google-Smtp-Source: ABdhPJy2CjO1I67T+PQpg8YLPijsHlOxA6EHAyqe5+JzRgKtib9fvCVULpHBG6yc/KMPxLIkBNOW/ULSCVkrAFwXN8Q=
X-Received: by 2002:a5b:50b:: with SMTP id o11mr6645741ybp.466.1630610963746;
 Thu, 02 Sep 2021 12:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com>
 <20210902025528.1017391-3-saravanak@google.com> <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
 <CAGETcx-rOakAX_apu2ecu6jWCwzO0RgMkwdfzyF+UaxQfVj4CA@mail.gmail.com> <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+A1T5+KK5xsVVtrMVeuMre3B6sAAroX+a3gQy6wY+r8A@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 12:28:47 -0700
Message-ID: <CAGETcx9wY66TsFX_1rFUO+toE-OpkAvWSdcNVK7M=LYwa6xbAw@mail.gmail.com>
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

On Thu, Sep 2, 2021 at 12:03 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Sep 2, 2021 at 11:57 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Thu, Sep 2, 2021 at 7:24 AM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
> > > >
> > > > We don't want fw_devlink creating device links for bus devices as
> > > > they'll never probe. So mark those device node with this flag.
> > > >
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > >  drivers/of/platform.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > > > diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> > > > index 74afbb7a4f5e..42b3936d204a 100644
> > > > --- a/drivers/of/platform.c
> > > > +++ b/drivers/of/platform.c
> > > > @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
> > > >         if (!dev || !of_match_node(matches, bus))
> > > >                 return 0;
> > > >
> > > > +       /*
> > > > +        * If the bus node has only one compatible string value and it has
> > > > +        * matched as a bus node, it's never going to get probed by a device
> > > > +        * driver. So flag it as such so that fw_devlink knows not to create
> > > > +        * device links with this device.
> > > > +        *
> > > > +        * This doesn't catch all devices that'll never probe, but this is good
> > > > +        * enough for now.
> > > > +        *
> > > > +        * This doesn't really work for PPC because of how it uses
> > > > +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> > > > +        */
> > > > +       if (!IS_ENABLED(CONFIG_PPC) &&
> > > > +           of_property_count_strings(bus, "compatible") == 1)
> > > > +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;
> > >
> > > This looks fragile relying on 1 compatible string, and the DT flags in
> > > this code have been fragile too. I'm pretty sure we have cases of
> > > simple-bus or simple-mfd that also have another compatible.
> > >
> > > Couldn't we solve this with a simple driver?
> >
> > Oh, I didn't think you'd like that. I'd lean towards that option too
> > if we can address some of the other concerns below.
> >
> > > Make 'simple-pm-bus'
> > > driver work for other cases?
> >
> > > BTW, this patch doesn't even work for
> > > simple-pm-bus.
> >
> > How do you mean? Because simple-pm-bus already has a driver and
> > doesn't set "matches" param when it calls of_platform_populate() and
> > this flag won't be set. So at least for simple-pm-bus I don't see any
> > issue.
>
> You're right.
>
> > I was trying to reuse of_default_bus_match_table without explicitly
> > referring to it, but if it's confusing I can add a separate list of
> > compatible strings and use those here instead of using "matches".
>
> What happens with a non-default table? I'm not sure we can assume the
> same behavior.
>
> > > A driver for simple-bus may cause issues if there's a
> > > more specific driver to bind to as we don't handle that. It's simply
> > > whichever matches first.
> >
> > Right, this is my worry. Especially for devices like this (there are
> > plenty of cases like this) which have a driver that probes them but
> > also lists simple-bus
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/arm-realview-pb11mp.dts?id=73f3af7b4611d77bdaea303fb639333eb28e37d7#n299
>
> Uhh, that one is certainly a leakage of wanting an soc_device in the
> hierarchy, not any real bus structure reflecting the h/w. I'm not a
> fan of the soc_device stuff and its optional nature. Everything is an
> SoC, so it should always be there? Or your device hierarchy should
> change when you decide to add a soc_device?
>
> > So as long as there's a compatible string that's not one of the
> > "transparent" busses, this driver shouldn't match. So, I don't think I
> > can get away from checking the compatible strings.
> >
> > How about I check here to make sure all the "compatible" strings are
> > from an approved transparent bus list, and if it's true, I use
> > driver_override to force match it to a transparent bus driver? Would
> > you be okay with that?
>
> Can't we do that within a driver? We check this and fail probe if
> there's a more specific compatible.  Then another driver can match and
> probe.

I was thinking that initially, but if we fail a probe, the driver core
will permanently give up (won't search further) or might end up
retrying with the same driver and never get to the other driver. I'll
send out a v2 with what I described above. It's not too bad and it
will also allow us to handle the PPC cases (we'll just need to keep
adding the simple-bus equivalent entries to a table).

-Saravana
