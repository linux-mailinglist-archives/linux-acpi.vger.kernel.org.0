Return-Path: <linux-acpi+bounces-14630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2B4AE8DA6
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 21:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A597A5EC0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A1E2E9EB4;
	Wed, 25 Jun 2025 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkirKdIu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A022DECDA;
	Wed, 25 Jun 2025 18:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750877919; cv=none; b=jkFTPRm/GGj6ID8O+cy3eiauwpnrId4PBCBXZ/Q3h8Qt5hQO1KdZdkQSIzlNds5+0M4OsB7cgkJqDfN90KRAMmou6unZ8cWVBMFaGItoCLbjRIKZgUEYYAGPyQSsB9laM59aVU7OIZXgknCqPXUDWr/kcOHtb0SjY+CWXWHKfFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750877919; c=relaxed/simple;
	bh=1F7cHi0zdFkUjQtQvOihS+a8sD0TCE1tJFcjKn/2wIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RyBEOFNGyX0f6VTqhQOhkNEBOynouRTWD3YlPdE0ZYrPSSWp1gjWFhGJbOK7GdBZHLcpclsdHJRlK730SystYq43WycF8bg5Q3Nvpu0NVnyMZddJXI1RX2Rks9ExU0WeVmW+3PbbbtIMGZF5ADCDP37juQf6gKSxoDtR7lIy4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkirKdIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73720C4CEF4;
	Wed, 25 Jun 2025 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750877918;
	bh=1F7cHi0zdFkUjQtQvOihS+a8sD0TCE1tJFcjKn/2wIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jkirKdIu7ZMIwfYhSJchhl36UCyPaf3xu7UtXWACXpg+9oW86ZrU73CDLIwtkh61s
	 oPzUs+Ejol37osnL0mmT4n5WgTRVBZCLSPK6CNh+IOAEDaJnvRfzJZXzC9DFGB9loO
	 B759nDbQbt3eQboy2obZ9dxkh9pC/U6/nqVUZgCvw/c8t3yDYFXz2kE/witvEptNb7
	 wnSoJqRVd0xi4SUtkO5S7QMm884AYniM2YJHoalbcpMv0V3FW/N3xk/vXUuyzYjCAh
	 Sq+/4MVz7l9rTL0niyg95mRkkHpj1GaMgvxyKvZTXkKtstiwTY9Pt/oP3eyTs8Ni+x
	 WmoYR0WZ2ednQ==
Message-ID: <817fec2c-a9c0-4cbf-9d7a-714a0f752eb3@kernel.org>
Date: Wed, 25 Jun 2025 20:58:34 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] gpiolib: acpi: Program debounce when finding GPIO
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
 <20250625181342.3175969-3-superm1@kernel.org>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250625181342.3175969-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 25-Jun-25 8:13 PM, Mario Limonciello wrote:
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

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
> v2:
>  * Make non fatal by using helper from patch 1 (Andy)
> ---
>  drivers/gpio/gpiolib-acpi-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
> index 1895e45bd9f16..15222bfc25bb2 100644
> --- a/drivers/gpio/gpiolib-acpi-core.c
> +++ b/drivers/gpio/gpiolib-acpi-core.c
> @@ -962,6 +962,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>  
>  	acpi_gpio_update_gpiod_flags(dflags, &info);
>  	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
> +	acpi_set_debounce_timeout(desc, info.debounce);
>  	return desc;
>  }
>  


