Return-Path: <linux-acpi+bounces-14587-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0531AE8086
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 13:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F35CE169364
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Jun 2025 11:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D3829E11F;
	Wed, 25 Jun 2025 11:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TErRV/gd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160227FB31
	for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 11:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849470; cv=none; b=Xnge3vh5gXoqWjNJROdAuVtNCREjr1imDhCsDNkHp/bHIWYT0Hv3A18RHdF3RonPuv3Yx5IHge8NXy9AT45u5Qv4E+b/kwyQEgjF/9LoMqlB21w7qbrBBW6xufZX8p8KdR/By0rhR2CJDdNKffFHgeELgon6Di09J2+0ZMahpXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849470; c=relaxed/simple;
	bh=Y61BWDZPtR7pOaf7dLRue8jdp9Hm+JJTJKTIUIAX/6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+gqqkWjff5mJuLNbyumoOsHRZOkFF4sWBPRpX6ScG4vtUUVqiABycVgnjyH9/Jr9IH0xoSNDLUgxQrAUY6Zz1/KimukMvfekf0HC6C36fWeJy5D9Jya+tMlK/imVCJd6oEUmyEkVL8u1FKCKp5MJqaVkfUseATYwvjQJdIJOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TErRV/gd; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5257748e1so4335756f8f.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jun 2025 04:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750849466; x=1751454266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bBM23Ct+ByfHw8SX8hyrNix/sLf/sb5BZO5XYr+ya8c=;
        b=TErRV/gdYBjNP7cUVLn/kFyF8fQG5e4LdU5VRG8LeqKzmFrHa3SdTYp/8LlOHZJk3J
         2w73MS8opdz0FHCHV1TfAS9skDT8fpbnexqcwjPM7kT73MwLB2yh75N0ggXYf1ZDslhi
         wI+ld/2quuc3yAdVrtV+rcF+MVT4qbHo2/3WxroiSK9A+35u8YPHvwWxHB0pLa7tDFyG
         gJ6R9AVQUKHn68MgTbVNspKPwDcAt/PImfs/UMOyFlJxcaMRZ/VDfDkSsL44n907aZ50
         C7maMr9Fka+sVPLheQLi6Ifb1CKmneYq5+uUxyZFWKY0ti+FGdqQGuIZPEw/cLCW0m1X
         O/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750849466; x=1751454266;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBM23Ct+ByfHw8SX8hyrNix/sLf/sb5BZO5XYr+ya8c=;
        b=nrv3L1tf1/l6sTQ1sTGsCvACRWRGvXDGCC5ZugDqckTXP/l6dd6iZNPsokleKjScnG
         gc0j3iL4fGcb0+UUMTgF9QpS3tdXXTu8ATsEgznX94mUGfOGJcyqIELToFOktqd8Rglf
         lH+B7XTUa8+2B7YMmtCrxruo4r7gkXwe1lQDvpiz8hXNauHBlFy/8LIcgm6i72eKzb0Z
         1Pohz00coRbKE067ifPdX1/JcnDX3WxPXVbKEuE3GewFxY8HnO7XS6K0A93KvNgHOOAt
         QpFbLyo0qo3g8ED33+jg5lmWRV0zwS5L9OWR93gcZ83+djoQDBG20LgqOXcWgv2t7xwO
         E3cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJcR4jiEqU67nV4wufzE4XpxXlzW7GAcFz3vkNjm6++KcbrDD9/BnI8a50U7VyelvVZpZ1/wBWL6Es@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfcDXeeBDg0s8+RTDZlHbIIduSHooejw+SvBi/niy4BsA+gWC
	uO0JIVQ3uiNdAbpbwiF8und7qCYYwb8FwIXxLC47udCSLLGjqBcSls/2/DzxM9o7pUo=
X-Gm-Gg: ASbGncsL0jUwHjGzpmC6NwOirtXb+XQLXxJ8MFzjolyhotgY3Ti+Dqz64wwJ23gksHg
	1F3f6LgxMZdRJyiMmJ8sclnMyODLB31qmeaE7TeliMuEz58c776KFofCAcjHQiipHiwtVRfCQQo
	KgR/r2udOZPjeBmER6eFjSK+uWhixZOQ83jdHrPnZvmSQTqLgjiKP1Gi+tyX1CA3BQsCslfTNFI
	+xdPPDR/tBLM2Wo6BcHv+28K1rwT2v44cYbm5FBheSYOH4jKB5fOnBwkiq7EjHO7Kt66Nlu+oKP
	DewrblScRL7qI4dNsyDlWZk+jWbUYZQ1/HjItREdh1oDgoTPBx2CYNutI31ure6/Air3I/Z47M+
	R
X-Google-Smtp-Source: AGHT+IGqXj4nCrHiF5JwTZNWhPjB/iAgsxt4njcrF6F5C/nV0EZz4mK8GLoApBEEds3Rk2JIMJczGg==
X-Received: by 2002:a05:6000:40cd:b0:3a5:39e9:928d with SMTP id ffacd0b85a97d-3a6ed58b645mr2239688f8f.0.1750849466039;
        Wed, 25 Jun 2025 04:04:26 -0700 (PDT)
