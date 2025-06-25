Return-Path: <linux-acpi+bounces-14581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F87AE7B57
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD65162100
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 09:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC07D28ECEF;
	Wed, 25 Jun 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuZCt9yX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB9285CBD;
	Wed, 25 Jun 2025 09:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750842127; cv=none; b=gc6HAtkMzk8BE3SI5MKQ59gPYDVY6Yj4+FfD3UpysM5mkC5T+AsdJ7GteHu3wUxtSKFk4HfYk1ZGg9or/oeeg+ezphzfEZLK6pTC+bHugqQviyTXb8YWjwqCS7WthvbGqK7Y7ZBB9PA9LTBE9zPeXjcYLFg9fGwBXawCD9nCzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750842127; c=relaxed/simple;
	bh=1W7arUVBB1d15aM5ROHQioZU9ZN5vTbbjFufqTMljjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgu+yErlp1k5B7chxZp+U980JXDQpgdhcYKjCTPIZRf9LPu4PNp8AMKYimIaYctFWdJe0TlWVB1ACXh6XVFjd0hMhW/Zxhjf2Rk3MDv8qAnftEo5j5pDxGMVhblCS9kkX7/dLU4hFb1FSftztZd52BYPWDzZGuiKFo8i1f7Gsr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuZCt9yX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407C7C4CEEA;
	Wed, 25 Jun 2025 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750842127;
	bh=1W7arUVBB1d15aM5ROHQioZU9ZN5vTbbjFufqTMljjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NuZCt9yXs3wPNf5vWm1VKzHQk2Xsdu2t355zrjpHl3z7VDgv/9R4whsVEFtVjGeov
	 Ll3QlWDSXyZo6H3mZMA8+tC2bu2Xp5ytUln7P2i33ZwvYD6Z1WpCa3FwVR6fBzz4jh
	 dUhZ1LKeBEMcp3/85ZGZP2daRCfl3w6nuTlVgqtZ+w9Wvc/9GR8OAr5brHEtIvlTaa
	 +N6nVA2GoKuFW/YoGnvxBCgQd4vdIMf5uYC/AaHwHatYlqEQqlrgVCxUvyI4Ku2bgS
	 dt+sqrlWl27aQeiOKU7f0FRCflB3LLNvFmkFTQLYXScpgVHhlCmxI6KyqE2TweJJ/B
	 W3tAqYOhTz2LQ==
Message-ID: <3f653a9f-e838-4298-9758-95e6fbec52bb@kernel.org>
Date: Wed, 25 Jun 2025 11:02:03 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpiolib: acpi: Program debounce when finding GPIO
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
References: <20250624202211.1088738-1-superm1@kernel.org>
 <20250624202211.1088738-2-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250624202211.1088738-2-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mario,

On 24-Jun-25 10:22 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> When soc-button-array looks up the GPIO to use it calls acpi_find_gpio()
> which will parse _CRS.
> 
> acpi_find_gpio.cold (drivers/gpio/gpiolib-acpi-core.c:953)
> gpiod_find_and_request (drivers/gpio/gpiolib.c:4598 drivers/gpio/gpiolib.c:4625)
> gpiod_get_index (drivers/gpio/gpiolib.c:4877)
> 
> The GPIO is setup basically, but the debounce information is discarded.
> The platform will assert what debounce should be in _CRS, so program it
> at the time it's available.
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpio/gpiolib-acpi-core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 12b24a717e43f..475cac2d95aa1 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
>  	struct acpi_gpio_info info;
>  	struct gpio_desc *desc;
> +	int ret;
>  
>  	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
>  	if (IS_ERR(desc))
> @@ -957,6 +958,9 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  
>  	acpi_gpio_update_gpiod_flags(dflags, &info);
>  	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
> +	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
> +	if (ret)
> +		return ERR_PTR(ret);

IIRC this is going to fail sometimes, depending on which range of
debounce values the GPIO controller support. Note that there already
is another code-path in gpiolib-acpi-core.c which calls
gpio_set_debounce_timeout() in acpi_request_own_gpiod() and it does:

        /* ACPI uses hundredths of milliseconds units */
        ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
        if (ret)
                dev_warn(chip->parent,
                         "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
                         pin, ret);

Making this a warning was done in commit cef0d022f553 ("gpiolib: acpi: Make
set-debounce-timeout failures non fatal").

Otherwise I think this is fine.

Regards,

Hans



