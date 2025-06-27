Return-Path: <linux-acpi+bounces-14805-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B186AAEC052
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 21:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF96A640C82
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 19:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2CE121ADC7;
	Fri, 27 Jun 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDXLkkkk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7E211460;
	Fri, 27 Jun 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053556; cv=none; b=pUQOMvppUP7HE8ZMQWpnnG0MTNqdAbhe6yY0hQG0ckDIFGhoqNnHeJKgapw5r/DGDdRGVNTiUJVwVtDp2H7w62b7bPxIbqpOk0RysTgZBmHCmN6WI8qpSk0WiTPlgflHhuHhgiU7lCAlB0fb2Vq85xDTtWjur6/elkj/pU5HPxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053556; c=relaxed/simple;
	bh=nybGHUl0eKRvrlbvr0hzyiokVYz+dFJp2PTtyQdcxc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HajY90fKHS4yJ4Cvr9zOEajNu2b+iRT/xO65LNgchmqE/I8ufL2auPvvKh0jtqDO6mTuG7hLGeKZDpf32+6hTRqvmeHY74HO8IL8/+S95CinVy1DTOWXuq/EOVjfcMYXavgruJlmHRyLVx+ZW/FiS0X6dtZQzmOK0AVFf31jBTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDXLkkkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2272C4CEE3;
	Fri, 27 Jun 2025 19:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053556;
	bh=nybGHUl0eKRvrlbvr0hzyiokVYz+dFJp2PTtyQdcxc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mDXLkkkkNlwRMffFHNuDjksIX7ei9J32Efy0q8vMOlM19YDCpkEnMuzf7PR9osJ5g
	 QE4Pys/SHveMMhvmOa+jF1Qoam8l5ICKxte7Nyy9hQu1EmjXQUzpiBcdu6spl4O2Pc
	 pCZxNLjGrs3X9JJxe07Ee/+ljbdTptvAox6XfjEmk8XgQDg+UfnbZAl/0Y4iaNy1xs
	 o3Y6FcuGuAxBjm29lmbKAUofdDJ7bs5Hu+I3a0xpfgTZ7NhBqe7aAttoDC09bLfGkd
	 0fYj3hb1xSyfabh5m+BqGYSpUs2fZTSZtTYfzqph1rnWFC9PFCIUwpfcExypalzcA1
	 HJcD8inGqUr5A==
Message-ID: <5224077f-4262-425b-8183-9cc7673e381e@kernel.org>
Date: Fri, 27 Jun 2025 14:45:53 -0500
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
Cc: Hans de Goede <hansg@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Mika Westerberg <westeri@kernel.org>,
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <ly3mww7nq7uuqvdx7p2uzcrphhboeuep3yuwbaxwfimesitjaa@hf72i4vu5quo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/2025 2:18 PM, Dmitry Torokhov wrote:
> On Fri, Jun 27, 2025 at 01:56:53PM -0500, Mario Limonciello wrote:
>> On 6/27/2025 1:36 PM, Dmitry Torokhov wrote:
>>> On Fri, Jun 27, 2025 at 05:56:05PM +0200, Hans de Goede wrote:
> 
> [ ... trim ... ]
> 
>>>
>>> 2. There is a patch from Mario (a8605b0ed187) suppressing sending
>>> KEY_POWER as part of "normal" wakeup handling, pretty much the same as
>>> what he and you are proposing to do in gpio-keys (and eventually in
>>> every driver keyboard or button driver in the kernel). This means we no
>>> longer can tell if wakeup is done by power button or sleep button (on
>>> systems with dual-button models, see ACPI 4.8.3.1).
>>
>> Actually a8605b0ed187 was about a runtime regression not a suspend
>> regression.  I didn't change anything with sending KEY_POWER during wakeup
>> handling.
> 
> Ah, right, ignorng events for "suspended" buttons was done in
> e71eeb2a6bcc ("ACPI / button: Do not propagate wakeup-from-suspend
> events"). Again trying to add heuristic to the kernel instead of
> enlightening userspace.
> 
> I am curious why the system is sending "Notify Wake" events when not
> sleeping though?

I wondered the same thing.  My guess is this is a BIOS bug.

> 
> [ .. skip .. ]
> 
>>
>> FTR I did test Hans suggestion and it does work effectively (code below).
>>
>> diff --git a/drivers/input/keyboard/gpio_keys.c
>> b/drivers/input/keyboard/gpio_keys.c
>> index f9db86da0818b..3bc8c95e9943b 100644
>> --- a/drivers/input/keyboard/gpio_keys.c
>> +++ b/drivers/input/keyboard/gpio_keys.c
>> @@ -425,7 +425,8 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void
>> *dev_id)
>>                           * already released by the time we got interrupt
>>                           * handler to run.
>>                           */
>> -                       input_report_key(bdata->input, button->code, 1);
>> +                       input_report_key(bdata->input, *bdata->code, 1);
>> +                       input_sync(bdata->input);
> 
> I start wondering if we should keep the fake press given that we do not
> know for sure if wakeup truly happened because of this button press...
> 
> Can we track back to the wakeup source and determine this? It will not
> help your problem, but I still believe userspace is where policy should
> live.
> 
> Thanks.
> 


