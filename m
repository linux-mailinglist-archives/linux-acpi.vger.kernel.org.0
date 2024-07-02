Return-Path: <linux-acpi+bounces-6739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7AA923EE6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 15:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73061287392
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508AB1BA08A;
	Tue,  2 Jul 2024 13:25:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CCB1B580F;
	Tue,  2 Jul 2024 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926741; cv=none; b=mm6vdplevIKk6FCHZU/EWgVGQFp8v/abGOBAZdgGVnB6oWn5jF7PrDvAbgC8HrS+Yr1avCtjnPCUyMJrEEXG+7+1dr0a4IjQ9/auH2WlWIK+pyoEGsxC0mHHgJQAkVW60GJKNi2xnSML+HgXsXbZcVYc8oYhZJVQPRHxF5/2G3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926741; c=relaxed/simple;
	bh=rzfwDHLMmpigWVdvXCtKhRmYiLruuuCfKfjujE+/a+c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eOmjv0pgvQj+9XH2LJFUFnjvizOnHLB/0zS3p2DOniFlhYPKqlEVbD4vEGO2RJc2hatniDEzz6fkrqSn+UsBRdJ4WvP2U0vRI8RGrZK5k2vtEeLH8+n5VhaIl8N+4R96eBfHo1+tTsdS9Xe0KYMeGkl9g8nCye42EOqkJoj7gdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3X15Qdpz6K8xB;
	Tue,  2 Jul 2024 21:23:45 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 08FC0140517;
	Tue,  2 Jul 2024 21:25:37 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 14:25:36 +0100
Date: Tue, 2 Jul 2024 14:25:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
	<dave.jiang@intel.com>, "Dan Williams" <dan.j.williams@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
	<horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240702142535.00003dc0@Huawei.com>
In-Reply-To: <20240628060925.303309-2-horen.chuang@linux.dev>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
	<20240628060925.303309-2-horen.chuang@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 28 Jun 2024 06:09:23 +0000
"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

> If we simply move the set_node_memory_tier() from memory_tier_init()
> to late_initcall(), it will result in HMAT not registering
> the mt_adistance_algorithm callback function, because
> set_node_memory_tier() is not performed during the memory tiering
> initialization phase, leading to a lack of correct default_dram
> information.
> 
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
> 
> Besides, since default_dram_type may be checked/used during the
> initialization process of HMAT and drivers, it is better to keep the
> allocation of default_dram_type in memory_tier_init().
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/numa/hmat.c     |  5 +--
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            | 59 +++++++++++++++---------------------
>  3 files changed, 28 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c8ccc91ebe6..a2f9e7a4b479 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -940,10 +940,7 @@ static int hmat_set_default_dram_perf(void)
>  	struct memory_target *target;
>  	struct access_coordinate *attrs;
>  
> -	if (!default_dram_type)
> -		return -EIO;
> -
> -	for_each_node_mask(nid, default_dram_type->nodes) {
> +	for_each_node_mask(nid, default_dram_nodes) {
As below. Do we care if the combination of RAM + CPU wasn't true
earlier and is true by this point?   If not, why not just
compute the node mask in here and not store it.

>  		pxm = node_to_pxm(nid);
>  		target = find_mem_target(pxm);
>  		if (!target)
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 0d70788558f4..fa61ad9c4d75 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -38,6 +38,7 @@ struct access_coordinate;
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
>  extern struct memory_dev_type *default_dram_type;
> +extern nodemask_t default_dram_nodes __initdata;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
>  
>  #define numa_demotion_enabled	false
>  #define default_dram_type	NULL
> +#define default_dram_nodes NODE_MASK_NONE
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 6632102bd5c9..a19a90c3ad36 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
>  static LIST_HEAD(default_memory_types);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
> +nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
>  
>  static const struct bus_type memory_tier_subsys = {
>  	.name = "memory_tiering",
> @@ -671,28 +672,38 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
>  
>  /*
>   * This is invoked via `late_initcall()` to initialize memory tiers for
> - * CPU-less memory nodes after driver initialization, which is
> - * expected to provide `adistance` algorithms.
> + * memory nodes, both with and without CPUs. After the initialization of
> + * firmware and devices, adistance algorithms are expected to be provided.
>   */
>  static int __init memory_tier_late_init(void)
>  {
>  	int nid;
> +	struct memory_tier *memtier;
>  
> +	get_online_mems();
>  	guard(mutex)(&memory_tier_lock);
> +	/*
> +	 * Look at all the existing and uninitialized N_MEMORY nodes and
> +	 * add them to default memory tier or to a tier if we already have
> +	 * memory types assigned.
> +	 */
>  	for_each_node_state(nid, N_MEMORY) {
>  		/*
> -		 * Some device drivers may have initialized memory tiers
> -		 * between `memory_tier_init()` and `memory_tier_late_init()`,
> -		 * potentially bringing online memory nodes and
> -		 * configuring memory tiers. Exclude them here.
> +		 * Some device drivers may have initialized
> +		 * memory tiers, potentially bringing memory nodes
> +		 * online and configuring memory tiers.
> +		 * Exclude them here.
>  		 */
>  		if (node_memory_types[nid].memtype)
>  			continue;
>  
> -		set_node_memory_tier(nid);
> +		memtier = set_node_memory_tier(nid);
> +		if (IS_ERR(memtier))
> +			/* Continue with memtiers we are able to setup. */

Might later ones be possible if we just continued this loop?

> +			break;
>  	}
> -
White space was harmless - I'd leave it there rather than adding noise to this diff.
>  	establish_demotion_targets();
> +	put_online_mems();
>  
>  	return 0;
>  }
> @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  
>  static int __init memory_tier_init(void)
>  {
> -	int ret, node;
> -	struct memory_tier *memtier;
> +	int ret;
>  
>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
>  	if (ret)
> @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
>  				GFP_KERNEL);
>  	WARN_ON(!node_demotion);
>  #endif
> -	mutex_lock(&memory_tier_lock);
> +
> +	guard(mutex)(&memory_tier_lock);

If this was safe to do without the rest of the change (I think so)
then better to pull that out as a trivial precursor so less noise
in here.

>  	/*
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
> @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> -	/*
> -	 * Look at all the existing N_MEMORY nodes and add them to
> -	 * default memory tier or to a tier if we already have memory
> -	 * types assigned.
> -	 */
> -	for_each_node_state(node, N_MEMORY) {
> -		if (!node_state(node, N_CPU))
> -			/*
> -			 * Defer memory tier initialization on
> -			 * CPUless numa nodes. These will be initialized
> -			 * after firmware and devices are initialized.
> -			 */
> -			continue;
> -
> -		memtier = set_node_memory_tier(node);
> -		if (IS_ERR(memtier))
> -			/*
> -			 * Continue with memtiers we are able to setup
> -			 */
> -			break;
> -	}
> -	establish_demotion_targets();
> -	mutex_unlock(&memory_tier_lock);
> +	/* Record nodes with memory and CPU to set default DRAM performance. */
> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
> +		  node_states[N_CPU]);

There are systems where (for various esoteric reasons, such as describing an
association with some other memory that isn't DRAM where the granularity
doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
Handling that can be a job for another day though.

Why does this need to be computed here?  Why not do it in
hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.


>  
>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>  	return 0;


