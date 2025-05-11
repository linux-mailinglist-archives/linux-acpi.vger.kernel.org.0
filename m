Return-Path: <linux-acpi+bounces-13674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0ABAB2845
	for <lists+linux-acpi@lfdr.de>; Sun, 11 May 2025 14:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B4C7A84D3
	for <lists+linux-acpi@lfdr.de>; Sun, 11 May 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42333256C8A;
	Sun, 11 May 2025 12:56:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A7256C62;
	Sun, 11 May 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746968196; cv=none; b=Lu2YdI5pOHC8/km6kZkoDva4APhUHIY81/Fq4iBnBm7BzwxTF7Rtn3uxHUj+nyl4dBusYw+KQ0YrVGm3q9oHeVbjkVufJDfLpyFkKjdhcPtlY0wtC9A3E88W5iGkijGInU9vv81UH1rSiS+syKA+OueXEuChWCsZI8stxNc+Tkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746968196; c=relaxed/simple;
	bh=pwclJDUdZjI4+oI7YGLUqYQepdttd+QNHLwsyoQ/uNg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IhnMqQhG0qnceVBwdG4gtsiuMkNmuYzQESTjlmiD3VdhxLHREBpDh2mGdLgCXXlSnhvqgFG6oxmxncjroCn/ydLw6RY/lvqUiTiW50ue4o3md7r7DgFUL1+YsxY2J39W6puXz2wNmuuhKn/YrFnNTkwWdTZ/a7ux8t7XKLeto/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-f7-68209e753430
Message-ID: <2e030edd-b3e4-4b79-9e1d-1be0c6b0d0b5@sk.com>
Date: Sun, 11 May 2025 21:56:20 +0900
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kernel_team@skhynix.com, "Huang, Ying" <ying.huang@linux.alibaba.com>,
 gourry@gourry.net, yunjeong.mun@sk.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, lenb@kernel.org, dan.j.williams@intel.com,
 Jonathan.Cameron@huawei.com, dave.jiang@intel.com, horen.chuang@linux.dev,
 hannes@cmpxchg.org, osalvador@suse.de, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v8] mm/mempolicy: Weighted Interleave Auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250511025840.2410154-1-joshua.hahnjy@gmail.com>
