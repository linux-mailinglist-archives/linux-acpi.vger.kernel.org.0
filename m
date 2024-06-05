Return-Path: <linux-acpi+bounces-6189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D408FC742
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 11:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B79328770F
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 09:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6575214B974;
	Wed,  5 Jun 2024 09:10:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39C31946AD;
	Wed,  5 Jun 2024 09:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578619; cv=none; b=d9N7Bo9oN8f/7F19f8XPT3VYr/0gQQYmnrEdFnznhXIoTMN3wgI/9TUWclhBrMIOMTeottoUfx7K7/s/b7QCfjXZpAyR9U4lzHeRc6yipoPwDkk/aZ08YGWDyNUrCmlzKJApjSOI7j8x7GaOeL62BNNre2fuCnuglKE21T0+2Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578619; c=relaxed/simple;
	bh=1rsahx07lWgiYOE2PZinNKRtwuhyshf+IbP69Z56vlI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ll/ofJhsA7D2yDX19HUfM8ni0o4LwIn2zxNyDEA0M0NRJ5SMFf/X8i1YeosZv/CGt7ST1tIQEykbVkM5upuo7UNLLcAIVVQnn0iefH2J0GzK2R8kn6JhyaFxYxAdYjnnFRCbEVnCPsRYYtfjvOekJGrjRQZRGqvhCUtuHz8sTD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvM8b2DYFz6K99k;
	Wed,  5 Jun 2024 17:09:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 16D0E1400C9;
	Wed,  5 Jun 2024 17:10:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 10:10:13 +0100
Date: Wed, 5 Jun 2024 10:10:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <20240605101012.000041e4@Huawei.com>
In-Reply-To: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 24 May 2024 12:05:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> # Title: "Extended-linear" addressing for direct-mapped memory-side caches
> 
> # Status: v3
> 
> # Document: ACPI Specification 6.6
> 
> # License
> SPDX-License Identifier: CC-BY-4.0
> 
> # Submitter:
> * Sponsor: Dan Williams, Intel
> * Creators/Contributors:
>     * Andy Rudoff, retired
>     * Mahesh Natu, Intel
>     * Ishwar Agarwal, Intel
> 
> # Changelog
> * v3: Replace "Inclusive Linear" with "Extended-linear" term, and
>   clarify the SPA vs HPA behavior of this cache addressing mode.
>   (Jonathan Cameron)
> * v2: Clarify the "Inclusive" term as "including the capacity of the cache
>   in the SRAT range length"
> * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
>   that Address Mode values other than 1 are Reserved.
> 
> # Summary of the Change
> Recall that one of the modes available with persistent memory (PMEM) was a
> direct-mapped memory-side cache where DDR-memory transparently cached
> PMEM. This article has more details:
> 
> https://thessdguy.com/intels-optane-two-confusing-modes-part-2-memory-mode/
> 
> ...but the main takeaway of that article that is relevant for this ECN
> is:
> 
>     "[PMEM] is paired with a DRAM that behaves as a cache, and,
>      like a cache, it is invisible to the user. [..] A typical system
>      might combine a 64GB DRAM DIMM with a 512GB Optane DIMM, but the
>      total memory size will appear to the software as only 512GB."
> 
> Instead, this new "extended-linear" direct-mapped memory-side cache
> addressing mode would make the memory-size that appears to software in
> the above example as 576GB. The inclusion of the DDR capacity to extend
> the capacity visible to software may improve cache utilization.

I'd skip the cache utilization point as even with 'may' it might just
end up rat holing!. Capacity seems enough a justification to me and
requires a lot less justification.

Perhaps something like
"The inclusion of the DDR increases the available capacity whilst still
 providing benefits of a lower latency cache."

Up to you though as I'll not have to explain that utilization point
to anyone whereas you might.

