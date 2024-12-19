Return-Path: <linux-acpi+bounces-10196-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F07A9F7F20
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 855E87A10E7
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Dec 2024 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274292288CB;
	Thu, 19 Dec 2024 16:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFeoPoKz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C4227561;
	Thu, 19 Dec 2024 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624840; cv=none; b=fG2sdM+DZI5gPpptInt0rxfnEqZlSLr+4JcI3An5ebNRB+7wTgcGFdZBYPhe+sO1Ik3CeUME1IlugFmctpIQhPhI8Zmrk10lYcbvhoeFQw88KepFr0VAJtChja6TAv3HdMfJDwbqiz27PY1oobwwIVqam5JvosifvUR9rnl1cGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624840; c=relaxed/simple;
	bh=Yc3/2cJCYlxM2s5kaL57wIYuJuvUqF4D/4Y+Dx8HhIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yz+diwa0rFQxfCwtKaL9421k++KinfRTuWiig9XLTCoEB2STy/Lr5c7hzYlx14W3UlD7K5sy5Hy4Qjlp5mqv2ThW7xhD2EOiGDy1hiiLdMH4NlXMd7eKgoP7fzarBiN6lQ30bpLVPwIx6dVlMxjuPH1sYGQ9Vcd4YAmcmndlTls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFeoPoKz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8789DC4CECE;
	Thu, 19 Dec 2024 16:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734624839;
	bh=Yc3/2cJCYlxM2s5kaL57wIYuJuvUqF4D/4Y+Dx8HhIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YFeoPoKzxHxqW+QCAqoMT+Ei+Oq6k3V3quVOvEKehzybjsaxqtWdI6cJHTNf1eRxY
	 j1HomNzWRCZw1mBb9z/y+f9e5PcPbdzB6JYdoTgRIpYpqfH+mfwGD/nJdSR1Hz+BDl
	 JiqTmszUL71+A8gsWA/o5bSpNuvtuavJb/fn9U/d71vWL2Le4SMoUTFhSlsJb9w7o7
	 t32LxK3yrGGwfp58Ak/+aTZhYnB+UzqjHcdWRUgWzU5z8s5xRrkidHt1HR8D6LM2qI
	 yRqbxFfGLhQllzbpeoCvqNxUYj8iTb30ln1wpaIV2EyrTetWBY6dzRdhsHSGtmle0P
	 zjP9fqbD1ILHQ==
Message-ID: <deda5a04-ba48-43c0-83c9-2f0afcaefb18@kernel.org>
Date: Thu, 19 Dec 2024 10:13:55 -0600
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEAuGOKTsPvko4Ncg9nhkXiinb0B8-kXBaQ6dxyLocD5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/2024 09:24, Antheas Kapenekakis wrote:
> On Thu, 19 Dec 2024 at 15:50, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 12/19/2024 07:12, Antheas Kapenekakis wrote:
>>> Hi Mario,
>>> given that there is a Legion Go driver in the works, and Asus already
>>> has a driver, the only thing that would be left for locking down ACPI
>>> access is manufacturers w/o vendor APIs.
>>>
>>> So, can we restart the conversation about this driver? It would be
>>> nice to get to a place where we can lock down /dev/mem and ACPI by
>>> spring.
>>
>> As Shyam mentioned we don't have control for limits by the PMF driver
>> for this on PMF v2 (Strix) or later platforms.
>>
>> So if we were to revive this custom discussion it would only be for
>> Phoenix and Hawk Point platforms.
> 
> That's unfortunate.
> 
>>>
>>> Moreover, since the other two proposed drivers use the
>>> firmware_attributes API, should this be used here as well?
>>
>> I do feel that if we revive this conversation specifically for Phoenix
>> and Hawk Point platforms yes we should use the same API to expose it to
>> userspace as those other two drivers do.
>>
>> I'd like Shyam's temperature on this idea though before anyone spends
>> time on it.  If he's amenable would you want to work on it?
> 
> We currently expect the 2025 lineup to include a lot of Strix Point
> handhelds, so I'd like a solution that works with that. OneXPlayer
> released a model already, and GPD is getting ready to ship as well.
> 
> Yeah, I could throw some hours to it after I go through some overdue stuff.
> 
>>>
>>> By the way, you were right about needing a taint for this. Strix Point
>>> fails to enter a lower power state during sleep if you set it to lower
>>> than 10W. This is not ideal, as hawk point could go down to 5 while
>>> still showing a power difference, but I am unsure where this bug
>>> should be reported. This is both through ryzenadj/ALIB
>>
>> Who is to say this is a bug?  Abusing a debugging interface with a
>> reverse engineered tool means you might be able to configure a platform
>> out of specifications.
> 
> The spec being 10+W would be very undesirable for handhelds with Strix
> Point, so I'd hope somebody looks into it, esp. if it can be fixed
> with a BIOS fw update before more handhelds come out. I can raise the
> minimum TDP to 10W, with some user complaints.
> 
> Asus and Lenovo use the same mailbox so they'd share the issue too.
> 
> FYI for a typical handheld with e.g., a 60Wh battery, a 10W envelope
> results in around 20-22W total consumption which is around 2.5 hours.
> Hawk Point can be TDP limited down to 16W total consumption (TDP ~7W)
> and can go down to 8W with frame limiting etc. I do not have numbers
> for Strix Point yet, but to match Hawk Point it has to allow TDP to go
> down to 7W. I think for 2025, customer expectation will be 6-8 hours+
> at low wattages.
> 

I've got a fundamental question - why the fixation on PPT?

This just sets "limits" for the package.  In Windows it's probably the 
best knob to tune to adjust performance in an effort to extend battery 
life, but in Linux we have a lot of other knobs:

* the ability to tune EPP (energy_performance_preference)
* set min and max CPU frequencies (scaling_min_freq, scaling_max_freq)
* offline cores at will
* change DPM setting in the GPU driver (power_dpm_force_performance_level)

All the core related knobs can be changed on a per-core basis.  So for 
example even on a non-heterogeneous design you could potentially make it 
perform "like" a hetero design where you set it so that some cores don't 
go above nominal frequency or the EPP value is tuned less aggressively 
on some cores.

These knobs can have just as drastic of a result on battery life as 
adjusting the various power limiting knobs.  Most importantly these 
knobs have architectural limits that you won't be able to override so 
you can safely change them to min/max and see what happens.

I feel like specifically if you keep EPP at balance_performance, keep 
scaling_min_freq at lowest non linear frequency and change 
scaling_max_freq on a few of the cores you should be able to influence 
the battery life quite a bit while still keeping the system responsive.

