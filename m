Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A312024AD2E
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Aug 2020 05:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTDJu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Aug 2020 23:09:50 -0400
Received: from foss.arm.com ([217.140.110.172]:52948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHTDJu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 19 Aug 2020 23:09:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0858F1045;
        Wed, 19 Aug 2020 20:09:49 -0700 (PDT)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 99C813F66B;
        Wed, 19 Aug 2020 20:09:45 -0700 (PDT)
Subject: Re: [PATCH] arm64: numa: rightsize the distance array
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Barry Song <song.bao.hua@hisilicon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>, linuxarm@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>, Tejun Heo <tj@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20200708113825.1429671-1-Jonathan.Cameron@huawei.com>
 <31e0f1be-7dc5-3e5b-2e56-5cda569f2a55@arm.com>
 <20200819104106.00002e01@Huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a3df03b6-0266-2d12-df3e-1630ccd12421@arm.com>
Date:   Thu, 20 Aug 2020 08:39:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200819104106.00002e01@Huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org



On 08/19/2020 03:11 PM, Jonathan Cameron wrote:
> On Wed, 19 Aug 2020 10:31:18 +0530
> Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> Hello Jonathan,
> 
> Hi Anshuman,
> 
>>
>> On 07/08/2020 05:08 PM, Jonathan Cameron wrote:
>>> Unfortunately we are currently calling numa_alloc_distance well before we call
>>> setup_node_to_cpu_mask_map means that nr_node_ids is set to MAX_NUMNODES.
>>> This wastes a bit of memory and is confusing to the reader.  
>>
>> With defconfig where CONFIG_NODES_SHIFT = 2 i.e MAX_NUMNODES = 4, the total
>> numa_distance size is 16 bytes (individual entries here are just u8). 
> 
> That's another issue to tidy up.  The current defconfig isn't big enough to
> support existing platforms (we are shipping 8 node systems),
> let alone next generation.  Bit of an open question on how far to push it up
> though. Perhaps 64?  Given CXL we are probably going to soon see systems with
> a lot more nodes.  I'll send a patch for that and we can argue the exact
> value then.

I would expect atleast it matches up with the max nodes possible on currently
available systems.

> 
>> Even
>> with MAX_NUMNODES = 256, numa_distance is going to be just 64K. Hence there
>> might not be much space to be saved that would need optimizing this path.
>> Please correct me if I have missed something.
> 
> Agreed.  The saving is small.  This was mostly about the code being misleading.
> It gives the impression of doing dynamic sizing but doesn't actually do so as it
> is using nr_node_ids before that value has been updated.  I would prefer
> to make the code 'obviously' correct.  The x86 path is one approach, simply
> hard coding the size as a constant is another.
> 
> The secondary advantage would be to make it easy to unify this code across
> architectures.  Kind of inevitable riscv will be here soon and it would be nice
> not to have a third slight variation on the code.  I'd like to explore such
> possible unification but it wasn't the main aim of this patch.

There is already a RISC-V proposal in this regard which is trying to create
a generic NUMA framework selectable with GENERIC_ARCH_NUMA. If the ultimate
goal is unify the NUMA init path, we should try and see if that can also
accommodate X86.

https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=332897

> 
>>
>>>
>>> Note we could just decide to hardcode it as MAX_NUMNODES but if so we should
>>> do so explicitly.  
>>
>> nr_node_ids = MAX_NUMNODES which is set from mm/page_alloc.c, yes asserting
>> with an WARN_ON() that it is indeed MAX_NUMNODES would make sense.
> 
> OK, a WARN_ON would at least make it apparent this is a constant, not a dynamic
> value as a reader of the code might assume (I did).
> 
> Could we just go further and use MAX_NUMNODES directly and ignore nr_node_ids
> for this purpose?

IMHO this actually sounds better and cleaner. But the first preference should
be to unify all these as GENERIC_ARCH_NUMA.

> 
>>
>>>
>>> Looking at what x86 does, they do a walk of nodes_parsed and locally
>>> establish the maximum node count seen.  We can't actually do that where we
>>> were previously calling it in numa_init because nodes_parsed isn't set up
>>> either yet.  So let us take a leaf entirely out of x86's book and make
>>> the true assumption that nodes_parsed will definitely be set up before
>>> we try to put a real value in this array.  Hence just do it on demand.  
>>
>> So it is replacing one assumption i.e nr_node_ids = MAX_NUMNODES with another
>> i.e nodes_parsed has been initialized, while trying to populate an entry.
> 
> Yes.  If we make it clearly a fixed value, then I'm happy with that solution
> to this particular problem.
> 
> If not, I would argue that the use nodes_parsed makes it very much obvious that
> we are assuming it was initialized.  (Though on that argument we would have
> assumed nr_node_ids had it's final value in the existing code and it doesn't,
> I come back to my main argument being to make the code 'obviously' correct).
> 
>>
>>>
>>> In order to avoid trying and failing to allocate the array multiple times
>>> we do the same thing as x86 and set numa_distance = 1. This requires a
>>> few small modifications elsewhere.  
>>
>> Where ? Dont see numa_distance being set as 1.
> 
> See below, I have highlighted the line.
> 
>>
>>>
>>> Worth noting, that with one exception (which it appears can be removed [1])
>>> the x86 and arm numa distance code is now identical.  Worth factoring it
>>> out to some common location?
>>>
>>> [1] https://lkml.kernel.org/r/20170406124459.dwn5zhpr2xqg3lqm@node.shutemov.name
>>>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> ---
>>> arch/arm64/mm/numa.c | 35 ++++++++++++++++++-----------------
>>>  1 file changed, 18 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/numa.c b/arch/arm64/mm/numa.c
>>> index aafcee3e3f7e..a2f549ef0a36 100644
>>> --- a/arch/arm64/mm/numa.c
>>> +++ b/arch/arm64/mm/numa.c
>>> @@ -255,13 +255,11 @@ void __init numa_free_distance(void)
>>>  {
>>>  	size_t size;
>>>  
>>> -	if (!numa_distance)
>>> -		return;
>>> -
>>>  	size = numa_distance_cnt * numa_distance_cnt *
>>>  		sizeof(numa_distance[0]);
>>> -
>>> -	memblock_free(__pa(numa_distance), size);
>>> +	/* numa_distance could be 1LU marking allocation failure, test cnt */
>>> +	if (numa_distance_cnt)
>>> +		memblock_free(__pa(numa_distance), size);
>>>  	numa_distance_cnt = 0;
>>>  	numa_distance = NULL;
>>>  }
>>> @@ -271,20 +269,29 @@ void __init numa_free_distance(void)
>>>   */
>>>  static int __init numa_alloc_distance(void)
>>>  {
>>> +	nodemask_t nodes_parsed;
>>>  	size_t size;
>>> +	int i, j, cnt = 0;
>>>  	u64 phys;
>>> -	int i, j;
>>>  
>>> -	size = nr_node_ids * nr_node_ids * sizeof(numa_distance[0]);
>>> +	/* size the new table and allocate it */
>>> +	nodes_parsed = numa_nodes_parsed;
>>> +	for_each_node_mask(i, nodes_parsed)
>>> +		cnt = i;  
>>
>> There is no nodemask related helper to fetch the highest bit set ?
> 
> Not that I can find.
> 
> There is nodes_weight(), but I think we can currently end up with holes,
> and it definitely isn't obvious from the local code that we can't.

Right, the node mask can have holes, so nodes_weight() would not imply
maximum possible node number. Possibly a new helper nodes_max() should
do but not sure if there are any existing instances which could use
such a helper.  

> 
> 
>>
>>> +	cnt++;
>>> +	size = cnt * cnt * sizeof(numa_distance[0]);
>>>  	phys = memblock_find_in_range(0, PFN_PHYS(max_pfn),
>>>  				      size, PAGE_SIZE);
>>> -	if (WARN_ON(!phys))
>>> +	if (!phys) {
>>> +		pr_warn("Warning: can't allocate distance table!\n");
>>> +		/* don't retry until explicitly reset */
>>> +		numa_distance = (void *)1LU;
> 
> Here is where we set numa_distance to 1 in the error path.

Got it.

> 
>>>  		return -ENOMEM;
>>> -
>>> +	}
>>>  	memblock_reserve(phys, size);
>>>  
>>>  	numa_distance = __va(phys);
>>> -	numa_distance_cnt = nr_node_ids;
>>> +	numa_distance_cnt = cnt;
>>>  
>>>  	/* fill with the default distances */
>>>  	for (i = 0; i < numa_distance_cnt; i++)
>>> @@ -311,10 +318,8 @@ static int __init numa_alloc_distance(void)
>>>   */
>>>  void __init numa_set_distance(int from, int to, int distance)
>>>  {
>>> -	if (!numa_distance) {
>>> -		pr_warn_once("Warning: distance table not allocated yet\n");
>>> +	if (!numa_distance && numa_alloc_distance() < 0)
>>>  		return;
>>> -	}
>>>  
>>>  	if (from >= numa_distance_cnt || to >= numa_distance_cnt ||
>>>  			from < 0 || to < 0) {
>>> @@ -384,10 +389,6 @@ static int __init numa_init(int (*init_func)(void))
>>>  	nodes_clear(node_possible_map);
>>>  	nodes_clear(node_online_map);
>>>  
>>> -	ret = numa_alloc_distance();
>>> -	if (ret < 0)
>>> -		return ret;
>>> -
>>>  	ret = init_func();
>>>  	if (ret < 0)
>>>  		goto out_free_distance;
>>>   
>>
>> What is the primary objective here ? Reduce memory for numa_distance[]
>> or unifying arm64's numa_init() with that of x86's ?
> 
> As mentioned above. The objective when I originally looked at this was
> to make the code do what it appeared to do.  The approach chosen was about
> the added benefit of unifying this part with x86 + riscv etc.
> Always good to not reinvent the wheel.

Agreed.
