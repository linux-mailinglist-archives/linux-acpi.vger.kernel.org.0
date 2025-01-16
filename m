Return-Path: <linux-acpi+bounces-10721-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD8AA1387C
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 12:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94BE416262E
	for <lists+linux-acpi@lfdr.de>; Thu, 16 Jan 2025 11:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAC01DE3DC;
	Thu, 16 Jan 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="sKJXWGjv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0931DE3CF;
	Thu, 16 Jan 2025 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737025232; cv=none; b=eKBItM+pxNu/7X82OrqcQaNFHnRlxDYhtAX9eRyoASWGewpdwHTYPJtTuKvtbhfu3Dq3Vuvy9ktnZ4i5jlazMxBT3mW3AZ9euJVR/CFLDc2wqLDCHBGbCC/PHN46L2KXmDwOam95LyvBKo8UCcDN23m90Jkdkj8ZnRg1w0aWRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737025232; c=relaxed/simple;
	bh=qdG/fdRNNGHU0lg2+z99oR0IHwq3dqeDl0n+iEF85x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl0hsVgBv8uc+T9ANHs5nM438NnQuN44M/z+56c2WZorpVSYkLXVbk+UaetfCyVA62mZyPNwRP9c63v37ahWK+xH/btbU8FU8mgV4spyzbJOkfng5Cmmu2tRQqHhF/hSOnmoFTiDAsOIzO/fwre91IMPGKtLUXQgVprZvjpBhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=sKJXWGjv; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [10.6.0.9] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 259112FC005D;
	Thu, 16 Jan 2025 12:00:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1737025220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e3lvnwnyCzAfjPPm9gXH1aE4Sobrf2Mj2njgGn8RqtY=;
	b=sKJXWGjvN2LckuaM2msiRMEcyExiMgnJy+A9K6FEHQfn0ClcEqdxTtoN8Y0xAE0vrNjzAD
	4cpBKunwUNXdm4SaAinU4YU5R5klYXFcFqlJ7NaquV3Jr9wO49aD3fmuBjwzRvE5LLg1zu
	2DnJHme7lq33i6uKMAn10jiM/iNYwts=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <3b526ad3-2db6-40c3-9017-91f63d43f97d@tuxedocomputers.com>
Date: Thu, 16 Jan 2025 12:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thermal driver with safeguards
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>
Cc: rui.zhang@intel.com, Hans de Goede <hdegoede@redhat.com>,
 Armin Wolf <W_Armin@gmx.de>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org
References: <41483e2b-361b-4b84-88a7-24fc1eaae745@tuxedocomputers.com>
 <6ed0eb0c-c31b-41b0-93ca-c6581249c7b7@linaro.org>
 <3fbab873-c11f-40f7-b3eb-fa3c18528ba2@tuxedocomputers.com>
 <286f5efc-cd15-4e0b-bec2-2e9bbb93dd37@linaro.org>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <286f5efc-cd15-4e0b-bec2-2e9bbb93dd37@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Am 10.01.25 um 18:43 schrieb Daniel Lezcano:
> On 10/01/2025 17:56, Werner Sembach wrote:
>> Hi Daniel,
>>
>> Am 09.01.25 um 22:36 schrieb Daniel Lezcano:
>>> On 02/12/2024 15:52, Werner Sembach wrote:
>>>> Hi,
>>>>
>>>> given a pair of a temperature sensor and a fan, I want to implement a 
>>>> driver. that allows userspace to directly control the fan if it wants to. 
>>>> But have a minimum fan speed when certain high temperatures are reached to 
>>>> avoid crashes or hardware damage.
>>>
>>> From the userspace, use directly the thermal-engine which is currently under 
>>> development [1]. You can add your platform specific code in a plugin while 
>>> the thermal engine will catch all the thermal events and pass them to it [2].
>>>
>>> The thermal engine has a configuration file which will setup the thermal 
>>> framework to be woken up at different temperatures.
>> That still requires to trust userspace/the user to not write dangerous values 
>> directly to sysfs?
>
> No, it is not a trip point but temperature thresholds. So if the firmware 
> defines trip points, the userspace can not change them.
>
> Userspace thresholds are new : https://lwn.net/Articles/986009/
>
>>> The thermal engine will be proposed for a distro package, so the platform 
>>> support will be automatically supported.
>>>
>>> Beside the trip points can be setup in the device to act on higher temperature.
>> As far as i can tell these trip points only notify userspace but you can't 
>> attach code executed in kernel to it.
>
> [ ... ]
>
>>> What is unclear is how the fan is managed. I suggest to have a look at 
>>> pwm-fan.c in drivers/hwmon
>>
>> I already looked at hwmon, but that basically just writes trough values from 
>> and to userspace and has no kernel side management of temperatures and fan 
>> speeds whatsoever.
>
> IIUC, you request was about having the userspace to deal with a fan and the 
> kernel to be a safe guard, so taking over the thermal management when the 
> temperature is too high.
Not completely taking over, just enforcing a min speed.
>
> Obviously the monitored temperature must be for a device with a "slow" 
> temperature motion, userspace temperature management is not suitable for fast 
> temperature transitions.
>
> The thermal engine can for example configure different temperatures, let's 
> say: 43°C, 44°C, 46°C, 49°C and 54°C.
>
> Then the DT describes additional trip points for mitigation, one trip point 
> for mitigation could be enough (eg 80°C). One for "hot" to send to the thermal 
> engine a notification about getting really high so it can do some userspace 
> action like killing an application, and finally a "critical" trip point to 
> shutdown the system.
I guess with DT you mean device table. I deal with a driver for x86 notebooks so 
there is not DT.
>
> The fan would be a cooling device with 0-100 values representing the speed in 
> percentage. The trip point at 80°C would be associated with the fan with the 
> <0, 100> cooling states.
>
> The dynamic of the thermal management could be the following:
>
> The temperature is changing and stays in the [35°C - 60°C] boundaries. The 
> thermal engine receives the events at the different aforementioned 
> temperatures and manage to act on the pwm fan via hwmon.
>
> For any reason the temperature goes above 80°C, at this moment the kernel 
> takes over the management and will increase/decrease the fan speed between the 
> 0% - 100% limits until the temperature goes below the 80°C.
>
> If it continues to increase and reaches the "hot" trip point, then an events 
> is sent to the userspace which should take an action to reduce the temperature 
> (kill the application, reduce the battery charge, drop the frame rates, etc ...).
>
> If it continues to increase and reaches the "critical" trip point, then the 
> system shuts down.
>
> If the temperature decreases and goes below 80°C, then it returns to the 
> normal state and the thermal engine can continue its work.
>
> Does it make sense ?
>
>

