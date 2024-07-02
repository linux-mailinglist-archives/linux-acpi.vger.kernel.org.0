Return-Path: <linux-acpi+bounces-6735-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89759923DE6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 14:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD0C81C245DB
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 12:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D1816CD15;
	Tue,  2 Jul 2024 12:31:18 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9A15D5AB;
	Tue,  2 Jul 2024 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923478; cv=none; b=fkRS62V2Huc2J5KeGVQq/hsahf786GwnC5IrZrC0WQTgp/E1EhGvoKtZVMngf1imwjLpek0pqx2vUi4NCwAIoue+9NMuOABbl3wC2tYcipr9qWoPRMe+WzGRrLpCu3S2X8yrE7GCpxcu6c/HzmpdF5yMlfKoQ04yn/RRPi5FRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923478; c=relaxed/simple;
	bh=MuQLuqYQPJy7S+FKj1ZdB35/ciDGkUkDpskKJxA9Jb8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ckpzOa2XFz2zm8JralS8mWQDSqjnT9NkajJxOIk69VPnE2ZSV5deVYjvBWq1V+XxBVrJFR9Zs1+GeEN1BA6Ba98a0AGIwkv8Yd1NrfPdLJQBix33uFz1I5Bq8kiB5o3baf1ULk4AcMhy6F8CofdcrO0xNS3hhTxvlSYJ1Hk8wIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD2Lk3gBdz67Ct4;
	Tue,  2 Jul 2024 20:30:38 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2D44C140A70;
	Tue,  2 Jul 2024 20:31:14 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 13:31:13 +0100
Date: Tue, 2 Jul 2024 13:31:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN v4] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <20240702133112.000077d7@Huawei.com>
In-Reply-To: <668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch>
References: <668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch>
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

On Mon, 1 Jul 2024 15:54:41 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> # Title: "Extended-linear" addressing for direct-mapped memory-side caches
> 
> # Status: v4
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
> * v4: Drop "improved cache utilization" claim (Jonathan)
> * v4: Clarify SPA vs HPA terminology
> * v4: Clarify possibility and difficulty of multiple CPER records to
>   communicate aliases (Jonathan)
> * v4: Clarify that N is expected to be an integer ration of "near" to
>   "far" memory. (Jonathan)
> * v3: Replace "Inclusive Linear" with "Extended-linear" term, and
>   clarify the SPA vs HPA behavior of this cache addressing mode.
>   (Jonathan)
> * v2: Clarify the "Inclusive" term as "including the capacity of the cache
>   in the SRAT range length"
> * v2: Clarify that 0 is an undeclared / transparent Address Mode, and
>   that Address Mode values other than 1 are Reserved.
> 
> v3: http://lore.kernel.org/6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch
> v2: http://lore.kernel.org/663ea70884cfd_db82d29414@dwillia2-xfh.jf.intel.com.notmuch
> 
Trivial suggestions inline.

Otherwise seems fine to me.

Jonathan

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
> the above example as 576GB, an increase of addressable capacity.
> 
> A primary motivation for updating HMAT to explicitly enumerate this
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
> transparent cache of the SRAT capacity. I.e. typical systems present 1:1
> SPA:HPA, extended-linear memory-side-cache systems alias multiple SPAs
> to a single CXL HPA.  The enumeration of this addressing mode enables
> OSPM-memory-RAS (Reliability, Availability, and Serviceability) flows.
> 
> # Benefits of the Change
> Without this change an OSPM that encounters a memory-side cache
> configuration of DDR fronting CXL may not understand that an SRAT range
> extended by cache capacity should be maintained as one contiguous SPA
> range even though the CXL HPA decode configuration only maps a subset of
> the SRAT SPA range. In other words the memory-side-cache dynamically
> maps access to that SPA range to either a CXL or DDR HPA.
> 
> Without this change the only way for system software to become aware of
> the fact that one memory poison event implicates multiple address
> locations would be for multiple error records (CPER) to be emitted

multiple error record sections (one CPER can contain a bunch of those).

> per-poison consumption event. That may surprise existing OSPM
> implementations.

I'd be tempted to add one line say that obviously this is impossible
for OS first handling as no one there to generate the records.  That
is kind of implied, but might as well say it.


> 
> With this change, the OSPM can enumerate aliases and take actions like
> quarantine / offline all the impacted aliased pages to prevent further
> consumption of poison, or run repair operations on all the affected
> targets. The OSPM is enabled to identify the HPA associated with a given
> CXL endpoint DPA event, and understand how SPAs map to CXL HPAs.
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
> 
> * Section Table 5.149: Memory Side Cache Information Structure redefine
>   the 2 Reserved bytes starting at offset 28 as "Address Mode":
> 
>     * 0 - Reserved (Unknown Address Mode)
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
>     aliases of a given cacheline where N is an integer ratio of target memory
>     proximity domain size and the memory side cache size. Where the N
>     aliased addresses for a given cacheline all share the same result
>     for the operation 'address modulo cache size'. This setting is only
>     allowed when 'Cache Associativity' is 'Direct Map'."
> 


