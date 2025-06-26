Return-Path: <linux-acpi+bounces-14734-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C140FAEA5E9
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 388A21C441B7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2142EF2AC;
	Thu, 26 Jun 2025 18:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD580T0I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D333A2EF298;
	Thu, 26 Jun 2025 18:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964254; cv=none; b=luKudm7fjCaIPeiRvtF7i1th1Ha2kxPq5rkEL2G3YCxlGsZLWnla06OJYp8EkFxzzb33LNXsBLYCo3p0wQisE/cjtS61FcY/DEnuibDuiQwzLNnKe9b2e6wLs6GN6XihxUwGidngzGsotNJTZL/n1i1rx+DrWBfOanYw1DLrZ4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964254; c=relaxed/simple;
	bh=Mz+UWV5NsS/PNATtjzCRHBoPaeJNZ+PldtKmc1FftJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkMMkjT0zqgvSQfB5H/amYV9boaJ4xXY/KgXeuThgMeiPUqf8S9tH1NEd6D/lrOXJ0bw+HJeW82L+GO8kan10u6CG9SmdDUuDGLOlCcVYyK5+TtwDpctcUv/4ShVaurxIevi/UPls6fZJkBm75314dwa9PjN8sPxA8ngzWuTAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD580T0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148C6C4CEEB;
	Thu, 26 Jun 2025 18:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964254;
	bh=Mz+UWV5NsS/PNATtjzCRHBoPaeJNZ+PldtKmc1FftJo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kD580T0IA7MnoW7tYAG0L25GAP52rJSco/Yxosk/GqSEgCaB4RrFMFyxFlGvHVUYO
	 SMY0FdabMESGn/JMwwrLUptVprQPg38MLFqbal3zg2JgxOwC4sgJhxPh4Afz5E1oPx
	 lMz/47ZuDdq+DEJSD25gtE8OaLLNPEuibro0EfzS4C5y9E3UTwN0rViNpG8wqO89RY
	 SvFYrlBmt/i+fbdWNxNigDbIRTRKEbrua7d+cEKNv5l9Y69oOj5x9GUpwmdqR1gS5a
	 LRkSra0I2fEkJiZfxaGScnFDkPrzW0o2YjbKsDjVGshDr4Szgsv3C8UHUuD0gcjzqN
	 EYh9JgihQJUZA==
Message-ID: <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
Date: Thu, 26 Jun 2025 20:57:30 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>,
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
 <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 26-Jun-25 20:48, Dmitry Torokhov wrote:
> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>> On 6/26/2025 1:07 PM, Dmitry Torokhov wrote:
>>> On Thu, Jun 26, 2025 at 12:53:02PM -0500, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 6/26/25 12:44 PM, Dmitry Torokhov wrote:
>>>>> Hi Mario,
>>>>>
>>>>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
>>>>>>> Hi Mario,
>>>>>>>
>>>>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
>>>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>>
>>>>>>>> Sending an input event to wake a system does wake it, but userspace picks
>>>>>>>> up the keypress and processes it.  This isn't the intended behavior as it
>>>>>>>> causes a suspended system to wake up and then potentially turn off if
>>>>>>>> userspace is configured to turn off on power button presses.
>>>>>>>>
>>>>>>>> Instead send a PM wakeup event for the PM core to handle waking the system.
>>>>>>>>
>>>>>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
>>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>>> ---
>>>>>>>>     drivers/input/keyboard/gpio_keys.c | 7 +------
>>>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>>>>>> index 773aa5294d269..4c6876b099c43 100644
>>>>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>>>>>>>>     		pm_stay_awake(bdata->input->dev.parent);
>>>>>>>>     		if (bdata->suspended  &&
>>>>>>>>     		    (button->type == 0 || button->type == EV_KEY)) {
>>>>>>>> -			/*
>>>>>>>> -			 * Simulate wakeup key press in case the key has
>>>>>>>> -			 * already released by the time we got interrupt
>>>>>>>> -			 * handler to run.
>>>>>>>> -			 */
>>>>>>>> -			input_report_key(bdata->input, button->code, 1);
>>>>>>>> +			pm_wakeup_event(bdata->input->dev.parent, 0);
>>>>>
>>>>> There is already pm_stay_awake() above.
>>>>
>>>> But that doesn't help with the fact that userspace gets KEY_POWER from this
>>>> and reacts to it.
>>>>
>>>>>
>>>>>>>>     		}
>>>>>>>>     	}
>>>>>>>
>>>>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
>>>>>>> windows 8 / win10 tablets, so  this has been discussed before and e.g.
>>>>>>> Android userspace actually needs the button-press (evdev) event to not
>>>>>>> immediately go back to sleep, so a similar patch has been nacked in
>>>>>>> the past.
>>>>>>>
>>>>>>> At least for GNOME this has been fixed in userspace by ignoring
>>>>>>> power-button events the first few seconds after a resume from suspend.
>>>>>>>
>>>>>>
>>>>>> The default behavior for logind is:
>>>>>>
>>>>>> HandlePowerKey=poweroff
>>>>>>
>>>>>> Can you share more about what version of GNOME has a workaround?
>>>>>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
>>>>>>
>>>>>> Nonetheless if this is dependent on an Android userspace problem could we
>>>>>> perhaps conditionalize it on CONFIG_ANDROID_BINDER_DEVICES?
>>>>>
>>>>> No it is not only Android, other userspace may want to distinguish
>>>>> between normal and "dark" resume based on keyboard or other user
>>>>> activity.
>>>>>
>>>>> Thanks.
>>>>>
>>>> In this specific case does the key passed up to satisfy this userspace
>>>> requirement and keep it awake need to specifically be a fabricated
>>>> KEY_POWER?
>>>>
>>>> Or could we find a key that doesn't require some userspace to ignore
>>>> KEY_POWER?
>>>>
>>>> Maybe something like KEY_RESERVED, KEY_FN, or KEY_POWER2?
>>>
>>> The code makes no distinction between KEY_POWER and KEY_A or KEY_B, etc.
>>> It simply passes event to userspace for processing.
>>
>> Right.  I don't expect a problem with most keys, but my proposal is to
>> special case KEY_POWER while suspended.  If a key press event must be sent
>> to keep Android and other userspace happy I suggest sending something
>> different just for that situation.
> 
> I do not know if userspace specifically looks for KEY_POWER or if it
> looks for user input in general, and I'd rather be on safe side and not
> mangle user input.
> 
> As Hans mentioned, at least some userspace already prepared to deal with
> this issue. And again, this only works if by the time ISR/debounce
> runs the key is already released. What if it is still pressed? You still
> going to observe KEY_POWER and need to suppress turning off the screen.
> 
>>
>> Like this:
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c
>> b/drivers/input/keyboard/gpio_keys.c
>> index 773aa5294d269..66e788d381956 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -425,7 +425,10 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
>> *dev_id)
>>                          * already released by the time we got interrupt
>>                          * handler to run.
>>                          */
>> -                       input_report_key(bdata->input, button->code, 1);
>> +                       if (button->code == KEY_POWER)
>> +                               input_report_key(bdata->input, KEY_WAKEUP,
>> 1);
> 
> Just FYI: Here your KEY_WAKEUP is stuck forever.
> 
>> +                       else
>> +                               input_report_key(bdata->input, button->code,
>> 1);
>>                 }
>>         }
>>
>>
>>
>>>
>>> You need to fix your userspace. Even with your tweak it is possible for
>>> userspace to get a normal key event "too early" and turn off the screen
>>> again, so you still need to handle this situation.
>>>
>>> Thanks.
>>>
>>
>> I want to note this driver works quite differently than how ACPI power
>> button does.
>>
>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>> patch was modeling).
>>
>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>> [1]
> 
> If you check acpi_button_resume() you will see that the events are sent
> from there. Except that for some reason they chose to use KEY_WAKEUP and
> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
> multiple other platforms.

Interesting, but the ACPI button code presumably only does this on resume
for a normal press while the system is awake it does use KEY_POWER, right ?

Regards,

Hans


> 
> Thanks.
> 


