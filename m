Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2329071E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 16:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406826AbgJPO0U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 10:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390724AbgJPO0T (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Oct 2020 10:26:19 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C02C061755;
        Fri, 16 Oct 2020 07:26:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x7so3174037wrl.3;
        Fri, 16 Oct 2020 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RpHL2pmcG7XNMxRENeUpmnEYfg0F72pinXyJP1jJFB8=;
        b=SmmMkUw2n6WZdR0N52P05/GmD5Oo5yyLda9sROnFISetU7nBx+EL+EYbxviRgOYD4w
         XXlwaA4lzppI5vziBVE0+ISQVMnjzRMJe4pyVIx451NhcPj5nGB6XdPYKZbowidlCbQJ
         0FjmiiPw8sWlNkZvDv58qzOIBsHuvsqPhQX6GVy18VygS/1rVJ+99xlMo9BSkWf/dpR1
         xAtIIgx3m+Z8Z7FaxZpl6VmYO2MWNsfvOdO9R6VU0SA8zi+NpvAMkmz2eiN3YIfvAqkl
         aMOtE++fnAt0vzpl4OjbjjtAHZkzyCwmt1cfMr4aF/P5Z/ym4sTo8/wYAJcR9x+1gn50
         brhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RpHL2pmcG7XNMxRENeUpmnEYfg0F72pinXyJP1jJFB8=;
        b=Bl8aPoggZKv/ivcnBBKM3YkO0nwyYILEYzzivkwboix61zPYx9eNu6MMIYE8M6tSBI
         FERsrw1PyTMckCOVLYnVl7QffY1ZvLpxv18cBhuvdRWudm09L5IAg6t9WMHtxJa0PCVw
         kYlths6ODhFAYE3soBEjfHPNDstDE9HSN+zXZuBh8Hrq1T4170IBm2dlgmhQvLeag/hs
         ECG9Yu9Jt424yu9L/WFLuRuQQyO6TseUA4mq96zbr1bbd61yoeCgbUBlXAVPK/8Hekwr
         euTTiClZ/MOWJZS2GS9BLwT1rVNN8rxngqPd8GHOvhGM9zSkRjX+ZLOURspFjucmmoYl
         m13Q==
X-Gm-Message-State: AOAM531kIWpzoqSrj05bWQAzZRv8GhWZIH0+h3UYmOx6eRC9DnEvNtpg
        pUpgrmu4L8WpszavYd0X53o=
X-Google-Smtp-Source: ABdhPJxOXM7pkhmb/DdXwtIspFFXCqiiNtkftB3jeaUYVxEHwrZdhEZr99bZiJuOICg0fa6LMZ3f6g==
X-Received: by 2002:adf:ed07:: with SMTP id a7mr4443771wro.326.1602858376481;
        Fri, 16 Oct 2020 07:26:16 -0700 (PDT)
Received: from pce.localnet (host-80-117-125-178.retail.telecomitalia.it. [80.117.125.178])
        by smtp.gmail.com with ESMTPSA id i33sm3823963wri.79.2020.10.16.07.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:26:15 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
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
        Benjamin Berg <bberg@redhat.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [RFC] Documentation: Add documentation for new performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the DTPM framework)
Date:   Fri, 16 Oct 2020 16:26:13 +0200
Message-ID: <4600468.GXAFRqVoOG@pce>
In-Reply-To: <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org> <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com> <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

In data venerd=EC 16 ottobre 2020 13:10:54 CEST, Hans de Goede ha scritto:
> <note folding the 2 threads we are having on this into one, adding every =
one
> from both threads to the Cc>
>=20
> Hi,
>=20
> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
> > On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wro=
te:
> >> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
> <snip>
>=20
> >>> First, a common place to register a DPTF system profile seems to be
> >>> needed and, as I said above, I wouldn't expect more than one such
> >>> thing to be present in the system at any given time, so it may be
> >>> registered along with the list of supported profiles and user space
> >>> will have to understand what they mean.
> >>=20
> >> Mostly Ack, I would still like to have an enum for DPTF system
> >> profiles in the kernel and have a single piece of code map that
> >> enum to profile names. This enum can then be extended as
> >> necessary, but I want to avoid having one driver use
> >> "Performance" and the other "performance" or one using
> >> "performance-balanced" and the other "balanced-performance", etc.
> >>=20
> >> With the goal being that new drivers use existing values from
> >> the enum as much as possible, but we extend it where necessary.
> >=20
> > IOW, just a table of known profile names with specific indices assigned=
 to
> > them.
> Yes.
>=20
> > This sounds reasonable.
> >=20
> >>> Second, irrespective of the above, it may be useful to have a
> >>> consistent way to pass performance-vs-power preference information
> >>> from user space to different parts of the kernel so as to allow them
> >>> to adjust their operation and this could be done with a system-wide
> >>> power profile attribute IMO.
> >>=20
> >> I agree, which is why I tried to tackle both things in one go,
> >> but as you said doing both in 1 API is probably not the best idea.
> >> So I believe we should park this second issue for now and revisit it
> >> when we find a need for it.
> >=20
> > Agreed.
> >=20
> >> Do you have any specific userspace API in mind for the
> >> DPTF system profile selection?
> >=20
> > Not really.
>=20
> So before /sys/power/profile was mentioned, but that seems more like
> a thing which should have a set of fixed possible values, iow that is
> out of scope for this discussion.
>=20
> Since we all seem to agree that this is something which we need
> specifically for DPTF profiles maybe just add:
>=20
> /sys/power/dptf_current_profile    (rw)
> /sys/power/dptf_available_profiles (ro)
>=20
> (which will only be visible if a dptf-profile handler
>  has been registered) ?
>=20
> Or more generic and thus better (in case other platforms
> later need something similar) I think, mirror the:
>=20
> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
> for a system-wide energy-performance setting, so we get:
>=20
> /sys/power/energy_performance_preference
> /sys/power/energy_performance_available_preferences
>=20
> (again only visible when applicable) ?
>=20
> I personally like the second option best.
>=20
> Regards,
>=20
> Hans

between the two, the second seems to me more appropriate.
Considering that the various profiles interact with thermal behaviors what =
do=20
you think of something like:

/sys/power/thermal_profile_available_profiles
/sys/power/thermal_profile_profile

Regards,
Elia



