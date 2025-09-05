Return-Path: <linux-acpi+bounces-16420-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D96BB45E1D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 18:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741465C3D49
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Sep 2025 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8017302170;
	Fri,  5 Sep 2025 16:27:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BA631D750;
	Fri,  5 Sep 2025 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757089640; cv=none; b=noVbiy8rAY2HRSyCUE7nkfkGLqKjhH1SmJhUjm/TvpbZ+xIUiwwNYbUcGv0FluTXXdEq737+1egRfHK7K/MmTeIVu2HRqept9IW8qgOTNIZ2QxVchmSlpuccRfjuJOmjS+JySSoCgkK56XbDoyz7HOwYkG2CdacKXADOzPGSGC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757089640; c=relaxed/simple;
	bh=v/S/LJTOi6ZyryPMzGyn1/L7NYUSdlZ0YVbue83lmz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVyXX2C5DmldK7MhLKbL8qvVMrzzD0fFHHd9QZK1BM55EOAGH7oskGKHB2ajNC2IlhtugomeEcpBT87p2QSIsx+4fzTqV5YnjYKiYBN/7sAntRiVctV7Gur144P2CD0Yw6RcoB7FXRPer7aVSbevUn8xeLW/ZZ/9sTTb5fSDLis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6141152B;
	Fri,  5 Sep 2025 09:27:08 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.68])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4A4F83F63F;
	Fri,  5 Sep 2025 09:27:11 -0700 (PDT)
Date: Fri, 5 Sep 2025 17:27:08 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
	shameerali.kolothum.thodi@huawei.com,
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
Subject: Re: [PATCH 05/33] ACPI / PPTT: Find cache level by cache-id
Message-ID: <aLsPXFI4VuueQVXM@e133380.arm.com>
References: <20250822153048.2287-1-james.morse@arm.com>
 <20250822153048.2287-6-james.morse@arm.com>
 <aK7jEMqM/FoB4ABW@e133380.arm.com>
 <cc4881e8-5d90-4992-8cbf-650ea2efa5ca@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc4881e8-5d90-4992-8cbf-650ea2efa5ca@arm.com>

Hi James,

On Thu, Aug 28, 2025 at 04:58:05PM +0100, James Morse wrote:
> Hi Dave,
> 
> On 27/08/2025 11:50, Dave Martin wrote:
> > Hi,
> > 
> > On Fri, Aug 22, 2025 at 03:29:46PM +0000, James Morse wrote:
> >> The MPAM table identifies caches by id. The MPAM driver also wants to know
> >> the cache level to determine if the platform is of the shape that can be
> >> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> >> are online.
> >>
> >> Waiting for all CPUs to come online is a problem for platforms where
> >> CPUs are brought online late by user-space.
> >>
> >> Add a helper that walks every possible cache, until it finds the one
> >> identified by cache-id, then return the level.
> >> Add a cleanup based free-ing mechanism for acpi_get_table().
> 
> > Does this mean that the early secondaries must be spread out across the
> > whole topology so that everything can be probed?
> >
> > (i.e., a random subset is no good?)
> 
> For the mpam driver - it needs to see each cache with mpam hardware, which means a CPU
> associated with each cache needs to be online. Random is fine - provided you get lucky.

"Fine" = "not dependent on luck".  So, random is not fine.

> > If so, is this documented somewhere, such as in booting.rst?
> 
> booting.rst is for the bootloader.
> Late secondaries is a bit of a niche sport, I've only seen it commonly done in VMs.
> Most platforms so far have their MPAM controls on a global L3, so this requirement doesn't
> make much of a difference.
> 
> The concern is that if resctrl gets probed after user-space has started, whatever
> user-space service is supposed to set it up will have concluded its not supported. Working
> with cache-ids for offline CPUs means you don't have to bring all the CPUs online - only
> enough so that every piece of hardware is reachable.
> 
> 
> > Maybe this is not a new requirement -- it's not an area that I'm very
> > familiar with.
> 
> Hard to say - its a potentially surprising side effect of glomming OS accessible registers
> onto the side of hardware that can be automatically powered off. (PSCI CPU_SUSPEND).
> 
> I did try getting cacheinfo to populate all the CPUs at boot, regardless of whether they
> were online. Apparently that doesn't work for PowerPC where the properties of CPUs can
> change while they are offline. (presumably due to RAS or a firmware update)

So, it sounds like there is a requirement, but we don't document it,
and if the requirement is not met then the user is presented with an
obscure failure in the MPAM driver.  This seems a bit unhelpful?

I'm not saying booting.rst is the right place for this -- maybe the
appropriate document doesn't exist yet.

I wonder whether the required property is reasonable and general enough
that it should be treated as a kernel boot requirement.

Or, we require caches to be symmetric for non-early CPUs and reject
those that don't match when they try to come online (similarly to
the way cpufeatures deals with mismatches).


