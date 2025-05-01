Return-Path: <linux-acpi+bounces-13409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F132DAA65DA
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 23:56:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5F451BA68D1
	for <lists+linux-acpi@lfdr.de>; Thu,  1 May 2025 21:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14442609D3;
	Thu,  1 May 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npRNF0Pp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F8D1A38E1;
	Thu,  1 May 2025 21:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746136555; cv=none; b=l0sSbPNed9aGvEzhQV0miH6q/j5CRJQiI5kd1y+XUopDU/r3ve+VaG0lQJWcxBRQ7wrTYQFjmZFPvg3Ww0StOLQZ9HqbFhsOvsiobW1qEEnWW5kSCb+OGNWDZaF/pW/9hkP+wTjwaa0ALpqnJ78j89FtGBY11YKjldMokDJVf40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746136555; c=relaxed/simple;
	bh=OpVGOOkuH9HXmfX+AhfIKK2CBjHEJP+az618HOIiJnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S9v48hM7qNGwNyEn3LBvwFX8I+Lt1P7ek6XpvXEHOTdqCqn2OB2+2kvM0BaIYrDJS2p0IiWYy+/9xOvhhnuFnq6shBR2KVAK3ukJZ92pliJtB/IX/V/kenlJVG2RDa8Vyb0ZTUDUlFjCfI2nQL/sNiEuhubQVKIfwqNv+DrrLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npRNF0Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6982BC4CEE4;
	Thu,  1 May 2025 21:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746136555;
	bh=OpVGOOkuH9HXmfX+AhfIKK2CBjHEJP+az618HOIiJnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=npRNF0Pp3q1qiDjY13OuiCbkpHdnKQMovftpEatfooNh1bfolkyOJywAz80Ht4PR9
	 qL/b2oQZpLoVVTIc4g0x1WNlOO15IA6l3jeeXlmz9Kko/MxfC/PqbQSxdx/VZGrQVQ
	 AmnU5W3sSqYafNCtx2w8pC9e6eCl1/8YGabaVpeiXeEF9li8H6/lEMU3aPHAF8QIsb
	 OMww+e/tdoH6vd+Ogp2zCyXRFhtADCkUnH+OXsxvlpZcYumighXiw57MOZDtObFJ9X
	 4v9XXs42h1ymVaFlkMItp7kdih0HOkpeMMlW9IJi7moyfzLYFjXGlmoD+wkPZLr/Mk
	 pvYGgUTGSWTYw==
Message-ID: <28f24040-ca37-47df-a4c3-b457f0218f3e@kernel.org>
Date: Thu, 1 May 2025 16:55:52 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] pinctrl: amd: Fix hibernation support with
 CONFIG_SUSPEND unset
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
References: <5889368.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5889368.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/2025 1:27 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After recent changes, pinctrl-amd will not support hibernation when
> CONFIG_HIBERNATION is set and CONFIG_SUSPEND isn't because it will not
> register amd_gpio_pm_ops then.
> 
> Address this by restoring dependencies on CONFIG_PM_SLEEP where
> necessary for hibernation support.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Mario, this is on top of:
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/20250414203551.779320-1-superm1@kernel.org/
> 
> which is currently in my bleeding-edge branch only.

Thanks!  This makes sense now why there was CONFIG_PM_SLEEP in the first 
place. 🤦

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> ---
>   drivers/pinctrl/pinctrl-amd.c |   63 ++++++++++++++++++++++++------------------
>   1 file changed, 36 insertions(+), 27 deletions(-)
> 
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -894,26 +894,7 @@
>   	}
>   }
>   
> -#ifdef CONFIG_SUSPEND
> -static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
> -{
> -	const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
> -
> -	if (!pd)
> -		return false;
> -
> -	/*
> -	 * Only restore the pin if it is actually in use by the kernel (or
> -	 * by userspace).
> -	 */
> -	if (pd->mux_owner || pd->gpio_owner ||
> -	    gpiochip_line_is_irq(&gpio_dev->gc, pin))
> -		return true;
> -
> -	return false;
> -}
> -
> -#ifdef CONFIG_ACPI
> +#if defined(CONFIG_SUSPEND) && defined(CONFIG_ACPI)
>   static void amd_gpio_check_pending(void)
>   {
>   	struct amd_gpio *gpio_dev = pinctrl_dev;
> @@ -936,8 +917,40 @@
>   static struct acpi_s2idle_dev_ops pinctrl_amd_s2idle_dev_ops = {
>   	.check = amd_gpio_check_pending,
>   };
> +
> +static void amd_gpio_register_s2idle_ops(void)
> +{
> +	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
> +}
> +
> +static void amd_gpio_unregister_s2idle_ops(void)
> +{
> +	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
> +}
> +#else
> +static inline void amd_gpio_register_s2idle_ops(void) {}
> +static inline void amd_gpio_unregister_s2idle_ops(void) {}
>   #endif
>   
> +#ifdef CONFIG_PM_SLEEP
> +static bool amd_gpio_should_save(struct amd_gpio *gpio_dev, unsigned int pin)
> +{
> +	const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
> +
> +	if (!pd)
> +		return false;
> +
> +	/*
> +	 * Only restore the pin if it is actually in use by the kernel (or
> +	 * by userspace).
> +	 */
> +	if (pd->mux_owner || pd->gpio_owner ||
> +	    gpiochip_line_is_irq(&gpio_dev->gc, pin))
> +		return true;
> +
> +	return false;
> +}
> +
>   static int amd_gpio_suspend_hibernate_common(struct device *dev, bool is_suspend)
>   {
>   	struct amd_gpio *gpio_dev = dev_get_drvdata(dev);
> @@ -1211,9 +1224,7 @@
>   
>   	platform_set_drvdata(pdev, gpio_dev);
>   	acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
> -#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> -	acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
> -#endif
> +	amd_gpio_register_s2idle_ops();
>   
>   	dev_dbg(&pdev->dev, "amd gpio driver loaded\n");
>   	return ret;
> @@ -1232,9 +1243,7 @@
>   
>   	gpiochip_remove(&gpio_dev->gc);
>   	acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
> -#if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
> -	acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
> -#endif
> +	amd_gpio_unregister_s2idle_ops();
>   }
>   
>   #ifdef CONFIG_ACPI
> @@ -1251,7 +1260,7 @@
>   	.driver		= {
>   		.name	= "amd_gpio",
>   		.acpi_match_table = ACPI_PTR(amd_gpio_acpi_match),
> -#ifdef CONFIG_SUSPEND
> +#ifdef CONFIG_PM_SLEEP
>   		.pm	= &amd_gpio_pm_ops,
>   #endif
>   	},
> 
> 
> 


