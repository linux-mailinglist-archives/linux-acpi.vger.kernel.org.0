Return-Path: <linux-acpi+bounces-6677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F6391CFC0
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 02:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F397282473
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jun 2024 00:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE08010E6;
	Sun, 30 Jun 2024 00:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxEAA4Ma"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E3110A
	for <linux-acpi@vger.kernel.org>; Sun, 30 Jun 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719707964; cv=none; b=cIh0csRJYX8H1c63PXDVExvUVScZHrft00z9kbq6UnI3E6p75EkhZI6vhKGa10JO+Hdm/ONJa+ajsWSevQ84E4+9WCjFZ1CFzUzdbYyFQPGydHMEvBHbedHJMxnbRjAQIZD3USdMRO2xdWi7T+EU0wYvhWYUBwYw0pxPbJegBhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719707964; c=relaxed/simple;
	bh=tRIoatf77wwm0sxL/U2o7B+pzFe98brwQ+ax4MdYMS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sniDYAw60pKejd0/L0HA+tblVG/Cz6j47GalmutzkdLT9mcCSkF7CElRuNxUBkAs0/Dr+rtLNq5lr5uvBbiv/AruTLGzxA6Yl1f/Rcfk38a3gW6P83h3SIvTkSxqcuvGeNfRpvjHF4zPWqj42233Ab4tmFVobM/lwt6tRkeXHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QxEAA4Ma; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719707962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dYIxGuEXpUSy/5Y6UAVKbTkIJVtmPhwJBZMzOU8+q5w=;
	b=QxEAA4MaNG0Y9T1AequGVHlI3Zx+xC4vuRR/Qt2RuDFGJ+Vg01mSnwnzLpyqGGFDc6Z4EV
	+HJa2Z08ILVmm9TGu3FszFFfaAiK4N88uxqUJLgB3eljZkzKgXIXxXu+PPgzcVCl/OgLbE
	RwVfmS2fKoff1SraP4AmqCkNeCBgb/o=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-K3YuJACWNM61DA8GPxNZhw-1; Sat, 29 Jun 2024 20:39:17 -0400
X-MC-Unique: K3YuJACWNM61DA8GPxNZhw-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2bffbc8ad81so1223508a91.2
        for <linux-acpi@vger.kernel.org>; Sat, 29 Jun 2024 17:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719707956; x=1720312756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dYIxGuEXpUSy/5Y6UAVKbTkIJVtmPhwJBZMzOU8+q5w=;
        b=iVUgAcDkVjvE3NQz8bC0Z5iqtImpSnhbGx+IUMJqiJiQq7WtF9D1NH2PZKi9pFGmR2
         qVEnphP21UoJ0fdns5M1cVsElprHTSfITyjlvYDv78Pm0OcS0dXBda7XYHgnV04k308q
         GozZZKDVSXsWHE3cyj69Y3VgbVIlBEQXPR59NKV+AeSamcV4Yvucs/JYvmTrqyVToAfJ
         avO1ksZgsz3JCwptYPlt0DoCgteFaNQ5Py3OMhxzSgbLkkpTxT5vhiCPIXpGyYuJ9p8T
         /KKK+tRVyLx4DnQ38Ku6UPHn5uNb7rIl5DG81ObAjz9TW1GBoIteA2gOoLeQD6rH9kV5
         la0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVj3yodKnDBxEYHNhf/simERYLcnn2AxeWlMlOWRH7TsSmrgxyjtG8PLGlsZbLRaXasWzeo1gaVyJyfiHV76JKF+0H2i9wry6Zk3Q==
X-Gm-Message-State: AOJu0Yz5Go6EByIgPQhhS1nX9CmacainC5yIeCcrGypTmvos3DETPgSW
	wcx5akJG5xctmg+yMSEwg0ExX3fHUc4iwANlaH3D5nb12JIqG/35C16fXgmFkElra+EDVsGJNo4
	VcHG0s+UXjV5GFaq//0+pJYmMOgznFlINPZDJcvRVIW0S7WRoCHlCkDtnt6g=
X-Received: by 2002:a17:902:e5cd:b0:1f9:d99f:61ab with SMTP id d9443c01a7336-1fadbcf410emr12621705ad.62.1719707956598;
        Sat, 29 Jun 2024 17:39:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/NdzPye3ofsIgF1rsz62eiDjuN05hA7t2+cnE7758DAdfnF9KWdi//koW+PTHyTmfFFAF4Q==
