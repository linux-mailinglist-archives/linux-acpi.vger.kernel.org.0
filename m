Return-Path: <linux-acpi+bounces-16584-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB403B51B09
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 17:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66715A0717D
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 15:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD0933768B;
	Wed, 10 Sep 2025 14:57:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBF32C33B;
	Wed, 10 Sep 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757516244; cv=none; b=nQqVZ3dGtiKKIE96NliPfKrGoZIDTu5i2FgyY5eO0EdJwqL2/O0c3Qy1p2E1XqMveWO3OSrGTn7PzlOfWg/8f757SGMxWGiIlfwZil3rqQRH4JRkVMfJ8tpIZtiFv0cW+kB1foMxUE0WY9iWSrCb78pdF0uYs/rlTuK+XJA2kPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757516244; c=relaxed/simple;
	bh=i9kGLzuwhgZ00stfvmGeDFvOj/l2RLR+XHCvs78CoAU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Y1YvasOvhViOdMycswQYBKu6+8HpWAZBj/DQduxGaON2g9PJen5RWYA9cTa1dO/keFegUzwqISgCUhDAJHGgraVwyuHbGtnsatHB6x4E0oiHJXNPBqIUHBVHIsyJCZrsbh87hD8ZTCJzPl+kKOyr11HpyGEA+j0B/EaqZ4s0eAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cMNvm1wDvzRkFf;
	Wed, 10 Sep 2025 22:52:36 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 45D53180B63;
	Wed, 10 Sep 2025 22:57:13 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Sep 2025 22:57:12 +0800
Subject: Re: [PATCH v3] ACPI: APEI: EINJ: Allow more types of addresses except
 MMIO
To: Jiaqi Yan <jiaqiyan@google.com>, <tony.luck@intel.com>,
	<rafael@kernel.org>
CC: <dan.j.williams@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250910044531.264043-1-jiaqiyan@google.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <88893809-ed13-dbb9-2446-8fd680f57693@huawei.com>
Date: Wed, 10 Sep 2025 22:57:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250910044531.264043-1-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/9/10 12:45, Jiaqi Yan wrote:
> EINJ driver today only allows injection request to go through for two
> kinds of IORESOURCE_MEM: IORES_DESC_PERSISTENT_MEMORY and
> IORES_DESC_SOFT_RESERVED. This check prevents user of EINJ to test
> memory corrupted in many interesting areas:
> 
> - Legacy persistent memory
> - Memory claimed to be used by ACPI tables or NV storage
> - Kernel crash memory and others
> 
> There is need to test how kernel behaves when something consumes memory
> errors in these memory regions. For example, if certain ACPI table is
> corrupted, does kernel crash gracefully to prevent "silent data
> corruption". For another example, legacy persistent memory, when managed
> by Device DAX, does support recovering from Machine Check Exception
> raised by memory failure, hence worth to be tested.
> 
> However, attempt to inject memory error via EINJ to legacy persistent
> memory or ACPI owned memory fails with -EINVAL.
> 
> Allow EINJ to inject at address except it is MMIO. Leave it to the BIOS
> or firmware to decide what is a legitimate injection target.
> 
> In addition to the test done in [1], on a machine having the following
> iomem resources:
> 
>      ...
>      01000000-08ffffff : Crash kernel
>      768f0098-768f00a7 : APEI EINJ
>      ...
>    768f4000-77323fff : ACPI Non-volatile Storage
>    77324000-777fefff : ACPI Tables
>    777ff000-777fffff : System RAM
>    77800000-7fffffff : Reserved
>    80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
>    90040000-957fffff : PCI Bus 0000:00
>    ...
>    300000000-3ffffffff : Persistent Memory (legacy)
>    ...
> 
> I commented __einj_error_inject during the test and just tested when
> injecting a memory error at each start address shown above:
> - 0x80000000 and 0x90040000 both failed with EINVAL
> - request passed through for all other addresses
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
> 
> Changelog
> 
> v2 [2] -> v3:
> - Remove unnecessary IORES_DESC_CXL per comment from Hanjun [3].
> - Minor update to code comment.
> 
> v1 [1] -> v2:
> - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
>    door wider and only exclude MMIO per suggestion from Tony [4].
> - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm").
> 
> [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiyan@google.com
> [2] https://lore.kernel.org/linux-acpi/20250830030226.918555-1-jiaqiyan@google.com
> [3] https://lore.kernel.org/linux-acpi/bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com
> [4] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com
> 
> drivers/acpi/apei/einj-core.c | 51 ++++++++++++++++++++++++++++-------
>   1 file changed, 42 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2561b045acc7b..3c87953dbd197 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -656,6 +656,43 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>   	return rc;
>   }
>   
> +/* Allow almost all types of address except MMIO. */
> +static bool is_allowed_range(u64 base_addr, u64 size)
> +{
> +	int i;
> +	/*
> +	 * MMIO region is usually claimed with IORESOURCE_MEM + IORES_DESC_NONE.
> +	 * However, IORES_DESC_NONE is treated like a wildcard when we check if
> +	 * region intersects with known resource. So do an allow list check for
> +	 * IORES_DESCs that definitely or most likely not MMIO.
> +	 */
> +	int non_mmio_desc[] = {
> +		IORES_DESC_CRASH_KERNEL,
> +		IORES_DESC_ACPI_TABLES,
> +		IORES_DESC_ACPI_NV_STORAGE,
> +		IORES_DESC_PERSISTENT_MEMORY,
> +		IORES_DESC_PERSISTENT_MEMORY_LEGACY,
> +		/* Treat IORES_DESC_DEVICE_PRIVATE_MEMORY as MMIO. */
> +		IORES_DESC_RESERVED,
> +		IORES_DESC_SOFT_RESERVED,
> +	};
> +
> +	if (region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
> +			      == REGION_INTERSECTS)
> +		return true;
> +
> +	for (i = 0; i < ARRAY_SIZE(non_mmio_desc); ++i) {
> +		if (region_intersects(base_addr, size, IORESOURCE_MEM, non_mmio_desc[i])
> +				      == REGION_INTERSECTS)
> +			return true;
> +	}
> +
> +	if (arch_is_platform_page(base_addr))
> +		return true;
> +
> +	return false;
> +}
> +
>   /* Inject the specified hardware error */
>   int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>   		      u64 param4)
> @@ -702,19 +739,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>   	 * Disallow crazy address masks that give BIOS leeway to pick
>   	 * injection address almost anywhere. Insist on page or
>   	 * better granularity and that target address is normal RAM or
> -	 * NVDIMM.
> +	 * as long as is not MMIO.

Thanks for updating this as well.

>   	 */
>   	base_addr = param1 & param2;
>   	size = ~param2 + 1;
>   
> -	if (((param2 & PAGE_MASK) != PAGE_MASK) ||
> -	    ((region_intersects(base_addr, size, IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE)
> -				!= REGION_INTERSECTS) &&
> -	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_PERSISTENT_MEMORY)
> -				!= REGION_INTERSECTS) &&
> -	     (region_intersects(base_addr, size, IORESOURCE_MEM, IORES_DESC_SOFT_RESERVED)
> -				!= REGION_INTERSECTS) &&
> -	     !arch_is_platform_page(base_addr)))
> +	if ((param2 & PAGE_MASK) != PAGE_MASK)
> +		return -EINVAL;
> +
> +	if (!is_allowed_range(base_addr, size))
>   		return -EINVAL;
>   
>   	if (is_zero_pfn(base_addr >> PAGE_SHIFT))

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

