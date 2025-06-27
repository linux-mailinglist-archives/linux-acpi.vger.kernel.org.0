Return-Path: <linux-acpi+bounces-14778-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39612AEBC9C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 17:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DD2F175E3A
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0582E9EB9;
	Fri, 27 Jun 2025 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pipWipL0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1CB2E337C;
	Fri, 27 Jun 2025 15:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039770; cv=none; b=tbChnTZ93We17ZbJaAwgYJhQVLwaLAcp4Lmbod6RIijBIP0Z7qsj1ltsMBLxhil/ZjI8eWrUQu69gJ9qhGJ/WMqyYRRilM39f65g0o+lSJSAaUPV9ucjKqtjdUoTPwYSE4BdAzoWaKiuJwmCGqPrdvQRcv3kWqju6XQgiylwqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039770; c=relaxed/simple;
	bh=Kt6hxMbhF45+pYPS+uUmuLJPgeX6AoKkm7uSpf8DRqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1vfoKmNxAzMUTAO5cICQgq0hcKDcBBE6OEdczqqB/KbHabz2jJO2a3qnf1H6zpVjvoVcrYcQp4Num208o4GAuJpYa4oVA+9B+YwQIHkVHEC4ZM+vn3cukgaOeiNzyCwe+LCfFbsOAppUUoC8KUkDc/X641Qonbo5ovdiUMwHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pipWipL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73412C4CEE3;
	Fri, 27 Jun 2025 15:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039769;
	bh=Kt6hxMbhF45+pYPS+uUmuLJPgeX6AoKkm7uSpf8DRqo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pipWipL04tZelAzR+jqqfYj7pzCuL8Q0uvezlFXJstjwFlh34ihzYB0guOF/hU6IE
	 HHP8+Gooh8HlkXycYTz8y/SeqDdoMdOqT42D3TwKtYLE5krR56LpB39uN1TqsIYkvk
	 grFTvXy/7Qw4vCy3YHkiRw/2P2qkMRQyZLZlcJj2vwvJaZd7cb+dV5NnsVbqUITjf4
	 kWkdG9f9PYc8z8gmh5+wIX6w8x6041oEyb0P1wFcrF/iP6ygiAEYULmHqAmQc6qNTy
	 co4aRYJ+3RevvIkAzqmepJs/F4JqCBw55HcvKb402/DbzmwjqbdSEcDRtMi7Lj+8Kf
	 AaZJhCXzyj2NA==
Message-ID: <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
Date: Fri, 27 Jun 2025 17:56:05 +0200
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
Cc: Mario Limonciello <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mika Westerberg
 <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dmitry,

