Return-Path: <linux-acpi+bounces-10204-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97829F86D5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 22:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11437168CB5
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 21:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10D61A2632;
	Thu, 19 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KizDxaYT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9258017E00E;
	Thu, 19 Dec 2024 21:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734643268; cv=none; b=Tc/F4BPKGJN2MabunDVEs2oVmrbI/Rqm9atjrIbLYRFWnrP/XWJU4Vj/CJkF1Rz+sy7cmGUTEBlLHrCqnOx5xCh47O7RAIzGZzU+RvgTY7ioUb/Q7MCLHAHhqZiHksB/nBYjng+umfE2+ftMD/XI9/AkThLV8vDpDKNO5/iukw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734643268; c=relaxed/simple;
	bh=XHYlLzBS3NywA0WgoC9ubApOId9EDVkOjMNkcAwmwqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbn862NlTvY6ts0YHCsEdYtEs5dQ92bfOUope2CrwAf91VIMTc+hhrmowPkOeFulCCtSEAeJv5EPyC2+wuZJ7fqnIK6C8egph0BoYiljZO3Wyh4Y59CMQj5eStZopAB3teDBo/8ts57d5CntvRlbgcBHlp3X7WpGMj0t4EezsSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KizDxaYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6180DC4CECE;
	Thu, 19 Dec 2024 21:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734643268;
	bh=XHYlLzBS3NywA0WgoC9ubApOId9EDVkOjMNkcAwmwqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KizDxaYThus3ipiadI+7OCZyrj5u8++sECs8INBaQi1mKwCIHOPqQ3v0bhs4VZEoX
	 vK7rJmjpDwjA6fRSp94wSZ3OC0RvN7LrrLUmuvwUciFk4sb59vXHEjWVwPSOgsBFgz
	 50M7+TuksZ5yH0XHQEZdy7QFBGYDL57u0jbZcDzkCJuPczj7H0qCHdiC9sbjoNQ/iY
	 dXczD7vWW6MNfSpRPTBKRMZ8Bkgyvbl3J0tZ3rRNpQNUG2jFIuVyAKFQNUDhnGJGKw
	 z/y5Y9bHctrAPM9T6uvloWRgvIwBPVhTU8Dsc05eVtBAz9Bck4O0gnGA+CbbGyAqcx
	 5ASbaGvigHChw==
Message-ID: <d56cc2e1-fe4f-4694-a987-6e0a49134c7f@kernel.org>
Date: Thu, 19 Dec 2024 15:21:04 -0600
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwG3WCOa6s0_73-e1-iQOwMy413tBqj8WXk=J5FPkq3+QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/2024 15:10, Antheas Kapenekakis wrote:
> On Thu, 19 Dec 2024 at 17:14, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 12/19/2024 09:24, Antheas Kapenekakis wrote:
>>> On Thu, 19 Dec 2024 at 15:50, Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 12/19/2024 07:12, Antheas Kapenekakis wrote:
>>>>> Hi Mario,
>>>>> given that there is a Legion Go driver in the works, and Asus already
>>>>> has a driver, the only thing that would be left for locking down ACPI
>>>>> access is manufacturers w/o vendor APIs.
>>>>>
>>>>> So, can we restart the conversation about this driver? It would be
>>>>> nice to get to a place where we can lock down /dev/mem and ACPI by
>>>>> spring.
>>>>
>>>> As Shyam mentioned we don't have control for limits by the PMF driver
>>>> for this on PMF v2 (Strix) or later platforms.
>>>>
>>>> So if we were to revive this custom discussion it would only be for
>>>> Phoenix and Hawk Point platforms.
>>>
>>> That's unfortunate.
>>>
>>>>>
>>>>> Moreover, since the other two proposed drivers use the
>>>>> firmware_attributes API, should this be used here as well?
>>>>
>>>> I do feel that if we revive this conversation specifically for Phoenix
>>>> and Hawk Point platforms yes we should use the same API to expose it to
>>>> userspace as those other two drivers do.
>>>>
>>>> I'd like Shyam's temperature on this idea though before anyone spends
>>>> time on it.  If he's amenable would you want to work on it?
>>>
>>> We currently expect the 2025 lineup to include a lot of Strix Point
>>> handhelds, so I'd like a solution that works with that. OneXPlayer
>>> released a model already, and GPD is getting ready to ship as well.
>>>
>>> Yeah, I could throw some hours to it after I go through some overdue stuff.
>>>
>>>>>
>>>>> By the way, you were right about needing a taint for this. Strix Point
>>>>> fails to enter a lower power state during sleep if you set it to lower
>>>>> than 10W. This is not ideal, as hawk point could go down to 5 while
>>>>> still showing a power difference, but I am unsure where this bug
>>>>> should be reported. This is both through ryzenadj/ALIB
>>>>
>>>> Who is to say this is a bug?  Abusing a debugging interface with a
>>>> reverse engineered tool means you might be able to configure a platform
>>>> out of specifications.
>>>
>>> The spec being 10+W would be very undesirable for handhelds with Strix
>>> Point, so I'd hope somebody looks into it, esp. if it can be fixed
>>> with a BIOS fw update before more handhelds come out. I can raise the
>>> minimum TDP to 10W, with some user complaints.
>>>
>>> Asus and Lenovo use the same mailbox so they'd share the issue too.
>>>
>>> FYI for a typical handheld with e.g., a 60Wh battery, a 10W envelope
>>> results in around 20-22W total consumption which is around 2.5 hours.
>>> Hawk Point can be TDP limited down to 16W total consumption (TDP ~7W)
>>> and can go down to 8W with frame limiting etc. I do not have numbers
>>> for Strix Point yet, but to match Hawk Point it has to allow TDP to go
>>> down to 7W. I think for 2025, customer expectation will be 6-8 hours+
>>> at low wattages.
>>>
>>
>> I've got a fundamental question - why the fixation on PPT?
>>
>> This just sets "limits" for the package.  In Windows it's probably the
>> best knob to tune to adjust performance in an effort to extend battery
>> life, but in Linux we have a lot of other knobs:
>>
>> * the ability to tune EPP (energy_performance_preference)
>> * set min and max CPU frequencies (scaling_min_freq, scaling_max_freq)
> 
> We use both of these.
> 
>> * offline cores at will
> 
> if a core is parked and you try to write into its sysfs entrypoints,
> we found that this might cause a userspace program to hang
> indefinitely. Since a lot of settings are per core that's problematic
> and since it does not help much most TDP programs dont offer it
> anymore.

