Return-Path: <linux-acpi+bounces-5897-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876FB8C9CAF
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 13:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAAB61C21222
	for <lists+linux-acpi@lfdr.de>; Mon, 20 May 2024 11:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926F50A72;
	Mon, 20 May 2024 11:53:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA37446D1;
	Mon, 20 May 2024 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716206020; cv=none; b=hK5JgGJtslgTkN3ZsBBmBnDi5rx8K6ee1OAYdDY46GzI1sKr9WhwXToCxNm/XXYdQzX5mrWF2GNBTgyQ4+SKsVGUTihGyxwpap4tCNxup0K1LX5Y9q3blzfdX0olcJ03TOobuviz0uL2q5Dg8AxOrNiAiWtzf90GkMnLIO9FRyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716206020; c=relaxed/simple;
	bh=7PzAJ7WK1OWB/iiGIEkm76T7XM5AHbDcgmZcZuP+7ew=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ueStF3EYej+xBh+ccpHN1hOWP2dXdkAHxMdWY/CW1Yjy2Fn72SeYY49KQZP4MQz2BH3Ctx/sYWkVMmpM2XZFq20owRI7vLqHhIqnxHGQPi7nA57yT/PX0JOH86/UPQcfpsUzVo/WWrcA2D7W79hTQirp3Voz3dTqjDhDmLkR+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VjbTh744rz6JBGg;
	Mon, 20 May 2024 19:50:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 72D23140A36;
	Mon, 20 May 2024 19:53:34 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 12:53:34 +0100
Date: Mon, 20 May 2024 12:53:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] Enumerate "Inclusive Linear Address Mode"
 memory-side caches
Message-ID: <20240520125333.00007a47@Huawei.com>
In-Reply-To: <6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
References: <663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch>
	<20240517174550.0000242a@Huawei.com>
	<6647bbf6c88e3_2c2629451@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 17 May 2024 13:20:06 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Fri, 10 May 2024 16:00:24 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > # Title: Enumerate "Inclusive Linear Address Mode" memory-side caches  
> > 
> > So pretty much all my feedback is about using inclusive in anything
> > to do with caches.  Term usually means something very different from
> > what you have here and it confused me. As an example, consider a dataset
> > that fits entirely in CPU  L3 / L2 capacity.
> > In that case the situation you describe here looks like an exclusive L2 / L3
> > cache (line sits in one or the other but not both).  
> 
> I clarify in the text that this term is an attribute of the *address-space* not
> the cache hierarchy. If HMAT ever needed to described that a multi-level
> memory-side cache was Inclusive or Exclusive then I would likely steal bit3 of
> Cache Attributes field to enumerate that detail, but it is not clear that detail
> matters to any OS mechanism or policy.
> 
> > Maybe just describe the problem and skip the exact cause?
> > 
> > Enumerate "Unrecoverable aliases in direct mapped memory-side caches"  
> 
> I have read that several times and I can not map that title back to the property
> this "address mode" enumeration is trying to describe.
> 
> I would prefer to just pile on more explicit clarifications to overcome that
> instinct to map the word "Inclusive" to a multi-level cache attribute. Something
> like "note, 'Inclusive Linear' address-mode not to be confused with
> 'Inclusive/Exclusive' multi-level cache organization".

Hmm. I'll go with 'maybe'. When you have to add a bunch of distinctions of
a term that is applying to a 'cache' to say that you don't mean the standard
meaning for caches, it feels like a new term is a better path. 

Possibly as I suggest later a hyphen might avoid misreads.
inclusive-linear address mode.

> 
> > Whilst the CXL side of things (and I assume your hardware migration engine)
> > don't provide a way to recover this, it would be possible to build
> > a system that otherwise looked like you describe that did provide access
> > to the tag bits and so wouldn't present the aliasing problem.  
> 
> Aliasing problem? All direct-mapped caches have aliases, it just happens that
> this address mode allows direct-addressability of at least one alias.

As I understand this the problem is you get address A in the error record,
but that actually means any of A, A + N, A + 2N etc and the issue is you
have no way of recovering which alias you have. 

Another implementation might have the same aliasing in the cache, but allow
for establishing which one you have (the hardware inherently has to know that
but I presume in this case doesn't provide a way to look it up - or if it
does, then issue here is that the OS querying of the CXL device doesn't know
about that interface?).  So I think the critical here is that information is
not available, not that aliasing occurs.

