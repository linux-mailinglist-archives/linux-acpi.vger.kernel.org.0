Return-Path: <linux-acpi+bounces-14645-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB05AE8EC4
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4676D16FBA0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904121FECAD;
	Wed, 25 Jun 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnP/20HZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621941FC8;
	Wed, 25 Jun 2025 19:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879966; cv=none; b=fNsbzCvZR9A3vR4BxTNvMSKx2W7ysda0LfXFko36Qzc3MSIr49UNYFm5H2+LTr0xGxSxz20hvNQXo4N7Nn+ftFlPL+tV2mxrjXiraxDN8InzBs7SqyJ0jstMPtb5k8XxSsfJ/PnUTkMOalARr8e0lUqM5dYP6z4XaY/o4l6iy7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879966; c=relaxed/simple;
	bh=a4i1+PBHCN1xsBMmEZ0wjNOwvY3sVzRpMCk3lNsxY3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1GXEEwPYq7MuLKKHymToOjjR1D019VkV8BcH9GvTofd+TtUcO8mQNJVdSU6xECoADNTreNw16DM3VzUCRcRlZ3FmRmuKZ8TRDaq7jD3tmvPMK3/pbE2E4yjjfiu/uBiG4I5d1vnyoH3O4+N5jEHMtFJzpJnwubP2WNglEZb4kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnP/20HZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6415C4CEF1;
	Wed, 25 Jun 2025 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750879966;
	bh=a4i1+PBHCN1xsBMmEZ0wjNOwvY3sVzRpMCk3lNsxY3w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FnP/20HZTNjAZLDwHM4JpU8SRBdG+MplmF9vZhh/kUSAt8wz+vg5BaL91Mt6/QgtW
	 GA2xXi220MnFPMFIgaMY1g1YR0gll5OArXFGFVHuV7cR4iUKbFTcTN9ptoe+gnmeGz
	 NE8xBJUpSHeb7aAFjbhtv/J/WhQ7kQDO161p1kRzNTVaX1Cvn4h5cWdMwVBGam9K8m
	 GfhJKvDEH/sgTx5rtBe9m82ehTR/JNbpsXI99o2XaxJr3rRROqgLW7D5kRxRpd967/
	 T2acSPMKoI8ZqAi36QqWIijAwDfmDGemlgxIFlt/zGAomoemTCJ8qiKO248+G8hHyT
	 kio53MX/XdMPQ==
Message-ID: <ab90e09a-5c82-4d1c-a0dc-063ec48340eb@kernel.org>
Date: Wed, 25 Jun 2025 21:32:41 +0200
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
 <92ab85ff-6314-4db0-ae12-9803ddde5037@kernel.org>
 <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
 <4cfb5171-fc3d-4944-bcea-7dcf8e8e069a@kernel.org>
 <676b774e-5111-4eea-bc6e-968840193009@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <676b774e-5111-4eea-bc6e-968840193009@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mario,

On 25-Jun-25 9:10 PM, Mario Limonciello wrote:
> On 6/25/25 1:57 PM, Hans de Goede wrote:
>> On 25-Jun-25 4:41 PM, Mario Limonciello wrote:
>>> On 6/25/25 9:31 AM, Hans de Goede wrote:
>>
>> <snip>
>>
>>>> So maybe the windows ACPI0011 driver always uses a software-
>>>> debounce for the buttons? Windows not debouncing the mechanical
>>>> switches at all seems unlikely.
>>>>
>>>> I think the best way to fix this might be to add a no-hw-debounce
>>>> flag to the data passed from soc_button_array.c to gpio_keys.c
>>>> and have gpio_keys.c not call gpiod_set_debounce()  when the
>>>> no-hw-debounce flag is set.
>>>>
>>>> I've checked and both on Bay Trail and Cherry Trail devices
>>>> where soc_button_array is used a lot hw-debouncing is already
>>>> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
>>>> value and pinctrl-cherryview.c does not support hw debounce
>>>> at all.
>>>
>>> That sounds a like a generally good direction to me.
>>>
>>> I think I would still like to see the ASL values translated into the hardware even if the ASL has a "0" value.
>>> So I would keep patch 1 but adjust for the warning you guys both called out.
>>>
>>> As you have this hardware would you be able to work out that quirk?
>>
>> I think we've a bit of miscommunication going on here.
>>
>> My proposal is to add a "no_hw_debounce" flag to
>> struct gpio_keys_platform_data and make the soc_button_array
>> driver set that regardless of which platform it is running on.
>>
>> And then in gpio_keys.c do something like this:
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index f9db86da0818..2788d1e5782c 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>>           bool active_low = gpiod_is_active_low(bdata->gpiod);
>>             if (button->debounce_interval) {
>> -            error = gpiod_set_debounce(bdata->gpiod,
>> -                    button->debounce_interval * 1000);
>> +            if (ddata->pdata->no_hw_debounce)
>> +                error = -EINVAL;
>> +            else
>> +                error = gpiod_set_debounce(bdata->gpiod,
>> +                        button->debounce_interval * 1000);
>>               /* use timer if gpiolib doesn't provide debounce */
>>               if (error < 0)
>>                   bdata->software_debounce =
>>
>> So keep debouncing, which I believe will always be necessary when
>> dealing with mechanical buttons, but always use software debouncing
>> (which I suspect is what Windows does) to avoid issues like the issue
>> you are seeing.
> 
> So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?
> 
> In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.
> 
> Shouldn't you only turn on software debouncing when it's required?

Lets continue this discussion in the v2 thread.

Regards,

Hans




>>> Or if you want me to do it, I'll need something to go on how to how to effectively detect BYT and CYT hardware.
>>>
>>>>
>>>>> So that's where both patches in this series came from.
>>>>>
>>>>>>
>>>>>> drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
>>>>>> it self with the 50 ms provided by soc_button_array and if that does
>>>>>> not work it will fall back to software debouncing. So I don't see how
>>>>>> the 50 ms debounce can cause problems, other then maybe making
>>>>>> really really (impossible?) fast double-clicks register as a single
>>>>>> click .
>>>>>>
>>>>>> These buttons (e.g. volume up/down) are almost always simply mechanical
>>>>>> switches and these definitely will need debouncing, the 0 value from
>>>>>> the DSDT is plainly just wrong. There is no such thing as a not bouncing
>>>>>> mechanical switch.
>>>>>
>>>>> On one of these tablets can you check the GPIO in Windows to see if it's using any debounce?
>>>>
>>>> I'm afraid I don't have Windows installed on any of these.
>>>>
>>>> But based on your testing + the DSDT specifying no debounce
>>>> for the GPIO I guess Windows just follows the DSDt when it
>>>> comes to setting up the hw debounce-settings and then uses
>>>> sw-debouncing on top to actually avoid very quick
>>>> press-release-press event cycles caused by the bouncing.
>>>>
>>>
>>> Yeah that sounds like a plausible hypothesis.
>>>
>>>
>>
> 


