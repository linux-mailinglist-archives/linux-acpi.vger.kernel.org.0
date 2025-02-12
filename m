Return-Path: <linux-acpi+bounces-11078-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD5CA31C4D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 03:50:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96331888060
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 02:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36F71D47AD;
	Wed, 12 Feb 2025 02:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NDHbDciC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3FC225D6
	for <linux-acpi@vger.kernel.org>; Wed, 12 Feb 2025 02:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739328597; cv=none; b=PjQLx836uzDc+O8vc+iBSGH0JdUat0LDbMCLKqAlqjcoiHrfv5lIMtMgciTQfdmYJlWA3MpoiA5r51RUN8tRtYtPtkO8nrb7WKECLpqHnPdgrbY7Zu6VlXZJ5r1Iv8cuJKCmkUpPmxVUTC0fJvsaazwgZ1KlCLOugMRZLmVEbhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739328597; c=relaxed/simple;
	bh=t4jdm8aAjEASNSJ7dQyH0tbei8p5zPqrTyQPkiHDjeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRpywL+M+i23EqSuczXuQ8fcngUPB2juEi1soKq3FMR2lFTrCZz3nLyhxijI3fTn+xxDmOfD5w/EM86awsph5D3E94Ks9JsSofpgXrmrzpbbrT9WtTmjiDJT9lGrZkecy9E6UfAAGc5T4eU9TitcN9PKn9hwckxe8Kbj+xPrhZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NDHbDciC; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739328592; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=ZpbrcEKUGJysgSKHRBzTeKOkazM9B32hChdRQvetcrQ=;
	b=NDHbDciCQPE4D9zNudAVWIRtGSgcFpm5ryEx17iX9p8TXgVDAgedUvk9c1iHWoE3b9ceJLJyMEdVt/p9l2Jt4N2JB/U4oFPIx3p1E77KqN3IPbyDWXzV+7W+aD1q2BfAtypOYdnuagvGQ/riD3pkcyUoMM9nJ3vyvtveE7AG8i8=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPIPdKB_1739328573 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 10:49:50 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,  hyeonggon.yoo@sk.com,  honggyu.kim@sk.com,
  akpm@linux-foundation.org,  rafael@kernel.org,  lenb@kernel.org,
  gregkh@linuxfoundation.org,  rakie.kim@sk.com,  dan.j.williams@intel.com,
  Jonathan.Cameron@huawei.com,  dave.jiang@intel.com,
  horen.chuang@linux.dev,  hannes@cmpxchg.org,  linux-kernel@vger.org,
  linux-acpi@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v5] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250207201335.2105488-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Fri, 7 Feb 2025 12:13:35 -0800")
References: <20250207201335.2105488-1-joshua.hahnjy@gmail.com>
Date: Wed, 12 Feb 2025 10:49:32 +0800
Message-ID: <87a5ar3mir.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Thanks for your patch and sorry for late reply.

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On machines with multiple memory nodes, interleaving page allocations
> across nodes allows for better utilization of each node's bandwidth.
> Previous work by Gregory Price [1] introduced weighted interleave, which
> allowed for pages to be allocated across nodes according to user-set ratios.   
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

As asked by Andrew in another thread, you may need to make it more
explicit about why we need this patch.

> In this auto configuration mode, node weights are dynamically updated
> every time there is a hotplug event that introduces new bandwidth.
>
> Users can also enter manual mode by writing "N" or "0" to the new "auto"
> sysfs interface. When a user enters manual mode, the system stops
> dynamically updating any of the node weights, even during hotplug events
> that can shift the optimal weight distribution. The system also enters
> manual mode any time a user sets a node's weight directly by using the
> nodeN interface introduced in [1]. On the other hand, auto mode is
> only entered by explicitly writing "Y" or "1" to the auto interface.
>
> There is one functional change that this patch makes to the existing
> weighted_interleave ABI: previously, writing 0 directly to a nodeN
> interface was said to reset the weight to the system default. Before
> this patch, the default for all weights were 1, which meant that writing
> 0 and 1 were functionally equivalent.
>
> This patch introduces "real" defaults, but moves away from letting users
> use 0 as a "set to default" interface. Rather, users who want to use
> system defaults should use auto mode. This patch seems to be the
> appropriate place to make this change, since we would like to remove
> this usage before users begin to rely on the feature in userspace.
> Moreover, users will not be losing any functionality; they can still
> write 1 into a node if they want a weight of 1. Thus, we deprecate the
> "write zero to reset" feature in favor of returning an error, the same
> way we would return an error when the user writes any other invalid
> weight to the interface.
>
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
>
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Co-developed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> ---
> Changelog
> v5:
> - I accidentally forgot to add the mm/mempolicy: subject tag since v1 of
>   this patch. Added to the subject now!
> - Wordsmithing, correcting typos, and re-naming variables for clarity.
> - No functional changes.
> v4:
> - Renamed the mode interface to the "auto" interface, which now only
>   emits either 'Y' or 'N'. Users can now interact with it by
>   writing 'Y', '1', 'N', or '0' to it.
> - Added additional documentation to the nodeN sysfs interface.
> - Makes sure iw_table locks are properly held.
> - Removed unlikely() call in reduce_interleave_weights.
> - Wordsmithing
>
> v3:
> - Weightiness (max_node_weight) is now fixed to 32.
> - Instead, the sysfs interface now exposes a "mode" parameter, which
>   can either be "auto" or "manual".
>   - Thank you Hyeonggon and Honggyu for the feedback.
> - Documentation updated to reflect new sysfs interface, explicitly
>   specifies that 0 is invalid.
>   - Thank you Gregory and Ying for the discussion on how best to
>     handle the 0 case.
> - Re-worked nodeN sysfs store to handle auto --> manual shifts
> - mempolicy_set_node_perf internally handles the auto / manual
>   case differently now. bw is always updated, iw updates depend on
>   what mode the user is in.
> - Wordsmithing comments for clarity.
> - Removed RFC tag.
>
> v2:
> - Name of the interface is changed: "max_node_weight" --> "weightiness"
> - Default interleave weight table no longer exists. Rather, the
>   interleave weight table is initialized with the defaults, if bandwidth
>   information is available.
>   - In addition, all sections that handle iw_table have been changed
>     to reference iw_table if it exists, otherwise defaulting to 1.
> - All instances of unsigned long are converted to uint64_t to guarantee
>   support for both 32-bit and 64-bit machines
> - sysfs initialization cleanup
> - Documentation has been rewritten to explicitly outline expected
>   behavior and expand on the interpretation of "weightiness".
> - kzalloc replaced with kcalloc for readability
> - Thank you Gregory and Hyeonggon for your review & feedback!
>  ...fs-kernel-mm-mempolicy-weighted-interleave |  38 +++-
>  drivers/acpi/numa/hmat.c                      |   1 +
>  drivers/base/node.c                           |   7 +
>  include/linux/mempolicy.h                     |   4 +
>  mm/mempolicy.c                                | 200 ++++++++++++++++--
>  5 files changed, 233 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..ef43228d135d 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -20,6 +20,38 @@ Description:	Weight configuration interface for nodeN
>  		Minimum weight: 1
>  		Maximum weight: 255
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
> +		the system is in manual mode. All other values are invalid.
> +
> +		In auto mode, all node weights are re-calculated and overwritten
> +		(visible via the nodeN interfaces) whenever new bandwidth data
> +		is made available during either boot or hotplug events.
> +
> +		In manual mode, node weights can only be updated by the user.
> +		Note that nodes that are onlined with previously set / defaulted

Sorry, I don't understand this well.  What is "defaulted" weights?  Why
not just "previously set"?

> +		weights will inherit those weights. If they were not previously
> +		set or are onlined with missing bandwidth data, they will be
> +		defaulted to a weight of 1.
> +
> +		Writing Y or 1 to the interface will enable auto mode, while
> +		writing N or 0 will enable manual mode. All other strings will
> +		be ignored, and -EINVAL will be returned.
> +
> +		If Y or 1 is written to the interface but the recalculation or
> +		updates fail at any point (-ENOMEM or -ENODEV), then the system
> +		will remain in manual mode.

IMHO, it's unnecessary to make this a part of the interface definition.
However, I have no strong opinion on this.

> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 80a3481c0470..cc94cba112dd 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -20,6 +20,7 @@
>  #include <linux/list_sort.h>
>  #include <linux/memregion.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>  #include <linux/mutex.h>
>  #include <linux/node.h>
>  #include <linux/sysfs.h>

This change should be removed?

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..16e7a5a8ebe7 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -7,6 +7,7 @@
>  #include <linux/init.h>
>  #include <linux/mm.h>
>  #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>  #include <linux/vmstat.h>
>  #include <linux/notifier.h>
>  #include <linux/node.h>
> @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			break;
>  		}
>  	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord))
> +			pr_info("failed to set node%d mempolicy attrs\n", nid);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>  
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ce9885e0178a..0fe96f3ab3ef 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -11,6 +11,7 @@
>  #include <linux/slab.h>
>  #include <linux/rbtree.h>
>  #include <linux/spinlock.h>
> +#include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/pagemap.h>
>  #include <uapi/linux/mempolicy.h>
> @@ -178,6 +179,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>  
>  extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
>  
> +extern int mempolicy_set_node_perf(unsigned int node,
> +				   struct access_coordinate *coords);
> +
>  #else
>  
>  struct mempolicy {};
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 04f35659717a..51edd3663667 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -109,6 +109,7 @@
>  #include <linux/mmu_notifier.h>
>  #include <linux/printk.h>
>  #include <linux/swapops.h>
> +#include <linux/gcd.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/tlb.h>
> @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
>  
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
> +static uint64_t *node_bw_table;

Usually, we use "u64" instead of "uint64_t" in kernel.  It appears that
we don't need u64. "unsigned int" should be enough because "struct
access_coordinate" uses that too.

It's better to move this after iw_table definition below.  And make it
explicit that iw_table_lock protects all interleave weight global
variables.

> +
>  /*
> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> - * system-default value should be used. A NULL iw_table also denotes that
> - * system-default values should be used. Until the system-default table
> - * is implemented, the system-default is always 1.
> - *
> + * iw_table is the interleave weight table.
> + * If bandwidth data is available and the user is in auto mode, the table
                                             ~~~~
                                             system?

> + * is populated with default values in [1,255].

If system is in manual mode, the weight value is in [1, 255] too?

NULL iw_table is still a valid configuration, so we still need to
describe its behavior.  Right?

>   * iw_table is RCU protected
>   */
>  static u8 __rcu *iw_table;
>  static DEFINE_MUTEX(iw_table_lock);
> +static const int weightiness = 32;
> +static bool weighted_interleave_auto = true;
>  
>  static u8 get_il_weight(int node)
>  {
> @@ -156,14 +159,114 @@ static u8 get_il_weight(int node)
>  
>  	rcu_read_lock();
>  	table = rcu_dereference(iw_table);
> -	/* if no iw_table, use system default */

It appears that this applies at some degree.

>  	weight = table ? table[node] : 1;
> -	/* if value in iw_table is 0, use system default */
> -	weight = weight ? weight : 1;
>  	rcu_read_unlock();
>  	return weight;
>  }
>  
> +/*
> + * Convert bandwidth values into weighted interleave weights.
> + * Call with iw_table_lock.
> + */
> +static void reduce_interleave_weights(uint64_t *bw, u8 *new_iw)
> +{
> +	uint64_t sum_bw = 0, sum_iw = 0;
> +	uint64_t scaling_factor = 1, iw_gcd = 1;
> +	unsigned int i = 0;
> +
> +	/* Recalculate the bandwidth distribution given the new info */
> +	for (i = 0; i < nr_node_ids; i++)
> +		sum_bw += bw[i];
> +
> +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
> +	for (i = 0; i < nr_node_ids; i++) {
> +		if (bw[i]) {
> +			scaling_factor = 100 * bw[i];
> +			new_iw[i] = max(scaling_factor / sum_bw, 1);
> +		} else {
> +			new_iw[i] = 1;
> +		}
> +		sum_iw += new_iw[i];
> +	}
> +
> +	/*
> +	 * Scale each node's share of the total bandwidth from percentages
> +	 * to whole numbers in the range [1, weightiness]
> +	 */
> +	for (i = 0; i < nr_node_ids; i++) {
> +		scaling_factor = weightiness * new_iw[i];
> +		new_iw[i] = max(scaling_factor / sum_iw, 1);
> +		if (i == 0)
> +			iw_gcd = new_iw[0];
> +		iw_gcd = gcd(iw_gcd, new_iw[i]);
> +	}
> +
> +	/* 1:2 is strictly better than 16:32. Reduce by the weights' GCD. */
> +	for (i = 0; i < nr_node_ids; i++)
> +		new_iw[i] /= iw_gcd;
> +}
> +
> +int mempolicy_set_node_perf(unsigned int node, struct access_coordinate *coords)
> +{
> +	uint64_t *old_bw, *new_bw;
> +	uint64_t bw_val;
> +	u8 *old_iw, *new_iw;
> +
> +	/*
> +	 * Bandwidths above this limit cause rounding errors when reducing
> +	 * weights. This value is ~16 exabytes, which is unreasonable anyways.
> +	 */
> +	bw_val = min(coords->read_bandwidth, coords->write_bandwidth);
> +	if (bw_val > (U64_MAX / 10))
> +		return -EINVAL;
> +
> +	new_bw = kcalloc(nr_node_ids, sizeof(uint64_t), GFP_KERNEL);
> +	if (!new_bw)
> +		return -ENOMEM;
> +
> +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
> +	if (!new_iw) {
> +		kfree(new_bw);
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * Update bandwidth info, even in manual mode. That way, when switching
> +	 * to auto mode in the future, iw_table can be overwritten using
> +	 * accurate bw data.
> +	 */
> +	mutex_lock(&iw_table_lock);
> +	old_bw = node_bw_table;
> +	old_iw = rcu_dereference_protected(iw_table,
> +					   lockdep_is_held(&iw_table_lock));
> +
> +	if (old_bw)
> +		memcpy(new_bw, old_bw, nr_node_ids * sizeof(uint64_t));
> +	new_bw[node] = bw_val;
> +	node_bw_table = new_bw;
> +
> +	if (weighted_interleave_auto) {
> +		reduce_interleave_weights(new_bw, new_iw);
> +	} else if (old_iw) {
> +		/*
> +		 * The first time mempolicy_set_node_perf is called, old_iw
> +		 * (iw_table) is null. If that is the case, assign a zeroed
> +		 * table to it. Otherwise, free the newly allocated iw_table.

We shouldn't assign a zeroed iw_table?  Because 0 isn't valid now.
Please check changes in weighted_interleave_nid() below.

> +		 */
> +		mutex_unlock(&iw_table_lock);
> +		kfree(new_iw);
> +		kfree(old_bw);
> +		return 0;
> +	}
> +
> +	rcu_assign_pointer(iw_table, new_iw);
> +	mutex_unlock(&iw_table_lock);
> +	synchronize_rcu();
> +	kfree(old_iw);

If you want to save one synchronize_rcu() if unnecessary, you can use

        if (old_iw) {
                synchronize_rcu();
                kfree(old_iw);
        }

> +	kfree(old_bw);
> +	return 0;
> +}
> +
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -1998,10 +2101,7 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  	table = rcu_dereference(iw_table);
>  	/* calculate the total weight */
>  	for_each_node_mask(nid, nodemask) {
> -		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> -		weight_total += weight;
> +		weight_total += table ? table[nid] : 1;
>  	}
>  
>  	/* Calculate the node offset based on totals */
> @@ -2010,7 +2110,6 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  	while (target) {
>  		/* detect system default usage */
>  		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
>  		if (target < weight)
>  			break;
>  		target -= weight;
> @@ -3394,7 +3493,7 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
>  	if (count == 0 || sysfs_streq(buf, ""))
>  		weight = 0;
> -	else if (kstrtou8(buf, 0, &weight))
> +	else if (kstrtou8(buf, 0, &weight) || weight == 0)
>  		return -EINVAL;
>  
>  	new = kzalloc(nr_node_ids, GFP_KERNEL);
> @@ -3411,11 +3510,68 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  	mutex_unlock(&iw_table_lock);
>  	synchronize_rcu();
>  	kfree(old);
> +	weighted_interleave_auto = false;
>  	return count;
>  }
>  
>  static struct iw_node_attr **node_attrs;
>  
> +static ssize_t weighted_interleave_mode_show(struct kobject *kobj,

IMHO, it's better to name the function as
weighted_interleave_auto_show()?

> +		struct kobj_attribute *attr, char *buf)
> +{
> +	if (weighted_interleave_auto)
> +		return sysfs_emit(buf, "Y\n");
> +	else
> +		return sysfs_emit(buf, "N\n");

str_true_false() can be used here.

> +}
> +
> +static ssize_t weighted_interleave_mode_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	uint64_t *bw;
> +	u8 *old_iw, *new_iw;
> +
> +	if (count == 0)
> +		return -EINVAL;
> +
> +	if (sysfs_streq(buf, "N") || sysfs_streq(buf, "0")) {

kstrtobool() can be used here.  It can deal with 'count == 0' case too.

> +		weighted_interleave_auto = false;
> +		return count;
> +	} else if (!sysfs_streq(buf, "Y") && !sysfs_streq(buf, "1")) {
> +		return -EINVAL;
> +	}
> +
> +	new_iw = kcalloc(nr_node_ids, sizeof(u8), GFP_KERNEL);
> +	if (!new_iw)
> +		return -ENOMEM;
> +
> +	mutex_lock(&iw_table_lock);
> +	bw = node_bw_table;
> +
> +	if (!bw) {
> +		mutex_unlock(&iw_table_lock);
> +		kfree(new_iw);
> +		return -ENODEV;
> +	}
> +
> +	old_iw = rcu_dereference_protected(iw_table,
> +					   lockdep_is_held(&iw_table_lock));
> +
> +	reduce_interleave_weights(bw, new_iw);
> +	rcu_assign_pointer(iw_table, new_iw);
> +	mutex_unlock(&iw_table_lock);
> +
> +	synchronize_rcu();
> +	kfree(old_iw);
> +
> +	weighted_interleave_auto = true;

Why assign weighted_interleave_auto after synchronize_rcu()?  To reduce
the race window, it's better to change weighted_interleave_auto and
iw_table together?  Is it better to put them into a data structure and
change them together always?

        struct weighted_interleave_state {
                bool weighted_interleave_auto;
                u8 iw_table[0]
        };

> +	return count;
> +}
> +
> +static struct kobj_attribute wi_attr =
> +	__ATTR(auto, 0664, weighted_interleave_mode_show,
> +			   weighted_interleave_mode_store);
> +
>  static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>  				  struct kobject *parent)
>  {
> @@ -3473,6 +3629,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
>  	return 0;
>  }
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
>  static int add_weighted_interleave_group(struct kobject *root_kobj)
>  {
>  	struct kobject *wi_kobj;
> @@ -3489,6 +3654,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  		return err;
>  	}
>  
> +	err = sysfs_create_group(wi_kobj, &wi_attr_group);
> +	if (err) {
> +		pr_err("failed to add sysfs [auto]\n");
> +		kobject_put(wi_kobj);
> +		return err;
> +	}
> +
>  	for_each_node_state(nid, N_POSSIBLE) {
>  		err = add_weight_node(nid, wi_kobj);
>  		if (err) {

---
Best Regards,
Huang, Ying

