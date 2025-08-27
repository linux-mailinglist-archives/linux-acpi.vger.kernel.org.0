Return-Path: <linux-acpi+bounces-16104-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDF6B3804F
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 12:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA603AFCB3
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Aug 2025 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D3346A07;
	Wed, 27 Aug 2025 10:49:56 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE8E2367D9;
	Wed, 27 Aug 2025 10:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756291796; cv=none; b=O+e4vkiO5hdx5Zbzq+QQF1SbY72VWSgR22cxXGKKKTyec5Aky2OPbRyoM8qsY/hD6SleDdRzcD9kH6FrClaSfntcQ4Y15+kgDstN2BovEfaQhJqk3IbVh42xjt3TsHlzy+MXnmoMM6qU5jr/ae73aqMnCdvrpq55rTPORGNYHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756291796; c=relaxed/simple;
	bh=4HBLm36bQ26ae1yiA9CBBlZga+amlipJ54MTA+rXCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy7fuipgZuXG/ZzOGKJpJDK1MgRCD6PrD/dBMi1NEvgWHeAo1VFhAqXd9mAW9VA19gEF+BBl6LXCgKHGJ1ymsDivM5KbMiMuTKZ7Rv39qgDIxCc6Ey/hId58cwIJSlcIoEkF/QIhRKgaeDLjZ2UZ+WDr85roKargsn9SX6J9+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26BB81688;
	Wed, 27 Aug 2025 03:49:46 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8D223F738;
	Wed, 27 Aug 2025 03:49:48 -0700 (PDT)
Date: Wed, 27 Aug 2025 11:49:45 +0100
From: Dave Martin <Dave.Martin@arm.com>
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
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <aK7iyf/6iVOuVhTr@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-5-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822153048.2287-5-james.morse@arm.com>

Hi,

On Fri, Aug 22, 2025 at 03:29:45PM +0000, James Morse wrote:
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

Nit: I found all this a bit hard to follow.

This seems to boil down to:

--8<--

In acpi_count_levels(), the initial value of *levels passed by the
caller is really an implementation detail of acpi_count_levels(), so it
is unreasonable to expect the callers of this function to know what to
pass in for this parameter.  The only sensible initial value is 0,
which is what the only upstream caller (acpi_get_cache_info()) passes.

Use a local variable for the starting cache level in acpi_count_levels(),
and pass the result back to the caller via the function return value.

Gid rid of the levels parameter, which has no remaining purpose.

Fix acpi_get_cache_info() to match.

-->8--

split_levels is orthogonal to this refactoring (as evinced by the diff).
I think mentioning it in the commit message at all may just add to the
confusion...


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
>   *
> + * Returns number of levels.

Nit: the prevailing convention in this file would be

	Return: number of levels

(I don't know whether kerneldoc cares.)

Maybe also say "total number of levels" in place of "level", to make it
clearer that the split levels (if any) are included in this count.


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
>  
>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>  		 *levels, split_levels ? *split_levels : -1);

Otherwise, looks reasonable to me.

(But see my comments on the next patches re whether we really need this.)

Cheers
---Dave

