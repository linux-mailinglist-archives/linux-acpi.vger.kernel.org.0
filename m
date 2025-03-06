Return-Path: <linux-acpi+bounces-11892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ED2A54B53
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 13:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F12B1896E6D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 12:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BABD204590;
	Thu,  6 Mar 2025 12:58:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94EB1FF5FF;
	Thu,  6 Mar 2025 12:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741265916; cv=none; b=q5FhJ1y73ejrN+2+3lhS9iCNzbpzvZmM/U1GjuW+YKmdRnAeivOmSUwvwN6xNjvsUPicJGSXCKgDxd6Iv5N/rkLu0fqv5PAWa62jxidJez5T9KLHYGkUVIZfsIttj2+k8e1oiSoGwHqeL+egVDF/u+2g0PzRqb1rRanShAXS/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741265916; c=relaxed/simple;
	bh=y7s7lGyFX3iNFqgRk0ihcfktWMN4aw9oCbcLmcXrFuM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=t7xQdspOHes6qpRtT4rl+R7NytuIsKe04KR0mv+HTmRWia2HzfaRN6Fm1Wp84gV/XWfdZH/8MH7jjTyc4Rl0Ywdiiu995ms+l2vzx18JXlQd3NZqV8jxrf+yQD0s5WPzWvQxmhw2Jp42hvuBl9F02rrQiyzQYjmFffDXRSAWVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-c7-67c99bf14897
Message-ID: <5fdd7db9-96fb-49ea-9803-977158cb0132@sk.com>
Date: Thu, 6 Mar 2025 21:58:25 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, yunjeong.mun@sk.com, gregkh@linuxfoundation.org,
 rakie.kim@sk.com, akpm@linux-foundation.org, rafael@kernel.org,
 lenb@kernel.org, dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
 dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
 osalvador@suse.de, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v7] mm/mempolicy: Weighted Interleave Auto-tuning
Content-Language: ko
To: Joshua Hahn <joshua.hahnjy@gmail.com>, gourry@gourry.net,
 harry.yoo@oracle.com, ying.huang@linux.alibaba.com
