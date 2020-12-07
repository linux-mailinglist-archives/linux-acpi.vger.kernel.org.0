Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6712D178B
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Dec 2020 18:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgLGR15 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Dec 2020 12:27:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34821 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGR15 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Dec 2020 12:27:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so7104541otr.2
        for <linux-acpi@vger.kernel.org>; Mon, 07 Dec 2020 09:27:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wN5UVpAvBvEU2FzP7GRxMjamnB3KwhcFr9EldIBUA4E=;
        b=mR0yr5BlKGQ5L2U5Wb/2D9ull/0UX/SeBNP45L6KjlC9ciB4iisr+Lvdb67V6A81MK
         V4ZlT4KcekqPS4Htf65anpFl6Owf4VtgVuyk0NX8RVeermjraHil8W7RtUgEwlVqHPpN
         Lh146Lx9JQ1ST3K7yYzwIMXH6RY/TpChaPRnx5twJ8dhpJ0yRoOBlRniHmBCzvEeFYW0
         o6twSjAIRHXVX3vCeTe24tT5mY6RVXfcGrgxQneWboW+9IdRrZ738nblSxVdeoHnOCV7
         MaVJDNVJ0r3Q75O+HdiANFyhuKhClpU2Ja8vRb++fUzsMaS/wDhAwd576racRXTkrVrB
         T/pA==
X-Gm-Message-State: AOAM530BcmO0n04mOrIrgEhpgZeQglCItOQxcpidD8A+WGkn7QDlbAJ+
        jxLutJvYQxkAYyCm/D4NYo++c9RIgmXsZ1pIsj3YKMJESsw=
X-Google-Smtp-Source: ABdhPJxj8umhaZfTDmQX/GFcV27E7nAB9YBraguDlaHkaBSvSIdXb4+CmUKwcBwdsvHRoQzNMcQoA+6uug53O46Lxk4=
X-Received: by 2002:a9d:745a:: with SMTP id p26mr14324283otk.206.1607362035483;
 Mon, 07 Dec 2020 09:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
 <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
 <10746938.kh9KKrt31x@kreacher> <e2bcbee4-78cb-a4f1-41d9-ccb4d3ae0af0@redhat.com>
In-Reply-To: <e2bcbee4-78cb-a4f1-41d9-ccb4d3ae0af0@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Dec 2020 18:27:04 +0100
Message-ID: <CAJZ5v0hjxo8Osg7pSVeBPe6bdDNAcxHfHFBeMGdLOmhVq-GLzQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] ACPI: scan: Split root scanning into 2 steps
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Dec 5, 2020 at 6:03 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/5/20 4:44 PM, Rafael J. Wysocki wrote:
> > On Thursday, December 3, 2020 3:27:27 PM CET Rafael J. Wysocki wrote:
> >> On Thu, Dec 3, 2020 at 10:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > [cut]
> >
> >>> That indeed is not necessary if you take the entire set and always enable the
> >>> new behavior instead of using the module option. I guess we could go that route
> >>> for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
> >>> testing.
> >
> > I'd prefer to do the whole thing in 5.11-rc and possibly revert something if it
> > causes problems to occur.
>
> Ok, that is you call to make, so that is fine with me.
>
> >>> Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
> >>> thing and the module option and simply always uses the new behavior?
> >>
> >> No, something else.  Stay tuned.
> >
> > The patch below illustrates what I'd like to do.  It at least doesn't kill my
> > test-bed system, but also it doesn't cause the enumeration ordering to change
> > on that system.
> >
> > It really is three patches in one and (again) I borrowed some code from your
> > patches in the $subject series.
>
> Borrowing some of my code is fine, no worries about that. I'm happy as some
> fix for this gets upstream in some form :)
>
> >  [It is on top of the "ACPI: scan: Add PNP0D80
> > to the _DEP exceptions list" patch I've just posted.]
> >
> >
> > Please let me know what you think.
>
> I think this should work fine. I've 2 small remarks inline below, but nothing
> big / important.
>
> My list of kernel things to look into is longer then my available time
> (something which I assume you are familiar with), so for now I've only taken
> a good look at your proposed solution and not actually tested it.
>
> Let me know if you want me to give this a spin on the device with the _HID
> issue as is, or if you have something closer to a final version ready
> which you want me to test.

I will, thanks!

> > ---
> >  drivers/acpi/scan.c |  141 ++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 120 insertions(+), 21 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -1646,17 +1646,77 @@ void acpi_device_add_finalize(struct acp
> >       kobject_uevent(&device->dev.kobj, KOBJ_ADD);
> >  }
> >
> > -static int acpi_add_single_object(struct acpi_device **child,
> > -                               acpi_handle handle, int type,
> > -                               unsigned long long sta)
> > +/*
> > + * List of IDs for which we defer enumeration them to the second pass, because
> > + * some of their methods used during addition depend on OpRegions registered by
> > + * the drivers for other ACPI devices.
> > + */
> > +static const char * const acpi_defer_enumeration_ids[] = {
> > +     "BCM2E5B", /* Acer SW3-016 bluetooth HID vs GPIO OpRegs */
> > +     NULL
> > +};
>
> Note that since you defer if there are unmet _DEP-s, this won't be necessary:
>
> This list was purely there as a safer way to select devices which to defer,
> the kernel cmdline option in my patch-set would switch between either using
> this list, or checking _DEP. Since we are going to fully go for using _DEP
> now, this can be dropped.

OK

If that is the case, I'd prefer to check the _DEP list even earlier,
possibly in acpi_bus_check_add(), so as to avoid having to evaluate
_HID or _CID for devices with non-trivial _DEP lists (after taking
acpi_ignore_dep_ids[] into account) in the first pass.

> > +
> > +static bool acpi_should_defer_enumeration(acpi_handle handle,
> > +                                       struct acpi_device_info *info)
> > +{
> > +     struct acpi_handle_list dep_devices;
> > +     acpi_status status;
> > +     int i;
> > +
> > +     if (acpi_info_matches_ids(info, acpi_defer_enumeration_ids))
> > +             return true;
> > +
> > +     /*
> > +      * We check for _HID here to avoid deferring the enumeration of:
> > +      * 1. PCI devices
> > +      * 2. ACPI nodes describing USB ports
> > +      * However, checking for _HID catches more then just these cases ...
> > +      */
> > +     if (!(info->valid & ACPI_VALID_HID))
> > +             return false;
>
> Interesting approach (using _HID), I went with _ADR since _ADR indicates
> (more or less) that the ACPI fwnode is a companion node for a device
> which will be enumerated through other means (such as PCI devices), rather
> then one where the ACPI code will instantiate a platform_device, or
> i2c_client (etc) for it.
>
> Maybe if we want to play it safe check both, and if there either is no
> HID, or there is an ADR do not defer ?  Note just thinking out loud here,
> I'm fine with either approach.

By the spec checking _HID should be equivalent to checking _ADR
(Section 6.1 of ACPI 6.3 says "A device object must contain either an
_HID object or an _ADR,  but should not contain both"), but the
presence of _HID indicates that the device is expected to be
enumerated via ACPI and so _DEP is more likely to really matter IMV.
