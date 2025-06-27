Return-Path: <linux-acpi+bounces-14807-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96686AEC0DC
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 22:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC58C56566A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8415521D3CA;
	Fri, 27 Jun 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF7yCjrV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54124C2FB;
	Fri, 27 Jun 2025 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055964; cv=none; b=jLlg7AGYP1PICjuM/PriqgsEV0seZ3InEgBHEtmbOhGt7rA3OS9Eh0ZgjnqtRTm4iGMUu5iJd7tHxYW8QJTtZSB4HnpsNsgZVH8bPl8p0Xw7NJuIqfM9Tt5vfNMEWlGf0vdzktw+LUEjdpv7APV6oDZOV8BjR+3xmp1/mvcCI+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055964; c=relaxed/simple;
	bh=YT2e/UrTPLRrkBQtY5j9rxnjaYxhH76IJd3VIMz0jqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Us8u+GxnL6h8W9+t4E3wMJJ6wKiEDBh7dys9df51Uil9tDvqhLx/uaXWtiTuJWX2t8lZBa9abzbwuLPK99PBJQhxfA1DCvl1z48mj0hu8ym5NTgkTGEsH5f4S0HVQBNX2Fsk99mYa7npLKHcSiVj/zIbaQTYXRU6DbcW1c+FR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF7yCjrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460EC4CEE3;
	Fri, 27 Jun 2025 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751055963;
	bh=YT2e/UrTPLRrkBQtY5j9rxnjaYxhH76IJd3VIMz0jqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mF7yCjrViL8c+1IpdhJAWAG1mZOOzaGeNUjsW11TEbRHSs0gCIA3Z1cwVYzdZPtRd
	 tDOjxlz5oXFQkxd4JgAiIiEm2Cnf43lpwqnfqk7fLt9mAUnOLtVEYZjMHXSx8pWSv2
	 EWYsgaYCvgfjUwBlRFd4oYjaQSJrW5mTZr34DIQAhBoYURUuQ+bdnyyfNOlE8npUBw
	 5q+Sz22BfglkJltepaymcdJVORS7ZMuD+MPOzMxdRJHRtzA6pyTWf8v+k1D5oNJs0e
	 2+4MwQSgnZ12WZAEr0yvpNXs7LD5vofNfbJ5sZN+Z2E7ZdQw/QxCG7brv6TnZ3SEyj
	 nmv+gl9SmiFYA==
Message-ID: <5c8ca17f-2f77-4492-ade7-a78dba45df7d@kernel.org>
Date: Fri, 27 Jun 2025 22:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Mario Limonciello <superm1@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
 <eaf7bva2skjz6oo2s2f4agooplthvuztyr6tssa7rux764qw35@kscd3rtejfvn>
 <9f5e0c21-bc25-44d0-a4d4-6fd6e58a9f2e@kernel.org>
 <ly3mww7nq7uuqvdx7p2uzcrphhboeuep3yuwbaxwfimesitjaa@hf72i4vu5quo>
 <584af55f-1b73-4c17-bf85-c2d3ecf6692e@kernel.org>
 <e0469bf9-f12a-48a7-bd58-3ae346354987@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <e0469bf9-f12a-48a7-bd58-3ae346354987@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27-Jun-25 9:44 PM, Mario Limonciello wrote:
