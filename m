Return-Path: <linux-acpi+bounces-7073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3422193D7D8
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E2D1F21453
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7061742A9B;
	Fri, 26 Jul 2024 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="YAqW6iKm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362E18AEA
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 17:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722016561; cv=none; b=C+PWwhWO0N8kfKCpu5YVSkLycwVJW8udIkj3+1Q/RyWCiiG/5zl6ur1Bs1gsoRpRsIOEA9UFq3okyw3Pex9VSQW2BuTqInnrxoQ5r+UWS+p95I/xZCBQooIbQeHpDEBHBLlQIwhMFGJR53QbJJ+rn+Q+z0h0JSDDgQloWrPtcOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722016561; c=relaxed/simple;
	bh=DqcOBh33ljlaLRitctg9JuRV8VvDI3UXWraIkBlH6mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGR0nhR0Dn667SE9T0+zukzozzidKR/u/5h4MbG61mVpcWO7sCCbk5YuWHHFNz9J9Fd9XOrtYMzGxlwJ+AEMM2SU43i1BU7syq4ttsK2AhhxHJ/P3sAc+kMNGihwp2zsiD8E0g+Dc8e20wWH1tDgqYNoKyskyeXezq/65pFVzU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=YAqW6iKm; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70365f905b6so931010a34.0
        for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 10:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1722016559; x=1722621359; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VTQsnDD9dOQ9aXW3fhwk4CaUxvGpW17OCJzKJw9Ccdc=;
        b=YAqW6iKmGGOHLRq/E3ejXTM/GsgLtR6DuGHmbNYZ7YzlHb+jtAjPIOCcrh+1+OP8NR
         axlcFiAyrf6Ve3DaUsuYymcn7tvRMekQxzM/qb1A/COsQa7HaizGzTYLwOv0FjONQ01N
         j54alZp2VXtlQbS0YoiYyEhPPNwVukTHyxuV33o2Pr6giVDmJELgcJOEG0bE59GFhu4N
         Rzbma9SkZqZoZVPoGo7QI+EYJeTe1EqzyiHQj4YaKAFXYgPM+mf25pXXKXLKbqzpjVsb
         wTcKak2kBG1oVmYIbK98VXCU+m9vl4tjUxacJwVjGRWhrY71ryehPWv5+FmKVceEluaW
         kxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722016559; x=1722621359;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTQsnDD9dOQ9aXW3fhwk4CaUxvGpW17OCJzKJw9Ccdc=;
        b=j7/fPox7OGnSl5DaxQBnaw8Q6f5VVLonZzzvQmJuMeLCGdlhbsdTplsWBD0A2Xcj1O
         A6ti6dInrurmGJ2ekOwErgSG1p5EUi8gi6SfQDA1AoOr5xeihei/BAJ96TGuMOhNq304
         lNe8vYlBIrU4Ks/a11pdyHVXzz5X2D/SH8ZKzJWzWZJ8JE81NjwGYGup0qEfJnusYtb9
         r6S3KsQqmxh4p/YhjSzIZgmueakOx7VI+BFxGHfvPWJS0umaPWLv9Au9lQ0b9pp6budK
         3n6LPjAMIxm3Mw5FWk6PsMUuHeZzY1/Cd+fyxpnJnZdMVkLBzOnXTrlJqfXBbuFWUy34
         K5sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfNGxRY8G81zklodcBLisOoRNZmK9lkXWS3jZVnLYYKi7B5nORnuiI/H8aCBVCS4fzktdUALFMKXEIkctrTwt2gWdzpFxMNf+Etw==
X-Gm-Message-State: AOJu0YzhyO30/BNtpu2oWKX1Ad3Mm7sT15y/2pcxc1yxljWSqoE4DOqI
	ZIaEReH4bPM1P7KV2aaS8eITPJ3Hx939o/ch8FZlclXO/01XAPYBMv3tVT4OrzM=
X-Google-Smtp-Source: AGHT+IHljkEgQv5ran0KLKmhGq/iyvIgPz7k7A6vSGQHnc+uRtB/kEThWLvH9PXh/6khJbW9A6aLjg==
X-Received: by 2002:a05:6830:6189:b0:704:47db:cd6d with SMTP id 46e09a7af769-70940c0892amr420224a34.1.1722016558854;
        Fri, 26 Jul 2024 10:55:58 -0700 (PDT)
Received: from sunil-laptop ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70930794a19sm839816a34.78.2024.07.26.10.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 10:55:58 -0700 (PDT)
Date: Fri, 26 Jul 2024 23:25:51 +0530
From: Sunil V L <sunilvl@ventanamicro.com>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: rename acpi_arm_init to acpi_arch_init
Message-ID: <ZqPjJy5YCuF02XNI@sunil-laptop>
References: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>
 <ZqPJLtGZQfxrIxhf@bogus>
 <DCBB5DD3-C6FD-4CE6-8C21-C4E218BD666E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DCBB5DD3-C6FD-4CE6-8C21-C4E218BD666E@gmail.com>

