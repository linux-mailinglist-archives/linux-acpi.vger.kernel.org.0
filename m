Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEFA029E11A
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Oct 2020 02:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbgJ2BxG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 21:53:06 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:46990 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgJ1V5n (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 17:57:43 -0400
Received: from relay4-d.mail.gandi.net (unknown [217.70.183.196])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id E55933A5707;
        Wed, 28 Oct 2020 13:45:40 +0000 (UTC)
X-Originating-IP: 82.255.60.242
Received: from [192.168.0.28] (lns-bzn-39-82-255-60-242.adsl.proxad.net [82.255.60.242])
        (Authenticated sender: hadess@hadess.net)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id EA179E0004;
        Wed, 28 Oct 2020 13:45:15 +0000 (UTC)
Message-ID: <5ca1ae238b23a611b8a490c244fd93cdcc36ef79.camel@hadess.net>
Subject: Re: [PATCH] Documentation: Add documentation for new
 platform_profile sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Mark Pearson <markpearson@lenovo.com>
Cc:     dvhart@infradead.org, mgross@linux.intel.com,
        mario.limonciello@dell.com, eliadevito@gmail.com, bberg@redhat.com,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 28 Oct 2020 14:45:15 +0100
In-Reply-To: <20201027164219.868839-1-markpearson@lenovo.com>
References: <markpearson@lenovo.com>
         <20201027164219.868839-1-markpearson@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hey Hans, Mark,

On Tue, 2020-10-27 at 12:42 -0400, Mark Pearson wrote:
> From: Hans de Goede <hdegoede@redhat.com>
> 
> On modern systems the platform performance, temperature, fan and
> other
> hardware related characteristics are often dynamically configurable.
> The
> profile is often automatically adjusted to the load by somei
> automatic-mechanism (which may very well live outside the kernel).
> 
> These auto platform-adjustment mechanisms often can be configured
> with
> one of several 'platform-profiles', with either a bias towards low-
> power

Can you please make sure to quote 'platform-profile' and 'profile-name'
this way all through the document? They're not existing words, and
quoting them shows that they're attribute names, rather than English.

> consumption or towards performance (and higher power consumption and
> thermals).

s/thermal/temperature/

"A thermal" is something else (it's seasonal underwear for me ;)

> Introduce a new platform_profile sysfs API which offers a generic API
> for
> selecting the performance-profile of these automatic-mechanisms.
> 
> Co-developed-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Mark Pearson <markpearson@lenovo.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in V1:
>  - Moved from RFC to proposed patch
>  - Added cool profile as requested
>  - removed extra-profiles as no longer relevant
> 
>  .../ABI/testing/sysfs-platform_profile        | 66
> +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform_profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform_profile
> b/Documentation/ABI/testing/sysfs-platform_profile
> new file mode 100644
> index 000000000000..240bd3d7532b
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform_profile
> @@ -0,0 +1,66 @@
> +Platform-profile selection (e.g.
> /sys/firmware/acpi/platform_profile)
> +
> +On modern systems the platform performance, temperature, fan and
> other
> +hardware related characteristics are often dynamically configurable.
> The
> +profile is often automatically adjusted to the load by some
> +automatic-mechanism (which may very well live outside the kernel).
> +
> +These auto platform-adjustment mechanisms often can be configured
> with
> +one of several 'platform-profiles', with either a bias towards low-
> power
> +consumption or towards performance (and higher power consumption and
> +thermals).
> +
> +The purpose of the platform_profile attribute is to offer a generic
> sysfs
> +API for selecting the platform-profile of these automatic-
> mechanisms.
> +
> +Note that this API is only for selecting the platform-profile, it is
> +NOT a goal of this API to allow monitoring the resulting performance
> +characteristics. Monitoring performance is best done with
> device/vendor
> +specific tools such as e.g. turbostat.
> +
> +Specifically when selecting a high-performance profile the actual
> achieved
> +performance may be limited by various factors such as: the heat
> generated
> +by other components, room temperature, free air flow at the bottom
> of a
> +laptop, etc. It is explicitly NOT a goal of this API to let
> userspace know
> +about any sub-optimal conditions which are impeding reaching the
> requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe platform-
> profiles

It's not meaningless, but rather ambiguous. For a range of 1 to 5, is 1
high performance, and 5 low power, or vice-versa?

> +this API uses strings to describe the various profiles. To make sure
> that
> +userspace gets a consistent experience when using this API this API

you can remove "when using this API".

> +document defines a fixed set of profile-names. Drivers *must* map
> their
> +internal profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new
> profile-name
> +may be added.

"for some reason" can be removed.

>  Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.

"1. Explain why the existing 'profile-names' cannot be used"

> +2. Add the new profile-name to this document, so that future drivers
> which also
> +   have a similar problem can use the same name.

"2. Add the new 'profile-name' to the documentation so that other
drivers can use it, as well as user-space knowing clearly what
behaviour the 'profile-name' corresponds to"

> +
> +What:          /sys/firmware/acpi/platform_profile_choices
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:
> +               Reading this file gives a space separated list of
> profiles
> +               supported for this device.

"This file contains a space-separated list of profiles..."

> +
> +               Drivers must use the following standard profile-
> names:
> +
> +               low-power:              Emphasises low power
> consumption
> +               cool:                   Emphasises cooler operation
> +               quiet:                  Emphasises quieter operation
> +               balanced:               Balance between low power
> consumption
> +                                       and performance
> +               performance:            Emphasises performance (and
> may lead to
> +                                       higher temperatures and fan
> speeds)

I'd replace "Emphasises" with either "Focus on" or the US English
spelling of "Emphasizes".

> +               Userspace may expect drivers to offer at least
> several of these
> +               standard profile-names.

Replce "at least several" with "more than one".

> +
> +What:          /sys/firmware/acpi/platform_profile
> +Date:          October 2020
> +Contact:       Hans de Goede <hdegoede@redhat.com>
> +Description:
> +               Reading this file gives the current selected profile
> for this
> +               device. Writing this file with one of the strings
> from
> +               available_profiles changes the profile to the new
> value.

Is there another file which explains whether those sysfs value will
contain a trailing linefeed?

Cheers