Content-Language: ko
From: Honggyu Kim <honggyu.kim@sk.com>
In-Reply-To: <20250511025840.2410154-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsXC9ZZnkW7pPIUMg5nnZSzmrF/DZjF96gVG
	ixM3G9ksft49zm7RvHg9m8XqTb4Wt/vPsVqsWniNzeL41nnsFvsuAtXufPiWzWL5vn5Gi8u7
	5rBZ3Fvzn9XizLQii7lfpjJbrF6T4SDocfjNe2aPnbPusnt0t11m92g58pbVY/Gel0wem1Z1
	snls+jSJ3ePEjN8sHjsfWnosbJjK7LF/7hp2j3MXKzw2n672+LxJLoAvissmJTUnsyy1SN8u
	gStj5aQu5oKJfhWdj2YyNTD+tOti5OSQEDCRmLZwGTOMfWf7QjYQm1fAUmLdvK1gcRYBVYmW
	a89YIeKCEidnPmEBsUUF5CXu35rB3sXIxcEssJpZYtmZDYwgCWEBV4nb646B2SICYRJ3dk0C
	axYSsJNY9+cT2FBmARGJ2Z1tYDabgJrElZeTmEBsTgF7iRf/+lkgaswkurZ2MULY8hLb385h
	BlkmIXCKXWL17CdMEFdLShxccYNlAqPgLCQHzkKyYxaSWbOQzFrAyLKKUSgzryw3MTPHRC+j
	Mi+zQi85P3cTIzCGl9X+id7B+OlC8CFGAQ5GJR7eB9HyGUKsiWXFlbmHGCU4mJVEeKcyAIV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzGn0rTxESSE8sSc1OTS1ILYLJMnFwSjUwMq5JXv/A658Y
	z8fl9kdELTWrDxXa31loZDw5+A6bYKbQtoA2hXoZma2cKtavP2xP1p+5+uc33mMb5JdE31ly
	+eSWuXvvLimsO5QkxzzJdK6N1cfMicopLD+vvqhvit5R+b5mrnlwaqUZh9CnD4qvrGW/TDz5
	SDVrU5WD3Y7FjFtzX1ZE9XzbpMRSnJFoqMVcVJwIAEYcTdbdAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsXCNUNLT7d0nkKGwc6jPBZz1q9hs5g+9QKj
	xYmbjWwWP+8eZ7doXryezWL1Jl+L2/3nWC1WLbzGZnF86zx2i30XgWoPzz3JarHz4Vs2i+X7
	+hktLu+aw2Zxb81/Vosz04os5n6Zymyxek2Gxe9tK9gchD0Ov3nP7LFz1l12j+62y+weLUfe
	snos3vOSyWPTqk42j02fJrF7nJjxm8Vj50NLj4UNU5k99s9dw+5x7mKFx7fbHh6LX3xg8th8
	utrj8ya5AIEoLpuU1JzMstQifbsEroyVk7qYCyb6VXQ+msnUwPjTrouRk0NCwETizvaFbCA2
	r4ClxLp5W5lBbBYBVYmWa89YIeKCEidnPmEBsUUF5CXu35rB3sXIxcEssJpZYtmZDYwgCWEB
	V4nb646B2SICYRJ3dk0CaxYSsJNY9+cT2FBmARGJ2Z1tYDabgJrElZeTmEBsTgF7iRf/+lkg
	aswkurZ2MULY8hLb385hnsDINwvJHbOQjJqFpGUWkpYFjCyrGEUy88pyEzNzTPWKszMq8zIr
	9JLzczcxAmN0We2fiTsYv1x2P8QowMGoxMP7Ikk+Q4g1say4MvcQowQHs5II71QGoBBvSmJl
	VWpRfnxRaU5q8SFGaQ4WJXFer/DUBCGB9MSS1OzU1ILUIpgsEwenVANj6ZmrPJ+Emi4c2Cli
	vvXY1996Iac8w5odp59OcH6S92eT+99infgo5c17ciq5lWseJs/Y1C3XqLt12TsToboJe499
	lSy4a3KwsFTJIrit66rfHiE2j3av0k7mhyZ10sEr7k7m2eAzp7c7MF/a6m34uWsTTvTLHLrz
	gr+vzWJBjTW3s4buYRclluKMREMt5qLiRAD+Pq3PzQIAAA==
X-CFilter-Loop: Reflected

Hi Joshua,

Thanks for the update this patch and it looks good to me.

I've applied your v8 patch with your fixup here together, then tested it in my
server, which has 8ch of DRAM with 4ch of CXL memory in each socket.

