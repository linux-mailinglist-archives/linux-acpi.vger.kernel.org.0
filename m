Return-Path: <linux-acpi+bounces-10523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4A6A098CB
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 18:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99757188BB6B
	for <lists+linux-acpi@lfdr.de>; Fri, 10 Jan 2025 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1901214213;
	Fri, 10 Jan 2025 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItBn/Sl0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68062135A5
	for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2025 17:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736531014; cv=none; b=fLmzW5dzbaCpS5mo7b6WFgED18gRRMEDri8DYrS0+7SCD/cFogroFEEuu6eQ8i6mkXvLH7GfcdJolJrd5n2D/uX1ryVSWEtEJ1xVwocGjcYpaJnO9w583VKcfZvbzPfeCWWbuSaBSPs6TqotqDtX0KBNQLmXLGileUWABDEH4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736531014; c=relaxed/simple;
	bh=1Apa2WFTIcBJKzkJjvR6blkh0yURS6Fp5+goTMyn5BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VnLIESRUwK+VO30v2QGBF368fwsXDlgv9kD3y1yxH59KA8DlA/OAJCmx89bQKK7iGklhaj/7An91RAtUuV6YelCgAmxNqRIMGzFGTEIa4LJQE4eW8WcE+XZSPNkbnhUl3136g32IUaluTfIOYAW4BsT18716GYG3ucrrULpUU2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ItBn/Sl0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-436249df846so17347565e9.3
        for <linux-acpi@vger.kernel.org>; Fri, 10 Jan 2025 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736531011; x=1737135811; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxJz8MqeXBjnKI6kFTM6HAt0VIbHBekV4LBKCGRzAS0=;
        b=ItBn/Sl0wUbwH/TyLkf/EVlV47dPSqUB7tkJB6SBaQ/hF/y2ygWfQEqFxvMCLQFi+b
         45ZImb9wX36QLqKqmESnWesWGhaTEXI7cx0/pFXWxWrUlLT9x4mNthgNTYDn0Q7ArsvB
         IBaaiVV4fYlDspa9bxkbIghUBKiDDrXkgzwelNjCG8yntjd8mozWU+8SSq1am3XWlOD9
         pB1xq9Vgrw5q+3cshgOKukTuwm+UV1vBP3l6CX0uEEeArWr0d9kTVDPQLIcbOoAORT5y
         XYIznGem36lo6+FL0uvOziq25kKAyryt4vLZhO5Ph3N0Gt71pWz8vc8KU3nKpuxbgVJc
         jJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736531011; x=1737135811;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LxJz8MqeXBjnKI6kFTM6HAt0VIbHBekV4LBKCGRzAS0=;
        b=cMjUsfNvhNam6QkiH6CJrBtXGM3mAoOIuqhPKubetmK1rW49BjTSjCrZyrttX2LoXZ
         2v3juwHpDSATTMSlaRqD5+1wyH6f4wuYSQFLw/sVd21bXrHHKhuVSyIAVjjz2OJH1uFL
         vGq2Z38NWpminRcjRQ69G685A0mY9vdYnBgoUdyPmbZ2gAr0uvZWaZ3ky40TwfPQh2N8
         MB5U/EfpJeLxrtzcvk/W39pcDAxoj2UVOQmEEpOTy/sPKedvGyR3s4OGisAZzWLFaNEl
         wviCCM5oDvHwzOlpn3IdHbGCkjoX3ruJYdHyXehxhWXOr4F41opxu95ocV7ap1k4Kjf4
         4bgA==
X-Forwarded-Encrypted: i=1; AJvYcCVZ4paMuEsx179Rs3cnIjN/DoX1/DRvcmZxomzQNDgywUVev4f+p1l9itptstxi9LFOBZc1us+oWKHa@vger.kernel.org
X-Gm-Message-State: AOJu0YzUMi8eimAeAFR/wAcmG/uNFOmu9/0dGMtZmxYaSF6HDerh04rB
	XYnDh/rVBjikgSDIBO1b/lLlYZzeY7KPVK3Fk9VMRrgKfUr6WEfJ1Ck/bHzUHfM=
X-Gm-Gg: ASbGncvXLaPDh5TEHf0+fK0pf5g8Z1XfW4T4RLonMe9VjkteZ9D8a+8zOjXiQWfNZuN
	ZeUIJ3FxrJkfPzrXlp33pOm9W09ErApnrt/1qltj+0T3NxSnWb9CzAzGveS64FjviKoHoVkcaJV
	wi/6GQWhdWLXwMZjr5vMgecQKav3jNhs7hDu3o35mf6Z+d18rddyKc25L+WIUvf9fu6fqzlk/6V
	DJIvfJwiQRPvZ5F2LbmQHvnL0LksJ9KpvJ5KgC4d7v5VFFVRvnDJc/o9lkuvMWZMDGwTy1LcOo/
	ZszeP/qQKfjKzu+ZKrmo
