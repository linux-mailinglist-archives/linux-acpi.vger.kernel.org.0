Return-Path: <linux-acpi+bounces-15682-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA0B268D8
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 16:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6A319E128C
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 14:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2712B1F584C;
	Thu, 14 Aug 2025 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqgctjnJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A431F30AD
	for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755180166; cv=none; b=DCUvSCNvVt0/T/wr4bDm97qp4RcwZA0UfJkILHwzhZmCWHa3phdDDNpN9ih7ZYUT/OBs/FOG0UMLGNPUx3ZglkqzSAzVuy6iZ7JvAqafOuajqkoyhS77ukQSsA0X/5/0aHaUlVu1JIQTtz7CY2+DxQ7rkwn5RFPx1CZIVB42x1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755180166; c=relaxed/simple;
	bh=vD6N19vulg3nT1U+XDDs5iFEvbwhlOucwBKUyBA3INc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O1+zV51uj/zWnrkX+MMYK0asRYvqhC+tVbtXmCQ19e9avMrVcW1e9atex5CKt2/cKND090DRRezleNmzZQ2wKGkEfamwUByUy4m6WBwjxLxeKTdiss1dThTseUKKmQ/ncaYgh4P7zkNq/tecM2UwwQJ7weBliGhO77GyaVNfCuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gqgctjnJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so474653f8f.3
        for <linux-acpi@vger.kernel.org>; Thu, 14 Aug 2025 07:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755180161; x=1755784961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USeovI1td615+m2hPQWxMlhtpdb04/bJ2k3zHNEipJk=;
        b=gqgctjnJCGzhl1czEXqJS54vIfPyqjCUl0pj2GywqdDP9jBxdphgaww62BXBo5VYJe
         s+2Ugt0BD8ilg7MWS8PdNRWblewwgR9qpaj6uf7rko5jyBvrqDy1Z9WtkXzunBeiMugf
         aAPfzKlRtjkT96zXaL0W6TYMevGWktdeVzuXUVoQB11zMKVXXSyzfaeEh+IPjJGIWpn6
         tNr7Bku7DL3KQYiv4Wafz+IRtzMvuGUDS2Z9m5LZD2FgFI/LMUkgXdJz997bbftXDV6y
         hZUZr9si4IJ3TZuJhgL/o9RdotV+IGzewmnThwHTWzFdKt2M3SWtHy82ptwPXo2hwump
         eeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755180161; x=1755784961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USeovI1td615+m2hPQWxMlhtpdb04/bJ2k3zHNEipJk=;
        b=bOAxPzQrj38HiCLWIfsq4YKuMuNTBQrP/h8JZjWAbZuNtekrpAtUhxzNm4YZQdjac3
         sZs5YsZlcFf9musxmMhk92mdfpJADxoRoGNs4kx+3otGCzlikZJ8wkiNsaFlh+w13TAr
         l/m4ilh4DSaTEOkyM0jUF4rrj8hiUEMtSC7xyiiRq3HHAbmUAOKqaKUcVCWwFMbbdQvM
         7ejdcYp+XP20U6t8f/V2Uwn6v68bX4FMKafhZ6qFqq9nlhsLQ7kt9A3ng7JldZB6AovG
         SFSK3FtIFDpttm/RZj+GVNfruDYgS12XaEJRFtqWVehb/bzk1X8XmkZGLuEUl7XqcW0n
         uKYA==
X-Forwarded-Encrypted: i=1; AJvYcCWWjlzoL8d/ID6K8jv+5OmGrROnPugzmqZNeylX0hTLOjHL24b5AeC5Cim+MJY+auugtHKe97qE8xI5@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvxqFsLXA5JnPI+vE/IoyVyRkTUUJelqmbc9zSztThxNSnIp1
	tgK/GVPWUVDdNGql95lE7D6MqSpiq/MELuibYawNHrkstsR8lEZJvt/ohBmu+itAAtE=
