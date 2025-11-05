Return-Path: <linux-acpi+bounces-18517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E110DC3484A
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0EED4E5FF8
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B44B2D47F6;
	Wed,  5 Nov 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="cU/PL7RK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E103EA8D
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332120; cv=none; b=rf/kMgfFG1rGfKrNb11cna/Nbe6M/eSmSu/JO99Vr19t5l8WD4q/TRKefmIS/u80jrHWuyJoiaAX1qOfAyYMLdH4c+FA4UFlr0vZQ9pSXwun07CI5UrfJW/OSrT0sNyLAoxOwUsnKc4dbft9/kqrZOzHNlYo446crEkAnB3azoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332120; c=relaxed/simple;
	bh=lycGLt/AmYhVMaxxlc2sFqXsptoJSH+28KSwY6rR74o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZQJpCQ/4hPAmfSMElZPiIF1kqrcD/qvUWocNeoXdn2m+aH+2cTfwaPNM60toqV9/7i5nP+QWfLUQIxUNpENJ/abauUko+mrktRB7GvGrrSRiHcWwEewkr/fI4T+5A/saTnO/Aq0kL0OkKa8pyTgrsPmE1/8xsstAuatPQ5jiXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=cU/PL7RK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-294fd2ca6acso5230855ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762332118; x=1762936918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=cU/PL7RKSR1tV5ZDsvSmMjojGUYiW1PGAZi8ZuBRs3hY3MqfiktLZKApdk79+Nw6c6
         +u84uc4YZbzgT0Fq4EF4yMmEm2klAoaNPE9tw/uNt9ONJ3X4zV2DimOJ7C/R2ALDVZk/
         Os2W39mDqB7QtMJezrRXz/CJhYOPo4HbZvXraFQuXN8N2E6VFj8XsVvSShE9drleVqYr
         BHUpCGby8BKjLY117vQ0bWnI9qj/nkl0+bWIDfIZv27NsT4HeeGNQNJW0GLTx2ZSCIK/
         f3RYBhTWvWpBLOhQ9LlqJFzdCYILKH50OXc1uJVV3s5qXTj7hD/NT3zrsHgKXxTzeTn3
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762332118; x=1762936918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tUkopRdeDHdh9AWy0RMXnD+iemi5ZwANhUDqA8Z7pVY=;
        b=TnU7WK3w3JCts4igRwgOR7TtqN4RXRNxpE2Bv0H3wl0MILsyUB3EOIpb/rzlpCmMek
         gE1qZPro6IpwPHOSWBo8Cncfetfi6NwyYLJQPfwh3MeQ4TnLkTCf0est3vni5h8ck3zx
         bAX67LnMAWV3steNc/V6lS2BPMfHdBbVWj0oTiBhCangp5SbidEFpqw2/cEA6uBXHbh5
         geyhOfELE8LgX/oOKZvO9yYgtx5LJbwqQZ+m7Ek42c/bKyM5Vn6l/9+ajLIWSiCdlmCP
         /QWaPi6KTo+06knnlQaYs/pQJCalT07GcezMS6gso+8vQnlKRj0YKzPCXm8FDe9zw7Hc
         nihQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRGPIxuabvBzrlOMpNy959CdVMpV7dWV1MfyhOCJ5CzYepJDj75kv4sCUmrGtqV9b47BAKo4tp6bek@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/9BVbjEdm83YvFQb1J41OreIBqSYWa0/jwZEmNZDGE6Aaqpj
	+VZ/vd06LMjAFXvkDO/kyVBmD2922TR9LR5+FuBDk357Nal6+AzF0pk6DBU88ty6kyc=
X-Gm-Gg: ASbGncv+eM4RL9ntRo1gu65tr3yg6k44gsuWk6s1l1kK5mPyDdGSFLBi4Wa6NDlWQPd
	ltrt9FkRPMM6g8qRdqGq+Cljnjd8HVRtSJ3QaoMfDpIwA0HLkxYuGz+AqkZdUD+Ha/8LMJ0FrOp
	ppHEv8dJBrb6y1uMg+JFMwa/6K21JIwytT27htdAzRsRbyGmuotr9jM+KdKgO9aGu1ljSIeHoIn
	3wqT0mhSWKwrzLkqCDKUd3gMENYrGweI1dFsKGmTBj6ESTBpt/QZ8Snt08pKcMXnHjZbgRx8PU2
	dfRyJ1jSD4B6WbvQe3tDeV9UXoWCS0T9EIJVWCDfgbQ6VKXWyRDlc+es6iHnuw4NsCkSzZMmdIb
	AOve9Mtcp6U1NmRsTXU1ONr3ty+w89CErUiYkeRU6jJOBU7mpGzeuVpkuJUXP2ECDia769/BNuH
	eP9Pm+H05wmrsEN6ZKlj83MlfV2HzRQdhXMQfll8zSS5j4SA==
X-Google-Smtp-Source: AGHT+IH5fMD1INFs9eEGKYVtBDuuIJ1FKf0Z38BpsziCkXGqBqC8vDLl4i3lj3Io8I0ea2eccHNQTg==
X-Received: by 2002:a17:902:d48c:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2962ad0fba0mr32538305ad.4.1762332118155;
        Wed, 05 Nov 2025 00:41:58 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972a9fsm52542895ad.20.2025.11.05.00.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:41:57 -0800 (PST)
Message-ID: <913ad5f8-89cf-475f-8ab4-3fa5e21d2941@rivosinc.com>
Date: Wed, 5 Nov 2025 09:41:46 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/10] riscv: Add fixmap indices for GHES IRQ and
 SSE contexts
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-5-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> GHES error handling requires fixmap entries for IRQ notifications.
> Add fixmap indices for IRQ, SSE Low and High priority notifications.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  arch/riscv/include/asm/fixmap.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 0a55099bb734..e874fd952286 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -38,6 +38,14 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
>  
> +#ifdef CONFIG_ACPI_APEI_GHES
> +	/* Used for GHES mapping from assorted contexts */
> +	FIX_APEI_GHES_IRQ,
> +#ifdef CONFIG_RISCV_SBI_SSE
> +	FIX_APEI_GHES_SSE_LOW_PRIORITY,
> +	FIX_APEI_GHES_SSE_HIGH_PRIORITY,
> +#endif /* CONFIG_RISCV_SBI_SSE */
> +#endif /* CONFIG_ACPI_APEI_GHES */
>  	__end_of_permanent_fixed_addresses,
>  	/*
>  	 * Temporary boot-time mappings, used by early_ioremap(),

Hi Himanshu,

Reviewed-By: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

