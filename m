Return-Path: <linux-acpi+bounces-16521-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD00B4A56A
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 10:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB5E178ADD
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 08:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3225393C;
	Tue,  9 Sep 2025 08:35:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44F24A21;
	Tue,  9 Sep 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406942; cv=none; b=uLPPUaeFKjncDHsm81x3oRP9gd6g4qkl3RjQHXTgihvLN0I/E8dy4Ski/lWw3DFdfzO/dWgiS/dRnXaObyeRYxjcJbQoz8e8OVEEfFbE+/mBKGUhzOJrgEY37nTEWSfGXyIhbEdYKQAuynQ1dCf0cIQWoDC5UlLT83K8RBqfjtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406942; c=relaxed/simple;
	bh=EHGrgJIMU/49g/fvCbuGK+jZbVlWQLMceCgu9ynPzJA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lmet1335innPcLOSJculz0IeoRmI1ZeWjTE6DrVgl/3nS0wZ7RQFl5zhabL/G4KZlH9Y+u9wjXbhLU6tQbw0dqi1xIx5G32KhZVZrDT7PtVYXQJZr9yBzLFxNB9P/DWkdMDvJFDC8wXPSD4RCDyMHBt2Hz5qaPxZvNdeSRr3qqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cLcWj6pbbz1R9GS;
	Tue,  9 Sep 2025 16:32:33 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 0CA0E180044;
	Tue,  9 Sep 2025 16:35:36 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Sep 2025 16:35:35 +0800
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: Allow all types of addresses except
 MMIO
To: Jiaqi Yan <jiaqiyan@google.com>, <tony.luck@intel.com>,
	<rafael@kernel.org>
CC: <dan.j.williams@intel.com>, <bp@alien8.de>, <mchehab@kernel.org>,
	<xueshuai@linux.alibaba.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20250830030226.918555-1-jiaqiyan@google.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <bc8ad4b8-c000-0298-efd1-4a332c4c7820@huawei.com>
Date: Tue, 9 Sep 2025 16:35:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250830030226.918555-1-jiaqiyan@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/8/30 11:02, Jiaqi Yan wrote:
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

...

> Changelog
> 
> v1 [1] -> v2:
> - In addition to allow IORES_DESC_PERSISTENT_MEMORY_LEGACY, open the
>    door wider and only exclude MMIO per suggestion from Tony [2]
> - Rebased to commit 11e7861d680c ("Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm")
> 
> [1] https://lore.kernel.org/linux-acpi/20250825223348.3780279-1-jiaqiyan@google.com
> [2] https://lore.kernel.org/linux-acpi/SJ1PR11MB60835824926BEE57F094DE6FFC39A@SJ1PR11MB6083.namprd11.prod.outlook.com

For the Changelog, it's better to move it to below...

> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---

... here.

>   drivers/acpi/apei/einj-core.c | 50 +++++++++++++++++++++++++++++------
>   1 file changed, 42 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 2561b045acc7b..904930409fdb2 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -656,6 +656,44 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
> +		IORES_DESC_CXL,

Sorry, I'm not familiar with CXL, but I see the code in einj_error_inject():

/*
  * Injections targeting a CXL 1.0/1.1 port have to be injected
  * via the einj_cxl_rch_error_inject() path as that does the proper
  * validation of the given RCRB base (MMIO) address.
  */
if (einj_is_cxl_error_type(type) && (flags & SETWA_FLAGS_MEM))
	return -EINVAL;

So eject an error for CXL memory, there is a new interface which
means it's not handled here, do we need to remove IORES_DESC_CXL?

Thanks
Hanjun

