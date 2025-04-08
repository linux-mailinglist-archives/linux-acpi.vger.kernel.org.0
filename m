Return-Path: <linux-acpi+bounces-12872-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB5BA816BA
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 22:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2B23AD2A0
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 20:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D36241CA3;
	Tue,  8 Apr 2025 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="LNfxLNJK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91EA157A72;
	Tue,  8 Apr 2025 20:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143571; cv=none; b=mHGJ9zHh16z3YJiATrql8hvEJ0IIM5dIJXgWN6EfBA2u4COTswJWsFKMvHIB0pfBumhfBgbCOqqx0H0XEgY4+cbbkQEfBg9TieLp5P2fbEQeH5IeEbwXulLLdGgy6MRkLREGvbMQAAkoxa0FLtJUvGqOmxNQd6jj9UzHQ6Tucls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143571; c=relaxed/simple;
	bh=8DxBHdaCsnQq1alPWYBxe7geh2qcYCwnyHzf4Mu7E6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4MrcFXw/zuUqh6cYNaV06Thryelr1g39sbCOMgKYodqRh5HOrZmrpvR7QbNcb9V5KnHTyy0QbC42CBuGoNTcBdedtky7KecMqW1nP9iO0r0+wlmjg9akA3VKCX9EGa0hOKmo1BQj79p37inaSVGJeDp9rEsGkkE5Ecw93kkeA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=LNfxLNJK; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1744142967; bh=8DxBHdaCsnQq1alPWYBxe7geh2qcYCwnyHzf4Mu7E6Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LNfxLNJKXkH4rrx0+HEkW33W8OLwXaAWNjn6Q6heeWmxFDVUf+OI82EdBCMaB7Gr0
	 qeaiuK6571AXAm1NneWny8lguRtVuqZrB1zG1RxrHTw5ZdoyK5Zd6fcSlPphQOjgU7
	 QmI1PLX1Ar7OU2H9UA9GfBt+QvG/0wQupjjU1ksD1W8qmjgjSMk0qJrYQimo63a6em
	 93BnHDYutz7m+KRIS66cnN0xf7BdD0xjsX7MWSQ2cyrtGRT7x1BmuhHOctfmVujgfV
	 1QQJav7x9syS4hs81UjWcQYbqWhkUpkyANoUHQssdivIVOOR7WGBikLO8BcYwu5pFJ
	 NgjaikNkLPVr7iu8PkCgh7fu7b9gcR6mOi6MuH9vksg0C0RScx70CiGanQVG+7z5v+
	 V0c78nTiG9Ij0p3yw7OfVCLH8H1n3Fba01mnLZWsANVIp0UK6enG5LBiQAz5vc+MYp
	 Dy2sUYVx/+RBsAdmOJyFjiGBPgp6OWD73SDZsoas7/1eQyA+Gx4TI+KiblPozu4L+J
	 nptfzI1T82zK7BSJ/COy6ylYltczr6ttKKv593OkNvjZ6gMcPyoskELWDfd32ZO0C8
	 1RQZ/5OopDG9P2HLtG4Z3cdAuT6jKmkS+X5CtRO0/1DIu+4oeauTj+Je8hZEawldm1
	 dL4US5EsOwbTYcmKCJdFwnAk=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 7BFD51633EB;
	Tue,  8 Apr 2025 22:09:27 +0200 (CEST)
Message-ID: <9715c8dd-38df-48fd-a9d1-7a78163dc989@ijzerbout.nl>
Date: Tue, 8 Apr 2025 22:09:25 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] gpiolib: acpi: Deduplicate some code in
 __acpi_find_gpio()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20250403160034.2680485-1-andriy.shevchenko@linux.intel.com>
 <20250403160034.2680485-7-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <20250403160034.2680485-7-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Op 03-04-2025 om 17:59 schreef Andy Shevchenko:
> __acpi_find_gpio() calls two functions depending on the supplied con_id
> and possibility to fallback to _CRS lookup. Those functions have the same
> pieces of code that can be done only in one place. Do it so.
>
> This gives an impressive shrink of the generated code for x86_64:
>
> add/remove: 0/2 grow/shrink: 0/4 up/down: 0/-1204 (-1204)
> Function                                     old     new   delta
> acpi_find_gpio.__UNIQUE_ID_ddebug478          56       -     -56
> acpi_dev_gpio_irq_wake_get_by.__UNIQUE_ID_ddebug480      56       -     -56
> acpi_find_gpio                               354     216    -138
> acpi_get_gpiod_by_index                      456     307    -149
> __acpi_find_gpio                             877     638    -239
> acpi_dev_gpio_irq_wake_get_by                695     129    -566
> Total: Before=15358, After=14154, chg -7.84%
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/gpio/gpiolib-acpi.c | 101 +++++++++++++++++-------------------
>   1 file changed, 48 insertions(+), 53 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index f44d25df15cb..b3fcb9d5a39f 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> [...]
> @@ -983,17 +966,24 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
>   		 bool can_fallback, struct acpi_gpio_info *info)
>   {
>   	struct acpi_device *adev = to_acpi_device_node(fwnode);
> +	struct acpi_gpio_lookup lookup;
>   	struct gpio_desc *desc;
>   	char propname[32];
> +	int ret;
> +
> +	memset(&lookup, 0, sizeof(lookup));
> +	lookup.params.crs_entry_index = idx;
>   
>   	/* Try first from _DSD */
>   	for_each_gpio_property_name(propname, con_id) {
>   		if (adev)
> -			desc = acpi_get_gpiod_by_index(adev,
> -						       propname, idx, info);
> +			ret = acpi_get_gpiod_by_index(adev, propname, &lookup);
>   		else
> -			desc = acpi_get_gpiod_from_data(fwnode,
> -							propname, idx, info);
> +			ret = acpi_get_gpiod_from_data(fwnode, propname, &lookup);
> +		if (ret)
> +			continue;
> +
> +		desc = lookup.desc;
>   		if (PTR_ERR(desc) == -EPROBE_DEFER)
>   			return desc;
>   
> @@ -1002,8 +992,13 @@ __acpi_find_gpio(struct fwnode_handle *fwnode, const char *con_id, unsigned int
>   	}
>   
>   	/* Then from plain _CRS GPIOs */
> -	if (can_fallback)
> -		return acpi_get_gpiod_by_index(adev, NULL, idx, info);
> +	if (can_fallback) {
> +		ret = acpi_get_gpiod_by_index(adev, NULL, &lookup);
> +		if (ret)
> +			return ERR_PTR(ret);
> +
> +		return lookup.desc;
> +	}
>   
>   	return ERR_PTR(-ENOENT);
>   }
Please, check the changes in this function again.
`__acpi_find_gpio` doesn't fill `info` anymore. The callers of this 
function will continue with
an uninitialized struct.
-- 
Kees

