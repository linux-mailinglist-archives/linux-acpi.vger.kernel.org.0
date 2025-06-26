Return-Path: <linux-acpi+bounces-14707-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874E7AEA4BE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 19:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5287A1610
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 17:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661E42ECD3B;
	Thu, 26 Jun 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryfEdexV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F764A33;
	Thu, 26 Jun 2025 17:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960384; cv=none; b=c7N18iKkLNG1Ekidj16gnH7OjYXxlbjdxk+SeeoBNP9+oWI/UUncHoEwvrXt44eDzJCJpyQmjAwcV35L9TPsRsGzQCqGuSW47Tdj3eS+QA7ODHCVmpYWi3OJFrvVy4gGjkulmjC1papY525qSmk/Pkri0rjMB727Ou/F3gCvv+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960384; c=relaxed/simple;
	bh=E0rS6SSRQcFeqZsjLLphUkxpuY6vBPqEjlJeAgWEWaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHzINtXV/qT2GLNGAtUc55ilSFy6reEULBFTJIsC8LC4zsu7gppmEK5O7IBAmvjA7RtW9fHteGB/lH1J/425qQl5TOMC/AinlFV0/fYjo2MnUVzbuFGriAW8xGqYhGH1Vzg8nViEwlcq80rZFlM9f5t6k1/ZQ295lmomYv3Z6l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ryfEdexV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08BAC4CEEB;
	Thu, 26 Jun 2025 17:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750960383;
	bh=E0rS6SSRQcFeqZsjLLphUkxpuY6vBPqEjlJeAgWEWaM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ryfEdexVPwVNBYdRyOeE0OWrFa3oIvkoivmQbDkUYyEXCP1oBNgJXe9HHG2ABGVXs
	 jf/FAb6escBquCpi+11hwATqd/Y5bDtoMJuMoJb7H8gTkTWEkfPVYsybOXVFhlDFyx
	 mQC2Rczo6A61Wvx0uNpN6N7AfKSKUH4DmuUpyoRIvJL+JVBEcJXqUtBcso+mHQAzkj
	 KaPQ0co3SPhXdT9u2AqHmU2y9So3EE+dsalo05NjCnZT9eRYIZDku+0PbLdtP9PTnK
	 yirO3g53W2FXw9IWws0MSR1Cze0d3H3x2HZ96Hh4G1VdmeE81iyukntsLPLi1p7Y8W
	 TxK+4B6M/eC2w==
Message-ID: <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
Date: Thu, 26 Jun 2025 12:53:02 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <rn2kp5tog2agvswva2ipqq2ytiqdcgccnocudsg6ckwfh4roei@provk2g6dita>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
> Hi Mario,
> 
> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
>>
>>
>> On 6/26/25 3:35 AM, Hans de Goede wrote:
>>> Hi Mario,
>>>
>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Sending an input event to wake a system does wake it, but userspace picks
>>>> up the keypress and processes it.  This isn't the intended behavior as it
>>>> causes a suspended system to wake up and then potentially turn off if
>>>> userspace is configured to turn off on power button presses.
>>>>
>>>> Instead send a PM wakeup event for the PM core to handle waking the system.
>>>>
>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>    drivers/input/keyboard/gpio_keys.c | 7 +------
>>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>> index 773aa5294d269..4c6876b099c43 100644
>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>>>>    		pm_stay_awake(bdata->input->dev.parent);
>>>>    		if (bdata->suspended  &&
>>>>    		    (button->type == 0 || button->type == EV_KEY)) {
>>>> -			/*
>>>> -			 * Simulate wakeup key press in case the key has
>>>> -			 * already released by the time we got interrupt
>>>> -			 * handler to run.
>>>> -			 */
>>>> -			input_report_key(bdata->input, button->code, 1);
>>>> +			pm_wakeup_event(bdata->input->dev.parent, 0);
> 
> There is already pm_stay_awake() above.

But that doesn't help with the fact that userspace gets KEY_POWER from 
this and reacts to it.

> 
>>>>    		}
>>>>    	}
>>>
>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
>>> windows 8 / win10 tablets, so  this has been discussed before and e.g.
>>> Android userspace actually needs the button-press (evdev) event to not
>>> immediately go back to sleep, so a similar patch has been nacked in
>>> the past.
>>>
>>> At least for GNOME this has been fixed in userspace by ignoring
>>> power-button events the first few seconds after a resume from suspend.
>>>
>>
>> The default behavior for logind is:
>>
>> HandlePowerKey=poweroff
>>
>> Can you share more about what version of GNOME has a workaround?
>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
>>
>> Nonetheless if this is dependent on an Android userspace problem could we
>> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
> 
> No it is not only Android, other userspace may want to distinguish
> between normal and "dark" resume based on keyboard or other user
> activity.
> 
> Thanks.
> 
In this specific case does the key passed up to satisfy this userspace 
requirement and keep it awake need to specifically be a fabricated 
KEY_POWER?

Or could we find a key that doesn't require some userspace to ignore 
KEY_POWER?

Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?


