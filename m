Return-Path: <linux-acpi+bounces-10773-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B392A17CFD
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 12:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1C161048
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8151F1319;
	Tue, 21 Jan 2025 11:27:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.skhynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF01F0E44;
	Tue, 21 Jan 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737458847; cv=none; b=k37uuW1iE3yq1t/ttM8UQMeVl6JyJ+6pMWPDFlKtt27uloV9UF9bv/GAcDbkOv6SyBEZzQBRuNNRxzlBHdSSKPZAPHqNhfMmCV7elCTCSXEemvpmydro1/2Zne7GrslPflJ2tf03Cfo2ziSz1wT5rse80t2N+0YvW/v9o6WMR8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737458847; c=relaxed/simple;
	bh=/8ASWOfnYENHRoOpvya9t9/ZAhrYywuNi8IpfsKdFwQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C3fDSQYtATiye2Y0teC/xVShfEC/g/DBE3GF4ge1zPs52gtujJc1ykhT2Us6T7ElzAhxla3U8ngAV+WiqknkMyYGI/QOIMH7h61vDPW6iXAZRqO1ZkiXR16tiJx0V3VI1B//nu+y0Va7/+jERAT/Q+BoKwNi8B1X+ANki7oNtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-3c9ff7000001d7ae-db-678f84951cb2
Message-ID: <147aba6e-7e23-4ad1-9bd2-1ceac0f3d55b@sk.com>
Date: Tue, 21 Jan 2025 20:27:17 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, gourry@gourry.net, hyeonggon.yoo@sk.com,
 rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
 akpm@linux-foundation.org, rakie.kim@sk.com, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v3] Weighted interleave auto-tuning
Content-Language: ko
To: "Huang, Ying" <ying.huang@linux.alibaba.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250115185854.1991771-1-joshua.hahnjy@gmail.com>
 <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <87ikq8h0w4.fsf@DESKTOP-5N7EMDA>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRmVeSWpSXmKPExsXC9ZZnke7Ulv50g2P7tS3mrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4Wt/vPsVqsWniNzeL41nnsFvsuAtXufPiWzWL5vn5Gi8u7
	5rBZ3Fvzn9Vi7pepzBar12Q4CHgcfvOe2WPnrLvsHt1tl9k9Wo68ZfVYvOclk8emVZ1sHps+
	TWL3ODHjN4vHzoeWHgsbpjJ77J+7ht3j3MUKj8+b5AJ4o7hsUlJzMstSi/TtErgy2hb+ZixY
	lVBx+nsHSwPjJ58uRk4OCQETibY1L9lg7P37HjCB2LwClhJXFp1gB7FZBFQl+vuPQcUFJU7O
	fMICYosKyEvcvzUDqIaLg1lgBrPE24Y9YEXCAuYSE2dsZQWxmQVEJGZ3tjGD2CICkRJnty1m
	BLGFBBIlnn38BFbDJqAmceXlJLBeTgFdie/btjNB9JpJdG3tYoSw5SW2v53DDLJMQuAQu8SG
	Z6+ZIK6WlDi44gbLBEbBWUgOnIVk9ywks2YhmbWAkWUVo1BmXlluYmaOiV5GZV5mhV5yfu4m
	RmDMLqv9E72D8dOF4EOMAhyMSjy8B6z60oVYE8uKK3MPMUpwMCuJ8Ip+6EkX4k1JrKxKLcqP
	LyrNSS0+xCjNwaIkzmv0rTxFSCA9sSQ1OzW1ILUIJsvEwSnVwMhuY7vWS5ep4CavcBLPk1VW
	O5sf761elOu+c6Nh/xUl44j5F4xLZ8vb/5Xlncrn90dpZt3KDtXnCg/lpGdtnVVx9vgqk84t
	U3Y3HZ+QbyJ/wPziVfbd398c0JRLdZ4h1/NVPzE00Z1NJv5yn8iWW4/Mr2b94OS6/f523cQ6
	W0VxV50A+w396UosxRmJhlrMRcWJAEx9oBTVAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsXCNUNLT3dqS3+6wZTVkhZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L2/3nWC1mrk2yWLXwGpvF8a3z2C32XQSqPzz3JKvFzodv
	2SyW7+tntLi8aw6bxb01/1kt5n6Zymxx6NpzVovVazIchD0Ov3nP7LFz1l12j+62y+weLUfe
	snos3vOSyWPTqk42j02fJrF7nJjxm8Vj50NLj4UNU5k99s9dw+5x7mKFx7fbHh6LX3xg8vi8
	SS6AP4rLJiU1J7MstUjfLoEro23hb8aCVQkVp793sDQwfvLpYuTkkBAwkdi/7wETiM0rYClx
	ZdEJdhCbRUBVor//GFRcUOLkzCcsILaogLzE/VszgGq4OJgFZjBLvG3YA1YkLGAuMXHGVlYQ
	m1lARGJ2ZxsziC0iEClxdttiRhBbSCBR4tnHT2A1bAJqEldeTgLr5RTQlfi+bTsTRK+ZRNfW
	LkYIW15i+9s5zBMY+WYhuWMWkhWzkLTMQtKygJFlFaNIZl5ZbmJmjqlecXZGZV5mhV5yfu4m
	RmBsLqv9M3EH45fL7ocYBTgYlXh4D1j1pQuxJpYVV+YeYpTgYFYS4RX90JMuxJuSWFmVWpQf
	X1Sak1p8iFGag0VJnNcrPDVBSCA9sSQ1OzW1ILUIJsvEwSnVwNj03s3V8O3jU/bhiZ4Gwhf5
	Wve7VTOU1BXk8fkITVoye7vPvMNXN+d/CN/Zvchanj+s9m/il5iCm8FZ9+UETTS+Ma8tVeQ0
	k58u8em08S1rn3qFN3f4wguTdquI/mWbVfV78oLbRWxZ29JcFk5+f95F5nDj5v1FjW2/tv4o
	MLiisryy6rLgPCWW4oxEQy3mouJEALp9PjjJAgAA
