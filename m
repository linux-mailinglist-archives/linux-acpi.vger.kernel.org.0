Return-Path: <linux-acpi+bounces-10207-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFCA9F8DEC
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 09:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30ADE163390
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Dec 2024 08:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08C431A4E98;
	Fri, 20 Dec 2024 08:25:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from invmail3.skhynix.com (exvmail3.hynix.com [166.125.252.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613BB249EB;
	Fri, 20 Dec 2024 08:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734683143; cv=none; b=ZFMbxZGMh8VIswTcmBJvRv0Oi+SWfg2bbx4NrXyVdsr2OMXgc4/XsO3CRiVtCID3mGPB8+U+AlVOdUziAlHK+2+WfOIvXkVik8swBU8DE8PKhLeOTFIjNTyj+VHaovmxLyFkbfBmBoIuL1YCjKQr2sFjO328TNzSaRV26wYNuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734683143; c=relaxed/simple;
	bh=OMEeCmwJZytRwBXuuXm2R+f5Db/4WPMynfZYPampMqw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HlwXdT9KhJzQI5lpfZSbQ7Up5nuJx2YYE3RTYYXBTxcU37CgJtyCxVwMiRlGP3r/xwdcazK7SyAaM/sTJQtjH2Yws7vV28qZKuDBYoVM37/Oq8BtSeV1lVQ6D4DxoppFYwWSOvBK0+kam58nY/OtUyFLE/qtNYTTubf22m4ZwD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc59-7a9ff700000194b3-5f-676529f89a80
Message-ID: <3682b9cf-213c-497d-ab81-f70e1a785716@sk.com>
Date: Fri, 20 Dec 2024 17:25:28 +0900
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
 Honggyu Kim <honggyu.kim@sk.com>,
 "ying.huang@linux.alibaba.com" <ying.huang@linux.alibaba.com>,
 Rakie Kim <rakie.kim@sk.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "horen.chuang@linux.dev" <horen.chuang@linux.dev>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [External Mail] [RFC PATCH v2] Weighted interleave auto-tuning
To: Joshua Hahn <joshua.hahnjy@gmail.com>,
 "gourry@gourry.net" <gourry@gourry.net>
References: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
Content-Language: en-US
From: Hyeonggon Yoo <hyeonggon.yoo@sk.com>
In-Reply-To: <20241219191845.3506370-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsXC9ZZnoe5PzdR0g6crZC0m9hhYzFm/hs1i
	+tQLjBYnbjayWfy8e5zdonnxejaL1Zt8LW73n2O1WLXwGpvF8a3z2C32XQSq3fnwLZvF8n39
	jBaXd81hs7i35j+rxdwvU5ktVq/JcBD0OPzmPbPHzll32T262y6ze7QcecvqsXjPSyaPTas6
	2Tw2fZrE7nFixm8Wj50PLT0WNkxl9tg/dw27x7mLFR6fN8kF8EZx2aSk5mSWpRbp2yVwZZy/
	PpWxoMGz4tCfBawNjBOsuhg5OCQETCQ+XwnsYuQEM++tWscGYvMKWEp8u7CLGcRmEVCV+L5+
	NlRcUOLkzCcsILaogLzE/Vsz2EFsZoFnbBKbrwiB2MIC3hLf/t4HqxcRCJE4s3seE4gtJGAn
	8arlJytEvbjErSfzmUBOYBPQktjRmQoS5hSwl5h9/DYLRImZRNfWLkYIW15i+9s5zBBnnmKX
	+PLBG8KWlDi44gbLBEbBWUium4Vkwywko2YhGbWAkWUVo0hmXlluYmaOsV5xdkZlXmaFXnJ+
	7iZGYNwuq/0TuYPx24XgQ4wCHIxKPLwHuFLShVgTy4orcw8xSnAwK4nw8silpgvxpiRWVqUW
	5ccXleakFh9ilOZgURLnNfpWniIkkJ5YkpqdmlqQWgSTZeLglGpgTHZ5yz5TUKs0/6hJX+Yx
	T/dyvX0fM9tYj3mohogasbKVH7WUmbU7o7etTTXn14zbKRyZupseVXnH8E+w9Z/ge2G/xUqn
	DTqCHGVXj62rXXdofV6VUaDf+4sPAy8+FMsM3AR01w1GhdVGh1n1zZMlH8z9OynO2+H3YfFZ
	We9ZgzgtXopIn1FiKc5INNRiLipOBAAVDRQI1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsXCNUOnRPeHZmq6wafdChYTewws5qxfw2Yx
	feoFRosTNxvZLH7ePc5u0bx4PZvF6k2+Fp+fvWa2uN1/jtVi1cJrbBbHt85jt9h3Eajh8NyT
	rBY7H75ls1i+r5/R4vKuOWwW99b8Z7WY+2Uqs8Wha89ZLVavyXAQ8Tj85j2zx85Zd9k9utsu
	s3u0HHnL6rF4z0smj02rOtk8Nn2axO5xYsZvFo+dDy09FjZMZfbYP3cNu8e5ixUe3257eCx+
	8YHJ4/MmuQD+KC6blNSczLLUIn27BK6M89enMhY0eFYc+rOAtYFxglUXIyeHhICJxL1V69hA
	bF4BS4lvF3Yxg9gsAqoS39fPhooLSpyc+YQFxBYVkJe4f2sGO4jNLPCMTWLzFSEQW1jAW+Lb
	3/tg9SICIRJnds9jArGFBOwkXrX8ZIWoF5e49WQ+UJyDg01AS2JHZypImFPAXmL28dssECVm
	El1buxghbHmJ7W/nME9g5JuF5IpZSCbNQtIyC0nLAkaWVYwimXlluYmZOWZ6xdkZlXmZFXrJ
	+bmbGIERuqz2z6QdjN8uux9iFOBgVOLhPcCVki7EmlhWXJl7iFGCg1lJhJdHLjVdiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOK9XeGqCkEB6YklqdmpqQWoRTJaJg1OqgVHWLyX8TYS+2T4GsXMX
	WNcnm2c3rjuwJGR5Qebayyvfzsqv013aktjJumMeW4DrqoqyjJd3uPbscdQyPaWcfT5kWmLH
	0d0Rnx3+bly5Rz/55a2du7els4uvmxH9NmtHh1RCyXJXxkdOt9ax2V/2ZtZPXp+UdLugRO31
	RL1jGvY+X1+8u1jnEqbEUpyRaKjFXFScCADy3WwpzAIAAA==
X-CFilter-Loop: Reflected



On 2024-12-20 4:18 AM, Joshua Hahn wrote:
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
> This balance is controlled by a value "weightiness", which defines the
> interleaving aggression. Higher values lead to less interleaving
> (255:1), while lower values lead to more interleaving (1:1).
> 
> Large weightiness values generally lead to increased weight-bandwidth
> proportionality, but can lead to underutilized nodes (think worst-case
> scenario, which is 1:max_node_weight). Lower weightiness reduces the
> effects of underutilized nodes, but may lead to improperly loaded
> distributions.

s/max_node_weight/weightiness/

> This knob is exposed as a sysfs interface with a default value of 32.
> Weights are re-calculated once at boottime and then every time the knob
> is changed by the user, or when the ACPI table is updated.
> 
> [1] https://lore.kernel.org/linux-mm/20240202170238.90004-1-gregory.price@memverge.com/
> 
> Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Co-Developed-by: Gregory Price <gourry@gourry.net>
> 
> ---
> Changelog
> 
> v2:
> - Name of the interface is changed from v1: "max_node_weight" --> "weightiness"
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
>   ...fs-kernel-mm-mempolicy-weighted-interleave |  36 ++++
>   drivers/acpi/numa/hmat.c                      |   1 +
>   drivers/base/node.c                           |   7 +
>   include/linux/mempolicy.h                     |   4 +
>   mm/mempolicy.c                                | 183 +++++++++++++++---
>   5 files changed, 209 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> index 0b7972de04e9..edb2c1f4753f 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-mempolicy-weighted-interleave
> @@ -23,3 +23,39 @@ Description:	Weight configuration interface for nodeN
>   		Writing an empty string or `0` will reset the weight to the
>   		system default. The system default may be set by the kernel
>   		or drivers at boot or during hotplug events.
> +
> +What:		/sys/kernel/mm/mempolicy/weighted_interleave/weightiness
> +Date:		December 2024
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Weight limiting / scaling interface
> +
> +		"Weightiness": a measure of interleave aggression between
> +		memory nodes. Higher values lead to less interleaving (255:1),
> +		while lower values lead to more interleaving (1:1).

It might be better to explain what low and high values of
weightness imply, like the way how you described
in the changelog?

> +		When this value is updated, all node weights are re-calculated
> +		to reflect the new weightiness. These re-calculated values
> +		overwrite all existing node weights, including those manually
> +		set by writing to the nodeN files.
> +
> +		Node weight re-calculation is performed by scaling down
> +		bandwidth values reported in the ACPI HMAT to the range
> +		[1, weightiness]. Note that re-calculation uses only the
> +		weightiness parameter and bandwidth values, and ignores all
> +		current node weights.
> +
> +		Minimum weight: 1
> +		Default value: 32
> +		Maximum weight: 255
> +
> +		Writing an empty string will set the value to be the default
> +		(32). Writing a value outside the valid range  will return
> +		EINVAL and will not re-trigger a weight scaling.
> +
> +		If there is no bandwidth data in the ACPI HMAT, then this file
> +		will return ENODEV on an attempted write and perform no updates.
> +		Furthermore, if there is no bandwidth information available,
> +		all nodes' weights will default to 1.
> +
> +		Setting max_node_weight to 1 is equivalent to unweighted
> +		interleave.

s/max_node_weight/weightiness/

> @@ -3397,6 +3471,54 @@ static ssize_t node_store(struct kobject *kobj, struct kobj_attribute *attr,
>   
>   static struct iw_node_attr **node_attrs;
>   
> +static ssize_t weightiness_show(struct kobject *kobj,
> +		struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%d\n", weightiness);
> +}
> +
> +static ssize_t weightiness_store(struct kobject *kobj,
> +		struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	uint64_t *bw;
> +	u8 *old_iw, *new_iw;
> +	u8 new_weightiness;
> +
> +	if (count == 0 || sysfs_streq(buf, ""))
> +		new_weightiness = 32;
> +	else if (kstrtou8(buf, 0, &new_weightiness) || new_weightiness == 0)
> +		return -EINVAL;
> +
> +	new_iw = kzalloc(nr_node_ids, GFP_KERNEL);
> +	if (!new_iw)
> +		return -ENOMEM;

Could you please use kcalloc here similar to mempolicy_set_node_perf()?
Otherwise the patch looks fine to me. (will add a review and test on the
next revision)

By the way, this might be out of scope, but let me ask for my own
learning.

We have a server with 2 sockets, each attached with local DRAM and CXL 
memory (and thus 4 NUMA nodes). When accessing remote socket's memory
(either CXL or not), the bandwidth is limited by the interconnect's
bandwidth.

On this server, ideally weighted interleaving should be configured
within a socket (e.g. local NUMA node + local CXL node) because
weighted interleaving does not consider the bandwidth when accessed
from a remote socket.

So, the question is: On systems with multiple sockets (and CXL mem
attached to each socket), do you always assume the admin must bind to
a specific socket for optimal performance or is there any plan to
mitigate this problem without binding tasks to a socket?

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
> +	weightiness = new_weightiness;
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
> +	return count;
> +}
> +
> +static struct kobj_attribute wi_attr =
> +	__ATTR(weightiness, 0664, weightiness_show, weightiness_store);
> +
>   static void sysfs_wi_node_release(struct iw_node_attr *node_attr,
>   				  struct kobject *parent)
>   {
> @@ -3413,6 +3535,7 @@ static void sysfs_wi_release(struct kobject *wi_kobj)
>   
>   	for (i = 0; i < nr_node_ids; i++)
>   		sysfs_wi_node_release(node_attrs[i], wi_kobj);
> +
>   	kobject_put(wi_kobj);
>   }
>   
> @@ -3454,6 +3577,15 @@ static int add_weight_node(int nid, struct kobject *wi_kobj)
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
> @@ -3470,6 +3602,13 @@ static int add_weighted_interleave_group(struct kobject *root_kobj)
>   		return err;
>   	}
>   
> +	err = sysfs_create_group(wi_kobj, &wi_attr_group);
> +	if (err) {
> +		pr_err("failed to add sysfs [weightiness]\n");
> +		kobject_put(wi_kobj);
> +		return err;
> +	}
> +
>   	for_each_node_state(nid, N_POSSIBLE) {
>   		err = add_weight_node(nid, wi_kobj);
>   		if (err) {


