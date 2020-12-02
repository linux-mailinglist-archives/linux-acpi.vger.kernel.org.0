Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D782CC74A
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Dec 2020 20:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbgLBT6K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Dec 2020 14:58:10 -0500
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42734 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbgLBT6K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2020 14:58:10 -0500
Received: by mail-oo1-f66.google.com with SMTP id i30so652540ooh.9
        for <linux-acpi@vger.kernel.org>; Wed, 02 Dec 2020 11:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=io9VsNauqwY+rQZhdIScIa5YGUprNjj+k4b8rsOy50E=;
        b=ni07X1Iz1e1YYJC6eAJ64z3fsN2pAmc2Yu5A3LhdcRwA/KcFtiLtA0XQTZGvDYiWyT
         rTUtGKyoBT6AdJXkTpeKg70123k3ClM76GKAEX60tI2PCE+N9Ss/NnB/ABDc75kL1tHI
         NABr0x5KGLjzwHEegpVYYDrpqoiFOol9MRZSJk0MLe6S0MH9qg8rG3c4NaPMJipiz16V
         KjlruwfTwkwjFy6znPU+UaUR3XOieYK1CYwftG65GsZBxWdA5lqbmFjCvDECcWhugJ6K
         H4y2dXcdB3WZhL1mych4mTSeezUhzDdtTTennU1AeItKJwxuHxA0JBBz8BglFvXwbCX/
         Ai1g==
X-Gm-Message-State: AOAM533Gv22qHK4PcG4qxsPRHz6WrnLuq7M2Ql6CeVPNDrZwQ9bQ7TcZ
        H6jfEbpdzblKt+grmU9OUdsxU3YRDiJHCyfCTIxQvvhrvh8=
X-Google-Smtp-Source: ABdhPJx3zzKeSTrFaaa+kE7sfEmsrsK5/cBA49Icn/F8miPyq0i2SAYA8qYiOpg93CUUncvuGbtWP3FnB/6j3KEH4LA=
X-Received: by 2002:a4a:aac4:: with SMTP id e4mr2964553oon.2.1606939043232;
 Wed, 02 Dec 2020 11:57:23 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
 <1e07f2b7-b699-b475-79c0-e411ae772851@redhat.com>
In-Reply-To: <1e07f2b7-b699-b475-79c0-e411ae772851@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Dec 2020 20:57:11 +0100
Message-ID: <CAJZ5v0hmso90JSKfGMU4ZEJqKhR4bgmDa68Q+XLHytNJmGU10Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 2, 2020 at 8:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/2/20 2:49 PM, Rafael J. Wysocki wrote:
> > On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi Rafael,
> >>
> >> A while ago (almost 2 years ago) I discussed an issue with you about
> >> some devices, where some of the methods used during device-addition
> >> (such as _HID) may rely on OpRegions of other devices:
> >>
> >> https://www.spinics.net/lists/linux-acpi/msg86303.html
> >>
> >> An example of this is the Acer Switch 10E SW3-016 model. The _HID method
> >> of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
> >> the installed wifi chip and update the _HID for the Bluetooth's ACPI node
> >> accordingly. The current ACPI scan code calls _HID before the GPIO
> >> controller's OpRegions are available, leading to the wrong _HID being
> >> used and Bluetooth not working.
> >>
> >> Last week I bought a second hand Acer device, not knowing it was this
> >> exact model. Since I now have access to affected hardware I decided to
> >> take a shot at fixing this.
> >>
> >> In the discussion you suggested to split the acpi_bus_scan of the root
> >> into 2 steps, first scan devices with an empty _DEP, putting other
> >> acpi_handle-s on a list of deferred devices and then in step 2 scan the
> >> rest.
> >>
> >> I'm happy to report that, at least on the affected device, this works
> >> nicely. While working on this I came up with a less drastic way to
> >> deal with this. As you will see in patch 4 of this series, I decided
> >> to first add a more KISS method of deciding which devices to defer
> >> to the second scan step by matching by HID. This has the disadvantage
> >> of not being a generic solution. But it has the advantage of being a
> >> solution which does not potentially regress other devices.
> >>
> >> Then in patch 5 I actually do add the option to defer or not based on
> >> _DEP being empty. I've put this behind a kernel commandline option as
> >> I'm not sure we should do this everywhere by default. At least no without
> >> a lot more testing.
> >>
> >> Patch 6 fixes an issue with patch 5 which causes battery devices to stop
> >> working.
> >>
> >> And patch 7 adds some extra HIDs to the list of HIDs which should be
> >> ignored when checking if the _DEP list is empty from Linux' pov, iow
> >> some extra HIDs which Linux does not bind to.
> >>
> >> Please let me know what you think about this patch-set. I would be happy
> >> to see just patches 1-4 merged.
> >
> > I took patches 1 and 2, because IMO they are generally useful (I
> > rewrote the changelogs to avoid mentioning the rest of the series
> > though),
>
> That is fine. Thanks for taking those.
>
> > but I have some reservations regarding the rest.
> >
> > First off, I'm not really sure if failing acpi_add_single_object() for
> > devices with missing dependencies is a good idea.  IIRC there is
> > nothing in there that should depend on any opregions supplied by the
> > other devices, so it should be safe to allow it to complete.
>
> Actually acpi_add_single_object() does depend on ACPI methods
> which may depend on opregions, that is the whole reason why
> this series is necessary. Otherwise we could just delay the
> binding of the driver based in dep_unmet which would be easier.
>
> Here are 2 actual examples of acpi_add_single_object() calling
> ACPI methods which may depend on opregions:
>
> 1. acpi_add_single_object() calls acpi_init_device_object() which
> calls acpi_set_pnp_ids() which fills a bunch if fields of
> struct acpi_device with info returned by the acpi_get_object_info()
> call.
>
> Specifically it stores the value returned by the _HID method in
> the acpi_device_pnp array for the device and that _HID method is
> actually the problem in the example device which started this
> series. The _HID method of the bluetooth device reads 2 GPIOs
> to get a hw-id (0-3) and then translates the hwid to a _HID
> string. If the GPIO opregion's handlers have not registered yet
> then the reading of the GPIOs is correctly skipped, and hwid
> 0 is assumed, which is wrong in this case.
>
> 2. I've also seen examples where _STA depends on GPIOs in a similar
> manner; and acpi_add_single_object() calls acpi_bus_get_power_flags()
> which calls acpi_bus_init_power() which calls acpi_device_is_present()
> which depends on _STA results.

Well, this means that there is a bug in acpi_bus_attach() which
shouldn't call acpi_bus_init_power() which has been called already.

And it all means that either deferring acpi_add_single_object() is
needed and so there need to be 2 passes in acpi_bus_attach() overall,
or acpi_add_single_object() needs to avoid calling methods that may
depend on supplied opregions.  I guess the latter is rather
unrealistic, so the only practical choice is the former.

However, I still don't think that the extra list of "dependent
devices" is needed.
