Return-Path: <linux-acpi+bounces-17202-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A898B9234E
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BF6F189AFE3
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Sep 2025 16:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFA93112BD;
	Mon, 22 Sep 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZxPE1Wk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82257215198;
	Mon, 22 Sep 2025 16:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758558084; cv=none; b=pCEMoRlaC111BQkQneJiJKn8ZYsgw3xZ5/h//9HCNzzyedvaHIFwalCRsKwimZJ2NE+UYBfU5wX/ca33RaQRILZgGm0NkgjoOL+angZoxiCF11auYoM9UwtYmgyMbXeHMCMkpZ4qrGfO5ll3J0ISmthM76mcFSQ61uL+35NXFEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758558084; c=relaxed/simple;
	bh=gREPxZQCm8A4g2apBZdO6hgrydmqp7znNzVB64FbT14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/oG9IMnv1OAR8pem2wp91jWF0p/TO64zaAnzNvevxmV9hm6Cmnvk7Dv1oevrgIXrcrh98Y1IUC3dcsAS3xY3w9dI08A2HXpUnlbf868MEmlqsLrJ99pHNjUWpSh1aGHZ/jZ4D1tTqqs2S7Njkw9gFMerkLVpbHetTqtJHKw94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZxPE1Wk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5C5C4CEF0;
	Mon, 22 Sep 2025 16:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758558084;
	bh=gREPxZQCm8A4g2apBZdO6hgrydmqp7znNzVB64FbT14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZxPE1WkL1YRpJqsmRmhqPtQuk7L1fgzquTrDzQdl3KeYUN/yM4fKi8lH63OQ1Wyh
	 na4x7Nu2LQXwPvzkGOkweNS+oSY77TyYmmC5WzQHa2OV36GlMMshEtcNgycrV2oJx/
	 qGxRiCbrPkH60XCxixK8OfFtJUukpCtChMIrxnuss1qEIw4sIpJBDbqbil+vgsoJxF
	 NCZJuUkpGXuSwNumUmW2WtAoFZl7GZV3RZCafo3QGYvTnXxEXq4y+AZFs2YtXINqAZ
	 SrHVkhvnKWI06Qb3Oy3iIzZOK9J88T2h7wm8hQCCEc9gFOHzJU4qB5oWWdnJ3YIqU7
	 W7ITZLeZghBfA==
Message-ID: <79d7c45c-ccc9-411f-b9a8-47c02818f64c@kernel.org>
Date: Mon, 22 Sep 2025 11:21:22 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, stable@vger.kernel.org
References: <20250920201200.20611-1-hansg@kernel.org>
 <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
 <CAHp75Vf-MMcVGDt5xAMB94N866jZROQPKpvu5dZ-nCEPA9j-pg@mail.gmail.com>
 <f40ab4a5-1b17-4022-9539-37e470b7a175@kernel.org>
 <CAHp75VfaRcQOLjrd_pVK4XYPRN_4yM=acyVsOKThV3oMw1fB0g@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAHp75VfaRcQOLjrd_pVK4XYPRN_4yM=acyVsOKThV3oMw1fB0g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/21/2025 3:25 PM, Andy Shevchenko wrote:
> On Sun, Sep 21, 2025 at 11:11 PM Hans de Goede <hansg@kernel.org> wrote:
>> On 21-Sep-25 9:03 PM, Andy Shevchenko wrote:
>>> On Sun, Sep 21, 2025 at 9:09 PM Mario Limonciello (AMD) (kernel.org)
>>> <superm1@kernel.org> wrote:
>>>> On 9/20/2025 3:12 PM, Hans de Goede wrote:
> 
> ...
> 
>>>> Looks pretty much identical now to what I sent in my v3 and that Andy
>>>> had requested we change to make it fatal [1].
>>>>
>>>> Where is this bad GPIO value coming from?  It's in the GpioInt()
>>>> declaration?  If so, should the driver actually be supporting this?
>>>
>>> Since it's in acpi_find_gpio() it's about any GPIO resource type.
>>> Sorry, it seems I missed this fact. I was under the impression that v4
>>> was done only for the GpioInt() case. With this being said, the
>>> GpioIo() should not be fatal (it's already proven by cases in the wild
>>> that sometimes given values there are unsupported by HW), but
>>> GpioInt() in my opinion needs a justification to become non-fatal.
>>
>> GpioInt() debounce setting not succeeding already is non fatal in
>> the acpi_request_own_gpiod() case, which is used for ACPI events
>> (_AEI resources) and that exact use-case is why it was made non-fatal,
>> so no this is not only about GpioIo() resources. See commit
>> cef0d022f553 ("gpiolib: acpi: Make set-debounce-timeout failures non
>> fatal")
>>
>> IOW we need set debounce failures to be non-fatal for both the GpioIo
>> and GpioInt cases and this fix is correct as is.
> 
> Okay, since it doesn't change the state of affairs with for
> acpi_dev_gpio_irq_wake_get_by(), it's fair enough to get it as is.
> Mario, do you agree with Hans' explanations?
> 

Yeah it's fine as is, no concerns.

>> It is very likely too late to fix this *regression* for 6.17.0, please
>> queue this up for merging ASAP so that we can get a fix added to 6.17.1
> 
> 


