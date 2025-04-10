Return-Path: <linux-acpi+bounces-12954-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87327A84E2C
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96D601B873F1
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Apr 2025 20:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952828EA7F;
	Thu, 10 Apr 2025 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVNjAUHB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAC41FA262;
	Thu, 10 Apr 2025 20:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744316929; cv=none; b=Rc94UM9Cz4i0NETarwiY+Ih1Bd4j1YKuhBr1DF8b20IL9fmcT1JusN2tdaM1vEMEQuFwrhFF1Qd47ceiNBrep5OguVUvJEy8YtGQQv8MDFEfsiqCc0SWI2Ht9Ic3+ZU6f0+yhfy6kv+rjCPPGtbxHjWDWkSe+Dh/Dqma1KB/pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744316929; c=relaxed/simple;
	bh=MdZll6tFozWJMjFFh16yPz8vmYh5QIgv5cptZKSEuGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IeUGVClSKhVB4VCrSq1y6rtig5vln3SaPbhgC/0iIDC0G8jGUW5TiTx29weuN07s4XuG1ItabVJraZToeQedBmvqMcqIvOHBH2YB/6+Pv0lflJO2HFxZukBLgb5EIEx7q9jxOIIg1sHDb5AhLKyRN2Ev/ndD+muG1dMnKmvYEQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVNjAUHB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B2C4CEDD;
	Thu, 10 Apr 2025 20:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744316929;
	bh=MdZll6tFozWJMjFFh16yPz8vmYh5QIgv5cptZKSEuGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jVNjAUHBG7rogXBbeg5XTNMikVNJBGcxBIfQKG1wRINM7vXr8s+1opdkF+3CuOgvO
	 1uzymBEoSZyvy1eUAwFhOLRa4bcmSI0XJVNn1g69yDZMK5zlNOoLQ0XapJaGdHUg4J
	 EzjJ4C/f4rllBsZ9T1gyCsJabApm5T+J48bEPUQaxs4po4IC2KAwA5PEntiTvKLVpD
	 O1K9UPWPs5C7buZ0TNULPtRNqfc3otFfr8qJbjGInnLMaNspv6FlrlgxRmn5xLd1wR
	 7jC9H1dwYlWkue1HarQpTKHPU3sTEqR3sEW0bXgQjrenZY/QznaG3nLF2vUjG9cmXc
	 8R0oZzhdNEdzA==
Message-ID: <f509da3d-71de-4b90-b13b-ef0584bf05b8@kernel.org>
Date: Thu, 10 Apr 2025 15:28:47 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: amd: Fix use of undeclared identifier
 'pinctrl_amd_s2idle_dev_ops'
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Linus Walleij <linus.walleij@linaro.org>,
 "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 kernel test robot <lkp@intel.com>
References: <20250409213521.2218692-1-superm1@kernel.org>
 <CAJZ5v0h9v+OmqzRDuBAXBHY1oWq3BizP9FxyzdqkmJ353KjO1w@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0h9v+OmqzRDuBAXBHY1oWq3BizP9FxyzdqkmJ353KjO1w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/2025 7:50 AM, Rafael J. Wysocki wrote:
> On Wed, Apr 9, 2025 at 11:35 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> From: Mario Limonciello <mario.limonciello@amd.com>
>>
>> `pinctrl_amd_s2idle_dev_ops` is hidden under both `CONFIG_ACPI` and
>> `CONFIG_PM_SLEEP` so the functions that use it need the same scope.
> 
> Shouldn't this be CONFIG_SUSPEND given what's going on in acpi.h?

Really - I think we probably should change all of pinctrl-amd.c to use 
CONFIG_SUSPEND.

> 
> Also, there is one more report regarding pinctrl_dev being unused:
> 
> https://lore.kernel.org/linux-acpi/202504101106.hPCEcoHr-lkp@intel.com/T/#u
> 
> Any chance to address all of this in one patch?

Sure; I'll spin again and get something out to cover both cases soon.

> 
>> Adjust checks to look for both.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202504100420.88UPkUTU-lkp@intel.com/
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>   drivers/pinctrl/pinctrl-amd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
>> index b6fafed79b289..472a5aed4cd05 100644
>> --- a/drivers/pinctrl/pinctrl-amd.c
>> +++ b/drivers/pinctrl/pinctrl-amd.c
>> @@ -1209,7 +1209,7 @@ static int amd_gpio_probe(struct platform_device *pdev)
>>
>>          platform_set_drvdata(pdev, gpio_dev);
>>          acpi_register_wakeup_handler(gpio_dev->irq, amd_gpio_check_wake, gpio_dev);
>> -#ifdef CONFIG_ACPI
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>>          acpi_register_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>>   #endif
>>
>> @@ -1230,7 +1230,7 @@ static void amd_gpio_remove(struct platform_device *pdev)
>>
>>          gpiochip_remove(&gpio_dev->gc);
>>          acpi_unregister_wakeup_handler(amd_gpio_check_wake, gpio_dev);
>> -#ifdef CONFIG_ACPI
>> +#if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
>>          acpi_unregister_lps0_dev(&pinctrl_amd_s2idle_dev_ops);
>>   #endif
>>   }
>> --
>> 2.43.0
>>
>>


