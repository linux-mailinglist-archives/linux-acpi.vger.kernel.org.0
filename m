Return-Path: <linux-acpi+bounces-5695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EA28C11B0
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 17:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0730C28235F
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 15:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 844B712FF9B;
	Thu,  9 May 2024 15:09:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4252BCE3;
	Thu,  9 May 2024 15:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715267346; cv=none; b=d4oTUf7JvaTeZCfPfuKBpvU0ONEEi57iHxDAbfnc+tK0HuTxoyb9kNKa1P9NHUZzulaEMnRRnG97Wy6gKX3Wr7Fx0ZHWUachqPRohHEAWmdXkb236xQ2qLyRx2C5FOVuCk4zcpkQOmXCmTqYZTCoWunYwU4Nmm1LMa8ftPdBp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715267346; c=relaxed/simple;
	bh=XxiTctms0UHhDzc55pGt0O8Wzfmfftzf1auL80To9Ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2/Go54JA2OWaOP7d033jJbrPrnntYFrrkeTtt+ymqpmpDU5KAFCqPESNHds0cGnhSYT0jRay3K4woK/7d//3yX825agj8uUBR6X/Y6xe9dW9suM//qO5f/PwzFXghZ1C1mgsjZwyW9A8OaPCEL5dkgaxIJLdMz3MZyn9ZP6XYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34D59106F;
	Thu,  9 May 2024 08:09:29 -0700 (PDT)
Received: from [172.27.42.162] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 979AB3F641;
	Thu,  9 May 2024 08:09:02 -0700 (PDT)
Message-ID: <571d0194-dd3e-4a68-8879-d6b66276afe5@arm.com>
Date: Thu, 9 May 2024 10:09:01 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] riscv: cacheinfo: initialize cacheinfo's level and
 type from ACPI PPTT
Content-Language: en-US
To: Yunhui Cui <cuiyunhui@bytedance.com>, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, sunilvl@ventanamicro.com,
 aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org, bhelgaas@google.com,
 james.morse@arm.com, jhugo@codeaurora.org, john.garry@huawei.com,
 Jonathan.Cameron@huawei.com, pierre.gondois@arm.com, sudeep.holla@arm.com,
 tiantao6@huawei.com
Cc: Conor Dooley <conor.dooley@microchip.com>
References: <20240509073300.4968-1-cuiyunhui@bytedance.com>
 <20240509073300.4968-2-cuiyunhui@bytedance.com>
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20240509073300.4968-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 5/9/24 02:32, Yunhui Cui wrote:
> Before cacheinfo can be built correctly, we need to initialize level
> and type. Since RISC-V currently does not have a register group that
> describes cache-related attributes like ARM64, we cannot obtain them
> directly, so now we obtain cache leaves from the ACPI PPTT table
> (acpi_get_cache_info()) and set the cache type through split_levels.
> 
> Suggested-by: Jeremy Linton <jeremy.linton@arm.com>
> Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>   arch/riscv/kernel/cacheinfo.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 30a6878287ad..d6c108c50cba 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2017 SiFive
>    */
>   
> +#include <linux/acpi.h>
>   #include <linux/cpu.h>
>   #include <linux/of.h>
>   #include <asm/cacheinfo.h>
> @@ -78,6 +79,27 @@ int populate_cache_leaves(unsigned int cpu)
>   	struct device_node *prev = NULL;
>   	int levels = 1, level = 1;
>   
> +	if (!acpi_disabled) {
> +		int ret, fw_levels, split_levels;
> +
> +		ret = acpi_get_cache_info(cpu, &fw_levels, &split_levels);
> +		if (ret)
> +			return ret;
> +
> +		BUG_ON((split_levels > fw_levels) ||
> +		       (split_levels + fw_levels > this_cpu_ci->num_leaves));
> +
> +		for (; level <= this_cpu_ci->num_levels; level++) {
> +			if (level <= split_levels) {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> +			} else {
> +				ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> +			}
> +		}
> +		return 0;
> +	}
> +
>   	if (of_property_read_bool(np, "cache-size"))
>   		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
>   	if (of_property_read_bool(np, "i-cache-size"))


Yes, still looks good.

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks,


