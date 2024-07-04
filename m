Return-Path: <linux-acpi+bounces-6771-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5464F927BBA
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 19:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DDE728A1D0
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 17:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB21B47A9;
	Thu,  4 Jul 2024 17:09:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DC1B3F17;
	Thu,  4 Jul 2024 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112998; cv=none; b=YtGgbAHGxvo2CfNZAvQ+NffutKxg6AYYs5tXUIKsD6HEzVxXXwcmSnP9kUdUjG+andZaWRSeLf59wuM1MeSP7Q1ubZTsYC/lygMHGfIgTQeHS6kGSzdot+j72dWQ5+z8lMXz47ox3W7h/WNr5s8zglvf5XO2f8VDtck6WhGYKL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112998; c=relaxed/simple;
	bh=frySLW9WK5lcKmyMrKvNoMAZcvRUcfhaaX2Jqmlm1VE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NU290htDjzdvkoVKwgVBdblM/EW8NfQKJKkSJfF7MzkYtmbvtIlzjto2BbvBIiUHL5Tz1FNm8t3X2m5Tm6HhZDEUhynLV4s9YcX9IaDdoDeD3ADeA8H3BOYBmt4uCBPRwhjbw/CjwKFHsW+p9YMmQtzj9ahkIxmjY/zuV5A6vSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFNPp2RmKz6K9Kr;
	Fri,  5 Jul 2024 01:07:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C0523140C72;
	Fri,  5 Jul 2024 01:09:52 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Jul
 2024 18:09:52 +0100
Date: Thu, 4 Jul 2024 18:09:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Huang, Ying" <ying.huang@intel.com>
CC: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>, Gregory Price
	<gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>,
	<tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
	<emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
	Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
	<apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown
	<lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Dave Jiang
	<dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@bytedance.com>, "Ho-Ren (Jack) Chuang"
	<horenchuang@gmail.com>, <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
Message-ID: <20240704180951.00005ca6@Huawei.com>
In-Reply-To: <87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240628060925.303309-1-horen.chuang@linux.dev>
	<20240628060925.303309-2-horen.chuang@linux.dev>
	<20240702142535.00003dc0@Huawei.com>
	<87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

On Wed, 03 Jul 2024 16:51:40 +0800
"Huang, Ying" <ying.huang@intel.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
> > On Fri, 28 Jun 2024 06:09:23 +0000
> > "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:  
> 
> [snip]
> 
> >> @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
> >>  
> >>  static int __init memory_tier_init(void)
> >>  {
> >> -	int ret, node;
> >> -	struct memory_tier *memtier;
> >> +	int ret;
> >>  
> >>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
> >>  	if (ret)
> >> @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
> >>  				GFP_KERNEL);
> >>  	WARN_ON(!node_demotion);
> >>  #endif
> >> -	mutex_lock(&memory_tier_lock);
> >> +
> >> +	guard(mutex)(&memory_tier_lock);  
> >
> > If this was safe to do without the rest of the change (I think so)
> > then better to pull that out as a trivial precursor so less noise
> > in here.
> >  
> >>  	/*
> >>  	 * For now we can have 4 faster memory tiers with smaller adistance
> >>  	 * than default DRAM tier.
> >> @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
> >>  	if (IS_ERR(default_dram_type))
> >>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
> >>  
> >> -	/*
> >> -	 * Look at all the existing N_MEMORY nodes and add them to
> >> -	 * default memory tier or to a tier if we already have memory
> >> -	 * types assigned.
> >> -	 */
> >> -	for_each_node_state(node, N_MEMORY) {
> >> -		if (!node_state(node, N_CPU))
> >> -			/*
> >> -			 * Defer memory tier initialization on
> >> -			 * CPUless numa nodes. These will be initialized
> >> -			 * after firmware and devices are initialized.
> >> -			 */
> >> -			continue;
> >> -
> >> -		memtier = set_node_memory_tier(node);
> >> -		if (IS_ERR(memtier))
> >> -			/*
> >> -			 * Continue with memtiers we are able to setup
> >> -			 */
> >> -			break;
> >> -	}
> >> -	establish_demotion_targets();
> >> -	mutex_unlock(&memory_tier_lock);
> >> +	/* Record nodes with memory and CPU to set default DRAM performance. */
> >> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
> >> +		  node_states[N_CPU]);  
> >
> > There are systems where (for various esoteric reasons, such as describing an
> > association with some other memory that isn't DRAM where the granularity
> > doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> > Handling that can be a job for another day though.
> >
> > Why does this need to be computed here?  Why not do it in
> > hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.  
> 
> IMO, which node is default dram node is a general concept instead of
> HMAT specific.  So, I think that it's better to decide that in the
> general code (memory-tiers.c).

That makes sense given I'd imagine this will spread to other firmware
types in time.

Thanks,

Jonathan

> 
> >>  
> >>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
> >>  	return 0;  
> 
> --
> Best Regards,
> Huang, Ying
> 


