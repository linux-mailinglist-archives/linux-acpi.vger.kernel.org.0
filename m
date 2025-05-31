Return-Path: <linux-acpi+bounces-14040-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C566AC9D47
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 00:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 706C018977E8
	for <lists+linux-acpi@lfdr.de>; Sat, 31 May 2025 22:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C01DDC18;
	Sat, 31 May 2025 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eX0qyU+s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318BC1E515;
	Sat, 31 May 2025 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748730258; cv=none; b=F/APxBxa3My5NZbM9BmVOxRfLHyhAcdig6k4u4vWfgqKp8c4tdg0ioqT9pLrRYLceYoKPZgTsFKCVEo04OYBUyQhWfk+XmtrOtXoOVehTn3CRbUvl8Y8lG1t4xDFPfkJmThJpPVBRDbVTsehYuoncRL8wcBAMEIwirKFjbvOLng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748730258; c=relaxed/simple;
	bh=/OT6BcuQ0bwLw4PLGhYig6PRzvZSfY49od4+Eb2T+R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1HVzy/ZUAcpLDFb+hr4j1VX9MA34t0shFEdOml9Q8Yw3KfGypL7MJN/8k2RjUzRFXU56cWhK7PZ6caGuoweBEnHZBPQUS7kDEhi53604PPesrrYebBbale6ykA7zO7V1nVVEvEbAhzgWX1r7XJ4N2bhe5Wv42y2zJw9VuzBc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eX0qyU+s; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748730258; x=1780266258;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/OT6BcuQ0bwLw4PLGhYig6PRzvZSfY49od4+Eb2T+R4=;
  b=eX0qyU+sUxabFn20trCyHR2zy7K9JMFUW3HsRgUWsrUKjdO+FCg2ADKk
   t9O4gYHRX1Hs1DBGQazns/8O7gw67ySutiZyDEB2jmsZR3CfIljPKLKV7
   T9Dmkoq22vRsF1WqsFcdmiszfZxAtIWSez+IZGgQM4nxT+oWwez8Ejlj7
   pI6DEZajHeMfUfdyFP23I2cIwt06wIQzV+lsYRPG5teBl2zFGZ7mgaRwl
   qQw6Yd77Q2+0Kmm2ezqv0feTgyr85PqHaLMfJ0Y0XauazH4QVJpw+lXAO
   YAWyc0o/SWOsoOS499AO0ge0JZsglwpKBECgfNq4funHX/ZTOdXasJwBy
   g==;
X-CSE-ConnectionGUID: s77bKskrSzmPl0bf3Kw0xw==
X-CSE-MsgGUID: 0wJQPZAiQVi9QwMjFG0+Gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="54588796"
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="54588796"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 15:24:17 -0700
X-CSE-ConnectionGUID: hvIVU3ssSIm/7tNqdg2kGw==
X-CSE-MsgGUID: HayCyTs5Q1qP/nfJsbkbzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,199,1744095600"; 
   d="scan'208";a="144095998"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2025 15:24:16 -0700
Date: Sat, 31 May 2025 15:24:14 -0700
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
Message-ID: <aDuBjopy_nE9A-ph@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-10-zaidal@os.amperecomputing.com>
 <20250530102711.GAaDmH_1O7lc6kuveY@fat_crate.local>
 <aDoal24J-BMTIBCq@agluck-desk3>
 <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250531092050.GBaDrJ8iw7cNcpOKeA@fat_crate.local>

On Sat, May 31, 2025 at 11:20:50AM +0200, Borislav Petkov wrote:
> On Fri, May 30, 2025 at 01:52:39PM -0700, Luck, Tony wrote:
> > Use case to inject to one device would be:
> > 
> > # echo 1 > nr_components
> 
> What does that do?

EINJ V2 allows the user to perform multiple injections together.

The component_idN/component_syndromeN pairs of files direct the
"where" and the "what" of each injection.

But the kernel needs to know how many of these pairs to use
for an injection (to fill in a field in the structure passed
to the BIOS).

With EINJ V2 the user might want to inject to 2 locations with
one injection, and then just to 1 location on the next.

Zaid Alali's version took the approach of zeroing the input
after each injection so the user had to start from scratch
for each injection.

I wasn't fond of that because the existing Linux EINJ interface
saves all the paramters allowing the user to repeat the same
injection by just runniing "echo 1 > error_inject: over and over
(e.g. to force a soft offline by injecting multiple corrected
errors to the same address).

User interface options:

1) User can zero out the component_idN/component_syndromeN pairs
that they don't need and have the kernel count how many injections
are requested by looping to find the zero terminator.

2) Kernel could zero all pairs after an injection to make the user
explicitly set the list of targets each time.

3) User provides the count vis the nr_components file (perhaps
needs a better name?)

4) Something else?

> 
> The interface probably needs a little refinement, but...
> 
> > # echo 4 > component_id0
> > # echo A5A5A5A5 > component_syndrome0
> > ... set other files and finish with usual
> > # echo 1 > error_inject
> > 
> > There isn't a fancy "debugfs_create_x128_le()" helper to manage these
> > 128-bit little endian numbers. So I've coded with the basic building
> > blocks (though using copy_from_user() and copy_to_user() feels like
> > back in the stone age). If there some helpers that I missed I'd be
> > happy to see that part simplified.
> > 
> > Patch is on top of the existing v7 set. Obviously it needs to be folded
> > back into the earlier patches to make a clean history that doesn't add
> > functions and then replace them with different code.
> 
> ... yes, definitely much better.
> 
> Thanks!

You are welcome.
> 
> -- 
> Regards/Gruss,
>     Boris.

-Tony

