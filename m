Return-Path: <linux-acpi+bounces-10520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B09A097F2
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB81C16B5B1
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF0521323C;
	Fri, 10 Jan 2025 16:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="AGRnsR38"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332661A23B0;
	Fri, 10 Jan 2025 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736528185; cv=none; b=d3Z1dLqNVBf5zfzywwk5GdDPNS4EzBvM6XbcMSg4pnYdCE70Cnz0Xde8EwAMM6rDkHNgFgF0ujKyUkCSepS46RPf22KQQW0/jtOn44PYtUwkXariRwOjhOMcqYThtOPe43azyWO/ws+X3NDWiUJfB1Wj/cPgxAUFuz2fWyHZz+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736528185; c=relaxed/simple;
	bh=7+d2p/U16oaGJOghrxHTJmfMAYXNKUrRy5/1ait4TkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rLJfRFJdoqztuNM53ufwgL1LXSUDf1lY3Z50FI3Bc4BJ9oq0ixgKC7M6O2ewfj8IkQ8DiKgNb4viQ0Eb4/LNiF79q7FoTE1HirEO31cC2+WHwTM0KnRcYKeTIi5aqUdD9IHLRnKnhSf0+hQZDbXHZzGti0HThLzpBh1uFeYSSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=AGRnsR38; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.42.116] (pd9e5946e.dip0.t-ipconnect.de [217.229.148.110])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 819AB2FC007B;
	Fri, 10 Jan 2025 17:56:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1736528178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZwbAR7kbQ7sZE01kmy0UeRwARTTn7o+QTo2DSQOPdzw=;
	b=AGRnsR380Q1gN2UYgyQfSDAPekZ/meeGDjJEumWS0gXKpMECuoEbBFXpmKiayZE+y96KmV
	Mz+X9KbqVRL2iNk+uLnaPH4IT6S1RLVohIaYf/0Ww6x3LPVvnU0jqnhzD9LemHaqSdRcYn
	W8FhHCN7UlJov3m7fN7ST80ps1gKVRA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <3fbab873-c11f-40f7-b3eb-fa3c18528ba2@tuxedocomputers.com>
Date: Fri, 10 Jan 2025 17:56:18 +0100
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
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <6ed0eb0c-c31b-41b0-93ca-c6581249c7b7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

Am 09.01.25 um 22:36 schrieb Daniel Lezcano:
> On 02/12/2024 15:52, Werner Sembach wrote:
>> Hi,
>>
>> given a pair of a temperature sensor and a fan, I want to implement a driver. 
>> that allows userspace to directly control the fan if it wants to. But have a 
>> minimum fan speed when certain high temperatures are reached to avoid crashes 
>> or hardware damage.
>
> From the userspace, use directly the thermal-engine which is currently under 
> development [1]. You can add your platform specific code in a plugin while the 
> thermal engine will catch all the thermal events and pass them to it [2].
>
> The thermal engine has a configuration file which will setup the thermal 
> framework to be woken up at different temperatures.
That still requires to trust userspace/the user to not write dangerous values 
directly to sysfs?
>
> The thermal engine will be proposed for a distro package, so the platform 
> support will be automatically supported.
>
> Beside the trip points can be setup in the device to act on higher temperature.
As far as i can tell these trip points only notify userspace but you can't 
attach code executed in kernel to it.
>
> What is unclear is how the fan is managed. I suggest to have a look at 
> pwm-fan.c in drivers/hwmon

I already looked at hwmon, but that basically just writes trough values from and 
to userspace and has no kernel side management of temperatures and fan speeds 
whatsoever.

Kind regards,

Werner

>
>> e.g.
>>
>> - temperature of target die is 80°C -> fan speed must be at least 30%
>>
>> - temperature of target die is 90°C -> fan speed must be at least 40%
>>
>> - temperature of target die is 105°C -> fan speed must be 100%
>>
>> - temperature of target die is 110°C -> device shuts off to protect the hardware
>>
>> Would the thermal subsystem be the right place for this to implement this 
>> protection in driver?
>>
>> It already has functions around periodic temperature polling and trip points.
>
> [1] https://github.com/Linaro/libpm/tree/master
> [2] 
> https://github.com/Linaro/libpm/blob/master/thermal-engine/plugins/te-plugin-example-game.c
>
>