> 
> A primary motiviation for updating HMAT to explicitly enumerate this
> addressing mode is due to the OSPM's increased role for RAS and
> address-translation with CXL topologies. With CXL and OS native RAS
> flows OSPM is responsible for understanding and navigating the
> relationship between System-Physical-Address (SPA) ranges published
> ACPI.SRAT.MemoryAffinity, Host-Physical-Address ranges (HPA) published
> in the ACPI.CEDT.CFMWS, and HPAs programmed in CXL memory expander
> endpoints.
> 
> Enable an OSPM to enumerate that the capacity for a memory-side cache
> extends an SRAT range. Typically the "Memory Side Cache Size" enumerated
> in the HMAT is "excluded" from the SRAT range length because it is a
> transparent cache of the SRAT capacity. The enumeration of this
> addressing mode enables OSPM-memory-RAS (Reliability, Availability, and
> Serviceability) flows.
> 
> # Benefits of the Change
> Without this change an OSPM that encounters a memory-side cache
> configuration of DDR fronting CXL may not understand that an SRAT range
> extended by cache capacity should be maintained as one contiguous SPA
> range even though the CXL HPA decode configuration only maps a subset of
> the SRAT SPA range. In other words the memory-side-cache dynamically
> maps access to that SPA range to either a CXL or DDR HPA.
> 
> When the OSPM knows about this relationship it can take actions like
> quarantine / offline all the impacted aliased pages to prevent further
> consumption of poison, or run repair operations on all the affected
> targets. Without this change an OSPM may not accurately identify the HPA
> associated with a given CXL endpoint DPA event, or it may misunderstand
> the SPAs that map to CXL HPAs.

I'd like something here on impacts on firmware first error reporting.
Given we'd like that to work on a non CXL aware system not aware of this
feature at all, I'd propose multiple CPER records, one for each alias.
That assumes the firmware has no path to establish the alias.

Can certainly conceive of ways to implement a probe-type setup to allow
the discovery of which alias has been poisoned etc.

Perhaps needs a note somewhere in 18.3.  Something along lines of
"For any error with SPA originating in a range, where a memory-side cache
 with address mode extended-linear is present, multiple error records
 should be presented to cover any potentially affected aliases."

Maybe an OS could opt out of that multiple reporting via _OSC or similar
but I'm not sure why it would bother though. Easier to just allow for
multiple events.

> 
> # Impact of the Change
> The proposed "Address Mode" field consumes the 2 Reserved bytes
> following the "Cache Attributes" field in the "Memory Side Cache
> Information Structure". The default reserved value of 0 indicates the
> status quo of an undeclared addressing mode where the expectation is
> that it is safe to assume the cache-capacity is transparent to the SRAT
> range capacity. An OSPM that knows about new values can consider SPA to
> HPA relationships according to the address-layout definition proposed
> below. A legacy OSPM will ignore it as a Reserved field.
> 
> # References
> * Compute Express Link Specification v3.1,
> <https://www.computeexpresslink.org/>
> 
> # Detailed Description of the Change

Probably need to up rev HMAT as well.

> 
> * Section Table 5.149: Memory Side Cache Information Structure redefine
>   the 2 Reserved bytes starting at offset 28 as "Address Mode":
> 
>     * 0 - Reserved (OSPM may assume transparent cache addressing)

Can we make that assumption?  What are today's firmware's doing for this?
I'd drop the 'may assume'  Also after this change it's not reserved.
0 explicitly means transparent cache addressing.

>     * 1 - Extended-linear (N direct-map aliases linearly mapped)
>     * 2..65535 - Reserved (Unknown Address Mode)
> 
> * Extend the implementation note after Table 5.149 to explain how to
>   interpret the "Extended-linear" mode.
> 
>   * When Address Mode is 1 'Extended-Linear' it indicates that the
>     associated address range (SRAT.MemoryAffinityStructure.Length) is
>     comprised of the backing store capacity extended by the cache
>     capacity. It is arranged such that there are N directly addressable
>     aliases of a given cacheline where N is the ratio of target memory
>     proximity domain size and the memory side cache size. Where the N
>     aliased addresses for a given cacheline all share the same result
>     for the operation 'address modulo cache size'.

Probably need more here.  What if someone has two such ranges of size

Address 0, (512G + 64G) , (1024G + 128G)
And decides to pack them for some reason.
The second one will be aligned to 64G not, 128G so modulo needs to take
into account the base address.

Do we need explicit statement that N is an integer? Probably works anyway
but having 2.5 aliases is an unusual concept.

> This setting is only
>     allowed when 'Cache Associativity' is 'Direct Map'."

Other than these corner cases looks good to me and the new terminology and
clarifications help a lot.

Thanks,

Jonathan