This sounds like a kernel bug if you're hanging programs when trying to 
write to sysfs files of offlined cores.  If we can get that fixed having 
that in your toolbelt is quite useful.  I'm sure there are plenty of 
games that don't really need all the cores up and you can save some power.

Can you get a simple reproducer for me into a bug report to look at next 
year?

> 
>> * change DPM setting in the GPU driver (power_dpm_force_performance_level)
> 
> I think we played with this mostly to try to get lower than 800mhz.
> However, going lower than 800mhz in these APUs causes issues.
> 
>> All the core related knobs can be changed on a per-core basis.  So for
>> example even on a non-heterogeneous design you could potentially make it
>> perform "like" a hetero design where you set it so that some cores don't
>> go above nominal frequency or the EPP value is tuned less aggressively
>> on some cores.
> 
>> These knobs can have just as drastic of a result on battery life as
>> adjusting the various power limiting knobs.  Most importantly these
>> knobs have architectural limits that you won't be able to override so
>> you can safely change them to min/max and see what happens.
> 
> I feel like we are discussing different targets here. When it comes to
> computing tasks, you have a certain block of work that needs to be
> done and after that the CPU is free. In this case, programs like tuned
> (allegedly) optimize these settings so that they take the minimum
> amount of power to complete that block of work.
> 
> However, games are different. Games have no problem burning power if
> you let them and they are also playable at a variety of power levels.
> Typically, unless the user caps the framerate and video quality of the
> game it will use the full slow temp limit value. Even if they do set
> that, the game will typically burn 3-4W more than what is needed
> depending on TDP, EPP etc.

Part of what I'm wondering is if our 4 levels of EPP values "aren't 
enough" for optimization on a per game basis.

IMO They're incredibly rigid.  I do have a patch that can expose "raw" 
numbers for amd-pstate like intel-pstate does, but I haven't brought it 
on the lists yet because I'm still discussing it with others internal to 
AMD.

EPP is really about responsiveness in games.

> 
> Therefore, the question we ask users is how loud do you want your
> device to be and how long (in hours) do you want the battery to last.
> This is done by ppt + the other settings, which are set automatically
> based on ppt.
> 
> Then the users can compromise with what fidelity and fps they get
> based on their TDP.
> 
>> I feel like specifically if you keep EPP at balance_performance, keep
>> scaling_min_freq at lowest non linear frequency and change
>> scaling_max_freq on a few of the cores you should be able to influence
>> the battery life quite a bit while still keeping the system responsive.
> 
> The sweet spot on these APUs is max freq to be nominal (i.e., no
> boost), EPP at balance_power or power for very low tdps, and min_freq
> to be 0. Especially for min_freq, setting it to lowest non-linear
> seems to have no effect.

Min freq can't go to 0, but maybe you mean the unitless perf value of 0, 
right?

There is a pretty big current swing you'll have going from perf 0 vs the 
swing you get from lowest nonlinear perf.  It might not be visually 
noticeable, but I think it would be good to characterize how many joules 
are used for a given predictable gaming "workload" to decide what to do.

