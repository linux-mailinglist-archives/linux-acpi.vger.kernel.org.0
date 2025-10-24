Return-Path: <linux-acpi+bounces-18181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0851BC060D9
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD6DC585601
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 11:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E2A311C15;
	Fri, 24 Oct 2025 11:29:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB8313535;
	Fri, 24 Oct 2025 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305370; cv=none; b=BdlOOnwxzIv4JtbcQqtNSaa64ojfypmRg9qWuh0jnBSaQoIWRGPzEShQ3JK/wAC7iiqB5gIVvPWJ7egj9Ryu9OyzoFBw7B++jBrp7WPSyBqFwCkWnmwDqm47HLj1IJdJkEnTHRHC+lwmKnxHoXEBxjHI3rMz25g4DRAEKhJnWi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305370; c=relaxed/simple;
	bh=fDRtXysVIiMo7NBtu/I6CVO49kNEmIE3rzAcaTFmsAw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fDsprUakC+pRo3sduc22i1IpoR+IPJBa3q+nm50kRmj0kCMJhGpTb5VLqepa8sH4FrQzuixQ5poSwiscQDIZlbpJ3/5df1niIghfLcVgaZ5c4E4jec4U/G2mHMrYeZpFwD5T0MCMq1ntngkX3p6ERxrexBu9+sDZuCKDH/8XJiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ctLDj6tkWz6M4Wq;
	Fri, 24 Oct 2025 19:25:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E935E14014C;
	Fri, 24 Oct 2025 19:29:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 24 Oct
 2025 12:29:23 +0100
Date: Fri, 24 Oct 2025 12:29:21 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: James Morse <james.morse@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-acpi@vger.kernel.org>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>, Koba
 Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
	<fenghuay@nvidia.com>, <baisheng.gao@unisoc.com>, Rob Herring
	<robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>, "Rafael Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>,
	Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3 02/29] ACPI / PPTT: Stop acpi_count_levels()
 expecting callers to clear levels
Message-ID: <20251024122921.000004bc@huawei.com>
In-Reply-To: <20251017185645.26604-3-james.morse@arm.com>
References: <20251017185645.26604-1-james.morse@arm.com>
	<20251017185645.26604-3-james.morse@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 17 Oct 2025 18:56:18 +0000
James Morse <james.morse@arm.com> wrote:

> In acpi_count_levels(), the initial value of *levels passed by the
> caller is really an implementation detail of acpi_count_levels(), so it
> is unreasonable to expect the callers of this function to know what to
> pass in for this parameter.  The only sensible initial value is 0,
> which is what the only upstream caller (acpi_get_cache_info()) passes.
> 
> Use a local variable for the starting cache level in acpi_count_levels(),
> and pass the result back to the caller via the function return value.
> 
> Get rid of the levels parameter, which has no remaining purpose.
> 
> Fix acpi_get_cache_info() to match.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>

Another meh, the name is confusing type comment. 

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
Given it's not the starting level at this point... Maybe just call it level or current_level.
>  }
>  
>  /**
> @@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>  	if (!cpu_node)
>  		return -ENOENT;
>  
> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
>  
>  	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>  		 *levels, split_levels ? *split_levels : -1);


