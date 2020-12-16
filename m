Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F102DC695
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Dec 2020 19:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgLPSfG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Dec 2020 13:35:06 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44484 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731189AbgLPSfG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2020 13:35:06 -0500
Received: by mail-ot1-f45.google.com with SMTP id f16so23950169otl.11;
        Wed, 16 Dec 2020 10:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDhlmX3bOHuQ3YagDpzzTNcnQ3/dGgwNQfE6KmwBih8=;
        b=Z+xL7JNdHso/PwWhwp1pT5hEjZXMP2+6AMa81MldVGPh2JFufG2jQ2w973eRL6tifn
         ptQgju2MtTAz6C6H4bcoULz+Z6IoFdEYMiN4sgKoHCnmdEv4sbkFQqEmYdHRuG4OOFI7
         BGLKVUkFP6nitdrRQyffk2GOFwrM5KBPrYGCuHaTtPAyg5ZyUyVn3+D1AE/zDL096Ycr
         dB3ExDKGD8HcGkatO9fNtT45FZwz2QmjajVwy9lPqjlGQq3G9A0zHcSclIuOwVOyyZ44
         1LOy1JRzGyidEWW0ij8xGBNsMfUqJmMbLpFOF73cbgORROqbbXoJj7qaAx0k86nUeCVQ
         XcHA==
X-Gm-Message-State: AOAM5319y9Picm5j35iPMEWG/aSrelbhtnGorQQcm6UJdVnowWfL2JJx
        qxI8b22enekJ56aree320kf5Zk+LRfSINxKrsuo=
X-Google-Smtp-Source: ABdhPJx6NI5SJdpo2pP9knW2UKo4JR39I9y8IY8V2svBJpR3tC7/yrWa09X0GUdZo3TKyaaxPzA0vvGsblsBH3qETCE=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr25016447ota.260.1608143664907;
 Wed, 16 Dec 2020 10:34:24 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201211020630.305905-1-markpearson@lenovo.com>
In-Reply-To: <20201211020630.305905-1-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Dec 2020 19:34:13 +0100
Message-ID: <CAJZ5v0gZ72pPUjvWrMTVjgh3NWc2OCDWum+xV69dF05znuBL8A@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] Documentation: Add documentation for new
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
        Darren Hart <dvhart@infradead.org>, njosh1@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Dec 11, 2020 at 3:15 AM Mark Pearson <markpearson@lenovo.com> wrote:
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
>
>  .../ABI/testing/sysfs-platform_profile        | 24 +++++++++++
>  Documentation/userspace-api/index.rst         |  1 +
>  .../userspace-api/sysfs-platform_profile.rst  | 43 +++++++++++++++++++
>  3 files changed, 68 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
>  create mode 100644 Documentation/userspace-api/sysfs-platform_profile.rst
>
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..5ac14268585f
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
> +               available_profiles changes the profile to the new value.

IIUC s/available_profiles/platform_profile_choices/

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
> index 000000000000..56639d218003
> --- /dev/null
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -0,0 +1,43 @@
> +=====================================================================
> +Platform Profile Selection (e.g. /sys/firmware/acpi/platform_profile)
> +=====================================================================
> +
> +On modern systems the platform performance, temperature, fan and other
> +hardware related characteristics are often dynamically configurable. The
> +profile is often automatically adjusted to the load by some

After reading this one more time it looks to me like referring to the
profile here is premature, it needs to be defined first.

Maybe say "The platform configuration is often ..."

Iit is also unclear what "the load" means here, so I would say
something like "adjusted to the current conditions" to avoid using
that term.

> +automatic mechanism (which may very well live outside the kernel).
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