> On 6/27/2025 2:38 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 27-Jun-25 9:18 PM, Dmitry Torokhov wrote:
>>> On Fri, Jun 27, 2025 at 01:56:53PM -0500, Mario Limonciello wrote:
>>>> On 6/27/2025 1:36 PM, Dmitry Torokhov wrote:
>>>>> On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
>>>
>>> [ ... trim ... ]
>>>
>>>>>
>>>>> 2. There is a patch from Mario (a8605b0ed187) suppressing sending
>>>>> KEY_POWER as part of "normal" wakeup handling, pretty much the same as
>>>>> what he and you are proposing to do in gpio-keys (and eventually in
>>>>> every driver keyboard or button driver in the kernel). This means we no
>>>>> longer can tell if wakeup is done by power button or sleep button (on
>>>>> systems with dual-button models, see ACPI 4.8.3.1).
>>>>
>>>> Actually a8605b0ed187 was about a runtime regression not a suspend
>>>> regression.  I didn't change anything with sending KEY_POWER during wakeup
>>>> handling.
>>>
>>> Ah, right, ignorng events for "suspended" buttons was done in
>>> e71eeb2a6bcc ("ACPI / button: Do not propagate wakeup-from-suspend
>>> events"). Again trying to add heuristic to the kernel instead of
>>> enlightening userspace.
>>>
>>> I am curious why the system is sending "Notify Wake" events when not
>>> sleeping though?
>>>
>>> [ .. skip .. ]
>>>
>>>>
>>>> FTR I did test Hans suggestion and it does work effectively (code below).
>>>>
>>>> diff --git a/drivers/input/keyboard/gpio_keys.c
>>>> b/drivers/input/keyboard/gpio_keys.c
>>>> index f9db86da0818b..3bc8c95e9943b 100644
>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>> @@ -425,7 +425,8 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
>>>> *dev_id)
>>>>                           * already released by the time we got interrupt
>>>>                           * handler to run.
>>>>                           */
>>>> -                       input_report_key(bdata->input, button->code, 1);
>>>> +                       input_report_key(bdata->input, *bdata->code, 1);
>>>> +                       input_sync(bdata->input);
>>>
>>> I start wondering if we should keep the fake press given that we do not
>>> know for sure if wakeup truly happened because of this button press...
>>
>> AFAIK we cannot drop the fake press because then Android userspace
>> will immediately go back to sleep again assuming the wakeup was
>> e.g. just some data coming in from the modem which did not result
>> in a notification to show, so no need to turn on the display,
>> but instead immediately go back to sleep.
>>
>> IIRC last time we had this discussion (man years ago) the reason
>> to send KEY_POWER was to let Android know that it should actualy
>> turn on the display and show the unlock screen because the user
>> wants that to happen.
>>
>> I believe this is also what the KEY_WAKEUP thing in the ACPI button
>> code is for.
>>
>>> Can we track back to the wakeup source and determine this? It will not
>>> help your problem, but I still believe userspace is where policy should
>>> live.
>>
>> There is /sys/power/pm_wakeup_irq we could correlate that to the IRQ
>> number of the ISR and then AFAICT we will definitively know if
>> the power-button was the wakeup source ?
>>
> 
> So at least in my case when woken up by this power button press the IRQ isn't the one for the GPIO itself, but rather for the GPIO controller master interrupt.
> 
> # cat /sys/power/pm_wakeup_irq
> 7
> # grep . /sys/kernel/irq/7/*
> /sys/kernel/irq/7/actions:pinctrl_amd
> /sys/kernel/irq/7/chip_name:IR-IO-APIC
> /sys/kernel/irq/7/hwirq:7
> /sys/kernel/irq/7/name:fasteoi
> /sys/kernel/irq/7/per_cpu_count:0,0,0,0,0,5,0,0
> /sys/kernel/irq/7/type:level
> /sys/kernel/irq/7/wakeup:enabled
> 
> # grep . /sys/kernel/irq/102/*
> /sys/kernel/irq/102/actions:power
> /sys/kernel/irq/102/chip_name:amd_gpio
> /sys/kernel/irq/102/hwirq:0
> /sys/kernel/irq/102/per_cpu_count:0,1,0,2,1,0,0,1
> /sys/kernel/irq/102/type:edge
> /sys/kernel/irq/102/wakeup:disabled

Ah, right.

But thinking more about this I do not think believe
that wakeup racing is really a big issue here.

Wakeup racing only hits if the button ISR runs before
gpio_keys_resume() has run and cleared the bdata->suspended
flag. IOW the button was pressed before the system has
completely resumed in that case the users intend to me
very clearly was to wakeup the system.

So I still believe that sending key-wakeup for the simulated
keypress is the right thing to do in wakeup race cases even
if the system was actually woken up by e.g. network traffic.

As for Mario's patch from earlier in the thread that needs
some more work because it will release the wrong code if
the release ISR runs after gpio_keys_resume().

But working further on that only is useful if we can get
agreement from Dmitry on that approach.

Regards,

Hans



