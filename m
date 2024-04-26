Return-Path: <linux-acpi+bounces-5389-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06118B33AF
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F42021C218CB
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Apr 2024 09:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E213DDAE;
	Fri, 26 Apr 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp7zUzNb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA02E13D8B6
	for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 09:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122932; cv=none; b=A0toMiN2PowVb8IanFxabGxMxfhUl3wYnMpg1fPJO+yrfmdKSYnmYCigZh+98cDllLgDgRhXduNer8fu/KP7sj71vp4M70W8cQfiIrs25SqShBHjpg/5boJPP9Yzha+57JZQBPHpKH0l8lg2nalNVsUeiVMe6fbArWILVnkp+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122932; c=relaxed/simple;
	bh=+FjPzM84B6BX9czEfRXFDbCKq4ptfl8l7j3daLkKm1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWeMIdustGmkuAw3fXufsq1Ry8M/V/5KuIIgB79w7d2gDPsT4YbplT4tvLZX0uE7Bv4U+KRNMNdaErB2J07tdZ8Uze0W+c7GxGAx8bySYu+0GohXOwtI6HK9upvCsdrJFuMOPr2wtaWWtL1qQl6L6sthnL+GeTaunSUIRWEcvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp7zUzNb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714122929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
	b=bp7zUzNbGmpZwdfni3O+i0sqI1M6bCH2X8GzV5/GxsU+/gaTOcSfwk95jIACjF8+nAAfXL
	SrvhcmjFicuWkTMCnvnAhhlnuWEWUY046P+O9N9z0anMqv8OaCG3MwQWLyQSZ4YdYpAtzi
	0wOXQIiYrj8k32etxkwD3zTxlFF1PKc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-5eP3dtbEO1KYma41SEdAsA-1; Fri, 26 Apr 2024 05:15:28 -0400
X-MC-Unique: 5eP3dtbEO1KYma41SEdAsA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-601fef07eaeso2179951a12.1
        for <linux-acpi@vger.kernel.org>; Fri, 26 Apr 2024 02:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122927; x=1714727727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1jkzt/L+mhv/WzsExsbPIs4x3qKy+eN4N2XWavPkUaM=;
        b=fRBEyojUFRmSoOuYk21N2h81leUUEtwXx/raqdvuHVh87S6zhP7ItiCKHumkCNoy1m
         RBGWk8XvfmGKY8hH4dWUA8fpyIGIkimB2yH6Rq8CXg0QAVOuwtsTDQhdnisAJqqYONYc
         GgK00kYU6itRoBUgHY1j+JLaZjBXVKqCHYXnPNRcA1ITn1HsIvE6ZvfpEPHuRZKso3M9
         rrRIHHrP3WZql8KvvAnVJ9SiO22ziMNobvWkNCUgEIRdyYscL3rmOMglvq5kIGGBcLNY
         CTswwwaEk0G6WqBAoGRpFrYUaYWL7qGwZMTM6U0Gw88IUfM9rYLfPv5QTEJMTLlTz2nh
         DA6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVnNSiBxafnpg6p2EohVERGGd+razkP05nrXrycDxOUuPmLa9fIPSjVZwa2SLR10sFeJtDyfOnkjgF+/t6lFq3HiwhWoyf3Wm1CMA==
X-Gm-Message-State: AOJu0YwpvIWGwRy930480LwuiI4xGitXgdxPzDtJ8psPmBjNlysFUp5o
	OlUdOirDO16zZacHPkxRermPgPgX/4UOXfeGzKLio6shJJf3X+w16ePJhrpQxspk7x20IpM/iWz
	sBT438TpGDQt+ScudWHFT/P20XWcuBBuuHurbtnYFaqaoIZ97HpFEU2FwQYw=
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110986pze.62.1714122927167;
        Fri, 26 Apr 2024 02:15:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR4IonyI1PkhIL/Wl3B+SXVRCjKsdBxoyZhUJEblO74o+J0ratyZ96kbZ9Bo6ePHW9Uj0s2w==
X-Received: by 2002:a05:6a20:2713:b0:1a7:5425:3044 with SMTP id u19-20020a056a20271300b001a754253044mr2110962pze.62.1714122926856;
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Received: from [192.168.68.50] ([43.252.112.88])
        by smtp.gmail.com with ESMTPSA id bm5-20020a056a00320500b006ecf3e302ffsm14955063pfb.174.2024.04.26.02.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 02:15:26 -0700 (PDT)
Message-ID: <4d4f1a85-7aad-4ea1-aaed-1bb744d3ef99@redhat.com>
Date: Fri, 26 Apr 2024 19:15:16 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/16] ACPI: processor: Add acpi_get_processor_handle()
 helper
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Russell King
 <linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Miguel Luis <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
 Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, linuxarm@huawei.com,
 justin.he@arm.com, jianyong.wu@arm.com
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
 <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20240418135412.14730-6-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 23:54, Jonathan Cameron wrote:
> If CONFIG_ACPI_PROCESSOR provide a helper to retrieve the
> acpi_handle for a given CPU allowing access to methods
> in DSDT.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v7: No change
> v6: New patch
> ---
>   drivers/acpi/acpi_processor.c | 10 ++++++++++
>   include/linux/acpi.h          |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index ac7ddb30f10e..127ae8dcb787 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -35,6 +35,16 @@ EXPORT_PER_CPU_SYMBOL(processors);
>   struct acpi_processor_errata errata __read_mostly;
>   EXPORT_SYMBOL_GPL(errata);
>   
> +acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	acpi_handle handle = NULL;
> +	struct acpi_processor *pr = per_cpu(processors, cpu);;
                                                             ^^

                                                             s/;;/;

> +
> +	if (pr)
> +		handle = pr->handle;
> +
> +	return handle;
> +}
>   static int acpi_processor_errata_piix4(struct pci_dev *dev)
>   {
>   	u8 value1 = 0;
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 34829f2c517a..9844a3f9c4e5 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -309,6 +309,8 @@ int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
>   int acpi_unmap_cpu(int cpu);
>   #endif /* CONFIG_ACPI_HOTPLUG_CPU */
>   
> +acpi_handle acpi_get_processor_handle(int cpu);
> +
>   #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
>   int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
>   #endif
> @@ -1077,6 +1079,11 @@ static inline bool acpi_sleep_state_supported(u8 sleep_state)
>   	return false;
>   }
>   
> +static inline acpi_handle acpi_get_processor_handle(int cpu)
> +{
> +	return NULL;
> +}
> +
>   #endif	/* !CONFIG_ACPI */
>   
>   extern void arch_post_acpi_subsys_init(void);

Thanks,
Gavin


