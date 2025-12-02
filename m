Return-Path: <linux-acpi+bounces-19389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED061C9D14F
	for <lists+linux-acpi@lfdr.de>; Tue, 02 Dec 2025 22:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A293A5F18
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Dec 2025 21:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8312F83AA;
	Tue,  2 Dec 2025 21:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqLMK57r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226A02C21C1;
	Tue,  2 Dec 2025 21:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710731; cv=none; b=hjg3OSRAJv4eEApiwSp+IiT4nM17/DSjsyt27PpPSoZr/JhrHT2hqcpUDY78IUKTcXMVk1v8D0EhIh4OXTSyZAsougACLoMUqIW5QOCucIQhRvEo+jhvJ4z+sjyItumyH2InTMgZeRuBp1FRXDlb7gdfvqBzGot2ipuRLndKxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710731; c=relaxed/simple;
	bh=XyKpXLy/9f1vHOV4/DNuYttlABv5FMYSQduz4ChAEGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZWHCA/G0oKZ6PpUUxA/B7Qjn5IHkhocnCeIL0AbsVB1z9CtCu1NbhKKq8XOuhxtrcMKO3d7Zy4VGg5xZOhgZi2ruJbrpryOOzcaN9l38l75Olyn1Ilxgx4uzfWnYZaKXn4ZV4+0X7A51+fYr5YlEvmApqBl49Xllh0fepQmA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqLMK57r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3006BC4CEF1;
	Tue,  2 Dec 2025 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764710730;
	bh=XyKpXLy/9f1vHOV4/DNuYttlABv5FMYSQduz4ChAEGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fqLMK57rY/QCkIY9CONnCPO4ChZHPDJ6+pOIJK+qf3wIfXs9xf0IXsJAQEtIJwWMJ
	 wlJlnWSVNLTdtvaB3toR5Mzt+hqWFcTeMNYwxpRdIWMKawKsI2HYwNxZqZA0YMyH1S
	 cl+Bdr9ZhvfihQJkSArg2zZnAWaIe6k19d+hRpEBMCClNEJMoHBS00DwFnELGR72Ic
	 2b3krsO6WnAAVI6Zz7JVCv0dOcTRCiKFru6kBWRlIp2jl7VbUeRWSiKOKLjuqVtFax
	 dLOh8iqMnkTxyc2uE7ERPEiBezdwbEAc0mr8fHxKkZQMCd2VV5Zyv9XHvF5VK+jtkV
	 3NfliTbY7XKxQ==
Message-ID: <02103d95-7bca-4db0-81c6-ac36429ea0bb@kernel.org>
Date: Tue, 2 Dec 2025 15:25:26 -0600
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
 Lennart Poettering <lennart@poettering.net>
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Beckett <bob.beckett@collabora.com>, linux-acpi@vger.kernel.org,
 kernel@collabora.com, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Xaver Hugl <xaver.hugl@gmail.com>, Richard Hughes <richard@hughsie.com>,
 William Jon McCann <mccann@jhu.edu>, "Jaap A . Haitsma" <jaap@haitsma.org>,
 Benjamin Canou <bookeldor@gmail.com>, Bastien Nocera <hadess@hadess.net>,
 systemd-devel@lists.freedesktop.org
References: <20251202043416.2310677-1-dmitry.osipenko@collabora.com>
 <20251202043416.2310677-2-dmitry.osipenko@collabora.com>
 <CAGwozwG=F1BC8UF6Xkest5pwZG6iRjNjk5zpjmSV8Yh-0S2tGA@mail.gmail.com>
 <c7760b2d-c8cb-40fa-b1b1-8715e97e5cf0@kernel.org>
 <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwHi_U_R3ueJaYDaR_Pa6JntNbEh1dpwwbZW7jtrs5mbQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> Why would you want to expose all those states to userspace?  I feel like
