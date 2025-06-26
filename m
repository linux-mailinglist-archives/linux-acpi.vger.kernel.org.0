Return-Path: <linux-acpi+bounces-14725-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8F2AEA590
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA10E564570
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6272EE97D;
	Thu, 26 Jun 2025 18:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rar9E8Qz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E42EE964;
	Thu, 26 Jun 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963382; cv=none; b=Jzl7vpdbwMePnGhNoQs2uGHmW3R49Voc47VmjB88j3KCP59/vsA1H8+K0QCLFBqXc5A7C+f60Tj6cAz2HezEl905aoCi/oTZZfT02+cR7lyMoX/7JGCmasjDZZJ2NTj893XQYGYr7fGn1D9romMu6HBRb3hs0faRq02x2jhz8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963382; c=relaxed/simple;
	bh=WzjI9HvWygTWh0bVXlyz8hSb05qjYaCbp2nNFhRIA18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9ZGX6DxNRndgbVnn7+cY+sza0DFnbFRcd5kpqedKkOwIZwcaRP5y3gkS33eevWq89brIlE+bz6k/ckjXr4ndQY+/D4+7ljjZTpRQuwBS6zUXBS9PQ0vEYxBPQFAIUGKM7wtVlbCMcBciLR9WgQq6Ciogtq18bLxAhCsnrqAsjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rar9E8Qz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FCCC4CEEF;
	Thu, 26 Jun 2025 18:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963381;
	bh=WzjI9HvWygTWh0bVXlyz8hSb05qjYaCbp2nNFhRIA18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rar9E8QzkNV79tTJnpfcuEG63Jkin+cEL3NAMkA6gVm+YycisdGmRceCmrHFs61gF
	 Vwfc/EH4rZOV0X8/mtzUfnKJHwil3VS90jduLGgx2FYtIRq8rbQwSd9b5SlWVOUZ+c
	 8Y7WrgdlgRwZYodqA1qN2tzEh7TOdphSHPO7havu8hHTFk3tA0wCwFR26WtapKmE/t
	 R4zP+75lX2hvlm8p0/eUHw4GaRsuyIROhRxKwXISaouAvTXRrn2aRTB/01MUy4B8kc
	 bYMGi0o3U1r6JokuSFz/BP1qiArv+UyJMx5EiwlNCb4mXczaANExvQIEP6Ew0ohhd/
	 YreofaPo/nEoA==
Message-ID: <0982b8f9-81cc-4081-bdc2-29cb99923f54@kernel.org>
Date: Thu, 26 Jun 2025 13:42:59 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello
 <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-5-superm1@kernel.org>
 <710f7c04-0099-4611-b2ea-4dd4219ad5e2@kernel.org>
 <23f30094-68cc-47fe-86e0-5289cb41e940@kernel.org>
 <67224531-ad15-4fb6-b230-03c2d64206ad@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <67224531-ad15-4fb6-b230-03c2d64206ad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2025 1:37 PM, Hans de Goede wrote:
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
> 
> Right note poweroff not suspend, GNOME inhibits logind's power-button
> handling and substitutes its own handling which is done by gsd-media-keys.
> 
>> Can you share more about what version of GNOME has a workaround?
>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
> 
> See:
> 
> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/main/plugins/media-keys/gsd-media-keys-manager.c?ref_type=heads#L94
> 
> and the code in that file using that define.
> 
> Regards,
> 
> Hans
> 

This is pretty ancient, it's part of GNOME 40 and later.  Ubuntu 24.04 
is GNOME 46.

I have a hypothesis why the issue is happening.  I wasn't suspending 
using logind; I was using rtcwake (in case power button didn't work I 
needed a means to wake the system).

So this power button disable/enable delay code didn't get activated.

