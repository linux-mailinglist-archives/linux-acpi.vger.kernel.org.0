Return-Path: <linux-acpi+bounces-14726-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D29AEA5A7
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF8A567E0B
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB502EF664;
	Thu, 26 Jun 2025 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGCN2WHj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A62E2EF656;
	Thu, 26 Jun 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750963539; cv=none; b=h2AZnzDp0vpIs30IoBNDJOT5weytVZcOKDKdqHf6rJmmfrnbALIft809XQje5u7f2qBNv2OMSjSJf3spKr0FoDPKPqH2l9sNn+LGU8ZR5LWdQq0D47tQOsi/XX4i77wLjkrhwjXpNnOM+VkvwcbznAw4XlkajgqBam5+5HGvBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750963539; c=relaxed/simple;
	bh=of2O+rjvw2R+QnzTU0mW1vcupF6IPafKbj9Dx9Sl02o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jKZTI5fgJ+T0hfhXoR+ETP9GEP5O/3rZUoPkIa5q3H+owskF0Y8MmMpV1x0Z9FAHWl93bU5OkijL024aiorp62vTMqQOV49GHl1KL8jZCDc3sVbBjDHRdS0pJ1Klz+EcpcIPIJhsLwpfhUcDpMsqCBLNlzBtnVIR7cPF5Re4zU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGCN2WHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9E9C4CEEB;
	Thu, 26 Jun 2025 18:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750963538;
	bh=of2O+rjvw2R+QnzTU0mW1vcupF6IPafKbj9Dx9Sl02o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kGCN2WHjTESZc01jx6jRoowQdGuZKJFBfqTM91SFDkiR+k2bsnt1TypEh/+cGf7uk
	 x723zSQdxObINYz+43kKSE3lmytTODBwykobxycnHeqHcyN+Bf5S0N2FtLILVMHif+
	 yloRK5LwiofFdSoQ9e/JhjWZEx0h8O6MoDXk7gP3wgYXIxfq+RTUcow29vFtB3sXeP
	 iMQTogGfqdKIOXkjRgWPG0wRogmii7s351keSXczLO+nJPoi50J28PiOU+xG5/KjEH
	 66KSd5SBpkjx1k5ieDfJjwv6Ni+QUArEZGqRO8u8mk9R4jk7sKhoSmf3aV8EYvVxje
	 iOEKs6Ta58HLw==
Message-ID: <3a1e2e0c-cbb9-4e3a-aa5a-9f88e8f05bc5@kernel.org>
Date: Thu, 26 Jun 2025 20:45:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] Input: Don't send fake button presses to wake
 system
To: Mario Limonciello <superm1@kernel.org>
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <0982b8f9-81cc-4081-bdc2-29cb99923f54@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 26-Jun-25 20:42, Mario Limonciello wrote:
> On 6/26/2025 1:37 PM, Hans de Goede wrote:
>> Hi Mario,
>>
>> On Thu, Jun 26, 2025 at 06:33:08AM -0500, Mario Limonciello wrote:
>>>
>>>
>>> On 6/26/25 3:35 AM, Hans de Goede wrote:
>>>> Hi Mario,
>>>>
>>>> On 25-Jun-25 23:58, Mario Limonciello wrote:
>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>
>>>>> Sending an input event to wake a system does wake it, but userspace picks
>>>>> up the keypress and processes it.  This isn't the intended behavior as it
>>>>> causes a suspended system to wake up and then potentially turn off if
>>>>> userspace is configured to turn off on power button presses.
>>>>>
>>>>> Instead send a PM wakeup event for the PM core to handle waking the system.
>>>>>
>>>>> Cc: Hans de Goede <hansg@kernel.org>
>>>>> Fixes: 0f107573da417 ("Input: gpio_keys - handle the missing key press event in resume phase")
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>> ---
>>>>>    drivers/input/keyboard/gpio_keys.c | 7 +------
>>>>>    1 file changed, 1 insertion(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
>>>>> index 773aa5294d269..4c6876b099c43 100644
>>>>> --- a/drivers/input/keyboard/gpio_keys.c
>>>>> +++ b/drivers/input/keyboard/gpio_keys.c
>>>>> @@ -420,12 +420,7 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
>>>>>            pm_stay_awake(bdata->input->dev.parent);
>>>>>            if (bdata->suspended  &&
>>>>>                (button->type == 0 || button->type == EV_KEY)) {
>>>>> -            /*
>>>>> -             * Simulate wakeup key press in case the key has
>>>>> -             * already released by the time we got interrupt
>>>>> -             * handler to run.
>>>>> -             */
>>>>> -            input_report_key(bdata->input, button->code, 1);
>>>>> +            pm_wakeup_event(bdata->input->dev.parent, 0);
>>>>>            }
>>>>>        }
>>>>
>>>> Hmm, we have the same problem on many Bay Trail / Cherry Trail
>>>> windows 8 / win10 tablets, so  this has been discussed before and e.g.
>>>> Android userspace actually needs the button-press (evdev) event to not
>>>> immediately go back to sleep, so a similar patch has been nacked in
>>>> the past.
>>>>
>>>> At least for GNOME this has been fixed in userspace by ignoring
>>>> power-button events the first few seconds after a resume from suspend.
>>>>
>>>
>>> The default behavior for logind is:
>>>
>>> HandlePowerKey=poweroff
>>
>> Right note poweroff not suspend, GNOME inhibits logind's power-button
>> handling and substitutes its own handling which is done by gsd-media-keys.
>>
>>> Can you share more about what version of GNOME has a workaround?
>>> This was actually GNOME (on Ubuntu 24.04) that I found this issue.
>>
>> See:
>>
>> https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/main/plugins/media-keys/gsd-media-keys-manager.c?ref_type=heads#L94
>>
>> and the code in that file using that define.
>>
>> Regards,
>>
>> Hans
>>
> 
> This is pretty ancient, it's part of GNOME 40 and later.  Ubuntu 24.04 is GNOME 46.

Right, this power-button evdev key event on resume causing an immediate
suspend again is a pretty old problem. When I said "discussed before"
I meant discussed quite a while ago :)

Regards,

Hans



