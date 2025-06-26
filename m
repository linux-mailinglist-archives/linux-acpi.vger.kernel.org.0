Return-Path: <linux-acpi+bounces-14672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6624EAE9846
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D73B4635
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5867025E46A;
	Thu, 26 Jun 2025 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSnP3GMD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F11206F23;
	Thu, 26 Jun 2025 08:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926427; cv=none; b=fRDo3bztdjdEyt+f7NfTgn6sHJtgkQQUwRIsaxtfk1Ox67NWyH9IZ24WJlzhtd9gz7O1HWCR4lm5AWcQlNK4x7ZSARCphwX93Uux5Q7dZorhLxgm3vlLUeyQ6Qz5TsmxrXolFRVqD4Fypjzp1R8xt0BMVNW0k9f1264RMe4589s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926427; c=relaxed/simple;
	bh=S7XC0tUcCHKvkT+Ed0WOUsQ6fokGOML9A7PYuyOW2Js=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oWMFpAOxw8ey4b7R3VWlA3nMtCmDcvW03zzZyThE0XJKVunhsRxDIPzyRg5ehCArh0E7YhCmfqhp76clY2pYnfMGZc6cDU+beHxmD0ohwRBwIuOYv+w1uIVithFccqckooVxzq1v90JgQHEYtvwBYR1A/YGXo2GqDKjKCEFUvQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSnP3GMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4973AC4CEEB;
	Thu, 26 Jun 2025 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750926426;
	bh=S7XC0tUcCHKvkT+Ed0WOUsQ6fokGOML9A7PYuyOW2Js=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSnP3GMD0cNxXVox/QwHFndk0tVEsnIBiJSb/MkTiDKTc0rn69/+3Q/YS9Brvun73
	 637vfIkKFfd/6j7jMcmLHlqGYn5IlQqgC4h6wIjAerTblRWu1YBvGM+jQzNiqOuAtY
	 K1SzHvcR+nKc3HfJK4YionNXMtDavQ4BrChdt2hp6qopr0V+heN0T1JTiyM3bjCYn7
	 DpWEe9kAS8r/KCA4M/5/ZTMVCarDS+VZwZmCU7pR821lfGJ7le3fOV3x0ScBvP4j2g
	 A/A2M6x4L1LUX/9UlzDCNCrncH2fG5n+QOgM/dUXe/kBDJrOE36eq+3XErdgacayBb
	 KFIa8yGMmhQJw==
Message-ID: <61843beb-263d-475b-9876-fb273dd8d7fe@kernel.org>
Date: Thu, 26 Jun 2025 10:27:01 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] Input: Don't program hw debounce for
 soc_button_array devices
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
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-4-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250625215813.3477840-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 23:58, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> Programming a hardware debounce of 50ms causes problems where a button
> doesn't work properly anymore on some systems.  This debounce is intended
> for compatibility with systems with a mechanical switch so soc_button_array
> devices should only be using a sofware debounce.
> 
> Add support for indicating that a driver is only requesting gpio_keys
> to use software debounce support and mark that in soc_button_array
> accordingly.
> 
> Suggested-by: Hans de Goede <hansg@kernel.org>
> Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/input/keyboard/gpio_keys.c    | 7 +++++--
>  drivers/input/misc/soc_button_array.c | 1 +
>  include/linux/gpio_keys.h             | 2 ++
>  3 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index f9db86da0818b..773aa5294d269 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		bool active_low = gpiod_is_active_low(bdata->gpiod);
>  
>  		if (button->debounce_interval) {
> -			error = gpiod_set_debounce(bdata->gpiod,
> -					button->debounce_interval * 1000);
> +			if (ddata->pdata->no_hw_debounce)
> +				error = -EINVAL;
> +			else
> +				error = gpiod_set_debounce(bdata->gpiod,
> +							   button->debounce_interval * 1000);
>  			/* use timer if gpiolib doesn't provide debounce */
>  			if (error < 0)
>  				bdata->software_debounce =
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index b8cad415c62ca..dac940455bea8 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -232,6 +232,7 @@ soc_button_device_create(struct platform_device *pdev,
>  	gpio_keys_pdata->buttons = gpio_keys;
>  	gpio_keys_pdata->nbuttons = n_buttons;
>  	gpio_keys_pdata->rep = autorepeat;
> +	gpio_keys_pdata->no_hw_debounce = TRUE;
>  
>  	pd = platform_device_register_resndata(&pdev->dev, "gpio-keys",
>  					       PLATFORM_DEVID_AUTO, NULL, 0,
> diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
> index 80fa930b04c67..c99f74467fda6 100644
> --- a/include/linux/gpio_keys.h
> +++ b/include/linux/gpio_keys.h
> @@ -48,6 +48,7 @@ struct gpio_keys_button {
>   * @enable:		platform hook for enabling the device
>   * @disable:		platform hook for disabling the device
>   * @name:		input device name
> + * @no_hw_debounce:	avoid programming hardware debounce
>   */
>  struct gpio_keys_platform_data {
>  	const struct gpio_keys_button *buttons;
> @@ -57,6 +58,7 @@ struct gpio_keys_platform_data {
>  	int (*enable)(struct device *dev);
>  	void (*disable)(struct device *dev);
>  	const char *name;
> +	bool no_hw_debounce;
>  };
>  
>  #endif


