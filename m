Return-Path: <linux-acpi+bounces-15812-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD9B2AFE8
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 20:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644FB2A8403
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 18:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1B258ED7;
	Mon, 18 Aug 2025 18:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzwHpqku"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB225394B;
	Mon, 18 Aug 2025 18:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755540230; cv=none; b=tslvAffFWAFp7Fufo2vWoBYekq8JOAmFGi0a9Eqw4/3eunEoHDlwFhMDjZmKqrnOK2IN432lPJJcgm5A51FPUQDgoyDM0/zh2yE16dyHAnpT5r0I/ElT1qXRJtoE3Tg3Tv+U3KdjQgykO3hMMHkJUI8tAJkoV0oy2TIDiK6PMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755540230; c=relaxed/simple;
	bh=RaifyCQZpnzEq7EU2wCA2MNVN2r9uqWOvMcgjy+wcDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdWCK1nGMjrfv9mZxoR+B9c9447XPr3sUfaez5wsg2y+j3tE2Gq6gN/MNfCsd+QuKGTKYWuGo+X44FGTC4BZA2wpoPJ4WMruuK2chQgoAritJT33huXeKVA06FnNF4lIj8Sc+sHWMvy3piA6k0tmVhSYDwVSwZdFV9uXtH28MtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzwHpqku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A12C4CEEB;
	Mon, 18 Aug 2025 18:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755540229;
	bh=RaifyCQZpnzEq7EU2wCA2MNVN2r9uqWOvMcgjy+wcDU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tzwHpqku9YLK8zxrqus3OwkhNBtSaBRU/Hb1+WxGFpoPEHayUkzjBqVfLcXzxXrxT
	 9ah55lc99qT0MQkbvz9LtgRU8KI+lMINLnw8Tu2g9/yjEe3b3rI+NwuSxcMFpoPnP+
	 lsTNWOdllDS/5jy6O/Ck2jE0Snf0VNht3O89cAHVJxxT44m50iRYn4JpljQFChzQiv
	 aygrOID+wHOJwoc7okLev9oRmD3nonup9mMwnuwNYLUtDzhnLUeux9DjMHxCB7vZFM
	 QNqMIHZvmY0jIbFup3IJdcOD7odTD9+NZVMus290qkCWi2z+6XSgtRLegCgpjrAdsf
	 ZsZgrkRQmC3iA==
Message-ID: <08dd199e-0e7d-44b8-b980-5fde226cd636@kernel.org>
Date: Mon, 18 Aug 2025 13:03:48 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Program debounce when finding GPIO
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: mario.limonciello@amd.com, westeri@kernel.org,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org, brgl@bgdev.pl,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20250818015219.3604648-1-superm1@kernel.org>
 <20250818045538.GH476609@black.igk.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20250818045538.GH476609@black.igk.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/25 11:55 PM, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Aug 17, 2025 at 08:52:07PM -0500, Mario Limonciello (AMD) wrote:
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
> 
> The spec says for GpioInt():
> 
>    DebounceTimeout is an optional argument specifying the debounce wait
>    time, in hundredths of milliseconds. The bit field name _DBT is
>    automatically created to refer to this portion of the resource
>    descriptor.
> 
> I was not sure but wanted to check that if it is left out, does ACPICA fill
> it with 0? If yes (I would expect so) then this is fine.

Yeah AFAICT you're right.  The ACPI resource is zero'ed out, so if the 
field was empty it should default to zero.

> 
>> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>> v4:
> 
> You missed "v4" in the $subject.

Whoops, thanks.  If there ends up being a reason to spin I'll send the 
next one as a v5.

> 
>>   * Just add a direct call instead
>>   * drop tag
>>   * update commit message
>> ---
>>   drivers/gpio/gpiolib-acpi-core.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpio/gpiolib-acpi-core.c b/drivers/gpio/gpiolib-acpi-core.c
>> index 12b24a717e43f..6388e8e363dee 100644
>> --- a/drivers/gpio/gpiolib-acpi-core.c
>> +++ b/drivers/gpio/gpiolib-acpi-core.c
>> @@ -944,6 +944,7 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>>   	bool can_fallback = acpi_can_fallback_to_crs(adev, con_id);
>>   	struct acpi_gpio_info info;
>>   	struct gpio_desc *desc;
>> +	int ret;
>>   
>>   	desc = __acpi_find_gpio(fwnode, con_id, idx, can_fallback, &info);
>>   	if (IS_ERR(desc))
>> @@ -957,6 +958,11 @@ struct gpio_desc *acpi_find_gpio(struct fwnode_handle *fwnode,
>>   
>>   	acpi_gpio_update_gpiod_flags(dflags, &info);
>>   	acpi_gpio_update_gpiod_lookup_flags(lookupflags, &info);
>> +	/* ACPI uses hundredths of milliseconds units */
>> +	ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
>> +	if (ret)
>> +		return ERR_PTR(ret);
>> +
>>   	return desc;
>>   }
>>   
>> -- 
>> 2.43.0


