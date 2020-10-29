Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9982729EA6F
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 12:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ2LZu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Oct 2020 07:25:50 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42719 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgJ2LZt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Oct 2020 07:25:49 -0400
Received: by mail-oi1-f179.google.com with SMTP id c72so2802492oig.9;
        Thu, 29 Oct 2020 04:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QchY1rQBO8CSFd113tzUKvOK8asotum72xA9lUDpzIc=;
        b=gNiWdrMZrCfKPlbBzNxTLTeu4oLjUy288fTNywiUgx2OzsjOHBRGYyPItpfOvnMkAv
         kNbZw4GBEv2jfBwUNlKVoeN+75qv6Pyd+WRL1qXo1HMYiHgOcxIylSsF/zuorxzuFnXp
         uJb9RqwSMhZ0IjYwlPzk85v4nULcDnY/xy2cRcfC35PZtGExhYZ5TrZoodIvken9KRiw
         /AUa0Qo8RtSC3Le579QzI7zQ4LLoGOThx2msgOe1IuPn33YbcKW9vpZJr0QbisVid+pS
         r8esAIcBJufnp3lRGgBo4fRr1CPTZ9x4kPKfq6Mo9qeoMf6yZ+84uXqghIfT1rbUZXAq
         T7Bg==
X-Gm-Message-State: AOAM532qnV+8YrXSZA3m7TYMHU5Q9N13+uL8B5VWe0dyXV+FriXfEo0l
        xUSZHxZjgO2R5dC90nwB3FHZUK8VwRIAtKkct0Q=
X-Google-Smtp-Source: ABdhPJx9CE4uF1ccjyYAqyCw3qpTvRqSxQHalV2jVP/wHFIrcYNGtma055Xz40efk5OWLEfk3yCow3a8TC21dbC/jA8=
X-Received: by 2002:aca:4c86:: with SMTP id z128mr2634681oia.71.1603970748463;
 Thu, 29 Oct 2020 04:25:48 -0700 (PDT)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201027164219.868839-1-markpearson@lenovo.com>
 <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
In-Reply-To: <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 29 Oct 2020 12:25:37 +0100
Message-ID: <CAJZ5v0hUzsCS0dZbT4RRQ31DgTiuCOmyCcJMji_DbU19ghaOdA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Add documentation for new platform_profile
 sysfs attribute
To:     Bastien Nocera <hadess@hadess.net>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 29, 2020 at 2:53 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> Hey Hans, Mark,
>
> On Tue, 2020-10-27 at 12:42 -0400, Mark Pearson wrote:
> > From: Hans de Goede <hdegoede@redhat.com>
> >
> > On modern systems the platform performance, temperature, fan and
> > other
> > hardware related characteristics are often dynamically configurable.
> > The
> > profile is often automatically adjusted to the load by somei
> > automatic-mechanism (which may very well live outside the kernel).
> >
> > These auto platform-adjustment mechanisms often can be configured
> > with
> > one of several 'platform-profiles', with either a bias towards low-
> > power

Strictly speaking, power is a rate, so it cannot be consumed.

So I would say "low-power operation" here.

> Can you please make sure to quote 'platform-profile' and 'profile-name'
> this way all through the document? They're not existing words, and
> quoting them shows that they're attribute names, rather than English.
>
> > consumption or towards performance (and higher power consumption and

And analogously here.

> > thermals).
>
> s/thermal/temperature/

Right.

