Return-Path: <linux-acpi+bounces-10206-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AE9F8726
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 22:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D9D416F37F
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68D1D90D9;
	Thu, 19 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku+uYpWO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE821C5CB6;
	Thu, 19 Dec 2024 21:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734644111; cv=none; b=WTqszx+DU78z5IQQozXhIrOKK12h54m5BdnUY/ignhwKPMXM7ZTY+YbAAd0WmSDLs5wLus/lZRL0gFhvEy9wHRrJh3EAPciF6fcwBxXj6z18sU17ne3G1zf5A+T2+j+7CEZKvFyej1yHq5wZCUeXNQPSvp8CHhidkjszaaaD3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734644111; c=relaxed/simple;
	bh=gRFltU4fxhjOFJFvL0nOWyf+SxsAEjybpwxoxFYKr88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ahoVso/w1JKbcZU+EksWiwtjPYZ6fLoqCAnIsoFcf64M/da+eG/tChImjzaSdBnQn5CcCoQ+L9gku0zpsyKlKTgIOJUWdx1IibmVvtMOiBRSDwefsT4T9YWg2i+L43HcYf/EijnXnnOSmEEBe88h9ZbEiATyXMp3k/EvqEy0+eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku+uYpWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C718C4CECE;
	Thu, 19 Dec 2024 21:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734644111;
	bh=gRFltU4fxhjOFJFvL0nOWyf+SxsAEjybpwxoxFYKr88=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ku+uYpWOE83mz9GiWNlAJJ71IL6HmJQS/j6R8iZ4b1qufrGsb33AQFDSgxNTEa+By
	 hDWWs/DHrYyuOe6lvxA9mGTpBuh14YPH7qtC9sJmapT0gtPYQJx7NUkL0OBO3xMlHo
	 H9HprA+kS+j/0Y+v7XITPeS6QyPGp7L2vciaDj14/pFPdiT4oofwPdXejztS5IVK1H
	 B4BcRiGinIK26+H5I8UXl75gf8pj/VYVdt1QMOy3x0eSWhVX5IhqaPfXx0LPJ83uc3
	 4eEiEqg5zokhafwPaVwUZZZIyFGXTStTJuoUSJ5RDlqaRRxDtuY9FTwSBza6vfNo6d
	 bq7OMT8LyP6dA==
Message-ID: <e66973b9-29e5-4d77-a069-8bd7d264f402@kernel.org>
Date: Thu, 19 Dec 2024 15:35:08 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] platform/x86/amd: pmf: Add manual control support
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <20240926025955.1728766-3-superm1@kernel.org>
 <CAGwozwFjo4uSFpCAXRKivK+VoeYz-Qftmw+iLtOrVnyhn3xpfA@mail.gmail.com>
 <ba5a7961-de65-41a1-a556-338ed1b06faa@kernel.org>
 <CAGwozwEAuGOKTsPvko4Ncg9nhkXiinb0B8-kXBaQ6dxyLocD5w@mail.gmail.com>
 <deda5a04-ba48-43c0-83c9-2f0afcaefb18@kernel.org>
 <CAGwozwG3WCOa6s0_73-e1-iQOwMy413tBqj8WXk=J5FPkq3+QA@mail.gmail.com>
 <d56cc2e1-fe4f-4694-a987-6e0a49134c7f@kernel.org>
 <CAGwozwG8dFQfPzPVDa=rwKYLnraw7kRoLOZELZrkrW0tEfEsug@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwG8dFQfPzPVDa=rwKYLnraw7kRoLOZELZrkrW0tEfEsug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/2024 15:27, Antheas Kapenekakis wrote:
