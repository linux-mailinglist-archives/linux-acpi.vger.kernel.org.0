Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646D422C3FF
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Jul 2020 13:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgGXLDV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 24 Jul 2020 07:03:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2523 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726114AbgGXLDV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 24 Jul 2020 07:03:21 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3B06F1FAC0AA13DC1C95;
        Fri, 24 Jul 2020 12:03:19 +0100 (IST)
Received: from localhost (10.52.122.213) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 24 Jul
 2020 12:03:18 +0100
Date:   Fri, 24 Jul 2020 12:01:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>, <linuxarm@huawei.com>,
        Tejun Heo <tj@kernel.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] arm64: numa: rightsize the distance array
Message-ID: <20200724120157.00005252@Huawei.com>
In-Reply-To: <20200708113825.1429671-1-Jonathan.Cameron@huawei.com>
References: <20200708113825.1429671-1-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.122.213]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 8 Jul 2020 19:38:25 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Unfortunately we are currently calling numa_alloc_distance well before we call
> setup_node_to_cpu_mask_map means that nr_node_ids is set to MAX_NUMNODES.
> This wastes a bit of memory and is confusing to the reader.
> 
> Note we could just decide to hardcode it as MAX_NUMNODES but if so we should
> do so explicitly.
> 
> Looking at what x86 does, they do a walk of nodes_parsed and locally
> establish the maximum node count seen.  We can't actually do that where we
> were previously calling it in numa_init because nodes_parsed isn't set up
> either yet.  So let us take a leaf entirely out of x86's book and make
> the true assumption that nodes_parsed will definitely be set up before
> we try to put a real value in this array.  Hence just do it on demand.
> 
> In order to avoid trying and failing to allocate the array multiple times
> we do the same thing as x86 and set numa_distance = 1. This requires a
> few small modifications elsewhere.
> 
> Worth noting, that with one exception (which it appears can be removed [1])
> the x86 and arm numa distance code is now identical.  Worth factoring it
> out to some common location?
> 
> [1] https://lkml.kernel.org/r/20170406124459.dwn5zhpr2xqg3lqm@node.shutemov.name
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Polite nudge.  Anyone?  No particular urgency on this one but I'm thinking
of taking a stab at factoring out this code into a common location for arm64
and x86 and this change needs to proceed that.

Thanks,

Jonathan


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


