Return-Path: <linux-acpi+bounces-12984-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2960A8656C
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 20:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CFB4E260B
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Apr 2025 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63C425949A;
	Fri, 11 Apr 2025 18:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b="MOJtHNJ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bout3.ijzerbout.nl (bout3.ijzerbout.nl [136.144.140.114])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7D8BEA;
	Fri, 11 Apr 2025 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.144.140.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395781; cv=none; b=m6iyXq1QVULZztRTx+Mk3fG6kDRATbARyx79KD9ve+WU/efmwnGCASwwL7csjQl+ZExy0ejtFOetCrNnYBzZErQQqlzb4rFilpfD9RNewMPmFh3RZ3YOJnH6GzbTNDxOg5LzjQMMJhvshvwh7pW4Jkd/30K0uTcIVgucS8cfN98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395781; c=relaxed/simple;
	bh=hU1s2MUharV+JZ/o7ZGxIzde3SPrYoBUq97/n8uSb2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JKuOXjdL5aJNElTMLptliezSQqBDGoVIIBazTMf1/5a+NelPltu7+Dvh4NXthCWhqyCvBo7mJgO0PjGqepCao6txTqtt0rdjmr1NCSl4flsrm4j2kWOsVyu4QGVucnpUjUqbuKZOPJTq03YOUr4WJ3ZfankYGYbamwXn/qc9jYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl; spf=pass smtp.mailfrom=ijzerbout.nl; dkim=pass (4096-bit key) header.d=ijzerbout.nl header.i=@ijzerbout.nl header.b=MOJtHNJ8; arc=none smtp.client-ip=136.144.140.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ijzerbout.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ijzerbout.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ijzerbout.nl; s=key;
	t=1744395768; bh=hU1s2MUharV+JZ/o7ZGxIzde3SPrYoBUq97/n8uSb2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MOJtHNJ84XRDBxnVQB8WQ1itTQrapZnb9yZMoagXLZ/o5UUfuQEhp2S6hRjJm4khh
	 6TJ66jf2dHD34WIXLEh0GBZyc9tMNU95j3f3Mx2JEwdwaSHhSKeHLro3LPt0A15q54
	 bP0qe2lclj6gpPSe2rHHxzQ6N6BzWs2L5qAIaFOUGTfWiffBleYN0vKkeQH7NSNqH2
	 pab+dtYSF5kqYrC1ionbLYzkcx/RKzoWMuRM2zc6YHN7F7HYgi9w+6fcrjRthMWt/q
	 GhEq5rysYviHJPcH/IcCGYUkofQM+JPRr0aghNPnpyBT9rj/CnEzsAdspA0hLj611E
	 PFgD6FuP4JoolBBv7iRk9Huil3yIldFEpg6yn1/wgfe0MHWYXGWWcb8WdOGlpt1WSb
	 u7zJwC/SZYKPEjZ2gPSsqjxP4k4kXCuOq/4n03c+JMXiJjlH0v2bVGrhTMwqexL/cC
	 AOsa2vjigand3nGTKeoT4Tavlg5/l6BHmpzExQL47AcBMZEhnx7A89glS9n1ROm+yp
	 qhgRD+gONPDfZzrSJ4mz/1wGRunuibTdn8lvvK+iYR03+brssPhPCvOxmnIyFDPHpN
	 YFrh0+1L6ILiaz25AUKhKFpa5RgX4DEcmEiGuaz3zkFwhkbWiBQersl3+yNKLR9VYO
	 EKm2oXg3oYvWFqTWBXlf7uDs=
Received: from [IPV6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a] (racer.ijzerbout.nl [IPv6:2a10:3781:99:1:1ac0:4dff:fea7:ec3a])
	by bout3.ijzerbout.nl (Postfix) with ESMTPSA id 9227F163653;
	Fri, 11 Apr 2025 20:22:48 +0200 (CEST)
Message-ID: <4793eafb-bd9c-4857-a020-944fdb97fb9e@ijzerbout.nl>
Date: Fri, 11 Apr 2025 20:22:41 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] gpiolib: acpi: Make sure we fill struct
 acpi_gpio_info
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
References: <20250409132942.2550719-1-andriy.shevchenko@linux.intel.com>
 <20250409132942.2550719-3-andriy.shevchenko@linux.intel.com>
 <98ded07e-33e4-417c-8146-fbf2783a7464@ijzerbout.nl>
 <Z_gQyg_JXTBRjisf@surfacebook.localdomain>
Content-Language: en-US
From: Kees Bakker <kees@ijzerbout.nl>
In-Reply-To: <Z_gQyg_JXTBRjisf@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Op 10-04-2025 om 20:41 schreef Andy Shevchenko:
> Wed, Apr 09, 2025 at 08:16:59PM +0200, Kees Bakker kirjoitti:
>> Op 09-04-2025 om 15:27 schreef Andy Shevchenko:
> ...
>
>> Can you check and confirm that at least info.gpioint is filled in (or
>> initialized)?
> Yes, I can confirm this. And that's how I have tested it, on Intel
> Edison/Arduino the first GPIO expander (PCAL9555, serviced by
> drivers/gpio/gpio-pca953x.c) is able to deliver an interrupt to the SoC.
>
> Before this series that doesn't show up, now it works as expected.
>
>> The callers of `__acpi_find_gpio` pass in an uninitialized `struct
>> acpi_gpio_info`
> True.
>
>> and after the call they read `info.gpioint`.
> ...when GPIO descriptor is valid.
>
> ...
>
> Yes, I agree that NULLifying info maybe good to have, but I don't see currently
> if we have bugs with it. Can you be more specific in case you have observed
> anything wrong?
Thanks for confirming.
I have nothing specific, just manually reviewing the (new) patch.
So, I guess this code in `acpi_populate_gpio_lookup` takes care of it.
         lookup->desc = desc;
         info->pin_config = agpio->pin_config;
         info->debounce = agpio->debounce_timeout;
         info->gpioint = gpioint;
         info->wake_capable = acpi_gpio_irq_is_wake(&info->adev->dev, 
agpio);
That would sound plausible.
-- 
Kees


