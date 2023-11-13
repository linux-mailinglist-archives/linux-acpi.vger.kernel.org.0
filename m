Return-Path: <linux-acpi+bounces-1429-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BEB7E9394
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 01:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AAE31C2033E
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 00:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08025848A
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Nov 2023 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OnUnWxgN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748ED15DA
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2023 00:29:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166D6124
	for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 16:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699835393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N8MbV+ldUGJXtFXnad6b8yZArDRg/WTGKo84KPGxrMw=;
	b=OnUnWxgNzvhAbmReTtDLNiqz5O263sgsHcUy+Zt4sBkbr3DlR5TUsP/dt1SBhIb6sBdS4P
	qDcSKrGqfrJPiH9mcwhfBtqFo4IDLv0qp1JJQEObBltLbVxxv0JwyJxU69BQdc5MFnug2H
	HQ8/hiWGPwE5evo0/4MveNKe8W5TJmk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-u7dMSrAeNWuDKPOjacSXqw-1; Sun, 12 Nov 2023 19:29:52 -0500
X-MC-Unique: u7dMSrAeNWuDKPOjacSXqw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-692c0c3bcc5so3632405b3a.3
        for <linux-acpi@vger.kernel.org>; Sun, 12 Nov 2023 16:29:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699835391; x=1700440191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N8MbV+ldUGJXtFXnad6b8yZArDRg/WTGKo84KPGxrMw=;
        b=Z0Q3EIT4QkdjsGjd5WKA4iBLUXtSwuKvwfitxXo6cYAISe+DuK+pOt3j2/X2+mcke/
         BJp9pzBKi7i6+tXJUb6lQfiWOhAmOLUr9pfxorpE/4sZPpqnOuiE+llM/P+TtD6ZceI/
         shRfnOm9ssB/7Phvg2/qS+LZFTsRXKJrPTBWu2U9/lIUUnjPZV5D6W6lnjD+N6ESSLSe
         Zbwvk75MMElAsx8CiEKSNrpIHeVfBFjl325lrcsYZqABLk0Tvmz2lhmhnoIzv8u8EDw6
         1ulmNor0foi/8n4bQv1ekiHHegX04FnNOJm+d52t0dxGXPCo2dvpPKhLKydbfTvPX6qg
         8BtQ==
X-Gm-Message-State: AOJu0YwDyNfp8yywEFIGFauJKKVZj4OTNZsY3CdNT+ZoEpCqNb161Gzj
	eE0tL+UyNkzGIdcUyd3v2xAGjgaNuLCtmCs39kn9GiGYRBJ2b+U0g5iM6Z8hsf0KimCAGbIZMAh
	Wi6ZUc5G1UapJiyUo8ox0yg==
X-Received: by 2002:a05:6a20:430b:b0:186:bb41:180 with SMTP id h11-20020a056a20430b00b00186bb410180mr63905pzk.33.1699835390949;
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfd4yfzq0YXl5QdnKYzie2VCc6U5S9RTqxoEsGgDflqzH9st3ur7RFmEwEZUtvxIYzQtb9pw==
X-Received: by 2002:a05:6a20:430b:b0:186:bb41:180 with SMTP id h11-20020a056a20430b00b00186bb410180mr63892pzk.33.1699835390683;
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001c62d63b817sm3035620plf.179.2023.11.12.16.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:29:50 -0800 (PST)
Message-ID: <8e288692-7460-4aa4-86f3-500327256bc3@redhat.com>
Date: Mon, 13 Nov 2023 10:29:39 +1000
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/22] ACPI: Move ACPI_HOTPLUG_CPU to be disabled on
 arm64 and riscv
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JL6-00CTws-3z@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JL6-00CTws-3z@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Neither arm64 nor riscv support physical hotadd of CPUs that were not
> present at boot. For arm64 much of the platform description is in static
> tables which do not have update methods. arm64 does support HOTPLUG_CPU,
> which is backed by a firmware interface to turn CPUs on and off.
> 
> acpi_processor_hotadd_init() and acpi_processor_remove() are for adding
> and removing CPUs that were not present at boot. arm64 systems that do this
> are not supported as there is currently insufficient information in the
> platform description. (e.g. did the GICR get removed too?)
> 
> arm64 currently relies on the MADT enabled flag check in map_gicc_mpidr()
> to prevent CPUs that were not described as present at boot from being
> added to the system. Similarly, riscv relies on the same check in
> map_rintc_hartid(). Both architectures also rely on the weak 'always fails'
> definitions of acpi_map_cpu() and arch_register_cpu().
> 
> Subsequent changes will redefine ACPI_HOTPLUG_CPU as making possible
> CPUs present. Neither arm64 nor riscv support this.
> 
> Disable ACPI_HOTPLUG_CPU for arm64 and riscv by removing 'default y' and
> selecting it on the other three ACPI architectures. This allows the weak
> definitions of some symbols to be removed.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC:
>   * Expanded conditions to avoid ACPI_HOTPLUG_CPU being enabled when
>     HOTPLUG_CPU isn't.
> Changes since RFC v3:
>   * Dropped ia64 changes
> ---
>   arch/loongarch/Kconfig        |  1 +
>   arch/x86/Kconfig              |  1 +
>   drivers/acpi/Kconfig          |  1 -
>   drivers/acpi/acpi_processor.c | 18 ------------------
>   4 files changed, 2 insertions(+), 19 deletions(-)
> 

With the following nits addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d889a0b97bc1..64620e90c12c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -5,6 +5,7 @@ config LOONGARCH
>   	select ACPI
>   	select ACPI_GENERIC_GSI if ACPI
>   	select ACPI_MCFG if ACPI
> +	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ACPI_PPTT if ACPI
>   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>   	select ARCH_BINFMT_ELF_STATE
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..dbdcfc708369 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -59,6 +59,7 @@ config X86
>   	#
>   	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
>   	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
> +	select ACPI_HOTPLUG_CPU			if ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ARCH_32BIT_OFF_T			if X86_32
>   	select ARCH_CLOCKSOURCE_INIT
>   	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index f819e760ff19..a3acfc750fce 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -310,7 +310,6 @@ config ACPI_HOTPLUG_CPU
>   	bool
>   	depends on ACPI_PROCESSOR && HOTPLUG_CPU
>   	select ACPI_CONTAINER
> -	default y
>   
>   config ACPI_PROCESSOR_AGGREGATOR
>   	tristate "Processor Aggregator"
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 0f5218e361df..4fe2ef54088c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -184,24 +184,6 @@ static void __init acpi_pcc_cpufreq_init(void) {}
>   
>   /* Initialization */
>   #ifdef CONFIG_ACPI_HOTPLUG_CPU
> -int __weak acpi_map_cpu(acpi_handle handle,
> -		phys_cpuid_t physid, u32 acpi_id, int *pcpu)
> -{
> -	return -ENODEV;
> -}
> -
> -int __weak acpi_unmap_cpu(int cpu)
> -{
> -	return -ENODEV;
> -}
> -
> -int __weak arch_register_cpu(int cpu)
> -{
> -	return -ENODEV;
> -}
> -
> -void __weak arch_unregister_cpu(int cpu) {}
> -

Since we're here, EXPORT_SYMBOL() can be dropped for these functions on
x86 and loongarch because they're not called from a module?

>   static int acpi_processor_hotadd_init(struct acpi_processor *pr)
>   {
>   	unsigned long long sta;

Thanks,
Gavin


