Return-Path: <linux-acpi+bounces-11979-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93987A58A66
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 03:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB7163ADA
	for <lists+linux-acpi@lfdr.de>; Mon, 10 Mar 2025 02:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6F3189906;
	Mon, 10 Mar 2025 02:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AJ4KgrnX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4F770814;
	Mon, 10 Mar 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741573373; cv=none; b=MbjEcWzeAZH5vaEFDAg6/xnwnKQuiIphme6uw789bnEopcsXQ1uA+hjQfRDRJxsnREkdEWYeP1k+Sr2356DWf27fW9UUB8PRu4ZRh4T0kRvGveMC5FrAA6hElGxaHKJHPsCfzEFnq+hdhQdJQh8iiCbIZRqNTDB2Wf3O/Jn7fxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741573373; c=relaxed/simple;
	bh=A1R7g4zDAU+E4M4BxFXCwJCuJarA454T0dMV3nWTUek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ToBZBWftDcFFDXUiNpvNQmDM4Savfohi+mIHuu1uuJkeSwrK1UpBhfSdkctvFYdLHSuOQfvChqdmKnyrLmXkm8kTzUNOzvBkmIwW+m/iX7UjEJK7IitKnfY4gazob2llynjUe1ihBQe7tgkemY/W1kn9MYWd8hkIBLpevj0wKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AJ4KgrnX; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741573365; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=qU37W5kgf5YoBuCts8FpM8WlMw/+BZqrVRTpK5YJPQg=;
	b=AJ4KgrnXhx1kxoeX7HuVeWn9/Y0NBqE1TgpjHwZQpElpQOAsiXI01EgtxeaXyLIP50nqTQd1PWNE6ukEVRs5sBpqn/7oCMVb+bK5ECAf2fZGb54Oq6ykiUSlTd+EOJVAVJjtnS3K7g0QNfZzz5mTMViLqgDTT348TOOpPak0lCE=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WQyTgQa_1741573350 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 10:22:44 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: gourry@gourry.net,  harry.yoo@oracle.com,  honggyu.kim@sk.com,
  yunjeong.mun@sk.com,  gregkh@linuxfoundation.org,  rakie.kim@sk.com,
  akpm@linux-foundation.org,  rafael@kernel.org,  lenb@kernel.org,
  dan.j.williams@intel.com,  Jonathan.Cameron@huawei.com,
  dave.jiang@intel.com,  horen.chuang@linux.dev,  hannes@cmpxchg.org,
  osalvador@suse.de,  linux-kernel@vger.kernel.org,
  linux-acpi@vger.kernel.org,  linux-mm@kvack.org,  kernel-team@meta.com
Subject: Re: [PATCH v7] mm/mempolicy: Weighted Interleave Auto-tuning
In-Reply-To: <20250305200506.2529583-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Wed, 5 Mar 2025 12:05:05 -0800")
References: <20250305200506.2529583-1-joshua.hahnjy@gmail.com>
Date: Mon, 10 Mar 2025 10:22:30 +0800
Message-ID: <874j0162vt.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Thanks for your new version.

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

Forget to describe the new functionality?

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
>   - Combine iw_table allocation & initialization to be outside the function.
>   - Skip scaling to [1,100] before scaling to [1,weightiness].
> - Removed the second part of this patch, which prevented creating weight
>   sysfs interfaces for memoryless nodes.
> - Added Suggested-by tags; I should have done this much, much earlier.
>
> v6:
> - iw_weights and mode_auto are combined into one rcu-protected struct.
> - Protection against memoryless nodes, as suggested by Oscar Salvador
> - Wordsmithing (documentation, commit message and comments), as suggested
>   by Andrew Morton.
> - Removed unnecessary #include statement in hmat.c, as pointed out by
>   Harry (Hyeonggon) Yoo and Ying Huang.
> - Bandwidth values changed from u64_t to unsigned int, as pointed out by
>   Ying Huang and Dan Carpenter.
> - RCU optimizations, as suggested by Ying Huang.
> - A second patch is included to fix unintended behavior that creates a
>   weight knob for memoryless nodes as well.
> - Sysfs show/store functions use str_true_false & kstrtobool.
> - Fix a build error in 32-bit systems, which are unable to perform
>   64-bit division by casting 64-bit values to 32-bit, if under the range.
>
> v5:
> - I accidentally forgot to add the mm/mempolicy: subject tag since v1 of
>   this patch. Added to the subject now!
> - Wordsmithing, correcting typos, and re-naming variables for clarity.
> - No functional changes.
>
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
>
>  ...fs-kernel-mm-mempolicy-weighted-interleave |  34 +-
>  drivers/base/node.c                           |   9 +
>  include/linux/mempolicy.h                     |   9 +
>  mm/mempolicy.c                                | 318 +++++++++++++++---
>  4 files changed, 311 insertions(+), 59 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..862b19943a85 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -20,6 +20,34 @@ Description:	Weight configuration interface for nodeN
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
> +		the system is in manual mode.

str_true_false() is used to show the attribute, so the "true/false" will
be displayed?

> +
> +		In auto mode, all node weights are re-calculated and overwritten
> +		(visible via the nodeN interfaces) whenever new bandwidth data
> +		is made available during either boot or hotplug events.
> +
> +		In manual mode, node weights can only be updated by the user.
> +		Note that nodes that are onlined with previously set weights
> +		will inherit those weights. If they were not previously set or

s/inherit/reuse/?

However my English is poor, so keep it if you think that is better.

> +		are onlined with missing bandwidth data, the weights will use
> +		a default weight of 1.
> +
> +		Writing Y or 1 to the interface will enable auto mode, while

kstrtobool() is used to parser user input, so maybe something like
below?

Writing any true value string (e.g., Y or 1) will enable auto mode.

> +		writing N or 0 will enable manual mode. All other strings will
> +		be ignored, and -EINVAL will be returned.
> +
> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.

s/update/switch/?

Again, keep your words if think that it's better.

> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..f3c01fb90db1 100644
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
> @@ -214,6 +215,14 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>  			break;
>  		}
>  	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord)) {
> +			pr_info("failed to set mempolicy attrs for node %d\n",
> +				nid);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>  
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ce9885e0178a..78f1299bdd42 100644
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
> @@ -56,6 +57,11 @@ struct mempolicy {
>  	} w;
>  };
>  
> +struct weighted_interleave_state {
> +	bool mode_auto;

Just "auto" looks more natural for me.  However, I have no strong
opinion on thist.

> +	u8 iw_table[]; /* A null iw_table is interpreted as an array of 1s. */

What is "null" array?

IIUC, iw_state is prevous iw_table now, so we may replace this with,

A null wi_state is interpreted as mode is "auto" and the weight of any
node is "1".

?

> +};
> +
>  /*
>   * Support for managing mempolicy data objects (clone, copy, destroy)
>   * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
> @@ -178,6 +184,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
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
> index bbaadbeeb291..857ea3faa5cb 100644
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
> @@ -139,31 +140,135 @@ static struct mempolicy default_policy = {
>  static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>  
>  /*
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
>   */
> -static u8 __rcu *iw_table;
> -static DEFINE_MUTEX(iw_table_lock);
> +static const int weightiness = 32;
> +
> +/* wi_state is RCU protected */

"__rcu" below can replace the above comments?

> +static struct weighted_interleave_state __rcu *wi_state;
> +static unsigned int *node_bw_table;
> +
> +/*
> + * wi_state_lock protects both wi_state and node_bw_table.
> + * node_bw_table is only used by writers to update wi_state.
> + */
> +static DEFINE_MUTEX(wi_state_lock);
>  
>  static u8 get_il_weight(int node)
>  {
> -	u8 *table;
> -	u8 weight;
> +	u8 weight = 1;
>  
>  	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> -	/* if no iw_table, use system default */
> -	weight = table ? table[node] : 1;
> -	/* if value in iw_table is 0, use system default */
> -	weight = weight ? weight : 1;
> +	if (rcu_access_pointer(wi_state))
> +		weight = rcu_dereference(wi_state)->iw_table[node];

IIUC, wi_state may be changed between rcu_access_pointer() and
rcu_dereference().  If so, it's better to use rcu_dereference()
directly.

>  	rcu_read_unlock();
> +
>  	return weight;
>  }
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

NIT: because we will always initialize new_wi_state->iw_table[] below,
we can just use kmalloc() and initailze new_wi_state->mode_auto?

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

I prefer

		memcpy(new_bw, old_bw, nr_node_ids * sizeof(*old_bw));

a little.  But it's not a big deal.

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

Because we can use "!old_wi_state || !old_wi_state->mode_auto" here, I
don't think rcu_access_pointer() above gives us something.

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
>  /**
>   * numa_nearest_node - Find nearest node by state
>   * @node: Node id to start the search
> @@ -1988,34 +2093,33 @@ static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
>  	u8 *table;
>  	unsigned int weight_total = 0;
>  	u8 weight;
> -	int nid;
> +	int nid = 0;
>  
>  	nr_nodes = read_once_policy_nodemask(pol, &nodemask);
>  	if (!nr_nodes)
>  		return numa_node_id();
>  
>  	rcu_read_lock();
> -	table = rcu_dereference(iw_table);
> +	if (!rcu_access_pointer(wi_state))
> +		goto out;

If wi_state == NULL, why should we always return 0?  IIUC, wi_state ==
NULL means the weight of any node is 1.

> +
> +	table = rcu_dereference(wi_state)->iw_table;
>  	/* calculate the total weight */
> -	for_each_node_mask(nid, nodemask) {
> -		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> -		weight_total += weight;
> -	}
> +	for_each_node_mask(nid, nodemask)
> +		weight_total += table ? table[nid] : 1;

When will table be NULL here?

>  
>  	/* Calculate the node offset based on totals */
>  	target = ilx % weight_total;
>  	nid = first_node(nodemask);
>  	while (target) {
>  		/* detect system default usage */
> -		weight = table ? table[nid] : 1;
> -		weight = weight ? weight : 1;
> +		weight = table[nid];
>  		if (target < weight)
>  			break;
>  		target -= weight;
>  		nid = next_node_in(nid, nodemask);
>  	}
> +out:
>  	rcu_read_unlock();
>  	return nid;
>  }
> @@ -2411,13 +2515,14 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  		struct mempolicy *pol, unsigned long nr_pages,
>  		struct page **page_array)
>  {
> +	struct weighted_interleave_state *state;
>  	struct task_struct *me = current;
>  	unsigned int cpuset_mems_cookie;
>  	unsigned long total_allocated = 0;
>  	unsigned long nr_allocated = 0;
>  	unsigned long rounds;
>  	unsigned long node_pages, delta;
> -	u8 *table, *weights, weight;
> +	u8 *weights, weight;
>  	unsigned int weight_total = 0;
>  	unsigned long rem_pages = nr_pages;
>  	nodemask_t nodes;
> @@ -2467,17 +2572,19 @@ static unsigned long alloc_pages_bulk_weighted_interleave(gfp_t gfp,
>  		return total_allocated;
>  
>  	rcu_read_lock();
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
>  	/* calculate total, detect system default usage */
> -	for_each_node_mask(node, nodes) {
> -		if (!weights[node])
> -			weights[node] = 1;
> +	for_each_node_mask(node, nodes)
>  		weight_total += weights[node];
> -	}
>  
>  	/*
>  	 * Calculate rounds/partial rounds to minimize __alloc_pages_bulk calls.
> @@ -3402,36 +3509,112 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>  static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>  			  const char *buf, size_t count)
>  {
> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>  	struct iw_node_attr *node_attr;
> -	u8 *new;
> -	u8 *old;
>  	u8 weight = 0;
> +	int i;
>  
>  	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
>  	if (count == 0 || sysfs_streq(buf, ""))
>  		weight = 0;
> -	else if (kstrtou8(buf, 0, &weight))
> +	else if (kstrtou8(buf, 0, &weight) || weight == 0)
>  		return -EINVAL;
>  
> -	new = kzalloc(nr_node_ids, GFP_KERNEL);
> -	if (!new)
> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> +			       GFP_KERNEL);
> +	if (!new_wi_state)
>  		return -ENOMEM;
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
>  	return count;
>  }
>  
>  static struct iw_node_attr **node_attrs;
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

NIT: "wi_attr" appears too general for me.  Maybe something like
"wi_auto_attr"?

> +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> +			   weighted_interleave_auto_store);
> +
>  static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>  				  struct kobject *parent)
>  {
> @@ -3489,6 +3672,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
> @@ -3505,6 +3697,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
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
> @@ -3519,15 +3718,22 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>  
>  static void mempolicy_kobj_release(struct kobject *kobj)
>  {
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
>  	synchronize_rcu();
> -	kfree(old);
> +	kfree(old_wi_state);
> +out:
>  	kfree(node_attrs);
>  	kfree(kobj);
>  }
>
> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc

---
Best Regards,
Huang, Ying

