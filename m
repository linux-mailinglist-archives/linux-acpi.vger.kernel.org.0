Return-Path: <linux-acpi+bounces-10771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF5A17C90
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0D33A3278
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51261BBBD4;
	Tue, 21 Jan 2025 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LoSp2xMh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10143C8FE;
	Tue, 21 Jan 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457334; cv=none; b=UDs/rzeBIjWmyL/TH/4za3EDPIOPfNuflaJeTwMDYv6/MGS1FpAvTjEhhqDv5PjTDABwO87tIiNfxpwPkgeHDqhSqWQR2Vsx7Ar92RAIk/u5P0KXddPwwWI7Q+33pfDigkMd110LZfzaSfdZ/jz9SHYtaahCEAa/HalLsxykBMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457334; c=relaxed/simple;
	bh=oTepDSc0KwrrdJ3h9q7voGwdMZhckB5bWvRO1r7tnNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIpEHL8CxFeR3bIPouZqnCZFsMHFkvE2Bogs9gjXhSGWH/lMEbX9zGf2DgLhY4R2AIS33InmHMvuSElJWru4AdVL3a8Gby/qzUAuPMt9q69dAiIA442w3OJH+9hBDrxhODOrch6ziGqz73OQVG26p/zXZ+A/+KJ7GW+kn6P/odQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LoSp2xMh; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737457322; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=caGvGQDtH2XqXoRIUZNscLgmTWrQ6Ez/SEQhEHQiauU=;
	b=LoSp2xMhpaBqfxrk3k3xkeG65bSquMsa+fI2c/Dd1fOhL4pv1W0Y9EDZTTRDqyqTPnzfwJ4NEwn0OUg/Uwz5RxO3y9pVVMjjrQA9aBNp3ZjVtMyCm2sLhZ38nU8EzmZTdbVLbWA+z6op1tNZ2hNci7dVOZASKEhy5EszSwsC41U=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WO5F9Xh_1737457311 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 19:02:00 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Gregory Price <gourry@gourry.net>,  Hyeonggon Yoo
 <hyeonggon.yoo@sk.com>,  kernel_team@skhynix.com,  42.hyeyoo@gmail.com,
  "rafael@kernel.org" <rafael@kernel.org>,  "lenb@kernel.org"
 <lenb@kernel.org>,  "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>,  "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>,  =?utf-8?B?6rmA7ZmN6recKEtJTSBIT05HR1lVKQ==?=
 System SW
 <honggyu.kim@sk.com>,  =?utf-8?B?6rmA65296riwKEtJTSBSQUtJRSk=?= System SW
 <rakie.kim@sk.com>,
  "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
  "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
  "dave.jiang@intel.com" <dave.jiang@intel.com>,  "horen.chuang@linux.dev"
 <horen.chuang@linux.dev>,  "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
  "linux-mm@kvack.org" <linux-mm@kvack.org>,  "kernel-team@meta.com"
 <kernel-team@meta.com>
Subject: Re: [External Mail] Re: [External Mail] [RFC PATCH] mm/mempolicy:
 Weighted interleave auto-tuning
In-Reply-To: <20250109191102.3772288-1-joshua.hahnjy@gmail.com> (Joshua Hahn's
	message of "Thu, 9 Jan 2025 11:10:34 -0800")
References: <20250109191102.3772288-1-joshua.hahnjy@gmail.com>
Date: Tue, 21 Jan 2025 19:01:51 +0800
Message-ID: <87msfkh1ls.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Joshua,

Sorry for late reply.

Joshua Hahn <joshua.hahnjy@gmail.com> writes:

