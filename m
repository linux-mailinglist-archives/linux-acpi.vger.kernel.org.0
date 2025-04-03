Return-Path: <linux-acpi+bounces-12707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8819EA7AFEB
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 23:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD64A189AD8F
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 20:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBC25A635;
	Thu,  3 Apr 2025 19:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZpnJ5jS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0F25A62E
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743710217; cv=none; b=gJnKnrQQUYbwFNlYfZ2+/9zn0yArpSUdqHQXZs8j8ey6JZK8AgLdpVSqNi1naDOzCEtWODIGd2oqOomRcwbog6QWLk3vzo2TQ0aBXC5Bon3fP4yv7mUWU+dMj8u3TOxKYTtymZW8Ct34D7L/0EyXYDr24c/FOFIuB56C0deATI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743710217; c=relaxed/simple;
	bh=QsfGg77/4wcXyQi/oDNqF6H4MrgvSDK8UQvAfwzGYtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qcsna+74LSYDCg61cqUYB3W8M7rC86bQLPcr7zPkv5VoRMVFJSD46WWUVoInp1FqGnDT3bZDL4Jtys8szuazjE36QihS2qbAbBgq8su6nmo2QyFjSnzixIB5PIaZPdxmKFxSAQVfMpgzYBEmqGdBWyxwlFuuj0Ybg2LTREdtiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZpnJ5jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CACC4CEE3;
	Thu,  3 Apr 2025 19:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743710216;
	bh=QsfGg77/4wcXyQi/oDNqF6H4MrgvSDK8UQvAfwzGYtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BZpnJ5jSl9OtB0RRAj4C/YiHrCyUWlggp0EXAh1oUK/XdMb03JOSIAuRIeV3fVRcb
	 nSXs6AOj/dFRe+BXOLncRWHWV+peNRStozPzQwdIYYO/TVI/Q9UNUYoqBehUe3YWhs
	 70PmtnpTsmSwxZefd9pJqAzpWslLX+vVXpkHbgTCPcWBgpygpuwLuWBS/+FT8swTmc
	 cEZIJpYsNblUSvNtGqnUP7PIMHr5s4mnI1Fyq5Z7dm98iJuDGqgNHgjF43UQx8djw1
	 +1jWNkqaiyBw5I9Mj2A9JK3Vnb+skL84OvFB5aBMupammtwk/Y+v3KxjvfxsMTMDMt
	 WIKB6ji0yBZyg==
Message-ID: <e128ae3c-8d15-4a0d-ab1a-350e062c0a51@kernel.org>
Date: Thu, 3 Apr 2025 14:56:54 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
 Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
 "derekjohn.clark@gmail.com" <derekjohn.clark@gmail.com>
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <1eb121e5-c0d3-49a8-9579-6ea5543ad4f9@kernel.org>
 <CAGwozwFgRO=6a=NNfbTtz1E5sroH27sxyXJQuV9QbTMfAttO6w@mail.gmail.com>
 <6a9268de-4072-4ef2-9f33-95cc783a8595@kernel.org>
 <CAGwozwF6iFkgvS54KYGMg554S9DTD83rq2ctH=UtFO-b8c1H1Q@mail.gmail.com>
 <dc2ae336-6a26-4e3e-a901-15afbe7fc611@kernel.org>
 <CAGwozwF=ZfJ31_UBXV==x_0og+yzf2nLnrb4xG9ca027y-S_Sg@mail.gmail.com>
 <8cdc5a58-2221-4332-9a47-e0f5b7832922@kernel.org>
 <CAGwozwFoM+Wtd85Yx6_XxTv2e+qMY6wMRJSd2V+LsVn-GZUruA@mail.gmail.com>
 <411633ba-b693-4d08-81cf-426d20326434@kernel.org>
 <CAGwozwFbnSwVxO4y+_XtMVGcAC+TZByzerqx9j-vVCw+VWotZA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFbnSwVxO4y+_XtMVGcAC+TZByzerqx9j-vVCw+VWotZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/2025 3:37 PM, Antheas Kapenekakis wrote:

>> Maybe I'm failing at my search-engine-foo, could you point me at some
>> docs about this AC/DC burst stuff?
> 
> AC/DC Burst/AC/DC Burst Suppresed are the events in Sleep Study
> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-sleepstudy
> 
> You can see those when running a sleep study and unplugging a
> connector. I think suppressed is unplugging
> 
> Then here is the description for plugging in a charger
> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#environmental-context-changes-1
> 
>> The Windows power manager will turn on the display when the battery subsystem has indicated
>> AC power has been connected. The GPIO interrupt for power source changes must cause the
>> ACPI _PSR method under the power supply device to be executed. The power subsystem must
>> wake the SoC any time the power source changes, including when the system is attached or
>> removed from a dock that has a battery or AC power source. After AC power is connected,
>> the display will remain on for five seconds, unless there is input to the system during this five-second window.
> 
> And here for unplugging:
> https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-wake-sources#environmental-context-changes-2
> 
>> The GPIO interrupt for power source changes must cause the ACPI _PSR method under
>> the power supply device to be executed. The power subsystem must wake the SoC any time
>> the power source changes, including when the system is attached or removed from a dock
>> that has a battery or AC power source.

I suppose this could actually just be another way to say that there is a 
flurry of EC activity as a result of the ACPI SCI and they characterize 
that activity as a "burst" associated with unplug or plug.  It would be 
good to find actual documentation though instead of guessing.

> 
> I guess from the description it is not clear that the device stays on
> for 5 seconds when unplugging, but from empirical testing I want to
> say it does. It has been a while. I left 3 devices like an hour ago on
> Windows and none of them managed to sleep, so I cannot verify this at
> the moment though.
> 

During "display off" there is other activity that goes on until reaching 
resiliency on Microsoft side.  So it's not really cut and dry periods of 
time.

If I was to hypothesize when the screen off wakeup occurs the OS looks 
at the amount of time that has passed and if there was any scheduled 
tasks for the next wakeup gets them done before going back down.

