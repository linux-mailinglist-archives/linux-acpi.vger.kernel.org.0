Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE81B292DC2
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Oct 2020 20:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgJSSta (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Oct 2020 14:49:30 -0400
Received: from mail1.bemta23.messagelabs.com ([67.219.246.112]:38966 "EHLO
        mail1.bemta23.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727681AbgJSSta (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Oct 2020 14:49:30 -0400
Received: from [100.112.5.40] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-c.us-east-1.aws.symcld.net id EB/AC-14399-6BFDD8F5; Mon, 19 Oct 2020 18:49:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRWlGSWpSXmKPExsWSLveKTXfb/d5
  4g6sVFpNm/Ge22H9dwmLeZ1mLroUGFgvvn2K1+PrtNrvFm+PTmSyW7+tntLi8aw6bxefeI4wW
  C5ta2C2aOpuA3I7JLBar97xgtpj7ZSqzxZOHfWwWExZvZHcQ9Fgzbw2jx6SZM5g9ds66y+7xa
  9saFo/NK7Q8Fu95yeSxaVUnm8eda3vYPOadDPR4v+8qm8fnTXIB3FGsmXlJ+RUJrBlflk5hLd
  hgVjH95kO2Bsb3ul2MXBxCAv8ZJQ5/msMG4bxglFg/5x8LiCMssJZR4tvBN0xdjJwcIgKBEl8
  f34Gq6mKXONB9CKyKWeAbq8S+x5vYQarYBLQltmz5xQZi8wrYSuxbfJW1i5GDg0VAVeL3KjWQ
  sKhAuETHjR1MECWCEidnPmEBsTkFEiXu3TzKCGIzC1hIzJx/HsoWl7j1ZD4ThC0v0bx1NjOIL
  SGgILGw8x8bhJ0gsezlHeYJjIKzkIydhWTULCSjZiEZtYCRZRWjWVJRZnpGSW5iZo6uoYGBrq
  Ghka6ZrqGFsV5ilW6yXmmxbmpicYmuoV5iebFecWVuck6KXl5qySZGYJynFLBt38G49/UHvUO
  MkhxMSqK8wfd644X4kvJTKjMSizPii0pzUosPMcpwcChJ8CaC5ASLUtNTK9Iyc4ApByYtwcGj
  JMK7+C5Qmre4IDG3ODMdInWKUZfj8vV5i5iFWPLy81KlxHnVQGYIgBRllObBjYClv0uMslLCv
  IwMDAxCPAWpRbmZJajyrxjFORiVhHmngKziycwrgdv0CugIJqAjbPt7QI4oSURISTUwJay0ub
  +o58fqi12nqksMcj4d+3ZGXvpuP3PVi95pS/tmlTxIYF6zRYFlS17NH4fZNlseZGxJWTZd4t3
  Me/JNdV+DmPs6uM01bSs3zw4K7dznVOu/XWbB1zMTHlk2WP6Yoy0b9/vJ+Uvp51d+EJng+9G3
  4W/uM7ZQ5ddrP+wQCz2qs3PdntlBc/2YttxKjZa99sn6y52kLwdfe9oXnuzbv+vI8bUpt/4ZT
  XgXK2dg19j0ynyeZ5z94rO/Kg7ttzKY5+vTfm9+0j3DX8+SXn+9svO25xpRn5mdd/v/Pdskec
  phuf5VrqnyrHMafuU95DM9F/Go3iT7yvQlO32XhJidOrVyTi5b87azK9U+LVu3/NNsJZbijER
  DLeai4kQAMeme2voDAAA=
X-Env-Sender: markpearson@lenovo.com
X-Msg-Ref: server-29.tower-406.messagelabs.com!1603133363!186762!1
X-Originating-IP: [103.30.234.6]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.60.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7194 invoked from network); 19 Oct 2020 18:49:25 -0000
Received: from unknown (HELO lenovo.com) (103.30.234.6)
  by server-29.tower-406.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Oct 2020 18:49:25 -0000
Received: from reswpmail04.lenovo.com (unknown [10.62.32.23])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by Forcepoint Email with ESMTPS id 853E15211490BC11B2FF;
        Tue, 20 Oct 2020 02:49:19 +0800 (CST)
Received: from localhost.localdomain (10.46.57.111) by reswpmail04.lenovo.com
 (10.62.32.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2044.4; Mon, 19 Oct
 2020 11:49:13 -0700
Subject: Re: Fw: [External] Re: [RFC] Documentation: Add documentation for new
 performance_profile sysfs class (Also Re: [PATCH 0/4] powercap/dtpm: Add the
 DTPM framework)
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20201006122024.14539-1-daniel.lezcano@linaro.org>
 <eb26a00d-eee0-a4d1-ed25-61a661ad5683@redhat.com>
 <8be66efd-7833-2c8a-427d-b0055c2f6ec1@linaro.org>
 <97e5368b-228d-eca1-85a5-b918dfcfd336@redhat.com>
 <CAJZ5v0gwc_d1vnwDVWXY+i4f0T2r0tAz8xuWV7oS_afsy7OocQ@mail.gmail.com>
 <63dfa6a1-0424-7985-7803-756c0c5cc4a5@redhat.com>
 <CAJZ5v0jpYpu3Tk7qq_MCVs0wUr-Dw0rY5EZELrVbQta0NZaoVA@mail.gmail.com>
 <87d9a808-39d6-4949-c4f9-6a80d14a3768@redhat.com>
 <CAJZ5v0iWmmu5WV7cX7uNb61NMYQ7s0dnhg1K+T0x90b3sBfU9w@mail.gmail.com>
 <943531a7-74d6-7c7f-67bc-2645b3ba7b8a@redhat.com>
 <CAJZ5v0j8o5Ot-4U0HmUtckUUBSNqC+TRB6CCRzqdjeE0p_XfvA@mail.gmail.com>
 <25d000cc-0c00-3b17-50f7-ca8de8b7a65b@redhat.com>
 <CAJZ5v0jC=rrTEtqoTvjw5vi=OH7i5OGC-KFuJgjCaXaDsKhUeQ@mail.gmail.com>
 <64de7cf0-5d52-f8b3-426a-431fb3a6a6ec@redhat.com>
 <HK2PR0302MB24494037019FBC7720976735BD1E0@HK2PR0302MB2449.apcprd03.prod.outlook.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Srinivas Pandruvada ,>" <srinivas.pandruvada@linux.intel.com>,
        "Lukasz Luba ,>" <lukasz.luba@arm.com>,
        "Linux Kernel Mailing List ,>" <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "> Zhang, Rui" <rui.zhang@intel.com>,
        Bastien Nocera <hadess@hadess.net>,
        "> Mark Pearson" <mpearson@lenovo.com>,
        "Limonciello, Mario ,>" <Mario.Limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        "Andy ,> Shevchenko" <andy@infradead.org>,
        Mark Gross <mgross@linux.intel.com>,
        "> Elia Devito" <eliadevito@gmail.com>,
        Benjamin Berg <bberg@redhat.com>,
        "> linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "> platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
From:   Mark Pearson <markpearson@lenovo.com>
Message-ID: <7189685b-4975-ff09-8ac0-59f4e3204359@lenovo.com>
Date:   Mon, 19 Oct 2020 14:49:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <HK2PR0302MB24494037019FBC7720976735BD1E0@HK2PR0302MB2449.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.46.57.111]
X-ClientProxiedBy: reswpmail04.lenovo.com (10.62.32.23) To
 reswpmail04.lenovo.com (10.62.32.23)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi

 > On 19/10/2020 14:43, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
> 
> On 10/18/20 2:31 PM, Rafael J. Wysocki wrote:
>> On Sun, Oct 18, 2020 at 11:41 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>
>>> Hi,
>>>
>>> On 10/16/20 4:51 PM, Rafael J. Wysocki wrote:
>>>> On Fri, Oct 16, 2020 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>
>>>>> <note folding the 2 threads we are having on this into one, adding every one from both threads to the Cc>
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 10/14/20 5:42 PM, Rafael J. Wysocki wrote:
>>>>>> On Wed, Oct 14, 2020 at 4:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>>>> On 10/14/20 3:33 PM, Rafael J. Wysocki wrote:
>>>>>
>>>>> <snip>
>>>>>
>>>>>>>> First, a common place to register a DPTF system profile seems to be
>>>>>>>> needed and, as I said above, I wouldn't expect more than one such
>>>>>>>> thing to be present in the system at any given time, so it may be
>>>>>>>> registered along with the list of supported profiles and user space
>>>>>>>> will have to understand what they mean.
>>>>>>>
>>>>>>> Mostly Ack, I would still like to have an enum for DPTF system
>>>>>>> profiles in the kernel and have a single piece of code map that
>>>>>>> enum to profile names. This enum can then be extended as
>>>>>>> necessary, but I want to avoid having one driver use
>>>>>>> "Performance" and the other "performance" or one using
>>>>>>> "performance-balanced" and the other "balanced-performance", etc.
>>>>>>>
>>>>>>> With the goal being that new drivers use existing values from
>>>>>>> the enum as much as possible, but we extend it where necessary.
>>>>>>
>>>>>> IOW, just a table of known profile names with specific indices assigned to them.
>>>>>
>>>>> Yes.
>>>>>
>>>>>> This sounds reasonable.
>>>>>>
>>>>>>>> Second, irrespective of the above, it may be useful to have a
>>>>>>>> consistent way to pass performance-vs-power preference information
>>>>>>>> from user space to different parts of the kernel so as to allow them
>>>>>>>> to adjust their operation and this could be done with a system-wide
>>>>>>>> power profile attribute IMO.
>>>>>>>
>>>>>>> I agree, which is why I tried to tackle both things in one go,
>>>>>>> but as you said doing both in 1 API is probably not the best idea.
>>>>>>> So I believe we should park this second issue for now and revisit it
>>>>>>> when we find a need for it.
>>>>>>
>>>>>> Agreed.
>>>>>>
>>>>>>> Do you have any specific userspace API in mind for the
>>>>>>> DPTF system profile selection?
>>>>>>
>>>>>> Not really.
>>>>>
>>>>> So before /sys/power/profile was mentioned, but that seems more like
>>>>> a thing which should have a set of fixed possible values, iow that is
>>>>> out of scope for this discussion.
>>>>
>>>> Yes.
>>>>
>>>>> Since we all seem to agree that this is something which we need
>>>>> specifically for DPTF profiles maybe just add:
>>>>>
>>>>> /sys/power/dptf_current_profile    (rw)
>>>>> /sys/power/dptf_available_profiles (ro)
>>>>>
>>>>> (which will only be visible if a dptf-profile handler
>>>>>  has been registered) ?
>>>>>
>>>>> Or more generic and thus better (in case other platforms
>>>>> later need something similar) I think, mirror the:
>>>>>
>>>>> /sys/bus/cpu/devices/cpu#/cpufreq/energy_performance_* bits
>>>>> for a system-wide energy-performance setting, so we get:
>>>>>
>>>>> /sys/power/energy_performance_preference
>>>>> /sys/power/energy_performance_available_preferences
>>>>
>>>> But this is not about energy vs performance only in general, is it?
>>>>
>>>>> (again only visible when applicable) ?
>>>>>
>>>>> I personally like the second option best.
>>>>
>>>> But I would put it under /sys/firmware/ instead of /sys/power/ and I
>>>> would call it something like platform_profile (and
>>>> platform_profile_choices or similar).
>>>
>>> Currently we only have dirs under /sys/firmware:
>>>
>>> [hans@x1 ~]$ ls /sys/firmware
>>> acpi  dmi  efi  memmap
>>>
>>> But we do have /sys/firmware/apci/pm_profile:
>>>
>>> Documentation/ABI/stable/sysfs-acpi-pmprofile
>>>
>>> What:           /sys/firmware/acpi/pm_profile
>>> Date:           03-Nov-2011
>>> KernelVersion:  v3.2
>>> Contact:        linux-acpi@vger.kernel.org
>>> Description:    The ACPI pm_profile sysfs interface exports the platform
>>>                 power management (and performance) requirement expectations
>>>                 as provided by BIOS. The integer value is directly passed as
>>>                 retrieved from the FADT ACPI table.
>>> Values:         For possible values see ACPI specification:
>>>                 5.2.9 Fixed ACPI Description Table (FADT)
>>>                 Field: Preferred_PM_Profile
>>>
>>>                 Currently these values are defined by spec:
>>>                 0 Unspecified
>>>                 1 Desktop
>>>                 2 Mobile
>>>                 3 Workstation
>>>                 4 Enterprise Server
>>>                 ...
>>>
>>> Since all platforms which we need this for are ACPI based
>>> (and the involved interfaces are also all ACPI interfaces)
>>> how about:
>>>
>>> /sys/firmware/acpi/platform_profile
>>> /sys/firmware/acpi/platform_profile_choices
>>>
>>> ?
>>>
>>> I think this goes nice together with /sys/firmware/acpi/pm_profile
>>> although that is read-only and this is a read/write setting.
>>>
>>> Rafel, would:
>>>
>>> /sys/firmware/acpi/platform_profile
>>> /sys/firmware/acpi/platform_profile_choices
>>>
>>> work for you ?
>> 
>> Yes, it would.
> 
> Great. So I think hat means that we have the most important part
> for moving forward with this.
> 
> So I guess the plan for this now looks something like this.
> 
> 1. Rewrite my API docs RFC to update it for the new 
> /sys/firmware/acpi/platform_profile[_choices]
>     plan (should be easy and a bunch of stuff like the "type" bit can 
> just be dropped)
> 
> 2. Add code somewhere under drivers/acpi which allows code from else where
>     to register itself as platform_profile handler/provider.
> 
> Rafael, any suggestions / preference for where this should be added under
> drivers/acpi ?  In a new .c file perhaps ?
> 
> 3.1 Use the code from 2 to add support for platform-profile selection in
>      thinkpad_acpi (something for me or Mark Pearson) to do
> 3.2 Use the code from 2 to add support for platform-profile selection
>      to hp-wmi
> 3.3 (and to other drivers in the future).
> 
> 
> An open question is who will take care of 1. and 2. Mark (Pearson)
> do you feel up to this? or do you want me to take care of this?
> 
> Regards,
> 
> Hans
> 

Definitely up for (2) and will happily have a go at number (1).

If there's an example of something similar I can look at for reference 
that would be helpful :)

Mark
