Return-Path: <linux-acpi+bounces-4098-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C7D8714E6
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 05:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91E6280E31
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Mar 2024 04:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BA53FB1B;
	Tue,  5 Mar 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ez0zoYlh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94738398
	for <linux-acpi@vger.kernel.org>; Tue,  5 Mar 2024 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709613732; cv=none; b=TpIkpbtJwjoaxsHiOtMYSG3kA1vPhYAfKxMqZ8HRZdgTPhkXT5AzpGwL5WMXsUOJ7M548QLEbogWz3/d7w8DfolLPNGw50OAGjbCiJ3Dh157hZgSMmIj8g2jTcryqleJi959d3vQ24MLa4oz9hkp74DkYyxAqrbUi/gUcNK+bxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709613732; c=relaxed/simple;
	bh=ofKGUMTvxn3SKlpz50MdrEeThbOSHyLZrTEsteB2xT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V/YtMlJH0v/fQ5Q1o7U14FZxaCxBD8LXWK4yYq26uNODLkq/28kYEgw33Aw0n4fk1XTsCcDu4VuTnU1WsFZoWYZJyhWh0Rt0aH6dFJAn0xZOYZnZeKRlWn0N1B6ytQqiCoL1qefgHIuKG0Qi2ImVBlmcTydLdmIc8bkmemzKXH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ez0zoYlh; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e627596554so1183757b3a.2
        for <linux-acpi@vger.kernel.org>; Mon, 04 Mar 2024 20:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1709613730; x=1710218530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yF4EwQqzBVk7XgdJQilAun1918XSEfc6vUXCeQtX3Tw=;
        b=Ez0zoYlh05rjjLfw90z4mna/4PFMsJgIdqBpszhrmzTMPT3vm42k+cfrARCIQ4Kq53
         NQxVUilkcC5bCW+B0DJ/6yjH7m4LeP04FAM8MH/mOSY8KUA9Bj9ZRKMfmod79VSbpmh2
         sYwIXIC2abrXjWOCC2pa/JA+kp+UfRqW3fyWQC9omouNKLKCw5XfAzmMiPxbq7pyAHx6
         EDqFeUyl656x7lHU/b3UlafF7sdY6pbfQCWnLdU5ATCVicV8TgUutLPP26tluheFcfX7
         HSOUwcjj+WCTOyOhSmUCPC28tdM6wmW4tEgMN8NPr9oVVpZajRu9C/jZRlomCuWX77Xw
         nZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709613730; x=1710218530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yF4EwQqzBVk7XgdJQilAun1918XSEfc6vUXCeQtX3Tw=;
        b=GUPshKc4T/NaCgCaJBJVTVAC7apEvijLZ3p6/el6IsJQu3POpWXu9ozeV0E6jiiY63
         e8QKAqy/7XSjuDd6ifNLXI4QvcgDnecIyox4AtrMMWiDkPcgpngBM7/4L1bumpffmM+f
         XZDuAQS6av4zVvV1CeIIQlzY0fXrE82O7wvT0bQhOiPKlEjLN7PfVhCqJ41BA4yqdh/N
         IPS0wG8cd02Yt1meERoc9vm6WR7K+f0fTdoEvQMeYI/baMfuV88QQcuZDNlEWKuO+Vrv
         8Ezhca1X5zw7mS+3VHnxaEG+iGdvRCHfewZYtJUGyfLknWcehd9HRam9OxGdcEmSLkMp
         fEcA==
X-Forwarded-Encrypted: i=1; AJvYcCXLkdeL2Uy7xzdVhQo8bAHuoqCe/EiAVhZuRS5A1Z5bE7H3qN6KRAxU8FipXwnkFPwAm8UsX4B+DxDAM/uSWZ3ihX/Hx0polkgFbQ==
X-Gm-Message-State: AOJu0YyS9h6wEJ2K/OA0MiYF2JbUx8IIdvEOw5C4WpeC3BwBeQKiNfoc
	hzyRMyoWY+b+5myN3a06PMSwvSZYfOjRoCgq4e6r0NfPDnIjcuFGX0kdPKH3DT4=
X-Google-Smtp-Source: AGHT+IHFeTjXThPCXKLo9RHXN66EbeSFne7ZcgdAIqKXetKAR8c1ZOC18G/a37FUmZWnIib779ErWA==
X-Received: by 2002:aa7:8714:0:b0:6e6:136b:cfc with SMTP id b20-20020aa78714000000b006e6136b0cfcmr4986620pfo.4.1709613730220;
        Mon, 04 Mar 2024 20:42:10 -0800 (PST)