X-Gm-Gg: ASbGncs+OQciD4nzRh2QRTpK/S7PLRLmpy8VP1BKcuDz3EPJxVNHiw1rwYhxjH2UjE1
	8rHtx11CfXRHl6bLaiBcbpivKxaQMiOAKZTkJ43bNhog2tVhRL570qFXHL2lo5joo+rcWMB+4/t
	X/QuXPGwz8/vWiFxlamuwfCuypdwEm9DYifENHPpHNP9LvGVbRrq1uZFWyc6B6n00G6gM28NpuM
	KONiqUQ7muCdu5lNDjLROBxXJQuFMsNrKkVu56NaBqLlvAmxVHcu+9u9PIZhBxjIv6lame/d3g3
	oTBXdVMu0+QV6XJseqX121zcltesyj3nMhOydyrz/zs9GCnzZ2SsXm2Vh5KSCS1NnkAe6PD1Kv+
	EwWwvH1YD/svhGK/hrUDdfNv2gX37oXrtr+Y4pVcj9VxiaqXBSg3eZi8qHBvSdg==
X-Google-Smtp-Source: AGHT+IERUJslQgwOH4b97ptMQL4N4tOcjICMqR7HsbySu7FxgbLzrjkgYS25JdaV9G4A+kXiHJj3RQ==
X-Received: by 2002:a05:6000:2503:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b9edf1cf68mr2732676f8f.21.1755180161393;
        Thu, 14 Aug 2025 07:02:41 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b911469bffsm9885157f8f.36.2025.08.14.07.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 07:02:40 -0700 (PDT)
Message-ID: <52887b08-d5bc-4710-af7c-a70fab5e7f81@linaro.org>
Date: Thu, 14 Aug 2025 16:02:40 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clocksource/drivers/arm_arch_timer: Add standalone
 MMIO driver
To: Marc Zyngier <maz@kernel.org>, Steven Price <steven.price@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250807160243.1970533-3-maz@kernel.org>
 <8e58b01b-772d-4ca7-a681-34f10baa07e6@arm.com> <86ldnmdvpl.wl-maz@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <86ldnmdvpl.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 12:49, Marc Zyngier wrote:
> On Thu, 14 Aug 2025 11:13:47 +0100,
> Steven Price <steven.price@arm.com> wrote:
>>
>> On 07/08/2025 17:02, Marc Zyngier wrote:
>>> Add a new driver for the MMIO side of the ARM architected timer.
>>> Most of it has been lifted from the existing arch timer code,
>>> massaged, and finally rewritten.
>>>
>>> It supports both DT and ACPI as firmware descriptions.
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> ---
>>>   MAINTAINERS                               |   1 +
>>>   drivers/clocksource/arm_arch_timer_mmio.c | 420 ++++++++++++++++++++++
>>>   2 files changed, 421 insertions(+)
>>>   create mode 100644 drivers/clocksource/arm_arch_timer_mmio.c
>>>
>> [...]
>>> +static void arch_timer_mmio_setup(struct arch_timer *at, int irq)
>>> +{
>>> +	at->evt = (struct clock_event_device) {
>>> +		.features		   = (CLOCK_EVT_FEAT_ONESHOT |
>>> +					      CLOCK_EVT_FEAT_DYNIRQ),
>>> +		.name			   = "arch_mem_timer",
>>> +		.rating			   = 400,
>>> +		.cpumask		   = cpu_possible_mask,
>>> +		.irq 			   = irq,
>>> +		.set_next_event		   = arch_timer_mmio_set_next_event,
>>> +		.set_state_oneshot_stopped = arch_timer_mmio_shutdown,
>>> +		.set_state_shutdown	   = arch_timer_mmio_shutdown,
>>> +	};
>>> +
>>> +	at->evt.set_state_shutdown(&at->evt);
>>> +
>>> +	clockevents_config_and_register(&at->evt, at->rate, 0xf, CLOCKSOURCE_MASK(56));
>>
>> This doesn't work on 32 bit - clockevents_config_and_register()'s final
>> argument is an unsigned long, and a 56 bit mask doesn't fit. This
>> triggers a compiler warning:
> 
> Already reported, see 20250814111657.7debc9f1@canb.auug.org.au.
> 
>> Possible this should really be min(CLOCKSOURCE_MASK(56), ULONG_MAX)? But
>> I'm not familiar enough with this code. Most likely it's dead code on a
>> 32 bit platform.
> 
> No, this definitely exists on 32bit crap, since it has been part of
> the architecture from the ARMv7+VE days.
> 
> I think this is more of an impedance mismatch between the
> CLOCKSOURCE_MASK() helper and the clockevents_config_and_register(),
> and a (unsigned long) cast would do the trick.
> 
> But it also means that the per-cpu timer also gets truncated the same
> way, and that has interesting impacts on how often the timer is
> reprogrammed.
> 
> Daniel, do you want a patch on top or a new series?

A new series please

Thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

