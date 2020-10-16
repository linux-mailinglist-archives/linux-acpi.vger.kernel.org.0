Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C67672907BA
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 16:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407677AbgJPOvP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 10:51:15 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:46180 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407130AbgJPOvO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 10:51:14 -0400
Received: by mail-oo1-f65.google.com with SMTP id c25so665059ooe.13;
        Fri, 16 Oct 2020 07:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OvZLUwxXbsYt5GY0+KWs0O5JpZUG+90mhJIF+9eGBQQ=;
        b=HZ5HjjaHeMqkRkQRGWyxpyLo6md2ywah9Am0X4mCz9PiwCvZkURHi2+JpDQAzMOHbJ
         KvLg5zwcajmhlTaPZG3o+IQG8CPeWrHtnOYyHFDJNfPzydWbp1AtiwvpNXipG8ywBPdZ
         ZpuJANiYeJIuELv3jttRnv4kXGMPOUMfbuqYhZuRHZb9mobhflEqxaNKaokltv9P60S1
         yt+PU0IU6moOz8ZSYI1jjx1ii9U6tZ6NFe6I/PvNDFuWSt1blSu7jSsCpxVbHRGg8/Jt
         MReHVK/ACfQNIShYaUGKGNDfRZB2CUj7IEoc/VccBQnC6ITPIFWG2Js2xHBws9syKOHW
         FC3w==
X-Gm-Message-State: AOAM532puJBVTm3DJeNjkiBQYrctGvAVkSLmyjSnTi9JERcs0G4ibG5k
        kw2nqg89HVhcDulfhzq+QAt7KV0oSlLZThyqWnY=
X-Google-Smtp-Source: ABdhPJw8jW44BfJvCmZodx50dYHRYCufqM/DoXtN34Tthnu+zshnry25BklsWhEZmu4o/uyug2ms+xRaxomIrI0Qr1s=
X-Received: by 2002:a4a:dc0d:: with SMTP id p13mr3036465oov.2.1602859873680;
 Fri, 16 Oct 2020 07:51:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com> <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com> <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com> <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
 <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com> <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
 <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
In-Reply-To: <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Oct 2020 16:51:02 +0200
Message-ID: <CAJZ5v0j8o5Ot-4U0HmUtckUUBSNqC+TRB6CCRzqdjeE0p_XfvA@mail.gmail.com>
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

On Fri, Oct 16, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> <note folding the 2 threads we are having on this into one, adding every one from both threads to the Cc>
>
> Hi,
>
> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
> > On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
>
> <snip>
>
> >>> First, a common place to register a DPTF system profile seems to be
> >>> needed and, as I said above, I wouldn't expect more than one such
> >>> thing to be present in the system at any given time, so it may be
> >>> registered along with the list of supported profiles and user space
> >>> will have to understand what they mean.
> >>
> >> Mostly Ack, I would still like to have an enum for DPTF system
> >> profiles in the kernel and have a single piece of code map that
> >> enum to profile names. This enum can then be extended as
> >> necessary, but I want to avoid having one driver use
> >> "Performance" and the other "performance" or one using
> >> "performance-balanced" and the other "balanced-performance", etc.
> >>
> >> With the goal being that new drivers use existing values from
> >> the enum as much as possible, but we extend it where necessary.
> >
> > IOW, just a table of known profile names with specific indices assigned to them.
>
> Yes.
>
> > This sounds reasonable.
> >
> >>> Second, irrespective of the above, it may be useful to have a
> >>> consistent way to pass performance-vs-power preference information
> >>> from user space to different parts of the kernel so as to allow them
> >>> to adjust their operation and this could be done with a system-wide
> >>> power profile attribute IMO.
> >>
> >> I agree, which is why I tried to tackle both things in one go,
> >> but as you said doing both in 1 API is probably not the best idea.
> >> So I believe we should park this second issue for now and revisit it
> >> when we find a need for it.
> >
> > Agreed.
> >
> >> Do you have any specific userspace API in mind for the
> >> DPTF system profile selection?
> >
> > Not really.
>
> So before /sys/power/profile was mentioned, but that seems more like
> a thing which should have a set of fixed possible values, iow that is
> out of scope for this discussion.

Yes.

> Since we all seem to agree that this is something which we need
> specifically for DPTF profiles maybe just add:
>
> /sys/power/dptf_current_profile    (rw)
> /sys/power/dptf_available_profiles (ro)
>
> (which will only be visible if a dptf-profile handler
>  has been registered) ?
>
> Or more generic and thus better (in case other platforms
> later need something similar) I think, mirror the:
>
> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
> for a system-wide energy-performance setting, so we get:
>
> /sys/power/energy_performance_preference
> /sys/power/energy_performance_available_preferences

But this is not about energy vs performance only in general, is it?

> (again only visible when applicable) ?
>
> I personally like the second option best.

But I would put it under /sys/firmware/ instead of /sys/power/ and I
would call it something like platform_profile (and
platform_profile_choices or similar).

Cheers!