> >> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> >> index 8f9b9508acba..660457644a5b 100644
> >> --- a/drivers/acpi/pptt.c
> >> +++ b/drivers/acpi/pptt.c
> >> @@ -907,3 +907,67 @@ int find_acpi_cpu_topology_hetero_id(unsigned int cpu)
> >>  	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
> >>  					  ACPI_PPTT_ACPI_IDENTICAL);
> >>  }
> >> +
> >> +/**
> >> + * find_acpi_cache_level_from_id() - Get the level of the specified cache
> >> + * @cache_id: The id field of the unified cache
> >> + *
> >> + * Determine the level relative to any CPU for the unified cache identified by
> >> + * cache_id. This allows the property to be found even if the CPUs are offline.
> >> + *
> >> + * The returned level can be used to group unified caches that are peers.
> >> + *
> >> + * The PPTT table must be rev 3 or later,
> >> + *
> >> + * If one CPUs L2 is shared with another as L3, this function will return
> >> + * an unpredictable value.
> >> + *
> >> + * Return: -ENOENT if the PPTT doesn't exist, or the cache cannot be found.
> > 
> > Nit: doesn't exist or its revision is too old.
> 
> ... its not old, but there is no published spec for that revision... unsupported?

That seems OK, say,

	"... if the PPTT doesn't exist or has an unsupported format, or ..."


> >> + * Otherwise returns a value which represents the level of the specified cache.
> >> + */
> >> +int find_acpi_cache_level_from_id(u32 cache_id)
> >> +{
> >> +	u32 acpi_cpu_id;
> >> +	int level, cpu, num_levels;
> >> +	struct acpi_pptt_cache *cache;
> >> +	struct acpi_pptt_cache_v1 *cache_v1;
> >> +	struct acpi_pptt_processor *cpu_node;
> >> +	struct acpi_table_header *table __free(acpi_table) = acpi_get_table_ret(ACPI_SIG_PPTT, 0);
> 
> > acpi_get_pptt() ? (See comment on patch 3.)
> 
> Yup,
> 
> > Comments there also suggest that the acpi_put_table() may be
> > unnecessary, at least on some paths.
> > 
> > I haven't tried to understand the ins and outs of this.
> 
> It's grabbing one reference and using it for everything, because it needs to 'map' the
> table in atomic context due to cpuhp, but can't.
> Given how frequently its used, there is no problem just leaving it mapped.

That's rather what I thought -- in which case we can use it (as you
already concluded, by the looks of it).

> >> +
> >> +	if (IS_ERR(table))
> >> +		return PTR_ERR(table);
> >> +
> >> +	if (table->revision < 3)
> >> +		return -ENOENT;
> >> +
> >> +	/*
> >> +	 * If we found the cache first, we'd still need to walk from each CPU
> >> +	 * to find the level...
> >> +	 */
> 
> > ^ Possibly confusing comment?  The cache id is the starting point for
> > calling this function.  Is there a world in which we are at this point
> > without first having found the cache node?
> > 
> > (If the comment is just a restatement of part of the kerneldoc
> > description, maybe just drop it.)
> 
> It's describing the alternate world where the table is searched to find the cache first,
> but then we'd still need to walk the table another NR_CPUs times, which can't be avoided.
> I'll drop it - it was justifying why its done this way round...

Oh, I see, this is "if the code had been written in such-and-such a way",
not "if such-and-such a runtime precondition is met" ?

The comment can be read both ways, as it stands.

> 
> >> +	for_each_possible_cpu(cpu) {
> >> +		acpi_cpu_id = get_acpi_id_for_cpu(cpu);
> >> +		cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
> >> +		if (!cpu_node)
> >> +			return -ENOENT;
> >> +		num_levels = acpi_count_levels(table, cpu_node, NULL);
> > 
> > Is the initial call to acpi_count_levels() really needed here?
> > 
> > It feels a bit like we end up enumerating the whole topology two or
> > three times here; once to count how many levels there are, and then
> > again to examine the nodes, and once more inside acpi_find_cache_node().
> > 
> > Why can't we just walk until we run out of levels?
> 
> This is looking for a unified cache - and we don't know where those start.
> We could walk the first 100 caches, and stop once we start getting unified caches, then
> they stop again ... but this seemed simpler.

I'm still a bit confused.

We start at level one, and then trace parents until we hit a unified
cache or run out of levels.

Why do we need to know a priori how many levels there are, when the
way to determine that is part of the same procedure we're already doing
(i.e., start at level one and trace parents until we run out of levels)?

> > I may be missing some details of how these functions interact -- if
> > this is only run at probe time, compact, well-factored code is
> > more important than making things as fast as possible.

(This still stands.)


> >> diff --git a/include/linux/acpi.h b/include/linux/acpi.h

[...]

> >> @@ -221,6 +222,17 @@ void acpi_reserve_initial_tables (void);
> >>  void acpi_table_init_complete (void);
> >>  int acpi_table_init (void);
> >>  
> >> +static inline struct acpi_table_header *acpi_get_table_ret(char *signature, u32 instance)
> >> +{
> >> +	struct acpi_table_header *table;
> >> +	int status = acpi_get_table(signature, instance, &table);
> >> +
> >> +	if (ACPI_FAILURE(status))
> >> +		return ERR_PTR(-ENOENT);
> >> +	return table;
> >> +}
> 
> > This feels like something that ought to exist already.  If not, why
> > not?  If so, are there open-coded versions of this spread around the
> > ACPI tree that should be ported to use it?
> 
> 
> It's a cleanup idiom helper that lets the compiler do this automagically - but its moot as
> its not going to be needed in the pptt because of the acpi_get_pptt() thing.

Ah, OK.

Cheers
---Dave

