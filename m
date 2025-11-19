Return-Path: <linux-acpi+bounces-19059-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5DCC6CC56
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 05:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA48734E0B4
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Nov 2025 04:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E67A307AC5;
	Wed, 19 Nov 2025 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="nSHAzLOT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754162DF71B;
	Wed, 19 Nov 2025 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763527813; cv=none; b=KX2DdhqKDnZWUy/zcgGVKkceXLb+fpjwwER6prkEWR+YUtRJG9vHLwsawWVgA06YuILJjAdU88wtnznUUtSIl3BSWnMntrfLwAf8hSAPyPnjL2jbzkYKADycW9gsSa+jX5FPKzEysQzFDmgS5bukXPOSFvbBlMRKcDq9JydPEEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763527813; c=relaxed/simple;
	bh=c2nwyg99D9iOJkh8PLXDWUa1W0jYumJD4SiAIVUjGvo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Yg2vxpzMRYW3MsNj+kolapG1pHFe6uQDStJe4d/a3Bv8WC2cs0iQacEBzrTD6kbL4ceipQewsa2nBaqfgw99CFYrQKa2TLWvDKZB+zty6+Qkcm4r+14vdZfq608qGz937vU2ISJjq3Ii9ykCsk0RNd/XSOvO5jwVQAwNRljkR7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=nSHAzLOT; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hKU1Gtuos1m8SjZRDqgme1B/v1iMasdGvE7MrILXjh0=;
	b=nSHAzLOTukZKkZGECTv47qtuuu+NyZ1cnwVvrLoNrO+/5IYqk5lT40SPgwnu+zOFjWB+lur9m
	AhoEFQZIzFFz8mIF5Nzxl1cx8mFqCjc+PKdGCC5QvzQAOjgPv65C4pe3iaOu3q9dCYGSvpRRy53
	RTQfkP724p6P0cIXqq2tJ5E=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dB89v6vs9zcZy1;
	Wed, 19 Nov 2025 12:48:03 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id DB5311400DC;
	Wed, 19 Nov 2025 12:50:05 +0800 (CST)
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemf500002.china.huawei.com (7.185.36.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 19 Nov 2025 12:50:03 +0800
Subject: Re: [PATCH v5 02/34] ACPI / PPTT: Stop acpi_count_levels() expecting
 callers to clear levels
To: Ben Horgan <ben.horgan@arm.com>, <james.morse@arm.com>
CC: <amitsinght@marvell.com>, <baisheng.gao@unisoc.com>,
	<baolin.wang@linux.alibaba.com>, <bobo.shaobowang@huawei.com>,
	<carl@os.amperecomputing.com>, <catalin.marinas@arm.com>, <dakr@kernel.org>,
	<dave.martin@arm.com>, <david@redhat.com>, <dfustini@baylibre.com>,
	<fenghuay@nvidia.com>, <gregkh@linuxfoundation.org>, <gshan@redhat.com>,
	<jeremy.linton@arm.com>, <jonathan.cameron@huawei.com>, <kobak@nvidia.com>,
	<lcherian@marvell.com>, <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<lpieralisi@kernel.org>, <peternewman@google.com>, <quic_jiles@quicinc.com>,
	<rafael@kernel.org>, <robh@kernel.org>, <rohit.mathew@arm.com>,
	<scott@os.amperecomputing.com>, <sdonthineni@nvidia.com>,
	<sudeep.holla@arm.com>, <tan.shaopeng@fujitsu.com>, <will@kernel.org>,
	<xhao@linux.alibaba.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng
 Heng <zengheng4@huawei.com>
References: <20251117170014.4113754-1-ben.horgan@arm.com>
 <20251117170014.4113754-3-ben.horgan@arm.com>
From: Hanjun Guo <guohanjun@huawei.com>
Message-ID: <4292c687-cb83-3009-cf6a-d490cfe80024@huawei.com>
Date: Wed, 19 Nov 2025 12:50:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251117170014.4113754-3-ben.horgan@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500002.china.huawei.com (7.185.36.57)

On 2025/11/18 0:59, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
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
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Tested-by: Carl Worth <carl@os.amperecomputing.com>
> Tested-by: Gavin Shan <gshan@redhat.com>
> Tested-by: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> s/starting_level/current_level/ (Jonathan)
> ---
>   drivers/acpi/pptt.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index b8248c0092fe..2856254e29d7 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -177,14 +177,14 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>   }
>   
>   /**
> - * acpi_count_levels() - Given a PPTT table, and a CPU node, count the cache
> - * levels and split cache levels (data/instruction).
> + * acpi_count_levels() - Given a PPTT table, and a CPU node, count the
> + * total number of levels and split cache levels (data/instruction).
>    * @table_hdr: Pointer to the head of the PPTT table
>    * @cpu_node: processor node we wish to count caches for
> - * @levels: Number of levels if success.
>    * @split_levels:	Number of split cache levels (data/instruction) if
>    *			success. Can by NULL.
>    *
> + * Return: number of levels.
>    * Given a processor node containing a processing unit, walk into it and count
>    * how many levels exist solely for it, and then walk up each level until we hit
>    * the root node (ignore the package level because it may be possible to have
> @@ -192,14 +192,18 @@ acpi_find_cache_level(struct acpi_table_header *table_hdr,
>    * split cache levels (data/instruction) that exist at each level on the way
>    * up.
>    */
> -static void acpi_count_levels(struct acpi_table_header *table_hdr,
> -			      struct acpi_pptt_processor *cpu_node,
> -			      unsigned int *levels, unsigned int *split_levels)
> +static int acpi_count_levels(struct acpi_table_header *table_hdr,
> +			     struct acpi_pptt_processor *cpu_node,
> +			     unsigned int *split_levels)
>   {
> +	int current_level = 0;
> +
>   	do {
> -		acpi_find_cache_level(table_hdr, cpu_node, levels, split_levels, 0, 0);
> +		acpi_find_cache_level(table_hdr, cpu_node, &current_level, split_levels, 0, 0);
>   		cpu_node = fetch_pptt_node(table_hdr, cpu_node->parent);
>   	} while (cpu_node);
> +
> +	return current_level;
>   }
>   
>   /**
> @@ -645,7 +649,7 @@ int acpi_get_cache_info(unsigned int cpu, unsigned int *levels,
>   	if (!cpu_node)
>   		return -ENOENT;
>   
> -	acpi_count_levels(table, cpu_node, levels, split_levels);
> +	*levels = acpi_count_levels(table, cpu_node, split_levels);
>   
>   	pr_debug("Cache Setup: last_level=%d split_levels=%d\n",
>   		 *levels, split_levels ? *split_levels : -1);
> 

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun

