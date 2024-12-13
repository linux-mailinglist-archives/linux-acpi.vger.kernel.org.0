Return-Path: <linux-acpi+bounces-10126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB69F04D5
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 07:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C359188A749
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Dec 2024 06:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8118A95A;
	Fri, 13 Dec 2024 06:34:38 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4586815383B;
	Fri, 13 Dec 2024 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734071678; cv=none; b=rEhHgfDz9bQ2rTv0PIVhf3NXN8aUwFFdVzLoU0E2AeZicMjaLB1Z+d77uob74baR3SfGF0qxPp1rQWtMH8sq8N0mJAjyG/3rOf9ZWctDeUyEpKChGUjAqqI6M8StJzF7nniZUoJ55AU69+RmQ2EGWeGHpbTcecj9/1KOyGZLVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734071678; c=relaxed/simple;
	bh=WkuUsDhCdHDYIjlpg61nNp1C6QvBkOda1YPkvlq1O9s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BXQQrScGmMrNwq7kPi2F+jFdVDXXJg1ES98MpPIsK3QPeU/6q0O1UXZ1iQ3jfc0FS21mrWbD2RlKdCZIY4UD65R0Rrxh+Pc9JOW+QLBy2iHzhjGOLK97b7TsgtrTXPVjvuOI00YJyA4crbwHT9bzGrFCrckzZ25fK4fuN9QJLsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-7a9ff700000194b3-cd-675bd1e96ec1
Message-ID: <4ddfa283-eb64-4032-880b-c19b07e407e1@sk.com>
Date: Fri, 13 Dec 2024 15:19:20 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, "rafael@kernel.org" <rafael@kernel.org>,
 "lenb@kernel.org" <lenb@kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 =?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?=
 <honggyu.kim@sk.com>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 =?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?= <rakie.kim@sk.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "horen.chuang@linux.dev" <horen.chuang@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH] mm/mempolicy: Weighted interleave
 auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 "gourry@gourry.net" <gourry@gourry.net>
References: <20241210215439.94819-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <20241210215439.94819-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsXC9ZZnoe7Li9HpBg/va1rMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wtbvefY7VYtfAam8XxrfPYLfZdBKrd+fAtm8Xyff2MFpd3
	zWGzuLfmP6vF3C9TmS1Wr8lwEPA4/OY9s8fOWXfZPbrbLrN7tBx5y+qxeM9LJo9NqzrZPDZ9
	msTucWLGbxaPnQ8tPRY2TGX22D93DbvHuYsVHp83yQXwRnHZpKTmZJalFunbJXBlXLl3kang
	qlfFjD8rWBoYl1l3MXJySAiYSCzZ+ZoFxv59uIkVxOYVsJQ407IcKM7BwSKgKnH4awlEWFDi
	5MwnYOWiAvIS92/NYO9i5OJgFljJLnG1oZ0NJCEsECHxfeUZRhBbRCBE4szueUwgtpCAjcTK
	yU1gcWYBcYlbT+YzgcxnE9CS2NGZChLmFLCVePFmKTNEiZlE19YuqHJ5ie1v5zCD7JIQOMUu
	0fb8BTvEzZISB1fcYJnAKDgLyX2zkKyYhWTWLCSzFjCyrGIUycwry03MzDHWK87OqMzLrNBL
	zs/dxAiM2WW1fyJ3MH67EHyIUYCDUYmHN+BeVLoQa2JZcWXuIUYJDmYlEd4b9pHpQrwpiZVV
	qUX58UWlOanFhxilOViUxHmNvpWnCAmkJ5akZqemFqQWwWSZODilGhg9pecICd9gbuxZZlcU
	/+H25e3+JSs23DZIDgo40aAfG9GvziQb33Sy9ZB/me+0WQy/M7c/kNTJYd31VCtef43KKUat
	epnL6QE8LIK/k1aKGaxllBF8ZdailjDP5KV43Ml525bdDH3v0HpiqW8/d0ui1Ik1c1laLrDs
	6H2fbi13zJ9965vuE0osxRmJhlrMRcWJAOQJvhbVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKIsWRmVeSWpSXmKPExsXCNUOnRPflxeh0g+W3xC3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4Wn5+9Zra43X+O1WLVwmtsFse3zmO32HcRqOHw3JOsFjsf
	vmWzWL6vn9Hi8q45bBb31vxntZj7ZSqzxaFrz1ktVq/JcBD2OPzmPbPHzll32T262y6ze7Qc
	ecvqsXjPSyaPTas62Tw2fZrE7nFixm8Wj50PLT0WNkxl9tg/dw27x7mLFR7fbnt4LH7xgcnj
	8ya5AP4oLpuU1JzMstQifbsErowr9y4yFVz1qpjxZwVLA+My6y5GTg4JAROJ34ebWEFsXgFL
	iTMty1m6GDk4WARUJQ5/LYEIC0qcnPmEBcQWFZCXuH9rBnsXIxcHs8BKdomrDe1sIAlhgQiJ
	7yvPMILYIgIhEmd2z2MCsYUEbCRWTm4CizMLiEvcejKfCWQ+m4CWxI7OVJAwp4CtxIs3S5kh
	SswkurZ2QZXLS2x/O4d5AiPfLCRnzEIyaRaSlllIWhYwsqxiFMnMK8tNzMwx0yvOzqjMy6zQ
	S87P3cQIjMxltX8m7WD8dtn9EKMAB6MSD2/Avah0IdbEsuLK3EOMEhzMSiK8N+wj04V4UxIr
	q1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4pRoYN3+dfJlxo1/F6uar
	wWkNNx6HiGheYn9y5nlm/u8VBYJ8Ec+OKFzU1DnT8CZQ4UlcZ9tOlvPZwus332G8uaTqD0Ob
	5qU97yY5dm2xM7AuS+4WsAuo+e0iPPPYHevK2GUHlN9d+cHfY3Dt1beKqYvsNgcY/jKa8t92
	U/Xxw/MFEsVeLJ3y3OxnrhJLcUaioRZzUXEiALhuclrIAgAA
X-CFilter-Loop: Reflected

On 2024-12-11 06:54 AM, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across NUMA nodes according to
> user-set ratios.
> 
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
> 
> At the same time, we want these weights to be as small as possible.
> Having ratios that involve large co-prime numbers like 7639:1345:7 leads
> to awkward and inefficient allocations, since the node with weight 7
> will remain mostly unused (and despite being proportional to bandwidth,
> will not aid in relieving the pressure present in the other two nodes).
> 
> This patch introduces an auto-configuration for the interleave weights
> that aims to balance the two goals of setting node weights to be
> proportional to their bandwidths and keeping the weight values low.
> This balance is controlled by a value max_node_weight, which defines the
> maximum weight a single node can take.

Hi Joshua,

I am wondering how this is going to work for host memory + CXL memory 
interleaving. I guess by "the ACPI table" you mean the ACPI HMAT or CXL 
CDAT, both of which does not provide the bandwidth of host memory.
If this feature does not consider the bandwidth of host memory, manual 
configuration will be inevitable anyway.

> Large max_node_weights generally lead to increased weight-bandwidth
> proportionality, but can lead to underutilized nodes (think worst-case
> scenario, which is 1:max_node_weight). Lower max_node_weights reduce the
> effects of underutilized nodes, but may lead to improperly loaded
> distributions.
> 
> This knob is exposed as a sysfs interface with a default value of 32.
> Weights are re-calculated once at boottime and then every time the knob
> is changed by the user, or when the ACPI table is updated.
>> [1] 
https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Co-Developed-by: Gregory Price <gourry@gourry.net>
> ---
>   ...fs-kernel-mm-mempolicy-weighted-interleave |  24 +++
>   drivers/acpi/numa/hmat.c                      |   1 +
>   drivers/base/node.c                           |   7 +
>   include/linux/mempolicy.h                     |   4 +
>   mm/mempolicy.c                                | 195 ++++++++++++++++--
>   5 files changed, 211 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..2ef9a87ce878 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -23,3 +23,27 @@ Description:	Weight configuration interface for nodeN
>   		Writing an empty string or `0` will reset the weight to the
>   		system default. The system default may be set by the kernel
>   		or drivers at boot or during hotplug events.
> +
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/max_node_weight
> +Date:		December 2024
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Weight limiting / scaling interface
> +
> +		The maximum interleave weight for a memory node. When it is
> +		updated, any previous changes to interleave weights (i.e. via
> +		the nodeN sysfs interfaces) are ignored, and new weights are
> +		calculated using ACPI-reported bandwidths and scaled.
> +

At first this paragraph sounded like "previously stored weights are 
discarded after setting max_node_weight", but I think you mean
"User can override the default values, but defaults values are 
calculated regardless of the values set by the user". Right?