>> it is going to be risky to have userspace changing the state machine for
>> suspend like that.
> 
> The reasoning is that if userspace is to be made able to run while the
> device is in those states it should be able to command the device to
> enter them. Right now the sleep _DSMs are tucked above the LPS0 call
> after userspace is frozen. Specifically for the sleep _DSM I am not
> suggesting that all software should be able to run after it is called.
> But this limitation responsibility is placed on the init system
> currently for the Linux desktop (android has wakelocks).

I see.  This is a pretty big change you're proposing, I think we should 
see what Rafael has to say.

> 
> In the case of systemd, this would be potentially two-tier freezer
> groups. The first freezer group for userspace apps is implemented
> already to improve hibernation behavior. A second freezer group could
> be introduced for crucial lightweight services that are able to run
> and hold locks under this sleep state. In addition,
> suspend-then-hibernate/spurious wakeup checks* can also run in this
> sleep state, to avoid powering on the power LED of a device/fan for
> certain manufacturers when checks happen.

OK I get the concept of two cgroups of frozen processes.  In your mind 
what are some samples processes that would actually be in the other group?

And do you really need the LPS0 _DSM callback to be active at this time?

> 
> *non-existent currently-but newer Modern Standby devices like to wake
> up randomly due to e.g. charge state change

I wouldn't expect anything to be random here - I would describe this as 
unhandled wakeup reasons.

> 
>> Since the _DSM call that is interesting here is focusing specifically on
>> screen off I have a slightly different proposal on how this could work.
> 
> Both Sleep and Screen Off DSM are interesting but let's focus on
> Screen Off for now.
> 
>> What about if instead of an explicit userspace calling interface it's an
>> inhibition/voting interface:
>>
>> While in screen on:
>> * By default no inhibitions are set.
>> * If no inhibitions are set and all physical displays go into DPMS then
>> DRM can do an call (using an exported symbol) to enter screen off.
>> * If userspace is using a remote display it could set an inhibition.
>> * When the inhibition is cleared (IE userspace indicates that a remote
>> display is no longer in use) then:
>>     * if all physical displays are already off call screen off.
>>     * if at least one physical display is on do nothing (turning off
>> physical displays would call screen off)
>>
>> While in screen off
>> * When a physical display is turned DRM would use exported symbol to
>> call screen on.
>>    * When  an inhibitor is added call screen ON.
> 
> I think we have discussed some of the limitations of this approach in
> a previous thread.
> 
> Userspace software that renders external displays would not have
> rootful access to this API, it would use a dbus lock implemented by
> systemd, in which case there is no need for a kernel side api
> 

This is a solvable problem in userspace.  It's the same problem no 
matter you have a sysfs interface that does enable/disable or that inhibits.

> Exporting these symbols to DRM would cause potential timing issues if
> a CRTC is turned on and off rapidly. The calls in Windows are
> debounced, specifically to after 5 seconds the screen turns off due to
> inactivity.

What's wrong with it going quickly?  If there is a problem, sure a 
workqueue is just fine.

> 
> An inhibitor process in logind can handle this gracefully very simply.
> Involving the DRM subsystem just adds a lot of complexity and it is
> not clear what the benefit would be. There are no known devices that
> hook DRM components into that DSM.
> 
>> By doing it this way userspace still has control, but it's not
>> *mandatory* for userspace to be changed.
> 
> On that note, the screen off calls/userspace implementations are
> optional under both patch series. If userspace is not aware of them,
> they are still called by the kernel when suspending.

With the proposal I mentioned you can get the LPS0 _DSM called on a 
handheld when the screen gets called without changing userspace.

> 
> Current userland also duplicates the functionality of the screen off
> call, which is primarily turning off the keyboard backlight. So along
> implementing this call, userspace software like powerdevil/upower
> needs to be tweaked to avoid doing that if the screen off state is
> available.

Sure Any hooking for turning off LEDs manually based off the screen off 
_DSM is totally feasible.




