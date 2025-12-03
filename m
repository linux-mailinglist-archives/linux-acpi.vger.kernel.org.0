Return-Path: <linux-acpi+bounces-19413-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C403FC9F4E3
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 15:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3DA9B30000B5
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743032FDC39;
	Wed,  3 Dec 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHPFhJOu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F412FD7A8;
	Wed,  3 Dec 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764772490; cv=none; b=WPM0FJMU34uBubleNdjBXd5+hpjIM6uAcmLry+ICsFoo/BAqoyL6HhE+HcRtjJgO4p2N1tJ4awIIWVRDi+G40po1vr3c+vPzdxBiqkno/740vlelMkZ+rcSzeDRMnf6Ra5SJbpwz1dsGC335L2QGbaSikmTip6OjViXbr3q3S6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764772490; c=relaxed/simple;
	bh=75sM6P0BND/nLtSjLsysOiqxUPuoaL5e6OnCNezvNfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYTEBSBitoXi/x4kMuJ+W1KKkGbEOaEASjqbJcX9VvmVao1CEFGqgArrAhgwj0Txa0eg37c0xf/sKQW+mUNFc1TZT8cRzrkbdzjMN22aWPVcXwAjNBaSlZVfRS0h+Or3Tcxp9RE9a4+iXQXkWPnI1Pw3o0761V4WuPkNC8/UtzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHPFhJOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5241C4CEF5;
	Wed,  3 Dec 2025 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764772489;
	bh=75sM6P0BND/nLtSjLsysOiqxUPuoaL5e6OnCNezvNfg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=EHPFhJOuUaYeheZRXMaeB/i9/rZXdjh32bIaRi/MvShEqOxIOm6tYah3UQNaq6ttz
	 RVYnLApUet2mr8MDG5LEh9Vb6HbNEWT/4vF8MRoEkeH4vTixNMlmFlNlaXzLbw09ze
	 82IEagF6y0drqGzqHPGuoQJnQKPOk270NLcUF61XvX9guULPk5zILJEAwdkTFZMGBT
	 oEoYyTjNcpZjjrCTi13o77A5Eb1mPqCzeUojwO4FBphaEEBoudOqHUSTwJz2T5/enu
	 fZZBVTwZjmt7hUUH7fx5V+oAjfoCB3ZQC/THI9V76RTlt+HHJYbrhhuZ7lME9EMmis
	 h5g3Z7ss7yaEg==
Message-ID: <2d4040dd-87e0-4cc4-9cce-3560e7b026c9@kernel.org>
Date: Wed, 3 Dec 2025 08:34:47 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Antheas Kapenekakis <lkml@antheas.dev>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Lennart Poettering <lennart@poettering.net>,
 Daniel Stone <daniels@collabora.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Robert Beckett <bob.beckett@collabora.com>,
 linux-acpi@vger.kernel.org, kernel@collabora.com,
 linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
 <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
 <02103d95-7bca-4db0-81c6-ac36429ea0bb@kernel.org>
 <35f69c12-ecd4-4b21-bfb0-53bf57f0febf@collabora.com>
 <ba7f9789-fd57-4d53-bf9a-15e85657ddd7@kernel.org>
 <82357e17-56ec-4dd6-82b2-0b8308f7aec2@collabora.com>
 <CAGwozwEDJbFoZJsqyOycHbv-LwGqOC-MG3K_duVEEqfKfXMUhA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwEDJbFoZJsqyOycHbv-LwGqOC-MG3K_duVEEqfKfXMUhA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/3/25 4:12 AM, Antheas Kapenekakis wrote:
