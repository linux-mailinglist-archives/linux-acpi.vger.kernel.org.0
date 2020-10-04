Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2182827D5
	for <lists+linux-acpi@lfdr.de>; Sun,  4 Oct 2020 03:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgJDBdd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 3 Oct 2020 21:33:33 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.115]:44260 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbgJDBdd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Oct 2020 21:33:33 -0400
Received: from [100.112.5.40] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-c.us-east-1.aws.symcld.net id 9F/BC-22503-866297F5; Sun, 04 Oct 2020 01:33:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRWlGSWpSXmKPExsWSLveKXTdDrTL
  eYNE6cYtJM/4zW+y/LmHRtdDAYuH9U6wWX7/dZrd4c3w6k8Xyff2MFpd3zWGz+Nx7hNGiqbMJ
  yOqYzGKxes8LZgcej0kzZzB77Jx1l93j17Y1LB6bV2h5zDsZ6PF+31U2j8+b5ALYo1gz85LyK
  xJYM750HWUpaDCraLx8n62B8YlOFyMXh5DAf0aJDe3vmSCcZ4wSq1ddYeti5OQQFkiXeDyphQ
  UkISIwnVHi+6vV7CAOs8BRJolzTzYwdjFyALWkSFw8ownSwCagLbFlyy+wZl4BW4mNV1ewgtg
  sAioS2+5cBrNFBSIk1hyfyARRIyhxcuYTFhCbU8BCYsbduWC9zED2zPnnGSFscYlbT+YzQdjy
  EtvfzmEGsSWA7Od/VrBD2AkSy17eYZ7AKDgLydhZSEbNQjJqFpJRCxhZVjGaJRVlpmeU5CZm5
  ugaGhjoGhoa6ZrpGloY6yVW6SbrlRbrpiYWl+ga6iWWF+sVV+Ym56To5aWWbGIExmNKAdv2HY
  x7X3/QO8QoycGkJMq7aHdFvBBfUn5KZUZicUZ8UWlOavEhRg0ODoErB4/MZpRiycvPS1WS4D2
  qUhkvJFiUmp5akZaZA0wZMKUSHDxKIrzuqkBp3uKCxNzizHSI1ClGRSlx3tnyQAkBkERGaR5c
  GyxNXWKUlRLmZWRgYBDiKUgtys0sQZV/xSjOwagkzMsBMp4nM68EbvoroMVMQItvH60AWVySi
  JCSamCKL3XLkZZ/qvBK4ExYeO1anutHbjJ2L5utuuOggsOu9evspqoHTj5jmbnaKmOV197P3x
  W+bOacvGtXc5u7UoJJQoLg3StZ0i8NfZ2zbFX8e61iGNbxz2dNqzB+2b565aPAiG/R24O5vnF
  c81igOpnHd+vxhpmTH2f4HRO8mCdrL1G+iz15slLJ0VWLjH6Hf59Q6XaIWUBxhcNs5YScWoXr
  fTceKUT9uKI/6UFu89z86/7Zt548OTeL//Pa43dOCM5mncm4gVk/uSksYWmIY0v2hwnc+31FS
  y782nFmlsTE3yubmDOzTF6dM/y6ZOGCFaHvK+/zr/K6U77bvOb+AUazU1URCx7MiW5Z4LFEe1
  aKEktxRqKhFnNRcSIAE7/Rac4DAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-13.tower-406.messagelabs.com!1601775205!1008834!1
X-Originating-IP: [103.30.234.7]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16824 invoked from network); 4 Oct 2020 01:33:27 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.7)
  by server-13.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Oct 2020 01:33:27 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id C11DAC8022744C3B0A04;
        Sun,  4 Oct 2020 09:33:22 +0800 (CST)
Received: from localhost.localdomain (10.46.54.95) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Sat, 3 Oct 2020
 18:33:18 -0700
Subject: Re: [External] [RFC] Documentation: Add documentation for new
 performance_profile sysfs class
To:     Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>
CC:     Mario Limonciello <mario.limonciello@dell.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Elia Devito <eliadevito@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Benjamin Berg <bberg@redhat.com>, <linux-pm@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20201003131938.9426-1-hdegoede@redhat.com>
 <20201003131938.9426-2-hdegoede@redhat.com>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <99924aaa-3f54-63df-5ce7-2d78d4f31d63@lenovo.com>
