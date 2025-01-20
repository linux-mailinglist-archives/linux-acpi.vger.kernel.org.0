Return-Path: <linux-acpi+bounces-10759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC9A16628
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 05:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DA63A8EA0
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 04:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C29145B14;
	Mon, 20 Jan 2025 04:47:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail3.skhynix.com (exvmail3.skhynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD39917E4;
	Mon, 20 Jan 2025 04:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737348450; cv=none; b=V0GQZyfxLmYHTOmXe8gslVAlvusnV8Kgbe7nRlXOY8kRQPFcBNZsxxpbwvaOt1gyfrYnic6z70HgOaV0iBQxWvMaWHpVUENPMYkUJpp0JeS9tL12l0JhmhSLnZPLdf82SCL/5rTkWY45dvkO7g8uZgEWn2XCgr1Ahsjh9L7hS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737348450; c=relaxed/simple;
	bh=ihi/0sIRtq4WbyGE62c8aKnxiCidBxgkbuEcXC9qq+Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Sqn2fjDdd6nYRnw56FgzUdRe51nh/KC2Nm21NlOKHPKZTCzgUyatqSeQLo5TVehQZutjbBv0hC/Wh0d/ox+kSED9hxiEftL8BvUuel41iIZBar1ggl+4+UvUbvcJBTN9AYdsdeucJ5wzBpjVRou67rkue8uDqE5YT/vvoRhAR4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-791ff700000194b3-98-678dd55a9e61
Message-ID: <4ab7bd83-1191-434c-8b5f-75e71ceb26c1@sk.com>
Date: Mon, 20 Jan 2025 13:47:21 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, 42.hyeyoo@gmail.com,
 "rafael@kernel.org" <rafael@kernel.org>, "lenb@kernel.org"
 <lenb@kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 =?UTF-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKSBTeXN0ZW0gU1c=?=
 <honggyu.kim@sk.com>, =?UTF-8?B?6rmA65296riwKEtJTSBSQUtJRSkgU3lzdGVtIFNX?=
 <rakie.kim@sk.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "horen.chuang@linux.dev" <horen.chuang@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 "gourry@gourry.net" <gourry@gourry.net>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsXC9ZZnoW7U1d50gzObBC0m9hhYzFm/hs1i
	+tQLjBYnbjayWfy8e5zdonnxejaL1Zt8LW73n2O1WLXwGpvF8a3z2C32XQSq3fnwLZvF8n39
	jBaXd81hs7i35j+rxdwvU5ktVq/JcBD0OPzmPbPHzll32T262y6ze7QcecvqsXjPSyaPTas6
	2Tw2fZrE7nFixm8Wj50PLT0WNkxl9tg/dw27x7mLFR6fN8kF8EZx2aSk5mSWpRbp2yVwZdw/
	f4G1oMGxonNbRgPjNeMuRk4OCQETiQ+bl7F1MXKA2Q2Xc0HCvAKWEle2X2IEsVkEVCUWz13D
	DBEXlDg58wkLiC0qIC9x/9YM9i5GLg5mgb9sEn0HzrKCJIQFzCUmztjKCpIQEZjKKHH11hKw
	biEBO4lfX+ezgdjMAuISt57MZwJZzCagJbGjMxUkzClgL/Hh5gFGiBIzia6tXVC2vMT2t3OY
	QWZKCJxjl3hwazs7xAOSEgdX3GCZwCg4C8mBs5CsmIVk1iwksxYwsqxiFMnMK8tNzMwx1ivO
	zqjMy6zQS87P3cQIjN1ltX8idzB+uxB8iFGAg1GJhzeBtTddiDWxrLgy9xCjBAezkgiv6Iee
	dCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8Rt/KU4QE0hNLUrNTUwtSi2CyTBycUg2Mlr5zGU7s
	c5WR/f+c6Z/WxIhKRQu2W+3mV/hKj6/RZ1xzhbdg/UKb7d8NvrEELmJ7JhGadr2S8UrOFFUV
	32WzKwK+3YgsX9SpIlqo+vfjZpXLD5bEms55o+/nKK914nC52bX5fd/7WHL/TjFg/l+aLn1d
	XfDimT3L6r2FPnZezQx9tyFrb8lWJZbijERDLeai4kQAeIFxydkCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsXCNUOnRDfqam+6QWuZxcQeA4s569ewWUyf
	eoHR4sTNRjaLn3ePs1s0L17PZrF6k6/F52evmS1u959jtVi18BqbxfGt89gt9l0Eajg89ySr
	xc6Hb9kslu/rZ7S4vGsOm8W9Nf9ZLeZ+mcpscejac1aL1WsyHEQ8Dr95z+yxc9Zddo/utsvs
	Hi1H3rJ6LN7zkslj06pONo9Nnyaxe5yY8ZvFY+dDS4+FDVOZPfbPXcPuce5ihce32x4ei198
	YPL4vEkugD+KyyYlNSezLLVI3y6BK+P++QusBQ2OFZ3bMhoYrxl3MXJwSAiYSDRczu1i5OTg
	FbCUuLL9EiOIzSKgKrF47hpmiLigxMmZT1hAbFEBeYn7t2awdzFycTAL/GWT6DtwlhUkISxg
	LjFxxlZWkISIwFRGiau3loB1CwnYSfz6Op8NxGYWEJe49WQ+E8hiNgEtiR2dqSBhTgF7iQ83
	DzBClJhJdG3tgrLlJba/ncM8gZFvFpI7ZiGZNAtJyywkLQsYWVYximTmleUmZuaY6RVnZ1Tm
	ZVboJefnbmIExuey2j+TdjB+u+x+iFGAg1GJhzeBtTddiDWxrLgy9xCjBAezkgiv6IeedCHe
	lMTKqtSi/Pii0pzU4kOM0hwsSuK8XuGpCUIC6YklqdmpqQWpRTBZJg5OqQbGaUoCmxcXvToQ
	fM/DaHXGgahezty+3SzuKf++pPmVPSsT9mhjONS775wRJ9OPn20S9s5X/vrdZ13/uGCB+SPZ
	M3blkWYB78/NfXeM/2W7SamH6eoFH99J/enzU/JrOvqwzmxX4wxZXUvZV4IzPU2YORbIfOdo
	UM5nPFrZyFPxb4FNrGrToXNKLMUZiYZazEXFiQAwzE63ywIAAA==
X-CFilter-Loop: Reflected



On 1/16/2025 3:58 AM, Joshua Hahn wrote:
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
> will not aid in relieving the bandwidth pressure in the other two nodes).
> 
> This patch introduces an auto-configuration mode for the interleave
> weights that aims to balance the two goals of setting node weights to be
> proportional to their bandwidths and keeping the weight values low.
> In order to perform the weight re-scaling, we use an internal
> "weightiness" value (fixed to 32) that defines interleave aggression.
> 
> In this auto configuration mode, node weights are dynamically updated
> every time there is a hotplug event that introduces new bandwidth.
> 
> Users can also enter manual mode by writing "manual" to the new "mode"
> sysfs interface. When a user enters manual mode, the system stops
> dynamically updating any of the node weights, even during hotplug events
> that can shift the optimal weight distribution. The system also enters
> manual mode any time a user sets a node's weight by hand, using the
> nodeN interface introduced in [1]. On the other hand, auto mode is
> only entered by explicitly writing "auto" to the mode interface.
> 
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent.
> 
> This patch introduces "real" defaults, but we have decided to move away
> from letting users use 0 as a "set to default" interface. Rather, users
> who want to use system defaults should use "auto" mode. This patch seems
> to be the appropriate place to make this change, since we would like to
> remove this usage before users begin to rely on the feature in
> userspace. Moreover, users will not be losing any functionality; they
> can still write 1 into a node if they want a weight of 1. Thus, we
> deprecate the "write zero to reset" feature in favor of returning an
> error, the same way we would return an error when the user writes any
> other invalid weight to the interface.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
> Changelog
> v3:
> - Weightiness (max_node_weight) is now fixed to 32.
> - Instead, the sysfs interface now exposes a "mode" parameter, which
>    can either be "auto" or "manual".
>    - Thank you Hyeonggon and Honggyu for the feedback.
> - Documentation updated to reflect new sysfs interface, explicitly
>    specifies that 0 is invalid.
>    - Thank you Gregory and Ying for the discussion on how best to
>      handle the 0 case.
> - Re-worked nodeN sysfs store to handle auto --> manual shifts
> - mempolicy_set_node_perf internally handles the auto / manual
>    caes differently now. bw is always updated, iw updates depend on
>    what mode the user is in.
> - Wordsmithing comments for clarity.
> - Removed RFC tag.
> 
> v2:
> - Name of the interface is changed: "max_node_weight" --> "weightiness"
> - Default interleave weight table no longer exists. Rather, the
>    interleave weight table is initialized with the defaults, if bandwidth
>    information is available.
>    - In addition, all sections that handle iw_table have been changed
>      to reference iw_table if it exists, otherwise defaulting to 1.
> - All instances of unsigned long are converted to uint64_t to guarantee
>    support for both 32-bit and 64-bit machines
> - sysfs initialization cleanup
> - Documentation has been rewritten to explicitly outline expected
>    behavior and expand on the interpretation of "weightiness".
> - kzalloc replaced with kcalloc for readability
> - Thank you Gregory and Hyeonggon for your review & feedback!
> 
>   ...fs-kernel-mm-mempolicy-weighted-interleave |  30 ++-
>   drivers/acpi/numa/hmat.c                      |   1 +
>   drivers/base/node.c                           |   7 +
>   include/linux/mempolicy.h                     |   4 +
>   mm/mempolicy.c                                | 212 ++++++++++++++++--
>   5 files changed, 227 insertions(+), 27 deletions(-)

