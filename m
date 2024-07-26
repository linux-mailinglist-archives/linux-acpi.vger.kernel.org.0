Return-Path: <linux-acpi+bounces-7059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F86893D686
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 18:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B95C283DB6
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jul 2024 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07725588B;
	Fri, 26 Jul 2024 16:05:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564001F95A
	for <linux-acpi@vger.kernel.org>; Fri, 26 Jul 2024 16:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722009909; cv=none; b=R2DFZndzGmAFUs6Qk1DI9YEcj68PnimcIOLzfbF9kPpC9GGqQO13YUQcGmQeClxVAPvMD8lWyc/RLMcffLZKTNgnx+Ad5/1H9gXM7RhbMcfXne5zyXoOnwBWJpLz7r3YpZclmWI3QCOyH37rQkG92HT5tWhLv/SsKtWjNL2cDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722009909; c=relaxed/simple;
	bh=xXApZ9YGMhq9qjcLIvt6XBrsqUSUwsYwZsWn0dIC8O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0Ydyj+mid7M/d025IDT3EoPhIiv3Jhh9WP+PwOwLhXFeFoBRla1yIPgdrLnArhk3xfjrd9B9GOdw6qot8n4VjXGzmkxHCGphryCgZanxukPrGvoHz8Uc+uZFuuqopxkn2MN9QWQdyCPG4UAq2z8+BbuEgCz43Mmp2fikCdw2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9C5D1007;
	Fri, 26 Jul 2024 09:05:31 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DE9D3F766;
	Fri, 26 Jul 2024 09:05:04 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:05:02 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: shankerwangmiao@gmail.com
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>, Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] ACPI: rename acpi_arm_init to acpi_arch_init
Message-ID: <ZqPJLtGZQfxrIxhf@bogus>
References: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446b96d0-4b61-11ef-9239-3f7ac1938848@innull.com>

On Fri, Jul 26, 2024 at 11:03:01PM +0800, Miao Wang via B4 Relay wrote:
> From: Miao Wang <shankerwangmiao@gmail.com>
> 
> So that we avoid arch-specific code in general ACPI initialization flow.
> Other architectures can also have chance to define their own
> arch-specific acpi initialization process if necessary.
> 

Nice, but I assume you are adding something similar to another arch(riscv
or loongarch ?). It would be nice to have those changes as well together to
make it easy to understand the intention much quicker.

> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> ---
>  arch/arm64/include/asm/acpi.h | 2 ++
>  drivers/acpi/arm64/init.c     | 2 +-
>  drivers/acpi/bus.c            | 2 +-
>  include/linux/acpi.h          | 6 +++---
>  4 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index a407f9cd549e..0d24e920e143 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -188,4 +188,6 @@ static inline void acpi_map_cpus_to_nodes(void) { }
>  
>  #define ACPI_TABLE_UPGRADE_MAX_PHYS MEMBLOCK_ALLOC_ACCESSIBLE
>  
> +#define ACPI_HAVE_ARCH_INIT
> +

There is nothing core arm66 arch specific in acpi_arm_init() and hence it
is in drivers/acpi/arm64. I would like to avoid adding anything in arch/arm64
if possible. Also I don't think we need to define this ACPI_HAVE_ARCH_INIT

>  #endif /*_ASM_ACPI_H*/
> diff --git a/drivers/acpi/arm64/init.c b/drivers/acpi/arm64/init.c
> index d0c8aed90fd1..7a47d8095a7d 100644
> --- a/drivers/acpi/arm64/init.c
> +++ b/drivers/acpi/arm64/init.c
> @@ -2,7 +2,7 @@
>  #include <linux/acpi.h>
>  #include "init.h"
>  
> -void __init acpi_arm_init(void)
> +void __init acpi_arch_init(void)

Keep the name acpi_arm_init as is.

>  {
>  	if (IS_ENABLED(CONFIG_ACPI_AGDI))
>  		acpi_agdi_init();
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 284bc2e03580..662f69e379ef 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1458,7 +1458,7 @@ static int __init acpi_init(void)
>  	acpi_viot_early_init();
>  	acpi_hest_init();
>  	acpi_ghes_init();
> -	acpi_arm_init();
> +	acpi_arch_init();

Here we need acpi_arch_init() like you have changed.

>  	acpi_scan_init();
>  	acpi_ec_init();
>  	acpi_debugfs_init();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f0b95c76c707..3c3a83499c2d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1517,10 +1517,10 @@ static inline int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
>  }
>  #endif
>  
> -#ifdef CONFIG_ARM64
> -void acpi_arm_init(void);
> +#ifdef ACPI_HAVE_ARCH_INIT
> +void acpi_arch_init(void);

This is bit inconsistent. The Makefile is still conditional on
CONFIG_ARM64 while here you move to ACPI_HAVE_ARCH_INIT.
So while not just undefine and redefine acpi_arch_init to acpi_arm_init.
Something like this must work ?

#define acpi_arch_init()	do { }while(0)

#ifdef CONFIG_ARM64
#undef acpi_arch_init
#define acpi_arch_init()	acpi_arm_init()
#endif

--
Regards,
Sudeep

