Return-Path: <linux-acpi+bounces-6604-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA27C91619F
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEA371C235F0
	for <lists+linux-acpi@lfdr.de>; Tue, 25 Jun 2024 08:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC2C148832;
	Tue, 25 Jun 2024 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWDOmpjN"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9145038;
	Tue, 25 Jun 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305317; cv=none; b=uUbAsJi+VdYThin5vkYf37zQ+ob90Z2t3iaxEBjNTHzLzmFGV6BdeNG/ji3otXuc1XJWLbZw2EmQKeLEjq7zjD31FKyM29UXuUPbvaGbKFcZIFA3oAPudzANyE0dvJuIQuKjN8nbeFtH1Rbp4EsFualT/6cJLrDCgM6QBrLHCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305317; c=relaxed/simple;
	bh=sc3MvgtGqd2jx97fryD2plG5tg26uAjfgeVc4PVkPh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KSWZWCDA1JyW8O60Mzaa0rIuG01kNMh+fK02QAXYMWvbd0BpCXJ4QsP7AwE6eFNqhebWTLe9dx6phLqRclOFyEf3mIqQ1tZjINLMM0wxiR50X+YNp+r51+sYphTT7IJR5Otlwwm7XgXE4DJa7tfk4XiAtqNlZ23aicamWHRBvKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWDOmpjN; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719305315; x=1750841315;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=sc3MvgtGqd2jx97fryD2plG5tg26uAjfgeVc4PVkPh8=;
  b=BWDOmpjNRAdgFT92q6vWDJ1TiDbEcESb7YlVTR0j+VgH9IDmaN/o/CtO
   OUi3ig1HdnUoeeZwVT18qr4VrMvADS3AnZ5BpVSMRIwKxuR9k+HY5n6lV
   h1Pk3njI4HLa2FfjCAeWEwqyqhdFLltTA3exkeTJUKqGraxi937QG/k2z
   bhHBGA5PXF2r/rincezRpIdGoSy+vVgalINvnm5TM25j1GT0Hv9m4NwfH
   AKEYXQV4XzP0y/qhsg/MAla56DnFdyMHVZ1bILcaDAwO3OyqE08qHpsYb
   Sx7b7MYhqi1DDy7Iuh115iDl0HbMPmusoqjr3rxvENMUpVX+aCs1klGEO
   g==;
X-CSE-ConnectionGUID: 88jXlpSrSP6nIorM2HnlYQ==
X-CSE-MsgGUID: aFD59GQSQ7atUPb6mUTacg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="41727759"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="41727759"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:48:34 -0700
X-CSE-ConnectionGUID: LNH8uXAFT9u3uT9tfnWQ6Q==
X-CSE-MsgGUID: cawdbL5LS7mNcQEHg4JiaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43671725"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:48:28 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren Chuang" <horen.chuang@linux.dev>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
  mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
  "Alistair Popple" <apopple@nvidia.com>,  "Srinivasulu Thanneeru"
 <sthanneeru@micron.com>,  "SeongJae Park" <sj@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  "Len Brown" <lenb@kernel.org>,  "Andrew
 Morton" <akpm@linux-foundation.org>,  "Dave Jiang" <dave.jiang@intel.com>,
  "Dan Williams" <dan.j.williams@intel.com>,  linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>,  linux-cxl@vger.kernel.org,
  qemu-devel@nongnu.org
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of
 memory tiers
