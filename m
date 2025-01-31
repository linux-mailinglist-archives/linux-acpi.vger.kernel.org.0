Return-Path: <linux-acpi+bounces-10871-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C678A23F14
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 15:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E8123A6068
	for <lists+linux-acpi@lfdr.de>; Fri, 31 Jan 2025 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3A51CAA92;
	Fri, 31 Jan 2025 14:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh1a399F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8DEAC6;
	Fri, 31 Jan 2025 14:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333425; cv=none; b=tzssEfh2ydeG98s8gGWdUVmVZz4cIRFwSa3llb0IFIf15g8Ht2IQ9M96mQQHTZYILUU+FSVfKfcXioG/tsNQ/iA7F+VenyWQ7wv7rkLCrXmKpOWmzv9xYsT6pbqCpeNePQzmB63wFp3Zt5YM7TjafyLFsYnpSv01+4zDOwTItaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333425; c=relaxed/simple;
	bh=UBp2J8DVFWNLCbpQgbGh7veRFV+5Pc0uSzzmwJVBfDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ifv19Tr1npko/rP2GesjQIHX2meRBd6SO8Jt0IXNGWWkX/4ZAsKKr1a+WudoXVOBvE/qGq1Ry2kWImrDN5irG43LARaAfUB8njhgAMj9a/ZBtes4zkJXse156J9FYKfidscQfQThO4QnKIuPUsXOAqgOU+Ibno7uRCOjwTi9/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh1a399F; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21649a7bcdcso36768245ad.1;
        Fri, 31 Jan 2025 06:23:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738333423; x=1738938223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARjCakve7mgdK1H0BwgCO4BIUlFMuzNVILcOIXbfRi8=;
        b=Kh1a399FCVg05bUfORa65LXy3OifhBjsooedu23qhM+c7mMW0a1Qw3juSZZLZkcuNd
         hYIAPLyIJgXtWAggdInk++HWorwbTa0TMm3fiWKU3/DMeop2RYDreDGko3M/xm+TKq+X
         Kgz5EhhLTrRjg5F9VZVwpDmaqZn3EFHrMKeHrfuItQqoxby+JwDKCuLmsFNCQijFmLza
         XZuGyfgt56ae3dZqht9F39OLAMZGeU22ANs3BR5cit4FWTrfRZtwFnj6PDFraviIKtUr
         yWiXJtK3xBg3K8xDUbd7+yph2kSDg743GqtifElZ7EMcnXQ2+NH87wk0m3/7+eSINjjC
         2qOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738333423; x=1738938223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARjCakve7mgdK1H0BwgCO4BIUlFMuzNVILcOIXbfRi8=;
        b=SSCELUN//XmZ6VwgFZK5Dg3h2SJpamxGFe9LaKhnhkMcR4npk3AFu55+vsnBkt8/MI
         rjGO0fcgmBbgRbC0215e58oDj8azjjc1dacuvtwHx8FqNJ7xMgf77hELAiQRgVmNImr5
         SbefpPmGuX3V4PtQDs0DPVreKSzWX6b3L5rHV0w2vaAlnhkPvSJWK9mxInr8E3fFyKLf
         kWyHCGkyMu2qTeTjqbWRzQlm0nYzg2DpFUVNs/ISO2N2tBc4EvWXhqAGYvw1e66Re757
         ceeOlMWFErCUy8zF64yYr84f/Ile9o8obAUEP5oOS8xHs3edZaqLqbwCWupa1YZPYEnj
         C57w==
X-Forwarded-Encrypted: i=1; AJvYcCU5EOGJfpp+f0qgPYdZXmM3g7kgrJJ03Xc6YCV33pKhV6ZRsWGPVTw5Ivhd3/BVyvuBXWbx+cx4gtyXIH+n@vger.kernel.org, AJvYcCUkp7KazkRKRb/YTTWHjf2nteirwMBSHlnfucnXj4AMQ5jtj3AVeBlAaeV9r6ycugwGFy5daScF2/V5@vger.kernel.org
X-Gm-Message-State: AOJu0YwODB+ThytOrkOXthmktrzmcHwhoBcockoG15dvTA+q6dXq1bba
	+SqE3q5IBH547xNx9U9gG/HWLck1P7dNUJxGTWMpn8CmCVPxb5Je
