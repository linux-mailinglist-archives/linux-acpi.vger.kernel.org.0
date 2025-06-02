Return-Path: <linux-acpi+bounces-14073-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2DACB9F2
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 19:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED7A402B7F
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 17:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDE13B293;
	Mon,  2 Jun 2025 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYFZTPPh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB64EAF9;
	Mon,  2 Jun 2025 17:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883739; cv=none; b=YloYAcMDnHRAazjl1DbX9bzrSOkUNq7/XuaIfv4G4JzaKsIwxQbBNrEB/gExvCMkrWdTUlgoJ/jRrWdxHGqPvAIwnQkVbpBtLqFO35d3YPAxxEaRRr/CpVBLMrTRC7lYnH4PrGSYwvvb6gxKvp9Lmip/KrXroQ74rmoN38NiFJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883739; c=relaxed/simple;
	bh=PAm0qcVMccKzdp3fnXKmqZ+vGp/mrw6+rOYNaWYB160=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZymTehWtHv8AYXurRPDH+XpHB5BokG+12ZusqnWmQ8zwjqGgVCvzzs6jiGA2wTTEPNLXIp7HViq4Su2+EmejT2Kpgm0uSURwDscN9fsM+/CS8XRS6DW0mj1/aRkjs7mjGCV+y9Xt1ns3Dwn+AJ/Rk9pt1oeVWIxUOYzqD3XQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYFZTPPh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748883738; x=1780419738;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PAm0qcVMccKzdp3fnXKmqZ+vGp/mrw6+rOYNaWYB160=;
  b=VYFZTPPhKiBC/Sb/trqgppHvCfCTCvHE0aM6AE5jhRhwGTG9hloTN2UC
   5Q8Pqbcfz6ldGmodh71fJB9piXu/4oIsrO/tx2bAuw2jMfMNW8xoFWT45
   y8hytDNy8kwxAg4M+UPLG2E5253MPCWfghjQxPMtzSFS0wFQmLy1PGWSK
   Tn9geGBehI7yk/dt5j/7TUYRlEeLkjPwhNRtXae7pBQ5Kll4q/GuwtjnG
   me/PLHb7cKEJwYtnWhxKvPIG8zV5csT8n/trrqsmEBspXWNqJvEEkkelu
   7g8YTDWr2zoMcJ3sd7UGRzS9OwJfkLHD/K/zuMRZjjgwjGNasobFr4hY2
   g==;
X-CSE-ConnectionGUID: FVMqi/LnTAWDDBGtGiNEYA==
X-CSE-MsgGUID: O4AEIlrfRqSBJXxBFiIyZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="51045532"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="51045532"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 10:02:17 -0700
X-CSE-ConnectionGUID: z/pjBT1NRjuZhrsoXUAvOw==
X-CSE-MsgGUID: z/gChtcpR1WIx6vBj/unYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="148451524"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 10:02:16 -0700
Date: Mon, 2 Jun 2025 10:02:15 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Zaid Alali <zaidal@os.amperecomputing.com>, rafael@kernel.org,
	lenb@kernel.org, james.morse@arm.com, robert.moore@intel.com,
	Jonathan.Cameron@huawei.com, ira.weiny@intel.com,
	Benjamin.Cheatham@amd.com, dan.j.williams@intel.com, arnd@arndb.de,
	Avadhut.Naik@amd.com, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 9/9] ACPI: APEI: EINJ: Update the documentation for
 EINJv2 support
Message-ID: <aD3ZFyBW4SCyaGI9@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
 <aDuBjopy_nE9A-ph@agluck-desk3>
 <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250601102554.GAaDwqsgCODzEne7Ow@fat_crate.local>

On Sun, Jun 01, 2025 at 12:25:54PM +0200, Borislav Petkov wrote:
> Some questions inline...
> 
> On Sat, May 31, 2025 at 03:24:14PM -0700, Luck, Tony wrote:
> > EINJ V2 allows the user to perform multiple injections together.
> > 
> > The component_idN/component_syndromeN pairs of files direct the
> > "where" and the "what" of each injection.
> > 
> > But the kernel needs to know how many of these pairs to use
> > for an injection (to fill in a field in the structure passed
> > to the BIOS).
> 
> The kernel could realloc on each write. Or we could allocate the struct to max
> elems and trim it before passing it down to BIOS.

The actual structure passed to BIOS is the same each time. Just the
set_error_type_with_address::einjv2_struct::component_arr_count
changed to indicate how many errors to inject.  In theory the
driver could allocate and copy a correctly sized structure, but
Zaid's code here is simpler, an this is hardly a critical path.

> > User interface options:
> > 
> > 1) User can zero out the component_idN/component_syndromeN pairs
> > that they don't need and have the kernel count how many injections
> > are requested by looping to find the zero terminator.
> > 
> > 2) Kernel could zero all pairs after an injection to make the user
> > explicitly set the list of targets each time.
> > 
> > 3) User provides the count vis the nr_components file (perhaps
> > needs a better name?)
> 
> Yap, agree that the name is not optimal.

It can be dropped if we make the user zap previously supplied
component_idN/component_syndromeN pairs that are no longer
wanted.
> 
> User can inject into each component pairs file and the kernel can put that in
> the tracking struct. So you have:
> 
> # echo 4 > component_id0
> # echo A5A5A5A5 > component_syndrome0
> ... set other files and finish with usual
> # echo 1 > error_inject
> 
> <--- here, it goes through each component pair and builds the structure to
> pass down the BIOS.
> 
> And you track valid component pairs by setting the IDs to -1 or something else
> invalid.

This is just an improvement on my "option 1" (improved because all-ones
for the component ID is going to be invalid for sure, while all zeroes
could be a valid component).
> 
> All those component IDs which have remained invalid after the error_inject
> write happens, get ignored - you gather only those which are valid and inject.

Or just stop collecting on the first invalid one.

> And this way you can keep the old values too and gather them again and inject
> again, over and over again.
> 
> Right?

Yup.

-Tony

