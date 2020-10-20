Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E6F293BBC
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Oct 2020 14:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406212AbgJTMfR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Oct 2020 08:35:17 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37382 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406196AbgJTMfO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2020 08:35:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id m22so1560937ots.4;
        Tue, 20 Oct 2020 05:35:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnCt+XFaosLLbfx8VEYEAcAQq5yi8ZE5UTPu7v1RbEs=;
        b=HyQJTt5szUCFQP6kLkc9Qlen25r1VjKr7siVjNw2CKEb9UjswxaIp4uXXT5VbmM73j
         RQVmJg205iPppYNVQwqgzQEmEQkMw7ONfrnxOuXoP+Qb296ChbF5xYGCGBIOPEE3nJgq
         or9gd2Km9skd8aIhTEPF38v7AOj7SytNVlzWwjBL7SiXdREvzY+tdlMjuEg/LVACAPJf
         Jn/3Cwz4kjWF06zFzJGUsfVf4PKJDb1d8tgpSgy0dsnxyfHH1hoe/Q7f2sLp9aYM4MFL
         gtRRFk0/iTvpighn2HtsuRImc+n2govV4+ayeIvxnf6qrYN1jx/+2NoPqJjuChbdrMcY
         qVFA==
X-Gm-Message-State: AOAM5321KeymVHjoo+qBtYZW+30iUForPgQtl6HwZp/hX6I/cZIa5Oi1
        vUNZzrRK2vX0CPfnyXM594hSbyQvCRTCoLUHocE=
X-Google-Smtp-Source: ABdhPJx11FJ6JjHAoVE+I1oNT24inHCpQ5CeynliIfRgEV2FrHbCZkZiqi9XOv+QjDg5bnEEwsxHctj7Ex27seChu5Y=
X-Received: by 2002:a05:6830:18cd:: with SMTP id v13mr1641488ote.206.1603197311012;
 Tue, 20 Oct 2020 05:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com> <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com> <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com> <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
 <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com> <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
 <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com> <CAJZ5v0j8o5Ot-4U0HmUtckUUBSNqC+TRB6CCRzqdjeE0p_XfvA@mail.gmail.com>
 <25d000cc-0c00-3b17-50f7-ca8de8b7a65b@redhat.com> <CAJZ5v0jC=rrTEtqoTvjw5vi=OH7i5OGC-KFuJgjCaXaDsKhUeQ@mail.gmail.com>
 <64de7cf0-5d52-f8b3-426a-431fb3a6a6ec@redhat.com>