On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
> On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
>>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
>>>> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
>>>>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
>>>>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
>>>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
>>>>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
>>>>>>>>>>
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
>>>>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
>>>>>>>>>>>> Hi,
>>>>>>>>>>>>
>>>>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
>>>>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>>>>>>>> [...]
>>>>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
>>>>>>>>>>>>>> button does.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>>>>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>>>>>>>>>>>>>> patch was modeling).
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>
>>>>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
>>>>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
>>>>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
>>>>>>>>>>>>> multiple other platforms.
>>>>>>>>>>>>
>>>>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
>>>>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
>>>>>>>>>>>
>>>>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
>>>>>>>>>>> it does not seem to be captured in the email discussions or in the patch
>>>>>>>>>>> description.
>>>>>>>>>>
>>>>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
>>>>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
>>>>>>>>>> some userspace desktop environments are still going to have a problem
>>>>>>>>>> with this.
>>>>>>>>>
>>>>>>>>> It was done for this reason IIRC, but it should have been documented
>>>>>>>>> more thoroughly.
>>>>>>>>
>>>>>>>> I assert that it should not have been done and instead dealt with in
>>>>>>>> userspace. There are numerous drivers in the kernel emitting
>>>>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
>>>>>>>> what keys to process and when.
>>>>>>>
>>>>>>> Please see my last message in this thread (just sent) and see the
>>>>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
>>>>>>> events").
>>>>>>>
>>>>>>> This appears to be about cases when no event would be signaled to user
>>>>>>> space at all (power button wakeup from ACPI S3).
>>>>>>
>>>>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
>>>>>> button, right? So we can not send the "right" event code and use
>>>>>> "neutral" KEY_WAKEUP for both. Is this right?
>>>>>>
>>>>>> Thanks.
>>>>>>
>>>>>
>>>>> I did some more experiments with this affected system that started this
>>>>> thread (which uses s2idle).
>>>>>
>>>>> I only applied patch 3 in this series to help the debounce behavior and
>>>>> figure out impacts from patch 4 with existing Linux userspace.
>>>>>
>>>>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
>>>>> the GNOME workaround mitigates this problem and no visible impact.
>>>>>
>>>>> If I suspend by hand using the kernel interface and then press power button
>>>>> to wake:
>>>>>
>>>>> # echo mem | sudo tee /sys/power/state:
>>>>>
>>>>> * When GNOME is running:
>>>>> I get the shutdown popup and it eventually shuts down.
>>>>>
>>>>> * When GNOME isn't running (just on a VT):
>>>>> System shuts down.
>>>>
>>>> For the latter you may want to raise an issue with systemd, and for the
>>>> former I guess it is being too clever and does not activate the
>>>> workaround if suspend was not initiated by it? I think Gnome is being
>>>> too careful.
>>>>
>>>> Thanks.
>>>>
>>>
>>> Sure I could file bugs with both the projects.
>>>
>>> But before I do if all userspace needs to account for this with a series of workarounds at resume time, you still think that is that really the best way forward?
>>>
>>> Hans, you have a lot of experience in the GNOME community.  Your thoughts?
>>
>> I guess it would be good to fix this in the kernel, sending
>> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
>> we are going through the special wakeup path in gpio_keys.
>>
>> When this was discussed quite a while ago the ACPI button
>> driver simply did not send any event at all on wkaeup
>> by ACPI power-button. Know that it does send an event
>> it would be good to mimic this, at least when the gpio_key
>> devices where instantiated by soc_button_array.
>>
>> So maybe add a new field to struct gpio_keys_button
>> called wakeup_code and when that is not 0 use that
>> instead of the plain "code" member on wakeups ?
>>
>> That would keep the gpio_keys code generic while
>> allowing to mimic the ACPI button behavior.
>>
>> And then set wakeup_code to KEY_WAKEUP for
>> the power-button in soc_button_array.
>>
>> To me this sounds better then trying to fix all userspace
>> code which does something on KEY_POWER of which there
>> is quite a lot.
>>
>> The special GNOME power-button handling was always
>> a workaround because last time a kernel fix was
>> nacked. But now with the KEY_WAKEUP done by the ACPI
>> button code it looks like we do have a good way
>> to fix this in the kernel, so that would be better
>> IMHO.
>>
>> Dmitry, what do you think of adding a wakeup_code
>> field to struct gpio_keys_button and let the code
>> creating the gpio_keys_button decide if a different
>> code should be used on wakeup or not ?
> 
> And what is the plan on dealing with all other drivers that emit
> KEY_POWER?

There actually aren't that many that I'm aware of.

Note that this gpio_keys KEY_POWER evdev event generation
on resume issue goes way back until the last time we had
this conversation and it still has not really been fixed.

And I've not seen any bug-reports about the same problem
with any other drivers.

> What about acpi button behavior when using S0ix?

AFAIK it is the same as with S3, at least it is not
causing any issues. I've never seen the ACPI button code
cause re-suspend immediately on wakeup by what for all
intends and purposes is a spurious KEY_POWER event.

Last time we discussed this I wasn't really happy with
the outcome of the discussion but I just went for it
because of Android's reliance on the event and we
lacked a better plan.

Now that we've a fix for this in the form of KEY_WAKEUP
it is time to properly fix this instead of doing userspace
kludges.

> What about
> holding power button for too long so that normal reporting "catches" the
> pressed state?

The key-down event is send as KEY_WAKEUP instead,
so userspace sees KEY_WAKEUP pressed not KEY_POWER.

> Kernel reports hardware events, interpreting them and applying certain
> policies is task for userspace.

And atm it is actually doing a shitty job of reporting
hwevents because there is no way for userspace to be able
to differentiate between:

1. User pressed power-button to wakeup system
2. User pressed power-button after resume to do
   power-button-action (e.g. suspend system)

Even though *the kernel* does *know* the difference.

So the suggested change actually makes the kernel
do its job of reporting hw-events better by making
the reporting more accurate.

ATM if I resume say a tablet with GNOME and then
change my mind and press the power button within
3 seconds of resume to suspend it again the second
power-button press will outright be ignored

The current userspace workaround is racy like this,
again the whole workaround in GNOME is just an ugly
kludge which I did back then because we couldn't
agree on a better way to deal with this in the kernel /
because just suppressing sending KEY_POWER would break
Android.

The suggested use of KEY_WAKEUP is lightyears better
then doing ignore KEY_POWER events for xx seconds
after resume which is simply always going to be racy
and always was just an ugly hack / never was
a great solution.

Regards,

Hans





