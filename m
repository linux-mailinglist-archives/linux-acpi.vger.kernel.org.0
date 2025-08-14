Return-Path: <linux-acpi+bounces-15673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8177B26231
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 12:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E38901894A97
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 10:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C292FAC0B;
	Thu, 14 Aug 2025 10:13:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D702E9EB4;
	Thu, 14 Aug 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755166433; cv=none; b=RyxmJgrioP65QmHzK5JKDDtgGtjZsqVQEb/9NUJs4PkT+SLF5T6lJc7QjKbMmC+hV+EA1dWKAMP5vK0H+W6d7ogNigSzsCdD7riYTY1dYvOqLWfzjQ2d4h9N86InzQO/JpdTrznSKDH5Sm85u9+47GKTmiYH860bnUXZLstKzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755166433; c=relaxed/simple;
	bh=Bg9AzY3Mn0AYL1nBIXFeDIoVS+u15WrCOpXgAgnHRFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kCA1ZS2AT5Obnk/38GzlNsVyI9+ca4/1ibPJt9zsw9dbe3eotChwWbg7ngu3pGWedYMUAyRA2te8+i/ftnhbHXbX4umKkmZKOE+YirnHneOQCvNOJZUeE9Hg3+VeucEHr57v3XQWZe0vkUFjiF1X/HSmmy8NynKoFkW3wGb/Hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43B7A1691;
	Thu, 14 Aug 2025 03:13:43 -0700 (PDT)
Received: from [10.1.32.48] (e122027.cambridge.arm.com [10.1.32.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A06E3F738;
	Thu, 14 Aug 2025 03:13:49 -0700 (PDT)
Message-ID: <8e58b01b-772d-4ca7-a681-34f10baa07e6@arm.com>
Date: Thu, 14 Aug 2025 11:13:47 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Add standalone
 MMIO driver
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-3-maz@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20250807160243.1970533-3-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2025 17:02, Marc Zyngier wrote:
> Add a new driver for the MMIO side of the ARM architected timer.
> Most of it has been lifted from the existing arch timer code,
> massaged, and finally rewritten.
> 
> It supports both DT and ACPI as firmware descriptions.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  MAINTAINERS                               |   1 +
>  drivers/clocksource/arm_arch_timer_mmio.c | 420 ++++++++++++++++++++++
>  2 files changed, 421 insertions(+)
>  create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
> 
[...]
> +static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
> +{
> +	at->evt = (struct clock_event_device) {
> +		.features		   = (CLOCK_EVT_FEAT_ONESHOT |
> +					      CLOCK_EVT_FEAT_DYNIRQ),
> +		.name			   = "arch_mem_timer",
> +		.rating			   = 400,
> +		.cpumask		   = cpu_possible_mask,
> +		.irq 			   = irq,
> +		.set_next_event		   = arch_timer_mmio_set_next_event,
> +		.set_state_oneshot_stopped = arch_timer_mmio_shutdown,
> +		.set_state_shutdown	   = arch_timer_mmio_shutdown,
> +	};
> +
> +	at->evt.set_state_shutdown(&at->evt);
> +
> +	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));

This doesn't work on 32 bit - clockevents_config_and_register()'s final
argument is an unsigned long, and a 56 bit mask doesn't fit. This
triggers a compiler warning:

 drivers/clocksource/arm_arch_timer_mmio.c: In function
'arch_timer_mmio_setup':
 ./include/linux/bits.h:47:9: error: conversion from 'long long unsigned
int' to 'long unsigned int' changes value from '72057594037927935' to
'4294967295' [-Werror=overflow]
    47 |         ((t)(GENMASK_INPUT_CHECK(h, l) +                        \
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    48 |              (type_max(t) << (l) &                              \
       |              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
       |               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 ./include/linux/bits.h:52:33: note: in expansion of macro 'GENMASK_TYPE'
    52 | #define GENMASK_ULL(h, l)       GENMASK_TYPE(unsigned long
long, h, l)
       |                                 ^~~~~~~~~~~~
 ./include/linux/clocksource.h:153:32: note: in expansion of macro
'GENMASK_ULL'
   153 | #define CLOCKSOURCE_MASK(bits) GENMASK_ULL((bits) - 1, 0)
       |                                ^~~~~~~~~~~
 drivers/clocksource/arm_arch_timer_mmio.c:255:66: note: in expansion of
macro 'CLOCKSOURCE_MASK'
   255 |         clockevents_config_and_register(&at->evt, at->rate,
0xf, CLOCKSOURCE_MASK(56));
       |
 ^~~~~~~~~~~~~~~~

Possible this should really be min(CLOCKSOURCE_MASK(56), ULONG_MAX)? But
I'm not familiar enough with this code. Most likely it's dead code on a
32 bit platform.

Thanks,
Steve


