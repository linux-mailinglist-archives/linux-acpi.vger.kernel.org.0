Return-Path: <linux-acpi+bounces-5945-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42228CC5A4
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E4F91F2237C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 May 2024 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D421422D5;
	Wed, 22 May 2024 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="DAsC82GC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631771422B6
	for <linux-acpi@vger.kernel.org>; Wed, 22 May 2024 17:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716399323; cv=none; b=WgFErHRX0ZOOraqO4nn3SaSFb7JRFtHpzAmbJQZ8xkmZb9JuxTXBi4nlQ8tghCAuXAMGO8yA9P4lNBM7prcdCvYK225v9/iZoH+LqgmO7pwvNYfNyRSDDFd6sgcZMqGG9cTctZn04rXYMzS7mQPVBw/ZmiaaCXAipSIaat87xuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716399323; c=relaxed/simple;
	bh=h4xDjoVBbGCwsS9xKPDSs0gCw1+IXJwG83x1dxLD/vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNMo4hDKQHORzql0eFbZQP5XwGAUVw61GDpoZGl0JLfdokho5VO5OQcEBZERlGpA5ShsfRitbBOCxJ0Xg6s/fKPW+URGzsksi7yON6tNgHxl4uUG5H+qH3KkeXA8Lx3hHz9DQtcZbEDL3NmEPOBCn+v7qKQyXeMpYwchjrqmD5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=DAsC82GC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f4f2b1c997so1598672b3a.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 May 2024 10:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1716399322; x=1717004122; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtcwHXQhuywjWtHL8fvX3LFZZ/ytDiic4eCWATEojeU=;
        b=DAsC82GCCi/9D+bWWykzRIg8kz1HH1AccNbltetZKDu2pJ+CJHlGbO7mm8hxJbP5bZ
         AZHKm6y+UGpt+sCXnLKMAjkeTg3O2JZveMZJQY9GmMFzHjZ7ahOvFOEr9e7rTy86wqgs
         Qwhpo8ryAuSdGCNMU7TRKJVI+VinDwA1CElmZOD26NxLQ22a6PWV0TLP1jdv7YGzsMKM
         HShunNEKq4FD+t/LaccNSLEQra0YDuwDXndEVu4tUs0qK5CSfH29xf2gOtNwBlxshyaH
         rfCUWuZLdfVgWGoLep1iTJ4psN7PkF6mjnixxg4fKpelWHJsfACTiHEdr6TXyIyfKxo9
         czEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716399322; x=1717004122;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtcwHXQhuywjWtHL8fvX3LFZZ/ytDiic4eCWATEojeU=;
        b=MrR5uSXJhWzOgDI45ceIdk1LIYSX0tla8V9YdogN/Op/0qS+0mC/KpnL8RlLeh9+10
         IUTBW2ekRndu9/ty1pPQ4MxT9u5n0ZLJqncRgTHf/MWFkn84GezgLlcvrgWQ+r06kxWz
         pQwCpnai4wUu7AaSgoiCw26/PCFkFDzZKZtbXP4d/m06ICVV031+lajZZeJo09hNAdmg
         fL4CLjLoKkoJ2ApbG7WztyyjMLgIiBou31leNfIwmYbBfvMnQZHrqFhKVrxXh/byxeDY
         K2ikyVSpI9LRftPRxnxX4dUSU2DFW5X4jnwzaQxZAPUBae/+ohf2MOBc2iXJ6gHl6tos
         YcKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrYhr0p82i8BzY61yW8XxiPZloXXgfV9bCRMe7LIHggGY52hDNnYdJZW3LrdZDUx0g+KjV8GscSSrxz9MVqAD/IjZYjHr2lbQ7kQ==
X-Gm-Message-State: AOJu0Yweq+hrvrlx+/F6Cc4N4vZuGDuAcNbdy066WqR00Vo+4ht9gaNV
	VyKC2wQfIqnNZacq8LvBWPQYQe3jqLmt6469cgehSfqbq6Xct0d7PmNtIo/W5vc=
X-Google-Smtp-Source: AGHT+IFnVExZ9w4FLsmZMki4aPDFIr85cfle6enyYjYsVAi4+pfoOCqX9NTQeS826YOJ4cg7meMOkA==
X-Received: by 2002:a05:6a00:3cc7:b0:6f3:ecdc:220e with SMTP id d2e1a72fcca58-6f6d617a507mr3058370b3a.24.1716399321714;
        Wed, 22 May 2024 10:35:21 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.31])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a9d976sm22673408b3a.89.2024.05.22.10.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 10:35:21 -0700 (PDT)
Date: Wed, 22 May 2024 23:05:03 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Haibo Xu <haibo1.xu@intel.com>
Cc: arnd@arndb.de, xiaobo55x@gmail.com, ajones@ventanamicro.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Greentime Hu <greentime.hu@sifive.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Evan Green <evan@rivosinc.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v3 5/6] ACPI: NUMA: change the ACPI_NUMA to a hidden
 option
Message-ID: <Zk4sxy4a5gy6ZfdJ@sunil-laptop>
References: <cover.1713778236.git.haibo1.xu@intel.com>
 <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3a005a67096010cf3c465f8e3362651763fe3b.1713778236.git.haibo1.xu@intel.com>

On Wed, Apr 24, 2024 at 01:46:25PM +0800, Haibo Xu wrote:
> x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> would do the same thing, so change it to a hidden option and the
> select statements except for the X86_64_ACPI_NUMA can also go away.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> ---
>  arch/arm64/Kconfig        | 1 -
>  arch/loongarch/Kconfig    | 1 -
>  drivers/acpi/numa/Kconfig | 5 +----
>  3 files changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 7b11c98b3e84..c6c667898da6 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1439,7 +1439,6 @@ config HOTPLUG_CPU
>  config NUMA
>  	bool "NUMA Memory Allocation and Scheduler Support"
>  	select GENERIC_ARCH_NUMA
> -	select ACPI_NUMA if ACPI
>  	select OF_NUMA
>  	select HAVE_SETUP_PER_CPU_AREA
>  	select NEED_PER_CPU_EMBED_FIRST_CHUNK
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index a5f300ec6f28..29d574a5c34c 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -465,7 +465,6 @@ config NR_CPUS
>  config NUMA
>  	bool "NUMA Support"
>  	select SMP
> -	select ACPI_NUMA if ACPI
>  	help
>  	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
>  	  support.  This option improves performance on systems with more
> diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
> index 849c2bd820b9..f33194d1e43f 100644
> --- a/drivers/acpi/numa/Kconfig
> +++ b/drivers/acpi/numa/Kconfig
> @@ -1,9 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config ACPI_NUMA
> -	bool "NUMA support"
> -	depends on NUMA
> -	depends on (X86 || ARM64 || LOONGARCH)
> -	default y if ARM64
> +	def_bool NUMA && !X86
>  
LGTM.

Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>