> On Thu, 9 Jan 2025 09:18:18 -0800 Joshua Hahn <joshua.hahnjy@gmail.com> wrote:
>
>> On Thu, 9 Jan 2025 10:56:20 -0500 Gregory Price <gourry@gourry.net> wrote:
>> 
>> > On Wed, Jan 08, 2025 at 10:19:19AM +0900, Hyeonggon Yoo wrote:
>> > > Hi, hope you all had a nice year-end holiday :)
>> > > 
>> > ... snip ...
>> > > Please let me know if there's any point we discussed that I am missing.
>> > > 
>> > > Additionally I would like to mention that within an internal discussion
>> > > my colleague Honggyu suggested introducing 'mode' parameter which can be
>> > > either 'manual' or 'auto' instead of 'use_defaults' to be provide more
>> > > intuitive interface.
>> > > 
>> > > With Honggyu's suggestion and the points we've discussed,
>> > > I think the interface could be:
>> > > 
>> > > # At booting, the mode is 'auto' where the kernel can automatically
>> > > # update any weights.
>> > > 
>> > > mode             auto         # User hasn't specified any weight yet.
>> > > effective        [2, 1, -, -] # Using system defaults for node 0-1,
>> > >                               # and node 2-3 not populated yet.
>> > > 
>> > > # When a new NUMA node is added (e.g. via hotplug) in the 'auto' mode,
>> > > # all weights are re-calculated based on ACPI HMAT table, including the
>> > > # weight of the new node.
>> > > 
>> > > mode             auto         # User hasn't specified weights yet.
>> > > effective        [2, 1, 1, -] # Using system defaults for node 0-2,
>> > >                               # and node 3 not populated yet.
>> > > 
>> > > # When user set at least one weight value, change the mode to 'manual'
>> > > # where the kernel does not update any weights automatically without
>> > > # user's consent.
>> > > 
>> > > mode             manual       # User changed the weight of node 0 to 4,
>> > >                               # changing the mode to manual config mode.
>> > > effective        [4, 1, 1, -]
>> > > 
>> > > 
>> > > # When a new NUMA node is added (e.g. via hotplug) in the manual mode,
>> > > # the new node's weight is zero because it's in manual mode and user
>> > > # did not specify the weight for the new node yet.
>> > > 
>> > > mode             manual
>> > > effective        [4, 1, 1, 0]
>> > > 
>> > 
>> > 0's cannot show up in the effective list - the allocators can never
>> > percieve a 0 as there are (race) conditions where that may cause a div0.
>> > 
>> > The actual content of the list may be 0, but the allocator will see '1'.
>> > 
>> > IIRC this was due to lock/sleep limitations in the allocator paths and
>> > accessing this RCU protected memory. If someone wants to take another
>> > look at the allocator paths and characterize the risk more explicitly,
>> > this would be helpful.
>> 
>> Hi Gregory and Hyeonggon,
>> 
>> Based on a quick look, I see that there can be a problematic scenario
>> in alloc_pages_bulk_array_weighted_interleave where we sum up all
>> the weights from iw_table and divide by this sum. This _can_ be problematic
>> for two reasons, one of them being the div0 mentioned.
>> 
>> Currently, you can access the weights in one of two ways:
>> The first way is to call get_il_weight, which will retrieve a specified
>> node's weight under an rcu read lock. Within this function, it first
>> checks if the value at iw_table[nid] is 0, and if it is, returns 1.
>> Although this prevents a div0 scenario by ensuring that all weights are
>> nonzero, there is a coherency problem, since each instance of get_il_weight
>> creates a new rcu read lock. Therefore, retrieving node weights within a
>> loop creates a race condition in which the state of iw_table may change
>> in between iterations of the loop.
>> 
>> The second way is to directly dereference iw_table under a rcu lock,
>> copy its contents locally, then free the lock. This is how
>> alloc_pages_bulk_array_weighted_interleave currently calculates the sum.
>> The problem here is that even though we solve the coherency issue, there
>> is no check to ensure that this sum is zero. Thus, while having an array of
>> weights [0,0,0,0] gets translated into [1,1,1,1] when inspecting each
>> node individually using get_il_weight, it is still stored internally as 0
>> and can lead to a div0 here.
>> 
>> There are a few workarounds:
>> - Check that weight_total != 0 before performing the division.
>> - During the weight sum iteration, add by weights[node] ? weights[node] : 1
>>   like it is calculated within get_il_weight
>> - Prevent users from ever storing 0 into a node.
>> 
>> Of course, we can implement all three of these changes to make sure that
>> there are no unforunate div0s. However, there are realistic scenarios
>> where we may want the node to actually have a weight of 0, so perhaps
>> it makes sense to just do the first to checks. I can write up a quick
>> patch to perform these checks, if it looks good to everyone.
>> 
>> Please let me know if I missed anything as well.
>
> On second thought, the second bullet point doesn't make much sense, if
> we expect nodes to have 0 as a valid value. Here is something that could
> work for the first bullet point, though. I can send this as a separate
> patch since this is not explicitly related to this thread.
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index cb355bdcdd12..afb0f2a7bd4f 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2552,10 +2552,13 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>          * if (rounds > 0) and (delta == 0), resume_node will always be
>          * the node following prev_node and its weight.
>          */
> -       rounds = rem_pages / weight_total;
> -       delta = rem_pages % weight_total;
>         resume_node = next_node_in(prev_node, nodes);
>         resume_weight = weights[resume_node];
> +       if (weight_total == 0)
> +               goto out;
> +
> +       rounds = rem_pages / weight_total;
> +       delta = rem_pages % weight_total;
>         for (i = 0; i < nnodes; i++) {
>                 node = next_node_in(prev_node, nodes);
>                 weight = weights[node];
> @@ -2582,6 +2585,8 @@ static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
>                         break;
>                 prev_node = node;
>         }
> +
> +out:
>         me->il_prev = resume_node;
>         me->il_weight = resume_weight;
>         kfree(weights);
>
> Of course, the only way this can happen is if a user purposefully
> sets all of the node weights to 0, so I don't think this is something
> that should ever happen naturally. Even with the new reduce_interleave_weights
> function, it manually checks and makes sure that the lowest possible value
> is 1.
>
> Again, please let me know if I am missing anything!

I don't think that "0" is a valid weight value.  If you don't want to
allocate pages on some nodes, just don't specify them in the node mask
parameter when you call mbind() or set_mempolicy().

---
Best Regards,
Huang, Ying

