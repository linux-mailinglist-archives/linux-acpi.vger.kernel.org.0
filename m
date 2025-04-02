Return-Path: <linux-acpi+bounces-12633-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62981A78B39
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2634A7A4DD5
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Apr 2025 09:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F4236458;
	Wed,  2 Apr 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE+8UrCx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC00236453;
	Wed,  2 Apr 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743586797; cv=none; b=BFN0UvsbCUPHJ6m4Cp2ZaYgYUFEgEQgFpRXEDDshaXF07Ji2dQKxjvtqIfrQGHyROpSarQ2FhUr2LoqMAM3zxyb6ZQJ9KY2Jpt67MhGWEdURAgHHajP8HBGSW6x/SDGe0ZeMRy30WgukJN4ODz+VOW3IBDILQgROnYD4OmtFYBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743586797; c=relaxed/simple;
	bh=SmCXw4v07fnCF2PMedutweCHBi3wxPPlB3+QMVFkasw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDyhda0YgLXLjgd3JYJSu1RIplL2VK1drvSBHHll3/e0ouh04UCjCMdSpXMCjAkTzujoafSZIL20Ce8M0XhHNoGlmi5ndNiNlPRaTUo2Zk/1js3BeX3SkgYpp0biKIbigNiw7fJFwvyHDyehe3rzTImFykT6ztdkMjrz+7vjygY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE+8UrCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36093C4CEE9;
	Wed,  2 Apr 2025 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743586796;
	bh=SmCXw4v07fnCF2PMedutweCHBi3wxPPlB3+QMVFkasw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KE+8UrCxpQpzzo9nSQtehkHNB7tuKWLbhx5ScuFdQHr9Vy48cdtSapFzSd5/MzI46
	 TmsRR9Y4Qi1OSKhoQKGdy71N9j4c1QO2raQiRofMm7xpEnXrUZqJU2dDK1DZ9NrRsj
	 diZGh5Wsr+G230J/VIof4zTVM7M0CA+TxufFTytfLJgpWqcDqrWI1lYYldFEbb2qhC
	 a9F71uE4jfGVon9zoohpBmF+oWNNJZRL9Dh2IV8mnTMhmtG3v24TxOpttBy0XBDlpp
	 IbH0GnGNeeMIXBrX2wYNJZKp25QcZycUk6brDJP90cyFSju7o/agepf1hDlvtEmBg7
	 CVWlRNZMEQHkA==
Date: Wed, 2 Apr 2025 12:39:44 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Oscar Salvador <osalvador@suse.de>, Gregory Price <gourry@gourry.net>,
	linux-mm@kvack.org, linux-acpi@vger.kernel.org,
	kernel-team@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, dan.j.williams@intel.com,
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
	rrichter@amd.com, bfaccini@nvidia.com, haibo1.xu@intel.com,
	dave.jiang@intel.com, Ira Weiny <ira.weiny@intel.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 0/3] memory,x86,acpi: hotplug memory alignment
 advisement
Message-ID: <Z-0F4Fm0byd0Co3v@kernel.org>
References: <20250127153405.3379117-1-gourry@gourry.net>
 <Z-w2O8O9MGJ1Ok78@localhost.localdomain>
 <01d8cde7-0973-4303-bb5d-3d377a6862cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d8cde7-0973-4303-bb5d-3d377a6862cb@redhat.com>

On Tue, Apr 01, 2025 at 09:08:31PM +0200, David Hildenbrand wrote:
> On 01.04.25 20:53, Oscar Salvador wrote:
> > On Mon, Jan 27, 2025 at 10:34:02AM -0500, Gregory Price wrote:
> > > v8: nits and tag pickups
> > > 
> > > When physical address regions are not aligned to memory block size,
> > > the misaligned portion is lost (stranded capacity).
> > > 
> > > Block size (min/max/selected) is architecture defined. Most architectures
> > > tend to use the minimum block size or some simplistic heurist. On x86,
> > > memory block size increases up to 2GB, and is otherwise fitted to the
> > > alignment of non-hotplug (i.e. not special purpose memory).
> > 
> > I wonder if something like this could help us in improving the
> > ridiculous situation of having 16MB memory-block size on powerpc.
> 
> They have this granularity because ... they want to add/remove memory in
> 16MiB on some powerpc dlpar machines :(

I'm not sure they do it today, there's a comment in near define of that 16M
in arch/powerpc/mm/init_64.c:

/*
 * Outside hotplug the kernel uses this value to map the kernel direct map
 * with radix. To be compatible with older kernels, let's keep this value
 * as 16M which is also SECTION_SIZE with SPARSEMEM. We can ideally map
 * things with 1GB size in the case where we don't support hotplug.
 */
 
and their SECTION_SIZE didn't change since 2005. 
Quite possible that they'll be fine with increasing their
DEFAULT_MEMORY_BLOCK_SIZE.

> probe_memory_block_size() can query the hypervisor on the actual hot(un)plug
> size. IIRC, QEMU sets it to 256 MiB.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

