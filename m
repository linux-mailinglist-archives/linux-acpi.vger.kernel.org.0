Return-Path: <linux-acpi+bounces-14803-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A98F5AEC012
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 21:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CC20188BA38
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Jun 2025 19:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361C120C000;
	Fri, 27 Jun 2025 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jORnNvZ4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C661C5496;
	Fri, 27 Jun 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053091; cv=none; b=UKBKQyZ8iixV0J+pg8MUkwZ5qvsb6tEubCvisXb5Kv7C99RBhSYv0sbOZC0XUX7LTfUCR/sYGifPhHfDEkxBDEd8wr/pKeUyxs69bYGAqlAyJ1NMTKXlzJmoiv5BBAodwNj4IwUplMtzxrI79SSjF2y4+bCle1r7EUSBBoZ74Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053091; c=relaxed/simple;
	bh=IaHiq80K/XJ1mca1aiRXLxnrML7BIY8xQk2zNdDd4Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THoyXRTWuM5T1+EQtyyaUzOntGAu9NSoVcN9pY9XxTTWVPt6t9iQqmE17t1ifUInq4AuV8HDj/ni1reXzacqz6xTwWvEz7X4a0PML+XwxLKsQsbg2l4yALUZnU29iTaVx/viuVt5e4O3ufjmVznYWuT+hjJGt9NWl0EevD4yImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jORnNvZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE77C4CEE3;
	Fri, 27 Jun 2025 19:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751053090;
	bh=IaHiq80K/XJ1mca1aiRXLxnrML7BIY8xQk2zNdDd4Tc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jORnNvZ4wQ/o3RzobzHRXuK+7K/AsTmPQk9RRlzQ47O4SyiyHTo5i8uMeXcBEAUD2
	 ehvVVfzCPAVPzLmM7NiUvHxkTy6h0rxBZeRGy+vcRvBtaGZ8PSogIIcUct0itwZUcW
	 TVFaX7BCaf7jJ9Ms3ZqOc29Dk5p+PEFyP9YMOp9sDws315zmNLDQ1ZPboubB9ENGT2
	 Xp2O0hqfnpuq+AaXKUReBa/cgBljGYCX1QbWskTu1TAxhabUxdZwImU8AXusu6uFkX
	 +AkM3BRd9+zjoiUMbkKYgxHnfFF5QTnB0iB+ana/xoyCGt4PTwWrMZzbFE1nATtgPJ
	 3lGL3aRg4Wo/A==
Message-ID: <584af55f-1b73-4c17-bf85-c2d3ecf6692e@kernel.org>
Date: Fri, 27 Jun 2025 21:38:06 +0200
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
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <ly3mww7nq7uuqvdx7p2uzcrphhboeuep3yuwbaxwfimesitjaa@hf72i4vu5quo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 27-Jun-25 9:18 PM, Dmitry Torokhov wrote:
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
>>                          * already released by the time we got interrupt
>>                          * handler to run.
>>                          */
>> -                       input_report_key(bdata->input, button->code, 1);
>> +                       input_report_key(bdata->input, *bdata->code, 1);
>> +                       input_sync(bdata->input);
> 
> I start wondering if we should keep the fake press given that we do not
> know for sure if wakeup truly happened because of this button press...

AFAIK we cannot drop the fake press because then Android userspace
will immediately go back to sleep again assuming the wakeup was
e.g. just some data coming in from the modem which did not result
in a notification to show, so no need to turn on the display,
but instead immediately go back to sleep.

IIRC last time we had this discussion (man years ago) the reason
to send KEY_POWER was to let Android know that it should actualy
turn on the display and show the unlock screen because the user
wants that to happen.

I believe this is also what the KEY_WAKEUP thing in the ACPI button
code is for.

> Can we track back to the wakeup source and determine this? It will not
> help your problem, but I still believe userspace is where policy should
> live.

There is /sys/power/pm_wakeup_irq we could correlate that to the IRQ
number of the ISR and then AFAICT we will definitively know if
the power-button was the wakeup source ?

Regards,

Hans


