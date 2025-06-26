Return-Path: <linux-acpi+bounces-14727-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E9BAEA5AF
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254D23B59D8
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4C82EBBA1;
	Thu, 26 Jun 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpfXFUG4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6731CAA65;
	Thu, 26 Jun 2025 18:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963650; cv=none; b=BWgM/1dTvse986rcjGnabd869jxmVfAnME2Ge+ZKVA5BUbLqRfO6eYaB3v859wwvTn/EVJbaeEAUl13rka7+Jp2xPMKEJWo9mpR5W78annGNRuob9mjkLXb0J+tjZu4pRP7/ut2by7ANhDzAYSM2GCxEc12qArC7O1SwyG2Wm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963650; c=relaxed/simple;
	bh=BADaXYUrZL5+xrzmm/s/1wasA5JQ79E9/27l3wQ69EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEg2G8Vr7rTaq6K8KJFJ2upPoPdzTDxAWY15umuqU52RQphLn+QBjlhoY3yXoktQWCYJg1WkRMYgWCRUMnG0zRCt4SyOeuDne0guD/ylpqTLHL4q5A0UAaLnO3fCAg+o6Pjb3LffDEBqQs5NhvgvXsOhpQlazMi9thVNAw8lGQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpfXFUG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284E9C4CEEB;
	Thu, 26 Jun 2025 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963650;
	bh=BADaXYUrZL5+xrzmm/s/1wasA5JQ79E9/27l3wQ69EA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HpfXFUG4vZ6ajDROW2NrlGbAYAzqVepwStyvKdfvEoLDIgw3mXoIjT9br2vfUHLyh
	 dTN9mFEHulnxo2S3UOV9YbX4wANdsJ+vJgAnokegIdjQ8wvilurgIlgUNNBB+Z7U2l
	 fPuCHBSxY1jJyK79G1YPr+nfHkmCBg2yzW43d3hH/JRfh3TM8NKCBUAAN64fvcNUOz
	 9ORHkAa/0eHsTFvv2jviixwed2PCvshKZtligg7P9N0KcwaKnvoH1FVCyzGY+Eu/Kf
	 Mstfy7FRPaZB9Fk2ACd59z9Wi8DiFvgq6ZmkOISs+38KVzANFCCwaH8n7ZqqF+BF4C
	 aMnSV4qvgJ0kQ==
Message-ID: <9c2d7405-4c6f-49f4-ab40-0db821db6bea@kernel.org>
Date: Thu, 26 Jun 2025 13:47:28 -0500
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
 <0982b8f9-81cc-4081-bdc2-29cb99923f54@kernel.org>
 <3a1e2e0c-cbb9-4e3a-aa5a-9f88e8f05bc5@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <3a1e2e0c-cbb9-4e3a-aa5a-9f88e8f05bc5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/2025 1:45 PM, Hans de Goede wrote:
> Hi,
> 
> On 26-Jun-25 20:42, Mario Limonciello wrote:
>> On 6/26/2025 1:37 PM, Hans de Goede wrote:
>>> Hi Mario,
>>>
>>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> Sending an input event to wake a system does wake it, but userspace picks
>>>>>> up the keypress and processes it.  This isn't the intended behavior as it
>>>>>> causes a suspended system to wake up and then potentially turn off if
>>>>>> userspace is configured to turn off on power button presses.
>>>>>>
>>>>>> Instead send a PM wakeup event for the PM core to handle waking the system.
>>>>>>
>>>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>> ---
>>>>>>     drivers/input/keyboard/gpio_keys.c | 7 +------
>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>>>> index 773aa5294d269..4c6876b099c43 100644
>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>>>>>>             pm_stay_awake(bdata->input->dev.parent);
>>>>>>             if (bdata->suspended  &&
>>>>>>                 (button->type == 0 || button->type == EV_KEY)) {
>>>>>> -            /*
>>>>>> -             * Simulate wakeup key press in case the key has
>>>>>> -             * already released by the time we got interrupt
>>>>>> -             * handler to run.
>>>>>> -             */
>>>>>> -            input_report_key(bdata->input, button->code, 1);
>>>>>> +            pm_wakeup_event(bdata->input->dev.parent, 0);
>>>>>>             }
>>>>>>         }
>>>>>
>>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
>>>>> windows 8 / win10 tablets, so  this has been discussed before and e.g.
>>>>> Android userspace actually needs the button-press (evdev) event to not
>>>>> immediately go back to sleep, so a similar patch has been nacked in
>>>>> the past.
>>>>>
>>>>> At least for GNOME this has been fixed in userspace by ignoring
>>>>> power-button events the first few seconds after a resume from suspend.
>>>>>
>>>>
>>>> The default behavior for logind is:
>>>>
>>>> HandlePowerKey=poweroff
>>>
>>> Right note poweroff not suspend, GNOME inhibits logind's power-button
>>> handling and substitutes its own handling which is done by gsd-media-keys.
>>>
>>>> Can you share more about what version of GNOME has a workaround?
>>>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
>>>
>>> See:
>>>
>>> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/main/plugins/media-keys/gsd-media-keys-manager.c?ref_type=heads#L94
>>>
>>> and the code in that file using that define.
>>>
>>> Regards,
>>>
>>> Hans
>>>
>>
>> This is pretty ancient, it's part of GNOME 40 and later.  Ubuntu 24.04 is GNOME 46.
> 
> Right, this power-button evdev key event on resume causing an immediate
> suspend again is a pretty old problem. When I said "discussed before"
> I meant discussed quite a while ago :)
> 
> Regards,
> 
> Hans
> 

:)

I'm quite used to most platforms using ACPI power button which doesn't 
send a key press event during the resume sequence, so this is the first 
exposure for me to it.

