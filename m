Return-Path: <linux-acpi+bounces-19449-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4843FCA8BB2
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 19:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 054F5308BD96
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 18:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26D2E92D6;
	Fri,  5 Dec 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hucvDOcu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C453127A12B;
	Fri,  5 Dec 2025 18:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958051; cv=none; b=bpwugbzqQdfO125Dutu7/MzMDebgrIs8PKK07/J94pRv9boWQUBjsaqhw+zowld677pim0DRpDdAMRL87VEWkRByaBc8VSzFIdepEhiq33sbqyFyBwqQt3H+XsyWS/egFQryqQCIvW10xspMMZL+kWkTwkgGFezB47ACP3TNCts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958051; c=relaxed/simple;
	bh=lZOQ4vOsQUyw8k6JX0SmHW4UcvPfYiZunKsZaWmwLGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UNOeLaFgsyp+qjfd/NTxI+NfhceIevG1Fo5DrDJwcHo1Q+W/j3fG5k+5urFvRcDe/21mS5QBy33CVwSvl50b3XEzxduo8GnpPW+nqLAGEWiRAhduVpiwS+nM4R2INET5+UxW20zxDsu68rccwN6VkNyZtNmmYd0GScKLNlh//ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hucvDOcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF95C4CEF1;
	Fri,  5 Dec 2025 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764958051;
	bh=lZOQ4vOsQUyw8k6JX0SmHW4UcvPfYiZunKsZaWmwLGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hucvDOcupA3TZ5sMkdIJ6ipvJnpdR3AcotO+6jSwZeYeRWi7qb0ETcG9rg/NisWon
	 9Myy6NXnCYGX88p2QPrSdxHPOxfVgAtcnvTFXTHGUf1rCRY2XoWlxN6CnD/r1OAiOu
	 KoXx7gEQZ1nnv+KGVkvExd1s6de8Y5+usOeDk9ZmlgcK4MRVKM4DDpzYpmYMp/XgQ2
	 v1jWVTS+r4ZXqulQNlgxIOabPWN4Rlpei9enTpGBqwq4wyJ+ubP8kyt7PnJHuH7zUo
	 NxNA3wdECdKROQuweuQe4dnr3afsFBBfeKIOzIxFhBhXwLDcbLgw3hx6sbdziKAk0Z
	 PZOtScUdrzF5Q==
Message-ID: <411ea5f1-7cc7-4a2e-99b4-2891f3aa344e@kernel.org>
Date: Fri, 5 Dec 2025 12:07:29 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Antheas Kapenekakis <lkml@antheas.dev>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org,
 Lennart Poettering <lennart@poettering.net>
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAJZ5v0hRiA_AFTsBL0Ud5vdDyyqSJcwLtKaVtpYareh4URS_CQ@mail.gmail.com>
 <479b4a5a-a792-4d3d-8bf1-59ef296b7e96@collabora.com>
 <CAJZ5v0h_8aA+VwBb5B1tKn5Y0Herb3dG=Qjy1uueA4V83FUcCg@mail.gmail.com>
 <CAGwozwF4Xv=ePdHhF6B6dFgHUES1vyoU6f5KrrzM7pU8tao2Gg@mail.gmail.com>
 <CAJZ5v0i63EwNxaYU8S9W5a3jpzQtCNxTH+0hsjO_xLf_wXd1Qw@mail.gmail.com>
 <a0d91fa6-bf95-4bbb-a4f9-9d8cceae5543@kernel.org>
 <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0hkkurEK6X3_d_AErKMOn9uicusEb1OhDAv5sFHr7_ahQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/5/25 11:22 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 5, 2025 at 5:47 PM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>> I would start with the graphics stacks and teach them to
>>> runtime-suspend the HW when the displays go off.  No firmware
>>> notifications are needed for this to work.
>>
>> Well the problem with this is there is a sizable latency to runtime
>> suspend hardware when displays go off.  For example you would need to
>> redo link training when you spin the hardware back up.
>>
>> What we do today (AMD *dGPU* centric) is runtime suspend the hardware
>> when no displays are connected and nothing else is using the GPU (for
>> offload purposes).
> 
> The latency problem can be addressed by using autosuspend instead of
> synchronous suspend.  Just set the autosuspend timer when displays go
> off.

Sorry I probably confused the problem by saying latency to suspend the 
hardware.  That doesn't matter.  It's a problem of latency when they 
*come back up*.  Let me give a hypothetical that will demonstrate.

Let's say I have the following:
* Desktop with a dGPU connected to it.
* My DE has a setting for compositor to blank the monitor after 5 minutes.
* My DE has a setting to starting system suspend after 10 minutes.
* You set up auto-suspend on the dGPU for 15 seconds.
* No non-display work running.

You walk away for 6 minutes.  The dGPU will have entered runtime PM from 
the auto-suspend.  You come back to the machine and you wiggle the 
mouse.  Because the dGPU was auto-suspended you gotta wait for it to 
spin back up, you have to wait for link training again etc.

This is pretty much the same that would have happened if you walked away 
for 10 minutes now!  Your "5 minute blank monitor" turned into "5 minute 
turn off dGPU".

> 
>> On AMD APU we don't use runtime suspend.  If you ignore the latency I
>> could see an argument for proxying the status of displays to indicate
>> runtime suspended, but I don't know what it really buys you.
> 
> Well, the lack of runtime PM is a problem and I don't see how it can
> be overcome easily.
> 
> The main issue is that when the system is resuming and there is no
> runtime PM support, the device in question must be powered up during
> the system resume flow.

I don't think this is actually a problem.  The reason is in my below 
comment.

> 
>>> Then, I would teach
>>> graphics drivers to leave the devices in runtime-suspend if they are
>>> runtime-suspended when system suspend starts and to leave them in
>>> runtime-suspend throughout the system suspend and resume, so they are
>>> still runtime-suspended whey system resume is complete.  I'm not sure
>>> how far away graphics stacks are from this, but at least some of them
>>> support runtime PM, so maybe the fruits don't hang very high.  With
>>> that, you'd just need a way to trigger a system suspend after a period
>>> of inactivity when the displays are off and you have your "dark mode".
>>
>> I think even without kernel changes this can be accomplished today with
>> userspace.
>>
>> There will be change events when the displays are turned off and you can
>> listen to and set a timer to enter system suspend based upon how long
>> they are off.
> 
> True, but that's just about suspending.  To avoid powering up devices
> on the way back from system suspend, runtime PM support and
> integration of it with system suspend-resume is necessary.

Yes and no.  For most device types I would agree; but the compositor 
controls DPMS on each CRTC which impacts whether anything is displayed.

If the compositor chooses to turn off the displays the GPU hardware will 
remain active but display IP will be off or in a low power state.  This 
will still have significant power savings by the displays being off.


