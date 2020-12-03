Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350662CD915
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Dec 2020 15:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLCO2W (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Dec 2020 09:28:22 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38747 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgLCO2V (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Dec 2020 09:28:21 -0500
Received: by mail-oi1-f193.google.com with SMTP id o25so2333657oie.5
        for <linux-acpi@vger.kernel.org>; Thu, 03 Dec 2020 06:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAtEZ2xgq1f8kIbBzblqM/vbaRP0R3ZW119nK7fqwHw=;
        b=d46NgWaxV8kqklli/bN0TWIfR9vNo/wfy9BWBYii2udaM9audURJjs2+VU1SS8GIh2
         sFYEhUMH30tGL9YoM96D6/SX6a+I6O1Y7QYojhYBX5wI58GWDx8y/ja8jnjYdYprPusr
         v0HIlZ1CkKGyMmqAhvmpzpzc7n86qWCh26Iy3S5lDcVrRusKFCmhKVv0uehXDRtOzQqf
         VcgYMbHFRmuRucccvMOcMg8c6uF05Yt8yqCQxpGs/GXACq4DW37X2DTD058g1T2o07uN
         nPRvc7Jyy0Jc0FBsz0yK0TgcWsbxQkPYANF4pjFUMhwzso9RtqhB+ljCc2+Ecn0kxkWl
         eGSQ==
X-Gm-Message-State: AOAM532fOVv07K68BOB1j5uDZNNezbhLivRTXp2sRRt7tBIJ4XozlOZo
        aZ6I78e1FOAfIcampBxDpD7td/qjfBECWnfn7k+VoptI8Dk=
X-Google-Smtp-Source: ABdhPJyWL6h1p0jpKm4DMtk7e2gkoRAs9BD+I1vH0Vcu/uTINjIeqZCJtJp0K9QYHshxbZiA0DoS8NLBQrTWuQIOz8s=
X-Received: by 2002:aca:cf4a:: with SMTP id f71mr2029697oig.157.1607005660224;
 Thu, 03 Dec 2020 06:27:40 -0800 (PST)
MIME-Version: 1.0
References: <20201121203040.146252-1-hdegoede@redhat.com> <CAJZ5v0joWwOqaBkEXOsi3oT__j8JMJt68TPuRAY7f5WY6w=KrA@mail.gmail.com>
 <1e07f2b7-b699-b475-79c0-e411ae772851@redhat.com> <CAJZ5v0hmso90JSKfGMU4ZEJqKhR4bgmDa68Q+XLHytNJmGU10Q@mail.gmail.com>
 <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
In-Reply-To: <00a4b9c2-aca2-4842-3006-720515f262db@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 3 Dec 2020 15:27:27 +0100
Message-ID: <CAJZ5v0iP4a_6sSjO2sAgQUZ7T9BWvaV+s_JvYnD4NwdcCY9DMw@mail.gmail.com>
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

On Thu, Dec 3, 2020 at 10:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 12/2/20 8:57 PM, Rafael J. Wysocki wrote:
> > On Wed, Dec 2, 2020 at 8:39 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 12/2/20 2:49 PM, Rafael J. Wysocki wrote:
> >>> On Sat, Nov 21, 2020 at 9:30 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> Hi Rafael,
> >>>>
> >>>> A while ago (almost 2 years ago) I discussed an issue with you about
> >>>> some devices, where some of the methods used during device-addition
> >>>> (such as _HID) may rely on OpRegions of other devices:
> >>>>
> >>>> https://www.spinics.net/lists/linux-acpi/msg86303.html
> >>>>
> >>>> An example of this is the Acer Switch 10E SW3-016 model. The _HID method
> >>>> of the ACPI node for the UART attached Bluetooth, reads GPIOs to detect
> >>>> the installed wifi chip and update the _HID for the Bluetooth's ACPI node
> >>>> accordingly. The current ACPI scan code calls _HID before the GPIO
> >>>> controller's OpRegions are available, leading to the wrong _HID being
> >>>> used and Bluetooth not working.
> >>>>
> >>>> Last week I bought a second hand Acer device, not knowing it was this
> >>>> exact model. Since I now have access to affected hardware I decided to
> >>>> take a shot at fixing this.
> >>>>
> >>>> In the discussion you suggested to split the acpi_bus_scan of the root
> >>>> into 2 steps, first scan devices with an empty _DEP, putting other
> >>>> acpi_handle-s on a list of deferred devices and then in step 2 scan the
> >>>> rest.
> >>>>
> >>>> I'm happy to report that, at least on the affected device, this works
> >>>> nicely. While working on this I came up with a less drastic way to
> >>>> deal with this. As you will see in patch 4 of this series, I decided
> >>>> to first add a more KISS method of deciding which devices to defer
> >>>> to the second scan step by matching by HID. This has the disadvantage
> >>>> of not being a generic solution. But it has the advantage of being a
> >>>> solution which does not potentially regress other devices.
> >>>>
> >>>> Then in patch 5 I actually do add the option to defer or not based on
> >>>> _DEP being empty. I've put this behind a kernel commandline option as
> >>>> I'm not sure we should do this everywhere by default. At least no without
> >>>> a lot more testing.
> >>>>
> >>>> Patch 6 fixes an issue with patch 5 which causes battery devices to stop
> >>>> working.
> >>>>
> >>>> And patch 7 adds some extra HIDs to the list of HIDs which should be
> >>>> ignored when checking if the _DEP list is empty from Linux' pov, iow
> >>>> some extra HIDs which Linux does not bind to.
> >>>>
> >>>> Please let me know what you think about this patch-set. I would be happy
> >>>> to see just patches 1-4 merged.
> >>>
> >>> I took patches 1 and 2, because IMO they are generally useful (I
> >>> rewrote the changelogs to avoid mentioning the rest of the series
> >>> though),
> >>
> >> That is fine. Thanks for taking those.
> >>
> >>> but I have some reservations regarding the rest.
> >>>
> >>> First off, I'm not really sure if failing acpi_add_single_object() for
> >>> devices with missing dependencies is a good idea.  IIRC there is
> >>> nothing in there that should depend on any opregions supplied by the
> >>> other devices, so it should be safe to allow it to complete.
> >>
> >> Actually acpi_add_single_object() does depend on ACPI methods
> >> which may depend on opregions, that is the whole reason why
> >> this series is necessary. Otherwise we could just delay the
> >> binding of the driver based in dep_unmet which would be easier.
> >>
> >> Here are 2 actual examples of acpi_add_single_object() calling
> >> ACPI methods which may depend on opregions:
> >>
> >> 1. acpi_add_single_object() calls acpi_init_device_object() which
> >> calls acpi_set_pnp_ids() which fills a bunch if fields of
> >> struct acpi_device with info returned by the acpi_get_object_info()
> >> call.
> >>
> >> Specifically it stores the value returned by the _HID method in
> >> the acpi_device_pnp array for the device and that _HID method is
> >> actually the problem in the example device which started this
> >> series. The _HID method of the bluetooth device reads 2 GPIOs
> >> to get a hw-id (0-3) and then translates the hwid to a _HID
> >> string. If the GPIO opregion's handlers have not registered yet
> >> then the reading of the GPIOs is correctly skipped, and hwid
> >> 0 is assumed, which is wrong in this case.
> >>
> >> 2. I've also seen examples where _STA depends on GPIOs in a similar
> >> manner; and acpi_add_single_object() calls acpi_bus_get_power_flags()
> >> which calls acpi_bus_init_power() which calls acpi_device_is_present()
> >> which depends on _STA results.
> >
> > Well, this means that there is a bug in acpi_bus_attach() which
> > shouldn't call acpi_bus_init_power() which has been called already.
>
> I'm afraid we have a bit of a misunderstanding here, the problem is
> not that acpi_bus_attach() calls acpi_bus_init_power(), the problem is
> that acpi_bus_init_power() (which is called from acpi_add_single_object())
> depends on the value returned by _STA and that in turn may depend on
> some OpRegions being available. IOW it is the same problem as the _HID
> problem.

This was a side note.

Arguably, acpi_bus_init_power() should not be called twice in a row
for the same device, which is actually done by the current code.

Another side note: while we can avoid evaluating _STA for the devices
whose enumeration we want to defer, avoiding to evaluate _HID (or _CID
for that matter) for them will be rather hard.

> > And it all means that either deferring acpi_add_single_object() is
> > needed and so there need to be 2 passes in acpi_bus_attach() overall,
> > or acpi_add_single_object() needs to avoid calling methods that may
> > depend on supplied opregions.  I guess the latter is rather
> > unrealistic, so the only practical choice is the former.
>
> I agree.
>
> > However, I still don't think that the extra list of "dependent
> > devices" is needed.
>
> I'm not sure what you are trying to say here? Do you mean this list:
>
> +/*
> + * List of HIDs for which we defer adding them to the second step of the
> + * scanning of the root, because some of their methods used during addition
> + * depend on OpRegions registered by the drivers for other ACPI devices.
> + */
> +static const char * const acpi_defer_add_hids[] = {
> +       "BCM2E5B", /* Acer SW3-016 bluetooth HID when GPIO OpRegs or not available yet */
> +       NULL
> +};
> +
>
> ?

No, the one created by patch [4/7] in your series, acpi_deferred_devices.

> That indeed is not necessary if you take the entire set and always enable the
> new behavior instead of using the module option. I guess we could go that route
> for 5.12, and get it into next as soon as 5.11-rc1 is available for maximum
> testing.
>
> Do you want me to do a new version of the series which drops the acpi_defer_add_hids[]
> thing and the module option and simply always uses the new behavior?

No, something else.  Stay tuned.
