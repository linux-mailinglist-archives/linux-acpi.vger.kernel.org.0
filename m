Return-Path: <linux-acpi+bounces-19400-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D48BC9DF4E
	for <lists+linux-acpi@lfdr.de>; Wed, 03 Dec 2025 07:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C053C346364
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Dec 2025 06:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084642882D3;
	Wed,  3 Dec 2025 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="YULaOp35"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294633207;
	Wed,  3 Dec 2025 06:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764744460; cv=pass; b=Es68wJ0HJ7HrBKXzHiZchlbz2jThfJ3qySO1YQza/NJgWPm5A6OgSb2J+xfc/plR9QCVmRASPL6pE11Ez7zvBWdEgHB5L90tfqBGXfe892UOmWdRMnJGTN7Qsk9Uqnu5pl8cVKCzduK73UIhZgV3mNi5gEyL72A9NvYIzO24KWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764744460; c=relaxed/simple;
	bh=64t97yL/fKIk+dAjW+u3ookSyLfPIL8RlN7SmdA3NLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN/oTJqyKORyjaO/uI6FuwlYQMwj2IzANQ9C8gY4JY5tH1a89wphyXInpKTFHcQV+h+ESMX9ugoarbeeYajBbe5zMkcl8WC4Mwt30MJIt9BN7ObE2SJ8gF+zyGxMIm72ePIvdWcc33aSvImpLwlIn3+Zd2mEWHxtIRVOukrELO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=YULaOp35; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1764744427; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=adcaaadQ9bQPe2gi5zs7CYkbpCO0irOUxxyXYw/rtehGLpBfl2T4wog5uebMpgklAutVDea5BJulhewTVIid4/xfxOSwxrWSxHaRTgidYOh6AS1iWRSVP72pSnatgBZsKD3y/Kz4NpS+1vXnkEom6DKsiMjRlkuMADUmXF9Ov+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764744427; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8GvbmRWwlb7wA01a4EnaF3w8ynUT2jXh7V8LW5SIOlQ=; 
	b=k9I7AME8DJBvZ8hViytQUo1kdhIq4+oZOYFBB5hwqdXePPNYZDCRHz6aIr1mTXdeY59et9tnOHWi08Krt5bDearxeuOT9BHmmlH43vEZI3uC7pkXNxMCaQsdrWnzs8lSkL2Mx2FL7AbEJCgmavly2TKx4J1OIzvTNqiiWlgyvW4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764744427;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8GvbmRWwlb7wA01a4EnaF3w8ynUT2jXh7V8LW5SIOlQ=;
	b=YULaOp3597YUTXvpZpLMdri6bHWIGGYbCuTY0VidS0LHTsnKeZxdFkpkWFkTZvCW
	ZwatpZ4tXe6iYtlkXw/nnbhg61unlR42q9yb0bUFOrhZulUKhO88fG4nnJWHBvIx7Vq
	4CQ/gsFKW8/i9bX3J2o4ldz6Hffpq+qglbqgVjlI=
Received: by mx.zohomail.com with SMTPS id 1764744425567119.09519179039432;
	Tue, 2 Dec 2025 22:47:05 -0800 (PST)
Message-ID: <82357e17-56ec-4dd6-82b2-0b8308f7aec2@collabora.com>
Date: Wed, 3 Dec 2025 09:46:59 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 1/1] ACPI: PM: s2idle: Add lps0_screen_off sysfs
 interface
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
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
 <ba7f9789-fd57-4d53-bf9a-15e85657ddd7@kernel.org>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <ba7f9789-fd57-4d53-bf9a-15e85657ddd7@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 12/3/25 05:12, Mario Limonciello (AMD) (kernel.org) wrote:
> 
> 
> On 12/2/2025 4:35 PM, Dmitry Osipenko wrote:
>> On 12/3/25 00:25, Mario Limonciello (AMD) (kernel.org) wrote:
>>>> An inhibitor process in logind can handle this gracefully very simply.
>>>> Involving the DRM subsystem just adds a lot of complexity and it is
>>>> not clear what the benefit would be. There are no known devices that
>>>> hook DRM components into that DSM.
>>>>
>>>>> By doing it this way userspace still has control, but it's not
>>>>> mandatory for userspace to be changed.
>>>>
>>>> On that note, the screen off calls/userspace implementations are
>>>> optional under both patch series. If userspace is not aware of them,
>>>> they are still called by the kernel when suspending.
>>>
>>> With the proposal I mentioned you can get the LPS0 _DSM called on a
>>> handheld when the screen gets called without changing userspace.
>>>
>>>>
>>>> Current userland also duplicates the functionality of the screen off
>>>> call, which is primarily turning off the keyboard backlight. So along
>>>> implementing this call, userspace software like powerdevil/upower
>>>> needs to be tweaked to avoid doing that if the screen off state is
>>>> available.
>>>
>>> Sure Any hooking for turning off LEDs manually based off the screen off
>>> _DSM is totally feasible.
>>
>> It's not that trivial to add screen on/off hooks to DRM, there is no one
>> central place for that from what I can tell. I'm seeing variant with DRM
>> hooks as unnecessary complexity that doesn't solve any practical problem.
> 
> Is it really that hard?  I figured that any time
> connector->dpms != mode from drm_atomic_connector_commit_dpms() could
> walk through all the connectors and make a judgement call whether to
> notify the potentially exported symbol.

- drm_atomic_connector_commit_dpms() is used only for atomic ioctl path
- there is another legacy kms path
- AFAICT, DRM takes a different path when display is enabled initially
by kernel

Here we have 3 places where to plug the hook. Gives a strong feeling of
a red flag, IMO.

>> A week ago in a private conversation, Daniel Stone gave an example of
>> laptop's lid-close handling that is done purely in userspace.
>> Technically, kernel could have DRM hooks for that too, but it doesn't.
> 
> All the way into hardware sleep?  There are certain requirements needed
> for hardware sleep that kernel drivers are normally used to put devices
> into the right state.  I guess PCIe devices you can hack around with
> userspace PCI config space writes but you're going to confuse the kernel
> pretty badly.

- Userspace gets notification for a changed lid state
- Userspace takes action of turning display on/off
- Kernel DRM doesn't know and doesn't care about lid state,
force-disabling display on machine suspension

Don't see how this is different for the case of the LPS0 notifications.
Maybe I'm not getting your point well, in that case please clarify more.

>> Userspace would need to be taught about new power modes in any case.
>> Addition of DRM hooks should require a well-defined justification, which
>> is currently absent.
>>
> 
> Why does userspace need to know about them?  Besides the inhibitor can't
> this be invisible to userspace?  I thought this mostly is for the
> firmware to flash some LEDs and maybe change some power limits.

What I was saying is that LPS0 inhibitors would represent the power mode
controls by themselves. Userspace would have to know how to drive them.

Userspace power managers are already driving displays DPMS. Combining
this with knowledge about the LPS0 inhibitors gives userspace ability to
support the new device power states. Hence, there is no practical need
to bother kernel DRM with the LPS0 burden.

-- 
Best regards,
Dmitry

