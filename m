Return-Path: <linux-acpi+bounces-14771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CDAEB989
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481011C47CF8
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6AD2E1C54;
	Fri, 27 Jun 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOAp3271"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5B2E1C5A;
	Fri, 27 Jun 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033682; cv=none; b=NTUkyguTP6mXvz94U8e+qA/o5rj95gG++H2IE8CV8JDUU8fh5P86TUz2Lnm3r1y7pOJKS2nUIFqgOhCylu+Xa93ABqWbMpVE2+8/KSfwistkG2OqRdnNkoLqbJfjT/BdCy+EeA0+4GKmU0ZB7NJXDj9rX0ir5OKbkkn4QnuKb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033682; c=relaxed/simple;
	bh=2Q8UEjUaMPywc5hyQXQigtFyP4/maHQ1+o4AIC7RNl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZZZAqG6T8G7MkYv/kZvkLAWymUe1l9RQBxSKGhw9cAvNx3ENrquyvthMKCI5j/TP6WlTBjkV78XDd5AEzeWcM9NNwrweeTuPdSC0fha7PumW7qMWPSB50HbB7eLTaD+/RuxVIa5RDjbB0GTkIc9pZ9nrSzBUPXs9nlCbp05JT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOAp3271; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7A1C4CEE3;
	Fri, 27 Jun 2025 14:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751033682;
	bh=2Q8UEjUaMPywc5hyQXQigtFyP4/maHQ1+o4AIC7RNl8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vOAp3271zcYOmsZhHpe8KweaT83og6A2Rh2VqgZ94zvRnsF/tTggeUcjAZexVZwIv
	 YZIlCwG5PuGD9Vyuo+zeqcjvbZlgSZjXzbzym3aGEaPGW311XrzhCijRH/Pm5EgfIc
	 LFGzEVBzUajLcxYTpTlqK7kz1mmKENJoVwnGKsiuwUJvCS56lJQbQZew1eryHWtD5Y
	 AoVltl5qZlQudROfmHhhNNUanYyjtmbgoBWrTzk445fV7vF/TzpPcfDrq6flMlPZQr
	 fCtid1j0FUgTdFolZdU7SXos8+8icmWX55HOSvYHGHTguXqpp4ctJnMuQ0YepfD5eh
	 bWq16gJZsk+Pg==
Message-ID: <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
Date: Fri, 27 Jun 2025 16:14:38 +0200
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
References: <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
 <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
>> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
>>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
>>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
>>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
>>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>>
>>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
>>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
>>>>>>>>
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
>>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
>>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>>>>>> [...]
>>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
>>>>>>>>>>>> button does.
>>>>>>>>>>>>
>>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>>>>>>>>>>>> patch was modeling).
>>>>>>>>>>>>
>>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>>>>>>>>>>>> [1]
>>>>>>>>>>>
>>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
>>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
>>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
>>>>>>>>>>> multiple other platforms.
>>>>>>>>>>
>>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
>>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
>>>>>>>>>
>>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
>>>>>>>>> it does not seem to be captured in the email discussions or in the patch
>>>>>>>>> description.
>>>>>>>>
>>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
>>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
>>>>>>>> some userspace desktop environments are still going to have a problem
>>>>>>>> with this.
>>>>>>>
>>>>>>> It was done for this reason IIRC, but it should have been documented
>>>>>>> more thoroughly.
>>>>>>
>>>>>> I assert that it should not have been done and instead dealt with in
>>>>>> userspace. There are numerous drivers in the kernel emitting
>>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
>>>>>> what keys to process and when.
>>>>>
>>>>> Please see my last message in this thread (just sent) and see the
>>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
>>>>> events").
>>>>>
>>>>> This appears to be about cases when no event would be signaled to user
>>>>> space at all (power button wakeup from ACPI S3).
>>>>
>>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
>>>> button, right? So we can not send the "right" event code and use
>>>> "neutral" KEY_WAKEUP for both. Is this right?
>>>>
>>>> Thanks.
>>>>
>>>
>>> I did some more experiments with this affected system that started this
>>> thread (which uses s2idle).
>>>
>>> I only applied patch 3 in this series to help the debounce behavior and
>>> figure out impacts from patch 4 with existing Linux userspace.
>>>
>>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
>>> the GNOME workaround mitigates this problem and no visible impact.
>>>
>>> If I suspend by hand using the kernel interface and then press power button
>>> to wake:
>>>
>>> # echo mem | sudo tee /sys/power/state:
>>>
>>> * When GNOME is running:
>>> I get the shutdown popup and it eventually shuts down.
>>>
>>> * When GNOME isn't running (just on a VT):
>>> System shuts down.
>>
>> For the latter you may want to raise an issue with systemd, and for the
>> former I guess it is being too clever and does not activate the
>> workaround if suspend was not initiated by it? I think Gnome is being
>> too careful.
>>
>> Thanks.
>>
> 
> Sure I could file bugs with both the projects.
> 
> But before I do if all userspace needs to account for this with a series of workarounds at resume time, you still think that is that really the best way forward?
> 
> Hans, you have a lot of experience in the GNOME community.  Your thoughts?

I guess it would be good to fix this in the kernel, sending
KEY_WAKEUP from gpio_key when the event is KEY_POWER and
we are going through the special wakeup path in gpio_keys.

When this was discussed quite a while ago the ACPI button
driver simply did not send any event at all on wkaeup
by ACPI power-button. Know that it does send an event
it would be good to mimic this, at least when the gpio_key
devices where instantiated by soc_button_array.

So maybe add a new field to struct gpio_keys_button
called wakeup_code and when that is not 0 use that
instead of the plain "code" member on wakeups ?

That would keep the gpio_keys code generic while
allowing to mimic the ACPI button behavior.

And then set wakeup_code to KEY_WAKEUP for
the power-button in soc_button_array.

To me this sounds better then trying to fix all userspace
code which does something on KEY_POWER of which there
is quite a lot.

The special GNOME power-button handling was always
a workaround because last time a kernel fix was
nacked. But now with the KEY_WAKEUP done by the ACPI
button code it looks like we do have a good way
to fix this in the kernel, so that would be better
IMHO.

Dmitry, what do you think of adding a wakeup_code
field to struct gpio_keys_button and let the code
creating the gpio_keys_button decide if a different
code should be used on wakeup or not ?

Regards,

Hans