Received: from sunil-laptop ([106.51.184.12])
        by smtp.gmail.com with ESMTPSA id x19-20020a63f713000000b005dbf22d6e1asm8416760pgh.56.2024.03.04.20.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 20:42:09 -0800 (PST)
Date: Tue, 5 Mar 2024 10:11:56 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>, Baoquan He <bhe@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>, Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 2/4] ACPI: NUMA: Add handler for SRAT RINTC affinity
 structure
Message-ID: <ZeailF+UYf/+4NQq@sunil-laptop>
References: <cover.1706603678.git.haibo1.xu@intel.com>
 <a1e20de53156f50385c7609507982f08866e859b.1706603678.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1e20de53156f50385c7609507982f08866e859b.1706603678.git.haibo1.xu@intel.com>

Hi Haibo,

On Wed, Jan 31, 2024 at 10:31:59AM +0800, Haibo Xu wrote:
> Add RINTC affinity structure handler during parsing SRAT table.
> The ARCH specific implementation will be added in next patch.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  drivers/acpi/numa/srat.c | 32 +++++++++++++++++++++++++++++++-
>  include/linux/acpi.h     |  3 +++
>  2 files changed, 34 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 0214518fc582..503abcf6125d 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -165,6 +165,19 @@ acpi_table_print_srat_entry(struct acpi_subtable_header *header)
>  		}
>  	}
>  	break;
> +
> +	case ACPI_SRAT_TYPE_RINTC_AFFINITY:
> +		{
> +			struct acpi_srat_rintc_affinity *p =
> +			    (struct acpi_srat_rintc_affinity *)header;
> +			pr_debug("SRAT Processor (acpi id[0x%04x]) in proximity domain %d %s\n",
> +				 p->acpi_processor_uid,
> +				 p->proximity_domain,
> +				 (p->flags & ACPI_SRAT_RINTC_ENABLED) ?
> +				 "enabled" : "disabled");
> +		}
> +		break;
> +
>  	default:
>  		pr_warn("Found unsupported SRAT entry (type = 0x%x)\n",
>  			header->type);
> @@ -448,6 +461,21 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
>  }
>  #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
>  
> +static int __init
> +acpi_parse_rintc_affinity(union acpi_subtable_headers *header,
> +			 const unsigned long end)
Alignment doesn't look right. Could you please run checkpatch on all
the patches?

> +{
> +	struct acpi_srat_rintc_affinity *rintc_affinity;
> +
> +	rintc_affinity = (struct acpi_srat_rintc_affinity *)header;
> +	acpi_table_print_srat_entry(&header->common);
> +
> +	/* let architecture-dependent part to do it */
> +	acpi_numa_rintc_affinity_init(rintc_affinity);
> +
Is it required to have this commit first prior to architecture
functionality? I am wondering whether it is logically better to
implement the function first and then consume in next commit?

> +	return 0;
> +}
> +
>  static int __initdata parsed_numa_memblks;
>  
>  static int __init
> @@ -501,7 +529,7 @@ int __init acpi_numa_init(void)
>  
>  	/* SRAT: System Resource Affinity Table */
>  	if (!acpi_table_parse(ACPI_SIG_SRAT, acpi_parse_srat)) {
> -		struct acpi_subtable_proc srat_proc[4];
> +		struct acpi_subtable_proc srat_proc[5];
>  
>  		memset(srat_proc, 0, sizeof(srat_proc));
>  		srat_proc[0].id = ACPI_SRAT_TYPE_CPU_AFFINITY;
> @@ -512,6 +540,8 @@ int __init acpi_numa_init(void)
>  		srat_proc[2].handler = acpi_parse_gicc_affinity;
>  		srat_proc[3].id = ACPI_SRAT_TYPE_GENERIC_AFFINITY;
>  		srat_proc[3].handler = acpi_parse_gi_affinity;
> +		srat_proc[4].id = ACPI_SRAT_TYPE_RINTC_AFFINITY;
> +		srat_proc[4].handler = acpi_parse_rintc_affinity;
>  
>  		acpi_table_parse_entries_array(ACPI_SIG_SRAT,
>  					sizeof(struct acpi_table_srat),
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index b7165e52b3c6..a65273db55c6 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -269,6 +269,9 @@ acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
>  
>  int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
>  
> +static inline void
> +acpi_numa_rintc_affinity_init(struct acpi_srat_rintc_affinity *pa) { }
> +
I think this can be fit in single like as we can have upto 100
characters.

>  #ifndef PHYS_CPUID_INVALID
>  typedef u32 phys_cpuid_t;
>  #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
> -- 
> 2.34.1
> 

