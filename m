Return-Path: <linux-acpi+bounces-14594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16181AE8683
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 16:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4820189177D
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 14:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C9424A06F;
	Wed, 25 Jun 2025 14:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhvUBeDz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C37175A5;
	Wed, 25 Jun 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750861886; cv=none; b=VsDSNXGzgBrGgAEMguXTpMwwFh3iFKjiXlL45W2b5ZQ30NQOrS1jLJfSARP3hpwBD8ryUh4koumahhdXnUfemxkWN4d26Me4RngaEdjcitf5qeP/TvfPEzHqTpOyHsDCdplhyBjT9j5DpgbjkY1JZK+wjI/I7XoUn9n8xaDk1sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750861886; c=relaxed/simple;
	bh=Jcjv+dddV2ui/w203eJdS8SKE0fSdMAbf6Th4P6s6sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dUg6g5h50brRH+wnzoY2C+BlqUsqMidzNkiuJM4aNbuxu2Yut+DJfPoRCT2RiT/87RKbmfUDN9P6utrJF6A2YNgxI6zg48OQ/t5bCIx3M2aEf7VSxdbNi/Fp0vC1TmDR53DCDhqziwicIHi9WNN3JoWWdGJdomQvbAi0SJ/rsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhvUBeDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C91C4CEEA;
	Wed, 25 Jun 2025 14:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750861885;
	bh=Jcjv+dddV2ui/w203eJdS8SKE0fSdMAbf6Th4P6s6sw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JhvUBeDzL7M6b/VIQTjsjQox29Ft5/n+QtfpwL/mRmVUAtjEvCwvnSygjEKmqRMml
	 r9rWrz286dnobMM1Au/LMyDS6a3aMVFFBsd/yLaKsWT5pHgmbXNnKfvy6rCPlcqxd1
	 wowLCk+7H2RnhWeItQJF55C3XNfywypAqCcY8Z7wjb7MqqMcFqFSAZ9lzTvHrfir3I
	 4KrgIAt9fH+kpSOKpUkSo+LBXFrOTinKmkKSK7Ny3dW0x3mgfPAxi+7ditCy+iBvdN
	 cA93qAud4RhLKaiBRXTmTpqJwbmVeP+cYVvFUoCmD938ig+P1YiwrHHXf5N6Ma6F1w
	 DE+TNcjCCFSeg==
Message-ID: <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
Date: Wed, 25 Jun 2025 16:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Revert "Input: soc_button_array - debounce the
 buttons"
To: Mario Limonciello <superm1@kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
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
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mario,

On 25-Jun-25 4:09 PM, Mario Limonciello wrote:
> On 6/25/25 4:09 AM, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:
>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>>> hardcoded all soc-button-array devices to use a 50ms debounce timeout
>>> but this doesn't work on all hardware.  The hardware I have on hand
>>> actually prescribes in the ASL that the timeout should be 0:
>>>
>>> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>>>           "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>>> {   // Pin list
>>>      0x0000
>>> }
>>>
>>> Let the GPIO core program the debounce instead of hardcoding it into a
>>> driver.
>>>
>>> This reverts commit 5c4fa2a6da7fbc76290d1cb54a7e35633517a522.
>>
>> This is going to cause problems I'm afraid I just checked and
>> based on randomly checking a few DSDTs of the tablets this driver
>> is used on, it seems the DSDT always specifies a debounce timeout
>> of 0 like your example above. And on many many devices using
>> the soc_button_array driver debouncing is actually necessary.
> 
> That's unfortunate to hear.
> 
>>
>> May I ask what problem you are seeing with the 50ms debounce timeout /
>> what problem you are exactly trying to fix here ?
> 
> The power button doesn't work to wake from suspend.  I bisected it down to your commit and then later traced that debounce from the ASL never gets set (pinctrl-amd's amd_gpio_set_debounce() is never called).

Ok, so specifically the gpiod_set_debounce() call with 50 ms
done by gpio_keys.c is the problem I guess?

So amd_gpio_set_debounce() does accept the 50 ms debounce
passed to it by gpio_keys.c as a valid value and then setting
that breaks the wake from suspend?

> Also comparing the GPIO register in Windows (where things work) Windows never programs a debounce.

So maybe the windows ACPI0011 driver always uses a software-
debounce for the buttons? Windows not debouncing the mechanical
switches at all seems unlikely.

I think the best way to fix this might be to add a no-hw-debounce
flag to the data passed from soc_button_array.c to gpio_keys.c
and have gpio_keys.c not call gpiod_set_debounce()  when the
no-hw-debounce flag is set.

I've checked and both on Bay Trail and Cherry Trail devices
where soc_button_array is used a lot hw-debouncing is already
unused. pinctrl-baytrail.c does not accept 50 ms as a valid
value and pinctrl-cherryview.c does not support hw debounce
at all.

> So that's where both patches in this series came from.
> 
>>
>> drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
>> it self with the 50 ms provided by soc_button_array and if that does
>> not work it will fall back to software debouncing. So I don't see how
>> the 50 ms debounce can cause problems, other then maybe making
>> really really (impossible?) fast double-clicks register as a single
>> click .
>>
>> These buttons (e.g. volume up/down) are almost always simply mechanical
>> switches and these definitely will need debouncing, the 0 value from
>> the DSDT is plainly just wrong. There is no such thing as a not bouncing
>> mechanical switch.
> 
> On one of these tablets can you check the GPIO in Windows to see if it's using any debounce?

I'm afraid I don't have Windows installed on any of these.

But based on your testing + the DSDT specifying no debounce
for the GPIO I guess Windows just follows the DSDt when it
comes to setting up the hw debounce-settings and then uses
sw-debouncing on top to actually avoid very quick
press-release-press event cycles caused by the bouncing.

Regards,

Hans





>>> Cc: Hans de Goede <hansg@kernel.org>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>   drivers/input/misc/soc_button_array.c | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
>>> index b8cad415c62ca..99490df42b6f2 100644
>>> --- a/drivers/input/misc/soc_button_array.c
>>> +++ b/drivers/input/misc/soc_button_array.c
>>> @@ -219,8 +219,6 @@ soc_button_device_create(struct platform_device *pdev,
>>>           gpio_keys[n_buttons].active_low = info->active_low;
>>>           gpio_keys[n_buttons].desc = info->name;
>>>           gpio_keys[n_buttons].wakeup = info->wakeup;
>>> -        /* These devices often use cheap buttons, use 50 ms debounce */
>>> -        gpio_keys[n_buttons].debounce_interval = 50;
>>>           n_buttons++;
>>>       }
>>>   
>>
> 