X-Gm-Gg: ASbGncs1LRLGOzDomMqSHw3SXiApAuboGu2e/1QaR2wPz06lCG5V8Z8LQKoXgPubXRg
	fATaCYqOO1BgnQnLs2HE95F0tYu+Md2tjjkjqi7I+HVklg2AwfbZoiK2P8kUADgF21h+Y46yaGt
	r7tbONEDJ+Kq0lM4moaMWVHwA4f/n2UpUmWdYLDnge/AwSL4nko3ov7jz8g2Z7CLmVssue0ZZrF
	5Ynr9TWUzwZ7ZEpF9jJkgGydUw5rSEj2HymmKIHV8NPq5FuxmE03A/Smnrjokm1LDKFH6W/rDjF
	mjXqUwLqVpvsZE8I/tJ/aVG/
X-Google-Smtp-Source: AGHT+IHlix273zN3fIW6sOXprknGjDEnzUPDPgPG8ZJxarufv3yoAZJE7C8S3dO9ckkKc0A4GpUGbA==
X-Received: by 2002:a17:902:ce8f:b0:215:9d29:9724 with SMTP id d9443c01a7336-21dd7ddfdc9mr176888955ad.38.1738333422691;
        Fri, 31 Jan 2025 06:23:42 -0800 (PST)
Received: from [192.168.75.213] ([116.121.188.179])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-acec04796c9sm3137988a12.62.2025.01.31.06.23.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2025 06:23:42 -0800 (PST)
Message-ID: <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>
Date: Fri, 31 Jan 2025 23:23:34 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Honggyu Kim <honggyu.km@gmail.com>
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>, gourry@gourry.net,
 ying.huang@linux.alibaba.com
Cc: rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
 dan.j.williams@intel.com, Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
 horen.chuang@linux.dev, hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
 kernel_team@skhynix.com, 42.hyeyoo@gmail.com
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
In-Reply-To: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joshua,

Thank you for the v4 update!

It took a long time to give you a feedback due to Luna new year's
holiday.  Happy new year anyway!

On 1/29/25 07:23, Joshua Hahn wrote:
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
> 
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
> ---
> Changelog
> v4:
> - Renamed the mode inerface to the "auto" interface, which now only

[nit] inerface -> interface

So we're going back to similar to "use_default" now.  I prefer "mode"
with string interface with "auto" and "manual", but I also agree with
Ying that "mode" won't have more options in the future so this kind of
binary interface with "auto" is also fine.

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
>    caes differently now. bw is always updated, iw updates depend on

[nit] caes -> case

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
> ...fs-kernel-mm-mempolicy-weighted-interleave |  34 ++-
>   drivers/acpi/numa/hmat.c                      |   1 +
>   drivers/base/node.c                           |   7 +
>   include/linux/mempolicy.h                     |   4 +
>   mm/mempolicy.c                                | 200 ++++++++++++++++--
>   5 files changed, 229 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..c26879f59d5d 100644
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
> +Date:		January 2025
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
> +		If a node is hotplugged while the user is in manual mode,
> +		the node will have a default weight of 1.

Sorry for jumping into this discussion a bit late, but IMHO, setting a
newly onlined node's weight to 1 can possibly make the entire weight
ratio unbalanced.

