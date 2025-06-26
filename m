Return-Path: <linux-acpi+bounces-14700-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9561AEA329
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B528B1C28131
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 16:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425531E501C;
	Thu, 26 Jun 2025 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEof/ivM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B408632C;
	Thu, 26 Jun 2025 16:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953854; cv=none; b=NaCNhFRx4qdpgo2kzGq6CVAQnSZdvm9B35NCSBlNhYP88QrQX2KbCv6DI+fRp27A6N121H0q5KNfhylfmgDJIaZM653TArsntyOFBJQd4Lysz+0IRkkJtdfanFq2Cx6XnjID+CoWHbC7z22w70CQwyAc3J3G2jLSz2/JrsMsWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953854; c=relaxed/simple;
	bh=RDVQoL4sE82paXI00u0nyf0ncj3K2JAAIAgRoe++0BY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GfJmvUkHz8/J8nl49a67qDS9as6TiM7dDQtMZbN8//OLQRgzcBdm8iaV8+StV5S5M7+sB2zDHS8FrqRYIXR2x5oq64sUzpWmbgcNKk1NZCXb9nqFRfRh2R7DPoIjTmjHvkwE4xWh2+P4wEHbeDKGsNnGCcSip/jPmx3RGGwx6sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEof/ivM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9EFC4CEEB;
	Thu, 26 Jun 2025 16:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750953853;
	bh=RDVQoL4sE82paXI00u0nyf0ncj3K2JAAIAgRoe++0BY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hEof/ivMo0Fy+fOm+QQKtPyZduOchfOjWFMaTkaTdRemSDbiRAb/xdNgZWjVgXDbu
	 Nswr4OwHi8YWTLKzER6kRVaGqJu5pKfptYm+PtKFGWlzCRPyiNv8+rCyy+aekhsVZG
	 nMbBpy/SuGKns7pDLzvDaRrsCK42yWW2sfGvNj8XPtHQMIJ1RaelUnSRa32yWhkodS
	 fF+HWSBlkhO1tZ8uN7le6DcK4+6hCqM12MT3W7XstyTRKvMYaUTpiIMPnTevnzX8ZB
	 22/bapkVc/WnVo1Xx2edSGA1wgYNGlFvYs9nUtxI7wq6K29vHaqZFcwF10qNoA+Wtn
	 Ngj4G1GClTM4Q==
Message-ID: <d7199941-9f7d-4dcc-89b2-9f54ec2a0232@kernel.org>
Date: Thu, 26 Jun 2025 11:04:11 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] gpiolib: acpi: Add a helper for programming
 debounce
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, Mika Westerberg <westeri@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "open list:GPIO ACPI SUPPORT" <linux-gpio@vger.kernel.org>,
 "open list:GPIO ACPI SUPPORT" <linux-acpi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..."
 <linux-input@vger.kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
References: <20250625215813.3477840-1-superm1@kernel.org>
 <20250625215813.3477840-2-superm1@kernel.org>
 <aF1ZTrq4FLnpSz0q@smile.fi.intel.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <aF1ZTrq4FLnpSz0q@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/2025 9:29 AM, Andy Shevchenko wrote:
> On Wed, Jun 25, 2025 at 04:58:10PM -0500, Mario Limonciello wrote:
>>
>> Debounce is programmed in two places and considered non-fatal in one of
>> them. Introduce a helper for programming debounce and show a warning
>> when failing to program.
> 
>> This is a difference in behavior for the call
>> in acpi_dev_gpio_irq_wake_get_by().
> 
> When I meant "both", I was thinking of the _single_ existing case and new one
> which you are about to add. In principle, I think changing behaviour here is
> undesired. We provoke BIOS writers to make mistakes with debounce settings in
> GpioInt() resources.
> 
> I agree on the patch...
> 
>> -			/* ACPI uses hundredths of milliseconds units */
>> -			ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
>> -			if (ret)
>> -				return ret;
>> +			acpi_set_debounce_timeout(desc, info.debounce);
> 
> ...except this hunk.
> 

OK in that case I'll just squash patches 1 and 2 together, pick up Hans' 
tag and drop this hunk.

