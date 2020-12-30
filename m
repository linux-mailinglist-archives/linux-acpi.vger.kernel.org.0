Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215432E7BA0
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 18:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3Rgr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 12:36:47 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:42490 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgL3Rgr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Dec 2020 12:36:47 -0500
Received: by mail-ot1-f48.google.com with SMTP id 11so15942489oty.9;
        Wed, 30 Dec 2020 09:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWnS6I8UEx94mp4jO4CRVu1zT+7oC6nWHWCtpIaNNJU=;
        b=pdobmfV3ieKjdaUCe3MxHV4QHt+/zzwKBTIS+/8sIiZXABWPpNqMXKpmFCLCJp7+tQ
         LUIAwUs0PKQtOIZ7CEbzzQa4mQ8FGa45S1/hMrOThJ/esrhaAGCRsgkK991NeHdsNQLw
         JAwhK5fXiFk2t32VvQo7Cm6IzlHc2GsNs5gZ+zV5QnvkhS9N/mOnNEQ48r/ap0pYZWKp
         fzSN9e1J1PdbTogaQ/649018FihgiMevwgZZNhshnN7JTNfkGvOYb7JZEJKUEmCM3d9H
         w7G6d/42ice/qEwerBqklsS1IUsvY0mvizDqo5AwWvY0GpA0C8wAcJkECj1ThcnrjLLe
         Zs1g==
X-Gm-Message-State: AOAM530lulXceGQ0om2dXVlU0qghPdZrCR5LbmUw5pajKm2ZqB3pS4W7
        dKb7/9V+T23AZ58iixCCDeX+b+HfWOld15Kf8tw=
X-Google-Smtp-Source: ABdhPJzNw86skedRcIC0BMM58zjOg1ottUR8MHfDXqu5oTG3/88yzIZ9WF3y6+8QG81eE4oyluy27N8Obgb1N2yJK3M=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr40422141otn.321.1609349765726;
 Wed, 30 Dec 2020 09:36:05 -0800 (PST)
MIME-Version: 1.0
References: <markpearson@lenovo.com> <20201230001827.3745-1-markpearson@lenovo.com>
In-Reply-To: <20201230001827.3745-1-markpearson@lenovo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 30 Dec 2020 18:35:53 +0100
Message-ID: <CAJZ5v0hv12N4y=ZmjKwry4jGckyrQFBB5pNKgjHNG=dMzqfkvg@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] Documentation: Add documentation for new
 platform_profile sysfs attribute
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 30, 2020 at 1:24 AM Mark Pearson <markpearson@lenovo.com> wrote:
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

Applied, thanks!

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
> Changes in v8:
>  - Removed unnecessary empty lines at end of file
>
>  .../ABI/testing/sysfs-platform_profile        | 24 +++++++++++
>  Documentation/userspace-api/index.rst         |  1 +
>  .../userspace-api/sysfs-platform_profile.rst  | 42 +++++++++++++++++++
>  3 files changed, 67 insertions(+)
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
> index 000000000000..c33a71263d9e
> --- /dev/null
> +++ b/Documentation/userspace-api/sysfs-platform_profile.rst
> @@ -0,0 +1,42 @@
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
> --
> 2.28.0
>
