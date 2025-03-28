Return-Path: <linux-acpi+bounces-12535-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08509A7529C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 23:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A094E17271B
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 22:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE07C1F4170;
	Fri, 28 Mar 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGyNjFrs"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C501B1EEA5D;
	Fri, 28 Mar 2025 22:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743202411; cv=none; b=PiOQa0I7yT6YKA0YOESOtXpeSgyxUBCRD3cgsM67pg0v2TBz6R8MtMlfzOXRcjKXNU8CIuAiHc7f6tnC/x/IzqIAibxkg8Kl4uPnH4HryE5mzHdOfMsEo3GW51msUMJjCiT2qH3y0HCUz456aWoMu/neyDta15KJgaX9VeCBRvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743202411; c=relaxed/simple;
	bh=X8QzRMcFsniUFRx5vA7MHEqQC/yTTdlJQdKOdbyOdCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a255wv3hLMdp5kAKe701QlWUCuMmN253We5NZ8kjV7ciPv1pLFnu/FpTn8EjGL0p0s3BgtXW0RAqwJv3FUqJTYCMgpssZHVokYNtBNPXKTMax4EbTTnk3arBhRQHoIxS+ueqnx5OJN3Km/vDshTKrZlckbipGdXQ/YOGXWE2NB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGyNjFrs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2604C4CEE4;
	Fri, 28 Mar 2025 22:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743202411;
	bh=X8QzRMcFsniUFRx5vA7MHEqQC/yTTdlJQdKOdbyOdCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oGyNjFrsB84ZD2gSZSoDKhui0JmIK/RMefONuzx6vRZDoAXKClqQ8TWFqrqfecofS
	 kL1GFnZk6s0cNy3nP/etxlUOrkZousXfaWLtxsZUd9Ky3zRHfXOkxGHIsGffdsehIV
	 8HcUnkAhXxaPDlduhMDsLRkh2y8FfUXo2QcxmEB+sw7RzwujnrKxx3itYVyoO80wXu
	 UZthIA3EpRHjHqn3NdKK5uK4RITBpuDVCDt0oYqOrvFD5qeWLEwkwkwk1lzeCeJL9K
	 Ob46hbj6s9Wt2FyqUME251vPI20EViHGEXPFwLsfvs3R728YUanJk2B85OcbRW1ihp
	 AW8/fn5c7x01Q==
Date: Sat, 29 Mar 2025 01:53:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rafael@kernel.org, lenb@kernel.org, akpm@linux-foundation.org,
	alison.schofield@intel.com, rrichter@amd.com, bfaccini@nvidia.com,
	haibo1.xu@intel.com, david@redhat.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	chenbaozi@phytium.com.cn
Subject: Re: [PATCH v2] mm: numa_memblks: introduce numa_add_reserved_memblk
Message-ID: <Z-coYimFFwK0q5dr@kernel.org>
References: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328092132.2695299-1-wangyuquan1236@phytium.com.cn>

On Fri, Mar 28, 2025 at 05:21:32PM +0800, Yuquan Wang wrote:
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

For numa_memblks

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

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
> -- 
> 2.34.1
> 
> 

-- 
Sincerely yours,
Mike.