Received: from [192.168.0.20] ([212.21.159.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80ff8b8sm4225084f8f.71.2025.06.25.04.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:04:25 -0700 (PDT)
Message-ID: <fa56c7d9-cd93-47a5-bc48-0962b364d8be@suse.com>
Date: Wed, 25 Jun 2025 14:04:24 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/22] x86/mce: Define BSP-only init
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 linux-acpi@vger.kernel.org
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
 <20250624-wip-mca-updates-v4-11-236dd74f645f@amd.com>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250624-wip-mca-updates-v4-11-236dd74f645f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/24/25 17:16, Yazen Ghannam wrote:
> Currently, MCA initialization is executed identically on each CPU as
> they are brought online. However, a number of MCA initialization tasks
> only need to be done once.
> 
> Define a function to collect all 'global' init tasks and call this from
> the BSP only. Start with CPU features.
> 
> Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>      Link:
>      https://lore.kernel.org/r/20250415-wip-mca-updates-v3-7-8ffd9eb4aa56@amd.com
>      
>      v3->v4:
>      * Change cpu_mca_init() to mca_bsp_init().
>      * Drop code comment.
>      
>      v2->v3:
>      * Add tags from Qiuxu and Tony.
>      
>      v1->v2:
>      * New in v2.
> 
>   arch/x86/include/asm/mce.h     |  2 ++
>   arch/x86/kernel/cpu/common.c   |  1 +
>   arch/x86/kernel/cpu/mce/amd.c  |  3 ---
>   arch/x86/kernel/cpu/mce/core.c | 28 +++++++++++++++++++++-------
>   4 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index 3224f3862dc8..31e3cb550fb3 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -241,12 +241,14 @@ struct cper_ia_proc_ctx;
>   
>   #ifdef CONFIG_X86_MCE
>   int mcheck_init(void);
> +void mca_bsp_init(struct cpuinfo_x86 *c);
>   void mcheck_cpu_init(struct cpuinfo_x86 *c);
>   void mcheck_cpu_clear(struct cpuinfo_x86 *c);
>   int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
>   			       u64 lapic_id);
>   #else
>   static inline int mcheck_init(void) { return 0; }
> +static inline void mca_bsp_init(struct cpuinfo_x86 *c) {}
>   static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
>   static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
>   static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 8feb8fd2957a..8a00faa1042a 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1771,6 +1771,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>   		setup_clear_cpu_cap(X86_FEATURE_LA57);
>   
>   	detect_nopl();
> +	mca_bsp_init(c);
>   }
>   
>   void __init init_cpu_devs(void)
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index 292109e46a94..25a24d0b9cf9 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -655,9 +655,6 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>   	u32 low = 0, high = 0, address = 0;
>   	int offset = -1;
>   
> -	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> -	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
> -	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
>   	mce_flags.amd_threshold	 = 1;
>   
>   	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index ebe3e98f7606..c55462e6af1c 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1837,13 +1837,6 @@ static void __mcheck_cpu_cap_init(void)
>   	this_cpu_write(mce_num_banks, b);
>   
>   	__mcheck_cpu_mce_banks_init();
> -
> -	/* Use accurate RIP reporting if available. */
> -	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
> -		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
> -
> -	if (cap & MCG_SER_P)
> -		mca_cfg.ser = 1;
>   }
>   
>   static void __mcheck_cpu_init_generic(void)
> @@ -2243,6 +2236,27 @@ DEFINE_IDTENTRY_RAW(exc_machine_check)
>   }
>   #endif
>   
> +void mca_bsp_init(struct cpuinfo_x86 *c)
> +{
> +	u64 cap;
> +
> +	if (!mce_available(c))
> +		return;
> +
> +	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
> +	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
> +	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);

nit: Why use cpu_feature_enabled VS say boot_cpu_has since none of the 3 
features are defined in cpufeaturemasks.h, meaning that 
cpu_feature_enabled is essentially static_cpu_has, given that this is 
not a fast path?

It's not wrong per-se but I think the cpu_feature_enabled api is 
somewhat of a trainwreck i.e we ought to have a version that uses 
boot_cpu_has for "ordinary uses" and probably cpu_feature_enabled_fast 
for fastpaths.
> +
> +	rdmsrq(MSR_IA32_MCG_CAP, cap);
> +
> +	/* Use accurate RIP reporting if available. */
> +	if ((cap & MCG_EXT_P) && MCG_EXT_CNT(cap) >= 9)
> +		mca_cfg.rip_msr = MSR_IA32_MCG_EIP;
> +
> +	if (cap & MCG_SER_P)
> +		mca_cfg.ser = 1;
> +}
> +
>   /*
>    * Called for each booted CPU to set up machine checks.
>    * Must be called with preempt off:
> 