References: <20250305200506.2529583-1-joshua.hahnjy@gmail.com>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250305200506.2529583-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsXC9ZZnoe6n2SfTDe4yWcxZv4bNYvrUC4wW
	J242sln8vHuc3aJ58Xo2i9WbfC3uL3vGYnG7/xyrxaqF19gsjm+dx26x7yJQw86Hb9kslu/r
	Z7S4vGsOm8W9Nf9ZLc5MK7KY+2Uqs8XqNRkOQh6H37xn9tg56y67R3fbZXaPliNvWT0W73nJ
	5LFpVSebx6ZPk9g9Tsz4zeKx86Glx8KGqcwe++euYfc4d7HC4+PTWywem09Xe3zeJBfAH8Vl
	k5Kak1mWWqRvl8CVcbxrC0vBtROMFWu33GFuYLw2j7GLkZNDQsBE4tX2PWwwdt+5CewgNq+A
	pcT7HUtYQWwWARWJxzunsUHEBSVOznzCAmKLCshL3L81A6iei4NZYDqzxO01j8CahQVcJS4e
	m80MYjMLiEjM7mwDs0UEiiSOz/gMtJiDQ0jATuL02WCQMJuAmsSVl5OYQGxOAXuJ7u4JbBCt
	ZhJdW7sYIWx5ie1v5zCD7JIQuMcu8XTZXhaIoyUlDq64wTKBUXAWkvtmIVk9C8msWUhmLWBk
	WcUolJlXlpuYmWOil1GZl1mhl5yfu4kRGNfLav9E72D8dCH4EKMAB6MSD6/H1JPpQqyJZcWV
	uYcYJTiYlUR4L/oBhXhTEiurUovy44tKc1KLDzFKc7AoifMafStPERJITyxJzU5NLUgtgsky
	cXBKNTBK8+XvOrTpocgdtt8Xi1ZGRl6bYOK0bXKIeZwI05TAc2++B23JD+OVaLjdGjJlwa0N
	77WTBGfeTG9crsH9q733twir/aFMxjMX2Et0d5cf5wgUUlUprn4oecu5VvOn9leFPJ+vmgej
	H3gyq7+9VHoobVvOh/4wldObm806Z2+Z0mH4fH6Y4SolluKMREMt5qLiRABLn8he5wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsXCNUNLT/fj7JPpBr+eaFrMWb+GzWL61AuM
	FiduNrJZ/Lx7nN2iefF6NovVm3wt7i97xmJxu/8cq8WqhdfYLI5vncduse8iUMPhuSdZLXY+
	fMtmsXxfP6PF5V1z2CzurfnPanFmWpHF3C9TmS0OXXvOarF6TYbF720r2BxEPQ6/ec/ssXPW
	XXaP7rbL7B4tR96yeize85LJY9OqTjaPTZ8msXucmPGbxWPnQ0uPhQ1TmT32z13D7nHuYoXH
	x6e3WDy+3fbwWPziA5PH5tPVAYJRXDYpqTmZZalF+nYJXBnHu7awFFw7wVixdssd5gbGa/MY
	uxg5OSQETCT6zk1gB7F5BSwl3u9YwgpiswioSDzeOY0NIi4ocXLmExYQW1RAXuL+rRlA9Vwc
	zALTmSVur3kE1iws4Cpx8dhsZhCbWUBEYnZnG5gtIlAkcXzGZ6BlHBxCAnYSp88Gg4TZBNQk
	rrycxARicwrYS3R3T2CDaDWT6NraxQhhy0tsfzuHeQIj3ywkZ8xCsmEWkpZZSFoWMLKsYhTJ
	zCvLTczMMdUrzs6ozMus0EvOz93ECIzdZbV/Ju5g/HLZ/RCjAAejEg+vx9ST6UKsiWXFlbmH
	GCU4mJVEeC/6AYV4UxIrq1KL8uOLSnNSiw8xSnOwKInzeoWnJggJpCeWpGanphakFsFkmTg4
	pRoYE+tt19/gXvAo6GU4l5Hj1DmTF1Z92p2qICX+ij012DVOt3WRRr76NKa5cdUfwmQlb3D4
	lMXzlc4Rn/XFbLHQr+x2hmfPy04XBtny+taXiJ5Z7BVxpF5iH1NNxjm1xnTdjh+OS26+6km8
	43wqxId1X2vAYsHi3xfvWc1UlM46vMoi2Yd1+ywlluKMREMt5qLiRAAYlP/W2QIAAA==
X-CFilter-Loop: Reflected

Hi Joshua,

I didn't expect Andrew took this patch that fast but anyway ...

   Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>

I can also confirm that the auto-configured weights are sane under our
4ch CXL memory system. (with our upcoming fix for 12 nodes -> 4 nodes)

   # cd /sys/kernel/mm/mempolicy/weighted_interleave/
   # ls
   auto  node0  node1  node2  node3

   # cat auto node0 node1 node2 node3
   true
   3
   3
   2
   2

So I can also add this.

   Tested-by: Honggyu Kim <honggyu.kim@sk.com>

Thanks,
Honggyu

