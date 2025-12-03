Return-Path: <linux-acpi+bounces-19395-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D74EC9D8F2
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 03:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3946349A19
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 02:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6E022FE0E;
	Wed,  3 Dec 2025 02:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkjiOfJ3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCB72628;
	Wed,  3 Dec 2025 02:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764727926; cv=none; b=MXPlwvZ7WWhcJNxn7MJwcD0QXvFuP9FHVZO6v8gGxeM+zSRR/aVvpXnvoKSROVm/cCi4AuzDpif2cQ8wbTj89CuvQsaA4GzEng7ZdmW3tr0nP9Qc3K/Vw72y1Yj8zc47A6QkxO0mVmzT4D9X5KQKeauUdXNZnze5FQDaXjvee9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764727926; c=relaxed/simple;
	bh=5ws/+GE8CaHugSwnw3dj9M0TJUhDTs7Dg22tRTSnqug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8XM9HoL/IENsvTMZ1Fbim8e7CmfWX0gRud/7ndZMlzVFSW0ov00M81nYRo2/m0BUg92Id4PFb9UV7zs9P0iYRVHYtTUEz/4FjkVc1nCIiplSR55eC36uvOL1c7+WciSySoKemyXkhY3oD+KDY/M0JMITWsbYJ54j8dwZkJC43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkjiOfJ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7979C116D0;
	Wed,  3 Dec 2025 02:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764727924;
	bh=5ws/+GE8CaHugSwnw3dj9M0TJUhDTs7Dg22tRTSnqug=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dkjiOfJ3WY32SeIxfYrgp2RvR4/fsGBf5zodfivetNfF9KwEzBA2kAjKl2gDNY+pO
	 gxptVikNJ3h4vy0S7uHZIeGTPCyuP1uaMIBxx+mkhLAShGDOZ3KxjN/aZfKer6vckp
	 Vgl1mFs7vBBcTBrdZcnV9enZiZNe+kuUrA7sMSL2kdibpljeXx444aOZzpyeBMOag6
	 DfIFQe+EKDpwBd/AWPScEs7xStN2lL8jGBR6azjxdAS+YzrYvENrsP6UQls3te+QI7
	 sJD4ZfoN4T7To8R+1xFk7OqglrwHEdd2uLJePPscL7NfCmUPt5zDTjPdcNd31e+ItW
	 86zPSiUOM3fTw==
Message-ID: <ba7f9789-fd57-4d53-bf9a-15e85657ddd7@kernel.org>
Date: Tue, 2 Dec 2025 20:12:01 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 Lennart Poettering <lennart@poettering.net>,
 Daniel Stone <daniels@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
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
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <35f69c12-ecd4-4b21-bfb0-53bf57f0febf@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
>>> An inhibitor process in logind can handle this gracefully very simply.
>>> Involving the DRM subsystem just adds a lot of complexity and it is
>>> not clear what the benefit would be. There are no known devices that
>>> hook DRM components into that DSM.
>>>
>>>> By doing it this way userspace still has control, but it's not
>>>> mandatory for userspace to be changed.
>>>
>>> On that note, the screen off calls/userspace implementations are
>>> optional under both patch series. If userspace is not aware of them,
>>> they are still called by the kernel when suspending.
>>
>> With the proposal I mentioned you can get the LPS0 _DSM called on a
>> handheld when the screen gets called without changing userspace.
>>
>>>
>>> Current userland also duplicates the functionality of the screen off
>>> call, which is primarily turning off the keyboard backlight. So along
>>> implementing this call, userspace software like powerdevil/upower
>>> needs to be tweaked to avoid doing that if the screen off state is
>>> available.
>>
>> Sure Any hooking for turning off LEDs manually based off the screen off
>> _DSM is totally feasible.
> 
> It's not that trivial to add screen on/off hooks to DRM, there is no one
> central place for that from what I can tell. I'm seeing variant with DRM
> hooks as unnecessary complexity that doesn't solve any practical problem.

Is it really that hard?  I figured that any time
connector->dpms != mode from drm_atomic_connector_commit_dpms() could 
walk through all the connectors and make a judgement call whether to 
notify the potentially exported symbol.

> 
> A week ago in a private conversation, Daniel Stone gave an example of
> laptop's lid-close handling that is done purely in userspace.
> Technically, kernel could have DRM hooks for that too, but it doesn't.

All the way into hardware sleep?  There are certain requirements needed 
for hardware sleep that kernel drivers are normally used to put devices 
into the right state.  I guess PCIe devices you can hack around with 
userspace PCI config space writes but you're going to confuse the kernel 
pretty badly.

> 
> Userspace would need to be taught about new power modes in any case.
> Addition of DRM hooks should require a well-defined justification, which
> is currently absent.
> 

Why does userspace need to know about them?  Besides the inhibitor can't 
this be invisible to userspace?  I thought this mostly is for the 
firmware to flash some LEDs and maybe change some power limits.

