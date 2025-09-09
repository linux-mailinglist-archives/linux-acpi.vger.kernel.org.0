Return-Path: <linux-acpi+bounces-16528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F3FB4AA2D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 12:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6665618877C3
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Sep 2025 10:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822C31CA59;
	Tue,  9 Sep 2025 10:14:32 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716BA31A573;
	Tue,  9 Sep 2025 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412872; cv=none; b=TQttMfR0rY9FBjEXKvThbbHODQScO1A+d5PHWr0153tRYBjS6z1jQYFD9rv/vzZz7OpV5jX38w2Y9GCMFF5KjH4dN88gm7ZLGqOPeQffS3OeTqxX7rxy8M7p5O9EOfPST6XCmgEDs5EIYiv/ZXL06UfzjV48X+c6/ND1JE7GG7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412872; c=relaxed/simple;
	bh=ym80XdqDh0Lyk6nkO25aoerkSsuVfLPsaJi31FE8O70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5SAFiHxoJbeURjU75th6b7ZrGXbwtO7Ju6sE/PpkU5p13LeC5/2pkI86zCA2ReSd7xAAo/qyAMtDVGWlaUUInQy1eBFmM5Jk7Zkr3LHnfE2N75udE+5t7Ym6TtevqQqQlxa/6BTL8LJ899P7xjbupobAUlaflCnT7T2j8RoBog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BEA6113E;
	Tue,  9 Sep 2025 03:14:21 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013613F66E;
	Tue,  9 Sep 2025 03:14:23 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:14:20 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>, Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
	baisheng.gao@unisoc.com,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
	Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 06/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
Message-ID: <aL/9/KSH35ou8Mgj@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-7-james.morse@arm.com>
 <aK7ju2caTjqf1+VN@e133380.arm.com>
 <2e4c3c00-b248-421e-8ff1-d24b7b03be1a@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e4c3c00-b248-421e-8ff1-d24b7b03be1a@arm.com>

Hi,

On Thu, Aug 28, 2025 at 04:58:16PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 11:53, Dave Martin wrote:
> > On Fri, Aug 22, 2025 at 03:29:47PM +0000, James Morse wrote:
> >> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> >>
> >> The driver needs to know which CPUs are associated with the cache,
> >> the CPUs may not all be online, so cacheinfo does not have the
> >> information.
> > 
> > Nit: cacheinfo lacking the information is not a consequence of the
> > driver needing it.
> > 
> > Maybe split the sentence:
> > 
> > -> "[...] associated with the cache. The CPUs may not [...]"
> 
> Sure,

OK

> >> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >> index 660457644a5b..cb93a9a7f9b6 100644
> >> --- a/drivers/acpi/pptt.c
> >> +++ b/drivers/acpi/pptt.c
> >> @@ -971,3 +971,65 @@ int find_acpi_cache_level_from_id(u32 cache_id)

[...]

> >> + * acpi_pptt_get_cpumask_from_cache_id() - Get the cpus associated with the
> >> + *					   specified cache
> >> + * @cache_id: The id field of the unified cache
> >> + * @cpus: Where to build the cpumask
> >> + *
> >> + * Determine which CPUs are below this cache in the PPTT. This allows the property
> >> + * to be found even if the CPUs are offline.
> >> + *
> >> + * The PPTT table must be rev 3 or later,
> >> + *
> >> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
> >> + * Otherwise returns 0 and sets the cpus in the provided cpumask.
> >> + */
> >> +int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id, cpumask_t *cpus)
> >> +{

[...]

> >> +	/*
> >> +	 * If we found the cache first, we'd still need to walk from each cpu.
> >> +	 */
> >> +	for_each_possible_cpu(cpu) {

[...]

> > Again, it feels like we are repeating the same walk multiple times to
> > determine how deep the table is (on which point the table is self-
> > describing anyway), and then again to derive some static property, and
> > then we are then doing all of that work multiple times to derive
> > different static properties, etc.
> > 
> > Can we not just walk over the tables once and stash the derived
> > properties somewhere?
> 
> That is possible - but its a more invasive change to the PPTT parsing code.
> Before the introduction of the leaf flag, the search for a processor also included a
> search to check if the discovered node was a leaf.
> 
> I think this is trading time - walking over the table multiple times, against the memory
> you'd need to de-serialise the tree to find the necessary properties quickly. I think the
> reason Jeremy L went this way was because there may never be another request into this
> code, so being ready with a quick answer was a waste of memory.
> 
> MPAM doesn't change this - all these things are done up front during driver probing, and
> the values are cached by the driver.

I guess that's true.

> > I'm still getting my head around this parsing code, so I'm not saying
> > that the approach is incorrect here -- just wondering whether there is
> > a way to make it simpler.
> 
> It's walked at boot, and on cpu-hotplug. Neither are particularly performance critical.

Do we do this only for unknown late secondaries (e.g., that haven't
previously come online?)  I haven't gone to track this down but, if not,
this cuts across the assertion that "there may never be another request
into this code".

cpu hotlug is slow in practice, but gratuitous cost on this path should
still be avoided where feasible.

> I agree that as platforms get bigger, there will be a tipping point ... I don't think
> anyone has complained yet!

Ack -- when in ACPI, do as the ACPI folks do, I guess.

Cheers
---Dave

