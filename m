Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA3524944D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Aug 2020 07:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725601AbgHSFBw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Aug 2020 01:01:52 -0400
Received: from foss.arm.com ([217.140.110.172]:54910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSFBw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Aug 2020 01:01:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 582D731B;
        Tue, 18 Aug 2020 22:01:51 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 942EA3F71F;
        Tue, 18 Aug 2020 22:01:48 -0700 (PDT)
Subject: Re: [PATCH] arm64: numa: rightsize the distance array
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>, linuxarm@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200708113825.1429671-1-Jonathan.Cameron@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <31e0f1be-7dc5-3e5b-2e56-5cda569f2a55@arm.com>
Date:   Wed, 19 Aug 2020 10:31:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200708113825.1429671-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hello Jonathan,

On 07/08/2020 05:08 PM, Jonathan Cameron wrote:
> Unfortunately we are currently calling numa_alloc_distance well before we call
> setup_node_to_cpu_mask_map means that nr_node_ids is set to MAX_NUMNODES.
> This wastes a bit of memory and is confusing to the reader.

With defconfig where CONFIG_NODES_SHIFT = 2 i.e MAX_NUMNODES = 4, the total
numa_distance size is 16 bytes (individual entries here are just u8). Even
with MAX_NUMNODES = 256, numa_distance is going to be just 64K. Hence there
might not be much space to be saved that would need optimizing this path.
Please correct me if I have missed something.

> 
> Note we could just decide to hardcode it as MAX_NUMNODES but if so we should
> do so explicitly.

nr_node_ids = MAX_NUMNODES which is set from mm/page_alloc.c, yes asserting
with an WARN_ON() that it is indeed MAX_NUMNODES would make sense.

> 
> Looking at what x86 does, they do a walk of nodes_parsed and locally
> establish the maximum node count seen.  We can't actually do that where we
> were previously calling it in numa_init because nodes_parsed isn't set up
> either yet.  So let us take a leaf entirely out of x86's book and make
> the true assumption that nodes_parsed will definitely be set up before
> we try to put a real value in this array.  Hence just do it on demand.

So it is replacing one assumption i.e nr_node_ids = MAX_NUMNODES with another
i.e nodes_parsed has been initialized, while trying to populate an entry.

> 
> In order to avoid trying and failing to allocate the array multiple times
> we do the same thing as x86 and set numa_distance = 1. This requires a
> few small modifications elsewhere.

Where ? Dont see numa_distance being set as 1.

> 
> Worth noting, that with one exception (which it appears can be removed [1])
> the x86 and arm numa distance code is now identical.  Worth factoring it
> out to some common location?
> 
> [1] https://lkml.kernel.org/r/20170406124459.dwn5zhpr2xqg3lqm@node.shutemov.name
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> arch/arm64/mm/numa.c | 35 ++++++++++++++++++-----------------
>  1 file changed, 18 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
> index aafcee3e3f7e..a2f549ef0a36 100644
> --- a/arch/arm64/mm/numa.c
> +++ b/arch/arm64/mm/numa.c
> @@ -255,13 +255,11 @@ void __init numa_free_distance(void)
>  {
>  	size_t size;
>  
> -	if (!numa_distance)
> -		return;
> -
>  	size = numa_distance_cnt * numa_distance_cnt *
>  		sizeof(numa_distance[0]);
> -
> -	memblock_free(__pa(numa_distance), size);
> +	/* numa_distance could be 1LU marking allocation failure, test cnt */
> +	if (numa_distance_cnt)
> +		memblock_free(__pa(numa_distance), size);
>  	numa_distance_cnt = 0;
>  	numa_distance = NULL;
>  }
> @@ -271,20 +269,29 @@ void __init numa_free_distance(void)
>   */
>  static int __init numa_alloc_distance(void)
>  {
> +	nodemask_t nodes_parsed;
>  	size_t size;
> +	int i, j, cnt = 0;
>  	u64 phys;
> -	int i, j;
>  
> -	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
> +	/* size the new table and allocate it */
> +	nodes_parsed = numa_nodes_parsed;
> +	for_each_node_mask(i, nodes_parsed)
> +		cnt = i;

There is no nodemask related helper to fetch the highest bit set ?

> +	cnt++;
> +	size = cnt * cnt * sizeof(numa_distance[0]);
>  	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
>  				      size, PAGE_SIZE);
> -	if (WARN_ON(!phys))
> +	if (!phys) {
> +		pr_warn("Warning: can't allocate distance table!\n");
> +		/* don't retry until explicitly reset */
> +		numa_distance = (void *)1LU;
>  		return -ENOMEM;
> -
> +	}
>  	memblock_reserve(phys, size);
>  
>  	numa_distance = __va(phys);
> -	numa_distance_cnt = nr_node_ids;
> +	numa_distance_cnt = cnt;
>  
>  	/* fill with the default distances */
>  	for (i = 0; i < numa_distance_cnt; i++)
> @@ -311,10 +318,8 @@ static int __init numa_alloc_distance(void)
>   */
>  void __init numa_set_distance(int from, int to, int distance)
>  {
> -	if (!numa_distance) {
> -		pr_warn_once("Warning: distance table not allocated yet\n");
> +	if (!numa_distance && numa_alloc_distance() < 0)
>  		return;
> -	}
>  
>  	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
>  			from < 0 || to < 0) {
> @@ -384,10 +389,6 @@ static int __init numa_init(int (*init_func)(void))
>  	nodes_clear(node_possible_map);
>  	nodes_clear(node_online_map);
>  
> -	ret = numa_alloc_distance();
> -	if (ret < 0)
> -		return ret;
> -
>  	ret = init_func();
>  	if (ret < 0)
>  		goto out_free_distance;
> 

What is the primary objective here ? Reduce memory for numa_distance[]
or unifying arm64's numa_init() with that of x86's ?