On 3/6/2025 5:05 AM, Joshua Hahn wrote:
> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.
> 
> Ideally, these weights should be proportional to their bandwidth, so
> that under bandwidth pressure, each node uses its maximal efficient
> bandwidth and prevents latency from increasing exponentially.
> 
> Previously, weighted interleave's default weights were just 1s -- which
> would be equivalent to the (unweighted) interleave mempolicy, which goes
> through the nodes in a round-robin fashion, ignoring bandwidth information.
> 
> This patch has two main goals:
> First, it makes weighted interleave easier to use for users who wish to
> relieve bandwidth pressure when using nodes with varying bandwidth (CXL).
> By providing a set of "real" default weights that just work out of the
> box, users who might not have the capability (or wish to) perform
> experimentation to find the most optimal weights for their system can
> still take advantage of bandwidth-informed weighted interleave.
> 
> Second, it allows for weighted interleave to dynamically adjust to
> hotplugged memory with new bandwidth information. Instead of manually
> updating node weights every time new bandwidth information is reported
> or taken off, weighted interleave adjusts and provides a new set of
> default weights for weighted interleave to use when there is a change
> in bandwidth information.
> 
> To meet these goals, this patch introduces an auto-configuration mode
> for the interleave weights that provides a reasonable set of default
> weights, calculated using bandwidth data reported by the system. In auto
> mode, weights are dynamically adjusted based on whatever the current
> bandwidth information reports (and responds to hotplug events).
> 
> This patch still supports users manually writing weights into the nodeN
> sysfs interface by entering into manual mode. When a user enters manual
> mode, the system stops dynamically updating any of the node weights,
> even during hotplug events that shift the optimal weight distribution.
> 
> A new sysfs interface "auto" is introduced, which allows users to switch
> between the auto (writing 1 or Y) and manual (writing 0 or N) modes. The
> system also automatically enters manual mode when a nodeN interface is
> manually written to.
> 
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Suggested-by: Yunjeong Mun <yunjeong.mun@sk.com>
> Suggested-by: Oscar Salvador <osalvador@suse.de>
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Suggested-by: Harry Yoo <harry.yoo@oracle.com>
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> ---
> Changelog
> v7:
> - Wordsmithing
> - Rename iw_table_lock to wi_state_lock
> - Clean up reduce_interleave_weights, as suggested by Yunjeong Mun.
>    - Combine iw_table allocation & initialization to be outside the function.
>    - Skip scaling to [1,100] before scaling to [1,weightiness].
> - Removed the second part of this patch, which prevented creating weight
>    sysfs interfaces for memoryless nodes.
> - Added Suggested-by tags; I should have done this much, much earlier.
> 
> v6:
> - iw_weights and mode_auto are combined into one rcu-protected struct.
> - Protection against memoryless nodes, as suggested by Oscar Salvador
> - Wordsmithing (documentation, commit message and comments), as suggested
>    by Andrew Morton.
> - Removed unnecessary #include statement in hmat.c, as pointed out by
>    Harry (Hyeonggon) Yoo and Ying Huang.
> - Bandwidth values changed from u64_t to unsigned int, as pointed out by
>    Ying Huang and Dan Carpenter.
> - RCU optimizations, as suggested by Ying Huang.
> - A second patch is included to fix unintended behavior that creates a
>    weight knob for memoryless nodes as well.
> - Sysfs show/store functions use str_true_false & kstrtobool.
> - Fix a build error in 32-bit systems, which are unable to perform
>    64-bit division by casting 64-bit values to 32-bit, if under the range.
> 
> v5:
> - I accidentally forgot to add the mm/mempolicy: subject tag since v1 of
>    this patch. Added to the subject now!
> - Wordsmithing, correcting typos, and re-naming variables for clarity.
> - No functional changes.
> 
> v4:
> - Renamed the mode interface to the "auto" interface, which now only
>    emits either 'Y' or 'N'. Users can now interact with it by
>    writing 'Y', '1', 'N', or '0' to it.
> - Added additional documentation to the nodeN sysfs interface.
> - Makes sure iw_table locks are properly held.
> - Removed unlikely() call in reduce_interleave_weights.
> - Wordsmithing
> 
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
>    case differently now. bw is always updated, iw updates depend on
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
>   ...fs-kernel-mm-mempolicy-weighted-interleave |  34 +-
>   drivers/base/node.c                           |   9 +
>   include/linux/mempolicy.h                     |   9 +
>   mm/mempolicy.c                                | 318 +++++++++++++++---
>   4 files changed, 311 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..862b19943a85 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -20,6 +20,34 @@ Description:	Weight configuration interface for nodeN
>   		Minimum weight: 1
>   		Maximum weight: 255
>   
> -		Writing an empty string or `0` will reset the weight to the
> -		system default. The system default may be set by the kernel
> -		or drivers at boot or during hotplug events.
> +		Writing invalid values (i.e. any values not in [1,255],
> +		empty string, ...) will return -EINVAL.
> +
> +		Changing the weight to a valid value will automatically
> +		update the system to manual mode as well.
> +
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
> +Date:		February 2025
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Auto-weighting configuration interface
> +
> +		Configuration mode for weighted interleave. A 'Y' indicates
> +		that the system is in auto mode, and a 'N' indicates that
> +		the system is in manual mode.
> +
> +		In auto mode, all node weights are re-calculated and overwritten
> +		(visible via the nodeN interfaces) whenever new bandwidth data
> +		is made available during either boot or hotplug events.
> +
> +		In manual mode, node weights can only be updated by the user.
> +		Note that nodes that are onlined with previously set weights
> +		will inherit those weights. If they were not previously set or
> +		are onlined with missing bandwidth data, the weights will use
> +		a default weight of 1.
> +
> +		Writing Y or 1 to the interface will enable auto mode, while
> +		writing N or 0 will enable manual mode. All other strings will
> +		be ignored, and -EINVAL will be returned.
> +
> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..f3c01fb90db1 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -7,6 +7,7 @@
>   #include <linux/init.h>
>   #include <linux/mm.h>
>   #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>   #include <linux/vmstat.h>
>   #include <linux/notifier.h>
>   #include <linux/node.h>
> @@ -214,6 +215,14 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>   			break;
>   		}
>   	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord)) {
> +			pr_info("failed to set mempolicy attrs for node %d\n",
> +				nid);
> +		}
> +	}
>   }
>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>   
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ce9885e0178a..78f1299bdd42 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -11,6 +11,7 @@
>   #include <linux/slab.h>
>   #include <linux/rbtree.h>
>   #include <linux/spinlock.h>
> +#include <linux/node.h>
>   #include <linux/nodemask.h>
>   #include <linux/pagemap.h>
>   #include <uapi/linux/mempolicy.h>
> @@ -56,6 +57,11 @@ struct mempolicy {
>   	} w;
>   };
>   
> +struct weighted_interleave_state {
> +	bool mode_auto;
> +	u8 iw_table[]; /* A null iw_table is interpreted as an array of 1s. */
> +};
> +
>   /*
>    * Support for managing mempolicy data objects (clone, copy, destroy)
>    * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
> @@ -178,6 +184,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>   
>   extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
>   
> +extern int mempolicy_set_node_perf(unsigned int node,
> +				   struct access_coordinate *coords);
> +
>   #else
>   
>   struct mempolicy {};
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index bbaadbeeb291..857ea3faa5cb 100644
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
> @@ -139,31 +140,135 @@ static struct mempolicy default_policy = {
>   static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>   
>   /*
> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> - * system-default value should be used. A NULL iw_table also denotes that
> - * system-default values should be used. Until the system-default table
> - * is implemented, the system-default is always 1.
> - *
> - * iw_table is RCU protected
> + * weightiness balances the tradeoff between small weights (cycles through nodes
> + * faster, more fair/even distribution) and large weights (smaller errors
> + * between actual bandwidth ratios and weight ratios). 32 is a number that has
> + * been found to perform at a reasonable compromise between the two goals.
>    */
> -static u8 __rcu *iw_table;
> -static DEFINE_MUTEX(iw_table_lock);
> +static const int weightiness = 32;
> +
> +/* wi_state is RCU protected */
> +static struct weighted_interleave_state __rcu *wi_state;
> +static unsigned int *node_bw_table;
> +
> +/*
> + * wi_state_lock protects both wi_state and node_bw_table.
> + * node_bw_table is only used by writers to update wi_state.
> + */
> +static DEFINE_MUTEX(wi_state_lock);
>   
>   static u8 get_il_weight(int node)
>   {
> -	u8 *table;
> -	u8 weight;
> +	u8 weight = 1;
>   
>   	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> -	/* if no iw_table, use system default */
> -	weight = table ? table[node] : 1;
> -	/* if value in iw_table is 0, use system default */
> -	weight = weight ? weight : 1;
> +	if (rcu_access_pointer(wi_state))
> +		weight = rcu_dereference(wi_state)->iw_table[node];
>   	rcu_read_unlock();
> +
>   	return weight;
>   }
>   
> +/*
> + * Convert bandwidth values into weighted interleave weights.
> + * Call with wi_state_lock.
> + */
> +static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
> +{
> +	u64 sum_bw = 0;
> +	unsigned int cast_sum_bw, scaling_factor = 1, iw_gcd = 0;
> +	int nid;
> +
> +	for_each_node_state(nid, N_MEMORY)
> +		sum_bw += bw[nid];
> +
> +	/* Scale bandwidths to whole numbers in the range [1, weightiness] */
> +	for_each_node_state(nid, N_MEMORY) {
> +		/*
> +		 * Try not to perform 64-bit division.
> +		 * If sum_bw < scaling_factor, then sum_bw < U32_MAX.
> +		 * If sum_bw > scaling_factor, then round the weight up to 1.
> +		 */
> +		scaling_factor = weightiness * bw[nid];
> +		if (bw[nid] && sum_bw < scaling_factor) {
> +			cast_sum_bw = (unsigned int)sum_bw;
> +			new_iw[nid] = scaling_factor / cast_sum_bw;
> +		} else {
> +			new_iw[nid] = 1;
> +		}
> +		if (!iw_gcd)
> +			iw_gcd = new_iw[nid];
> +		iw_gcd = gcd(iw_gcd, new_iw[nid]);
> +	}
> +
> +	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
> +	for_each_node_state(nid, N_MEMORY)
> +		new_iw[nid] /= iw_gcd;
> +}
> +
> +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> +{
> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> +	unsigned int *old_bw, *new_bw;
> +	unsigned int bw_val;
> +	int i;
> +
> +	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
> +	new_bw = kcalloc(nr_node_ids, sizeof(unsigned int), GFP_KERNEL);
> +	if (!new_bw)
> +		return -ENOMEM;
> +
> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> +			       GFP_KERNEL);
> +	if (!new_wi_state) {
> +		kfree(new_bw);
> +		return -ENOMEM;
> +	}
> +	for (i = 0; i < nr_node_ids; i++)
> +		new_wi_state->iw_table[i] = 1;
> +
> +	/*
> +	 * Update bandwidth info, even in manual mode. That way, when switching
> +	 * to auto mode in the future, iw_table can be overwritten using
> +	 * accurate bw data.
> +	 */
> +	mutex_lock(&wi_state_lock);
> +
> +	old_bw = node_bw_table;
> +	if (old_bw)
> +		memcpy(new_bw, old_bw, nr_node_ids * sizeof(unsigned int));
> +	new_bw[node] = bw_val;
> +	node_bw_table = new_bw;
> +
> +	/* wi_state not initialized yet; assume auto == true */
> +	if (!rcu_access_pointer(wi_state))
> +		goto reduce;
> +
> +	old_wi_state = rcu_dereference_protected(wi_state,
> +					lockdep_is_held(&wi_state_lock));
> +	if (old_wi_state->mode_auto)
> +		goto reduce;
> +
> +	mutex_unlock(&wi_state_lock);
> +	kfree(new_wi_state);
> +	kfree(old_bw);
> +	return 0;
> +
> +reduce:
> +	new_wi_state->mode_auto = true;
> +	reduce_interleave_weights(new_bw, new_wi_state->iw_table);
> +	rcu_assign_pointer(wi_state, new_wi_state);
> +
> +	mutex_unlock(&wi_state_lock);
> +	if (old_wi_state) {
> +		synchronize_rcu();
> +		kfree(old_wi_state);
> +	}
> +	kfree(old_bw);
> +
> +	return 0;
> +}
> +
>   /**
>    * numa_nearest_node - Find nearest node by state
>    * @node: Node id to start the search
> @@ -1988,34 +2093,33 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>   	u8 *table;
>   	unsigned int weight_total = 0;
>   	u8 weight;
> -	int nid;
> +	int nid = 0;
>   
>   	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
>   	if (!nr_nodes)
>   		return numa_node_id();
>   
>   	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> +	if (!rcu_access_pointer(wi_state))
> +		goto out;
> +
> +	table = rcu_dereference(wi_state)->iw_table;
>   	/* calculate the total weight */
> -	for_each_node_mask(nid, nodemask) {
> -		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> -		weight_total += weight;
> -	}
> +	for_each_node_mask(nid, nodemask)
> +		weight_total += table ? table[nid] : 1;
>   
>   	/* Calculate the node offset based on totals */
>   	target = ilx % weight_total;
>   	nid = first_node(nodemask);
>   	while (target) {
>   		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table[nid];
>   		if (target < weight)
>   			break;
>   		target -= weight;
>   		nid = next_node_in(nid, nodemask);
>   	}
> +out:
>   	rcu_read_unlock();
>   	return nid;
>   }
> @@ -2411,13 +2515,14 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>   		struct mempolicy *pol, unsigned long nr_pages,
>   		struct page **page_array)
>   {
> +	struct weighted_interleave_state *state;
>   	struct task_struct *me = current;
>   	unsigned int cpuset_mems_cookie;
>   	unsigned long total_allocated = 0;
>   	unsigned long nr_allocated = 0;
>   	unsigned long rounds;
>   	unsigned long node_pages, delta;
> -	u8 *table, *weights, weight;
> +	u8 *weights, weight;
>   	unsigned int weight_total = 0;
>   	unsigned long rem_pages = nr_pages;
>   	nodemask_t nodes;
> @@ -2467,17 +2572,19 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>   		return total_allocated;
>   
>   	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> -	if (table)
> -		memcpy(weights, table, nr_node_ids);
> -	rcu_read_unlock();
> +	if (rcu_access_pointer(wi_state)) {
> +		state = rcu_dereference(wi_state);
> +		memcpy(weights, state->iw_table, nr_node_ids * sizeof(u8));
> +		rcu_read_unlock();
> +	} else {
> +		rcu_read_unlock();
> +		for (i = 0; i < nr_node_ids; i++)
> +			weights[i] = 1;
> +	}
>   
>   	/* calculate total, detect system default usage */
> -	for_each_node_mask(node, nodes) {
> -		if (!weights[node])
> -			weights[node] = 1;
> +	for_each_node_mask(node, nodes)
>   		weight_total += weights[node];
> -	}
>   
>   	/*
>   	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
> @@ -3402,36 +3509,112 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>   static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   			  const char *buf, size_t count)
>   {
> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>   	struct iw_node_attr *node_attr;
> -	u8 *new;
> -	u8 *old;
>   	u8 weight = 0;
> +	int i;
>   
>   	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
>   	if (count == 0 || sysfs_streq(buf, ""))
>   		weight = 0;
> -	else if (kstrtou8(buf, 0, &weight))
> +	else if (kstrtou8(buf, 0, &weight) || weight == 0)
>   		return -EINVAL;
>   
> -	new = kzalloc(nr_node_ids, GFP_KERNEL);
> -	if (!new)
> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> +			       GFP_KERNEL);
> +	if (!new_wi_state)
>   		return -ENOMEM;
>   
> -	mutex_lock(&iw_table_lock);
> -	old = rcu_dereference_protected(iw_table,
> -					lockdep_is_held(&iw_table_lock));
> -	if (old)
> -		memcpy(new, old, nr_node_ids);
> -	new[node_attr->nid] = weight;
> -	rcu_assign_pointer(iw_table, new);
> -	mutex_unlock(&iw_table_lock);
> -	synchronize_rcu();
> -	kfree(old);
> +	mutex_lock(&wi_state_lock);
> +	if (rcu_access_pointer(wi_state)) {
> +		old_wi_state = rcu_dereference_protected(wi_state,
> +					lockdep_is_held(&wi_state_lock));
> +		memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> +					nr_node_ids * sizeof(u8));
> +	} else {
> +		for (i = 0; i < nr_node_ids; i++)
> +			new_wi_state->iw_table[i] = 1;
> +	}
> +	new_wi_state->iw_table[node_attr->nid] = weight;
> +	new_wi_state->mode_auto = false;
> +
> +	rcu_assign_pointer(wi_state, new_wi_state);
> +	mutex_unlock(&wi_state_lock);
> +	if (old_wi_state) {
> +		synchronize_rcu();
> +		kfree(old_wi_state);
> +	}
>   	return count;
>   }
>   
>   static struct iw_node_attr **node_attrs;
>   
> +static ssize_t weighted_interleave_auto_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	bool wi_auto = true;
> +
> +	rcu_read_lock();
> +	if (rcu_access_pointer(wi_state))
> +		wi_auto = rcu_dereference(wi_state)->mode_auto;
> +	rcu_read_unlock();
> +
> +	return sysfs_emit(buf, "%s\n", str_true_false(wi_auto));
> +}
> +
> +static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
> +	unsigned int *bw;
> +	bool input;
> +	int i;
> +
> +	if (kstrtobool(buf, &input))
> +		return -EINVAL;
> +
> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> +			       GFP_KERNEL);
> +	if (!new_wi_state)
> +		return -ENOMEM;
> +	for (i = 0; i < nr_node_ids; i++)
> +		new_wi_state->iw_table[i] = 1;
> +
> +	mutex_lock(&wi_state_lock);
> +	if (!input) {
> +		if (rcu_access_pointer(wi_state)) {
> +			old_wi_state = rcu_dereference_protected(wi_state,
> +					lockdep_is_held(&wi_state_lock));
> +			memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> +					nr_node_ids * sizeof(u8));
> +		}
> +		goto update_wi_state;
> +	}
> +
> +	bw = node_bw_table;
> +	if (!bw) {
> +		mutex_unlock(&wi_state_lock);
> +		kfree(new_wi_state);
> +		return -ENODEV;
> +	}
> +
> +	new_wi_state->mode_auto = true;
> +	reduce_interleave_weights(bw, new_wi_state->iw_table);
> +
> +update_wi_state:
> +	rcu_assign_pointer(wi_state, new_wi_state);
> +	mutex_unlock(&wi_state_lock);
> +	if (old_wi_state) {
> +		synchronize_rcu();
> +		kfree(old_wi_state);
> +	}
> +	return count;
> +}
> +
> +static struct kobj_attribute wi_attr =
> +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> +			   weighted_interleave_auto_store);
> +
>   static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>   				  struct kobject *parent)
>   {
> @@ -3489,6 +3672,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>   	return 0;
>   }
>   
> +static struct attribute *wi_default_attrs[] = {
> +	&wi_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group wi_attr_group = {
> +	.attrs = wi_default_attrs,
> +};
> +
>   static int add_weighted_interleave_group(struct kobject *root_kobj)
>   {
>   	struct kobject *wi_kobj;
> @@ -3505,6 +3697,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>   		return err;
>   	}
>   
> +	err = sysfs_create_group(wi_kobj, &wi_attr_group);
> +	if (err) {
> +		pr_err("failed to add sysfs [auto]\n");
> +		kobject_put(wi_kobj);
> +		return err;
> +	}
> +
>   	for_each_node_state(nid, N_POSSIBLE) {
>   		err = add_weight_node(nid, wi_kobj);
>   		if (err) {
> @@ -3519,15 +3718,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>   
>   static void mempolicy_kobj_release(struct kobject *kobj)
>   {
> -	u8 *old;
> +	struct weighted_interleave_state *old_wi_state;
> +
> +	mutex_lock(&wi_state_lock);
> +	if (!rcu_access_pointer(wi_state)) {
> +		mutex_unlock(&wi_state_lock);
> +		goto out;
> +	}
> +
> +	old_wi_state = rcu_dereference_protected(wi_state,
> +			lockdep_is_held(&wi_state_lock));
>   
> -	mutex_lock(&iw_table_lock);
> -	old = rcu_dereference_protected(iw_table,
> -					lockdep_is_held(&iw_table_lock));
> -	rcu_assign_pointer(iw_table, NULL);
> -	mutex_unlock(&iw_table_lock);
> +	rcu_assign_pointer(wi_state, NULL);
> +	mutex_unlock(&wi_state_lock);
>   	synchronize_rcu();
> -	kfree(old);
> +	kfree(old_wi_state);
> +out:
>   	kfree(node_attrs);
>   	kfree(kobj);
>   }
> 
> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc


