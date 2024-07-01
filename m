Return-Path: <linux-acpi+bounces-6694-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B854291D754
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 07:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EDF51F20F78
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jul 2024 05:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED632A8D0;
	Mon,  1 Jul 2024 05:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e0qJzg/b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3631C33;
	Mon,  1 Jul 2024 05:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719810948; cv=none; b=llvoqp9WTTCSE+pAxncKTfabLpJ8Brt/c8wIIUQGsguCkMXIWQpljyn7YJFY4uN6wfsw+EcG4X3bg9wPGH+7dBwqUit52VAUHLntgT3v+vTVsZOmdkyzb7ovHoZia7KcOYVkCRWNcOyI0zrnwQYDI9e7Fyjij7cMXvsPJ/DM/lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719810948; c=relaxed/simple;
	bh=33LnhJ7+BqQZikbci+g6bJ6dGM6/pya/Tnvx+wHf3/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sOJEmW/nmKt9/nL2lwB/AXRFA18wNRBAUvljfhy/FolDaAKMrrnmbGCkeMsze8oQJErQr6x67C4287/Ob/3U6Ile03x5LgTELELaSSeooEhjjOcReDV8KyRJwSy/wDjDlxLxxDxtRM4Cu6/vFeeKrH+VA6sW9Jwg2es9l/anU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e0qJzg/b; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719810947; x=1751346947;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=33LnhJ7+BqQZikbci+g6bJ6dGM6/pya/Tnvx+wHf3/o=;
  b=e0qJzg/bAYQ9ItJEWSZgQKQZKwCAR4rVLN6AKAk0ANM+yi8FU9NsSRiu
   m3Q5E5atmplHQliscOyBUAPTbDIVa4ZM8RD9Q0i4I92U7bO7vsQru+pEB
   gQDQN2lnUmWbwyZOCVNEDWL7hTwUZTJFS5a8rGhekl3MGKf1Pv4XIzcy9
   JRbcypcs2DDkURijwcjT8BGLbktDbl/+4ZmDckbCeqdlK51Hf13MHcFcW
   EtO/P8Pm5gVxvm8+gA7uPTLfWjJfk8B65xULyl3Zu7XwCjiYu4ENw1eu9
   HFrCHro14pM9cZUBjQAGw7AYlyMHUcXpm+VegDGiDHV53tjF+KJLzE6xl
   w==;
X-CSE-ConnectionGUID: Tr8CTBX1TCqwEDxLJFzRqw==
X-CSE-MsgGUID: VHbIxnhnSZC2J2OkBrOUaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17051618"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="17051618"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:15:47 -0700
X-CSE-ConnectionGUID: tRBL+MYsRYyKY5Q3fRDiVA==
X-CSE-MsgGUID: yXSuGEvLRIqOj0oi+miQLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; 
   d="scan'208";a="45803392"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 22:15:40 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
Cc: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
  "Alistair Popple" <apopple@nvidia.com>,  "Srinivasulu Thanneeru"
 <sthanneeru@micron.com>,  "SeongJae Park" <sj@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>,  linux-cxl@vger.kernel.org,
  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
In-Reply-To: <20240628060925.303309-2-horen.chuang@linux.dev> (Ho-Ren Chuang's
	message of "Fri, 28 Jun 2024 06:09:23 +0000")
References: <20240628060925.303309-1-horen.chuang@linux.dev>
	<20240628060925.303309-2-horen.chuang@linux.dev>
Date: Mon, 01 Jul 2024 13:13:49 +0800
Message-ID: <87tth9ofsi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Jack,

"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> writes:

I suggest you to merge the [0/1] with the change log here.  [0/1]
describes why do we need the patch.  The below text describes some
details.  Just don't use "---" to separate them.  We need both parts in
the final commit message.

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

Why do we need it?  IIRC, we have deleted its usage in hmat.c.

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

Can we remove the above line?

> +extern nodemask_t default_dram_nodes __initdata;

We don't need to use __initdata in variable declaration.

>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
>  
>  #define numa_demotion_enabled	false
>  #define default_dram_type	NULL
> +#define default_dram_nodes NODE_MASK_NONE

Should we use <tab> after "default_dram_nodes"?

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

If the memory type of the node has been assigned, we will skip it in the
following code.  So, I think that we need to revise the comments.

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
> +			break;
>  	}
> -
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
>  
>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>  	return 0;

--
Best Regards,
Huang, Ying