Hi Joshua, thanks for the update!
It actually is what I was intended in the manual / auto mode description.

I don't have a strong opinion on the weight of the hot-plugged NUMA node
in manual mode, as it's not ideal whatever weight we choose and the user
need to update the weight after hot-plug events anyway.

Some comments inlined below:

> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..d30dc29c53ff 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
>   		Minimum weight: 1
>   		Maximum weight: 255
>   
> -		Writing an empty string or `0` will reset the weight to the
> -		system default. The system default may be set by the kernel
> -		or drivers at boot or during hotplug events.
> +		Writing invalid values (i.e. any values not in [1,255],
> +		empty string, ...) will return -EINVAL.
> +
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
> +Date:		January 2025
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Auto-weighting configuration interface
> +
> +		Configuration modes for weighted interleave. Can take one of
> +		two options: "manual" and "auto". Default is "auto".
> +
> +		In auto mode, all node weights are re-calculated and overwritten
> +		(visible via the nodeN interfaces) whenever new bandwidth data
> +		is made available either during boot or hotplug events.
> +
> +		In manual mode, node weights can only be updated by the user.
> +		If a node is hotplugged while the user is in manual mode,
> +		the node will have a default weight of 1.
> +
> +		Modes can be changed by writing either "auto" or "manual" to the
> +		interface. All other strings will be ignored, and -EINVAL will
> +		be returned. If "auto" is written to the interface but the
> +		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
> +		then the mode will remain in manual mode.
> +
> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.

I think the last paragraph should also be included in the nodeX parameter.

> @@ -2450,16 +2548,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
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

Uh-hum...
Looks like it now allows copying weights from different versions of iw_tables?

Otherwise this patch looks good to me.

Best,
Hyeonggon

