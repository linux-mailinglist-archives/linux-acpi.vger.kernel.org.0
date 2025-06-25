Return-Path: <linux-acpi+bounces-14629-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB067AE8D58
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 20:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12185A1EBC
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DFD2DF3E3;
	Wed, 25 Jun 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXG6OcNP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456612DECD5;
	Wed, 25 Jun 2025 18:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877889; cv=none; b=iXNWenwWczCk4NpnccNV+Ozsy8yFam72zdjmkjrh4o3Fp28M6xKtc285B4UWkhNoi6GphBL7Vwh2U7Qqm3ljsgmzpA5OzeR+OvIdTEJ/Mz36Dc3DyPyJo/PfYbYIXXHRHqbJy0mNjl8bUq5JmaRwCf9edUkTFhB60WkPMGhcalY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877889; c=relaxed/simple;
	bh=3OLpQwoBvTvHBPceDaTTwYm8KETmFqBGnz2ugi+2kUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVYNu2nDiaGLnLMyq9sEXC19redf5x3kze6+UFWBtmFXkKA+6uGQdZYfIAt2idaZfQuKV9JxCTcA0j7lQrmdSi3K+ji7ZnTTrBzYVr8tSAQX5Bfw66ks0qCZg8VmUfCDLtT1AmtQRl23KH4gkHp1c+01ZZhdn2f8MLy6ie2ncX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXG6OcNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2724C4CEF3;
	Wed, 25 Jun 2025 18:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877888;
	bh=3OLpQwoBvTvHBPceDaTTwYm8KETmFqBGnz2ugi+2kUY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GXG6OcNPEME1CEqWK/3A7LhmB2b7xbI5p/EVT28ITDiYMq2zAaR96iS3g4OFfJXn3
	 BdpUEeXsvFjT6uYJMeV6en68QFHJGVc+460GUsGOkBQoM4O790OKFEFpjFw8c9OePf
	 mwRkFf7v0TuLXonJF3g5TxOFjMhZb8FtxUXBiAiJDKRE4ae/mBWoy8FV69sl4Katke
	 oB+n5s4J+SEji7uwUMNRwjZrdFupxRSrjD60i3cpz9zvafP8LANIUVu/TLjIspr0vC
	 NzyDNCgFwYN5DTLWqK94sJdE7eYpLpPw2pKUWGmyh9HxhQKJvj5QdhwmPwBtBbMa0F
	 EB0WsELaBv4MQ==
Message-ID: <3ec49306-a21b-4f2a-b224-994f323148ab@kernel.org>
Date: Wed, 25 Jun 2025 20:58:05 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] gpiolib: acpi: Add a helper for programming
 debounce
To: Mario Limonciello <superm1@kernel.org>,
 Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250625181342.3175969-1-superm1@kernel.org>
 <20250625181342.3175969-2-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250625181342.3175969-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Debounce is programmed in two places and considered non-fatal in one of
> them. Introduce a helper for programming debounce and show a warning
> when failing to program.  This is a difference in behavior for the call
> in acpi_dev_gpio_irq_wake_get_by().
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/gpio/gpiolib-acpi-core.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 12b24a717e43f..1895e45bd9f16 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -291,6 +291,17 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
>  	return GPIOD_ASIS;
>  }
>  
> +static void acpi_set_debounce_timeout(struct gpio_desc *desc, unsigned int timeout)
> +{
> +	int ret;
> +
> +	/* ACPI uses hundredths of milliseconds units */
> +	ret = gpio_set_debounce_timeout(desc, timeout * 10);
> +	if (ret)
> +		dev_warn(&desc->gdev->dev,
> +			 "Failed to set debounce-timeout: %d\n", ret);
> +}
> +
>  static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>  						struct acpi_resource_gpio *agpio,
>  						unsigned int index,
> @@ -300,18 +311,12 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>  	enum gpiod_flags flags = acpi_gpio_to_gpiod_flags(agpio, polarity);
>  	unsigned int pin = agpio->pin_table[index];
>  	struct gpio_desc *desc;
> -	int ret;
>  
>  	desc = gpiochip_request_own_desc(chip, pin, label, polarity, flags);
>  	if (IS_ERR(desc))
>  		return desc;
>  
> -	/* ACPI uses hundredths of milliseconds units */
> -	ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
> -	if (ret)
> -		dev_warn(chip->parent,
> -			 "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
> -			 pin, ret);
> +	acpi_set_debounce_timeout(desc, agpio->debounce_timeout);
>  
>  	return desc;
>  }
> @@ -1025,10 +1030,7 @@ int acpi_dev_gpio_irq_wake_get_by(struct acpi_device *adev, const char *con_id,
>  			if (ret < 0)
>  				return ret;
>  
> -			/* ACPI uses hundredths of milliseconds units */
> -			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> -			if (ret)
> -				return ret;
> +			acpi_set_debounce_timeout(desc, info.debounce);
>  
>  			irq_flags = acpi_dev_get_irq_type(info.triggering,
>  							  info.polarity);


