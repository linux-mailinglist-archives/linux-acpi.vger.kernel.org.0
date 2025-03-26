Return-Path: <linux-acpi+bounces-12435-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D57A719D9
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 16:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7383A19C3907
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Mar 2025 15:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D661145B27;
	Wed, 26 Mar 2025 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLvVqDNP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E9235968;
	Wed, 26 Mar 2025 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743001235; cv=none; b=m7rfpxlNC7OKd7iI6QvvlR3obZloEbE2URkIE4JT6r+Vlyeacs8qvndiwsA+yb1bDcJUD2OAaIOW2Pft9vuttqF7YBMDCfdVU4PdTDufWIoZM+CLtn6z8S4IH5BnoCcdBIoGZxgmylKfv3LneXBjm5WjzIOIJozJlvl+an3zl2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743001235; c=relaxed/simple;
	bh=2eBfpGTXDD24FL4ei3Eshn77s6yu+IfAOgKSh5SyMZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1s5XN0EZwVTQ0i6FragcIlFMC4gLQ+BhLA+c/bT2+gT8GQBSsyYDpZXhKwx20Jy8tXIu8PiLvZO42S4nIweiSvaFVdwtz69YMQTuaHbYuq9PIWnPtRA/Ug+DrrSbiMbFAyXcXRCoHi4fwgHfPYid+dFrFUsdYQSrZckOjmRPDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLvVqDNP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98978C4CEE2;
	Wed, 26 Mar 2025 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743001234;
	bh=2eBfpGTXDD24FL4ei3Eshn77s6yu+IfAOgKSh5SyMZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hLvVqDNPG/H7z6VVnoN8G1VvPThguZkSI3q9N+P80U1b5sP6vfOi2egH+S5PB7FzH
	 MZfebzSL2SRtlOWFLNPAUgcQdp7gCTC6GUQnDSlVNxivIZckt6OpL3qUmpFHCVew7M
	 iNbxRIiRmhdQtaYz9OiUojwhn5M/1BibdzQ/TCxXbIAORl0G3sBX1bIbd4iBoqSCT6
	 NZ9LemcnQBCSarASuJB1ZcmgEnG6PIaV/VcyFYKBeTQFR1DuWOpUaBGOT4jRApRT0D
	 xsgwVhQzl4yIhGl7keGYyeJJw2gcFQUcACrWY1MWxTKvpCA5qmr4kBTlvSXuLWdCbm
	 E96sMPr+fF76g==
Date: Wed, 26 Mar 2025 11:00:30 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Yuquan Wang <wangyuquan1236@phytium.com.cn>, dan.j.williams@intel.com,
	akpm@linux-foundation.org, david@redhat.com, bfaccini@nvidia.com,
	rafael@kernel.org, lenb@kernel.org, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	haibo1.xu@intel.com, linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	chenbaozi@phytium.com.cn
Subject: Re: [RFC PATCH v3 2/2] ACPI: NUMA: debug invalid unused PXM value
 for CFMWs
Message-ID: <Z-QWjpisq8TB9s4W@kernel.org>
References: <20250321023602.2609614-1-wangyuquan1236@phytium.com.cn>
 <20250321023602.2609614-3-wangyuquan1236@phytium.com.cn>
 <20250321115116.00007ae7@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321115116.00007ae7@huawei.com>

Hi,

On Fri, Mar 21, 2025 at 11:51:16AM +0000, Jonathan Cameron wrote:
> On Fri, 21 Mar 2025 10:36:02 +0800
> Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
> 
> > The absence of SRAT would cause the fake_pxm to be -1 and increment
> > to 0, then send to acpi_parse_cfmws(). If there exists CXL memory
> > ranges that are defined in the CFMWS and not already defined in the
> > SRAT, the new node (node0) for the CXL memory would be invalid, as
> > node0 is already in "used", and all CXL memory might be online on
> > node0.
> > 
> > This utilizes node_set(0, nodes_found_map) to set pxm&node map. With
> > this setting, acpi_map_pxm_to_node() could return the expected node
> > value even if no SRAT.
> > 
> > If SRAT is valid, the numa_memblks_init() would then utilize
> > numa_move_tail_memblk() to move the numa_memblk from numa_meminfo to
> > numa_reserved_meminfo in CFMWs fake node situation.
> 
> I would call out that numa_move_tail_memblk() is called in
> numa_cleanup_meminfo() which is indeed called by num_memblks_init()
> 
> > 
> > If SRAT is missing or bad, the numa_memblks_init() would fail since
> > init_func() would fail. And it causes that no numa_memblk in
> > numa_reserved_meminfo list and the following dax_cxl driver could
> > find the expected fake node.
> > 
> > Use numa_add_reserved_memblk() to replace numa_add_memblk(), since
> > the cxl numa_memblk added by numa_add_memblk() would finally be moved
> > to numa_reserved_meminfo, and numa_add_reserved_memblk() here could
> > add cxl numa_memblk into reserved list directly. Hence, no matter
> > SRAT is good or not, cxl numa_memblk could be allocated to reserved
> > list.
> > 
> > Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> This definitely wants input from Mike Rapoport.
> Looks fine to me, but there may be some subtle corners I'm missing.

I'm fine with exposing numa_add_reserved_memblk(), but I don't understand
CXL discovery enough to say if adding CXL ranges directly to
numa_reserved_meminfo.

If this is always the case that CFMW regions end up on
numa_reserved_meminfo, adding them there in the first place does make
sense.
 
> > ---
> >  drivers/acpi/numa/srat.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 00ac0d7bb8c9..50bfecfb9c16 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -458,11 +458,12 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (numa_add_memblk(node, start, end) < 0) {
> > +	if (numa_add_reserved_memblk(node, start, end) < 0) {
> >  		/* CXL driver must handle the NUMA_NO_NODE case */
> >  		pr_warn("ACPI NUMA: Failed to add memblk for CFMWS node %d [mem %#llx-%#llx]\n",
> >  			node, start, end);
> >  	}
> > +
> 
> Unrelated change.  Always give patches a final look through to spot
> things like this.  Trivial, but they all add noise to what we are focusing on.
> 
> >  	node_set(node, numa_nodes_parsed);
> >  
> >  	/* Set the next available fake_pxm value */
> > @@ -646,8 +647,12 @@ int __init acpi_numa_init(void)
> >  		if (node_to_pxm_map[i] > fake_pxm)
> >  			fake_pxm = node_to_pxm_map[i];
> >  	}
> > -	last_real_pxm = fake_pxm;
> > -	fake_pxm++;
> > +
> > +	/* Make sure CFMWs fake node >= 1 */
> > +	fake_pxm = max(fake_pxm, 0);
> > +	last_real_pxm = fake_pxm++;

I'd make it more explicit:

	/*
	 * Make sure CFMWs fake nodes follow last_real_pxm, even when SRAT
	 * is invalid
	 */
	last_real_pxm = max(fake_pxm, 0);
	fake_pxm = last_real_pxm + 1;	

> > +	node_set(0, nodes_found_map);
> > +
> >  	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, acpi_parse_cfmws,
> >  			      &fake_pxm);
> >  
> 

-- 
Sincerely yours,
Mike.