> On Thu, 19 Dec 2024 at 22:21, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 12/19/2024 15:10, Antheas Kapenekakis wrote:
>>> On Thu, 19 Dec 2024 at 17:14, Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 12/19/2024 09:24, Antheas Kapenekakis wrote:
>>>>> On Thu, 19 Dec 2024 at 15:50, Mario Limonciello <superm1@kernel.org> wrote:
>>>>>>
>>>>>> On 12/19/2024 07:12, Antheas Kapenekakis wrote:
>>>>>>> Hi Mario,
>>>>>>> given that there is a Legion Go driver in the works, and Asus already
>>>>>>> has a driver, the only thing that would be left for locking down ACPI
>>>>>>> access is manufacturers w/o vendor APIs.
>>>>>>>
>>>>>>> So, can we restart the conversation about this driver? It would be
>>>>>>> nice to get to a place where we can lock down /dev/mem and ACPI by
>>>>>>> spring.
>>>>>>
>>>>>> As Shyam mentioned we don't have control for limits by the PMF driver
>>>>>> for this on PMF v2 (Strix) or later platforms.
>>>>>>
>>>>>> So if we were to revive this custom discussion it would only be for
>>>>>> Phoenix and Hawk Point platforms.
>>>>>
>>>>> That's unfortunate.
>>>>>
>>>>>>>
>>>>>>> Moreover, since the other two proposed drivers use the
>>>>>>> firmware_attributes API, should this be used here as well?
>>>>>>
>>>>>> I do feel that if we revive this conversation specifically for Phoenix
>>>>>> and Hawk Point platforms yes we should use the same API to expose it to
>>>>>> userspace as those other two drivers do.
>>>>>>
>>>>>> I'd like Shyam's temperature on this idea though before anyone spends
>>>>>> time on it.  If he's amenable would you want to work on it?
>>>>>
>>>>> We currently expect the 2025 lineup to include a lot of Strix Point
>>>>> handhelds, so I'd like a solution that works with that. OneXPlayer
>>>>> released a model already, and GPD is getting ready to ship as well.
>>>>>
>>>>> Yeah, I could throw some hours to it after I go through some overdue stuff.
>>>>>
>>>>>>>
>>>>>>> By the way, you were right about needing a taint for this. Strix Point
>>>>>>> fails to enter a lower power state during sleep if you set it to lower
>>>>>>> than 10W. This is not ideal, as hawk point could go down to 5 while
>>>>>>> still showing a power difference, but I am unsure where this bug
>>>>>>> should be reported. This is both through ryzenadj/ALIB
>>>>>>
>>>>>> Who is to say this is a bug?  Abusing a debugging interface with a
>>>>>> reverse engineered tool means you might be able to configure a platform
>>>>>> out of specifications.
>>>>>
>>>>> The spec being 10+W would be very undesirable for handhelds with Strix
>>>>> Point, so I'd hope somebody looks into it, esp. if it can be fixed
>>>>> with a BIOS fw update before more handhelds come out. I can raise the
>>>>> minimum TDP to 10W, with some user complaints.
>>>>>
>>>>> Asus and Lenovo use the same mailbox so they'd share the issue too.
>>>>>
>>>>> FYI for a typical handheld with e.g., a 60Wh battery, a 10W envelope
>>>>> results in around 20-22W total consumption which is around 2.5 hours.
>>>>> Hawk Point can be TDP limited down to 16W total consumption (TDP ~7W)
>>>>> and can go down to 8W with frame limiting etc. I do not have numbers
>>>>> for Strix Point yet, but to match Hawk Point it has to allow TDP to go
>>>>> down to 7W. I think for 2025, customer expectation will be 6-8 hours+
>>>>> at low wattages.
>>>>>
>>>>
>>>> I've got a fundamental question - why the fixation on PPT?
>>>>
>>>> This just sets "limits" for the package.  In Windows it's probably the
>>>> best knob to tune to adjust performance in an effort to extend battery
>>>> life, but in Linux we have a lot of other knobs:
>>>>
>>>> * the ability to tune EPP (energy_performance_preference)
>>>> * set min and max CPU frequencies (scaling_min_freq, scaling_max_freq)
>>>
>>> We use both of these.
>>>
>>>> * offline cores at will
>>>
>>> if a core is parked and you try to write into its sysfs entrypoints,
>>> we found that this might cause a userspace program to hang
>>> indefinitely. Since a lot of settings are per core that's problematic
>>> and since it does not help much most TDP programs dont offer it
>>> anymore.
>>
>> This sounds like a kernel bug if you're hanging programs when trying to
>> write to sysfs files of offlined cores.  If we can get that fixed having
>> that in your toolbelt is quite useful.  I'm sure there are plenty of
>> games that don't really need all the cores up and you can save some power.
>>
>> Can you get a simple reproducer for me into a bug report to look at next
>> year?
> 
> I will try to. This was relayed to me. 

Thanks! If whoever relayed it to you opens the bug report that's totally 
fine with me too.  Just ping me after the new year if I miss it because 
it will be lost in a giant pile of other stuff.

> Disabling SMT also causes a
> crash on the Ally when going to sleep.

Yes; SMT is require to be enabled for s0i3 to work.

That's why the s2idle debugging script flags it.

https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.py#L1207
> 
>>>
>>>> * change DPM setting in the GPU driver (power_dpm_force_performance_level)
>>>
>>> I think we played with this mostly to try to get lower than 800mhz.
>>> However, going lower than 800mhz in these APUs causes issues.
>>>
>>>> All the core related knobs can be changed on a per-core basis.  So for
>>>> example even on a non-heterogeneous design you could potentially make it
>>>> perform "like" a hetero design where you set it so that some cores don't
>>>> go above nominal frequency or the EPP value is tuned less aggressively
>>>> on some cores.
>>>
>>>> These knobs can have just as drastic of a result on battery life as
>>>> adjusting the various power limiting knobs.  Most importantly these
>>>> knobs have architectural limits that you won't be able to override so
>>>> you can safely change them to min/max and see what happens.
>>>
>>> I feel like we are discussing different targets here. When it comes to
>>> computing tasks, you have a certain block of work that needs to be
>>> done and after that the CPU is free. In this case, programs like tuned
>>> (allegedly) optimize these settings so that they take the minimum
>>> amount of power to complete that block of work.
>>>
>>> However, games are different. Games have no problem burning power if
>>> you let them and they are also playable at a variety of power levels.
>>> Typically, unless the user caps the framerate and video quality of the
>>> game it will use the full slow temp limit value. Even if they do set
>>> that, the game will typically burn 3-4W more than what is needed
>>> depending on TDP, EPP etc.
>>
>> Part of what I'm wondering is if our 4 levels of EPP values "aren't
>> enough" for optimization on a per game basis.
>>
>> IMO They're incredibly rigid.  I do have a patch that can expose "raw"
>> numbers for amd-pstate like intel-pstate does, but I haven't brought it
>> on the lists yet because I'm still discussing it with others internal to
>> AMD.
>>
>> EPP is really about responsiveness in games.
> 
> EPP performance is so detrimental we hide it. It destroys performance
> by sucking power from the GPU. EPP balance_performance is only useful
> in certain emulators that need a lot of CPU. Only balance_power is
> useful. Then, for TDPs lower than 10, setting EPP to power milks
> another 1-2W

Yes; this is a different conversation once you're talking about the 
power share between CPU cores and GPU.  It's part of why I was talking 
about core parking when you don't need all the cores.


