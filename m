Return-Path: <linux-acpi+bounces-13600-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77EAAE691
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE0B2170207
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF22128B7FD;
	Wed,  7 May 2025 16:24:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9B28980B;
	Wed,  7 May 2025 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635086; cv=none; b=reJqCCsE6Q9DidFv3i59Ms/1j8EC3zuWpKxvvD64etc5fBppFFri7DX1FLrTL4y4InEUdMGDR72lnl45WMgxZJoC9w/zcHEZlEAuOD5ySZvu32xh4u81g+F4MK80lqf71X5NPrzb/zLu26bc7RIX5NgWbI+0FZT6K6wCNIiGxB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635086; c=relaxed/simple;
	bh=oBYNTIRvr0qn3RLc15igFSD5nLZ7U8eh2ms4fvyrDJQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UksrhAmFr8/NbIWlf52VZX1lKiHfD3suEOACc6ZZNhSyJcnigRhfqlqukEEIr96pFplDd97KAug1c7fpfrF3fg6ND8VEYPAAu7wDC9i1qgxO49LCTgHoJvDv3k/a3TBTQOMSYAa0xZX0qnmL0QBPNdHTmGi7YsBKZe8PU+ujwAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zt0pv0HkCz6M4d4;
	Thu,  8 May 2025 00:20:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 50B6C140518;
	Thu,  8 May 2025 00:24:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 7 May
 2025 18:24:37 +0200
Date: Wed, 7 May 2025 17:24:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <dan.j.williams@intel.com>, <rppt@kernel.org>, <rafael@kernel.org>,
	<lenb@kernel.org>, <akpm@linux-foundation.org>, <alison.schofield@intel.com>,
	<rrichter@amd.com>, <bfaccini@nvidia.com>, <haibo1.xu@intel.com>,
	<david@redhat.com>, <chenhuacai@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <chenbaozi@phytium.com.cn>, <loongarch@lists.linux.dev>
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <20250507172436.00003888@huawei.com>
In-Reply-To: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
References: <20250506062245.3816791-1-wangyuquan1236@phytium.com.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 6 May 2025 14:22:45 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> acpi_parse_cfmws() currently adds empty CFMWS ranges to numa_meminfo
> with the expectation that numa_cleanup_meminfo moves them to
> numa_reserved_meminfo. There is no need for that indirection when it is
> known in advance that these unpopulated ranges are meant for
> numa_reserved_meminfo in support of future hotplug / CXL provisioning.
> 
> Introduce and use numa_add_reserved_memblk() to add the empty CFMWS
> ranges directly.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
This is v2 take 2.  There were tags on the previous version (pre longarch
change).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

(Also Dan Williams).

Easiest option when this happens is spin a v3 with a change log to
say the loongarch issue is resolved and you picked up tags.


> ---
> 
> Changes in v2 (Thanks to Dan & Alison):
> - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> - Add comments to describe the usage of numa_add_reserved_memblk()
> - Updating the commit message to clarify the purpose of the patch
> 
> By the way, "LoongArch: Introduce the numa_memblks conversion" is in linux-next.
> 
>  drivers/acpi/numa/srat.c     |  2 +-
>  include/linux/numa_memblks.h |  1 +
>  mm/numa_memblks.c            | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 0a725e46d017..751774f0b4e5 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -453,7 +453,7 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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


