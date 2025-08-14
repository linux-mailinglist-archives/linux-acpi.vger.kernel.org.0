Return-Path: <linux-acpi+bounces-15678-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27790B26547
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 14:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E81B60873
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 12:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1E2FCC04;
	Thu, 14 Aug 2025 12:23:33 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B571F582A;
	Thu, 14 Aug 2025 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755174213; cv=none; b=GY5vkaurLyGv/F21gRBV6fuPcqJXK2LbxMhm4bJ7NA6v8LMXpm7OgXop3ikudQwQA2gV0ljBf33oS7DHeW7nym9Sp7hiBvN6wJgLRyd9YR6ZlOaRV3FfWjSLeCqVVp4Dm2x8jWIx1W3IJlzm4ZaUqb5ewkdBQM8sEY3zAbzu+y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755174213; c=relaxed/simple;
	bh=UyyepfLCOzmmFFPFe6HR3vRn+M39bRs4+vF+ORPios4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EdVGHKeFYHrBm70Xg3oE3+/firW24woFwe437qZB9AJZUnIsQVKisZK1lIbi5+5ADyIZR59pyt404gmeYi/m7O1EtY0xMulOOjD722zSBO1Zy7LKJ9BSGDgtEvyKzmqND900+7saYgJj0/URSK3JLX66pVGbyVlFrrUZSZ6bie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8BD41688;
	Thu, 14 Aug 2025 05:23:21 -0700 (PDT)
Received: from [10.1.32.48] (e122027.cambridge.arm.com [10.1.32.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D65203F738;
	Thu, 14 Aug 2025 05:23:27 -0700 (PDT)
Message-ID: <d3bd4234-2053-45ce-aad4-6fc577665d72@arm.com>
Date: Thu, 14 Aug 2025 13:23:26 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Add standalone
 MMIO driver
To: Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-3-maz@kernel.org>
 <8e58b01b-772d-4ca7-a681-34f10baa07e6@arm.com> <86ldnmdvpl.wl-maz@kernel.org>
 <871ppetatg.wl-maz@kernel.org>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <871ppetatg.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/08/2025 12:14, Marc Zyngier wrote:
> On Thu, 14 Aug 2025 11:49:26 +0100,
> Marc Zyngier <maz@kernel.org> wrote:
>>
>> On Thu, 14 Aug 2025 11:13:47 +0100,
>> Steven Price <steven.price@arm.com> wrote:
>>>
>>> On 07/08/2025 17:02, Marc Zyngier wrote:
>>>> Add a new driver for the MMIO side of the ARM architected timer.
>>>> Most of it has been lifted from the existing arch timer code,
>>>> massaged, and finally rewritten.
>>>>
>>>> It supports both DT and ACPI as firmware descriptions.
>>>>
>>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>>> ---
>>>>  MAINTAINERS                               |   1 +
>>>>  drivers/clocksource/arm_arch_timer_mmio.c | 420 ++++++++++++++++++++++
>>>>  2 files changed, 421 insertions(+)
>>>>  create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
>>>>
>>> [...]
>>>> +static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
>>>> +{
>>>> +	at->evt = (struct clock_event_device) {
>>>> +		.features		   = (CLOCK_EVT_FEAT_ONESHOT |
>>>> +					      CLOCK_EVT_FEAT_DYNIRQ),
>>>> +		.name			   = "arch_mem_timer",
>>>> +		.rating			   = 400,
>>>> +		.cpumask		   = cpu_possible_mask,
>>>> +		.irq 			   = irq,
>>>> +		.set_next_event		   = arch_timer_mmio_set_next_event,
>>>> +		.set_state_oneshot_stopped = arch_timer_mmio_shutdown,
>>>> +		.set_state_shutdown	   = arch_timer_mmio_shutdown,
>>>> +	};
>>>> +
>>>> +	at->evt.set_state_shutdown(&at->evt);
>>>> +
>>>> +	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));
>>>
>>> This doesn't work on 32 bit - clockevents_config_and_register()'s final
>>> argument is an unsigned long, and a 56 bit mask doesn't fit. This
>>> triggers a compiler warning:
>>
>> Already reported, see 20250814111657.7debc9f1@canb.auug.org.au.
>>
>>> Possible this should really be min(CLOCKSOURCE_MASK(56), ULONG_MAX)? But
>>> I'm not familiar enough with this code. Most likely it's dead code on a
>>> 32 bit platform.
>>
>> No, this definitely exists on 32bit crap, since it has been part of
>> the architecture from the ARMv7+VE days.
>>
>> I think this is more of an impedance mismatch between the
>> CLOCKSOURCE_MASK() helper and the clockevents_config_and_register(),
>> and a (unsigned long) cast would do the trick.
> 
> Of course not. That would just result in a big fat zero.

No - CLOCKSOURCE_MASK() turns into GENMASK_ULL so a simple truncation to
unsigned long would be ULONG_MAX (all 1s). So an unsigned long cast
should be fine. My suggestion of MIN(, ULONG_MAX) was just to make that
more clear.

>> But it also means that the per-cpu timer also gets truncated the same
>> way, and that has interesting impacts on how often the timer is
>> reprogrammed.
> 
> That question still stand, and I wonder whether we have ugly bugs
> lurking on 32bit platforms because of that... I'll try and have a
> look.

I don't know whether there are other bugs due to the capping to
ULONG_MAX, but I don't think there's an (additional) bug here, it's
"just" a ugly warning.

Thanks,
Steve


