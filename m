Return-Path: <linux-acpi+bounces-6640-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF414919E1C
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 06:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6929A1F2115B
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Jun 2024 04:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F153D17BD3;
	Thu, 27 Jun 2024 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oehAH12s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CC8175A6
	for <linux-acpi@vger.kernel.org>; Thu, 27 Jun 2024 04:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719461877; cv=none; b=oytsAZx+XcvzpmlMx3b0rMBiiubxxuxp+ocvHfx0l+u+6WsMP6IEHPTOmPs3fl9yW0mJMv6HczQWo7DzsG2WF7Ug0sbxx827FRO+Qliy8y/i8p2TNL0ssGu3QOxxuCuTgbyX5gFi6GUgO37ZFPUUUJGPHyfLIVrx9fDfi10rgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719461877; c=relaxed/simple;
	bh=k5K0M+fBqUjzJ8pwUUP1swDP1a6+96Qi5H3wdBe1cds=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=WyCE/1AAsYT37A7wSQiKVsmuyS+aI2abKua3jbLK5gOalrNGJGqToATzOPrSo0yRpxDJxgGwkQWSPx6lljJSbIEHWuM+p3C1VT/taUIKQMYd4lj94JIwoCQaO63ct8DtbY2lhLlOonJ53zmRvFFrqKeXjg1RCW41Y5SDoXaJcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oehAH12s; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: ying.huang@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719461872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv/6QLcq34uXZKK1rKIo+VWeZS88eWcyBWQHYE3wee4=;
	b=oehAH12sBGRLubiO1vArFzwSmNpLPBzYrZxvPQmgc8oERPs0odUWNZGokbAcxNyXGmOpRX
	5l1ry8EduncN5wA3Ht3qgRN2Bxljy5+JrCLnUCnw+LuEQsV783aGG/C8gQC3j1Y4iBh19R
	+wGqaHYio5bmlSb4NT8RvbXcjg2UOOc=
X-Envelope-To: jonathan.cameron@huawei.com
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
Date: Thu, 27 Jun 2024 04:17:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Ho-Ren Chuang" <horen.chuang@linux.dev>
Message-ID: <6e4833165a6fc0dc94e9f2fe3f481be7233a86a5@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v1] memory tier: consolidate the initialization of memory
 tiers
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, "Gregory Price"
 <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com,
 tj@kernel.org, john@jagalactic.com, "Eishan Mirakhur"
 <emirakhur@micron.com>, "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>, "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Srinivasulu Thanneeru"
 <sthanneeru@micron.com>, "SeongJae Park" <sj@kernel.org>, "Rafael J. 
 Wysocki" <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>, "Andrew 
 Morton" <akpm@linux-foundation.org>, "Dave Jiang" <dave.jiang@intel.com>,
 "Dan Williams" <dan.j.williams@intel.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, "Ho-Ren (Jack)  Chuang"
 <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
In-Reply-To: <87v81xxvdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240621044833.3953055-1-horen.chuang@linux.dev>
 <87wmmezqx7.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d8a3664144e904d3a27dacb83febd8d00b95295f@linux.dev>
 <87v81xxvdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Migadu-Flow: FLOW_OUT

June 25, 2024 at 1:46 AM, "Huang, Ying" <ying.huang@intel.com> wrote:

Hi Huang, Ying,

I'm working on the v2 according to Andrew's and your feedback.

Thank you for your confirmation.

