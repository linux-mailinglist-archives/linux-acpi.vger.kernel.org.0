Return-Path: <linux-acpi+bounces-14753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC513AEA98E
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 00:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986157AD9A7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 22:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04AF26056F;
	Thu, 26 Jun 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTrt4WkV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3C2185AC;
	Thu, 26 Jun 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750976498; cv=none; b=jJzS73F9Rt2O3l2J4tN6+HaVav7clkwYM1ZPhXzs49PhvPGbiDGlOLdm3gLE+DSL/25WabwY5WGg9/3cKMlcfpjAVUZwqpu8OpM3JEoquUmIcmNaHfukxGy4vp5qNg2cVZbHatqdGnWbyvT87AScF2KMQT1VxCQorRrkXp8h+pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750976498; c=relaxed/simple;
	bh=S4MQ+wCspDRAXFvPxNkjxgXfaczwIPQ46HAjeRIjCq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TFyViSp40makklYOZuQtOVkhJGpdrxTtjFJLoQBYlglvkypDP9zZbrmhaNLWRn/DmVxag79QtKiC74LZXRen/XmuvRf0mDPanREgLw5Nax4S9s1YDXn8eiLyJptqXNKvK3+u70jwkZy/zN1xUjJWKXGtsgyBLJj/nXTtumVkZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTrt4WkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F778C4CEEB;
	Thu, 26 Jun 2025 22:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750976498;
	bh=S4MQ+wCspDRAXFvPxNkjxgXfaczwIPQ46HAjeRIjCq4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CTrt4WkVJKOL0eSc1X21mUYuVtrkxMBdcEjoCNAmbsmyoMWFkKbdFDlNqDDc6s5FZ
	 iuproVump4dstGukb02DSUrq7f6BkEjdBkd8JBUILPB4M2Z6rHZKIub3M+avK011W7
	 YRUPGu4pKS/dtuJ6gOaeLzuSnBW1pvmKTajcunoD8NhqQMHwrPNFkzXjqAeEDETgu6
	 hs0oILjp6poL1wZwYYCn5lWH6rzwsGNtZwbFTrpz3Z21Ubi3NL+R+L07BsgfSUMimX
	 4qsijFyNhKs5oMA9C+nq5GzPxhySYJ3or8hI46ElNzrqp61OvkXE/bf0SAfJ6gc6Wo
	 3IPvaCXKRTowg==
Message-ID: <de548b27-4c43-4f30-af9d-b060101e6fd8@kernel.org>
Date: Thu, 26 Jun 2025 17:21:35 -0500
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
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <363c2b92-4bfc-4537-9fca-025eef09526f@kernel.org>
 <nxticocp26r5mmpkttritw76h5igw7bdpus6zaf5krkso2h5xy@wna6m2quekfi>
 <cbbf0caf-82ce-4427-9844-b11e0f5cacdb@kernel.org>
 <obpakvzyludc4jskqzyxf65dhqds7ie3jkbfsqdve32ouuaili@xvogkmwvbmbf>
 <284ea5c0-dca5-4e9e-a3e7-705eca794010@kernel.org>
 <vkau25ybcx3bcoa2jmxlukumunzii5h6em43anh6mmzk2kyiv7@kyych4kxc4zo>
 <0d71a686-da67-4686-8976-a17d0d1ca923@kernel.org>
 <CAJZ5v0gKUN1OdqAHnXNcFUAOfhpdRfa_o=L6TA2GZTpe1bMaNQ@mail.gmail.com>
 <exmgckzoakt2ncsdphqvymcadon7k6tl36a3zvrj2pv23dffps@znq23v3qbcm2>
 <CAJZ5v0j3ZyuEqSKQ+3K8M3BwPCxn5Z6KOwjyjt4cJW6HfxjPDw@mail.gmail.com>
 <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <hyvpl4gvxc6h2r3itfofjduwb3vpobyo7a7z6g3zapzscqtafh@ixsd4amyljva>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/2025 2:40 PM, Dmitry Torokhov wrote:
