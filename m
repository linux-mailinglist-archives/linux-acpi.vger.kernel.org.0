Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC172E0E8B
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Dec 2020 20:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgLVTFq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Dec 2020 14:05:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37132 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLVTFq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Dec 2020 14:05:46 -0500
Received: by mail-ot1-f52.google.com with SMTP id o11so12859002ote.4;
        Tue, 22 Dec 2020 11:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fgq5ug8DhG4hXU3luoLCpE4N98cyz+pyyX4Bzyufy2k=;
        b=st8AyLqkElcxbPG6ivDyS7ZuhnmGLSEvtLloUXFil4hfCZJDFDckl5kSuKj7MIsMqz
         4ULFVZK/1b6hQU2ShRiSjDWRQuT2WQRcVLzibi3ufoiF27zurC+roKDPU8Mdw+LbX/nV
         cMgD7cvx8+yHR02HqGRcU02Oss7dSTKeETW04vCYaK3J+UZimWZ29kOP6Xy6EibPPgIP
         eCLOry09AJB9r6Ibt/z/ecCMF2+5/7Rlyhzc9YPpMfl5YW3qGRDQ0//iobURwK4EoJFM
         WAYHPqRDHk5LmG1miWuJovW53iqAtjirelm478ustZuxQkTXOetrVJuh6rc3ih9JDdRr
         Ge0Q==
X-Gm-Message-State: AOAM531gMWvxaxrPycR6VVFAqAIARV/4qka1K0f2OmdMctBZvzeFO+u7
        OGiFIJKuGc4qxCWbFKCJSrQRBK044ArKQjZSjs0=
X-Google-Smtp-Source: ABdhPJwdBXE2Upm+lmcyp7jbD1oF7lJKVbLAtQD1FX9fOYp8KcGsdZZ8/Ofe/lIGF5jW5G57or5smVyD2OcuZ5Yo5bE=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr17182133otn.321.1608663904838;
 Tue, 22 Dec 2020 11:05:04 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201218174759.667457-1-markpearson@lenovo.com>
In-Reply-To: <20201218174759.667457-1-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Dec 2020 20:04:53 +0100
Message-ID: <CAJZ5v0g5buTCCJ15Hk3_4dBmk+_yoY2=wVpv4aQPeJoyZQLbBA@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Elia Devito <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        Darren Hart <dvhart@infradead.org>, njoshi1@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 18, 2020 at 6:54 PM Mark Pearson <markpearson@lenovo.com> wrote:
>
> On modern systems the platform performance, temperature, fan and other
> hardware related characteristics are often dynamically configurable. The
> profile is often automatically adjusted to the load by some
> automatic-mechanism (which may very well live outside the kernel).
>
> These auto platform-adjustment mechanisms often can be configured with
> one of several 'platform-profiles', with either a bias towards low-power
> consumption or towards performance (and higher power consumption and
> thermals).
>
> Introduce a new platform_profile sysfs API which offers a generic API for
> selecting the performance-profile of these automatic-mechanisms.
>
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
>  - updated to rst format
> Changes in v3, v4, v5
>  - version bump along with rest of patch series
> Changes in v6:
>  - Split sysfs-platform_profile.rs into ABI text and then admin guide in
>    userspace-api section. Hope this is correct - I'm guessing a bit.
> Changes in v7:
>  - Correct available_choices to platform_profile_choices
>  - Improve phrasing as recommended by review
>
>  .../ABI/testing/sysfs-platform_profile        | 24 ++++++++++
>  Documentation/userspace-api/index.rst         |  1 +
>  .../userspace-api/sysfs-platform_profile.rst  | 44 +++++++++++++++++++
>  3 files changed, 69 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
>  create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst
>
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..9d6b89b66cca
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -0,0 +1,24 @@
> +What:          /sys/firmware/acpi/platform_profile_choices
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:   This file contains a space-separated list of profiles supported for this device.
> +
> +               Drivers must use the following standard profile-names:
> +
> +               ============    ============================================
> +               low-power       Low power consumption
> +               cool            Cooler operation
> +               quiet           Quieter operation
> +               balanced        Balance between low power consumption and performance
> +               performance     High performance operation
> +               ============    ============================================
> +
> +               Userspace may expect drivers to offer more than one of these
> +               standard profile names.
> +
> +What:          /sys/firmware/acpi/platform_profile
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:   Reading this file gives the current selected profile for this
> +               device. Writing this file with one of the strings from
> +               platform_profile_choices changes the profile to the new value.
> diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
> index acd2cc2a538d..d29b020e5622 100644
> --- a/Documentation/userspace-api/index.rst
> +++ b/Documentation/userspace-api/index.rst
> @@ -24,6 +24,7 @@ place where this information is gathered.
>     ioctl/index
>     iommu
>     media/index
> +   sysfs-platform_profile
>
>  .. only::  subproject and html
>
> diff --git a/Documentation/userspace-api/sysfs-platform_profile.rst b/Documentation/userspace-api/sysfs-platform_profile.rst
> new file mode 100644
> index 000000000000..046bf2f3ffd0
> --- /dev/null
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -0,0 +1,44 @@
> +=====================================================================
> +Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
> +=====================================================================
> +
> +On modern systems the platform performance, temperature, fan and other
> +hardware related characteristics are often dynamically configurable. The
> +platform configuration is often automatically adjusted to the current
> +conditions by some automatic mechanism (which may very well live outside
> +the kernel).
> +
> +These auto platform adjustment mechanisms often can be configured with
> +one of several platform profiles, with either a bias towards low power
> +operation or towards performance.
> +
> +The purpose of the platform_profile attribute is to offer a generic sysfs
> +API for selecting the platform profile of these automatic mechanisms.
> +
> +Note that this API is only for selecting the platform profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high performance profile the actual achieved
> +performance may be limited by various factors such as: the heat generated
> +by other components, room temperature, free air flow at the bottom of a
> +laptop, etc. It is explicitly NOT a goal of this API to let userspace know
> +about any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers on their own cannot represent the multiple variables that a
> +profile will adjust (power consumption, heat generation, etc) this API
> +uses strings to describe the various profiles. To make sure that userspace
> +gets a consistent experience the sysfs-platform_profile ABI document defines
> +a fixed set of profile names. Drivers *must* map their internal profile
> +representation onto this fixed set.
> +
> +If there is no good match when mapping then a new profile name may be
> +added. Drivers which wish to introduce new profile names must:
> +
> + 1. Explain why the existing profile names canot be used.
> + 2. Add the new profile name, along with a clear description of the
> +    expected behaviour, to the sysfs-platform_profile ABI documentation.
> +
> +
> --

Applied as 5.11-rc material with the two extra empty lines at the end
of the new file dropped, thanks!
