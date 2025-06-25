Return-Path: <linux-acpi+bounces-14646-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD88DAE8EE3
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFEC47A96E9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9795E2DAFDF;
	Wed, 25 Jun 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pINkPIvI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D64A2D5C81;
	Wed, 25 Jun 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750880543; cv=none; b=UMg8hbylHNTzzov/kKXW85UwPsF6Cm/7L9xuw0oKJ46kM/2v/ws/VYUKa0LFtMSgYlnqO+afOndjnoRnvcEx+1UXUXo4OqdaWebCeNd45HBXluTqazZOGVxioADwIHCPLY+FsBMSznjzUzwGYBx9zAi8tMnscqQlX6cSlI2LHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750880543; c=relaxed/simple;
	bh=CjNKXvxO/4gk15CIk9SU0gSachKAURgD/j1MO4ru2uc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uVXjD5aNhLsZFRcnVXyHvepUpd2l7HSJy53m90hHfItQ7rmbzwMYOvVCONyp5HYhjXLWRQOxUIAdhBCaQVJWTYcW+NjY1MigoSAyrB7ylO0s2K4EtpcNioLGjdMUaNKg2dZoxppFiFD3yGUdmznWpor/fRtP1ziEptX7P9wYU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pINkPIvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB967C4CEEA;
	Wed, 25 Jun 2025 19:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750880543;
	bh=CjNKXvxO/4gk15CIk9SU0gSachKAURgD/j1MO4ru2uc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pINkPIvIsYZFEn6g5F4lCIfTIQbnezryez2xsbQgrOAbTjFtTNuLrgf6DYBczUoWb
	 0DLZ0I6mdKBMOTVvLilqgvgM+m5INwQzvktW1Kw1N+GRfVLSvCw10Du4xhXTGcNdng
	 EyHzGmRHx1e4K3lCpwKJ76vccLYyiTFD0INQpF4AoY4w1megiTREicpLYDtBqVNBxg
	 nf9GmZ9SAoMoSpmDhG9CAAJi8WHbJRBnpxeg2rPYhp8WiXIC59UGJSaXNmqF+vBOuP
	 Vp2rLFCGhwrYLmAsOYxB2jhOgTpPiqoUYh+1tLwVozs+UD9qXBZG6LKmumwmdccHTY
	 n3l10gmujvFlw==
Message-ID: <a9bed0b4-b050-468b-91cb-bc4c81352046@kernel.org>
Date: Wed, 25 Jun 2025 21:42:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
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
References: <20250625181342.3175969-1-superm1@kernel.org>
 <20250625181342.3175969-4-superm1@kernel.org>
 <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
 <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <57e9b1d5-faf1-4c7a-87fc-047e0dc102f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 25-Jun-25 9:23 PM, Mario Limonciello wrote:
> On 6/25/25 2:03 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
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
>>> Many cherryview and baytrail systems don't have accurate values in the
>>> ASL for debouncing and thus use software debouncing in gpio_keys. The
>>> value to use is programmed in soc_button_array.  Detect Cherry View
>>> and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
>>> the 50ms only for those systems.
>>>
>>> Cc: Hans de Goede <hansg@kernel.org>
>>> Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> I'm not a fan of this approach, I believe that we need to always debounce
>> when dealing with mechanical buttons otherwise we will get unreliable /
>> spurious input events.
>>
>> My suggestion to deal with the issue where setting up debouncing at
>> the GPIO controller level is causing issues is to always use software
>> debouncing (which I suspect is what Windows does).
>>
>> Let me copy and pasting my reply from the v1 thread with
>> a bit more detail on my proposal:
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
>> So keep debouncing, as that will always be necessary when dealing with
>> mechanical buttons, but always use software debouncing to avoid issues
>> like the issue you are seeing.
>>
>> My mention of the BYT/CHT behavior in my previous email was to point
>> out that those already always use software debouncing for the 50 ms
>> debounce-period. It was *not* my intention to suggest to solve this
>> with platform specific quirks/behavior.
>>
>> Regards,
>>
>> Hans
> 
> I mentioned on the v1 too, but let's shift conversation here.

Ack.

> So essentially all platforms using soc_button_array would always turn on software debouncing of 50ms?

Yes that is what my proposal entails.

> In that case what happens if the hardware debounce was ALSO set from the ASL?  You end up with double debouncing I would expect.

A hardware debounce of say 25 ms would still report the button down
immediately, it just won't report any state changes for 25 ms
after that, at least that is how I would expect this to work.

So the 50 ms ignore-button-releases for the sw debounce will start
at the same time as the hw ignore-button-release window and basically
the longest window will win. So having both active should not really
cause any problems.

Still only using one or the other as you propose below would
be better.

> Shouldn't you only turn on software debouncing when it's required?
> 
> I'm wondering if considering the first two patches we should have gpio-keys look up if hardware can support debounce, and then "only if it can't" we program the value from soc button array.
> 
> It can be done by having gpio_keys do a "get()" on debounce.  Iff the driver returns -ENOTSUPP /then/ program the software debounce.

Any special handling here should be done in soc_button_array since
this is specific to how with ACPI we have the GPIO resource
descriptors setting up the hw-debounce and then the need to do
software debounce when that was not setup.

As for checking for -ENOTSUPP I would make soc_button_array
do something like this.

ret = debounce_get()
if (ret <= 0)
	use-sw-debounce;

If hw-debounce is supported but not setup, either because
the exact debounce value being requested is not supported
or because the DSDT specified 0, then sw-debouncing should
also be used.

Note this will still require the use of a new no_hw_debounce
flag so that we don't end up enabling hw-debounce in
the hw-debounce is supported but not setup case.

Regards,

Hans





