Return-Path: <linux-acpi+bounces-14688-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD77AE9C8E
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 13:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 257D917C88A
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6406220698;
	Thu, 26 Jun 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtSe9HZf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7545A17BA5;
	Thu, 26 Jun 2025 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750937590; cv=none; b=eI4dL4bPTsMeQi2RlUkqE++HX+zMWA7OZRAuJyFX6h0nKAEpOd7+uJVzxPV2Ky7xlSoyuamJkT/Tb5p+xdh+NbSM9pXdM6v0GT/kZUpOF65Wfywvur4GBiiXT72EuJSrKkxu1mS7LNqRrZsX5kX4IVWmZRx2LrZsPxETXZP12DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750937590; c=relaxed/simple;
	bh=xNNGbFh2wsJes74tor0RiVvoVzoUaZ9XjJ4mHjEG10o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAJFwsdXLxNrVspwnLD47sgpYTO9Qm8wlx3VYVWI/NOz2YaCT0MNCnFpCQ+KBWys4y933UzF5KZBv9OjPXTQ2GoOpoczYbwB6VVQSZvy4nVYr9wNIZ4n5pgX2E/0mx1mNDKsYO1DLf/RMl/Bd7Ng0hA3j0Cig/SFYtOAnvHzn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtSe9HZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14517C4CEEB;
	Thu, 26 Jun 2025 11:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750937590;
	bh=xNNGbFh2wsJes74tor0RiVvoVzoUaZ9XjJ4mHjEG10o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RtSe9HZfMvfkJBx7YBgx9Oq9DqpdzUgG6gfBEUK4kGGwBB4sitcig369ayeEGvPnh
	 7krEeAUt7B9cf9MsxMDeGZ0BrOdkjXACLLUkuGuXzoeoDVu0mNXsJWbuVghHvg4Wvc
	 j5A170qvNf2nt1mp5lQHDMp4abpNMh/H/XRGjxJy3q8O+yIReT2A9VBG5Yf39m4LeD
	 XMdlpHz3VfwmxRrp4OppnZXkfo6TIv5DAiwgz3qHRK06U7ElLlf9t+i4lvrQbUog/8
	 7NYp4VWnsj4ogZs7nynth1Vkd/sJEamcYmCmY5jZ3vux/6XGv9QMCB2PNb3svHvGcg
	 h5xkGOV4TJm5w==
Message-ID: <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
Date: Thu, 26 Jun 2025 06:33:08 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/26/25 3:35 AM, Hans de Goede wrote:
> Hi Mario,
> 
> On 25-Jun-25 23:58, Mario Limonciello wrote:
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Sending an input event to wake a system does wake it, but userspace picks
>> up the keypress and processes it.  This isn't the intended behavior as it
>> causes a suspended system to wake up and then potentially turn off if
>> userspace is configured to turn off on power button presses.
>>
>> Instead send a PM wakeup event for the PM core to handle waking the system.
>>
>> Cc: Hans de Goede <hansg@kernel.org>
>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/input/keyboard/gpio_keys.c | 7 +------
>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>> index 773aa5294d269..4c6876b099c43 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>>   		pm_stay_awake(bdata->input->dev.parent);
>>   		if (bdata->suspended  &&
>>   		    (button->type == 0 || button->type == EV_KEY)) {
>> -			/*
>> -			 * Simulate wakeup key press in case the key has
>> -			 * already released by the time we got interrupt
>> -			 * handler to run.
>> -			 */
>> -			input_report_key(bdata->input, button->code, 1);
>> +			pm_wakeup_event(bdata->input->dev.parent, 0);
>>   		}
>>   	}
>>   
> 
> Hmm, we have the same problem on many Bay Trail / Cherry Trail
> windows 8 / win10 tablets, so  this has been discussed before and e.g.
> Android userspace actually needs the button-press (evdev) event to not
> immediately go back to sleep, so a similar patch has been nacked in
> the past.
> 
> At least for GNOME this has been fixed in userspace by ignoring
> power-button events the first few seconds after a resume from suspend.
> 

The default behavior for logind is:

HandlePowerKey=poweroff

Can you share more about what version of GNOME has a workaround?
This was actually GNOME (on Ubuntu 24.04) that I found this issue.

Nonetheless if this is dependent on an Android userspace problem could 
we perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?

Most people not using Android would be compiling with that enabled in 
their kernel I'd expect.

