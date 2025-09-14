Return-Path: <linux-acpi+bounces-16883-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A16B7B56AF1
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 19:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CF343B40A4
	for <lists+linux-acpi@lfdr.de>; Sun, 14 Sep 2025 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1352D2388;
	Sun, 14 Sep 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHrfhfVf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5233E1E7C11;
	Sun, 14 Sep 2025 17:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757872372; cv=none; b=MrnhGYgY7kEYSEImMjGoD9LG63o/VLpp3HtkGHiCj+z7tH12cyKB6aaNVka4v7q8Ic5zvaxDHYpDtCmp+QOI8z0YDfjJt3FbLRsAKcqI45WXwjzbLV+iEr1hT5b8CqaP0IC3xheKDiveouQnfpbUjnbJwYRvdZnm1/J0w8GOUJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757872372; c=relaxed/simple;
	bh=pYfF65mRAiqT7mXscm/JqIz2wg/wVSFsEQqnnaVhr+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gggdfcs88pGpa0QxWkOAJIOgcCm6MfIGDEVoYCtnnAq4g5HG59grmgl9u+ZAindmYkw0ZRFpcVvBxH17Ac77k4WmofG9cUTFDgW67Ojhp4WvZcBydlxT7dXcUmoHQCHIHDRkYlfXyIjBEpbFn3/NKL6QxppuFGRclmVRXdYvoYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHrfhfVf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA8EC4CEF0;
	Sun, 14 Sep 2025 17:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757872371;
	bh=pYfF65mRAiqT7mXscm/JqIz2wg/wVSFsEQqnnaVhr+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AHrfhfVfZebTL/3Zz/0uv8pEIaNGP+UpZ03WmGEARcrocMnbNWcIsQgD6PhU9Wlyk
	 zjCwD3AhlwWNvt8Pr0CNdcFOtl8Xv0UrbFdUdpUXyGypboRuXa/7YXppx8ikjWgucM
	 xlgi2atl/jkB6KFwiPIU4ZI8yVSQfRBu75PmB42BTbIK7/lD59Q3mRFLiM6ck2WS1D
	 K89hd5T6qV6TvHW+x0+Hbl8q1deywwIkxlfJFCXIPgq63SA4rI+AHETTu8SpmhzRDW
	 8hTwaLd1AVWzN2z5WAX9vA3xlsSlQDLCHjHQ85bxf8UdBP5Zk02j28VMKzcp+hJjdv
	 2sIF8ibDVjLQw==
Message-ID: <a73231f0-0636-45e5-a390-2fd74e192c83@kernel.org>
Date: Sun, 14 Sep 2025 19:52:48 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.17 REGRESSION FIX] gpiolib: acpi: Fix using random stack
 memory during GPIO lookups
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij
 <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org
References: <20250912221859.368173-1-hansg@kernel.org>
 <CAHp75VeOAuhQC2xZxSJ_9hedNzGXdmmeAeoahnKBSR-K9UP3mQ@mail.gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <CAHp75VeOAuhQC2xZxSJ_9hedNzGXdmmeAeoahnKBSR-K9UP3mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Andy,

On 14-Sep-25 3:24 PM, Andy Shevchenko wrote:
> On Sat, Sep 13, 2025 at 1:19 AM Hans de Goede <hansg@kernel.org> wrote:
>>
>> Before commit 8b4f52ef7a41 ("gpiolib: acpi: Deduplicate some code in
>> __acpi_find_gpio()") and the follow-up fix commit 7c010d463372 ("gpiolib:
>> acpi: Make sure we fill struct acpi_gpio_info"). The struct acpi_gpio_info
>> used during lookups was part of struct acpi_gpio_lookup which gets
>> memset() to 0 before use.
>>
>> And then after a successful lookup, acpi_gpio_resource_lookup() would
>> copy the content of the zeroed acpi_gpio_lookup.info to the on
>> stack struct acpi_gpio_info in __acpi_find_gpio(), overwriting any
>> uninitialized memory contents there.
>>
>> But now instead a pointer to the on stack struct acpi_gpio_info in
>> __acpi_find_gpio() is passed around, but that struct is never
>> initialized.
>>
>> This passing around of the uninitialized struct breaks index based
>> lookups of GpioInt GPIOs because info->quirks now contains some random
>> on stack data which may contain ACPI_GPIO_QUIRK_ONLY_GPIOIO.
>>
>> Initialize the on stack struct acpi_gpio_info to 0 to fix this.
> 
> Ah, very good catch! I missed that field that can have garbage as we
> don't file it. I'll take it on Monday and prepare a PR next week.

Thank you, but please take the more complete fix from Sébastien
available here:

https://lore.kernel.org/linux-gpio/20250912-gpiolib-acpi-fix-v1-1-1a41acbffadf@armadeus.com/

That also initializes a second case of an uninitialized
struct acpi_gpio_info on the stack.

Regards,

Hans




