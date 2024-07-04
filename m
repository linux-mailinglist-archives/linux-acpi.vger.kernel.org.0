Return-Path: <linux-acpi+bounces-6770-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E3D927B9C
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 19:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C8F1F263C0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 17:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4D1B4C26;
	Thu,  4 Jul 2024 17:08:30 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6D91B375B;
	Thu,  4 Jul 2024 17:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112910; cv=none; b=RYWlCdseXGYRhHrcoBOgoKNqyZgYpE2y3xhfRL7KzjPfsmqPSBOUJn07apiVEvBMaZevNsWbCLmce9LaMCyuVLbTRCNtGu6aQGoEi1P2M4MbPCsxcISlxx1lE/W8ngSV905bt+Mos69i3Qi3IklGvsWuUwTTtqqvMETXLUFze4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112910; c=relaxed/simple;
	bh=QiLJeBMBiVux1LfvRktK0NFIY7T3PnMvUz3RB/H8SM4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sk4NnhrUn6lHgVmH1maRbl68LvR3S5marA0g/q+Peo5jJG7j+a8KZUgIvVmorbKp/60nwbxmUIx6ftENddKEAmuw4bZKNsRLrJXEx4CDYJ3hskkbaBvtIVcbqUtPtfMZGeWlSnX3KBtxVP+uPwLeH4M4yo4ITVe8qEO7SBRPTjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNP12qNzz67Hm8;
	Fri,  5 Jul 2024 01:07:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C7BFF14065C;
	Fri,  5 Jul 2024 01:08:24 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:08:24 +0100
Date: Thu, 4 Jul 2024 18:08:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>,
	"SeongJae  Park" <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>,
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
  Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
	<horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704180823.0000212d@Huawei.com>
In-Reply-To: <84b43294411bb1fe0ed58f2da59abf554ef48f7d@linux.dev>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
	<20240628060925.303309-2-horen.chuang@linux.dev>
	<20240702142535.00003dc0@Huawei.com>
	<84b43294411bb1fe0ed58f2da59abf554ef48f7d@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


Hi,

> > > 
> > >  static int __init memory_tier_init(void)
> > > 
> > >  {
> > > 
> > >  - int ret, node;
> > > 
> > >  - struct memory_tier *memtier;
> > > 
> > >  + int ret;
> > > 
> > >  
> > > 
> > >  ret = subsys_virtual_register(&memory_tier_subsys, NULL);
> > > 
> > >  if (ret)
> > > 
> > >  @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
> > > 
> > >  GFP_KERNEL);
> > > 
> > >  WARN_ON(!node_demotion);
> > > 
> > >  #endif
> > > 
> > >  - mutex_lock(&memory_tier_lock);
> > > 
> > >  +
> > > 
> > >  + guard(mutex)(&memory_tier_lock);
> > >   
> > 
> > If this was safe to do without the rest of the change (I think so)
> > 
> > then better to pull that out as a trivial precursor so less noise
> > 
> > in here.
> >   
> 
> Do you mean instead of using guard(mutex)(),
> use mutex_lock() as it was? or?
> 

Code as here, but possibly pull the guard(mutex) part out as
a patch 1 as it's an unrelated improvement to the rest of the set
which would be in patch 2.

Not particularly important though as you've sent a v3 in the
meantime and it's fine to have it in one patch.

> > > 
> > > /*
> > > 
> > >  * For now we can have 4 faster memory tiers with smaller adistance
> > > 
> > >  * than default DRAM tier.
> > > 
> > >  @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
> > > 
> > >  if (IS_ERR(default_dram_type))
> > > 
> > >  panic("%s() failed to allocate default DRAM tier\n", __func__);
> > > 
> > >  
> > > 
> > >  - /*
> > > 
> > >  - * Look at all the existing N_MEMORY nodes and add them to
> > > 
> > >  - * default memory tier or to a tier if we already have memory
> > > 
> > >  - * types assigned.
> > > 
> > >  - */
> > > 
> > >  - for_each_node_state(node, N_MEMORY) {
> > > 
> > >  - if (!node_state(node, N_CPU))
> > > 
> > >  - /*
> > > 
> > >  - * Defer memory tier initialization on
> > > 
> > >  - * CPUless numa nodes. These will be initialized
> > > 
> > >  - * after firmware and devices are initialized.
> > > 
> > >  - */
> > > 
> > >  - continue;
> > > 
> > >  -
> > > 
> > >  - memtier = set_node_memory_tier(node);
> > > 
> > >  - if (IS_ERR(memtier))
> > > 
> > >  - /*
> > > 
> > >  - * Continue with memtiers we are able to setup
> > > 
> > >  - */
> > > 
> > >  - break;
> > > 
> > >  - }
> > > 
> > >  - establish_demotion_targets();
> > > 
> > >  - mutex_unlock(&memory_tier_lock);
> > > 
> > >  + /* Record nodes with memory and CPU to set default DRAM performance. */
> > > 
> > >  + nodes_and(default_dram_nodes, node_states[N_MEMORY],
> > > 
> > >  + node_states[N_CPU]);
> > >   
> > 
> > There are systems where (for various esoteric reasons, such as describing an
> > 
> > association with some other memory that isn't DRAM where the granularity
> > 
> > doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> > 
> > Handling that can be a job for another day though.
> >   
> 
> Thank you for informing me of this situation.
> Sounds like handling that also requires a mapping table between
> the CPU and the corresponding DRAM.

I've not yet looked at how it interacts with this, but
from an ACPI point of view it's just 'near' in SLIT and
HMAT.  The nearest thing to a description is
Memory Proximity Domain Attributes structures in HMAT.
That allows you to describe the location of the memory
controller, but in this type of system there may be
a many to 1 mapping (interleaving across memory controllers
in some CPU only nodes) for example.

Anyhow, guess I need to spin up some emulated machines and
see what breaks :)

Jonathan

