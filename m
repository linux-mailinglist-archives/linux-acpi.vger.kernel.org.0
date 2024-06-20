Return-Path: <linux-acpi+bounces-6552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC91910F67
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 19:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13BA3B2C78D
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 17:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286811AF6AF;
	Thu, 20 Jun 2024 17:37:09 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4D1B47AB;
	Thu, 20 Jun 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905029; cv=none; b=PkD76arRU3S46m3tj+TFmDMIc28K5NAW7wqXUqbaB2Y279I5ramj0VJQhCJm9WMhNWS38tD5K7AcJaYXvVe5oBc7bX5hlOSXQXVrHhMEsNDSnA8ELFsYd/hskEsWl05/6eAoK7rDW0bITeyf24c1UNzM5c5Jd2xNvggH1n7/Dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905029; c=relaxed/simple;
	bh=o/Ln2mLC+faFtJ179C73os+z2/rs+mxPEfIycSvEQJ4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WIUrM8YsGVLKns4y7KvAJy4PB4bEQM12UakgX0Coat0FTYbvEtmsttzdKNOol39t3YhiMVvdMdAddx4fv3V1UCT4qp10s/GXPu1vYaF+we8wxBEuq+VDZTMf/bdpM65E65Ea5d9i5mxkG15tTXnxxA7PW4VVpncpIHrXxmgG1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4nh137Vbz6K9Ff;
	Fri, 21 Jun 2024 01:35:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ED7C7140C72;
	Fri, 21 Jun 2024 01:37:02 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 20 Jun
 2024 18:37:02 +0100
Date: Thu, 20 Jun 2024 18:37:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<mahesh.natu@intel.com>, <rafael@kernel.org>
Subject: Re: [ACPI Code First ECN] "Extended-linear" addressing for
 direct-mapped memory-side caches
Message-ID: <20240620183701.00000029@Huawei.com>
In-Reply-To: <6670c5b267a79_3101294e2@dwillia2-xfh.jf.intel.com.notmuch>
References: <6650e4f835a0e_195e294a8@dwillia2-mobl3.amr.corp.intel.com.notmuch>
	<20240605101012.000041e4@Huawei.com>
	<6670c5b267a79_3101294e2@dwillia2-xfh.jf.intel.com.notmuch>
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
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)


> 
> 
> > > # Impact of the Change
> > > The proposed "Address Mode" field consumes the 2 Reserved bytes
> > > following the "Cache Attributes" field in the "Memory Side Cache
> > > Information Structure". The default reserved value of 0 indicates the
> > > status quo of an undeclared addressing mode where the expectation is
> > > that it is safe to assume the cache-capacity is transparent to the SRAT
> > > range capacity. An OSPM that knows about new values can consider SPA to
> > > HPA relationships according to the address-layout definition proposed
> > > below. A legacy OSPM will ignore it as a Reserved field.
> > > 
> > > # References
> > > * Compute Express Link Specification v3.1,
> > > <https://www.computeexpresslink.org/>
> > > 
> > > # Detailed Description of the Change  
> > 
> > Probably need to up rev HMAT as well.  
> 
> I'd let the ACPI working group make that determination. I am not clear
> on whether repurposing a reserved field mandates a version bump.

Normally does, but sure ASWG can figure it out.

> 
> > > 
> > > * Section Table 5.149: Memory Side Cache Information Structure redefine
> > >   the 2 Reserved bytes starting at offset 28 as "Address Mode":
> > > 
> > >     * 0 - Reserved (OSPM may assume transparent cache addressing)  
> > 
> > Can we make that assumption?  What are today's firmware's doing for this?  
> 
> The only shipping example I know of was for PMEM.

I gather that there are others, though that is the most common one.

> 
> > I'd drop the 'may assume'  Also after this change it's not reserved.
> > 0 explicitly means transparent cache addressing.  
> 
> I am just going to switch the parenthetical to "(Unknown Address Mode)"
> because "transparent" does not give any actionable information about
> alias layout in the SRAT address space. So system-software can make no
> assumptions about layout without consulting implementation specific
> documentation.

I'd like an option to indicate that we know reported errors will not
involve problems with aliases. Something like...

0 - Unknown (all bets are off, read the manual).
1 - No aliases.
2 - your one.

A simple write-through or write-back cache would not result in aliases
for errors reported by the backing memory.

Assuming we don't get an address corruption (in which case everything
dead anyway as uncontainable error), then poison can come from:
1) poison happens in the memory itself (fine, the DPA in CXL is enough)
2) poison happens in cache and is written back to memory. (fine
   the DPA in CXL is enough).
3) poison happens in cache and is read by host. Synchronous handling and
   the HPA is available and enough.

Not much we can do with 0, but 1 at least lets us know we have the
single right answer.

> 
> > >     * 1 - Extended-linear (N direct-map aliases linearly mapped)
> > >     * 2..65535 - Reserved (Unknown Address Mode)
> > > 
> > > * Extend the implementation note after Table 5.149 to explain how to
> > >   interpret the "Extended-linear" mode.
> > > 
> > >   * When Address Mode is 1 'Extended-Linear' it indicates that the
> > >     associated address range (SRAT.MemoryAffinityStructure.Length) is
> > >     comprised of the backing store capacity extended by the cache
> > >     capacity. It is arranged such that there are N directly addressable
> > >     aliases of a given cacheline where N is the ratio of target memory
> > >     proximity domain size and the memory side cache size. Where the N
> > >     aliased addresses for a given cacheline all share the same result
> > >     for the operation 'address modulo cache size'.  
> > 
> > Probably need more here.  What if someone has two such ranges of size
> > 
> > Address 0, (512G + 64G) , (1024G + 128G)
> > And decides to pack them for some reason.
> > The second one will be aligned to 64G not, 128G so modulo needs to take
> > into account the base address.  
> 
> Decides to pack them how? My expectation in this situation is 2
> proximity domains / memory-side cache descriptions.
> 

I was wrongly thinking the modulo maths failed if not aligned to the
cache size. Ignore this bit.

> > Do we need explicit statement that N is an integer? Probably works anyway
> > but having 2.5 aliases is an unusual concept.  
> 
> Easy enough to add "(integer)" after the first reference of "N".
> 
> > > This setting is only
> > >     allowed when 'Cache Associativity' is 'Direct Map'."  
> > 
> > Other than these corner cases looks good to me and the new terminology and
> > clarifications help a lot.  
> 
> Thanks for the feedback.

No problem.

J
> 


