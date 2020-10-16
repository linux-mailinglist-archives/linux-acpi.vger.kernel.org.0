Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D56290775
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 16:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409123AbgJPOnf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 10:43:35 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.116]:21751 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395275AbgJPOnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 10:43:31 -0400
Received: from [100.112.135.1] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-b.us-west-2.aws.symcld.net id 1C/77-23751-A81B98F5; Fri, 16 Oct 2020 14:43:22 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRWlGSWpSXmKPExsWSLveKTbdrY2e
  8wacmDotJM/4zW+y/LmEx77OsRddCA4uF90+xWnz9dpvd4s3x6UwWy/f1M1pc3jWHzeJz7xFG
  i4VNLewWTZ1NQG7HZBaL1XteMFvM/TKV2eLJwz42iwmLN7I7CHqsmbeG0WPSzBnMHjtn3WX3+
  LVtDYvH5hVaHov3vGTy2LSqk83jzrU9bB7zTgZ6vN93lc3j8ya5AO4o1sy8pPyKBNaM21enMR
  dMVK9YOfkSewPjYYUuRi4OIYH/jBJnlj1kgXCeM0psXXWCDcQRFljLKPHt4BumLkZODhGBUom
  H546wQVQtY5LYNnMRE4jDLNDOKjH/VRtYFZuAtsSWLb/YQGxeAVuJhmNvWUFsFgFVie9vd7OA
  2KIC4RIdN3YwQdQISpyc+QQszimQKHGj/ypYPbOAhcTM+ecZIWxxiVtP5jNB2PISzVtnM3cxc
  nBIANkfT4GVSwgkSCx7eYd5AqPgLCRTZyGZNAvJpFlIJi1gZFnFaJZUlJmeUZKbmJmja2hgoG
  toaKRraGyia6qXWKWbpFdarFueWlyia6SXWF6sV1yZm5yTopeXWrKJERjpKQVtrDsYz7/+oHe
  IUZKDSUmU98aCznghvqT8lMqMxOKM+KLSnNTiQ4wyHBxKEryaG4BygkWp6akVaZk5wKQDk5bg
  4FES4XUDSfMWFyTmFmemQ6ROMepyHDs6bxGzEEtefl6qlDivFDCFCQmAFGWU5sGNgCXAS4yyU
  sK8jAwMDEI8BalFuZklqPKvGMU5GJWEeReCrOLJzCuB2/QK6AgmoCNuzewAOaIkESEl1cC0xk
  GR5aTqLwW9PVohFsYcZd8sjttJ3piht+/D2mrJJ5NuMfVs3BF4yKAodeH5SUfWTdAPMgiZusV
  T4+fL7FvXP60LD93y875V2umSN+G5+jME7s6fx1U5MSTgTP/iifGF9/8/ufhWJrL+S8CbKeuC
  MkUO++wUOTM7cIv+97lX2b1WK1qUbQ+5YfO80nvDaZZPbD9l2eKLNgZ1XD6zkzfN911oSlX5p
  UDfGv9Ug0Ni53gfM02SWbJgb8ajfyuL5zBM2aDacfTZQh0jReOw83Wbet/Z5FU8TPO4tsIwo8
  N3kuJ19oZzf8OvvAqN+1E3y/Jw53y5xOfbnSa9Lhb9v/z8mbtyF+/p37xv5m7702iTrxJLcUa
  ioRZzUXEiACS6Rwv7AwAA
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-28.tower-356.messagelabs.com!1602859400!536!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30222 invoked from network); 16 Oct 2020 14:43:21 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-28.tower-356.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 16 Oct 2020 14:43:21 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 2FC6A9FD9F902E98BA62;
        Fri, 16 Oct 2020 22:43:16 +0800 (CST)
Received: from localhost.localdomain (10.46.55.85) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Fri, 16 Oct
 2020 07:43:11 -0700
Subject: Re: Fw: [External] Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the
 DTPM framework)
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Elia Devito <eliadevito@gmail.com>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
 <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com> <4600468.GXAFRqVoOG@pce>
 <HK2PR0302MB2449214B28438ADC1790D468BD030@HK2PR0302MB2449.apcprd03.prod.outlook.com>
CC:     aniel Lezcano <daniel.lezcano@linaro.org>,
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
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <f9163f54-9379-89f6-aaaf-e2d5084051df@lenovo.com>
Date:   Fri, 16 Oct 2020 10:43:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <HK2PR0302MB2449214B28438ADC1790D468BD030@HK2PR0302MB2449.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.55.85]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

<Note - switched my email address to my more open source non-outlook 
based address>

