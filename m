Return-Path: <linux-acpi+bounces-3511-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E8D85589C
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 02:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 209661C20616
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 01:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BC2EC7;
	Thu, 15 Feb 2024 01:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZof9KS4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9F01362;
	Thu, 15 Feb 2024 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707959494; cv=none; b=thV3/Q/+K4sEQMZ91s8HlYWKssFiNkHZoHEIaJdu44wyerFN5YIwLaPmoQJd4iTl5qcWp8uU1ubFC+INXlJqYVlgiRj2pG5i7OEGpFN8bxWhp4c/30l5w9FTYCDnjyKtxN+fco0mg3OeNk3qSo3inyORzJEMmK73xqzfFBCFanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707959494; c=relaxed/simple;
	bh=eK4p9fhH0bVjm6P8zlBk2snw4JQTb26GtnTnuCjk1fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fr5ijO8k7Bm5kJZNexTApBezdjJYebDJohXv1PDw+wlyKPYO9E7SxZUC6hkzKbPui9Da6hUgFHespKBZOpibcExF+dVcWM71szmeefSdnNJrL5zYsBTwta5NQy6JFkYKO7AC/NNeT5aiPKXzq3wD/VlivGWMVWrbAXDfM5p6Yt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZof9KS4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707959492; x=1739495492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eK4p9fhH0bVjm6P8zlBk2snw4JQTb26GtnTnuCjk1fk=;
  b=NZof9KS4CF3X+CQyhSG0vPIExU/y48rneAVCKjBfbSwI766gYeZpEIJO
   ABQ0Q3riuQUARJRJj6Cu5gy6TPniVhutyJQ3i67xE2lO6SI33SBULVtBC
   ADCMROIGntzO56gtJtdyw+eks0QbzBkqCAmSxUvcYzCOluVy73IK31ez0
   jP+XAnByozGFT2OaCqgvPNwCbhuybW5KjSQzjDnKKJqfmwqrWHjpQMRPS
   PmuBFf8NeIReEBUbPs/YnDpGF70dh+ITaroCFsyWKUQziIwXIQ6zBB/am
   aP94ooT4s8jV7OmegKAAvLCJPbgZYK92AWGVpL1hYlNfR9aOfQHhoOAL4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1905565"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1905565"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 17:11:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3691481"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 17:11:31 -0800
Date: Wed, 14 Feb 2024 17:11:29 -0800
From: Tony Luck <tony.luck@intel.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
Cc: dan.j.williams@intel.com, jonathan.cameron@huawei.com,
	rafael@kernel.org, james.morse@arm.com, bp@alien8.de,
	dave@stogolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v12 0/3] cxl, EINJ: Update EINJ for CXL error types
Message-ID: <Zc1kwWupeN9WagFj@agluck-desk3>
References: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214200709.777166-1-Benjamin.Cheatham@amd.com>

On Wed, Feb 14, 2024 at 02:07:06PM -0600, Ben Cheatham wrote:
> v12 Changes:
> 	- Rebase onto v6.8-rc4
> 	- Squash Kconfig patch into patch 2/3 (Jonathan)
> 	- Change CONFIG_CXL_EINJ from "depends on ACPI_APEI_EINJ >= CXL_BUS"
> 	  to "depends on ACPI_APEI_EINJ = CXL_BUS"
> 	- Drop "ACPI, APEI" part of commit message title and use just EINJ
> 	instead (Dan)
> 	- Add protocol error types to "einj_types" documentation (Jonathan)
> 	- Change 0xffff... constants to use GENMASK()
> 	- Drop param* variables and use constants instead in cxl error
> 	  inject functions (Jonathan)
> 	- Add is_cxl_error_type() helper function in einj.c (Jonathan)
> 	- Remove a stray function declaration in einj-cxl.h (Jonathan)
> 	- Comment #else/#endifs with corresponding #if/#ifdef in
> 	einj-cxl.h (Jonathan)
> 
> v11 Changes:
> 	- Drop patch 2/6 (Add CXL protocol error defines) and put the
> 	  defines in patch 4/6 instead (Dan)
> 	- Add Dan's reviewed-by
> 
> The new CXL error types will use the Memory Address field in the
> SET_ERROR_TYPE_WITH_ADDRESS structure in order to target a CXL 1.1
> compliant memory-mapped downstream port. The value of the memory address
> will be in the port's MMIO range, and it will not represent physical
> (normal or persistent) memory.
> 
> Add the functionality for injecting CXL 1.1 errors to the EINJ module,
> but not through the EINJ legacy interface under /sys/kernel/debug/apei/einj.
> Instead, make the error types available under /sys/kernel/debug/cxl.
> This allows for validating the MMIO address for a CXL 1.1 error type
> while also not making the user responsible for finding it.

I tried this series on an Intel Icelake (which as far as I know
doesn't support CXL).

Couple of oddities:

1) I built as a module (CONFIG_ACPI_APEI_EINJ=m) like I normally do.
   But this was autoloaded and EINJ initialized during boot:

[   33.909111] EINJ: Error INJection is initialized.

I'm wondering if that might be a problem for anyone that likes to
leave the einj module not loaded until they have some need to
inject errors.


2) Even though my system doesn't have any CXL support, I found this:

# cat /sys/kernel/debug/cxl/einj_types
0x00001000      CXL.cache Protocol Correctable

What does this mean?

Using ras-tools I injected some DDR memory errors. So legacy
functionality still works OK.

-Tony