We can avoid this default weight by not choosing the new node in
nodemask as Ying suggested, but some APIs of numactl uses all available
nodes in the system and the following API is one of the example.

   void *numa_alloc_weighted_interleaved(size_t size);
   (Add by Hyeonggon at https://github.com/numactl/numactl/pull/238)

The description of this API is as follows.

   numa_alloc_weighted_interleaved() allocates size bytes of memory page
   interleaved on _all nodes_ according to the weights in
   /sys/kernel/mm/mempolicy/weighted_interleave/node*.

Let's say there are 3 nodes and there bandwidth ratio is as follows.

   node0 - 1000
   node1 - 500
   node2 - 100

In this case, the weight ratio will be 10:5:1 in auto mode.  I worry
about the following problematic scenario.

   1. the auto mode set the weights as 10:5:1 for node{0-2}.
   2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.
   3. the auto sysfs interface is set to 0 to make it manual mode.
   4. node2 is onlined again, then the weights is now 2:1:1.
   5. calling numa_alloc_weighted_interleaved() API works in bad weights.

IMHO, the weight of onlined node is better to be 0 in manual mode and
give responsibility of setting the proper weight to users.

Could anyone please correct me if I miss something for this?

> +
> +		Modes can be changed by writing Y, N, 1, or 0 to the interface.
> +		All other strings will be ignored, and -EINVAL will be returned.
> +		If Y or 1 is written to the interface but the recalculation or
> +		updates fail at any point (-ENOMEM or -ENODEV), then the mode
> +		will remain in manual mode.
> +
> +		Writing a new weight to a node directly via the nodeN interface
> +		will also automatically update the system to manual mode.
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 80a3481c0470..cc94cba112dd 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -20,6 +20,7 @@
>   #include <linux/list_sort.h>
>   #include <linux/memregion.h>
>   #include <linux/memory.h>
> +#include <linux/mempolicy.h>
>   #include <linux/mutex.h>
>   #include <linux/node.h>
>   #include <linux/sysfs.h>
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..16e7a5a8ebe7 100644
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
> @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>   			break;
>   		}
>   	}
> +
> +	/* When setting CPU access coordinates, update mempolicy */
> +	if (access == ACCESS_COORDINATE_CPU) {
> +		if (mempolicy_set_node_perf(nid, coord))
> +			pr_info("failed to set node%d mempolicy attrs\n", nid);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>   
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index ce9885e0178a..0fe96f3ab3ef 100644
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
> @@ -178,6 +179,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
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
> index 04f35659717a..e41dbb3e9185 100644
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
> @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
>   
>   static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>   
> +static uint64_t *node_bw_table;
> +
>   /*
> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
> - * system-default value should be used. A NULL iw_table also denotes that
> - * system-default values should be used. Until the system-default table
> - * is implemented, the system-default is always 1.
> - *
> + * iw_table is the interleave weight table.
> + * If bandwiddth data is available and the user is in auto mode, the table

[nit] bandwiddth -> bandwidth

> + * is populated with default values in [1,255].
>    * iw_table is RCU protected
>    */
>   static u8 __rcu *iw_table;
>   static DEFINE_MUTEX(iw_table_lock);
> +static const int weightiness = 32;
> +static bool weighted_interleave_auto = true;
>   
>   static u8 get_il_weight(int node)
>   {
> @@ -156,14 +159,113 @@ static u8 get_il_weight(int node)
>   
>   	rcu_read_lock();
>   	table = rcu_dereference(iw_table);
> -	/* if no iw_table, use system default */
>   	weight = table ? table[node] : 1;
> -	/* if value in iw_table is 0, use system default */
> -	weight = weight ? weight : 1;
>   	rcu_read_unlock();
>   	return weight;
>   }
>   
> +/*
> + * Convert bandwidth values into weighted interleave weights.
> + * Call with iw_table_lock.
> + */
> +static void reduce_interleave_weights(uint64_t *bw, u8 *new_iw)
> +{
> +	uint64_t ttl_bw = 0, ttl_iw = 0, scaling_factor = 1, iw_gcd = 1;

[nit] Just curiosity but what does ttl mean? If this means "total", then
what about using sum_bw or sum_iw?

It's also a nitpick, but this single line defines too many variables so
how about this?

	uint64_t sum_bw = 0, sum_iw = 0;
	uint64_t scaling_factor = 1, iw_gcd = 1;

> +	unsigned int i = 0;
> +
> +	/* Recalculate the bandwidth distribution given the new info */
> +	for (i = 0; i < nr_node_ids; i++)
> +		ttl_bw += bw[i];
> +
> +	/* If node is not set or has < 1% of total bw, use minimum value of 1 */
> +	for (i = 0; i < nr_node_ids; i++) {
> +		if (bw[i]) {
> +			scaling_factor = 100 * bw[i];
> +			new_iw[i] = max(scaling_factor / ttl_bw, 1);
> +		} else {
> +			new_iw[i] = 1;
> +		}
> +		ttl_iw += new_iw[i];
> +	}
> +
> +	/*
> +	 * Scale each node's share of the total bandwidth from percentages
> +	 * to whole numbers in the range [1, weightiness]
> +	 */
> +	for (i = 0; i < nr_node_ids; i++) {
> +		scaling_factor = weightiness * new_iw[i];
> +		new_iw[i] = max(scaling_factor / ttl_iw, 1);
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
> +		memcpy(new_bw, old_bw, nr_node_ids*sizeof(uint64_t));

[nit] nr_node_ids*sizeof(uint64_t) -> nr_node_ids * sizeof(uint64_t)

Thanks,
Honggyu