>=20
>=20"Ho-Ren Chuang" <horen.chuang@linux.dev> writes:
>=20
>=20>=20
>=20> June 24, 2024 at 1:27 AM, "Huang, Ying" <ying.huang@intel.com> wrot=
e:
> >=20
>=20>  Hi Huang, Ying,
> >=20
>=20>  Thanks for your feedback. Replies inlined.
> >=20
>=20> >=20
>=20> > Hi, Jack,
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  Thanks for patch!
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> writes:
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > If we simply move the set_node_memory_tier() from memory_tier_=
init() to
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > late_initcall(), it will result in HMAT not registering the
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > mt_adistance_algorithm callback function, because set_node_mem=
ory_tier()
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > is not performed during the memory tiering initialization phas=
e,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > leading to a lack of correct default_dram information.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Therefore, we introduced a nodemask to pass the information of=
 the
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > default DRAM nodes. The reason for not choosing to reuse
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > default_dram_type->nodes is that it is not clean enough. So in=
 the end,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > we use a __initdata variable, which is a variable that is rele=
ased once
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > initialization is complete, including both CPU and memory node=
s for HMAT
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > to iterate through.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Besides, since default_dram_type may be checked/used during th=
e
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > initialization process of HMAT and drivers, it is better to ke=
ep the
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > allocation of default_dram_type in memory_tier_init().
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com=
>
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
>=20>=20
>=20>  Thank you for your help with the input. Will add it in the v2.
> >=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > ---
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Hi all,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > The current memory tier initialization process is distributed =
across two
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > different functions, memory_tier_init() and memory_tier_late_i=
nit(). This
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > design is hard to maintain. Thus, this patch is proposed to re=
duce the
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > possible code paths by consolidating different initialization =
patches into one.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > The earlier discussion with Jonathan and Ying is listed here:
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.co=
m/
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > If we want to put these two initializations together, they mus=
t be placed
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > together in the later function. Because only at that time, the=
 HMAT information
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > will be ready, adist between nodes can be calculated, and memo=
ry tiering can be
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > established based on the adist. So we position the initializat=
ion at
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > memory_tier_init() to the memory_tier_late_init() call.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Moreover, it's natural to keep memory_tier initialization in d=
rivers at
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > device_initcall() level.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > This patchset is based on commits cf93be18fa1b and a72a30af550=
c:
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > [0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horen=
chuang@bytedance.com
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > [1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horen=
chuang@bytedance.com
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > [1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horen=
chuang@bytedance.com
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  It appears that you should switch the parts before and after "--=
-".
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  This is the real patch description, as pointed out by Andrew too=
.
> > >=20
>=20>=20
>=20>  Thank you for the suggestion. I plan to write the real patch descr=
iption in
> >=20
>=20>  the cover letter in the next version to avoid any misunderstanding=
.
> >=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > Thanks,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > Ho-Ren (Jack) Chuang
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > drivers/acpi/numa/hmat.c | 4 ++-
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > include/linux/memory-tiers.h | 6 ++++
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > mm/memory-tiers.c | 70 ++++++++++++++++++------------------
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > 3 files changed, 44 insertions(+), 36 deletions(-)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat=
.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > index 2c8ccc91ebe6..31a77a3324a8 100644
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > --- a/drivers/acpi/numa/hmat.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +++ b/drivers/acpi/numa/hmat.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -939,11 +939,13 @@ static int hmat_set_default_dram_perf(vo=
id)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > int nid, pxm;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > struct memory_target *target;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > struct access_coordinate *attrs;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + nodemask_t default_dram_nodes;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > if (!default_dram_type)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > return -EIO;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - for_each_node_mask(nid, default_dram_type->nodes) {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + default_dram_nodes =3D mt_get_default_dram_nodemask();
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + for_each_node_mask(nid, default_dram_nodes) {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  We don't need 'default_dram_type' in the function actually. It a=
ppears
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  that we can hide it in memory-tiers.c now?
> > >=20
>=20>=20
>=20>  Do you mean to remove the "if (!default_dram_type) return -EIO;" h=
ere?
> >=20
>=20>  If so, I agree, it's not used anymore here.
> >=20
>=20
> Yes.
>=20
>=20>=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > pxm =3D node_to_pxm(nid);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > target =3D find_mem_target(pxm);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > if (!target)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > diff --git a/include/linux/memory-tiers.h b/include/linux/memo=
ry-tiers.h
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > index 0d70788558f4..1567db7bd40e 100644
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > --- a/include/linux/memory-tiers.h
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +++ b/include/linux/memory-tiers.h
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -51,6 +51,7 @@ int mt_perf_to_adistance(struct access_coord=
inate *perf, int *adist);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > struct list_head *memory_types);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > void mt_put_memory_types(struct list_head *memory_types);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +nodemask_t mt_get_default_dram_nodemask(void);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > #ifdef CONFIG_MIGRATION
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > int next_demotion_node(int node);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *ta=
rgets);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -149,5 +150,10 @@ static inline struct memory_dev_type *mt_=
find_alloc_memory_type(int adist,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static inline void mt_put_memory_types(struct list_head *memor=
y_types)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > }
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +static inline nodemask_t mt_get_default_dram_nodemask(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +{
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + return NODE_MASK_NONE;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +}
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > #endif /* CONFIG_NUMA */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > #endif /* _LINUX_MEMORY_TIERS_H */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > index 6632102bd5c9..7d4b7f53dd8f 100644
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > --- a/mm/memory-tiers.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +++ b/mm/memory-tiers.c
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static LIST_HEAD(default_memory_types);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static struct node_memory_type_map node_memory_types[MAX_NUMNO=
DES];
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > struct memory_dev_type *default_dram_type;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +static nodemask_t default_dram_nodes __initdata =3D NODE_MASK=
_NONE;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static const struct bus_type memory_tier_subsys =3D {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > .name =3D "memory_tiering",
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -125,6 +126,11 @@ static inline struct memory_tier *to_memo=
ry_tier(struct device *device)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > return container_of(device, struct memory_tier, dev);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > }
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +nodemask_t __init mt_get_default_dram_nodemask(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +{
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + return default_dram_nodes;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +}
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  Why not just expose 'default_dram_nodes'?
> > >=20
>=20>=20
>=20>  I was thinking encapsulating it should be more systematic/structur=
al.
> >=20
>=20>  Do you think exposing it is better?
> >=20
>=20
> It doesn't help much to encapsulate with one line function. So, IMO,
>=20
>=20it's better just to expose it.
>=20
>=20>=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > static __always_inline nodemask_t get_memtier_nodemask(struct =
memory_tier *memtier)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > nodemask_t nodes =3D NODE_MASK_NONE;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -671,27 +677,38 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > * This is invoked via `late_initcall()` to initialize memory t=
iers for
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * CPU-less memory nodes after driver initialization, which i=
s
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * expected to provide `adistance` algorithms.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * memory nodes, both with and without CPUs. After the initia=
lization of
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * firmware and devices, adistance algorithms are expected to=
 be provided.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static int __init memory_tier_late_init(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > int nid;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + struct memory_tier *memtier;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > guard(mutex)(&memory_tier_lock);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * Look at all the existing and uninitialized N_MEMORY nodes =
and
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * add them to default memory tier or to a tier if we already=
 have
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * memory types assigned.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > for_each_node_state(nid, N_MEMORY) {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  During the function run, the node may change between N_MEMORY an=
d
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  !N_MEMORY in theory. So, it appears necessary to get/put_online_=
mems()
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  in the function?
> > >=20
>=20>=20
>=20>  Thanks for the catch. I will add get/put_online_mems().
> >=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > - /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * Some device drivers may have initialized memory tiers
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * between `memory_tier_init()` and `memory_tier_late_init()`=
,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * potentially bringing online memory nodes and
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * configuring memory tiers. Exclude them here.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - if (node_memory_types[nid].memtype)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - continue;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + if (!node_state(nid, N_CPU))
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  Why? I think that we should "continue" here even if node_state(n=
id,
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  N_CPU).
> > >=20
>=20>=20
>=20>  Do you mean no matter node_state(nid, N_CPU) or !node_state(nid, N=
_CPU),
> >=20
>=20>  as long as if (node_memory_types[nid].memtype) is true, we
> >=20
>=20>  should "continue"?
> >=20
>=20>  I think you are right, at this moment, we only care if the
> >=20
>=20>  node_memory_types[nid].memtype is set or not.
> >=20
>=20>  If not, we should set it here. If yes, we should continue.
> >=20
>=20>  If my understanding is correct, I will fix it in the v2.
> >=20
>=20
> Yes. That's my opinion too.
>=20
>=20>=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > + /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * Some device drivers may have initialized
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * memory tiers, potentially bringing memory nodes
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * online and configuring memory tiers.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * Exclude them here.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + if (node_memory_types[nid].memtype)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + continue;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - set_node_memory_tier(nid);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + memtier =3D set_node_memory_tier(nid);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + if (IS_ERR(memtier))
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * Continue with memtiers we are able to setup.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + break;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > }
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > -
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > establish_demotion_targets();
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > return 0;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -876,7 +893,6 @@ static int __meminit memtier_hotplug_callb=
ack(struct notifier_block *self,
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > static int __init memory_tier_init(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > int ret, node;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - struct memory_tier *memtier;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > ret =3D subsys_virtual_register(&memory_tier_subsys, NULL);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > if (ret)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -887,7 +903,8 @@ static int __init memory_tier_init(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > GFP_KERNEL);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > WARN_ON(!node_demotion);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > #endif
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - mutex_lock(&memory_tier_lock);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > +
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + guard(mutex)(&memory_tier_lock);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > * For now we can have 4 faster memory tiers with smaller adist=
ance
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > * than default DRAM tier.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > @@ -898,28 +915,11 @@ static int __init memory_tier_init(void)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > panic("%s() failed to allocate default DRAM tier\n", __func__)=
;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  >=20
>=20> >=20
>=20> >  > /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * Look at all the existing N_MEMORY nodes and add them to
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * default memory tier or to a tier if we already have memory
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * types assigned.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + * Record nodes with memory and CPU to set default DRAM perfo=
rmance.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  For one line comments, we can use
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  /* Record nodes with memory and CPU to set default DRAM performa=
nce. */
> > >=20
>=20>=20
>=20>  Thank you for the guidance. Will fix in the v2.
> >=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > - for_each_node_state(node, N_MEMORY) {
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - if (!node_state(node, N_CPU))
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * Defer memory tier initialization on
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * CPUless numa nodes. These will be initialized
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * after firmware and devices are initialized.
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - continue;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > -
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - memtier =3D set_node_memory_tier(node);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - if (IS_ERR(memtier))
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - /*
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - * Continue with memtiers we are able to setup
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - */
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - break;
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - }
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - establish_demotion_targets();
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > - mutex_unlock(&memory_tier_lock);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + for_each_node_state(node, N_MEMORY)
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + if (node_state(node, N_CPU))
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > + node_set(node, default_dram_nodes);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >=20=20
>=20> >=20
>=20> >  Why not use
> > >=20
>=20> >=20=20
>=20> >=20
>=20> >  nodes_andnot(default_dram_nodes, node_states[N_MEMORY], node_sta=
tes[N_CPU]);
> > >=20
>=20>=20
>=20>  Instead of using nodes_andnot(), should nodes_and() be correct? be=
cause we wanna
> >=20
>=20>  record the nodes that are both N_MEMORY and N_CPU.
> >=20
>=20
> Oh, Yes, you are right.
>=20
>=20>=20
>=20> >=20
>=20> > >=20
>=20> >=20
>=20> >  > hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTP=
LUG_PRI);
> > >=20
>=20> >  >=20
>=20> >=20
>=20> >  > return 0;
> > >=20
>=20> >  >
> > >
> >=20
>=20
> --
>=20
>=20Best Regards,
>=20
>=20Huang, Ying
>

--
Best Regards,
Ho-Ren (Jack) Chuang

