Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404383D8F41
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jul 2021 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhG1Nj4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Jul 2021 09:39:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:49186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235314AbhG1Nj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jul 2021 09:39:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1582E60F9B;
        Wed, 28 Jul 2021 13:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627479593;
        bh=4OdhEgoy72ayOVqPMBW8RwgohEHFt0wPEe5LTOk/UBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQQstxouxk3H78OvzM2xnb4D22LC0VQxzKMZQuPdrMsjHjP7JJYQlFl5J6fdBNSS8
         BQUHeAKnKskbSmp4WxMHeAV5MxcasQ3hFmOhbrEFZBPP5AdsYUcjbpmxSVIc/9Uads
         P4Q/m5qPIsXP5iFEmasxN/oDyhRoz5ZhReaMW4IY=
Date:   Wed, 28 Jul 2021 15:39:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        virtualization@lists.linux-foundation.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 3/9] drivers/base/memory: introduce "memory groups" to
 logically group memory blocks
Message-ID: <YQFeJ1P9wQvlqAz7@kroah.com>
References: <20210723125210.29987-1-david@redhat.com>
 <20210723125210.29987-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210723125210.29987-4-david@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 23, 2021 at 02:52:04PM +0200, David Hildenbrand wrote:
> In our "auto-movable" memory onlining policy, we want to make decisions
> across memory blocks of a single memory device. Examples of memory devices
> include ACPI memory devices (in the simplest case a single DIMM) and
> virtio-mem. For now, we don't have a connection between a single memory
> block device and the real memory device. Each memory device consists of
> 1..X memory block devices.
> 
> Let's logically group memory blocks belonging to the same memory device
> in "memory groups". Memory groups can span multiple physical ranges and a
> memory group itself does not contain any information regarding physical
> ranges, only properties (e.g., "max_pages") necessary for improved memory
> onlining.
> 
> Introduce two memory group types:
> 
> 1) Static memory group: E.g., a single ACPI memory device, consisting of
>    1..X memory resources. A memory group consists of 1..Y memory blocks.
>    The whole group is added/removed in one go. If any part cannot get
>    offlined, the whole group cannot be removed.
> 
> 2) Dynamic memory group: E.g., a single virtio-mem device. Memory is
>    dynamically added/removed in a fixed granularity, called a "unit",
>    consisting of 1..X memory blocks. A unit is added/removed in one go.
>    If any part of a unit cannot get offlined, the whole unit cannot be
>    removed.
> 
> In case of 1) we usually want either all memory managed by ZONE_MOVABLE
> or none. In case of 2) we usually want to have as many units as possible
> managed by ZONE_MOVABLE. We want a single unit to be of the same type.
> 
> For now, memory groups are an internal concept that is not exposed to
> user space; we might want to change that in the future, though.
> 
> add_memory() users can specify a mgid instead of a nid when passing
> the MHP_NID_IS_MGID flag.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/base/memory.c          | 102 +++++++++++++++++++++++++++++++--
>  include/linux/memory.h         |  46 ++++++++++++++-
>  include/linux/memory_hotplug.h |   6 +-
>  mm/memory_hotplug.c            |  11 +++-
>  4 files changed, 158 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 86ec2dc82fc2..42109e7fb0b5 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -82,6 +82,11 @@ static struct bus_type memory_subsys = {
>   */
>  static DEFINE_XARRAY(memory_blocks);
>  
> +/*
> + * Memory groups, indexed by memory group identification (mgid).
> + */
> +static DEFINE_XARRAY_FLAGS(memory_groups, XA_FLAGS_ALLOC);
> +
>  static BLOCKING_NOTIFIER_HEAD(memory_chain);
>  
>  int register_memory_notifier(struct notifier_block *nb)
> @@ -634,7 +639,8 @@ int register_memory(struct memory_block *memory)
>  }
>  
>  static int init_memory_block(unsigned long block_id, unsigned long state,
> -			     unsigned long nr_vmemmap_pages)
> +			     unsigned long nr_vmemmap_pages,
> +			     struct memory_group *group)
>  {
>  	struct memory_block *mem;
>  	int ret = 0;
> @@ -653,6 +659,11 @@ static int init_memory_block(unsigned long block_id, unsigned long state,
>  	mem->nid = NUMA_NO_NODE;
>  	mem->nr_vmemmap_pages = nr_vmemmap_pages;
>  
> +	if (group) {
> +		mem->group = group;
> +		refcount_inc(&group->refcount);
> +	}
> +
>  	ret = register_memory(mem);
>  
>  	return ret;
> @@ -671,7 +682,7 @@ static int add_memory_block(unsigned long base_section_nr)
>  	if (section_count == 0)
>  		return 0;
>  	return init_memory_block(memory_block_id(base_section_nr),
> -				 MEM_ONLINE, 0);
> +				 MEM_ONLINE, 0,  NULL);
>  }
>  
>  static void unregister_memory(struct memory_block *memory)
> @@ -681,6 +692,11 @@ static void unregister_memory(struct memory_block *memory)
>  
>  	WARN_ON(xa_erase(&memory_blocks, memory->dev.id) == NULL);
>  
> +	if (memory->group) {
> +		refcount_dec(&memory->group->refcount);
> +		memory->group = NULL;

Who freed the memory for the group?

> +	}
> +
>  	/* drop the ref. we got via find_memory_block() */
>  	put_device(&memory->dev);
>  	device_unregister(&memory->dev);
> @@ -694,7 +710,8 @@ static void unregister_memory(struct memory_block *memory)
>   * Called under device_hotplug_lock.
>   */
>  int create_memory_block_devices(unsigned long start, unsigned long size,
> -				unsigned long vmemmap_pages)
> +				unsigned long vmemmap_pages,
> +				struct memory_group *group)
>  {
>  	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
>  	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
> @@ -707,7 +724,8 @@ int create_memory_block_devices(unsigned long start, unsigned long size,
>  		return -EINVAL;
>  
>  	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
> -		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
> +		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages,
> +					group);
>  		if (ret)
>  			break;
>  	}
> @@ -891,3 +909,79 @@ int for_each_memory_block(void *arg, walk_memory_blocks_func_t func)
>  	return bus_for_each_dev(&memory_subsys, NULL, &cb_data,
>  				for_each_memory_block_cb);
>  }
> +
> +static int register_memory_group(struct memory_group group)
> +{
> +	struct memory_group *new_group;
> +	uint32_t mgid;
> +	int ret;
> +
> +	if (!node_possible(group.nid))
> +		return -EINVAL;
> +
> +	new_group = kzalloc(sizeof(group), GFP_KERNEL);
> +	if (!new_group)
> +		return -ENOMEM;
> +	*new_group = group;

You burried a memcpy here, why?  Please be explicit as this is now a
dynamic structure.

> +	refcount_set(&new_group->refcount, 1);

Why not just use a kref?  You seem to be treating it as a kref would
work, right?

> +
> +	ret = xa_alloc(&memory_groups, &mgid, new_group, xa_limit_31b,
> +		       GFP_KERNEL);
> +	if (ret)
> +		kfree(new_group);
> +	return ret ? ret : mgid;

I hate ?: please spell this out:
	if (ret)
		return ret;
	return mgid;

There, more obvious and you can read it in 10 years when you have to go
fix it up...



> +}
> +
> +int register_static_memory_group(int nid, unsigned long max_pages)
> +{
> +	struct memory_group group = {
> +		.nid = nid,
> +		.s = {
> +			.max_pages = max_pages,
> +		},
> +	};
> +
> +	if (!max_pages)
> +		return -EINVAL;
> +	return register_memory_group(group);
> +}
> +EXPORT_SYMBOL_GPL(register_static_memory_group);

