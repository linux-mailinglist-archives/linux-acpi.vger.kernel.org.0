Return-Path: <linux-acpi+bounces-18516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1ABC347D8
	for <lists+linux-acpi@lfdr.de>; Wed, 05 Nov 2025 09:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FB63AD59A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Nov 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C1A2D0C98;
	Wed,  5 Nov 2025 08:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="AgGI8p9Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5270228000F
	for <linux-acpi@vger.kernel.org>; Wed,  5 Nov 2025 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762331626; cv=none; b=rb5tAbo26m9tpRvOzNReTujNjqQ5wnChZaa/QWVU7iYJ5teaQcIZJxpto8JooopeOJBtyw2mYLygCic7sRo9CQ81PcyyazXY/jPxFgf+aIia1NklwotRfj9Gsh+4nRHs7JoFnpnJ/wRFYV60429UBhalKt60DXeReb2BRb/zPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762331626; c=relaxed/simple;
	bh=BwPh3ox3ihF8gLYDzcrOK44f4OtqgF+2Fb0Dh0+BLJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sNJZvmR1VbnR/W6x4lQ4AOhOwHdhMQMGOEb+ro07SkjFYZ2Vv1RBJygFHECzv0vAA/+rMLi18W3t+rTthkcHi+yvNkShwKOSDVjrtXb2P2d3wdTiuV3Z8MFSQuA99OKvILNWOZkZCMvMrJ3frPIsYca4i8/pafId9gC9mWBGcvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=AgGI8p9Z; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b6ceb3b68eeso4804774a12.2
        for <linux-acpi@vger.kernel.org>; Wed, 05 Nov 2025 00:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1762331623; x=1762936423; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=AgGI8p9ZoO0lkp3sUeJlqenPSg5AaDCGTgreHg2Fypt3zR4fdXAxkTUQL2HtEY3kQH
         57ClDalQu5wc2UEU4y7jbwwog7mF5cUdIJXJjl/6TOgbpDoEm7Ca3ZpfDuTguCfmlYd+
         1bJYFBUH3O0MvQbr/q+opt6OcHFdBViuKAeYQh5qhMWqd7cIayrsdd8JL+IJsQPnhuRY
         cloQ5dToDd6KN9KES4ph3w84e2PIso31rEoOlQXJ/e0oIwKtApwoDjHObQRq88mk7ck4
         D05fcFET+nQxOS/HHxjfNGh+2qG6y4MME/yfdkaHCN2+nNlP32Gc3xq90390Re0lhY7E
         DMpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762331623; x=1762936423;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpTquQODFrk3k7PTmJWFoZkkIUY08cVx4+GYG+eKacw=;
        b=WywtW+efuIchDm+PjGduqiEiceY50Zjve+eJyTJFhRWvNOmMb994YySnhcilIy9mcU
         jFa3bkNR0rtXkMHCA/+g+SBPHmk0tp1ENH0GaRwrMln3eiS1jPcslJf3u/sG/NmKY3/r
         dxkE5qFnqcw0AfLMCgM7kd4SID/RrkNgNGwckL38RfxsgMZdOIt2SvNGln40HTc+VIpy
         FVG01Zuxl/9vksPqPUhNnHf+fuyxLa+cVG8Y1BsfQko4lFBjzptVqpVXhhztH1BxoadL
         viRMRRL6sQtNRNojIFTl8Jq/M0eFRgUk1Ob3mT3c/xc5MED9Xz6F/0alCFWmYjtrl+Lg
         06Xg==
X-Forwarded-Encrypted: i=1; AJvYcCVOYuwVTeAGC1m6eGYYoDv4iRyL0V+CBNR5E//D+FeC863X5/XcmUnOuKv6lpAT9xIkLsDJUtFfuV9e@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77rWhk+jcRZHIWWEKNOYFTO2BBo0+CocsJMKuPkmv4whcG4Cu
	FpI/cNcvs1sCNsVn8+EIugjHcSWVDFX4yoqAplTPpGAADqdd7LUYas5+rIWsXctJzUc=
X-Gm-Gg: ASbGncvh0zBWCAr9Y9irzQLZDhg1eO0DnfxECLBDXc3fcI1sel/8Xczd3b3NCDlpL3t
	TDnGUwUUJ1PnnptOnY8yCj6yJHBiZf705i7vUbx/aEZFrWhbdEwRZ/R7WCJ8lF7J+ZcNBuLOmdF
	Y60Wu2R1/2uV3TFFJM6usFEJjDMwoKPWZaNraSX8XhvjHK/OYTyiccvOccUdIOPV3VTcNoQCEp6
	YFo/gRkQWP8ZEK0DqNdgtZkm9V1lxelqqiV2W3/NkCo5pY4QMNU0ERtps0wgldmsfRgsVxnrrsh
	B+/pm7P7OeZpsBPtCiUz87wnAKdwirtGEGlfhclnNPCibGig0mRtaDMA8jx62mwnuMScXDbXKDf
	4/k47SJ8dqZz72y5i3/0idqaqcM4GePJtRM4BofYKcc8vZeLJkPn1qhmPZTnZPtq922dfY7Uanj
	px7K6fSgZyqaTYHe5gVKooIimc0/Jh4t5+eHUAREGJsLvR6A==
X-Google-Smtp-Source: AGHT+IHDFgcvO6z3yf7vgJuVKi/Izk8w235XWF6jlBUbkg3bEglTQPQvHCk60pfVQnoZVc+QCi6Lug==
X-Received: by 2002:a05:6300:800a:b0:34f:c83b:b3ec with SMTP id adf61e73a8af0-34fc83bbb89mr1922411637.15.1762331623396;
        Wed, 05 Nov 2025 00:33:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e17:9700:16d2:7456:6634:9626? ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ae256df261sm1899131b3a.73.2025.11.05.00.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 00:33:42 -0800 (PST)
Message-ID: <15298563-967c-4609-9410-4bc0b6a75be6@rivosinc.com>
Date: Wed, 5 Nov 2025 09:33:30 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/10] acpi: Introduce SSE in HEST notification
 types
To: Himanshu Chauhan <hchauhan@ventanamicro.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org,
 acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, lenb@kernel.org,
 james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, conor@kernel.org,
 robert.moore@intel.com, sunilvl@ventanamicro.com, apatel@ventanamicro.com
References: <20251029112649.3811657-1-hchauhan@ventanamicro.com>
 <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <20251029112649.3811657-4-hchauhan@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/29/25 12:26, Himanshu Chauhan wrote:
> Introduce a new HEST notification type for RISC-V SSE events.
> The GHES entry's notification structure contains the notification
> to be used for a given error source. For error sources delivering
> events over SSE, it should contain the new SSE notification type.
> 
> Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
> ---
>  include/acpi/actbl1.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 7f35eb0e8458..20b490227398 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1535,7 +1535,8 @@ enum acpi_hest_notify_types {
>  	ACPI_HEST_NOTIFY_SEI = 9,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_GSIV = 10,	/* ACPI 6.1 */
>  	ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED = 11,	/* ACPI 6.2 */
> -	ACPI_HEST_NOTIFY_RESERVED = 12	/* 12 and greater are reserved */
> +	ACPI_HEST_NOTIFY_SSE = 12, /* RISCV SSE */
> +	ACPI_HEST_NOTIFY_RESERVED = 13	/* 13 and greater are reserved */
>  };

Hi Himanshu,

Looks good to me,

Reviewed-by: Clément Léger <cleger@rivosinc.com>

Thanks,

Clément

>  
>  /* Values for config_write_enable bitfield above */



