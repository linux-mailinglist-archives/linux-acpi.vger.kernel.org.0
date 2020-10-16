Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168229082A
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 17:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409960AbgJPPQv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 11:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409831AbgJPPQv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 11:16:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6956C061755;
        Fri, 16 Oct 2020 08:16:50 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 13so2831451wmf.0;
        Fri, 16 Oct 2020 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oggAz0krhkvu30uZh4UQkIbc7V8gZUvgoTVCVVa355Y=;
        b=evcRpC8FcRK+gEWdPtIJnl1rNeY9E5ZIvNeuFsU5iwSXMcFtImXIG9hXOcaLWkqnWn
         BZKz6N9aztIZsOqq9Oi2K/AY77ISHeHjx/7TMMJ4NNEKvK87jWuRuKIZMdnjklqj6dM0
         T6guhGXROpvm4VOtGpNuBL3N82VIWdBEfTkZLu5wUnWrbyEnZsBgARQZkVviEiJM1zRs
         ghRtDz8ML28kBuVVwZYkRJCfQLvjd9LG7pCmUzP8oKaOsL3TL5Mhj9TkJO+uRF6DQt8D
         Mq5G5E3M7xaSqthLwpxB5j4V2zv6XlYmLZEPNP4n4rzACp3ITc5ZWbpSLyP3GoOgerLu
         RGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oggAz0krhkvu30uZh4UQkIbc7V8gZUvgoTVCVVa355Y=;
        b=IZm1idfeeYoJbDPwZ/EQa2/Hj7p9vgTCrIiUJQ7+/dKzP/FQETl0sJBPrWTZXhUgEL
         WooON0AUe8YCN77mHC7NuEhblJhyTF+DPyjgNcKq7+Bwq3Ax+YmooczoWShtKOnYvj4c
         SU4cLAZmozH2zxY//WIKwnsvaXu12bkVv1ieutNDY3Hbda1ncCNJnTJp+noZ9DUyt1df
         hUp8MfAOqutVgKvN+jnkPVHjuOibNDsoVJF1AlWRvdJf+6o8gCCLtadrQh4dHPpJgM0c
         BFjZ0IoOBB0vKx3+QgBbs2iIf0mcb3TCye8v/bum4AW7MndJoSPsPBI5Yuc3OKD/Jlbl
         vwqg==
X-Gm-Message-State: AOAM5320MwBUIhdNAXxjtsNxWNysSi6aq55dLDkLioc0IGqeYJ/tRctX
        qTzkrKQQNJGgQuRFU4HiqZQ=
X-Google-Smtp-Source: ABdhPJxVwbmPm8vZ0M+N9JtYQhOhyKwmKOctnAIMdOvbAb6s967whgwyI+XJKXOouNIhG1cAMQoVNA==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr4522871wmb.121.1602861409469;
        Fri, 16 Oct 2020 08:16:49 -0700 (PDT)
Received: from pce.localnet (host-80-117-125-178.pool80117.interbusiness.it. [80.117.125.178])
        by smtp.gmail.com with ESMTPSA id s2sm3191992wmf.45.2020.10.16.08.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 08:16:48 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
Cc:     aniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        "Limonciello, Mario" <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Benjamin Berg <bberg@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: Fw: [External] Re: [RFC] Documentation: Add documentation for new performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework)
Date:   Fri, 16 Oct 2020 17:16:46 +0200
Message-ID: <5679624.lOV4Wx5bFT@pce>
In-Reply-To: <f9163f54-9379-89f6-aaaf-e2d5084051df@lenovo.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org> <HK2PR0302MB2449214B28438ADC1790D468BD030@HK2PR0302MB2449.apcprd03.prod.outlook.com> <f9163f54-9379-89f6-aaaf-e2d5084051df@lenovo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

