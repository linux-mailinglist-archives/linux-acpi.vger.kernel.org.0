Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844A4282E18
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Oct 2020 00:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJDW3u (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 4 Oct 2020 18:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgJDW3u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Oct 2020 18:29:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C638EC0613CE;
        Sun,  4 Oct 2020 15:29:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l16so140903eds.3;
        Sun, 04 Oct 2020 15:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4yLKaYo4XIK+RyZ/mSCyoM9p4n3zdL/L+O3joJQSGto=;
        b=YRtuiS9rvOcBGoaoqnpcWDVgAk353mdnXOiylTkQdU15hKTBdGDIHxv32WdRayqybZ
         J8GpATybGHzNpC51ohxXRRGjBNr20GMsr3/3cle4rVC2xvCiYxwG3jRc61xYeEx79WVH
         /lIw24YPRp+u+YiDJPVG9aOucwWxGkb3No+vHqENGT6x6lYYasGYghEKd44gxZg5Qsz2
         FljsM1zCFneuCILbSeX7WovF6YBDJt0Q52upXMOVZcPYDcH1MMnT/Z5QNlZVNoo4C7LH
         3YiyUgFuzHO5yeRON1GnM0+EIS2GQBEnT73kC0dCTv4cPMMhS+ZpRmcu5vzLHh0J67Nt
         4jdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4yLKaYo4XIK+RyZ/mSCyoM9p4n3zdL/L+O3joJQSGto=;
        b=Vpvjzntch0locr6WRDQekywdwHQpKczCzfJ0aRMqEyo8R3chfMTUrq9awyh4pZStDf
         pzMLH9N3es9nb5vmnqk1qWpO0Fas8U2reHCj91EY/eayHY+xgkfp5DRe54FndLaav0L/
         ZtWvCi1yIRdEa8ZUiJrPM7zxLs/wPAukgRZe5EstD4mao4a36WbICGkSfIroPBR27+TC
         c8LU0BMNl7ubpfuH+gE9jN3vfj7ooOLy1TGwmCG9ibvjJn42uHwc0AgUUtdt4FaSm2vH
         4In4IZ+1/awD25/lDHKwlg7NUwNgHAWkPn59dsezJ/LIfKzSvcTGQbpHIuFbHsqNMURN
         3MRA==
X-Gm-Message-State: AOAM532XPQNBDadP3VN9cLldL5YgQYxcJoHNZ/aad9sSE9UWTBXzyj7y
        J+8tjrshnuooPgg7ogMrr4k=
X-Google-Smtp-Source: ABdhPJwFFF0iaQdGUKCMMoq3Gx7+W1mqfUYpNMrfBaWa6+9xcUWUYabVHxIysevlHI/XN4f67UABYw==
X-Received: by 2002:a05:6402:6d3:: with SMTP id n19mr13809009edy.381.1601850587034;
        Sun, 04 Oct 2020 15:29:47 -0700 (PDT)
Received: from pce.localnet (host-79-12-92-76.retail.telecomitalia.it. [79.12.92.76])
        by smtp.gmail.com with ESMTPSA id o13sm4191055ejr.120.2020.10.04.15.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2020 15:29:46 -0700 (PDT)
From:   Elia Devito <eliadevito@gmail.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Pearson <markpearson@lenovo.com>
Subject: Re: [RFC] Documentation: Add documentation for new performance_profile sysfs class
Date:   Mon, 05 Oct 2020 00:29:44 +0200
Message-ID: <2051253.irdbgypaU6@pce>
In-Reply-To: <20201003131938.9426-2-hdegoede@redhat.com>
References: <20201003131938.9426-1-hdegoede@redhat.com> <20201003131938.9426-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On 2020-10-03 9:19 a.m., Hans de Goede wrote:
> On modern systems CPU/GPU/... performance is often dynamically configurable
> in the form of e.g. variable clock-speeds and TPD. The performance is often
> automatically adjusted to the load by some automatic-mechanism (which may
> very well live outside the kernel).
>
> These auto performance-adjustment mechanisms often can be configured with
> one of several performance-profiles, with either a bias towards low-power
> consumption (and cool and quiet) or towards performance (and higher power
> consumption and thermals).
>
> Introduce a new performance_profile class/sysfs API which offers a generic
> API for selecting the performance-profile of these automatic-mechanisms.
>
> Cc: Mark Pearson <markpearson@lenovo.com>
> Cc: Elia Devito <eliadevito@gmail.com>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: Benjamin Berg <bberg@redhat.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
> 1 file changed, 104 insertions(+)
> create mode 100644
> Documentation/ABI/testing/sysfs-class-performance_profile
>
> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile
> b/Documentation/ABI/testing/sysfs-class-performance_profile new file mode
> 100644
> index 000000000000..9c67cae39600
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
> @@ -0,0 +1,104 @@
> +Performance-profile selection (e.g.
> /sys/class/performance_profile/thinkpad_acpi/) +
> +On modern systems CPU/GPU/... performance is often dynamically configurable
> +in the form of e.g. variable clock-speeds and TPD. The performance is
> often +automatically adjusted to the load by some automatic-mechanism
> (which may +very well live outside the kernel).
> +
> +These auto performance-adjustment mechanisms often can be configured with
> +one of several performance-profiles, with either a bias towards low-power
> +consumption (and cool and quiet) or towards performance (and higher power
> +consumption and thermals).
> +
> +The purpose of the performance_profile class is to offer a generic sysfs
> +API for selecting the performance-profile of these automatic-mechanisms.
> +
> +Note that this API is only for selecting the performance-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high-performance profile the actual achieved
> +performance may be limited by various factors such as: the heat generated
> by +other components, room temperature, free air flow at the bottom of a
> laptop, +etc. It is explicitly NOT a goal of this API to let userspace know
> about +any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe performance-profiles
> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API
> document +defines a fixed set of profile-names. Drivers *must* map their
> internal +profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new
> profile-name +may be added. Drivers which wish to introduce new
> profile-names must: +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers which
> also +   have a similar problem can use the same new. Usually new
> profile-names will +   be added to the "extra profile-names" section of
> this document. But in some +   cases the set of standard profile-names may
> be extended.
> +
> +What:          /sys/class/performance_profile/<device>/
available_profiles
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:
> +               Reading this file gives a space separated list of profiles
> +               supported for this device.
> +
> +               Drivers must use the following standard profile-names 
whenever
> +               possible:
> +
> +               low-power:              Emphasises low power consumption
> +                                       (and also cool and 
quiet)
> +               balanced-low-power:     Balances between low power 
consumption
> +                                       and performance with a 
slight bias
> +                                       towards low power
> +               balanced:               Balance between low power 
consumption
> +                                       and performance
> +               balanced-performance:   Balances between performance and 
low
> +                                       power consumption with 
a slight bias
> +                                       towards performance
> +               performance:            Emphasises performance 
(and may lead to
> +                                       higher temperatures and 
fan speeds)
> +
> +               Userspace may expect drivers to offer at least several of 
these
> +               standard profile-names! If none of the above are a good 
match
> +               for some of the drivers profiles, then drivers may use 
one of
> +               these extra profile-names:
> +               <reserved for future use>
> +
> +What:          /sys/class/performance_profile/<device>/current_profile
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:
> +               Reading this file gives the current selected profile for 
this
> +               device. Writing this file with one of the strings from
> +               available_profiles changes the profile to the new value.
> +
> +               Reading this file may also return "custom". This is 
intended for
> +               drivers which have and export multiple knobs influencing
> +               performance. Such drivers may very well still want to 
offer a
> +               set of profiles for easy of use and to be able to offer a
> +               consistent standard API (this API) to userspace for 
configuring
> +               their performance. The "custom" value is intended for 
when a
> +               user has directly configured the knobs (through e.g. some
> +               advanced control-panel for a GPU) and the knob values do 
not
> +               match any of the presets represented by the
> +               performance-profiles. In this case writing this file will
> +               override the modifications and restore the selected 
presets.
> +
> +What:          /sys/class/performance_profile/<device>/type
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:
> +               Performance-profiles may be system-wide, or for a specific
> +               device (e.g. CPU / GPU). System-wide profiles are 
typically
> +               used on devices where where a single cooling solution is
> +               shared between all components, such as laptops and NUCs.
> +
> +               Reading this file indicates the type of the device for 
which
> +               the thermal-profile is being configured.
> +
> +               Valid values: "system"
> +               Reserved for future use values: "cpu", "gpu"
> --
> 2.28.0

This looks good to me, the only consideration I have is that in my opinion the
quiet profile and the cool profile should not necessarily match the low-power
state because the quiet profile could cause thermal throttling without
benefiting consumption, instead the cool profile (with the fans almost
always on) would lead to an unnecessary increase in noise.

another question is the notebooks that offer both quiet and cool profile,
which profile should be associated as low power?

wouldn't it be better not to associate any of the 2 profiles with low-power
status and eventually expose them through another API maybe setting to
"custom" the current_profile value as you proposed for GPU knobs?

otherwise it seems to me an excellent solution

Elia


