Return-Path: <linux-acpi+bounces-9082-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B747E9B4F6C
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91541C22938
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Oct 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CCD1D89EF;
	Tue, 29 Oct 2024 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otd4vn6i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56351D86ED;
	Tue, 29 Oct 2024 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219707; cv=none; b=cOTM0iUeh/N6uMj8Q/F9vyio/QCQMwxw+Ly12hQhJlgkiS1ocM5uS1EPbD96tOPO9WSY1iebiywTWnoWXSJQvxwJJ0vDeg0Uk01dUdn8s8lx/9B4+k0xBTT6WalcI2eDNPbxjNxrugPq3mtuyZagSuz2wLPH+0lCLuU55zzaikA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219707; c=relaxed/simple;
	bh=Yj1b0cSGOis8m/UbHkjlmF67Irb4SXyzwgTNfJtCv4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0TkMYoPl+y5MFDdNhQwH8hD6Q+EOBCJ5eZVIWm0lvet1CmDKoYDcW/oxXcjf8m9nVG6KF4/WzYgsnZi39QeCLYDF7/YkYHV1JnpKeL8eSaJPHY43Zc1nJW+EboNaMX9GA6LZNFxyc2tR11lDrHrT3lQ/GJa7ebyjcJvAQq3eKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otd4vn6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9C5C4CECD;
	Tue, 29 Oct 2024 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730219706;
	bh=Yj1b0cSGOis8m/UbHkjlmF67Irb4SXyzwgTNfJtCv4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otd4vn6iRnZrPv2Llj4qkLPBk+7sCOd1HCIYS04+RCV4G3arDJmvKN0Ua0udw2Rjz
	 Y9HqTXjHPqETIUiitVuGWmsYPl1OfP9XXbe26QKVlLU/NbqltpNoyMPdaKFxk4YwhS
	 jPFRlYG0b5SWDwJ/dsMNrJr3is0jCr6LZbBG88K9AM3qwyHg+NE7ZkzKh9PeIbkcig
	 G2k8PYOGHq4l2QkoEIJmZHohrAldMZfTZ9snAtPiPg6LpTDpWa+MfnxvdpbmN+qL6G
	 5Iz4ClflvSViLQKRKW9YsutYB2T89rV7ZoAJWmzX7+4k9rYmkBQZ+7HfRZem+0rlus
	 9yI00MJ775kBA==
Date: Tue, 29 Oct 2024 18:31:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: David Hildenbrand <david@redhat.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, linux-cxl@kvack.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	rrichter@amd.com, Terry.Bowman@amd.com, dave.jiang@intel.com,
	ira.weiny@intel.com, alison.schofield@intel.com,
	dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	rafael@kernel.org, lenb@kernel.org, osalvador@suse.de,
	gregkh@linuxfoundation.org, akpm@linux-foundation.org
Subject: Re: [PATCH v3 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
Message-ID: <ZyENzGgsDOdhqBjd@kernel.org>
References: <20241022213450.15041-1-gourry@gourry.net>
 <20241022213450.15041-4-gourry@gourry.net>
 <55a5b63a-a6bb-4ba0-9aad-c9d8741d1c3a@redhat.com>
 <ZyDhLLCNXFN_M8l2@PC2K9PVX.TheFacebook.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyDhLLCNXFN_M8l2@PC2K9PVX.TheFacebook.com>

On Tue, Oct 29, 2024 at 09:20:44AM -0400, Gregory Price wrote:
> On Tue, Oct 29, 2024 at 01:42:12PM +0100, David Hildenbrand wrote:
> > 
> > >   static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> > >   				   void *arg, const unsigned long table_end)
> > >   {
> > > @@ -545,6 +569,15 @@ int __init acpi_numa_init(void)
> > >   	 * Initialize a fake_pxm as the first available PXM to emulate.
> > >   	 */
> > > +	/* Align memblock size to CFMW regions if possible */
> > > +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_align_cfmws, NULL);
> > > +
> > > +	/*
> > > +	 * Nodes start populating with blocks after this, so probe the max
> > > +	 * block size to prevent it from changing in the future.
> > > +	 */
> > > +	memory_block_probe_max_size();
> > > +
> > 
> > This looks odd. Why shouldn't we allow someone else to suggest/advise an
> > even smaller "max size" ? I'd drop that.
> > 
> 
> Ah, my reading of the numa_add_memblk path was mistaken.  I thought the
> hotplug blocks would start being created immediately after this in the
> acpi_parse_cfmws path - but memblk != memory_block x_x.

Right, we have a bunch of semi related memory blocks :)

There's mm/memblock.c for early memory description and allocation,
mm/numa_memblks.c for to describe what range belongs to which NUMA node and
there are memory blocks in drivers/base/memory.c that describe
hot-(un)plugable memory blocks.

Maybe it's time to rename memblock_* APIs back to bootmem_ :-D
 
> Will drop along with other recommended updates and submit v4.
> 
> ~Gregory

-- 
Sincerely yours,
Mike.