> On Wed, 3 Dec 2025 at 07:47, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> On 12/3/25 05:12, Mario Limonciello (AMD) (kernel.org) wrote:
>>>
>>>
>>> On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
>>>> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
>>>>>> An inhibitor process in logind can handle this gracefully very simply.
>>>>>> Involving the DRM subsystem just adds a lot of complexity and it is
>>>>>> not clear what the benefit would be. There are no known devices that
>>>>>> hook DRM components into that DSM.
>>>>>>
>>>>>>> By doing it this way userspace still has control, but it's not
>>>>>>> mandatory for userspace to be changed.
>>>>>>
>>>>>> On that note, the screen off calls/userspace implementations are
>>>>>> optional under both patch series. If userspace is not aware of them,
>>>>>> they are still called by the kernel when suspending.
>>>>>
>>>>> With the proposal I mentioned you can get the LPS0 _DSM called on a
>>>>> handheld when the screen gets called without changing userspace.
>>>>>
>>>>>>
>>>>>> Current userland also duplicates the functionality of the screen off
>>>>>> call, which is primarily turning off the keyboard backlight. So along
>>>>>> implementing this call, userspace software like powerdevil/upower
>>>>>> needs to be tweaked to avoid doing that if the screen off state is
>>>>>> available.
>>>>>
>>>>> Sure Any hooking for turning off LEDs manually based off the screen off
>>>>> _DSM is totally feasible.
>>>>
>>>> It's not that trivial to add screen on/off hooks to DRM, there is no one
>>>> central place for that from what I can tell. I'm seeing variant with DRM
>>>> hooks as unnecessary complexity that doesn't solve any practical problem.
>>>
>>> Is it really that hard?  I figured that any time
>>> connector->dpms != mode from drm_atomic_connector_commit_dpms() could
>>> walk through all the connectors and make a judgement call whether to
>>> notify the potentially exported symbol.
>>
>> - drm_atomic_connector_commit_dpms() is used only for atomic ioctl path
>> - there is another legacy kms path
>> - AFAICT, DRM takes a different path when display is enabled initially
>> by kernel
>>
>> Here we have 3 places where to plug the hook. Gives a strong feeling of
>> a red flag, IMO.

It could easily be a symbol that all 3 places call which enumerates 
connectors and decides whether to call the LPS0 symbol.

But yeah; you might be right it's too complex.

>>
>>>> A week ago in a private conversation, Daniel Stone gave an example of
>>>> laptop's lid-close handling that is done purely in userspace.
>>>> Technically, kernel could have DRM hooks for that too, but it doesn't.
>>>
>>> All the way into hardware sleep?  There are certain requirements needed
>>> for hardware sleep that kernel drivers are normally used to put devices
>>> into the right state.  I guess PCIe devices you can hack around with
>>> userspace PCI config space writes but you're going to confuse the kernel
>>> pretty badly.
>>
>> - Userspace gets notification for a changed lid state
>> - Userspace takes action of turning display on/off
>> - Kernel DRM doesn't know and doesn't care about lid state,
>> force-disabling display on machine suspension
>>
>> Don't see how this is different for the case of the LPS0 notifications.
>> Maybe I'm not getting your point well, in that case please clarify more.

I thought you were talking about total sleep handling, but you're just 
talking about other userspace events related to a lid.  This is much 
different.

>>
>>>> Userspace would need to be taught about new power modes in any case.
>>>> Addition of DRM hooks should require a well-defined justification, which
>>>> is currently absent.
>>>>
>>>
>>> Why does userspace need to know about them?  Besides the inhibitor can't
>>> this be invisible to userspace?  I thought this mostly is for the
>>> firmware to flash some LEDs and maybe change some power limits.
>>
>> What I was saying is that LPS0 inhibitors would represent the power mode
>> controls by themselves. Userspace would have to know how to drive them.
>>
>> Userspace power managers are already driving displays DPMS. Combining
>> this with knowledge about the LPS0 inhibitors gives userspace ability to
>> support the new device power states. Hence, there is no practical need
>> to bother kernel DRM with the LPS0 burden.
> 
> _Technically_ DPMS is driven by the compositor, not by any power manager.
> 
> However, I think for Gnome and KDE they link to logind's inactivity
> hook so practically you are correct for inactivity.
> 
> Moreover, traditionally, compositors do not fire DPMS for suspend, the
> kernel does. I think KDE fixed that recently though. This is why the
> display used to wake up twice during hibernation, and why you get a
> frozen display when suspending/resuming. This also complicates
> suspend-then-hibernate checks because the display wakes up. i.e., they
> should fire DPMS for suspend but a lot for them don't
> 
> With compositors such as gamescope that do not have a dbus API it gets
> more hairy. And it also means that the power manager/kernel cannot
> control DPMS without the compositor's consent. If they do that, the
> compositor will crash due to rejected commits. We have a suspend hook
> for gamescope on Bazzite though, it improves suspend appearance.

It's OT and tangential to this thread; but Gamescope should probably 
grow native DPMS control for this particular case.

> 
> Just throwing in this for context, although it builds more of a case
> of not involving DRM.
> 

I don't feel it's appropriate to build new API in the kernel to work 
around shortcomings of an individual compositor.


