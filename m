Return-Path: <linux-acpi+bounces-13941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF733AC8044
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 17:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9E3188B980
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 15:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6499822CBEA;
	Thu, 29 May 2025 15:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4m3XRav"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C021CC63;
	Thu, 29 May 2025 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532489; cv=none; b=RMaXL5enEmjFwoBf1zxE+nkBsGN9HVGbWhUMb0ZUuDlznpSwGOjMlxH8TRDhQuqfA8XrDIZp5coiBo2nK9xWLIXEvcLvF1i5mTJ8uIkGkOaItDsaD6yqqUob9DInx0K7mbRoe9Bp+sY7ShP6pmhOw3hSdXbtrDkhd1OvieHtvPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532489; c=relaxed/simple;
	bh=yPFET+cnqeHQaXJ8X3deZZadSpN1vopNPMuqCZp9UZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7+T7ZKW1H0ccpRMAZsm0oDlKmY+sJnHzvTo499KgPICfBvu8RLQxTCt0bKfZwRkyl5pkwTRlQq4fD8DAnEyzlXM7z91YiF0jg5Wu/XhzuC9LS/jkz1Nyv5UR3LcH7mh5Ps1j+oHTWqXNvD6FGffkrguXD6ZGwSFrTKOX+UAaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4m3XRav; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748532488; x=1780068488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yPFET+cnqeHQaXJ8X3deZZadSpN1vopNPMuqCZp9UZw=;
  b=Q4m3XRavVOUydTSGQ5TeKzWXISYUBlxeN9YDTDR7phUJeB9W2kYcurXL
   /LTQWmEJYSk0oWnfZU7iFrpwNsX6qf4cPzaN/Bjkpq9/vP3+gH5HFaywF
   H0YCgw//oYVBC/mcdT2z4HgdfU3vEUUiE6XSyqllDgbcLDAaBOFAmXCUo
   xPQ0IyvF23ZvhQrpJ0xH0PrFHUAWCfpS/tV4BL9eW9EDRnFwAUTuIe8LG
   87VZCYXu4HUSwwiS+147jBcEiYGD0l/C2KvMpz0CpkFq5ZlAMXFPQJY1Y
   yVPULqn55/OuTS1hpI+XXcK19FfJW+3AK3Ks2WqYw+2FrjwaSseQy/gzr
   w==;
X-CSE-ConnectionGUID: EfliI7OkRp21FrMbTq2MJw==
X-CSE-MsgGUID: geIsYCG2SRqbzg5dbO1qug==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50654520"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="50654520"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:28:08 -0700
X-CSE-ConnectionGUID: 5eqefe/rQSiqkWpb7m7BFQ==
X-CSE-MsgGUID: r5RXPeHzS/W9NHUEnz/Y+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="148749765"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 08:28:07 -0700
Date: Thu, 29 May 2025 08:28:05 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 6/9] ACPI: APEI: EINJ: Add einjv2 extension struct
Message-ID: <aDh9BfyNXvJvduDr@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-7-zaidal@os.amperecomputing.com>
 <aDdYPf-4ru_cC-_D@agluck-desk3>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDdYPf-4ru_cC-_D@agluck-desk3>

On Wed, May 28, 2025 at 11:38:54AM -0700, Luck, Tony wrote:
> On Tue, May 06, 2025 at 02:38:10PM -0700, Zaid Alali wrote:
> >  struct set_error_type_with_address {
> >  	u32	type;
> >  	u32	vendor_extension;
> > @@ -58,6 +80,7 @@ struct set_error_type_with_address {
> >  	u64	memory_address;
> >  	u64	memory_address_range;
> >  	u32	pcie_sbdf;
> > +	struct	einjv2_extension_struct einjv2_struct;
> 
> I can't make this match up with the ACPI v6.5 spec.  The spec defines
> a whole new EINJV2_SET_ERROR_TYPE data structure in table 18.34 that
> is NOT just a simple addition of new fields at the end of the existing
> SET_ERROR_TYPE_WITH_ADDRESS data structure. E.g. the "flags" are now
> in a 3-byte field at offset 5 instead of a 4-byte field at offset 8.
> There is a new "length" field that descibes the total size of the
> structure including the new flex array of syndrome values at the
> end.

Someone pointed me to the ACPI 6.5 Errata A spec: https://uefi.org/specs/ACPI/6.5_A/

This code does match with the description there.

I'll continue looking at your patches with this as the reference.

Please make sure to reference this spec directly (not buried in links
to tianocore bugzilla entries) when you post next version.

-Tony