In-Reply-To: <64de7cf0-5d52-f8b3-426a-431fb3a6a6ec@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 20 Oct 2020 14:34:59 +0200
Message-ID: <CAJZ5v0js7ujhzJF3UdO4+M2c5=N1kTP=8JRbdvxM7DuN4RqVUA@mail.gmail.com>
Subject: Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the
 DTPM framework)
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <mpearson@lenovo.com>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 19, 2020 at 8:43 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 10/18/20 2:31 PM, Rafael J. Wysocki wrote:
> > On Sun, Oct 18, 2020 at 11:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> Hi,
> >>
> >> On 10/16/20 4:51 PM, Rafael J. Wysocki wrote:
> >>> On Fri, Oct 16, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>
> >>>> <note folding the 2 threads we are having on this into one, adding every one from both threads to the Cc>
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
> >>>>> On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>>>> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
> >>>>
> >>>> <snip>
> >>>>
> >>>>>>> First, a common place to register a DPTF system profile seems to be
> >>>>>>> needed and, as I said above, I wouldn't expect more than one such
> >>>>>>> thing to be present in the system at any given time, so it may be
> >>>>>>> registered along with the list of supported profiles and user space
> >>>>>>> will have to understand what they mean.
> >>>>>>
> >>>>>> Mostly Ack, I would still like to have an enum for DPTF system
> >>>>>> profiles in the kernel and have a single piece of code map that
> >>>>>> enum to profile names. This enum can then be extended as
> >>>>>> necessary, but I want to avoid having one driver use
> >>>>>> "Performance" and the other "performance" or one using
> >>>>>> "performance-balanced" and the other "balanced-performance", etc.
> >>>>>>
> >>>>>> With the goal being that new drivers use existing values from
> >>>>>> the enum as much as possible, but we extend it where necessary.
> >>>>>
> >>>>> IOW, just a table of known profile names with specific indices assigned to them.
> >>>>
> >>>> Yes.
> >>>>
> >>>>> This sounds reasonable.
> >>>>>
> >>>>>>> Second, irrespective of the above, it may be useful to have a
> >>>>>>> consistent way to pass performance-vs-power preference information
> >>>>>>> from user space to different parts of the kernel so as to allow them
> >>>>>>> to adjust their operation and this could be done with a system-wide
> >>>>>>> power profile attribute IMO.
> >>>>>>
> >>>>>> I agree, which is why I tried to tackle both things in one go,
> >>>>>> but as you said doing both in 1 API is probably not the best idea.
> >>>>>> So I believe we should park this second issue for now and revisit it
> >>>>>> when we find a need for it.
> >>>>>
> >>>>> Agreed.
> >>>>>
> >>>>>> Do you have any specific userspace API in mind for the
> >>>>>> DPTF system profile selection?
> >>>>>
> >>>>> Not really.
> >>>>
> >>>> So before /sys/power/profile was mentioned, but that seems more like
> >>>> a thing which should have a set of fixed possible values, iow that is
> >>>> out of scope for this discussion.
> >>>
> >>> Yes.
> >>>
> >>>> Since we all seem to agree that this is something which we need
> >>>> specifically for DPTF profiles maybe just add:
> >>>>
> >>>> /sys/power/dptf_current_profile    (rw)
> >>>> /sys/power/dptf_available_profiles (ro)
> >>>>
> >>>> (which will only be visible if a dptf-profile handler
> >>>>  has been registered) ?
> >>>>
> >>>> Or more generic and thus better (in case other platforms
> >>>> later need something similar) I think, mirror the:
> >>>>
> >>>> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
> >>>> for a system-wide energy-performance setting, so we get:
> >>>>
> >>>> /sys/power/energy_performance_preference
> >>>> /sys/power/energy_performance_available_preferences
> >>>
> >>> But this is not about energy vs performance only in general, is it?
> >>>
> >>>> (again only visible when applicable) ?
> >>>>
> >>>> I personally like the second option best.
> >>>
> >>> But I would put it under /sys/firmware/ instead of /sys/power/ and I
> >>> would call it something like platform_profile (and
> >>> platform_profile_choices or similar).
> >>
> >> Currently we only have dirs under /sys/firmware:
> >>
> >> [hans@x1 ~]$ ls /sys/firmware
> >> acpi  dmi  efi  memmap
> >>
> >> But we do have /sys/firmware/apci/pm_profile:
> >>
> >> Documentation/ABI/stable/sysfs-acpi-pmprofile
> >>
> >> What:           /sys/firmware/acpi/pm_profile
> >> Date:           03-Nov-2011
> >> KernelVersion:  v3.2
> >> Contact:        linux-acpi@vger.kernel.org
> >> Description:    The ACPI pm_profile sysfs interface exports the platform
> >>                 power management (and performance) requirement expectations
> >>                 as provided by BIOS. The integer value is directly passed as
> >>                 retrieved from the FADT ACPI table.
> >> Values:         For possible values see ACPI specification:
> >>                 5.2.9 Fixed ACPI Description Table (FADT)
> >>                 Field: Preferred_PM_Profile
> >>
> >>                 Currently these values are defined by spec:
> >>                 0 Unspecified
> >>                 1 Desktop
> >>                 2 Mobile
> >>                 3 Workstation
> >>                 4 Enterprise Server
> >>                 ...
> >>
> >> Since all platforms which we need this for are ACPI based
> >> (and the involved interfaces are also all ACPI interfaces)
> >> how about:
> >>
> >> /sys/firmware/acpi/platform_profile
> >> /sys/firmware/acpi/platform_profile_choices
> >>
> >> ?
> >>
> >> I think this goes nice together with /sys/firmware/acpi/pm_profile
> >> although that is read-only and this is a read/write setting.
> >>
> >> Rafel, would:
> >>
> >> /sys/firmware/acpi/platform_profile
> >> /sys/firmware/acpi/platform_profile_choices
> >>
> >> work for you ?
> >
> > Yes, it would.
>
> Great. So I think hat means that we have the most important part
> for moving forward with this.
>
> So I guess the plan for this now looks something like this.
>
> 1. Rewrite my API docs RFC to update it for the new /sys/firmware/acpi/platform_profile[_choices]
>    plan (should be easy and a bunch of stuff like the "type" bit can just be dropped)
>
> 2. Add code somewhere under drivers/acpi which allows code from else where
>    to register itself as platform_profile handler/provider.

Sounds good to me.

> Rafael, any suggestions / preference for where this should be added under
> drivers/acpi ?  In a new .c file perhaps ?

Yes, that would be most suitable IMV.

> 3.1 Use the code from 2 to add support for platform-profile selection in
>     thinkpad_acpi (something for me or Mark Pearson) to do
> 3.2 Use the code from 2 to add support for platform-profile selection
>     to hp-wmi
> 3.3 (and to other drivers in the future).

Right.
