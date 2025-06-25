Return-Path: <linux-acpi+bounces-14595-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D1BAE86CF
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 16:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C8CB1895387
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2342690D1;
	Wed, 25 Jun 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4qpNxN9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E040265CC5;
	Wed, 25 Jun 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750862513; cv=none; b=eLerz1bG8EWcGbxCFORLCBDYE5KCthVxaDQj+cMeHHgF0ovDEs/GCbfVkMvIgRlGiJNonpC5Fo07oNx4gAfXApUCD7n6SgmBfy09qtt/f/LrnZ8lx1beSampcH1srkUpPwW07hGekA7EFSN3cW0+CXQ4zgnk1M2w0GViLVyQPEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750862513; c=relaxed/simple;
	bh=HbrmvPszGJbU3fqYSZC3uZA+lhL1yUXVrJ7I7BH6WzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uq46uw/zgf6U16w7W2CnL9LmWR+ow2I3h8JRosYKjZDp3KZP+x9d/hb0ImcO/gT75PdmhokKQ7j1Rk9WaBO5kOoR7uCapl5qzDEswf+ouway+7iE3hWcfvmm8s9I7tEBzvs0WhifMIzCnJr4EjYWPEDs+ScO3hstIDHLCmm6tZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4qpNxN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51C8C4CEEA;
	Wed, 25 Jun 2025 14:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750862512;
	bh=HbrmvPszGJbU3fqYSZC3uZA+lhL1yUXVrJ7I7BH6WzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U4qpNxN9mwxN013tZBA8h7r1s9VJq3FJ7G2ai8w20AVX3ykxGMvtmcGxdfqoR5MUH
	 r9s4T+apXI+sj2xJCuc/5qNCmg+yQIh/E4kip0bXpKayGRCBTjUuzHQP7MbJRnlRxm
	 IDA4UQUMqcTbZb7yen9KpHXGj5G5Ie5/FuMu1eZUR886bef6YKlLA9XEcJ2yWfyqeT
	 ziL2LdP2NN1fje9SfTsxdZyzoJ1QXTtzmOOZw18tW3yiEjdHIT29LdDPUNgh/ZJJ/t
	 WC2T4ceETOPFMvpTGEIKnRTSsV1fwLFDHj39nZXB80+QLN4uVxlWVdMkDk1XMc+PWG
	 CIJ1+4ELcv0SA==
Message-ID: <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
Date: Wed, 25 Jun 2025 09:41:51 -0500
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
 <1f8c0262-b376-43cb-b2c5-5b60e8cbf678@kernel.org>
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/25/25 9:31 AM, Hans de Goede wrote:
> Hi Mario,
> 
> On 25-Jun-25 4:09 PM, Mario Limonciello wrote:
>> On 6/25/25 4:09 AM, Hans de Goede wrote:
>>> Hi Mario,
>>>
>>> On 24-Jun-25 10:22 PM, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>>>> hardcoded all soc-button-array devices to use a 50ms debounce timeout
>>>> but this doesn't work on all hardware.  The hardware I have on hand
>>>> actually prescribes in the ASL that the timeout should be 0:
>>>>
>>>> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>>>>            "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
>>>> {   // Pin list
>>>>       0x0000
>>>> }
>>>>
>>>> Let the GPIO core program the debounce instead of hardcoding it into a
>>>> driver.
>>>>
>>>> This reverts commit 5c4fa2a6da7fbc76290d1cb54a7e35633517a522.
>>>
>>> This is going to cause problems I'm afraid I just checked and
>>> based on randomly checking a few DSDTs of the tablets this driver
>>> is used on, it seems the DSDT always specifies a debounce timeout
>>> of 0 like your example above. And on many many devices using
>>> the soc_button_array driver debouncing is actually necessary.
>>
>> That's unfortunate to hear.
>>
>>>
>>> May I ask what problem you are seeing with the 50ms debounce timeout /
>>> what problem you are exactly trying to fix here ?
>>
>> The power button doesn't work to wake from suspend.  I bisected it down to your commit and then later traced that debounce from the ASL never gets set (pinctrl-amd's amd_gpio_set_debounce() is never called).
> 
> Ok, so specifically the gpiod_set_debounce() call with 50 ms
> done by gpio_keys.c is the problem I guess?

Yep.

> 
> So amd_gpio_set_debounce() does accept the 50 ms debounce
> passed to it by gpio_keys.c as a valid value and then setting
> that breaks the wake from suspend?

That's right.

Here is what /sys/kernel/debug/gpio has for the bad case (no patches):

  gpio     int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient| 
  debounce|reg
#0        😛|     b|   edge|    |   |     |⏰|    |  ↑ |input  ↑|b (🕑 
046875us)|0x8151ce3

And then for the good case (these two patches):

  gpio     int|active|trigger|S0i3| S3|S4/S5| Z|wake|pull|  orient| 
  debounce|reg
#0        😛|     b|   edge|    |   |     |⏰|    |  ↑ |input  ↑| 
       |0x8151c00


> 
>> Also comparing the GPIO register in Windows (where things work) Windows never programs a debounce.
> 
> So maybe the windows ACPI0011 driver always uses a software-
> debounce for the buttons? Windows not debouncing the mechanical
> switches at all seems unlikely.
> 
> I think the best way to fix this might be to add a no-hw-debounce
> flag to the data passed from soc_button_array.c to gpio_keys.c
> and have gpio_keys.c not call gpiod_set_debounce()  when the
> no-hw-debounce flag is set.
> 
> I've checked and both on Bay Trail and Cherry Trail devices
> where soc_button_array is used a lot hw-debouncing is already
> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
> value and pinctrl-cherryview.c does not support hw debounce
> at all.

That sounds a like a generally good direction to me.

I think I would still like to see the ASL values translated into the 
hardware even if the ASL has a "0" value.
So I would keep patch 1 but adjust for the warning you guys both called out.

As you have this hardware would you be able to work out that quirk?

Or if you want me to do it, I'll need something to go on how to how to 
effectively detect BYT and CYT hardware.

> 
>> So that's where both patches in this series came from.
>>
>>>
>>> drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
>>> it self with the 50 ms provided by soc_button_array and if that does
>>> not work it will fall back to software debouncing. So I don't see how
>>> the 50 ms debounce can cause problems, other then maybe making
>>> really really (impossible?) fast double-clicks register as a single
>>> click .
>>>
>>> These buttons (e.g. volume up/down) are almost always simply mechanical
>>> switches and these definitely will need debouncing, the 0 value from
>>> the DSDT is plainly just wrong. There is no such thing as a not bouncing
>>> mechanical switch.
>>
>> On one of these tablets can you check the GPIO in Windows to see if it's using any debounce?
> 
> I'm afraid I don't have Windows installed on any of these.
> 
> But based on your testing + the DSDT specifying no debounce
> for the GPIO I guess Windows just follows the DSDt when it
> comes to setting up the hw debounce-settings and then uses
> sw-debouncing on top to actually avoid very quick
> press-release-press event cycles caused by the bouncing.
> 

Yeah that sounds like a plausible hypothesis.



