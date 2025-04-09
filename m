Return-Path: <linux-acpi+bounces-12895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7752CA82131
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 11:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E324A81C2
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Apr 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCF025484C;
	Wed,  9 Apr 2025 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz4G8OLX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD01E2858;
	Wed,  9 Apr 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191795; cv=none; b=NXr0AfcFdQSYd9OZnEN+8cWxdPyJcTBYCyFeSZe5p4Y3HunO8441oSWrSd/t+wNelPE4GGYozsmQtuESYNVaSweIe2Dnm5+Cv5iRTS+PpB6I2dFT4XG5V/Pg7a3OhFV1WFgOGcoH+giyAEkX4w66ls/RCim/V8mPU/8bUelgaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191795; c=relaxed/simple;
	bh=FjJ4QbW9SU1iP+ML3U0A+ucRm2GiU0e71LPKaPgthFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9uIxhsaykid0/I+Foi1W9ZB3if08gqJMuMRtAmkZUSmxZr2bZXu3vs+FJA6O+ZyRXz+/6vYPtAJm/EmvCQ+KnEhAGRN0YzEYsj8uQXjxRBbMMtHrSRf4rUQzD4P06nYU5kuGhC1k1wLqQrVBCmllUxRFcxJd/sfGI1NlnfVI0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz4G8OLX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D74C4CEE3;
	Wed,  9 Apr 2025 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744191795;
	bh=FjJ4QbW9SU1iP+ML3U0A+ucRm2GiU0e71LPKaPgthFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tz4G8OLX8nnog0v22oBwDuD3JId5z/TPCCskKfAVQorpXd7wLsaFqhlnrza8EuDMr
	 LjSnxnsFChBhBrq58wtx6DvwfQsfs7tAiWIIKakzb9Xg9v5uRbB8qkgMkPeZwtzxaQ
	 TVhfhlHk1twuHM91sNPkjfQ6MjrSyV2+6ZvkUlgZUkYqmtQQRiZQgb5yhbxsBEmuMN
	 rAIwMAQPKjWVXqAhNsd794HAiVN0G2Eoq/x4eOZgFSgw5Vy7MDHX7QTtaerCV8vohN
	 OGG1pkLzIMzw5GUh6ZL01fFSd/lTo7OpijYZUThfFL+l7TLpzEAExukEGjyXZj6dH0
	 87Ol5Ac251Mdg==
Date: Wed, 9 Apr 2025 12:43:06 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, david@redhat.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, chenbaozi@phytium.com.cn,
	loongarch@lists.linux.dev
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <Z_ZBKl8h_BzrW9yG@kernel.org>
References: <20250409040121.3212489-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409040121.3212489-1-wangyuquan1236@phytium.com.cn>

On Wed, Apr 09, 2025 at 12:01:21PM +0800, Yuquan Wang wrote:
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

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Changes in v2 (Thanks to Dan & Alison):
> - Use numa_add_reserved_memblk() to replace numa_add_memblk() in acpi_parse_cfmws()
> - Add comments to describe the usage of numa_add_reserved_memblk()
> - Updating the commit message to clarify the purpose of the patch
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
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