> On Thu, Jun 26, 2025 at 09:31:12PM +0200, Rafael J. Wysocki wrote:
>> On Thu, Jun 26, 2025 at 9:28 PM Dmitry Torokhov
>> <dmitry.torokhov@gmail.com> wrote:
>>>
>>> On Thu, Jun 26, 2025 at 09:18:56PM +0200, Rafael J. Wysocki wrote:
>>>> On Thu, Jun 26, 2025 at 9:16 PM Hans de Goede <hansg@kernel.org> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 26-Jun-25 21:14, Dmitry Torokhov wrote:
>>>>>> On Thu, Jun 26, 2025 at 08:57:30PM +0200, Hans de Goede wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On 26-Jun-25 20:48, Dmitry Torokhov wrote:
>>>>>>>> On Thu, Jun 26, 2025 at 01:20:54PM -0500, Mario Limonciello wrote:
>>> [...]
>>>>>>>>> I want to note this driver works quite differently than how ACPI power
>>>>>>>>> button does.
>>>>>>>>>
>>>>>>>>> You can see in acpi_button_notify() that the "keypress" is only forwarded
>>>>>>>>> when not suspended [1].  Otherwise it's just wakeup event (which is what my
>>>>>>>>> patch was modeling).
>>>>>>>>>
>>>>>>>>> https://github.com/torvalds/linux/blob/v6.16-rc3/drivers/acpi/button.c#L461
>>>>>>>>> [1]
>>>>>>>>
>>>>>>>> If you check acpi_button_resume() you will see that the events are sent
>>>>>>>> from there. Except that for some reason they chose to use KEY_WAKEUP and
>>>>>>>> not KEY_POWER, oh well. Unlike acpi button driver gpio_keys is used on
>>>>>>>> multiple other platforms.
>>>>>>>
>>>>>>> Interesting, but the ACPI button code presumably only does this on resume
>>>>>>> for a normal press while the system is awake it does use KEY_POWER, right ?
>>>>>>
>>>>>> Yes. It is unclear to me why they chose to mangle the event on wakeup,
>>>>>> it does not seem to be captured in the email discussions or in the patch
>>>>>> description.
>>>>>
>>>>> I assume they did this to avoid the immediate re-suspend on wakeup by
>>>>> power-button issue. GNOME has a workaround for this, but I assume that
>>>>> some userspace desktop environments are still going to have a problem
>>>>> with this.
>>>>
>>>> It was done for this reason IIRC, but it should have been documented
>>>> more thoroughly.
>>>
>>> I assert that it should not have been done and instead dealt with in
>>> userspace. There are numerous drivers in the kernel emitting
>>> KEY_POWER. Let userspace decide how to handle this, what keys to ignore,
>>> what keys to process and when.
>>
>> Please see my last message in this thread (just sent) and see the
>> changelog of commit 16f70feaabe9 ("ACPI: button: trigger wakeup key
>> events").
>>
>> This appears to be about cases when no event would be signaled to user
>> space at all (power button wakeup from ACPI S3).
> 
> Ahh, in S3 we do not know if we've been woken up with Sleep or Power
> button, right? So we can not send the "right" event code and use
> "neutral" KEY_WAKEUP for both. Is this right?
> 
> Thanks.
> 

I did some more experiments with this affected system that started this 
thread (which uses s2idle).

I only applied patch 3 in this series to help the debounce behavior and 
figure out impacts from patch 4 with existing Linux userspace.

If suspended using systemd in GNOME (click the GUI button) on Ubuntu 
24.04 the GNOME workaround mitigates this problem and no visible impact.

If I suspend by hand using the kernel interface and then press power 
button to wake:

# echo mem | sudo tee /sys/power/state:

* When GNOME is running:
I get the shutdown popup and it eventually shuts down.

* When GNOME isn't running (just on a VT):
System shuts down.



