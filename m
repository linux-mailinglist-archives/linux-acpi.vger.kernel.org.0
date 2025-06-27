Return-Path: <linux-acpi+bounces-14784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2454AEBECF
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 20:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF465188D078
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C632EB5D8;
	Fri, 27 Jun 2025 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLnIXYsO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3202E9ED4;
	Fri, 27 Jun 2025 18:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751047201; cv=none; b=I4AcaojeLd0H4/c7hdiKJ77rs6K1eroaICrBDz5D5teHQo+w8FMKFpe3ULJjxevQ+fVihXIZULrSFeTJ05hA1pDm2G2qHCagcJau/e3Kj1W8WvdFrQWT4gz1yupG8m/sqtp9sORCYjcibjcXiqgidGf34tc+s7foQ+40B8vbTxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751047201; c=relaxed/simple;
	bh=nHxRyHCbw9/Oav+1LaTV2CIaLPhiooN7OeG4MPg7kKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7cuAq2+GJasfrToCeOW0lBqiCDj2ujp2q3bBeQO9HH0cpmqFQfNc6SFeNAGfGXuExSFSMZJXL/NfvLCk2Qd47hkQSiL9fCeuATYJcHDCMlOGkYE+FxDjNueByWEGTIL52LSAketQNFDYZFbaqA71leZFtF6BQbtI5dK80dyjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLnIXYsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6EBC4CEE3;
	Fri, 27 Jun 2025 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751047200;
	bh=nHxRyHCbw9/Oav+1LaTV2CIaLPhiooN7OeG4MPg7kKI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dLnIXYsOLFU5f91sFEVR4n4Gv0Tr3l9RLdWH9Ur9ByywDTiq8c0iP96hyPoR9QY7j
	 KyHZHdXYuNobKJxtOYT3olEyxaoIVy/CVZMI0LmxsM+VW6NNLoaslkyG2b4//ClEgD
	 WwpuuSORZ6LcuSteMuSHgIQ2VMUYid8TSVUW9vmGriV5SMVQRa0K4NliNxQId3OSW4
	 CoAqzjc1iYkmYvebAL/TgZA5sIGhr6SCFXNiDNxZHl9EiNF505OLnyK1dvv83excuJ
	 T41DOzMKv0ud9T4IKKBaoARILaf/S1GUzhT8xAcegl2UsjPNwfrSd80OqTg8PYfRhy
	 0AW6p6+u9/8jQ==
Message-ID: <d967b0ed-da33-4cc1-9ec3-7dc1ab209d84@kernel.org>
Date: Fri, 27 Jun 2025 19:59:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
 <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
 <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
 <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
 <13025910-7639-400b-878a-cd0780c6534c@kernel.org>
 <4ajmcrl3bqeikki2etek5bafzszelgevr322tvuubx4pxxyju2@qqxz6lzcb6e5>
 <fdd635ce-5e8e-4123-8e8e-241a57b4d7fe@kernel.org>
 <aF7C0B038Qi-CUSk@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <aF7C0B038Qi-CUSk@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 27-Jun-25 6:12 PM, Andy Shevchenko wrote:
> On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
>> On 27-Jun-25 4:44 PM, Dmitry Torokhov wrote:
>>> On Fri, Jun 27, 2025 at 04:14:38PM +0200, Hans de Goede wrote:
>>>> On 27-Jun-25 4:06 PM, Mario Limonciello wrote:
>>>>> On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
> 
> ...
> 
>>>>> Hans, you have a lot of experience in the GNOME community.  Your thoughts?
>>>>
>>>> I guess it would be good to fix this in the kernel, sending
>>>> KEY_WAKEUP from gpio_key when the event is KEY_POWER and
>>>> we are going through the special wakeup path in gpio_keys.
>>>>
>>>> When this was discussed quite a while ago the ACPI button
>>>> driver simply did not send any event at all on wkaeup
>>>> by ACPI power-button. Know that it does send an event
>>>> it would be good to mimic this, at least when the gpio_key
>>>> devices where instantiated by soc_button_array.
>>>>
>>>> So maybe add a new field to struct gpio_keys_button
>>>> called wakeup_code and when that is not 0 use that
>>>> instead of the plain "code" member on wakeups ?
>>>>
>>>> That would keep the gpio_keys code generic while
>>>> allowing to mimic the ACPI button behavior.
>>>>
>>>> And then set wakeup_code to KEY_WAKEUP for
>>>> the power-button in soc_button_array.
>>>>
>>>> To me this sounds better then trying to fix all userspace
>>>> code which does something on KEY_POWER of which there
>>>> is quite a lot.
>>>>
>>>> The special GNOME power-button handling was always
>>>> a workaround because last time a kernel fix was
>>>> nacked. But now with the KEY_WAKEUP done by the ACPI
>>>> button code it looks like we do have a good way
>>>> to fix this in the kernel, so that would be better
>>>> IMHO.
>>>>
>>>> Dmitry, what do you think of adding a wakeup_code
>>>> field to struct gpio_keys_button and let the code
>>>> creating the gpio_keys_button decide if a different
>>>> code should be used on wakeup or not ?
>>>
>>> And what is the plan on dealing with all other drivers that emit
>>> KEY_POWER?
>>
>> There actually aren't that many that I'm aware of.
>>
>> Note that this gpio_keys KEY_POWER evdev event generation
>> on resume issue goes way back until the last time we had
>> this conversation and it still has not really been fixed.
>>
>> And I've not seen any bug-reports about the same problem
>> with any other drivers.
>>
>>> What about acpi button behavior when using S0ix?
>>
>> AFAIK it is the same as with S3, at least it is not
>> causing any issues. I've never seen the ACPI button code
>> cause re-suspend immediately on wakeup by what for all
>> intends and purposes is a spurious KEY_POWER event.
>>
>> Last time we discussed this I wasn't really happy with
>> the outcome of the discussion but I just went for it
>> because of Android's reliance on the event and we
>> lacked a better plan.
>>
>> Now that we've a fix for this in the form of KEY_WAKEUP
>> it is time to properly fix this instead of doing userspace
>> kludges.
>>
>>> What about
>>> holding power button for too long so that normal reporting "catches" the
>>> pressed state?
>>
>> The key-down event is send as KEY_WAKEUP instead,
>> so userspace sees KEY_WAKEUP pressed not KEY_POWER.
>>
>>> Kernel reports hardware events, interpreting them and applying certain
>>> policies is task for userspace.
>>
>> And atm it is actually doing a shitty job of reporting
>> hwevents because there is no way for userspace to be able
>> to differentiate between:
>>
>> 1. User pressed power-button to wakeup system
>> 2. User pressed power-button after resume to do
>>    power-button-action (e.g. suspend system)
>>
>> Even though *the kernel* does *know* the difference.
>>
>> So the suggested change actually makes the kernel
>> do its job of reporting hw-events better by making
>> the reporting more accurate.
>>
>> ATM if I resume say a tablet with GNOME and then
>> change my mind and press the power button within
>> 3 seconds of resume to suspend it again the second
>> power-button press will outright be ignored
>>
>> The current userspace workaround is racy like this,
>> again the whole workaround in GNOME is just an ugly
>> kludge which I did back then because we couldn't
>> agree on a better way to deal with this in the kernel /
>> because just suppressing sending KEY_POWER would break
>> Android.
>>
>> The suggested use of KEY_WAKEUP is lightyears better
>> then doing ignore KEY_POWER events for xx seconds
>> after resume which is simply always going to be racy
>> and always was just an ugly hack / never was
>> a great solution.
> 
> My take away from this discussion that in a sleep state the power button
> (or actually any wakeup source) should tell userspace "hey, we want to wake
> up". It doesn't tell "hey, we want to wake to power off".
> This sounds good to me as a user. Yes, if laptop is sleeping we need to wake
> it up to continue, the power off is just a next step of this flow.

Exactly.

These are really 2 different events and the problem
is that atm the kernel reports this as one and
the same event type. It really is as simple as this.

Note that I'm not proposing on making this change
something which all gpio_keys drivers will get
automatically.

My idea of adding a wakeup_code field to
struct gpio_keys_button allows individual gpio_keys
users to opt-in to the behavior of
sending KEY_SOMETHINGELSE on wakeup-by-gpio-button-press.

Since soc_button_array is only used on x86/ACPI platforms
and since by far the most x86/ACPI platforms use
the ACPI button code for the power-button, which already
behaves this way I do not expect any userspace problems
from doing such a change in soc_button_array because
if that were a problem then we would already have bug
reports because of the ACPI button code's behavior.

> The  expected hot topic here is the longer presses of power button, but I think
> if we have a timer and tell after say 3 second that the K_WUP was up and K_PW
> is down is not a solution, it will be always flaky.

If users do a long power-button press on x86 they are
*always* trying to do a forced power-off and after 4s
(or longer in some special cases) the hw itself will
do such a forced poweroff. So I do not believe that
we need to worry about long presses since those
have a very specific meaning on x86/ACPI platforms.

Also if there is a long press userspace will simply
see KEY_WAKEUP never getting released, which is
actually an accurate representation of things,
the user woke up the system through the power-button
and never released ir.

Regards,

Hans