> +		It is possible for weights to be greater than max_node_weight if
> +		the nodeN interfaces are directly modified to be greater.
> +
> +		Minimum weight: 1
> +		Default value: 32
> +		Maximum weight: 255
> +
> +		Writing an empty string will set the value to be the default
> +		(32). Writing a value outside the valid range  will return
> +		EINVAL and will not re-trigger a weight scaling.
> +
> +		Setting max_node_weight to 1 is equivalent to unweighted
> +		interleave.
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index ee32a10e992c..f789280acdcb 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -109,6 +109,7 @@
>   #include <linux/mmu_notifier.h>
>   #include <linux/printk.h>
>   #include <linux/swapops.h>
> +#include <linux/gcd.h>
>   
>   #include <asm/tlbflush.h>
>   #include <asm/tlb.h>
> @@ -153,24 +154,116 @@ static unsigned int mempolicy_behavior;

[...snip...]

> +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> +{
> +	unsigned long *old_bw, *new_bw;
> +	unsigned long bw_val;
> +	u8 *old_iw, *new_iw;
> +
> +	/*
> +	 * Bandwidths above this limit causes rounding errors when reducing
> +	 * weights. This value is ~16 exabytes, which is unreasonable anyways.
> +	 */
> +	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
> +	if (bw_val > (U64_MAX / 10))
> +		return -EINVAL;
> +
> +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned long), GFP_KERNEL);
> +	if (!new_bw)
> +		return -ENOMEM;
> +
> +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);

I think kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL); will be more readable.

> +	if (!new_iw) {
> +		kfree(new_bw);
> +		return -ENOMEM;
> +	}
> +
> +	mutex_lock(&default_iwt_lock);
> +	old_bw = node_bw_table;
> +	old_iw = rcu_dereference_protected(default_iw_table,
> +					   lockdep_is_held(&default_iwt_lock));
> +
> +	if (old_bw)
> +		memcpy(new_bw, old_bw, nr_node_ids*sizeof(unsigned long));
> +	new_bw[node] = bw_val;
> +	node_bw_table = new_bw;
> +
> +	reduce_interleave_weights(new_bw, new_iw);
> +	rcu_assign_pointer(default_iw_table, new_iw);
> +
> +	mutex_unlock(&default_iwt_lock);
> +	synchronize_rcu();
> +	kfree(old_bw);
> +	kfree(old_iw);
> +	return 0;
> +}
> +
>   /**
>    * numa_nearest_node - Find nearest node by state
>    * @node: Node id to start the search
> @@ -2001,7 +2094,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>   {
>   	nodemask_t nodemask;
>   	unsigned int target, nr_nodes;
> -	u8 *table;
> +	u8 *table, *defaults;
>   	unsigned int weight_total = 0;
>   	u8 weight;
>   	int nid;
> @@ -2012,11 +2105,12 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>   
>   	rcu_read_lock();
>   	table = rcu_dereference(iw_table);
> +	defaults = rcu_dereference(iw_table);

Probably you intended rcu_dereference(default_iw_table)?

>   	/* calculate the total weight */
>   	for_each_node_mask(nid, nodemask) {
>   		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table ? table[nid] : 0;
> +		weight = weight ? weight : (defaults ? defaults[nid] : 1);
>   		weight_total += weight;
>   	}
>   
> @@ -2025,8 +2119,8 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>   	nid = first_node(nodemask);
>   	while (target) {
>   		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table ? table[nid] : 0;
> +		weight = weight ? weight : (defaults ? defaults[nid] : 1);
>   		if (target < weight)
>   			break;
>   		target -= weight;
> @@ -2409,7 +2503,7 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>   	unsigned long nr_allocated = 0;
>   	unsigned long rounds;
>   	unsigned long node_pages, delta;
> -	u8 *table, *weights, weight;
> +	u8 *weights, weight;
>   	unsigned int weight_total = 0;
>   	unsigned long rem_pages = nr_pages;
>   	nodemask_t nodes;
> @@ -2458,16 +2552,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>   	if (!weights)
>   		return total_allocated;
>   
> -	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> -	if (table)
> -		memcpy(weights, table, nr_node_ids);
> -	rcu_read_unlock();
> -
> -	/* calculate total, detect system default usage */
>   	for_each_node_mask(node, nodes) {
> -		if (!weights[node])
> -			weights[node] = 1;
> +		weights[node] = get_il_weight(node);
>   		weight_total += weights[node];
>   	}
>   
> @@ -3396,6 +3482,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   }
>   
>   static struct iw_node_attr **node_attrs;
> +static struct kobj_attribute *max_nw_attr;

Where is max_nw_attr initialized?

Best,
Hyeonggon

>   static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>   				  struct kobject *parent)
> @@ -3413,6 +3500,10 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>   
>   	for (i = 0; i < nr_node_ids; i++)
>   		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +
> +	sysfs_remove_file(wi_kobj, &max_nw_attr->attr);
> +	kfree(max_nw_attr->attr.name);
> +	kfree(max_nw_attr);
>   	kobject_put(wi_kobj);
>   }

