Return-Path: <linux-acpi+bounces-16579-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9742B51832
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 15:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2803B07F1
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 13:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8821E31E0E5;
	Wed, 10 Sep 2025 13:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf/LWaAR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2B91494CC;
	Wed, 10 Sep 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757511888; cv=none; b=Gj/eXX8bYfubLJmyQXdF1WgJePqPbPFJ6rZ2FU1cIAe+bHf1F/+/6jMrCzuy9IT/H0UXCuMt0WOVX4FGi7zOt1apgMndDR6C1matUchqVmafSXg3jXSQ81RXq/hsHKqhud7N3/Hao9PCCm05Hfzfkd2F8DhO9ffWLspVw4BuHhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757511888; c=relaxed/simple;
	bh=lQtS1uAvZyCIoOaVmx4Kjk/94Sw+HBfw4GcgLVbEaBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awjqoHYh6+Hd1HeAKZBDXrQbDjvYGyrLrdwABuLD7BEkvLmCtfT/pGiIaKPkks+/4ZqczAcklUxkQwy1uKO26vU1Tog9W8iHr8hH3+N2HNbV+1HvoZa53cPT6rHv8nZ/UFAXSouZ1bNP3KL42Yh249kdcxLuoWUXIeh3FL9oWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf/LWaAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A457C4CEF0;
	Wed, 10 Sep 2025 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757511886;
	bh=lQtS1uAvZyCIoOaVmx4Kjk/94Sw+HBfw4GcgLVbEaBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lf/LWaARgNYUiFbHFsFtVjyFH8HFYjWCzyl1Y41QLK+pYBfO5yQs0F4JyuMrT0vlZ
	 nxXzMsM7ujPcVBkPiVsfRCvmcRbPxqvh+hL8VDf1pl4x68gtJf1/40DuKCZvI7dg6v
	 txKPIb8/FgUR+Kc1e/v0dKCHAwNZGfL+v0SZoh75LkO8X0eu2J6a3DHSimPml/E7Kq
	 MMh+8z6eijjQ9DKcmgRbB8z8k6MFHLdKmeSblm/VQdK4ADEdZDN8dNLe4cJOouSsHz
	 mwP0zzSco/lp97bKe1ipPtEXDcQbsJrgkA3W+EXAtaVo4AWXdr7CQXIPReD6WP2Q/L
	 t+pxtFM7t41IQ==
Date: Wed, 10 Sep 2025 15:44:35 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 04/33] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
Message-ID: <aMGAw4+/IAWBPiqn@lpieralisi>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-39-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-39-james.morse@arm.com>

On Fri, Aug 22, 2025 at 03:30:19PM +0000, James Morse wrote:
> acpi_count_levels() passes the number of levels back via a pointer argument.
> It also passes this to acpi_find_cache_level() as the starting_level, and
> preserves this value as it walks up the cpu_node tree counting the levels.
> 
> This means the caller must initialise 'levels' due to acpi_count_levels()
> internals. The only caller acpi_get_cache_info() happens to have already
> initialised levels to zero, which acpi_count_levels() depends on to get the
> correct result.
> 
> Two results are passed back from acpi_count_levels(), unlike split_levels,
> levels is not optional.
> 
> Split these two results up. The mandatory 'levels' is always returned,
> which hides the internal details from the caller, and avoids having
> duplicated initialisation in all callers. split_levels remains an
> optional argument passed back.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> 
> ---
> Changes since RFC:
>  * Made acpi_count_levels() return the levels value.
> ---
>  drivers/acpi/pptt.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4791ca2bdfac..8f9b9508acba 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -181,10 +181,10 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   * levels and split cache levels (data/instruction).
>   * @table_hdr: Pointer to the head of the PPTT table
>   * @cpu_node: processor node we wish to count caches for
> - * @levels: Number of levels if success.
>   * @split_levels:	Number of split cache levels (data/instruction) if
> - *			success. Can by NULL.
> + *			success. Can be NULL.

Nit: tempting but this change does not belong here.

>   *
> + * Returns number of levels.
>   * Given a processor node containing a processing unit, walk into it and count
>   * how many levels exist solely for it, and then walk up each level until we hit
>   * the root node (ignore the package level because it may be possible to have
> @@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   * split cache levels (data/instruction) that exist at each level on the way
>   * up.
>   */
> -static void acpi_count_levels(struct acpi_table_header *table_hdr,
> -			      struct acpi_pptt_processor *cpu_node,
> -			      unsigned int *levels, unsigned int *split_levels)
> +static int acpi_count_levels(struct acpi_table_header *table_hdr,
> +			     struct acpi_pptt_processor *cpu_node,
> +			     unsigned int *split_levels)
>  {
> +	int starting_level = 0;
> +
>  	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, &starting_level, split_levels, 0, 0);
>  		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>  	} while (cpu_node);
> +
> +	return starting_level;
>  }
>  
>  /**
> @@ -731,7 +735,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>  	if (!cpu_node)
>  		return -ENOENT;
>  
> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> +	*levels = acpi_count_levels(table, cpu_node, split_levels);

Looks fine to me - though initializing

*levels = 0

upper in the function now becomes superfluous (?) (well, it initializes
*levels to 0 if an error path is hit but on that case the caller should
not expect *levels to be initialized to anything IIUC).

Apart from these (very) minor things:

Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>

>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>  		 *levels, split_levels ? *split_levels : -1);
> -- 
> 2.20.1
> 