> 
> > > 
> > > # Status: Draft v2
> > > 
> > > # Document: ACPI Specification 6.6
> > > 
> > > # License
> > > SPDX-License Identifier: CC-BY-4.0
> > > 
> > > # Submitter:
> > > * Sponsor: Dan Williams, Intel
> > > * Creators/Contributors:
> > >     * Andy Rudoff, retired
> > >     * Mahesh Natu, Intel
> > >     * Ishwar Agarwal, Intel
> > > 
> > > # Changelog
> > > * v2: Clarify the "Inclusive" term as "including the capacity of the cache
> > >   in the SRAT range length"
> > > * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
> > >   that Address Mode values other than 1 are Reserved.
> > > 
> > > # Summary of the Change
> > > Enable an OSPM to enumerate that the capacity for a memory-side cache is
> > > "included" in an SRAT range. Typically the "Memory Side Cache Size"
> > > enumerated in the HMAT is "excluded" from the SRAT range length because
> > > it is a transparent cache of the SRAT capacity. The enumeration of this
> > > addressing mode enables OSPM memory RAS (Reliability, Availability, and
> > > Serviceability) flows.  
> > 
> > 'excluded' somehow implies it exists as something we might include but
> > we don't.  'Not relevant' would be clearer wording I think.  
> 
> But it is relevant. If the near memory (cache memory) is 64GB and the far memory
> (backing store) is 64GB then the SRAT range is 64GB (cache-excluded). With this
> new mode the SRAT range is 128GB.

Sure, but this is a cache, not normal memory so in what people normally expect
from a memory-side cache (write through / write back etc) there is no
reason to ever include it in SRAT. Hence it's not 'excluded' it just has
nothing to do with SRAT which is about memory, not caches. I'm not
arguing it is irrelevant in your case (where it clearly is because it is part
of the memory), but it is irrelevant in for example a write-through cache.
Saying it was excluded is implying a lot more that 'not-included' would for
example.

> 
> > > Recall that the CXL specification allows for platform address ranges to
> > > be interleaved across CXL and non-CXL targets. CXL 3.1 Table 9-22 CFMWS
> > > Structure states "If the Interleave Set spans non-CXL domains, this list
> > > may contain values that do not match \_UID field in any CHBS structures.
> > > These entries represent Interleave Targets that are not CXL Host
> > > Bridges". For an OSPM this means address translation needs to be
> > > prepared for non-CXL targets. Now consider the case when that CXL
> > > address range is flagged as a memory side cache in the ACPI HMAT.  
> > 
> > A CXL address range can be flagged as having a memory-side cache in
> > front of it bus as you've state normally wouldn't have separate HPA
> > ranges. The interleave stuff doesn't get you to what you describe
> > here as it's well defined, not a transparent cache like a
> > memory-side cache.  A given cacheline is in a known FRU, not potentially
> > multiple ones. Hence I'm not sure this paragraph is particularly useful.  
> 
> It was an attempt to show precedent for why Linux needs to care about the memory
> organization and how CFMWS does not achieve this description. That said, as this
> is text that only appears in the justification for the ECN I do not mind
> dropping it.

I think it risks confusion given it's not directly relevant to this.

> 
> > > Address translation needs to consider that the decode for an error may
> > > impact multiple components (FRUs fields replaceable units).
> > > 
> > > Now consider the implications of ["Flat Memory Mode" (Intel presentation
> > > at Hot Chips
> > > 2023)](https://cdrdv2-public.intel.com/787386/Hot%20Chips%20-%20Aug%2023%20-%20BHS%20and%20Granite%20Rapid%20-%20Xeon%20-%20Architecture%20-%20Public.pdf).  
> > 
> > Other than telling us someone put it on a slide, that slide provides
> > very little useful info!  
> 
> Hence this write-up in the ECN, felt it was better than nothing to include a
> picture for reference.

I think that left me more confused than anything ;)

