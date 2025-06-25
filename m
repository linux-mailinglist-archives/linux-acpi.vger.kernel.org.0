Return-Path: <linux-acpi+bounces-14593-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031FEAE85BE
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 16:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 997D27B643A
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 14:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21D0264A86;
	Wed, 25 Jun 2025 14:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikIPi8cU"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B13074B2;
	Wed, 25 Jun 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860577; cv=none; b=BCbKiOVfVT1mQrS26aD+Ezx2eOHlJhrt54e3UoweDZ0Jl6RG5lqiehGmdAFtHmB7G3sHLWcCFR5unyX1QPdVyxi42tQrNEg0PAJCx7JPnU2D1zaK20DrwcAcamDo1L6oixFKj/G+D0IWmDriqYzMKowoM2P4ID3vrhPvwjqtxhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860577; c=relaxed/simple;
	bh=mKmabAIo8Fb88oFDDtzqpED5rlh6TYCDvirbbBC1noU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMo0vbncQksdlWieqF8T0XPSNZPT43dWvG4eWMHZGmUZyJuc7VtmUAZj5r8GcWtJt6bHyFSghhr7pbkxonPTGPPFeBd6Y9Eid1F5Qjc5WXzQYcrI0mVSsIw07lJ5flB4N+tNWHHnGv9y2lJKp6Pqx1ssV/Pz1p66a+hnlnIve1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikIPi8cU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0E1C4CEEA;
	Wed, 25 Jun 2025 14:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750860576;
	bh=mKmabAIo8Fb88oFDDtzqpED5rlh6TYCDvirbbBC1noU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ikIPi8cU1y28w0Q0boFWDBnZ7Q66EBU8Jrs/z58KjVcd0wXNfEaS1l+nO6OjlPBkW
	 3UNYbKb8l6urSqohhLJf/LD1fy+MA1h7TU6d+MA/00usOcv7+uyK+LWFo5U6x4Jm+A
	 q7QbEz4Ss/b8IGu8DOjzaMs6uio9dsJ76VEBibUfufC3Dqqb+q9039NaALhPlJbaAg
	 8RjLX5lk3jY17LZFgCinIjgyY3y79CiU9CJgFKaciq9JieEupd996VLvrYppFLTdpr
	 Dp81d76OW9iIIGHVY917h4y6PU/hBi45WIvHdF7P9upx37wqY0w+vLhtDZcs1SMO+e
	 zaQflR4c/EZFA==
Message-ID: <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
Date: Wed, 25 Jun 2025 09:09:34 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
To: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-3-superm1@kernel.org>
 <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4a4d577b-a085-46e8-97b9-6df27461c870@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/25/25 4:09 AM, Hans de Goede wrote:
> Hi Mario,
> 
> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>> hardcoded all soc-button-array devices to use a 50ms debounce timeout
>> but this doesn't work on all hardware.  The hardware I have on hand
>> actually prescribes in the ASL that the timeout should be 0:
>>
>> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>>           "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>> {   // Pin list
>>      0x0000
>> }
>>
>> Let the GPIO core program the debounce instead of hardcoding it into a
>> driver.
>>
>> This reverts commit 5c4fa2a6da7fbc76290d1cb54a7e35633517a522.
> 
> This is going to cause problems I'm afraid I just checked and
> based on randomly checking a few DSDTs of the tablets this driver
> is used on, it seems the DSDT always specifies a debounce timeout
> of 0 like your example above. And on many many devices using
> the soc_button_array driver debouncing is actually necessary.

That's unfortunate to hear.

> 
> May I ask what problem you are seeing with the 50ms debounce timeout /
> what problem you are exactly trying to fix here ?

The power button doesn't work to wake from suspend.  I bisected it down 
to your commit and then later traced that debounce from the ASL never 
gets set (pinctrl-amd's amd_gpio_set_debounce() is never called).

Also comparing the GPIO register in Windows (where things work) Windows 
never programs a debounce.

So that's where both patches in this series came from.

> 
> drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
> it self with the 50 ms provided by soc_button_array and if that does
> not work it will fall back to software debouncing. So I don't see how
> the 50 ms debounce can cause problems, other then maybe making
> really really (impossible?) fast double-clicks register as a single
> click .
> 
> These buttons (e.g. volume up/down) are almost always simply mechanical
> switches and these definitely will need debouncing, the 0 value from
> the DSDT is plainly just wrong. There is no such thing as a not bouncing
> mechanical switch.

On one of these tablets can you check the GPIO in Windows to see if it's 
using any debounce?

> 
> Regards,
> 
> Hans
> 
> 
> 
>>
>> Cc: Hans de Goede <hansg@kernel.org>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/input/misc/soc_button_array.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
>> index b8cad415c62ca..99490df42b6f2 100644
>> --- a/drivers/input/misc/soc_button_array.c
>> +++ b/drivers/input/misc/soc_button_array.c
>> @@ -219,8 +219,6 @@ soc_button_device_create(struct platform_device *pdev,
>>   		gpio_keys[n_buttons].active_low = info->active_low;
>>   		gpio_keys[n_buttons].desc = info->name;
>>   		gpio_keys[n_buttons].wakeup = info->wakeup;
>> -		/* These devices often use cheap buttons, use 50 ms debounce */
>> -		gpio_keys[n_buttons].debounce_interval = 50;
>>   		n_buttons++;
>>   	}
>>   
> 


