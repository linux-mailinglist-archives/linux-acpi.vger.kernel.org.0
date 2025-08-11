Return-Path: <linux-acpi+bounces-15594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7683B21707
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 23:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA9E6811CC
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Aug 2025 21:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4E2E2DD0;
	Mon, 11 Aug 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1Orvt08"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC92E285B;
	Mon, 11 Aug 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754946388; cv=none; b=iPTKShblFuq4YgxHcYE0anJjWaEQzQ3CGLb1KFWSZU5CIIQPPuSD010DUa2/UOii4DZprcTrRUPFW3hGHmfFLubzJPwmpUUviCxfTXPZhYUdS+BQ0R831U+D+5IJ7ZdSeaOj+oVlyLkUQl3WN43Lwq2lWnUeprUq+jo2masPeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754946388; c=relaxed/simple;
	bh=jH1iI4xJGwfuGZfxy0AnoVyd9Mt7S2hCjqY8su0Nvls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGAUb9+fK3nGBsi9ljAMFgu0Ufsz7matt/BPN2s2nY/9SMf2lUC9l3JP6Koew7nHGJuldFa8I35LRxuWCR0pcqo5WAa9RkbNkoItFGP0JLOawNh+xArlF6I0+Ueixl9U2wfzV0ENOl8QnHYuoW4v5RVenpgv06mgpLRuGDWCQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1Orvt08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BBAC4CEED;
	Mon, 11 Aug 2025 21:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754946388;
	bh=jH1iI4xJGwfuGZfxy0AnoVyd9Mt7S2hCjqY8su0Nvls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1Orvt08q5Zgo0cG4iKsVZ5iN/3lETY1fNRYe0SuFZVLA119agKtglbKQFvnCiffG
	 u0q1Ne8orVfFWi6lyK7w2unX3vaskOl6ovVzO4/2V4v9Of+RLiv43ehxlS3GIUa54a
	 6vy/jDGi5vKmxH/TZmrQVbUfjw5MPzJUPp6PK7NLGOtdMnlMxVMFGeJm4w73s0XiI2
	 ihXG4JhViXvHA52uqp/xK4fstwqsh746V4B4EX+5goBJAWOivVU1IJL9ddOoTncxrw
	 ll4tLoNc+y4NM2N6FCw6Rq9xNDcaIQGk4g0rKnrszU4NQIBUoqYqLZ8meDz/XdZsb3
	 DqXuUL3JmiQiA==
Message-ID: <73b355d7-ed40-48c7-b624-380ebdac8f5a@kernel.org>
Date: Mon, 11 Aug 2025 16:06:26 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] gpiolib: acpi: Program debounce when finding GPIO
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>
References: <20250811164356.613840-1-superm1@kernel.org>
 <aJpVw39tBNkEtkgZ@smile.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aJpVw39tBNkEtkgZ@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/25 3:42 PM, Andy Shevchenko wrote:
> On Mon, Aug 11, 2025 at 11:43:56AM -0500, Mario Limonciello (AMD) wrote:
>> When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
>> which will parse _CRS.
>>
>> acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
>> gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
>> gpiod_get_index (drivers/gpio/gpiolib.c:4877)
>>
>> The GPIO is setup basically, but the debounce information is discarded.
>> The platform will assert what debounce should be in _CRS, so program it
>> at the time it's available.
>>
>> As this is considered non fatal if it fails, introduce a helper for
>> programming debounce and show a warning when failing to program.
> 
> I think I already commented on this previously. Let me do that below anyway.
> 
> ...
> 
> 
>> +static void acpi_set_debounce_timeout(struct gpio_desc *desc, unsigned int timeout)
>> +{
>> +	int ret;
>> +
>> +	/* ACPI uses hundredths of milliseconds units */
>> +	ret = gpio_set_debounce_timeout(desc, timeout * 10);
>> +	if (ret)
>> +		dev_warn(&desc->gdev->dev,
>> +			 "Failed to set debounce-timeout: %d\n", ret);
>> +}
> 
> I would make it still return the code to the caller. See below why.
> 
> 
> ...
> 
>> -			/* ACPI uses hundredths of milliseconds units */
>> -			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
>> -			if (ret)
>> -				return ret;
>> +			acpi_set_debounce_timeout(desc, info.debounce);
> 
> The commit message fails to explain why we do relax the condition here. This is
> about GpioInt() resource and so far I haven't heard about misused debounce
> values there. If we drop the fatality, it has to be a separate patch explaining
> why. But only if we have practical use cases. AS long as there no failed
> platforms, I can't agree on this piece of change.
> 

Thanks for the feedback.  I thought that I got your feedback the first 
time when I originally squashed, but I must have failed.

In that case I don't think we really need a helper at all.  I'll change 
it for v4 to just add the extra call without the use of a helper.