> 
> > > This cache geometry implies an address space that includes the
> > > memory-side cache size in the reported address range. For example, a
> > > typical address space layout for a memory-side-cache of 32GB of DDR
> > > fronting 64GB of CXL would report 64GB in the "Length" field of the
> > > SRAT's "Memory Affinity Structure" and 32GB in the "Memory Side Cache
> > > Size" field of the HMAT's "Memory Side Cache Information Structure".  
> >   
> > > An
> > > inclusive address-space layout of the same configuration would report
> > > 96GB in the "Length" field of the SRAT's "Memory Affinity Structure" and
> > > 32GB in the "Memory Side Cache Size" field of the HMAT's "Memory Side
> > > Cache Information Structure". The implication for address translation in
> > > the inclusive case, is that there are N potential aliased address
> > > impacted by a memory error where N is the ratio of:
> > > 
> > > SRAT.MemoryAffinityStructure.Length /
> > > HMAT.MemorySideCacheInformation.CacheSize  
> > 
> > So in your example a memory error can affect any of 3 addresses.
> > 
> > That feels like it is assuming a particular caching strategy without
> > expressly stating it. Let us take it to extreme.  Make it a fully
> > associative non-inclusive DDR cache (sure that is insane, but bare
> > with me). Now any potential problem affects all addresses as a given error
> > in the memory-side cache might affect anything - given it's fully associative
> > it's also possible an error in the CXL memory might also be any cacheline
> > in the system.
> > 
> > The memory-side cache description does include the option of specifying
> > the cache is direct mapped so if that is set your assumed mapping is valid.
> > If someone set the 'complex cache indexing' option then I think all bets
> > are off. To be useful you should rule that out in your spec change.  
> 
> Sure, "Linear" implies direct-mapped since fully-set associative is a
> non-linear arrangement.

Sure, but you haven't introduced linear yet so this reads as more general
than intended.  I'd call out explicitly that if your new mode is set then
direct-mapped must also be set.

> 
> > > This change request is not exclusive to CXL, the concept is applicable
> > > to any memory-side-cache configuration that the HMAT+SRAT can describe.
> > > However, CXL is a primary motivator given the OSPM role in address
> > > translation for device-physical-address (DPA) events being translated to
> > > impacted host-physical-address (HPA) events.
> > > 
> > > # Benefits of the Change
> > > An OSPM, when it knows about inclusive cache address space, can take
> > > actions like quarantine / offline all the impacted aliased pages to
> > > prevent further consumption of poison, or run repair operations on all
> > > the affected targets. Without this change an OSPM may not accurately
> > > identify the HPA associated with a given CXL FRU event, or it may
> > > misunderstand that an SRAT memory affinity range is an amalgam of CXL
> > > and cache capacity.  
> > 
> > Could you add a cache attribute to say it's a non-inclusive / exclusive
> > cache? That combined with direct-mapped would I think provide the relevant
> > indication.  It still runs into the problem that advanced hardware
> > could still resolve which alias is the problem. So maybe we are better
> > off sticking to describing that fact there is an alias issue for any
> > reported errors that cannot be resolved (presumably you can poke the
> > the aliased entries and see which one gives poison via synchronous access)  
> 
> I still disagree with the implication that "inclusion" is a property of the
> cache and not the address layout for this ECN.

It's an ECN about caches - the chance of misunderstanding is high.
Maybe there isn't a better option, but it definitely makes me feel uncomfortable.


> 
> > Note that I'm not keen on the use of inclusive for your range description
> > because that terminology means the exact opposite of what you intend
> > when applied to a normal cache! I can't think of a better term though
> > but the bikeshed should not be blue.  
> 
> I am sticking with "include" since cache capacity is included in the SRAT
> range, and will move off that term when/if someone comes up with something
> better.

Maybe hyphen will help? Inclusive-linear Address mode?
to avoid reading this as separate adjectives as in that this is an
'inclusive' cache that has a 'linear address' mode?

> 
> [..]
> > > 
> > > * Extend the implementation note after Table 5.149 to explain how to
> > >   interpret the "Inclusive linear" mode.
> > > 
> > >     * "When Address Mode is 1 'Inclusive Linear' it indicates that there
> > >       are N directly addressable aliases of a given cacheline
> > >       where N is the ratio of target memory proximity domain size and
> > >       the memory side cache size.  Where the N aliased addresses for a
> > >       given cacheline all share the same result for the operation
> > >       'address modulo cache size'."  
> > 
> > That description is somewhat tighter than the free form one in the intro
> > so answered a lot of questions I had before getting this far.  
> 
> Happy to delete all of the text outside of "Detailed Description of the Change"
> since none of it will be included in ACPI spec.
ASWG always like an explanation though and that stuff is helpful when
we are trying to figure out intent in years to come.

Jonathan