Date:   Sat, 3 Oct 2020 21:33:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201003131938.9426-2-hdegoede@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.46.54.95]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
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
>   .../testing/sysfs-class-performance_profile   | 104 ++++++++++++++++++
>   1 file changed, 104 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-performance_profile
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-performance_profile b/Documentation/ABI/testing/sysfs-class-performance_profile
> new file mode 100644
> index 000000000000..9c67cae39600
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-performance_profile
> @@ -0,0 +1,104 @@
> +Performance-profile selection (e.g. /sys/class/performance_profile/thinkpad_acpi/)
> +
> +On modern systems CPU/GPU/... performance is often dynamically configurable
> +in the form of e.g. variable clock-speeds and TPD. The performance is often
> +automatically adjusted to the load by some automatic-mechanism (which may
> +very well live outside the kernel).
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
> +performance may be limited by various factors such as: the heat generated by
> +other components, room temperature, free air flow at the bottom of a laptop,
> +etc. It is explicitly NOT a goal of this API to let userspace know about
> +any sub-optimal conditions which are impeding reaching the requested
> +performance level.
> +
> +Since numbers are a rather meaningless way to describe performance-profiles
> +this API uses strings to describe the various profiles. To make sure that
> +userspace gets a consistent experience when using this API this API document
> +defines a fixed set of profile-names. Drivers *must* map their internal
> +profile representation/names onto this fixed set.
> +
> +If for some reason there is no good match when mapping then a new profile-name
> +may be added. Drivers which wish to introduce new profile-names must:
> +1. Have very good reasons to do so.
> +2. Add the new profile-name to this document, so that future drivers which also
> +   have a similar problem can use the same new. Usually new profile-names will
> +   be added to the "extra profile-names" section of this document. But in some
> +   cases the set of standard profile-names may be extended.
> +
> +What:		/sys/class/performance_profile/<device>/available_profiles
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives a space separated list of profiles
> +		supported for this device.
> +
> +		Drivers must use the following standard profile-names whenever
> +		possible:
> +
> +		low-power:		Emphasises low power consumption
> +					(and also cool and quiet)
> +		balanced-low-power:	Balances between low power consumption
> +					and performance with a slight bias
> +					towards low power
> +		balanced:		Balance between low power consumption
> +					and performance
> +		balanced-performance:	Balances between performance and low
> +					power consumption with a slight bias
> +					towards performance
> +		performance:		Emphasises performance (and may lead to
> +					higher temperatures and fan speeds)
> +
> +		Userspace may expect drivers to offer at least several of these
> +		standard profile-names! If none of the above are a good match
> +		for some of the drivers profiles, then drivers may use one of
> +		these extra profile-names:
> +		<reserved for future use>
> +
> +What:		/sys/class/performance_profile/<device>/current_profile
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Reading this file gives the current selected profile for this
> +		device. Writing this file with one of the strings from
> +		available_profiles changes the profile to the new value.
> +
> +		Reading this file may also return "custom". This is intended for
> +		drivers which have and export multiple knobs influencing
> +		performance. Such drivers may very well still want to offer a
> +		set of profiles for easy of use and to be able to offer a
> +		consistent standard API (this API) to userspace for configuring
> +		their performance. The "custom" value is intended for when a
> +		user has directly configured the knobs (through e.g. some
> +		advanced control-panel for a GPU) and the knob values do not
> +		match any of the presets represented by the
> +		performance-profiles. In this case writing this file will
> +		override the modifications and restore the selected presets.
> +
> +What:		/sys/class/performance_profile/<device>/type
> +Date:		October 2020
> +Contact:	Hans de Goede <hdegoede@redhat.com>
> +Description:
> +		Performance-profiles may be system-wide, or for a specific
> +		device (e.g. CPU / GPU). System-wide profiles are typically
> +		used on devices where where a single cooling solution is
> +		shared between all components, such as laptops and NUCs.
> +
> +		Reading this file indicates the type of the device for which
> +		the thermal-profile is being configured.
> +
> +		Valid values: "system"
> +		Reserved for future use values: "cpu", "gpu"
> 
Thanks for putting this together. From my point of view it looks good 
and no objections or suggestions to add. It will work nicely for what we 
are trying to do, but I think it has enough flexibility to fit other use 
cases. I like it.

Mark
