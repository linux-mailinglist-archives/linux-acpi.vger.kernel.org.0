Return-Path: <linux-acpi+bounces-14631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC28AE8DFA
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:08:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB34A7B0846
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 19:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774B42DCC1B;
	Wed, 25 Jun 2025 19:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M18Pgbvz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4781B2DA752;
	Wed, 25 Jun 2025 19:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878242; cv=none; b=ANfIA4sfNFrvtbv75HB24Kpc4zXQey5zGe/MSBILtaO4KOMSRXLBEHoVHJe/lvX5iLrBvT+Qp9R89hqKJjy21nT62VNffPqFA3srM/UQyi84sucKSd4tUfD0ulyTEntZWQjVOSO50mGxSl2mw3+fDffIN91tOnBylY4szK6KjC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878242; c=relaxed/simple;
	bh=AVNgT0uZYuL7fGENFceaiSlLmc1/7qinR+ZKMhGYmbM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0qzhanogsxdDCb2vwDewiqfUrTI4oUddwMPl+eFMkM0kKJnGeu5OuKCuAWmnEmmkrBVLfoL3k2QtUQZWHvOpo8dPJGbfxqCHFB108H+s5a59FAn5wrGJvFw77PHxmB8hTRrB34OPTUKEbOfdQHzNdk60PXNJEUh18m1z1SCjmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M18Pgbvz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1BFC4CEEA;
	Wed, 25 Jun 2025 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750878241;
	bh=AVNgT0uZYuL7fGENFceaiSlLmc1/7qinR+ZKMhGYmbM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=M18PgbvzZRWM/kK+gtLvtfS3R44wAk2YabfWVehw3jxuBd7lt9DCq0ZECSOc2cuh6
	 qRWNj1Pg6TCmOuBrG8Bn44ucPG0Q1F7Xm7N4Wtr6H8ofzMCXMN5ylNhIudUhCmWWur
	 5UiDCox0H5ubxp9eClt9grFW9GgiYDpRV7mL7gTwENw6i8jmqRytQ2MnVAvqn70iHl
	 XKMIGaH+A961GH1E8u9+hQDPyzJpN4ux+nI96Zibr27cPiW5x3MN3alsnlvVyndTpi
	 JReZ4xCtmmdS6yaplplSwNzJW8LTh6uPKNLLiWX8SX2Vu6pbtduOPfXydK9QTwKf1f
	 zQIhgyH79P0tw==
Message-ID: <f5e1d50f-d85e-45a3-a131-f2da603c620c@kernel.org>
Date: Wed, 25 Jun 2025 21:03:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] Input: soc_button_array: Only debounce cherryview
 and baytrail systems
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
 <20250625181342.3175969-4-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250625181342.3175969-4-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> commit 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> hardcoded all soc-button-array devices to use a 50ms debounce timeout
> but this doesn't work on all hardware.  The hardware I have on hand
> actually prescribes in the ASL that the timeout should be 0:
> 
> GpioInt (Edge, ActiveBoth, Exclusive, PullUp, 0x0000,
>          "\\_SB.GPIO", 0x00, ResourceConsumer, ,)
> {   // Pin list
>     0x0000
> }
> 
> Many cherryview and baytrail systems don't have accurate values in the
> ASL for debouncing and thus use software debouncing in gpio_keys. The
> value to use is programmed in soc_button_array.  Detect Cherry View
> and Baytrail using ACPI HID IDs used for those GPIO controllers and apply
> the 50ms only for those systems.
> 
> Cc: Hans de Goede <hansg@kernel.org>
> Fixes: 5c4fa2a6da7fb ("Input: soc_button_array - debounce the buttons")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

I'm not a fan of this approach, I believe that we need to always debounce
when dealing with mechanical buttons otherwise we will get unreliable /
spurious input events.

My suggestion to deal with the issue where setting up debouncing at
the GPIO controller level is causing issues is to always use software
debouncing (which I suspect is what Windows does).

Let me copy and pasting my reply from the v1 thread with
a bit more detail on my proposal:

My proposal is to add a "no_hw_debounce" flag to 
struct gpio_keys_platform_data and make the soc_button_array
driver set that regardless of which platform it is running on.

And then in gpio_keys.c do something like this:

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index f9db86da0818..2788d1e5782c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -552,8 +552,11 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bool active_low = gpiod_is_active_low(bdata->gpiod);
 
 		if (button->debounce_interval) {
-			error = gpiod_set_debounce(bdata->gpiod,
-					button->debounce_interval * 1000);
+			if (ddata->pdata->no_hw_debounce)
+				error = -EINVAL;
+			else
+				error = gpiod_set_debounce(bdata->gpiod,
+						button->debounce_interval * 1000);
 			/* use timer if gpiolib doesn't provide debounce */
 			if (error < 0)
 				bdata->software_debounce =

So keep debouncing, as that will always be necessary when dealing with
mechanical buttons, but always use software debouncing to avoid issues
like the issue you are seeing.

My mention of the BYT/CHT behavior in my previous email was to point
out that those already always use software debouncing for the 50 ms
debounce-period. It was *not* my intention to suggest to solve this
with platform specific quirks/behavior.

Regards,

Hans




> ---
> v2:
>  * commit message
>  * quirk systems instead of revert
> ---
>  drivers/input/misc/soc_button_array.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
> index b8cad415c62ca..56abc93f23e0c 100644
> --- a/drivers/input/misc/soc_button_array.c
> +++ b/drivers/input/misc/soc_button_array.c
> @@ -129,6 +129,13 @@ static const struct dmi_system_id dmi_invalid_acpi_index[] = {
>  	{} /* Terminating entry */
>  };
>  
> +static const struct acpi_device_id force_software_debounce_ids[] = {
> +	{ "INT33FF" },
> +	{ "INT33B2" },
> +	{ "INT33FC" },
> +	{ }
> +};
> +
>  /*
>   * Get the Nth GPIO number from the ACPI object.
>   */
> @@ -149,11 +156,17 @@ static int soc_button_lookup_gpio(struct device *dev, int acpi_index,
>  	return 0;
>  }
>  
> +static int soc_button_match_acpi_device_ids(struct device *dev, const void *data)
> +{
> +	return acpi_match_device(data, dev) ? 1 : 0;
> +}
> +
>  static struct platform_device *
>  soc_button_device_create(struct platform_device *pdev,
>  			 const struct soc_button_info *button_info,
>  			 bool autorepeat)
>  {
> +	struct device *quirkdev __free(put_device) = NULL;
>  	const struct soc_button_info *info;
>  	struct platform_device *pd;
>  	struct gpio_keys_button *gpio_keys;
> @@ -181,6 +194,10 @@ soc_button_device_create(struct platform_device *pdev,
>  	if (dmi_id)
>  		invalid_acpi_index = (long)dmi_id->driver_data;
>  
> +	quirkdev = bus_find_device(&platform_bus_type, NULL,
> +				   force_software_debounce_ids,
> +				   soc_button_match_acpi_device_ids);
> +
>  	for (info = button_info; info->name; info++) {
>  		if (info->autorepeat != autorepeat)
>  			continue;
> @@ -220,7 +237,8 @@ soc_button_device_create(struct platform_device *pdev,
>  		gpio_keys[n_buttons].desc = info->name;
>  		gpio_keys[n_buttons].wakeup = info->wakeup;
>  		/* These devices often use cheap buttons, use 50 ms debounce */
> -		gpio_keys[n_buttons].debounce_interval = 50;
> +		if (quirkdev)
> +			gpio_keys[n_buttons].debounce_interval = 50;
>  		n_buttons++;
>  	}
>  