In data venerd=EC 16 ottobre 2020 16:43:09 CEST, Mark Pearson ha scritto:
> <Note - switched my email address to my more open source non-outlook
> based address>
>=20
> On 2020-10-16 10:32 a.m., Mark Pearson wrote:
> > ------------------------------------------------------------------------
> > *From:* Elia Devito <eliadevito@gmail.com>
> > *Sent:* October 16, 2020 10:26
> > *To:* Rafael J. Wysocki <rafael@kernel.org>; Hans de Goede
> > <hdegoede@redhat.com>
> > *Cc:* Daniel Lezcano <daniel.lezcano@linaro.org>; Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>; Lukasz Luba
> > <lukasz.luba@arm.com>; Linux Kernel Mailing List
> > <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>;
> > Zhang, Rui <rui.zhang@intel.com>; Bastien Nocera <hadess@hadess.net>;
> > Mark Pearson <mpearson@lenovo.com>; Limonciello, Mario
> > <Mario.Limonciello@dell.com>; Darren Hart <dvhart@infradead.org>; Andy
> > Shevchenko <andy@infradead.org>; Mark Gross <mgross@linux.intel.com>;
> > Benjamin Berg <bberg@redhat.com>; linux-acpi@vger.kernel.org
> > <linux-acpi@vger.kernel.org>; platform-driver-x86@vger.kernel.org
> > <platform-driver-x86@vger.kernel.org>
> > *Subject:* [External] Re: [RFC] Documentation: Add documentation for new
> > performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add
> > the DTPM framework)
> > Hi,
> >=20
> > In data venerd=EC 16 ottobre 2020 13:10:54 CEST, Hans de Goede ha scrit=
to:
> >> <note folding the 2 threads we are having on this into one, adding eve=
ry
> >> one from both threads to the Cc>
> >>=20
> >> Hi,
> >>=20
> >> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
> >> > On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com>=
=20
wrote:
> >> >> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
> >> <snip>
> >>=20
> >> >>> First, a common place to register a DPTF system profile seems to be
> >> >>> needed and, as I said above, I wouldn't expect more than one such
> >> >>> thing to be present in the system at any given time, so it may be
> >> >>> registered along with the list of supported profiles and user space
> >> >>> will have to understand what they mean.
> >> >>=20
> >> >> Mostly Ack, I would still like to have an enum for DPTF system
> >> >> profiles in the kernel and have a single piece of code map that
> >> >> enum to profile names. This enum can then be extended as
> >> >> necessary, but I want to avoid having one driver use
> >> >> "Performance" and the other "performance" or one using
> >> >> "performance-balanced" and the other "balanced-performance", etc.
> >> >>=20
> >> >> With the goal being that new drivers use existing values from
> >> >> the enum as much as possible, but we extend it where necessary.
> >> >=20
> >> > IOW, just a table of known profile names with specific indices assig=
ned
> >> > to
> >> > them.
> >>=20
> >> Yes.
> >>=20
> >> > This sounds reasonable.
> >> >=20
> >> >>> Second, irrespective of the above, it may be useful to have a
> >> >>> consistent way to pass performance-vs-power preference information
> >> >>> from user space to different parts of the kernel so as to allow th=
em
> >> >>> to adjust their operation and this could be done with a system-wide
> >> >>> power profile attribute IMO.
> >> >>=20
> >> >> I agree, which is why I tried to tackle both things in one go,
> >> >> but as you said doing both in 1 API is probably not the best idea.
> >> >> So I believe we should park this second issue for now and revisit it
> >> >> when we find a need for it.
> >> >=20
> >> > Agreed.
> >> >=20
> >> >> Do you have any specific userspace API in mind for the
> >> >> DPTF system profile selection?
> >> >=20
> >> > Not really.
> >>=20
> >> So before /sys/power/profile was mentioned, but that seems more like
> >> a thing which should have a set of fixed possible values, iow that is
> >> out of scope for this discussion.
> >>=20
> >> Since we all seem to agree that this is something which we need
> >> specifically for DPTF profiles maybe just add:
> >>=20
> >> /sys/power/dptf_current_profile    (rw)
> >> /sys/power/dptf_available_profiles (ro)
> >>=20
> >> (which will only be visible if a dptf-profile handler
> >>
> >>  has been registered) ?
> >>
> >> Or more generic and thus better (in case other platforms
> >> later need something similar) I think, mirror the:
> >>=20
> >> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
> >> for a system-wide energy-performance setting, so we get:
> >>=20
> >> /sys/power/energy_performance_preference
> >> /sys/power/energy_performance_available_preferences
> >>=20
> >> (again only visible when applicable) ?
> >>=20
> >> I personally like the second option best.
> >>=20
> >> Regards,
> >>=20
> >> Hans
> >=20
> > between the two, the second seems to me more appropriate.
> > Considering that the various profiles interact with thermal behaviors
> > what do
> > you think of something like:
> >=20
> > /sys/power/thermal_profile_available_profiles
> > /sys/power/thermal_profile_profile
> >=20
> > Regards,
> > Elia
>=20
> I'm good with either but I do find 'profile_profile' slightly awkward to
> say out loud (even though it's logically correct :))
>=20
> How about just:
> /sys/power/platform_profile
> /sys/power/platform_profile_available
>=20
> As it covers the platform as a whole - fans, temperature, power, and
> anything else that ends up getting thrown in?
>=20
> Mark

Completely agree,  I made a typo xD

Elia


