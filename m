Return-Path: <linux-acpi+bounces-6751-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96245925570
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 10:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537B2282074
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 08:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E01131BDD;
	Wed,  3 Jul 2024 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DyDgFpCr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689AF13A3F7
	for <linux-acpi@vger.kernel.org>; Wed,  3 Jul 2024 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995624; cv=none; b=Bd9QRCwi7JkDphEoMM3ZWEXFueXbGOppu5JtKKg5ukRyCcoBJnv293ZbVFCGeJtNLtu0Hgd4o5DVzTh2d12SVEBb63h2sbm4sCvw7U1qL/9FeEchsHEFS7M2WooV8tCzEcCKt1ZdfuTqFZs5tTwXQhgrRCC5wlPOL5xSRDR1xl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995624; c=relaxed/simple;
	bh=gh8cWkz+uZr7Fy+OxS6J+nBZ4z94uHhOoDTE8BsIX8c=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=UKk8p2gI6Z51UeTCD8jluO7+4fwcUWMAbitw545w/d7gGxkwZvLOn5zAXkTjqu4dshEoN1vUfQX052DRKY+lXCG3TdaSDbGXl4uswb+lvUFB7SgP7nLN3mVR3+oGWvR0IOGqHNfP9PLyVKQfb+aOVfzH9l2/PPhsOQhSjj0TikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DyDgFpCr; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jonathan.cameron@huawei.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719995618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GYdbIFqgvxSKSTx5OuR/O8uY7V3pnvwxeIXq3ufogpU=;
	b=DyDgFpCreZvB2lwahGshIF3DBrO6FntRG7C+76zi8xGu8aDbz1/RfGKqsK25a+L38OLXUS
	C11DOr3doHhqMokKBE+sXmq2txvQ4z0LGm/h0D7KFMyNmEsWMW9J1COhSZL4mOf76vOM/K
	3UMDQ2MRjHJKMQrDlJTMKOEATkS3Wug=
X-Envelope-To: ying.huang@intel.com
X-Envelope-To: gourry.memverge@gmail.com
X-Envelope-To: aneesh.kumar@linux.ibm.com
X-Envelope-To: mhocko@suse.com
X-Envelope-To: tj@kernel.org
X-Envelope-To: john@jagalactic.com
X-Envelope-To: emirakhur@micron.com
X-Envelope-To: vtavarespetr@micron.com
X-Envelope-To: ravis.opensrc@micron.com
X-Envelope-To: apopple@nvidia.com
X-Envelope-To: sthanneeru@micron.com
X-Envelope-To: sj@kernel.org
X-Envelope-To: rafael@kernel.org
X-Envelope-To: lenb@kernel.org
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: dave.jiang@intel.com
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: linux-acpi@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: horenc@vt.edu
X-Envelope-To: horenchuang@bytedance.com
X-Envelope-To: horenchuang@gmail.com
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: qemu-devel@nongnu.org
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 03 Jul 2024 08:33:34 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
Message-ID: <84b43294411bb1fe0ed58f2da59abf554ef48f7d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
To: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "Gregory Price"
 <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com,
 tj@kernel.org, john@jagalactic.com, "Eishan Mirakhur"
 <emirakhur@micron.com>, "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>, "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Srinivasulu Thanneeru"
 <sthanneeru@micron.com>, "SeongJae  Park" <sj@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack) Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack)  Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
In-Reply-To: <20240702142535.00003dc0@Huawei.com>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
 <20240628060925.303309-2-horen.chuang@linux.dev>
 <20240702142535.00003dc0@Huawei.com>
X-Migadu-Flow: FLOW_OUT

Hi Jonathan,

I appreciate your feedback and valuable suggestions. Replies inlined.


July 2, 2024 at 6:25 AM, "Jonathan Cameron" <Jonathan.Cameron@huawei.com>=
 wrote:
>=20
>=20On Fri, 28 Jun 2024 06:09:23 +0000
>=20
>=20"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:
>=20
>=20>=20
>=20> If we simply move the set_node_memory_tier() from memory_tier_init(=
)
> >=20
>=20>  to late_initcall(), it will result in HMAT not registering
> >=20
>=20>  the mt_adistance_algorithm callback function, because
> >=20
>=20>  set_node_memory_tier() is not performed during the memory tiering
> >=20
>=20>  initialization phase, leading to a lack of correct default_dram
> >=20
>=20>  information.
> >=20
>=20>=20=20
>=20>=20
>=20>  Therefore, we introduced a nodemask to pass the information of the
> >=20
>=20>  default DRAM nodes. The reason for not choosing to reuse
> >=20
>=20>  default_dram_type->nodes is that it is not clean enough. So in the=
 end,
> >=20
>=20>  we use a __initdata variable, which is a variable that is released=
 once
> >=20
>=20>  initialization is complete, including both CPU and memory nodes fo=
r HMAT
> >=20
>=20>  to iterate through.
> >=20
>=20>=20=20
>=20>=20
>=20>  Besides, since default_dram_type may be checked/used during the
> >=20
>=20>  initialization process of HMAT and drivers, it is better to keep t=
he
> >=20
>=20>  allocation of default_dram_type in memory_tier_init().
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >=20
>=20>  Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
>=20>  ---
> >=20
>=20>  drivers/acpi/numa/hmat.c | 5 +--
> >=20
>=20>  include/linux/memory-tiers.h | 2 ++
> >=20
>=20>  mm/memory-tiers.c | 59 +++++++++++++++---------------------
> >=20
>=20>  3 files changed, 28 insertions(+), 38 deletions(-)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> >=20
>=20>  index 2c8ccc91ebe6..a2f9e7a4b479 100644
> >=20
>=20>  --- a/drivers/acpi/numa/hmat.c
> >=20
>=20>  +++ b/drivers/acpi/numa/hmat.c
> >=20
>=20>  @@ -940,10 +940,7 @@ static int hmat_set_default_dram_perf(void)
> >=20
>=20>  struct memory_target *target;
> >=20
>=20>  struct access_coordinate *attrs;
> >=20
>=20>=20=20
>=20>=20
>=20>  - if (!default_dram_type)
> >=20
>=20>  - return -EIO;
> >=20
>=20>  -
> >=20
>=20>  - for_each_node_mask(nid, default_dram_type->nodes) {
> >=20
>=20>  + for_each_node_mask(nid, default_dram_nodes) {
> >=20
>=20
> As below. Do we care if the combination of RAM + CPU wasn't true
>=20
>=20earlier and is true by this point? If not, why not just
>=20
>=20compute the node mask in here and not store it.
>=20

It=20makes sense to me. I think we can move the computation to here
and remove the global node mask.

> >=20
>=20> pxm =3D node_to_pxm(nid);
> >=20
>=20>  target =3D find_mem_target(pxm);
> >=20
>=20>  if (!target)
> >=20
>=20>  diff --git a/include/linux/memory-tiers.h b/include/linux/memory-t=
iers.h
> >=20
>=20>  index 0d70788558f4..fa61ad9c4d75 100644
> >=20
>=20>  --- a/include/linux/memory-tiers.h
> >=20
>=20>  +++ b/include/linux/memory-tiers.h
> >=20
>=20>  @@ -38,6 +38,7 @@ struct access_coordinate;
> >=20
>=20>  #ifdef CONFIG_NUMA
> >=20
>=20>  extern bool numa_demotion_enabled;
> >=20
>=20>  extern struct memory_dev_type *default_dram_type;
> >=20
>=20>  +extern nodemask_t default_dram_nodes __initdata;
> >=20
>=20>  struct memory_dev_type *alloc_memory_type(int adistance);
> >=20
>=20>  void put_memory_type(struct memory_dev_type *memtype);
> >=20
>=20>  void init_node_memory_type(int node, struct memory_dev_type *defau=
lt_type);
> >=20
>=20>  @@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
> >=20
>=20>=20=20
>=20>=20
>=20>  #define numa_demotion_enabled false
> >=20
>=20>  #define default_dram_type NULL
> >=20
>=20>  +#define default_dram_nodes NODE_MASK_NONE
> >=20
>=20>  /*
> >=20
>=20>  * CONFIG_NUMA implementation returns non NULL error.
> >=20
>=20>  */
> >=20
>=20>  diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >=20
>=20>  index 6632102bd5c9..a19a90c3ad36 100644
> >=20
>=20>  --- a/mm/memory-tiers.c
> >=20
>=20>  +++ b/mm/memory-tiers.c
> >=20
>=20>  @@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
> >=20
>=20>  static LIST_HEAD(default_memory_types);
> >=20
>=20>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES]=
;
> >=20
>=20>  struct memory_dev_type *default_dram_type;
> >=20
>=20>  +nodemask_t default_dram_nodes __initdata =3D NODE_MASK_NONE;
> >=20
>=20>=20=20
>=20>=20
>=20>  static const struct bus_type memory_tier_subsys =3D {
> >=20
>=20>  .name =3D "memory_tiering",
> >=20
>=20>  @@ -671,28 +672,38 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
> >=20
>=20>=20=20
>=20>=20
>=20>  /*
> >=20
>=20>  * This is invoked via `late_initcall()` to initialize memory tiers=
 for
> >=20
>=20>  - * CPU-less memory nodes after driver initialization, which is
> >=20
>=20>  - * expected to provide `adistance` algorithms.
> >=20
>=20>  + * memory nodes, both with and without CPUs. After the initializa=
tion of
> >=20
>=20>  + * firmware and devices, adistance algorithms are expected to be =
provided.
> >=20
>=20>  */
> >=20
>=20>  static int __init memory_tier_late_init(void)
> >=20
>=20>  {
> >=20
>=20>  int nid;
> >=20
>=20>  + struct memory_tier *memtier;
> >=20
>=20>=20=20
>=20>=20
>=20>  + get_online_mems();
> >=20
>=20>  guard(mutex)(&memory_tier_lock);
> >=20
>=20>  + /*
> >=20
>=20>  + * Look at all the existing and uninitialized N_MEMORY nodes and
> >=20
>=20>  + * add them to default memory tier or to a tier if we already hav=
e
> >=20
>=20>  + * memory types assigned.
> >=20
>=20>  + */
> >=20
>=20>  for_each_node_state(nid, N_MEMORY) {
> >=20
>=20>  /*
> >=20
>=20>  - * Some device drivers may have initialized memory tiers
> >=20
>=20>  - * between `memory_tier_init()` and `memory_tier_late_init()`,
> >=20
>=20>  - * potentially bringing online memory nodes and
> >=20
>=20>  - * configuring memory tiers. Exclude them here.
> >=20
>=20>  + * Some device drivers may have initialized
> >=20
>=20>  + * memory tiers, potentially bringing memory nodes
> >=20
>=20>  + * online and configuring memory tiers.
> >=20
>=20>  + * Exclude them here.
> >=20
>=20>  */
> >=20
>=20>  if (node_memory_types[nid].memtype)
> >=20
>=20>  continue;
> >=20
>=20>=20=20
>=20>=20
>=20>  - set_node_memory_tier(nid);
> >=20
>=20>  + memtier =3D set_node_memory_tier(nid);
> >=20
>=20>  + if (IS_ERR(memtier))
> >=20
>=20>  + /* Continue with memtiers we are able to setup. */
> >=20
>=20
> Might later ones be possible if we just continued this loop?
>=20

I=20agree with you that theoretically, it=E2=80=99s possible
for later attempts to succeed. I also agree that
there is no harm in iterating through all possibilities.
Therefore, we can do a continue here.

Since it's legacy code.
I would also like to hear Huang, Ying=E2=80=99s thoughts about this.

> >=20
>=20> + break;
> >=20
>=20>  }
> >=20
>=20>  -
> >=20
>=20
> White space was harmless - I'd leave it there rather than adding noise =
to this diff.
>=20

Thanks!=20Got it. I will roll it back in the v3.

> >=20
>=20> establish_demotion_targets();
> >=20
>=20>  + put_online_mems();
> >=20
>=20>=20=20
>=20>=20
>=20>  return 0;
> >=20
>=20>  }
> >=20
>=20>  @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(=
struct notifier_block *self,
> >=20
>=20>=20=20
>=20>=20
>=20>  static int __init memory_tier_init(void)
> >=20
>=20>  {
> >=20
>=20>  - int ret, node;
> >=20
>=20>  - struct memory_tier *memtier;
> >=20
>=20>  + int ret;
> >=20
>=20>=20=20
>=20>=20
>=20>  ret =3D subsys_virtual_register(&memory_tier_subsys, NULL);
> >=20
>=20>  if (ret)
> >=20
>=20>  @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
> >=20
>=20>  GFP_KERNEL);
> >=20
>=20>  WARN_ON(!node_demotion);
> >=20
>=20>  #endif
> >=20
>=20>  - mutex_lock(&memory_tier_lock);
> >=20
>=20>  +
> >=20
>=20>  + guard(mutex)(&memory_tier_lock);
> >=20
>=20
> If this was safe to do without the rest of the change (I think so)
>=20
>=20then better to pull that out as a trivial precursor so less noise
>=20
>=20in here.
>=20

Do=20you mean instead of using guard(mutex)(),
use mutex_lock() as it was? or?

> >=20
>=20> /*
> >=20
>=20>  * For now we can have 4 faster memory tiers with smaller adistance
> >=20
>=20>  * than default DRAM tier.
> >=20
>=20>  @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
> >=20
>=20>  if (IS_ERR(default_dram_type))
> >=20
>=20>  panic("%s() failed to allocate default DRAM tier\n", __func__);
> >=20
>=20>=20=20
>=20>=20=0D
> >  - /*
> >=20
>=20>  - * Look at all the existing N_MEMORY nodes and add them to
> >=20
>=20>  - * default memory tier or to a tier if we already have memory
> >=20
>=20>  - * types assigned.
> >=20
>=20>  - */
> >=20
>=20>  - for_each_node_state(node, N_MEMORY) {
> >=20
>=20>  - if (!node_state(node, N_CPU))
> >=20
>=20>  - /*
> >=20
>=20>  - * Defer memory tier initialization on
> >=20
>=20>  - * CPUless numa nodes. These will be initialized
> >=20
>=20>  - * after firmware and devices are initialized.
> >=20
>=20>  - */
> >=20
>=20>  - continue;
> >=20
>=20>  -
> >=20
>=20>  - memtier =3D set_node_memory_tier(node);
> >=20
>=20>  - if (IS_ERR(memtier))
> >=20
>=20>  - /*
> >=20
>=20>  - * Continue with memtiers we are able to setup
> >=20
>=20>  - */
> >=20
>=20>  - break;
> >=20
>=20>  - }
> >=20
>=20>  - establish_demotion_targets();
> >=20
>=20>  - mutex_unlock(&memory_tier_lock);
> >=20
>=20>  + /* Record nodes with memory and CPU to set default DRAM performa=
nce. */
> >=20
>=20>  + nodes_and(default_dram_nodes, node_states[N_MEMORY],
> >=20
>=20>  + node_states[N_CPU]);
> >=20
>=20
> There are systems where (for various esoteric reasons, such as describi=
ng an
>=20
>=20association with some other memory that isn't DRAM where the granular=
ity
>=20
>=20doesn't match) the CPU nodes contain no DRAM but rather it's one node=
 away.
>=20
>=20Handling that can be a job for another day though.
>=20

Thank=20you for informing me of this situation.
Sounds like handling that also requires a mapping table between
the CPU and the corresponding DRAM.

> Why does this need to be computed here? Why not do it in
>=20
>=20hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.
>=20
Replied=20above.
> >=20
> > hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI=
);
> >=20
>=20>  return 0;
> >
>

--
Best Regards,
Ho-Ren (Jack) Chuang