> "A thermal" is something else (it's seasonal underwear for me ;)
>
> > Introduce a new platform_profile sysfs API which offers a generic API
> > for
> > selecting the performance-profile of these automatic-mechanisms.
> >
> > Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> > Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> > Changes in V1:
> >  - Moved from RFC to proposed patch
> >  - Added cool profile as requested
> >  - removed extra-profiles as no longer relevant
> >
> >  .../ABI/testing/sysfs-platform_profile        | 66
> > +++++++++++++++++++
> >  1 file changed, 66 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform_profile
> > b/Documentation/ABI/testing/sysfs-platform_profile
> > new file mode 100644
> > index 000000000000..240bd3d7532b
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-platform_profile
> > @@ -0,0 +1,66 @@
> > +Platform-profile selection (e.g.
> > /sys/firmware/acpi/platform_profile)
> > +
> > +On modern systems the platform performance, temperature, fan and
> > other
> > +hardware related characteristics are often dynamically configurable.
> > The
> > +profile is often automatically adjusted to the load by some
> > +automatic-mechanism (which may very well live outside the kernel).
> > +
> > +These auto platform-adjustment mechanisms often can be configured
> > with
> > +one of several 'platform-profiles', with either a bias towards low-
> > power
> > +consumption or towards performance (and higher power consumption and
> > +thermals).
> > +
> > +The purpose of the platform_profile attribute is to offer a generic
> > sysfs
> > +API for selecting the platform-profile of these automatic-
> > mechanisms.
> > +
> > +Note that this API is only for selecting the platform-profile, it is
> > +NOT a goal of this API to allow monitoring the resulting performance
> > +characteristics. Monitoring performance is best done with
> > device/vendor
> > +specific tools such as e.g. turbostat.
> > +
> > +Specifically when selecting a high-performance profile the actual
> > achieved
> > +performance may be limited by various factors such as: the heat
> > generated
> > +by other components, room temperature, free air flow at the bottom
> > of a
> > +laptop, etc. It is explicitly NOT a goal of this API to let
> > userspace know
> > +about any sub-optimal conditions which are impeding reaching the
> > requested
> > +performance level.
> > +
> > +Since numbers are a rather meaningless way to describe platform-
> > profiles
>
> It's not meaningless, but rather ambiguous. For a range of 1 to 5, is 1
> high performance, and 5 low power, or vice-versa?

It just is not useful. :-)

> > +this API uses strings to describe the various profiles. To make sure
> > that
> > +userspace gets a consistent experience when using this API this API
>
> you can remove "when using this API".
>
> > +document defines a fixed set of profile-names. Drivers *must* map
> > their
> > +internal profile representation/names onto this fixed set.
> > +
> > +If for some reason there is no good match when mapping then a new
> > profile-name
> > +may be added.
>
> "for some reason" can be removed.

Right.

> >  Drivers which wish to introduce new profile-names must:
> > +1. Have very good reasons to do so.
>
> "1. Explain why the existing 'profile-names' cannot be used"
>
> > +2. Add the new profile-name to this document, so that future drivers
> > which also
> > +   have a similar problem can use the same name.
>
> "2. Add the new 'profile-name' to the documentation so that other
> drivers can use it, as well as user-space knowing clearly what
> behaviour the 'profile-name' corresponds to"
>
> > +
> > +What:          /sys/firmware/acpi/platform_profile_choices
> > +Date:          October 2020
> > +Contact:       Hans de Goede <hdegoede@redhat.com>
> > +Description:
> > +               Reading this file gives a space separated list of
> > profiles
> > +               supported for this device.
>
> "This file contains a space-separated list of profiles..."
>
> > +
> > +               Drivers must use the following standard profile-
> > names:
> > +
> > +               low-power:              Emphasises low power
> > consumption

Let's be precise, so "low-power operation", please (see above for the reason).

> > +               cool:                   Emphasises cooler operation
> > +               quiet:                  Emphasises quieter operation
> > +               balanced:               Balance between low power
> > consumption

And same here and analogously everywhere.

> > +                                       and performance
> > +               performance:            Emphasises performance (and
> > may lead to
> > +                                       higher temperatures and fan
> > speeds)
>
> I'd replace "Emphasises" with either "Focus on" or the US English
> spelling of "Emphasizes".
>
> > +               Userspace may expect drivers to offer at least
> > several of these
> > +               standard profile-names.
>
> Replce "at least several" with "more than one".
>
> > +
> > +What:          /sys/firmware/acpi/platform_profile
> > +Date:          October 2020
> > +Contact:       Hans de Goede <hdegoede@redhat.com>
> > +Description:
> > +               Reading this file gives the current selected profile
> > for this
> > +               device. Writing this file with one of the strings
> > from
> > +               available_profiles changes the profile to the new
> > value.
>
> Is there another file which explains whether those sysfs value will
> contain a trailing linefeed?
>
> Cheers
>