On Sat, Jul 27, 2024 at 12:39:03AM +0800, Miao Wang wrote:
> Hi,
> 
> Thanks for your quick reply.
> 
> > 2024年7月27日 00:05，Sudeep Holla <sudeep.holla@arm.com> 写道：
> > 
> > On Fri, Jul 26, 2024 at 11:03:01PM +0800, Miao Wang via B4 Relay wrote:
> >> From: Miao Wang <shankerwangmiao@gmail.com>
> >> 
> >> So that we avoid arch-specific code in general ACPI initialization flow.
> >> Other architectures can also have chance to define their own
> >> arch-specific acpi initialization process if necessary.
> >> 
> > 
> > Nice, but I assume you are adding something similar to another arch(riscv
> > or loongarch ?). It would be nice to have those changes as well together to
> > make it easy to understand the intention much quicker.
> 
> Yes, you are right about it. I'm trying to add some codes for loongarch,
> after DSDT is loaded and namespace is created, before the devices are
> enumerated, so I'll have chance to add a _DEP method to one of the device
> using acpi_install_method to provide compatibility for some early loongarch
> devices which are produced before the loongarch related ACPI standard is
> finalized.
> 
I have arch-specific initialization need for RISC-V as well. So, good to
see this patch!.

> > 
> >> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> >> ---
> >> arch/arm64/include/asm/acpi.h | 2 ++
> >> drivers/acpi/arm64/init.c     | 2 +-
> >> drivers/acpi/bus.c            | 2 +-
> >> include/linux/acpi.h          | 6 +++---
> >> 4 files changed, 7 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> >> index a407f9cd549e..0d24e920e143 100644
> >> --- a/arch/arm64/include/asm/acpi.h
> >> +++ b/arch/arm64/include/asm/acpi.h
> >> @@ -188,4 +188,6 @@ static inline void acpi_map_cpus_to_nodes(void) { }
> >> 
> >> #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
> >> 
> >> +#define ACPI_HAVE_ARCH_INIT
> >> +
> > 
> > There is nothing core arm66 arch specific in acpi_arm_init() and hence it
> > is in drivers/acpi/arm64. I would like to avoid adding anything in arch/arm64
> > if possible. Also I don't think we need to define this ACPI_HAVE_ARCH_INIT
> > 
> >> #endif /*_ASM_ACPI_H*/
> >> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> >> index d0c8aed90fd1..7a47d8095a7d 100644
> >> --- a/drivers/acpi/arm64/init.c
> >> +++ b/drivers/acpi/arm64/init.c
> >> @@ -2,7 +2,7 @@
> >> #include <linux/acpi.h>
> >> #include "init.h"
> >> 
> >> -void __init acpi_arm_init(void)
> >> +void __init acpi_arch_init(void)
> > 
> > Keep the name acpi_arm_init as is.
> > 
> >> {
> >> if (IS_ENABLED(CONFIG_ACPI_AGDI))
> >> acpi_agdi_init();
> >> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> >> index 284bc2e03580..662f69e379ef 100644
> >> --- a/drivers/acpi/bus.c
> >> +++ b/drivers/acpi/bus.c
> >> @@ -1458,7 +1458,7 @@ static int __init acpi_init(void)
> >> acpi_viot_early_init();
> >> acpi_hest_init();
> >> acpi_ghes_init();
> >> - acpi_arm_init();
> >> + acpi_arch_init();
> > 
> > Here we need acpi_arch_init() like you have changed.
> > 
> >> acpi_scan_init();
> >> acpi_ec_init();
> >> acpi_debugfs_init();
> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> >> index f0b95c76c707..3c3a83499c2d 100644
> >> --- a/include/linux/acpi.h
> >> +++ b/include/linux/acpi.h
> >> @@ -1517,10 +1517,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> >> }
> >> #endif
> >> 
> >> -#ifdef CONFIG_ARM64
> >> -void acpi_arm_init(void);
> >> +#ifdef ACPI_HAVE_ARCH_INIT
> >> +void acpi_arch_init(void);
> > 
> > This is bit inconsistent. The Makefile is still conditional on
> > CONFIG_ARM64 while here you move to ACPI_HAVE_ARCH_INIT.
> > So while not just undefine and redefine acpi_arch_init to acpi_arm_init.
> > Something like this must work ?
> > 
> > #define acpi_arch_init() do { }while(0)
> > 
> > #ifdef CONFIG_ARM64
> > #undef acpi_arch_init
> > #define acpi_arch_init() acpi_arm_init()
> > #endif
> 
> It will work. However I can see the pattern in other parts, where
> the definition of a macro named HAVE_xxx is checked, and define an
> inline static function with empty body if such macro is not defined
> or define a function prototype with the same name otherwise, like
> acpi_arch_set_root_pointer. I'm just trying to follow this pattern.
> 
I was thinking to make it weak function similar to cpc_read_ffh().
Wouldn't it be better than ifdefery?

Thanks
Sunil