X-Google-Smtp-Source: AGHT+IGD1p5BWi+8fdojfwO/xsLJX8SqpKI8+n+3hiWhMt/TQN/d5LHbHuIgZ1cAKgtewl4Ayk+PkQ==
X-Received: by 2002:a05:600c:1ca4:b0:434:9f81:76d5 with SMTP id 5b1f17b1804b1-436e26d931bmr96425175e9.22.1736531011203;
        Fri, 10 Jan 2025 09:43:31 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38a8e38efeesm5165684f8f.62.2025.01.10.09.43.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 09:43:30 -0800 (PST)
Message-ID: <286f5efc-cd15-4e0b-bec2-2e9bbb93dd37@linaro.org>
Date: Fri, 10 Jan 2025 18:43:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Thermal driver with safeguards
To: Werner Sembach <wse@tuxedocomputers.com>,
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
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3fbab873-c11f-40f7-b3eb-fa3c18528ba2@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/01/2025 17:56, Werner Sembach wrote:
> Hi Daniel,
> 
> Am 09.01.25 um 22:36 schrieb Daniel Lezcano:
>> On 02/12/2024 15:52, Werner Sembach wrote:
>>> Hi,
>>>
>>> given a pair of a temperature sensor and a fan, I want to implement a 
>>> driver. that allows userspace to directly control the fan if it wants 
>>> to. But have a minimum fan speed when certain high temperatures are 
>>> reached to avoid crashes or hardware damage.
>>
>> From the userspace, use directly the thermal-engine which is currently 
>> under development [1]. You can add your platform specific code in a 
>> plugin while the thermal engine will catch all the thermal events and 
>> pass them to it [2].
>>
>> The thermal engine has a configuration file which will setup the 
>> thermal framework to be woken up at different temperatures.
> That still requires to trust userspace/the user to not write dangerous 
> values directly to sysfs?

No, it is not a trip point but temperature thresholds. So if the 
firmware defines trip points, the userspace can not change them.

Userspace thresholds are new : https://lwn.net/Articles/986009/

>> The thermal engine will be proposed for a distro package, so the 
>> platform support will be automatically supported.
>>
>> Beside the trip points can be setup in the device to act on higher 
>> temperature.
> As far as i can tell these trip points only notify userspace but you 
> can't attach code executed in kernel to it.

[ ... ]

>> What is unclear is how the fan is managed. I suggest to have a look at 
>> pwm-fan.c in drivers/hwmon
> 
> I already looked at hwmon, but that basically just writes trough values 
> from and to userspace and has no kernel side management of temperatures 
> and fan speeds whatsoever.

IIUC, you request was about having the userspace to deal with a fan and 
the kernel to be a safe guard, so taking over the thermal management 
when the temperature is too high.

Obviously the monitored temperature must be for a device with a "slow" 
temperature motion, userspace temperature management is not suitable for 
fast temperature transitions.

The thermal engine can for example configure different temperatures, 
let's say: 43°C, 44°C, 46°C, 49°C and 54°C.

Then the DT describes additional trip points for mitigation, one trip 
point for mitigation could be enough (eg 80°C). One for "hot" to send to 
the thermal engine a notification about getting really high so it can do 
some userspace action like killing an application, and finally a 
"critical" trip point to shutdown the system.

The fan would be a cooling device with 0-100 values representing the 
speed in percentage. The trip point at 80°C would be associated with the 
fan with the <0, 100> cooling states.

The dynamic of the thermal management could be the following:

The temperature is changing and stays in the [35°C - 60°C] boundaries. 
The thermal engine receives the events at the different aforementioned 
temperatures and manage to act on the pwm fan via hwmon.

For any reason the temperature goes above 80°C, at this moment the 
kernel takes over the management and will increase/decrease the fan 
speed between the 0% - 100% limits until the temperature goes below the 
80°C.

If it continues to increase and reaches the "hot" trip point, then an 
events is sent to the userspace which should take an action to reduce 
the temperature (kill the application, reduce the battery charge, drop 
the frame rates, etc ...).

If it continues to increase and reaches the "critical" trip point, then 
the system shuts down.

If the temperature decreases and goes below 80°C, then it returns to the 
normal state and the thermal engine can continue its work.

Does it make sense ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