In-Reply-To: <d8a3664144e904d3a27dacb83febd8d00b95295f@linux.dev> (Ho-Ren
	Chuang's message of "Tue, 25 Jun 2024 07:22:13 +0000")
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
	<87wmmezqx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<d8a3664144e904d3a27dacb83febd8d00b95295f@linux.dev>
Date: Tue, 25 Jun 2024 16:46:36 +0800
Message-ID: <87v81xxvdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

"Ho-Ren  Chuang" <horen.chuang@linux.dev> writes:

> June 24, 2024 at 1:27 AM, "Huang, Ying" <ying.huang@intel.com> wrote:
>
> Hi Huang, Ying,
>
> Thanks for your feedback. Replies inlined.
>
>> 
>> Hi, Jack,
>> 
>> Thanks for patch!
>> 
>> "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> writes:
>> 
>> > 
>> > If we simply move the set_node_memory_tier() from memory_tier_init() to
>> > 
>> >  late_initcall(), it will result in HMAT not registering the
>> > 
>> >  mt_adistance_algorithm callback function, because set_node_memory_tier()
>> > 
>> >  is not performed during the memory tiering initialization phase,
>> > 
>> >  leading to a lack of correct default_dram information.
>> > 
>> >  Therefore, we introduced a nodemask to pass the information of the
>> > 
>> >  default DRAM nodes. The reason for not choosing to reuse
>> > 
>> >  default_dram_type->nodes is that it is not clean enough. So in the end,
>> > 
>> >  we use a __initdata variable, which is a variable that is released once
>> > 
>> >  initialization is complete, including both CPU and memory nodes for HMAT
>> > 
>> >  to iterate through.
>> > 
>> >  Besides, since default_dram_type may be checked/used during the
>> > 
>> >  initialization process of HMAT and drivers, it is better to keep the
>> > 
>> >  allocation of default_dram_type in memory_tier_init().
>> > 
>> >  Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
>> > 
>> 
>> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> 
>
> Thank you for your help with the input. Will add it in the v2.
>
>> > 
>> > ---
>> > 
>> >  Hi all,
>> > 
>> >  The current memory tier initialization process is distributed across two
>> > 
>> >  different functions, memory_tier_init() and memory_tier_late_init(). This
>> > 
>> >  design is hard to maintain. Thus, this patch is proposed to reduce the
>> > 
>> >  possible code paths by consolidating different initialization patches into one.
>> > 
>> >  The earlier discussion with Jonathan and Ying is listed here:
>> > 
>> >  https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/
>> > 
>> >  If we want to put these two initializations together, they must be placed
>> > 
>> >  together in the later function. Because only at that time, the HMAT information
>> > 
>> >  will be ready, adist between nodes can be calculated, and memory tiering can be
>> > 
>> >  established based on the adist. So we position the initialization at
>> > 
>> >  memory_tier_init() to the memory_tier_late_init() call.
>> > 
>> >  Moreover, it's natural to keep memory_tier initialization in drivers at
>> > 
>> >  device_initcall() level.
>> > 
>> >  This patchset is based on commits cf93be18fa1b and a72a30af550c:
>> > 
>> >  [0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
>> > 
>> >  [1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
>> > 
>> >  [1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com
>> > 
>> 
>> It appears that you should switch the parts before and after "---".
>> 
>> This is the real patch description, as pointed out by Andrew too.
>> 
>
> Thank you for the suggestion. I plan to write the real patch description in
> the cover letter in the next version to avoid any misunderstanding.
>
>> > 
>> > Thanks,
>> > 
>> >  Ho-Ren (Jack) Chuang
>> > 
>> >  drivers/acpi/numa/hmat.c | 4 ++-
>> > 
>> >  include/linux/memory-tiers.h | 6 ++++
>> > 
>> >  mm/memory-tiers.c | 70 ++++++++++++++++++------------------
>> > 
>> >  3 files changed, 44 insertions(+), 36 deletions(-)
>> > 
>> >  diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> > 
>> >  index 2c8ccc91ebe6..31a77a3324a8 100644
>> > 
>> >  --- a/drivers/acpi/numa/hmat.c
>> > 
>> >  +++ b/drivers/acpi/numa/hmat.c
>> > 
>> >  @@ -939,11 +939,13 @@ static int hmat_set_default_dram_perf(void)
>> > 
>> >  int nid, pxm;
>> > 
>> >  struct memory_target *target;
>> > 
>> >  struct access_coordinate *attrs;
>> > 
>> >  + nodemask_t default_dram_nodes;
>> > 
>> >  
>> > 
>> >  if (!default_dram_type)
>> > 
>> >  return -EIO;
>> > 
>> >  
>> > 
>> >  - for_each_node_mask(nid, default_dram_type->nodes) {
>> > 
>> >  + default_dram_nodes = mt_get_default_dram_nodemask();
>> > 
>> >  + for_each_node_mask(nid, default_dram_nodes) {
>> > 
>> 
>> We don't need 'default_dram_type' in the function actually. It appears
>> 
>> that we can hide it in memory-tiers.c now?
>> 
>
> Do you mean to remove the "if (!default_dram_type) return -EIO;" here?
> If so, I agree, it's not used anymore here.

Yes.

>> > 
>> > pxm = node_to_pxm(nid);
>> > 
>> >  target = find_mem_target(pxm);
>> > 
>> >  if (!target)
>> > 
>> >  diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> > 
>> >  index 0d70788558f4..1567db7bd40e 100644
>> > 
>> >  --- a/include/linux/memory-tiers.h
>> > 
>> >  +++ b/include/linux/memory-tiers.h
>> > 
>> >  @@ -51,6 +51,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
>> > 
>> >  struct memory_dev_type *mt_find_alloc_memory_type(int adist,
>> > 
>> >  struct list_head *memory_types);
>> > 
>> >  void mt_put_memory_types(struct list_head *memory_types);
>> > 
>> >  +nodemask_t mt_get_default_dram_nodemask(void);
>> > 
>> >  #ifdef CONFIG_MIGRATION
>> > 
>> >  int next_demotion_node(int node);
>> > 
>> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
>> > 
>> >  @@ -149,5 +150,10 @@ static inline struct memory_dev_type *mt_find_alloc_memory_type(int adist,
>> > 
>> >  static inline void mt_put_memory_types(struct list_head *memory_types)
>> > 
>> >  {
>> > 
>> >  }
>> > 
>> >  +
>> > 
>> >  +static inline nodemask_t mt_get_default_dram_nodemask(void)
>> > 
>> >  +{
>> > 
>> >  + return NODE_MASK_NONE;
>> > 
>> >  +}
>> > 
>> >  #endif /* CONFIG_NUMA */
>> > 
>> >  #endif /* _LINUX_MEMORY_TIERS_H */
>> > 
>> >  diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> > 
>> >  index 6632102bd5c9..7d4b7f53dd8f 100644
>> > 
>> >  --- a/mm/memory-tiers.c
>> > 
>> >  +++ b/mm/memory-tiers.c
>> > 
>> >  @@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
>> > 
>> >  static LIST_HEAD(default_memory_types);
>> > 
>> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>> > 
>> >  struct memory_dev_type *default_dram_type;
>> > 
>> >  +static nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
>> > 
>> >  
>> > 
>> >  static const struct bus_type memory_tier_subsys = {
>> > 
>> >  .name = "memory_tiering",
>> > 
>> >  @@ -125,6 +126,11 @@ static inline struct memory_tier *to_memory_tier(struct device *device)
>> > 
>> >  return container_of(device, struct memory_tier, dev);
>> > 
>> >  }
>> > 
>> >  
>> > 
>> >  +nodemask_t __init mt_get_default_dram_nodemask(void)
>> > 
>> >  +{
>> > 
>> >  + return default_dram_nodes;
>> > 
>> >  +}
>> > 
>> >  +
>> > 
>> 
>> Why not just expose 'default_dram_nodes'?
>> 
>
> I was thinking encapsulating it should be more systematic/structural.
> Do you think exposing it is better?

It doesn't help much to encapsulate with one line function.  So, IMO,
it's better just to expose it.

>> > 
>> > static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
>> > 
>> >  {
>> > 
>> >  nodemask_t nodes = NODE_MASK_NONE;
>> > 
>> >  @@ -671,27 +677,38 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
>> > 
>> >  
>> > 
>> >  /*
>> > 
>> >  * This is invoked via `late_initcall()` to initialize memory tiers for
>> > 
>> >  - * CPU-less memory nodes after driver initialization, which is
>> > 
>> >  - * expected to provide `adistance` algorithms.
>> > 
>> >  + * memory nodes, both with and without CPUs. After the initialization of
>> > 
>> >  + * firmware and devices, adistance algorithms are expected to be provided.
>> > 
>> >  */
>> > 
>> >  static int __init memory_tier_late_init(void)
>> > 
>> >  {
>> > 
>> >  int nid;
>> > 
>> >  + struct memory_tier *memtier;
>> > 
>> >  
>> > 
>> >  guard(mutex)(&memory_tier_lock);
>> > 
>> >  + /*
>> > 
>> >  + * Look at all the existing and uninitialized N_MEMORY nodes and
>> > 
>> >  + * add them to default memory tier or to a tier if we already have
>> > 
>> >  + * memory types assigned.
>> > 
>> >  + */
>> > 
>> >  for_each_node_state(nid, N_MEMORY) {
>> > 
>> 
>> During the function run, the node may change between N_MEMORY and
>> 
>> !N_MEMORY in theory. So, it appears necessary to get/put_online_mems()
>> 
>> in the function?
>> 
>
> Thanks for the catch. I will add get/put_online_mems().
>
>> > 
>> > - /*
>> > 
>> >  - * Some device drivers may have initialized memory tiers
>> > 
>> >  - * between `memory_tier_init()` and `memory_tier_late_init()`,
>> > 
>> >  - * potentially bringing online memory nodes and
>> > 
>> >  - * configuring memory tiers. Exclude them here.
>> > 
>> >  - */
>> > 
>> >  - if (node_memory_types[nid].memtype)
>> > 
>> >  - continue;
>> > 
>> >  + if (!node_state(nid, N_CPU))
>> > 
>> 
>> Why? I think that we should "continue" here even if node_state(nid,
>> 
>> N_CPU).
>> 
>
> Do you mean no matter node_state(nid, N_CPU) or !node_state(nid, N_CPU),
> as long as if (node_memory_types[nid].memtype) is true, we
> should "continue"?
>
> I think you are right, at this moment, we only care if the
> node_memory_types[nid].memtype is set or not.
> If not, we should set it here. If yes, we should continue.
> If my understanding is correct, I will fix it in the v2.

Yes.  That's my opinion too.

>> > 
>> > + /*
>> > 
>> >  + * Some device drivers may have initialized
>> > 
>> >  + * memory tiers, potentially bringing memory nodes
>> > 
>> >  + * online and configuring memory tiers.
>> > 
>> >  + * Exclude them here.
>> > 
>> >  + */
>> > 
>> >  + if (node_memory_types[nid].memtype)
>> > 
>> >  + continue;
>> > 
>> >  
>> > 
>> >  - set_node_memory_tier(nid);
>> > 
>> >  + memtier = set_node_memory_tier(nid);
>> > 
>> >  + if (IS_ERR(memtier))
>> > 
>> >  + /*
>> > 
>> >  + * Continue with memtiers we are able to setup.
>> > 
>> >  + */
>> > 
>> >  + break;
>> > 
>> >  }
>> > 
>> >  -
>> > 
>> >  establish_demotion_targets();
>> > 
>> >  
>> > 
>> >  return 0;
>> > 
>> >  @@ -876,7 +893,6 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>> > 
>> >  static int __init memory_tier_init(void)
>> > 
>> >  {
>> > 
>> >  int ret, node;
>> > 
>> >  - struct memory_tier *memtier;
>> > 
>> >  
>> > 
>> >  ret = subsys_virtual_register(&memory_tier_subsys, NULL);
>> > 
>> >  if (ret)
>> > 
>> >  @@ -887,7 +903,8 @@ static int __init memory_tier_init(void)
>> > 
>> >  GFP_KERNEL);
>> > 
>> >  WARN_ON(!node_demotion);
>> > 
>> >  #endif
>> > 
>> >  - mutex_lock(&memory_tier_lock);
>> > 
>> >  +
>> > 
>> >  + guard(mutex)(&memory_tier_lock);
>> > 
>> >  /*
>> > 
>> >  * For now we can have 4 faster memory tiers with smaller adistance
>> > 
>> >  * than default DRAM tier.
>> > 
>> >  @@ -898,28 +915,11 @@ static int __init memory_tier_init(void)
>> > 
>> >  panic("%s() failed to allocate default DRAM tier\n", __func__);
>> > 
>> >  
>> > 
>> >  /*
>> > 
>> >  - * Look at all the existing N_MEMORY nodes and add them to
>> > 
>> >  - * default memory tier or to a tier if we already have memory
>> > 
>> >  - * types assigned.
>> > 
>> >  + * Record nodes with memory and CPU to set default DRAM performance.
>> > 
>> >  */
>> > 
>> 
>> For one line comments, we can use
>> 
>>  /* Record nodes with memory and CPU to set default DRAM performance. */
>> 
>
> Thank you for the guidance. Will fix in the v2.
>
>> > 
>> > - for_each_node_state(node, N_MEMORY) {
>> > 
>> >  - if (!node_state(node, N_CPU))
>> > 
>> >  - /*
>> > 
>> >  - * Defer memory tier initialization on
>> > 
>> >  - * CPUless numa nodes. These will be initialized
>> > 
>> >  - * after firmware and devices are initialized.
>> > 
>> >  - */
>> > 
>> >  - continue;
>> > 
>> >  -
>> > 
>> >  - memtier = set_node_memory_tier(node);
>> > 
>> >  - if (IS_ERR(memtier))
>> > 
>> >  - /*
>> > 
>> >  - * Continue with memtiers we are able to setup
>> > 
>> >  - */
>> > 
>> >  - break;
>> > 
>> >  - }
>> > 
>> >  - establish_demotion_targets();
>> > 
>> >  - mutex_unlock(&memory_tier_lock);
>> > 
>> >  + for_each_node_state(node, N_MEMORY)
>> > 
>> >  + if (node_state(node, N_CPU))
>> > 
>> >  + node_set(node, default_dram_nodes);
>> > 
>> 
>> Why not use
>> 
>>  nodes_andnot(default_dram_nodes, node_states[N_MEMORY], node_states[N_CPU]);
>> 
>
> Instead of using nodes_andnot(), should nodes_and() be correct? because we wanna
> record the nodes that are both N_MEMORY and N_CPU.

Oh, Yes, you are right.

>> > 
>> > hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>> > 
>> >  return 0;
>> > 
>> 

--
Best Regards,
Huang, Ying