On 2020-10-16 10:32 a.m., Mark Pearson wrote:
> 
> 
> ------------------------------------------------------------------------
> *From:* Elia Devito <eliadevito@gmail.com>
> *Sent:* October 16, 2020 10:26
> *To:* Rafael J. Wysocki <rafael@kernel.org>; Hans de Goede 
> <hdegoede@redhat.com>
> *Cc:* Daniel Lezcano <daniel.lezcano@linaro.org>; Srinivas Pandruvada 
> <srinivas.pandruvada@linux.intel.com>; Lukasz Luba 
> <lukasz.luba@arm.com>; Linux Kernel Mailing List 
> <linux-kernel@vger.kernel.org>; Linux PM <linux-pm@vger.kernel.org>; 
> Zhang, Rui <rui.zhang@intel.com>; Bastien Nocera <hadess@hadess.net>; 
> Mark Pearson <mpearson@lenovo.com>; Limonciello, Mario 
> <Mario.Limonciello@dell.com>; Darren Hart <dvhart@infradead.org>; Andy 
> Shevchenko <andy@infradead.org>; Mark Gross <mgross@linux.intel.com>; 
> Benjamin Berg <bberg@redhat.com>; linux-acpi@vger.kernel.org 
> <linux-acpi@vger.kernel.org>; platform-driver-x86@vger.kernel.org 
> <platform-driver-x86@vger.kernel.org>
> *Subject:* [External] Re: [RFC] Documentation: Add documentation for new 
> performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add 
> the DTPM framework)
> Hi,
> 
> In data venerdì 16 ottobre 2020 13:10:54 CEST, Hans de Goede ha scritto:
>> <note folding the 2 threads we are having on this into one, adding every one
>> from both threads to the Cc>
>> 
>> Hi,
>> 
>> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
>> > On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> >> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
>> <snip>
>> 
>> >>> First, a common place to register a DPTF system profile seems to be
>> >>> needed and, as I said above, I wouldn't expect more than one such
>> >>> thing to be present in the system at any given time, so it may be
>> >>> registered along with the list of supported profiles and user space
>> >>> will have to understand what they mean.
>> >> 
>> >> Mostly Ack, I would still like to have an enum for DPTF system
>> >> profiles in the kernel and have a single piece of code map that
>> >> enum to profile names. This enum can then be extended as
>> >> necessary, but I want to avoid having one driver use
>> >> "Performance" and the other "performance" or one using
>> >> "performance-balanced" and the other "balanced-performance", etc.
>> >> 
>> >> With the goal being that new drivers use existing values from
>> >> the enum as much as possible, but we extend it where necessary.
>> > 
>> > IOW, just a table of known profile names with specific indices assigned to
>> > them.
>> Yes.
>> 
>> > This sounds reasonable.
>> > 
>> >>> Second, irrespective of the above, it may be useful to have a
>> >>> consistent way to pass performance-vs-power preference information
>> >>> from user space to different parts of the kernel so as to allow them
>> >>> to adjust their operation and this could be done with a system-wide
>> >>> power profile attribute IMO.
>> >> 
>> >> I agree, which is why I tried to tackle both things in one go,
>> >> but as you said doing both in 1 API is probably not the best idea.
>> >> So I believe we should park this second issue for now and revisit it
>> >> when we find a need for it.
>> > 
>> > Agreed.
>> > 
>> >> Do you have any specific userspace API in mind for the
>> >> DPTF system profile selection?
>> > 
>> > Not really.
>> 
>> So before /sys/power/profile was mentioned, but that seems more like
>> a thing which should have a set of fixed possible values, iow that is
>> out of scope for this discussion.
>> 
>> Since we all seem to agree that this is something which we need
>> specifically for DPTF profiles maybe just add:
>> 
>> /sys/power/dptf_current_profile    (rw)
>> /sys/power/dptf_available_profiles (ro)
>> 
>> (which will only be visible if a dptf-profile handler
>>  has been registered) ?
>> 
>> Or more generic and thus better (in case other platforms
>> later need something similar) I think, mirror the:
>> 
>> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
>> for a system-wide energy-performance setting, so we get:
>> 
>> /sys/power/energy_performance_preference
>> /sys/power/energy_performance_available_preferences
>> 
>> (again only visible when applicable) ?
>> 
>> I personally like the second option best.
>> 
>> Regards,
>> 
>> Hans
> 
> between the two, the second seems to me more appropriate.
> Considering that the various profiles interact with thermal behaviors 
> what do
> you think of something like:
> 
> /sys/power/thermal_profile_available_profiles
> /sys/power/thermal_profile_profile
> 
> Regards,
> Elia
> 
I'm good with either but I do find 'profile_profile' slightly awkward to 
say out loud (even though it's logically correct :))

How about just:
/sys/power/platform_profile
/sys/power/platform_profile_available

As it covers the platform as a whole - fans, temperature, power, and 
anything else that ends up getting thrown in?

Mark