X-Received: by 2002:a17:902:e5cd:b0:1f9:d99f:61ab with SMTP id d9443c01a7336-1fadbcf410emr12621455ad.62.1719707956151;
        Sat, 29 Jun 2024 17:39:16 -0700 (PDT)
Received: from [192.168.68.51] ([103.210.27.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15966b1sm37766095ad.262.2024.06.29.17.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jun 2024 17:39:15 -0700 (PDT)
Message-ID: <47a261e0-006d-4c64-9c9b-bc73797b8d6b@redhat.com>
Date: Sun, 30 Jun 2024 10:39:04 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 17/19] arm64: Kconfig: Enable hotplug CPU on arm64 if
 ACPI_PROCESSOR is enabled.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 loongarch@lists.linux.dev, x86@kernel.org,
 Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>,
 James Morse <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Hanjun Guo <guohanjun@huawei.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
References: <20240529133446.28446-1-Jonathan.Cameron@huawei.com>
 <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240529133446.28446-18-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jonathan and Catalin,

On 5/29/24 11:34 PM, Jonathan Cameron wrote:
> In order to move arch_register_cpu() to be called via the same path
> for initially present CPUs described by ACPI and hotplugged CPUs
> ACPI_HOTPLUG_CPU needs to be enabled.
> 
> The protection against invalid IDs in acpi_map_cpu() is needed as
> at least one production BIOS is in the wild which reports entries
> in DSDT (with no _STA method, so assumed enabled and present)
> that don't match MADT.
> 
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   arch/arm64/Kconfig       |  1 +
>   arch/arm64/kernel/acpi.c | 22 ++++++++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5d91259ee7b5..e8f2ef2312db 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -5,6 +5,7 @@ config ARM64
>   	select ACPI_CCA_REQUIRED if ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_GTDT if ACPI
> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR

ACPI_HOTPLUG_CPU depends on (ACPI_PROCESSOR && HOTPLUG_CPU). It needs to be:

	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU

Otherwise, we can have compiling error with the following configurations.

CONFIG_ACPI_PROCESSOR=y
CONFIG_HOTPLUG_CPU=n
CONFIG_ACPI_HOTPLUG_CPU=y

arch/arm64/kernel/smp.c: In function ‘arch_unregister_cpu’:
arch/arm64/kernel/smp.c:563:9: error: implicit declaration of function ‘unregister_cpu’; did you mean ‘register_cpu’? [-Werror=implicit-function-declaration]
   563 |         unregister_cpu(c);
       |         ^~~~~~~~~~~~~~
       |         register_cpu

Since the series has been queued to Catalin's "for-next/vcpu-hotplug" branch, I
guess the easiest way would be to fix it in place with Catalin's help.

Thanks,
Gavin

>   	select ACPI_IORT if ACPI
>   	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
>   	select ACPI_MCFG if (ACPI && PCI)
> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> index e0e7b93c16cc..9360ba86678b 100644
> --- a/arch/arm64/kernel/acpi.c
> +++ b/arch/arm64/kernel/acpi.c
> @@ -30,6 +30,7 @@
>   #include <linux/pgtable.h>
>   
>   #include <acpi/ghes.h>
> +#include <acpi/processor.h>
>   #include <asm/cputype.h>
>   #include <asm/cpu_ops.h>
>   #include <asm/daifflags.h>
> @@ -423,6 +424,27 @@ void arch_reserve_mem_area(acpi_physical_address addr, size_t size)
>   	memblock_mark_nomap(addr, size);
>   }
>   
> +#ifdef CONFIG_ACPI_HOTPLUG_CPU
> +int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 apci_id,
> +		 int *pcpu)
> +{
> +	/* If an error code is passed in this stub can't fix it */
> +	if (*pcpu < 0) {
> +		pr_warn_once("Unable to map CPU to valid ID\n");
> +		return *pcpu;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_map_cpu);
> +
> +int acpi_unmap_cpu(int cpu)
> +{
> +	return 0;
> +}
> +EXPORT_SYMBOL(acpi_unmap_cpu);
> +#endif /* CONFIG_ACPI_HOTPLUG_CPU */
> +
>   #ifdef CONFIG_ACPI_FFH
>   /*
>    * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as


