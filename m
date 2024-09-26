Return-Path: <linux-acpi+bounces-8442-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F44C9878F5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 20:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B611F22DB3
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Sep 2024 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6230215FCE5;
	Thu, 26 Sep 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk+2CkGG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206813D889;
	Thu, 26 Sep 2024 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727374484; cv=none; b=EZLbEBOlYwozl/TVw/jsUdfVYIyVk9xrHyuewTNE3IiCHu3AN8ptpfN635H03h29m1ksL9zXzTi6B95mfYXGoUPe4kOnB5yFxlntwRvUaEWfSFEIrMrUP3n2hcZ9kSgcwCVnLCmJeJiPozix0sxQ7lifkPUrRtS8qdL60H2LWpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727374484; c=relaxed/simple;
	bh=N7pDSsBTC5mumG9nziGctRk8uC0jSDt0Wb1G0EiYg9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyJJLS4jDiSD2SwfUDY6nDOLSedUc/i46O6ec/4daGdpzDylegpEqBjI2fswcQHBtHvWC2YLK2vDFV2ZVghzu6xbTGlAQtJC6HCZeTyWu5a7WA6+JPjFOyDW5aGVJ0RrTE9+/KDuSnWPyTXhv4ewsul611hfm7KcrVSxs4ZT6yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tk+2CkGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BEAC4CEC5;
	Thu, 26 Sep 2024 18:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727374483;
	bh=N7pDSsBTC5mumG9nziGctRk8uC0jSDt0Wb1G0EiYg9A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tk+2CkGG7i1BjHpvfi0nvr6hfJJ9HTMNkKQBKUDVVFTRuX1zoFsTkpiTgvIdgreFw
	 lEpcgTULni3KsyoXZak0MHnbXBTJiTAp3kdhbt5eCBQ8Bena20k5mWz5osAMSVN7GH
	 0GK6dlHDEX5ZYpKO3rhRqESL9jq4J5FLFAQumoL3OrhaCL69ClpvfgTgUr++swX9Gj
	 cGpT2QbnCLH3b1lxORJxexgke6zZoaSPtmYFOZVCaCFA7YElQhvdXC64rzMd+2v3L5
	 kMXJ9LkBEJjWB0zvdf61TsCy1twhZLLfXpTiYqHNqo5HhNP/XFEWX6Mltd5aCFBzG6
	 OtDwCQcdFtr7Q==
Message-ID: <7bfba4ef-0f42-4482-874f-77a4434eb338@kernel.org>
Date: Thu, 26 Sep 2024 13:14:42 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] "custom" ACPI platform profile support
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Antheas Kapenekakis <lkml@antheas.dev>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>
References: <20240926025955.1728766-1-superm1@kernel.org>
 <2d07d31e-87f6-4576-977d-336f3d0bbc81@app.fastmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <2d07d31e-87f6-4576-977d-336f3d0bbc81@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/2024 08:58, Mark Pearson wrote:
> Thanks Mario,
> 
> On Wed, Sep 25, 2024, at 10:59 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> There are two major ways to tune platform performance in Linux:
>>   * ACPI platform profile
>>   * Manually tuning APU performance
>>
>> Changing the ACPI platform profile is a "one stop shop" to change
>> performance limits and fan curves all at the same time.
>>
>> On AMD systems the manual tuning methods typically involve changing
>> values of settings such as fPPT, sPPT or SPL.
>>
>> The problem with changing these settings manually is that the definition
>> of the ACPI platform profile if supported by the hardware is no longer
>> accurate.  At best this can cause misrepresenting the state of the
>> platform to userspace and at worst can cause the state machine into an
>> invalid state.
>>
>> The existence and continued development of projects such as ryzenadj which
>> manipulate debugging interfaces show there is a demand for manually tuning
>> performance.
>>
>> Furthermore some systems (such as ASUS and Lenovo handhelds) offer an
>> ACPI-WMI interface for changing these settings. If using anything outside
>> that WMI interface the state will be wrong.  If using that WMI interface
>> the platform profile will be wrong.
>>
>> This series introduces a "custom" ACPI platform profile and adds support
>> for the AMD PMF driver to use it when a user has enabled manual
>> adjustments.
>>
>> If agreeable a similar change should be made to asus-armoury and any other
>> drivers that export the ability to change these settings but also a
>> platform profile.
>>
> 
> As someone who supports customers on Lenovo devices and hits the occasional situation where a user has made strange tweaks to different power related settings, and then complains about power or thermal issues - I love the idea that it can be made clear the system has been 'adjusted' in a non standard way. I can also see why users would want interfaces to do those changes.

JFYI we're going to do something really similar in amdgpu when people 
have enabled overclocking.  That's part of the inspiration for this RFC.

https://lore.kernel.org/amd-gfx/CADnq5_M+vxGV6y8oEQHC+-CcqV-vW9ND4SsRHqHKbwR_b0iJ9g@mail.gmail.com/T/#m1d69399c3e799ea1ef2014a27fd6e555f9e70ba0

> 
> Some suggestions:
> 
> I'm wondering if we can make it so a driver can register only a 'custom' profile as an extra profile handler?
> 
> The thinking here is the custom setting in this series is implemented for the amd sps driver, and therefore on a regular Lenovo laptop wouldn't be used, as the thinkpad_acpi driver will grab the profile slot, Users on Lenovo systems aren't going to be able to get at these extra tweaks (unless they unload thinkpad_acpi, which has other side effects).

Well the RFC was just to show it for the AMD PMF driver, but I think 
that thinkpad_acpi, asus_armoury etc could all potentially implement the 
'custom' bit too if they offer an ACPI-WMI interface to similar settings.

> 
> If the sps driver can offer a custom mode, separately from thinkpad_acpi, then users can tweak settings to their hearts content but get back to regular mode when done.
> 
> I also think there needs to be a way that when you switch from custom back to a 'regular' profile that it would do a clean up of anything tweaked. e.g. when switching away from custom the ppd driver should call a 'custom mode cleanup' function, so things can be undone and returned to how they were when it was started.
> 
> Mark

I guess what you're proposing is that multiple drivers register as 
profile handlers and they might not all export the same features.

If we did something like this we could instead have the core call 
callbacks for all platform profile handlers.  We could also drop a pile 
of quirks from amd-pmf where there are some ASUS systems that advertise 
SPS in in the PMF framework and also asus-wmi provides it.

If I'm following you right, I generally like this idea.

