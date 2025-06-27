Return-Path: <linux-acpi+bounces-14770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A0AEB972
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 16:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A0A564977
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529EF2DE1E7;
	Fri, 27 Jun 2025 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeW7pb3H"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE22DD5E7;
	Fri, 27 Jun 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033173; cv=none; b=L715xn9WlqQSrMTrYJ7ngTFDtXFm+PLwoVSFh1AOjFbNa+DE8hLCt5Cii9iX5Jrs1du4Sts2/CGINekzhNzc8KKqG76q8FSqwWBaqb+Rsf66yzZzAUSomPNeUFyXYE71t6dtHJLJSlaAyPalhwS+kUy/RUiXvRIEbqhoYoaiMaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033173; c=relaxed/simple;
	bh=5W+oZzTTB+4rVXd1JXNGCD611xXo1F4FQJhxF29NZcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZB8XepB7n7MsEQLu93zf1Sp2iBN1dlm+dEvccont5HSlodjyCMIVz79++moDsSuDUUOK7crrKYWIEPybVCDXZ3nKQhqGtfn6dbAMQa0FjwwPxS1dyNobW21D1nlkJ0LV3Pskzlp5EZdXhZX0m3FfK1/ty3CJimGNHRNEsi2kuYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeW7pb3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A83FC4CEE3;
	Fri, 27 Jun 2025 14:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751033172;
	bh=5W+oZzTTB+4rVXd1JXNGCD611xXo1F4FQJhxF29NZcM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OeW7pb3HT5rxyoWJmyLCVyxgjnJsYpB8GgwGSY5N1+i6Q6eXieRfR4nO6Iem87BhE
	 7q0pCTKMeKpZoqqGoXKDaQcmm4ip+n9D+8a3UeMtLSMbfm7FufdPBk2RckrkcQeXG2
	 Nrj+WG/KJ4Sk7Zd2SO+lxvEz5KEzhto6WSL6tXRYb9Xg3o1rkZodSQWsGPAOH/Josn
	 b+iiupoL502dq8D7+rbZZjaClcgCoFQTn8Yx72zRFcFdSzwulzf+1rQ5f4Mjci9WMi
	 /G14PeRxfIJ0Qy90mQHjWtr2CQ6lqknpCvMBrYFhdvvWIPG4JrqVywk2clmHZEXxlI
	 u3KobtwsdKNVQ==
Message-ID: <1b0d2349-dbf7-47aa-95c9-1974e63d111a@kernel.org>
Date: Fri, 27 Jun 2025 09:06:10 -0500
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
 Hans de Goede <hansg@kernel.org>
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <75fixx6rgwsgsw6e765oxdcivcg2nkzx2fp2qywgx4vi3ihywh@ot7gdecsnttw>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/2025 11:56 PM, Dmitry Torokhov wrote:
> On Thu, Jun 26, 2025 at 05:21:35PM -0500, Mario Limonciello wrote:
>> On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
>>> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
>>>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
>>>> <dmitry.torokhov@gmail.com> wrote:
>>>>>
>>>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
>>>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
>>>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
>>>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>>>>> [...]
>>>>>>>>>>> I want to note this driver works quite differently than how ACPI power
>>>>>>>>>>> button does.
>>>>>>>>>>>
>>>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>>>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>>>>>>>>>>> patch was modeling).
>>>>>>>>>>>
>>>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>>>>>>>>>>> [1]
>>>>>>>>>>
>>>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
>>>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
>>>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
>>>>>>>>>> multiple other platforms.
>>>>>>>>>
>>>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
>>>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
>>>>>>>>
>>>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
>>>>>>>> it does not seem to be captured in the email discussions or in the patch
>>>>>>>> description.
>>>>>>>
>>>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
>>>>>>> power-button issue. GNOME has a workaround for this, but I assume that
>>>>>>> some userspace desktop environments are still going to have a problem
>>>>>>> with this.
>>>>>>
>>>>>> It was done for this reason IIRC, but it should have been documented
>>>>>> more thoroughly.
>>>>>
>>>>> I assert that it should not have been done and instead dealt with in
>>>>> userspace. There are numerous drivers in the kernel emitting
>>>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
>>>>> what keys to process and when.
>>>>
>>>> Please see my last message in this thread (just sent) and see the
>>>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
>>>> events").
>>>>
>>>> This appears to be about cases when no event would be signaled to user
>>>> space at all (power button wakeup from ACPI S3).
>>>
>>> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
>>> button, right? So we can not send the "right" event code and use
>>> "neutral" KEY_WAKEUP for both. Is this right?
>>>
>>> Thanks.
>>>
>>
>> I did some more experiments with this affected system that started this
>> thread (which uses s2idle).
>>
>> I only applied patch 3 in this series to help the debounce behavior and
>> figure out impacts from patch 4 with existing Linux userspace.
>>
>> If suspended using systemd in GNOME (click the GUI button) on Ubuntu 24.04
>> the GNOME workaround mitigates this problem and no visible impact.
>>
>> If I suspend by hand using the kernel interface and then press power button
>> to wake:
>>
>> # echo mem | sudo tee /sys/power/state:
>>
>> * When GNOME is running:
>> I get the shutdown popup and it eventually shuts down.
>>
>> * When GNOME isn't running (just on a VT):
>> System shuts down.
> 
> For the latter you may want to raise an issue with systemd, and for the
> former I guess it is being too clever and does not activate the
> workaround if suspend was not initiated by it? I think Gnome is being
> too careful.
> 
> Thanks.
> 

Sure I could file bugs with both the projects.

But before I do if all userspace needs to account for this with a series 
of workarounds at resume time, you still think that is that really the 
best way forward?

Hans, you have a lot of experience in the GNOME community.  Your thoughts?