Let's make our global namespace a bit nicer:
	memory_group_register_static()
	memory_group_register_dynamic()

and so on.  Use prefixes please, not suffixes.


> +
> +int register_dynamic_memory_group(int nid, unsigned long unit_pages)
> +{
> +	struct memory_group group = {
> +		.nid = nid,
> +		.is_dynamic = true,
> +		.d = {
> +			.unit_pages = unit_pages,
> +		},
> +	};
> +
> +	if (!unit_pages || !is_power_of_2(unit_pages) ||
> +	    unit_pages < PHYS_PFN(memory_block_size_bytes()))
> +		return -EINVAL;
> +	return register_memory_group(group);
> +}
> +EXPORT_SYMBOL_GPL(register_dynamic_memory_group);
> +
> +int unregister_memory_group(int mgid)
> +{
> +	struct memory_group *group;
> +
> +	if (mgid < 0)
> +		return -EINVAL;
> +
> +	group = xa_load(&memory_groups, mgid);
> +	if (!group || refcount_read(&group->refcount) > 1)
> +		return -EINVAL;
> +
> +	xa_erase(&memory_groups, mgid);
> +	kfree(group);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_memory_group);

memory_group_unregister()


> +
> +struct memory_group *get_memory_group(int mgid)
> +{
> +	return xa_load(&memory_groups, mgid);
> +}

Global function?


> diff --git a/include/linux/memory.h b/include/linux/memory.h
> index 97e92e8b556a..6e20a6174fe5 100644
> --- a/include/linux/memory.h
> +++ b/include/linux/memory.h
> @@ -23,6 +23,42 @@
>  
>  #define MIN_MEMORY_BLOCK_SIZE     (1UL << SECTION_SIZE_BITS)
>  
> +struct memory_group {
> +	/* Nid the whole group belongs to. */
> +	int nid;

What is a "nid"?

> +	/* References from memory blocks + 1. */

Blank line above this?

And put the structure comments in proper kernel doc so that others can
read them and we can verify it is correct over time.

> +	refcount_t refcount;
> +	/*
> +	 * Memory group type: static vs. dynamic.
> +	 *
> +	 * Static: All memory in the group belongs to a single unit, such as,
> +	 * a DIMM. All memory belonging to the group will be added in
> +	 * one go and removed in one go -- it's static.
> +	 *
> +	 * Dynamic: Memory within the group is added/removed dynamically in
> +	 * units of the specified granularity of at least one memory block.
> +	 */
> +	bool is_dynamic;
> +
> +	union {
> +		struct {
> +			/*
> +			 * Maximum number of pages we'll have in this static
> +			 * memory group.
> +			 */
> +			unsigned long max_pages;
> +		} s;
> +		struct {
> +			/*
> +			 * Unit in pages in which memory is added/removed in
> +			 * this dynamic memory group. This granularity defines
> +			 * the alignment of a unit in physical address space.
> +			 */
> +			unsigned long unit_pages;
> +		} d;

so is_dynamic determines which to use here?  Please be explicit.


thanks,

greg k-h