I can confirm that it shows decent ratio with this auto weight configuration as
follows.

   $ ls /sys/kernel/mm/mempolicy/weighted_interleave/
   auto  node0  node1  node2  node3

   $ cat /sys/kernel/mm/mempolicy/weighted_interleave/*
   true
   3
   3
   2
   2

Hi Andrew,

I'm not sure if Joshua is better to post v9, but if you want to fold and update,
then could you please add my tags as follows when you fold this change?

   Reviewed-by: Honggyu Kim <honggyu.kim@sk.com>
   Tested-by: Honggyu Kim <honggyu.kim@sk.com>

I added the same tags in v7 but not included in v8 somehow.
https://lore.kernel.org/linux-mm/5fdd7db9-96fb-49ea-9803-977158cb0132@sk.com

Thanks,
Honggyu

On 5/11/2025 11:58 AM, Joshua Hahn wrote:
> Hello Andrew,
> 
> I was hoping to fold this fixlet in with the patch this belongs to. It includes
> some wordsmithing changes, some code simplification/cleanups, and makes sure
> that the code behavior matches that of the ABI I described. I've kept the
> original message below as well, where Ying suggested the changes present in
> this fixlet.
> 
> Please let me know if this fixlet is too big, and you would rather prefer a
> new version instead. Thank you as always for your patience and support!
> Joshua
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index ec13382c606f..649c0e9b895c 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -24,7 +24,7 @@ Description:	Weight configuration interface for nodeN
>   		empty string, ...) will return -EINVAL.
> 
>   		Changing the weight to a valid value will automatically
> -		update the system to manual mode as well.
> +		switch the system to manual mode as well.
> 
>   What:		/sys/kernel/mm/mempolicy/weighted_interleave/auto
>   Date:		May 2025
> diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
> index 3e8da8ba1146..0fe96f3ab3ef 100644
> --- a/include/linux/mempolicy.h
> +++ b/include/linux/mempolicy.h
> @@ -57,15 +57,6 @@ struct mempolicy {
>   	} w;
>   };
> 
> -/*
> - * A null weighted_interleave_state is interpted as having .mode = "auto",
> - * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> - */
> -struct weighted_interleave_state {
> -	bool mode_auto;
> -	u8 iw_table[];
> -};
> -
>   /*
>    * Support for managing mempolicy data objects (clone, copy, destroy)
>    * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f542691b7123..0624d735a2e7 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -148,6 +148,14 @@ static struct mempolicy preferred_node_policy[MAX_NUMNODES];
>    */
>   static const int weightiness = 32;
> 
> +/*
> + * A null weighted_interleave_state is interpreted as having .mode="auto",
> + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
> + */
> +struct weighted_interleave_state {
> +	bool mode_auto;
> +	u8 iw_table[];
> +};
>   static struct weighted_interleave_state __rcu *wi_state;
>   static unsigned int *node_bw_table;
> 
> @@ -3561,9 +3569,8 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   	int i;
> 
>   	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
> -	if (count == 0 || sysfs_streq(buf, ""))
> -		weight = 0;
> -	else if (kstrtou8(buf, 0, &weight) || weight == 0)
> +	if (count == 0 || sysfs_streq(buf, "") ||
> +	    kstrtou8(buf, 0, &weight) || weight == 0)
>   		return -EINVAL;
> 
>   	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
> @@ -3630,9 +3637,15 @@ static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
>   	if (!input) {
>   		old_wi_state = rcu_dereference_protected(wi_state,
>   					lockdep_is_held(&wi_state_lock));
> -		if (old_wi_state)
> -			memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> -					nr_node_ids * sizeof(u8));
> +		if (!old_wi_state)
> +			goto update_wi_state;
> +		if (input == old_wi_state->mode_auto) {
> +			mutex_unlock(&wi_state_lock);
> +			return count;
> +		}
> +
> +		memcpy(new_wi_state->iw_table, old_wi_state->iw_table,
> +					       nr_node_ids * sizeof(u8));
>   		goto update_wi_state;
>   	}
> 
> @@ -3707,8 +3720,12 @@ static void wi_state_free(void)
>   	kfree(&wi_group->wi_kobj);
>   }
> 
> +static struct kobj_attribute wi_auto_attr =
> +	__ATTR(auto, 0664, weighted_interleave_auto_show,
> +			   weighted_interleave_auto_store);
> +
>   static void wi_cleanup(void) {
> -	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
> +	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
>   	sysfs_wi_node_delete_all();
>   	wi_state_free();
>   }
> @@ -3798,10 +3815,6 @@ static int wi_node_notifier(struct notifier_block *nb,
>   	return NOTIFY_OK;
>   }
> 
> -static struct kobj_attribute wi_auto_attr =
> -	__ATTR(auto, 0664, weighted_interleave_auto_show,
> -			   weighted_interleave_auto_store);
> -
>   static int __init add_weighted_interleave_group(struct kobject *mempolicy_kobj)
>   {
>   	int nid, err;
> 
> 
> On Sat, 10 May 2025 11:51:50 -0700 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
> 
>> On Sat, 10 May 2025 13:25:32 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>>
>> Hi Ying,
>> Thank you for reviewing my patch, as always!
>>
>>> Hi, Joshua,
>>>
>>> Thank you for updated version!  And sorry for late reply.
>>>
>>> Joshua Hahn <joshua.hahnjy@gmail.com> writes:
>>
>> [...snip...]
>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> index 0b7972de04e9..ec13382c606f 100644
>>>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
>>>> @@ -20,6 +20,35 @@ Description:	Weight configuration interface for nodeN
>>>>   		Minimum weight: 1
>>>>   		Maximum weight: 255
>>>>   
>>>> -		Writing an empty string or `0` will reset the weight to the
>>>> -		system default. The system default may be set by the kernel
>>>> -		or drivers at boot or during hotplug events.
>>>> +		Writing invalid values (i.e. any values not in [1,255],
>>>> +		empty string, ...) will return -EINVAL.
>>>> +
>>>> +		Changing the weight to a valid value will automatically
>>>> +		update the system to manual mode as well.
>>>
>>> s/update/switch/ ?
>>>
>>> But my English is poor, please keep your version if you think that it's
>>> better.
>>
>> I have no particular preference here, whatever will make it easiest for the
>> users to understand what is happening. I'll take your suggestion!
>>
>> [...snip...]
>>
>>>> +/*
>>>> + * A null weighted_interleave_state is interpted as having .mode = "auto",
>>>> + * and .iw_table is interpreted as an array of 1s with length nr_node_ids.
>>>> + */
>>>
>>> Better to move the comments to above "wi_state" definition?
>>>
>>>> +struct weighted_interleave_state {
>>>> +	bool mode_auto;
>>>> +	u8 iw_table[];
>>>> +};
>>>> +
>>>
>>> Why do you put the type definition in mempolicy.h instead of
>>> mempolicy.c?  I don't find other users except mempolicy.c.
>>
>> Good point, I'll move the definition to mempolicy.c and move the comment
>> to the wi_state definition as well.
>>
>> [...snip...]
>>
>>>> @@ -3450,31 +3555,104 @@ static ssize_t node_show(struct kobject *kobj, struct kobj_attribute *attr,
>>>>   static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>>>>   			  const char *buf, size_t count)
>>>>   {
>>>> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>>>>   	struct iw_node_attr *node_attr;
>>>> -	u8 *new;
>>>> -	u8 *old;
>>>>   	u8 weight = 0;
>>>> +	int i;
>>>>   
>>>>   	node_attr = container_of(attr, struct iw_node_attr, kobj_attr);
>>>>   	if (count == 0 || sysfs_streq(buf, ""))
>>>>   		weight = 0;
>>>
>>> According to revised ABI, we should return -EINVAL here?
>>
>> Great catch, I completely ignored the ABI description that I wrote...
>> I'll go ahead and just return -EINVAL here!
>>
>> [...snip...]
>>
>>>> +static ssize_t weighted_interleave_auto_store(struct kobject *kobj,
>>>> +		struct kobj_attribute *attr, const char *buf, size_t count)
>>>> +{
>>>> +	struct weighted_interleave_state *new_wi_state, *old_wi_state = NULL;
>>>> +	unsigned int *bw;
>>>> +	bool input;
>>>> +	int i;
>>>> +
>>>> +	if (kstrtobool(buf, &input))
>>>> +		return -EINVAL;
>>>> +
>>>> +	new_wi_state = kzalloc(struct_size(new_wi_state, iw_table, nr_node_ids),
>>>> +			       GFP_KERNEL);
>>>> +	if (!new_wi_state)
>>>> +		return -ENOMEM;
>>>> +	for (i = 0; i < nr_node_ids; i++)
>>>> +		new_wi_state->iw_table[i] = 1;
>>>> +
>>>> +	mutex_lock(&wi_state_lock);
>>>> +	if (!input) {
>>>
>>> If input == old_wi_state->mode_auto, we can return directly?
>>
>> Yes, that makes sense to me.
>>
>>>>   static void wi_cleanup(void) {
>>>> +	sysfs_remove_file(&wi_group->wi_kobj, &wi_group->auto_kobj_attr.attr);
>>>
>>> Why not just
>>>
>>> 	sysfs_remove_file(&wi_group->wi_kobj, &wi_auto_attr.attr);
>>>
>>> ?
>>
>> Also makes sense!!
>>
>>> ---
>>> Best Regards,
>>> Huang, Ying
>>
>> Thank you for your great feedback Ying, I'll make changes based on
>> your suggestions and shortly send up a v9. I hope you have a great day!
>> Joshua
>>


