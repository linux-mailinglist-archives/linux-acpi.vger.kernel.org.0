Return-Path: <linux-acpi+bounces-12730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 781CCA7B7CB
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 08:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EE97A7FF5
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 06:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E84187872;
	Fri,  4 Apr 2025 06:29:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45A3FF1;
	Fri,  4 Apr 2025 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743748163; cv=none; b=DHZ0DjiQCX9C0KkuZjki+4aK/a/VQfEUZXfabxZmrLPjPY1Y9fSDoBNL9/rzYKSbfgwzuM2Lb0c66JyNRRKQ7U8LTdpEoqler3XxJ9R+6OPheVIbgih5Q9uOMGzXrYO7PQ3GKPHTe5eqROE/I+CLRI3QQqlZN8t4KmCL8Fh5s3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743748163; c=relaxed/simple;
	bh=Rz1FHmu/xqulw9U0Of0xH8kGJD/eSjT8yc5MWWeHAjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sxkj6Q9ya9rfqlxCWl1bhycvBVVyvuAxNw+VLhlURrFGOwJ6OLdU3OglFFeGC0YJf3z1M0V68w9Dsl/aTQFSF9k3BBl7aKYnQj/z65tBCn900WLvbRVtMfii2pBLZDm2Ah+EWIn1d5PQO7MhTcnayHeWKEIPV23QGsDLq9wuQKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E19F31063;
	Thu,  3 Apr 2025 23:29:21 -0700 (PDT)
Received: from [10.162.40.17] (a077893.blr.arm.com [10.162.40.17])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FBC03F694;
	Thu,  3 Apr 2025 23:29:14 -0700 (PDT)
Message-ID: <b44b7241-cb97-49d4-986d-17dac4c463ae@arm.com>
Date: Fri, 4 Apr 2025 11:59:10 +0530
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, Jonathan.Cameron@huawei.com,
 dan.j.williams@intel.com, rppt@kernel.org, rafael@kernel.org,
 lenb@kernel.org, akpm@linux-foundation.org, alison.schofield@intel.com,
 rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com, david@redhat.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, chenbaozi@phytium.com.cn
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/25 14:51, Yuquan Wang wrote:
> With numa_add_reserved_memblk(), kernel could add numa_memblk into
> numa_reserved_meminfo directly.
> 
> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in suppot of future hotplug / CXL provisioning.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
> 
> Changes in v2 (Thanks to Dan):
> - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> - Add comments to describe the usage of numa_add_reserved_memblk()
> - Provide a more explicit commit message
> 
>  drivers/acpi/numa/srat.c     |  2 +-
>  include/linux/numa_memblks.h |  1 +
>  mm/numa_memblks.c            | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 00ac0d7bb8c9..70f1a7c6b54a 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -458,7 +458,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
>  		return -EINVAL;
>  	}
>  
> -	if (numa_add_memblk(node, start, end) < 0) {
> +	if (numa_add_reserved_memblk(node, start, end) < 0) {
>  		/* CXL driver must handle the NUMA_NO_NODE case */
>  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
>  			node, start, end);
> diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
> index dd85613cdd86..991076cba7c5 100644
> --- a/include/linux/numa_memblks.h
> +++ b/include/linux/numa_memblks.h
> @@ -22,6 +22,7 @@ struct numa_meminfo {
>  };
>  
>  int __init numa_add_memblk(int nodeid, u64 start, u64 end);
> +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end);
>  void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
>  
>  int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
> diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
> index ff4054f4334d..541a99c4071a 100644
> --- a/mm/numa_memblks.c
> +++ b/mm/numa_memblks.c
> @@ -200,6 +200,28 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
>  	return numa_add_memblk_to(nid, start, end, &numa_meminfo);
>  }
>  
> +/**
> + * numa_add_reserved_memblk - Add one numa_memblk to numa_reserved_meminfo
> + * @nid: NUMA node ID of the new memblk
> + * @start: Start address of the new memblk
> + * @end: End address of the new memblk
> + *
> + * Add a new memblk to the numa_reserved_meminfo.
> + *
> + * Usage Case: numa_cleanup_meminfo() reconciles all numa_memblk instances
> + * against memblock_type information and moves any that intersect reserved
> + * ranges to numa_reserved_meminfo. However, when that information is known
> + * ahead of time, we use numa_add_reserved_memblk() to add the numa_memblk
> + * to numa_reserved_meminfo directly.
> + *
> + * RETURNS:
> + * 0 on success, -errno on failure.
> + */
> +int __init numa_add_reserved_memblk(int nid, u64 start, u64 end)
> +{
> +	return numa_add_memblk_to(nid, start, end, &numa_reserved_meminfo);
> +}
> +
>  /**
>   * numa_cleanup_meminfo - Cleanup a numa_meminfo
>   * @mi: numa_meminfo to clean up

For the NUMA memblocks

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

