Return-Path: <linux-acpi+bounces-4581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2D89389B
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 09:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A12B21298
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Apr 2024 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5579D9479;
	Mon,  1 Apr 2024 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NJkaCS96"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CFD946C
	for <linux-acpi@vger.kernel.org>; Mon,  1 Apr 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711955941; cv=none; b=PQzV5cHiGk9o2etkC3PI/YxRoo77ZRrLFPvIcfRBj0xBUpQtNVmEIT41Q2+Gz6VrQYdDHw8mdmhkRWpHKUwhdjWOmLbHIWohQC3jnUo58z6C/H8RRk5nXB4xMBh9R+E//m8aofa9wQDKmnmykHxrgsuIfXxfYCL3cQfHMVjgLvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711955941; c=relaxed/simple;
	bh=MD+7DnurC6++x6pB8zRG9Hnf+SzLYopSLmHUgVuanGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvMNaUMZ66WOhLGx+GmhmbsDpxK6gnZt/J0PJFQYKYcduskKI11NIGVmT32nzFqRTkKn0D3zEe0HZQEX/jhfIlkbaNeBnBVLALluW1BjBWbMuwKznRFfB35kKDqK+wL6SptnFPLzeOq7zbE8aPsj063uE6N8q/zdJIfov1om34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NJkaCS96; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-221822a7dc7so1893225fac.3
        for <linux-acpi@vger.kernel.org>; Mon, 01 Apr 2024 00:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1711955939; x=1712560739; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmnMPiHdZwTuSyiAmUBbotIL+Wtz9SccD/2TsEE+0ng=;
        b=NJkaCS96oo9PoHrqunR0SGK5UCEYm6NAkf0BbpiFlw16fiAS4UuLhwJfn9/7FW4Gra
         Bg4Ni03q6MDMDq1mFoOv3Edlg/C68r0zvaZQX9yBGk1A4RQxPgO6B0Ril0kbqhG+nGnC
         1FTMlAuQSz+xaVwcq/JT48iXe3gVUONBKXubyrGL+q3HW5g79y/HqkPSRMjPilsq+Ymp
         U4tlQNGOU2/uZLgv7ZpoMJ5Mx+hKmB2vIqvCv9Ty0F2A4P9mNk0JzAwycpyQ5rrnVZlb
         sloZVEBmdA0clJkLOJKf1kkek3VOsxdra5bE4u6piQ4L2+/Fp8E+pm0A1kFsU6Z6/5eR
         abJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711955939; x=1712560739;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmnMPiHdZwTuSyiAmUBbotIL+Wtz9SccD/2TsEE+0ng=;
        b=kxm5io5HqAqHAAcyFznzofojOBauGSyqpnQjyWWPWtD13hYPODFkXqiqkjdUiqnN5u
         WuGQD2P8nMrwNl19/rYT3NYAK+StNV99c1R5gtwaJ9Ja5MmqZXD1Gm2Ky7mMOjb8Upy1
         AfWoJ8auOMTN3PilVCcYqRD72LGaFloI3iEpr6BYlgUOxGs6M3VWM5EOWkJk/lpg6szN
         EFY+c6/vzMZaWfogt1NYlGv5P02ZX+ptNLeip7271jg8mLWtt0uS9tzH+Rrgi4Lb3s02
         Eiw2A7qkb2CG/8/yY0G5TTUu8g0dwgoF+5BHtv/rffWIQLxLt+3I2Ra9WVQpJB9c4kIj
         Vatg==
X-Forwarded-Encrypted: i=1; AJvYcCUpID8SBqKcbhYR2vS9WAzyWq3TUOmIw2QX2nuTd93d2Se4lfpjHsusXXweCQRANMrEBgbD2D0yJPAmzwKZ0DLwZNmiv7ATNYyk9A==
X-Gm-Message-State: AOJu0YxpxBr97G6mSN8H6YBkYfWsnGFxle7p+E2gZgwDlCrfYjfehdya
	Zqrv+g2RJwLKMpfETiDKe52cjqcggBRb4Wx0pFzwluVnrXmLyilUE7H0tCG3RzE=
X-Google-Smtp-Source: AGHT+IGSfvqjOauFHIchIvjURLPiv+JlWEBBSRMGmtVtVu+cf9tXS/DlNmsy1MccDtCO/34D8tR6/w==
X-Received: by 2002:a05:6870:2309:b0:221:9227:e006 with SMTP id w9-20020a056870230900b002219227e006mr10279412oao.47.1711955938782;
        Mon, 01 Apr 2024 00:18:58 -0700 (PDT)
Received: from sunil-laptop ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id gy8-20020a056870288800b00222649d5b4esm2717950oab.16.2024.04.01.00.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 00:18:58 -0700 (PDT)
Date: Mon, 1 Apr 2024 12:48:42 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Guo Ren <guoren@kernel.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>, Jisheng Zhang <jszhang@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>, James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Marc Zyngier <maz@kernel.org>, Anup Patel <apatel@ventanamicro.com>,
	Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v2 6/6] ACPI: RISCV: Enable ACPI based NUMA
Message-ID: <Zgpf0rqUSEZcSiAV@sunil-laptop>
References: <cover.1709780590.git.haibo1.xu@intel.com>
 <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01cb5780041565784d459cd94a5c4f55eaa87739.1709780590.git.haibo1.xu@intel.com>

Hi Haibo,

On Thu, Mar 07, 2024 at 04:47:58PM +0800, Haibo Xu wrote:
> Enable ACPI based NUMA for RISCV in Kconfig.
> 
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/riscv/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0bfcfec67ed5..0fb55f166701 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -447,6 +447,7 @@ config NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
>  	select NEED_PER_CPU_PAGE_FIRST_CHUNK
> +	select ACPI_NUMA if ACPI

If the firmware didn't provide the SRAT/SLIT on ACPI based systems, then
there will be a message "Failed to initialise from firmware" from
arch_acpi_numa_init(). This is not specific to RISC-V. But I am
wondering why should it be pr_info instead of pr_debug.

Thanks,
Sunil
>  	select OF_NUMA
>  	select USE_PERCPU_NUMA_NODE_ID
>  	help
> -- 
> 2.34.1
> 