X-CFilter-Loop: Reflected

Hi Ying and Joshua,

On 1/21/2025 8:17 PM, Huang, Ying wrote:
> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
> 
>> On machines with multiple memory nodes, interleaving page allocations
>> across nodes allows for better utilization of each node's bandwidth.
>> Previous work by Gregory Price [1] introduced weighted interleave, which
>> allowed for pages to be allocated across NUMA nodes according to
>> user-set ratios.
>>
>> Ideally, these weights should be proportional to their bandwidth, so
>> that under bandwidth pressure, each node uses its maximal efficient
>> bandwidth and prevents latency from increasing exponentially.
>>
>> At the same time, we want these weights to be as small as possible.
>> Having ratios that involve large co-prime numbers like 7639:1345:7 leads
>> to awkward and inefficient allocations, since the node with weight 7
>> will remain mostly unused (and despite being proportional to bandwidth,
>> will not aid in relieving the bandwidth pressure in the other two nodes).
>>
>> This patch introduces an auto-configuration mode for the interleave
>> weights that aims to balance the two goals of setting node weights to be
>> proportional to their bandwidths and keeping the weight values low.
>> In order to perform the weight re-scaling, we use an internal
>> "weightiness" value (fixed to 32) that defines interleave aggression.
>>
>> In this auto configuration mode, node weights are dynamically updated
>> every time there is a hotplug event that introduces new bandwidth.
>>
>> Users can also enter manual mode by writing "manual" to the new "mode"
>> sysfs interface. When a user enters manual mode, the system stops
>> dynamically updating any of the node weights, even during hotplug events
>> that can shift the optimal weight distribution. The system also enters
>> manual mode any time a user sets a node's weight by hand, using the
>> nodeN interface introduced in [1]. On the other hand, auto mode is
>> only entered by explicitly writing "auto" to the mode interface.
>>
>> There is one functional change that this patch makes to the existing
>> weighted_interleave ABI: previously, writing 0 directly to a nodeN
>> interface was said to reset the weight to the system default. Before
>> this patch, the default for all weights were 1, which meant that writing
>> 0 and 1 were functionally equivalent.
>>
>> This patch introduces "real" defaults, but we have decided to move away
>> from letting users use 0 as a "set to default" interface. Rather, users
>> who want to use system defaults should use "auto" mode. This patch seems
>> to be the appropriate place to make this change, since we would like to
>> remove this usage before users begin to rely on the feature in
>> userspace. Moreover, users will not be losing any functionality; they
>> can still write 1 into a node if they want a weight of 1. Thus, we
>> deprecate the "write zero to reset" feature in favor of returning an
>> error, the same way we would return an error when the user writes any
>> other invalid weight to the interface.
>>
>> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
>>
>> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
>> Co-developed-by: Gregory Price <gourry@gourry.net>
>> Signed-off-by: Gregory Price <gourry@gourry.net>
>> ---
>> Changelog
>> v3:
>> - Weightiness (max_node_weight) is now fixed to 32.
>> - Instead, the sysfs interface now exposes a "mode" parameter, which
>>    can either be "auto" or "manual".
>>    - Thank you Hyeonggon and Honggyu for the feedback.
>> - Documentation updated to reflect new sysfs interface, explicitly
>>    specifies that 0 is invalid.
>>    - Thank you Gregory and Ying for the discussion on how best to
>>      handle the 0 case.
>> - Re-worked nodeN sysfs store to handle auto --> manual shifts
>> - mempolicy_set_node_perf internally handles the auto / manual
>>    caes differently now. bw is always updated, iw updates depend on
>>    what mode the user is in.
>> - Wordsmithing comments for clarity.
>> - Removed RFC tag.
>>
>> v2:
>> - Name of the interface is changed: "max_node_weight" --> "weightiness"
>> - Default interleave weight table no longer exists. Rather, the
>>    interleave weight table is initialized with the defaults, if bandwidth
>>    information is available.
>>    - In addition, all sections that handle iw_table have been changed
>>      to reference iw_table if it exists, otherwise defaulting to 1.
>> - All instances of unsigned long are converted to uint64_t to guarantee
>>    support for both 32-bit and 64-bit machines
>> - sysfs initialization cleanup
>> - Documentation has been rewritten to explicitly outline expected
>>    behavior and expand on the interpretation of "weightiness".
>> - kzalloc replaced with kcalloc for readability
>> - Thank you Gregory and Hyeonggon for your review & feedback!
>>
>>   ...fs-kernel-mm-mempolicy-weighted-interleave |  30 ++-
>>   drivers/acpi/numa/hmat.c                      |   1 +
>>   drivers/base/node.c                           |   7 +
>>   include/linux/mempolicy.h                     |   4 +
>>   mm/mempolicy.c                                | 212 ++++++++++++++++--
>>   5 files changed, 227 insertions(+), 27 deletions(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>> index 0b7972de04e9..d30dc29c53ff 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>> @@ -20,6 +20,30 @@ Description:	Weight configuration interface for nodeN
>>   		Minimum weight: 1
>>   		Maximum weight: 255
>>   
>> -		Writing an empty string or `0` will reset the weight to the
>> -		system default. The system default may be set by the kernel
>> -		or drivers at boot or during hotplug events.
>> +		Writing invalid values (i.e. any values not in [1,255],
>> +		empty string, ...) will return -EINVAL.
>> +
>> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/mode
>> +Date:		January 2025
>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:	Auto-weighting configuration interface
>> +
>> +		Configuration modes for weighted interleave. Can take one of
>> +		two options: "manual" and "auto". Default is "auto".
>> +
>> +		In auto mode, all node weights are re-calculated and overwritten
>> +		(visible via the nodeN interfaces) whenever new bandwidth data
>> +		is made available either during boot or hotplug events.
>> +
>> +		In manual mode, node weights can only be updated by the user.
>> +		If a node is hotplugged while the user is in manual mode,
>> +		the node will have a default weight of 1.
>> +
>> +		Modes can be changed by writing either "auto" or "manual" to the
>> +		interface. All other strings will be ignored, and -EINVAL will
>> +		be returned. If "auto" is written to the interface but the
>> +		recalculation / updates fail at any point (-ENOMEM or -ENODEV)
>> +		then the mode will remain in manual mode.
>> +
>> +		Writing a new weight to a node directly via the nodeN interface
>> +		will also automatically update the system to manual mode.
> 
> IMHO, this interface is somewhat hard to be used.  Users need to know
> which value is legal.  So, this will become something like,
> 
> $ cat mode
> auto [manual]
> $ echo auto > mode
> $ cat mode
> [auto] manual

This is exactly I internally proposed to Hyeonggon, but couldn't share
the idea directly here.

> 
> Unless it's possible we will add more modes in the future, this is kind
> of overkill for me.  How about something simpler as below?
> 
> $ cat auto
> true
> $ echo 0 > auto
> $ cat auto
> false

That also makes sense, but I feel like somewhat vague what "auto" false
means. The "auto" might be better to be "use_hmat" instead and this
makes "use_hmat" false more meaningful. "use_hmat_weight" or
"use_hmat_info" might be another candidates.

Thanks,
Honggyu

> 
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 80a3481c0470..cc94cba112dd 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -20,6 +20,7 @@
>>   #include <linux/list_sort.h>
>>   #include <linux/memregion.h>
>>   #include <linux/memory.h>
>> +#include <linux/mempolicy.h>
>>   #include <linux/mutex.h>
>>   #include <linux/node.h>
>>   #include <linux/sysfs.h>
>> diff --git a/drivers/base/node.c b/drivers/base/node.c
>> index 0ea653fa3433..16e7a5a8ebe7 100644
>> --- a/drivers/base/node.c
>> +++ b/drivers/base/node.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/init.h>
>>   #include <linux/mm.h>
>>   #include <linux/memory.h>
>> +#include <linux/mempolicy.h>
>>   #include <linux/vmstat.h>
>>   #include <linux/notifier.h>
>>   #include <linux/node.h>
>> @@ -214,6 +215,12 @@ void node_set_perf_attrs(unsigned int nid, struct access_coordinate *coord,
>>   			break;
>>   		}
>>   	}
>> +
>> +	/* When setting CPU access coordinates, update mempolicy */
>> +	if (access == ACCESS_COORDINATE_CPU) {
>> +		if (mempolicy_set_node_perf(nid, coord))
>> +			pr_info("failed to set node%d mempolicy attrs\n", nid);
>> +	}
>>   }
>>   EXPORT_SYMBOL_GPL(node_set_perf_attrs);
>>   
>> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
>> index ce9885e0178a..0fe96f3ab3ef 100644
>> --- a/include/linux/mempolicy.h
>> +++ b/include/linux/mempolicy.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/slab.h>
>>   #include <linux/rbtree.h>
>>   #include <linux/spinlock.h>
>> +#include <linux/node.h>
>>   #include <linux/nodemask.h>
>>   #include <linux/pagemap.h>
>>   #include <uapi/linux/mempolicy.h>
>> @@ -178,6 +179,9 @@ static inline bool mpol_is_preferred_many(struct mempolicy *pol)
>>   
>>   extern bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone);
>>   
>> +extern int mempolicy_set_node_perf(unsigned int node,
>> +				   struct access_coordinate *coords);
>> +
>>   #else
>>   
>>   struct mempolicy {};
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 04f35659717a..8777bd6229bc 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -109,6 +109,7 @@
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/printk.h>
>>   #include <linux/swapops.h>
>> +#include <linux/gcd.h>
>>   
>>   #include <asm/tlbflush.h>
>>   #include <asm/tlb.h>
>> @@ -138,16 +139,18 @@ static struct mempolicy default_policy = {
>>   
>>   static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>>   
>> +static uint64_t *node_bw_table;
>> +
>>   /*
>> - * iw_table is the sysfs-set interleave weight table, a value of 0 denotes
>> - * system-default value should be used. A NULL iw_table also denotes that
>> - * system-default values should be used. Until the system-default table
>> - * is implemented, the system-default is always 1.
>> - *
>> + * iw_table is the interleave weight table.
>> + * If bandwiddth data is available and the user is in auto mode, the table
>> + * is populated with default values in [1,255].
>>    * iw_table is RCU protected
>>    */
>>   static u8 __rcu *iw_table;
>>   static DEFINE_MUTEX(iw_table_lock);
>> +static const int weightiness = 32;
>> +static bool weighted_interleave_auto = true;
> 
> I still prefer to use 2 iw_table, one is for default, the other is for
> manual.  The default one will be used if the manual one is NULL.  Both
> are protected by RCU.  The default one can be updated upon hotplug
> blindly.  This makes the whole model easier to be understood IMHO.
> 
> What do you think about that.
> 
>>   static u8 get_il_weight(int node)
>>   {
>> @@ -156,14 +159,113 @@ static u8 get_il_weight(int node)
>>   
>>   	rcu_read_lock();
>>   	table = rcu_dereference(iw_table);
>> -	/* if no iw_table, use system default */
>>   	weight = table ? table[node] : 1;
>> -	/* if value in iw_table is 0, use system default */
>> -	weight = weight ? weight : 1;
>>   	rcu_read_unlock();
>>   	return weight;
>>   }
> 
> [snip]
> 
> ---
> Best Regards,
> Huang, Ying


