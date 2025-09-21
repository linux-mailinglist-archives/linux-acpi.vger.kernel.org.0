Return-Path: <linux-acpi+bounces-17161-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC639B8E2ED
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 20:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648273BFB11
	for <lists+linux-acpi@lfdr.de>; Sun, 21 Sep 2025 18:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717B1274B2F;
	Sun, 21 Sep 2025 18:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LggHvpcg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A42254B19;
	Sun, 21 Sep 2025 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758478141; cv=none; b=mkWHkGp6Fq4lDIoCCW/et+22gRMNNQ1qP3N1kzIdlrWE7jFU4ITOTNWdNywbPM7iYQ1PAI9HyZOAMzdQIjDyRPaInbcalS79mKjT4P+xdoUfTMXomgL0k7F0SnCyehNQudfqOs1zWBYu674DnXUadBbj80RSshJfFX1phQQWcUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758478141; c=relaxed/simple;
	bh=Jc+3ss1RntgdCTHA/Sh2ehd4H0pak4TUfCRpOkLWagk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kG6xDpMTYzJH5+fmZmNC7Y1Q9+8fwMiWqcyLfGhiQU2s+YhVXSJEE5MagVF3SJZbQ54LIr0getkwCAjJmF8QUqJQ8O5BvdO/Ewx5r1l9kzgF0qZ7fg+kagC+iGCzp80ZJbAmF22gtIBkr9SI58putyfPPQIvwrbCj6xzI0KTCZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LggHvpcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B5CC4CEE7;
	Sun, 21 Sep 2025 18:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758478140;
	bh=Jc+3ss1RntgdCTHA/Sh2ehd4H0pak4TUfCRpOkLWagk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LggHvpcghfvzN3XrFEmJV7wTSZU/PwXfG948FhXMMH5CPA6j/9hQQfAo9+5ZuyKDb
	 7p+516wvAB3CxXldBCKCGguY3hU6QamJIy4DJ9iLmDwtefraLRJUFM7ekFZ71tVeTl
	 Mlz0/SYyp942GVQOA8HFn0zr17Yn+aOZID4VVaQvBfvdyDBgZ8aqtV6IAw8tf6Vkg/
	 UE3i0XlBmxwpNJ2k7qSWLccW0/wselLVU6m8++cjvUPh1E9FRkqxQNfn0/FGFoOwN7
	 piJrHoyIBqYI2iNOT/YYItKWdS3O68EUSZW+767qpUjPVLGMUs1r+o7amY6v8W22Sl
	 eth7u11CJyPRw==
Message-ID: <6d9e13e9-1e93-4e39-bfd1-56e4d25c007f@kernel.org>
Date: Sun, 21 Sep 2025 13:08:58 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.17 REGRESSION FIX] gpiolib: acpi: Make set debounce
 errors non fatal
To: Hans de Goede <hansg@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 stable@vger.kernel.org
References: <20250920201200.20611-1-hansg@kernel.org>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <20250920201200.20611-1-hansg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/20/2025 3:12 PM, Hans de Goede wrote:
> Commit 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
> adds a gpio_set_debounce_timeout() call to acpi_find_gpio() and makes
> acpi_find_gpio() fail if this fails.
> 
> But gpio_set_debounce_timeout() failing is a somewhat normal occurrence,
> since not all debounce values are supported on all GPIO/pinctrl chips.
> 
> Making this an error for example break getting the card-detect GPIO for
> the micro-sd slot found on many Bay Trail tablets, breaking support for
> the micro-sd slot on these tablets.
> 
> acpi_request_own_gpiod() already treats gpio_set_debounce_timeout()
> failures as non-fatal, just warning about them.
> 
> Add a acpi_gpio_set_debounce_timeout() helper which wraps
> gpio_set_debounce_timeout() and warns on failures and replace both existing
> gpio_set_debounce_timeout() calls with the helper.
> 
> Since the helper only warns on failures this fixes the card-detect issue.
> 
> Fixes: 16c07342b542 ("gpiolib: acpi: Program debounce when finding GPIO")
> Cc: stable@vger.kernel.org
> Cc: Mario Limonciello <superm1@kernel.org>
> Signed-off-by: Hans de Goede <hansg@kernel.org>

Looks pretty much identical now to what I sent in my v3 and that Andy 
had requested we change to make it fatal [1].

Where is this bad GPIO value coming from?  It's in the GpioInt() 
declaration?  If so, should the driver actually be supporting this?

https://lore.kernel.org/linux-gpio/20250811164356.613840-1-superm1@kernel.org/ 
[1]

> ---
>   drivers/gpio/gpiolib-acpi-core.c | 27 +++++++++++++++------------
>   1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 284e762d92c4..67c4c38afb86 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -291,6 +291,19 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
>   	return GPIOD_ASIS;
>   }
>   
> +static void acpi_gpio_set_debounce_timeout(struct gpio_desc *desc,
> +					   unsigned int acpi_debounce)
> +{
> +	int ret;
> +
> +	/* ACPI uses hundredths of milliseconds units */
> +	acpi_debounce *= 10;
> +	ret = gpio_set_debounce_timeout(desc, acpi_debounce);
> +	if (ret)
> +		gpiod_warn(desc, "Failed to set debounce-timeout %u: %d\n",
> +			   acpi_debounce, ret);
> +}
> +
>   static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>   						struct acpi_resource_gpio *agpio,
>   						unsigned int index,
> @@ -300,18 +313,12 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>   	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
>   	unsigned int pin = agpio->pin_table[index];
>   	struct gpio_desc *desc;
> -	int ret;
>   
>   	desc = gpiochip_request_own_desc(chip, pin, label, polarity, flags);
>   	if (IS_ERR(desc))
>   		return desc;
>   
> -	/* ACPI uses hundredths of milliseconds units */
> -	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
> -	if (ret)
> -		dev_warn(chip->parent,
> -			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
> -			 pin, ret);
> +	acpi_gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
>   
>   	return desc;
>   }
> @@ -944,7 +951,6 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>   	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
>   	struct acpi_gpio_info info = {};
>   	struct gpio_desc *desc;
> -	int ret;
>   
>   	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
>   	if (IS_ERR(desc))
> @@ -959,10 +965,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>   	acpi_gpio_update_gpiod_flags(dflags, &info);
>   	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
>   
> -	/* ACPI uses hundredths of milliseconds units */
> -	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> -	if (ret)
> -		return ERR_PTR(ret);
> +	acpi_gpio_set_debounce_timeout(desc, info.debounce);
>   
>   	return desc;
>   }


