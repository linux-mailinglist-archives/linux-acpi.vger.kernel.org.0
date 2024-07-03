Return-Path: <linux-acpi+bounces-6753-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318599255EF
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 10:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6349B1C217AB
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Jul 2024 08:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70213B599;
	Wed,  3 Jul 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHa7f4Zn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3197A13B29F;
	Wed,  3 Jul 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996819; cv=none; b=ufIyrta4i+LHkw1BGIGQ/ygH8/tMMUr8POSnOn5A43eY02JW5vSqR1VGW0QgyfVDcmWMdUqDKQNrK+0MqyXNi5difZUMI6e5mhUqYAVsb07N80rJYWxhUmTygpGLYT8i/PeXl7Hbhs26dEt+Wo/JBNYTir/noBeRxYKqenmw/q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996819; c=relaxed/simple;
	bh=uJy6npIbvFhICTmqeRyyXfHKUe2Xu5teyWK4mPdnf60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E3U5Y7+tlNYELH6EjJm4pdcPc3D8neyml+JOUUKOwGj0HHiZ2Z6XiUMtz44dh62kbpw6GOpEc1tQ7C/m0yEkAjT/tqYHiBWVfvwYgEL14xnyRoHTC6eqtyKqhalrGWNEW8GrEBNPLP03Xx00N5C6cd/YRNyZ5ZGPL4mUsyFBHBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHa7f4Zn; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719996817; x=1751532817;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=uJy6npIbvFhICTmqeRyyXfHKUe2Xu5teyWK4mPdnf60=;
  b=eHa7f4ZnhLALGa9tUV6UJHkwmnWMf0aDsTb+Xr4JAv1c9CW8DWGTKgny
   k4All4eSziET0832k7b1Xq7luAHwcqigqhvg57Fci0h9hetf7+dGAjCvw
   pBHuX/kqGhhbwJO+NEF1+qrAOgc0GyvV+zg/efBO9DBDXk+H++3aJ/xUN
   lRorR9e7Zk7Q1uXrQ08TJjUkRcuJXoutq0K6FjPAvikO4mJzh2koaPpp8
   P3Dbe+7Q4Go2RQ4TYQ9UPRTg/o+lvQo4dnNtzeJaPKh4+RGeCQAgux3GS
   Gdv5bnyA+Nxsk9B4qTTZevQOC4YYgjI0W1EYdELlkEOOKtzVFpNdTrQp/
   w==;
X-CSE-ConnectionGUID: 7CGM4lhAS2a7NizhwIac+A==
X-CSE-MsgGUID: dOitDEatTra5Z2Sra93a+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27818576"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="27818576"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 01:53:36 -0700
X-CSE-ConnectionGUID: TNLyrCPHR5SOEUdQfrNb3w==
X-CSE-MsgGUID: b4l4Pq1yTnWXfVH4a1AjFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="50633629"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 01:53:31 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>,  Gregory Price
 <gourry.memverge@gmail.com>,  <aneesh.kumar@linux.ibm.com>,
  <mhocko@suse.com>,  <tj@kernel.org>,  <john@jagalactic.com>,  Eishan
 Mirakhur <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
  Alistair Popple <apopple@nvidia.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  SeongJae Park <sj@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  "Len Brown" <lenb@kernel.org>,  Andrew
 Morton <akpm@linux-foundation.org>,  "Dave Jiang" <dave.jiang@intel.com>,
  Dan Williams <dan.j.williams@intel.com>,  <linux-acpi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mm@kvack.org>,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>,  <linux-cxl@vger.kernel.org>,
  <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 1/1] memory tier: consolidate the initialization of
 memory tiers
In-Reply-To: <20240702142535.00003dc0@Huawei.com> (Jonathan Cameron's message
	of "Tue, 2 Jul 2024 14:25:35 +0100")
References: <20240628060925.303309-1-horen.chuang@linux.dev>
	<20240628060925.303309-2-horen.chuang@linux.dev>
	<20240702142535.00003dc0@Huawei.com>
Date: Wed, 03 Jul 2024 16:51:40 +0800
Message-ID: <87a5iykgdf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 28 Jun 2024 06:09:23 +0000
> "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> wrote:

[snip]

>> @@ -875,8 +886,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>>  
>>  static int __init memory_tier_init(void)
>>  {
>> -	int ret, node;
>> -	struct memory_tier *memtier;
>> +	int ret;
>>  
>>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
>>  	if (ret)
>> @@ -887,7 +897,8 @@ static int __init memory_tier_init(void)
>>  				GFP_KERNEL);
>>  	WARN_ON(!node_demotion);
>>  #endif
>> -	mutex_lock(&memory_tier_lock);
>> +
>> +	guard(mutex)(&memory_tier_lock);
>
> If this was safe to do without the rest of the change (I think so)
> then better to pull that out as a trivial precursor so less noise
> in here.
>
>>  	/*
>>  	 * For now we can have 4 faster memory tiers with smaller adistance
>>  	 * than default DRAM tier.
>> @@ -897,29 +908,9 @@ static int __init memory_tier_init(void)
>>  	if (IS_ERR(default_dram_type))
>>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>>  
>> -	/*
>> -	 * Look at all the existing N_MEMORY nodes and add them to
>> -	 * default memory tier or to a tier if we already have memory
>> -	 * types assigned.
>> -	 */
>> -	for_each_node_state(node, N_MEMORY) {
>> -		if (!node_state(node, N_CPU))
>> -			/*
>> -			 * Defer memory tier initialization on
>> -			 * CPUless numa nodes. These will be initialized
>> -			 * after firmware and devices are initialized.
>> -			 */
>> -			continue;
>> -
>> -		memtier = set_node_memory_tier(node);
>> -		if (IS_ERR(memtier))
>> -			/*
>> -			 * Continue with memtiers we are able to setup
>> -			 */
>> -			break;
>> -	}
>> -	establish_demotion_targets();
>> -	mutex_unlock(&memory_tier_lock);
>> +	/* Record nodes with memory and CPU to set default DRAM performance. */
>> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
>> +		  node_states[N_CPU]);
>
> There are systems where (for various esoteric reasons, such as describing an
> association with some other memory that isn't DRAM where the granularity
> doesn't match) the CPU nodes contain no DRAM but rather it's one node away.
> Handling that can be a job for another day though.
>
> Why does this need to be computed here?  Why not do it in
> hmat_set_default_dram_perf? Doesn't seem to be used anywhere else.

IMO, which node is default dram node is a general concept instead of
HMAT specific.  So, I think that it's better to decide that in the
general code (memory-tiers.c).

>>  
>>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>>  	return 0;

--
Best Regards,
Huang, Ying

