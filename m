Return-Path: <linux-acpi+bounces-11649-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AB5A4A33A
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 20:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B997AB1E6
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 19:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285C6275617;
	Fri, 28 Feb 2025 19:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfB/ZBjs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED35426F444;
	Fri, 28 Feb 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772584; cv=none; b=WyS4n6a/RBv0msNeUk57rU/3qXiJgnqzMxrueYitM/23iNQUjDLJV6jpuCiBh4viIlTBiWOBY/z32Dn5h6l1bXcSdRRkama91YzhBfcaOUqkFSXTfShz8vzxQyykA/BcJlVfjQtfsez+Li700LPqVsMhNcX+rI5oRb+gpQfB0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772584; c=relaxed/simple;
	bh=cYaxjN3iUfl6YT0X8uG+buMGiBP974jD8GQws6y5ZA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VkBBlyZdzwRpXn8NOxSxRpe8jNNG2nhVa0flYkbCCd88XSFpuGBQNpCnLqe7G+dqHnXlLC88eOrkRjlzDSgc7ptQvtV/LV2U47URO1zbmVClE2nzK7jKXb4BdeefPZlfI8jWiI1GiZ3lp3cRQztZ2YTy/Q5nu8LwNP3BeG2UTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfB/ZBjs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46922C4CED6;
	Fri, 28 Feb 2025 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740772583;
	bh=cYaxjN3iUfl6YT0X8uG+buMGiBP974jD8GQws6y5ZA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TfB/ZBjs8ZTYDagOOHObhkUsg1DnAQ9drYOOoExqPxSwPiCmYaoowa/pnETlSjQlA
	 61xDYk9V+de7DUqFAjFkmn6lk5DuOpeSW0IqwUqUbkYwaSe61MJ23YcEThwdhwhLfj
	 SppOOmgftaARe2k0FqneAIyo+UleahXjdA74nbDkWF/mC+TkV9SYQWc96Rvw43anpT
	 lWgfWWoFTMvAv7K++LBJxbTt7MujjmGjnslGQ2zFKTm0hfXArqr8H6Oxzb7C0WLrjg
	 XJFVxB+AC/S5dt9RhMCgA/gyG0ct+Z77jR+nMYWfmClfkWK0H4VoXTGb7aZdLwQwpc
	 CIYperEJflTlA==
Message-ID: <d1a29343-fe37-4564-a48d-2ba4890100fe@kernel.org>
Date: Fri, 28 Feb 2025 13:56:21 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <fcf58c76-2c0b-4892-96aa-c9b5b35c3e68@app.fastmail.com>
 <7d76a774-9dad-4c94-b4df-7c040e9dbc47@kernel.org>
 <CAGwozwFGx4n8NccKOJf1Bf1k7P8t_Xd3R4SHeij+s6X=NqBz9Q@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFGx4n8NccKOJf1Bf1k7P8t_Xd3R4SHeij+s6X=NqBz9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/2025 13:53, Antheas Kapenekakis wrote:
> On Fri, 28 Feb 2025 at 20:45, Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 2/28/2025 13:39, Mark Pearson wrote:
>>> Hi Mario,
>>>
>>> On Fri, Feb 28, 2025, at 12:01 PM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> When two drivers provide platform profile handlers but use different
>>>> strings to mean (essentially) the same thing the legacy interface won't
>>>> export them because it only shows profiles common to multiple drivers.
>>>>
>>>> This causes an unexpected behavior to people who have upgraded from an
>>>> earlier kernel because if multiple drivers have bound platform profile
>>>> handlers they might not be able to access profiles they were expecting.
>>>>
>>>> Introduce a concept of a "hidden choice" that drivers can register and
>>>> the platform profile handler code will utilize when using the legacy
>>>> interface.
>>>>
>>>> There have been some other attempts at solving this issue in other ways.
>>>> This serves as an alternative to those attempts.
>>>>
>>>> Link:
>>>> https://lore.kernel.org/platform-driver-x86/e64b771e-3255-42ad-9257-5b8fc6c24ac9@gmx.de/T/#t
>>>> Link:
>>>> https://lore.kernel.org/platform-driver-x86/CAGwozwF-WVEgiAbWbRCiUaXf=BVa3KqmMJfs06trdMQHpTGmjQ@mail.gmail.com/T/#m2f3929e2d4f73cc0eedd14738170dad45232fd18
>>>> Cc: Antheas Kapenekakis <lkml@antheas.dev>
>>>> Cc: "Luke D. Jones" <luke@ljones.dev>
>>>>
>>>> Mario Limonciello (3):
>>>>     ACPI: platform_profile: Add support for hidden choices
>>>>     platform/x86/amd: pmf: Add 'quiet' to hidden choices
>>>>     platform/x86/amd: pmf: Add balanced-performance to hidden choices
>>>>
>>>>    drivers/acpi/platform_profile.c    | 94 +++++++++++++++++++++++-------
>>>>    drivers/platform/x86/amd/pmf/sps.c | 11 ++++
>>>>    include/linux/platform_profile.h   |  3 +
>>>>    3 files changed, 87 insertions(+), 21 deletions(-)
>>>>
>>>> --
>>>> 2.43.0
>>>
>>> The patches are all good - but my question is do we really need the whole hidden implementation bit?
>>>
>>> If the options are not hidden, and someone chooses quiet or balanced-performance for the amd-pmf driver - does it really matter that it's going to do the same as low-power or performance?
>>>
>>> So, same feedback as I had for Antheas's patches. I understand why this is being proposed but for me it is making things unnecessarily complicated.
>>>
>>> My personal vote remains that the amd_pmf driver carries the superset to keep everyone happy (sorry - it sucks to be the CPU vendor that has to play nice with everyone).
>>>
>>> Mark
>>
>> Well so the problem with having all of them is specifically what happens
>> when "only" amd-pmf is bound?
>>
>> If you advertise both "low power" and "quiet" it's really confusing to
>> userspace what the difference is.
>>
>> The fact that it's actually 100% the same brings me to my personal
>> opinion on all of this.  Although I spent time writing up this series to
>> do it this way my "preference" is that we permanently alias "low power"
>> and "quiet" to one another and update all drivers to use "low power"
>> instead.
>>
>> Granted that doesn't help the case of balance-performance being hidden
>> that Antheas mentioned for acer-wmi and legion-wmi but I don't know
>> serious of a problem that actually is.
> 
> Hi Mark,
> So I agree with Mario here on that. I actually made the patch you
> suggested last Sunday [1].

My suggestion is actually more drastic than what you linked.  It's that 
we make a change in the core to special case the aliased strings, and 
then adjust all in-tree drivers to pick one or the other.

> 
> But then I looked at it and thought to myself that I can't ship this,
> so I did a v2, which is what I sent on Tuesday.
> 
> My priority here is to not disrupt the existing ABI with 6.14. This
> would allow extending this discussion by a couple of weeks, so a more
> permanent solution can be found.
> 
> If that would be the case, perhaps my patch series is more preferable
> as, since it is smaller, it would be cleaner to revert.
> 
> Antheas
> 
> [1] https://github.com/hhd-dev/patchwork/commit/aae724e8c90da3605bd131672fea07cd866af55f


