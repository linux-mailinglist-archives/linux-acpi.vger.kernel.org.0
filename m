Return-Path: <linux-acpi+bounces-14627-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8855AE8D27
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 792B71BC06FB
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36342D8DAF;
	Wed, 25 Jun 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R+MMU9jl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BE02BD01A;
	Wed, 25 Jun 2025 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877853; cv=none; b=lH+r1V+2VXdpUDIg1tGvD3pDmrfhD7j1AvhnmBYikXlFMl1mwzrS8RwF3etxvb3ue23EpK4u6JBNtmSP5y5vQtasmBAWyLeWfU6Ls2j/pfNM8zlfN02uG+f1ooK4C/PXPD03I+M1nnj7IJV7CczKU463JIc+s+e99sXjXAEv/LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877853; c=relaxed/simple;
	bh=1OMir9kl3v36P5nZPYgGtcbpFcQ07CfapBjMeFWn9zE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvA/aI8YYJcJMuce9J4SNy5lcPEhwI6GJJszhP2SH6TLCiKuyvXEOqSLZxIRd6emc5tUs3iHVv6yzxWD1Lau9qTuKAFLITbLDPCws55K9VRDeD8lgsv6Hm8r9p5zgEAQFEujCrJwMM5yhT0Yse1txiE+q3QCCzvtDx0E7v58MVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+MMU9jl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA9C4CEEA;
	Wed, 25 Jun 2025 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877853;
	bh=1OMir9kl3v36P5nZPYgGtcbpFcQ07CfapBjMeFWn9zE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R+MMU9jlztQr+lsjWDsDFmIBNWjwa+XS36BysbYzLM73aW49TsTD9NCuDgB4aSlPY
	 7syOQ2OfYl/AiI5t8pNL5bQGkknrBrxHJyGFyeoUvW87rrYWcFHL5rui6kWPjUmzBW
	 3UABtEN/g09tMo8mkZXJvXxnmG5OWzyRnQx/bKSYvjd4KszaOr79SyAbk4leQVaYaC
	 1TiA+oDjF++Z1tnQz8fW3WoT/yboKdYxT/rgcoq4SgG6yO1fLCKCsTSDPSGYEkD2u/
	 JlXBRjKS00//bjSmRhp7T3zCChBstEAgxbWU2oJajp63loxCo7qm6kUZe5k2CnKkYB
	 2l5IU/EXZ7iaQ==
Message-ID: <4cfb5171-fc3d-4944-bcea-7dcf8e8e069a@kernel.org>
Date: Wed, 25 Jun 2025 20:57:29 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <625952d3-01e9-426e-9739-86fe5cdfeb35@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Jun-25 4:41 PM, Mario Limonciello wrote:
> On 6/25/25 9:31 AM, Hans de Goede wrote:

<snip>

>> So maybe the windows ACPI0011 driver always uses a software-
>> debounce for the buttons? Windows not debouncing the mechanical
>> switches at all seems unlikely.
>>
>> I think the best way to fix this might be to add a no-hw-debounce
>> flag to the data passed from soc_button_array.c to gpio_keys.c
>> and have gpio_keys.c not call gpiod_set_debounce()  when the
>> no-hw-debounce flag is set.
>>
>> I've checked and both on Bay Trail and Cherry Trail devices
>> where soc_button_array is used a lot hw-debouncing is already
>> unused. pinctrl-baytrail.c does not accept 50 ms as a valid
>> value and pinctrl-cherryview.c does not support hw debounce
>> at all.
> 
> That sounds a like a generally good direction to me.
> 
> I think I would still like to see the ASL values translated into the hardware even if the ASL has a "0" value.
> So I would keep patch 1 but adjust for the warning you guys both called out.
> 
> As you have this hardware would you be able to work out that quirk?

I think we've a bit of miscommunication going on here.

My proposal is to add a "no_hw_debounce" flag to 
struct gpio_keys_platform_data and make the soc_button_array
driver set that regardless of which platform it is running on.

And then in gpio_keys.c do something like this:

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818..2788d1e5782c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bool active_low = gpiod_is_active_low(bdata->gpiod);
 
 		if (button->debounce_interval) {
-			error = gpiod_set_debounce(bdata->gpiod,
-					button->debounce_interval * 1000);
+			if (ddata->pdata->no_hw_debounce)
+				error = -EINVAL;
+			else
+				error = gpiod_set_debounce(bdata->gpiod,
+						button->debounce_interval * 1000);
 			/* use timer if gpiolib doesn't provide debounce */
 			if (error < 0)
 				bdata->software_debounce =

So keep debouncing, which I believe will always be necessary when
dealing with mechanical buttons, but always use software debouncing
(which I suspect is what Windows does) to avoid issues like the issue
you are seeing.

My mention of the BYT/CHT behavior in my previous email was to point
out that those already do use software debouncing for the 50 ms
debounce-period. It was *not* my intention to suggest to solve this
with platform specific quirks/behavior.

<semi offtopic>
Hmm, I did found one interesting thing looking at further DSDTs
the Dell Venue 10 Pro 5056 DSDT actually specifies a non 0
debounce time in the ACPI0011 device's GPIO descriptors
it uses a value of 30 ms. This device being one of the few
actually specifying a debounce time in the ACPI is ironic
since it uses drivers/pinctrl/intel/pinctrl-cherryview.c
which does not support PIN_CONFIG_INPUT_DEBOUNCE...
</semi offtopic>

Regards,

Hans





> 
> Or if you want me to do it, I'll need something to go on how to how to effectively detect BYT and CYT hardware.
> 
>>
>>> So that's where both patches in this series came from.
>>>
>>>>
>>>> drivers/input/keyboard/gpio_keys.c first will call gpiod_set_debounce()
>>>> it self with the 50 ms provided by soc_button_array and if that does
>>>> not work it will fall back to software debouncing. So I don't see how
>>>> the 50 ms debounce can cause problems, other then maybe making
>>>> really really (impossible?) fast double-clicks register as a single
>>>> click .
>>>>
>>>> These buttons (e.g. volume up/down) are almost always simply mechanical
>>>> switches and these definitely will need debouncing, the 0 value from
>>>> the DSDT is plainly just wrong. There is no such thing as a not bouncing
>>>> mechanical switch.
>>>
>>> On one of these tablets can you check the GPIO in Windows to see if it's using any debounce?
>>
>> I'm afraid I don't have Windows installed on any of these.
>>
>> But based on your testing + the DSDT specifying no debounce
>> for the GPIO I guess Windows just follows the DSDt when it
>> comes to setting up the hw debounce-settings and then uses
>> sw-debouncing on top to actually avoid very quick
>> press-release-press event cycles caused by the bouncing.
>>
> 
> Yeah that sounds like a plausible hypothesis.
> 
> 


