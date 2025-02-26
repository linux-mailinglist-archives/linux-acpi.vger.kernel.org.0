Return-Path: <linux-acpi+bounces-11499-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E456A46804
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB26E188280C
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 17:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DF21D59E;
	Wed, 26 Feb 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ut3Fkzzb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14EE212FB4;
	Wed, 26 Feb 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740590849; cv=none; b=hJ7ZgEJxACt15CfgUoBbEzC1TKarwqhNub3GjV/pWczNi0KQ6IeWje3JqT3vNyrRYXgPLgcecXa3G3iVv+ir+Ldbsf+qK252I8g5tUELBIHi9MdrsqlhUHZjbO5N0jcIMSpF5ghy5O1eCl5gxaPIVg1kgV/5HQBIwDetP6szBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740590849; c=relaxed/simple;
	bh=asV1/VRyl3y0f4o7SCuR0BWO5P75NgOs218yh3ITV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS/Qmj5vCHyFYtCyJjGZuA+SmwBo3pIZ1IgQ3rdHnm0a08BD6zrZG+MZqsy/9VW9WrM+yPjjvn97daMV5A0Tffryjh9RhWVU1y4RcqZELbwoTYBfOCkQD2meLLvtM5aUFBbHQKUD7OHbynUSZkUzZSaNG/J9vIuER/84H4VvRR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ut3Fkzzb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740590848; x=1772126848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asV1/VRyl3y0f4o7SCuR0BWO5P75NgOs218yh3ITV5Y=;
  b=Ut3FkzzbGhGzhOPS5O4crypgPGnG8ao5AqRJlO0mgIG14kb406IYs55K
   Ji+akmpuj0vU8wVQRFnOn/DBg3/XwayBXi+Yk/+BJWsc8iuxoFRZoQtTW
   kQLc0klZYR4qHhbZvZlbKXgYjkFxF8Yd4SpSmtFnYOwy43mO2xRY6Ohgp
   MwcZLpyxeoi26qkQKGiEA0ghkmDvXQ2+Laf4gfwZL2IrPdOVQuu1FEpMZ
   /b/ljek7TOlynvJbBur5XE2n0y14F+tU88cQ8pS0WUOYZ/i8me9C3YPiS
   0u1s/at00YE+zOy1nge0aHIcB8rCFBCGcQRPeI/q1pdJpxJjMAZOSvRmg
   g==;
X-CSE-ConnectionGUID: fm81DDyVTS2rSypxUvJAfg==
X-CSE-MsgGUID: aXUhrep3QAqqNNUhOYXArA==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="51660144"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="51660144"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:27:27 -0800
X-CSE-ConnectionGUID: Smqy06UkTmG2T1SHIDXxNA==
X-CSE-MsgGUID: kXJ/hHwtSQKv4Dm5gjj2Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="139985924"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.13])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:27:26 -0800
Date: Wed, 26 Feb 2025 09:27:24 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v5 0/4] acpi/hmat / cxl: Add exclusive caching
 enumeration and RAS support
Message-ID: <Z79O_BLI7SCrEhEQ@aschofie-mobl2.lan>
References: <20250226162224.3633792-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226162224.3633792-1-dave.jiang@intel.com>

On Wed, Feb 26, 2025 at 09:21:17AM -0700, Dave Jiang wrote:

With the small fixup needed in Patch 3/4, you can add my tag
for the series:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> v5:
> - Update couple dev_dbg() emits. (Alison)
> - Add hpa_alias emits for poison events. (Alison)
> - Drop cxlr_hpa_cache_alias() and opencode the one invocation. (Alison)
> - See individual patches for detailed changes.
> 
> v4:
> - Add alias adjustment for cxl_dpa_to_hpa() (Alison)
> - Add check of adjusted region start against CFMWS (Alison)
> - Use ULLONG_MAX consistently. (Alison)
> - Use hpa_alias0 consistently. (Alison)
> - Move devm_add_action_or_reset() to devm_cxl_add_mce_notifier(). (Ming)
> - See individual patches for detailed changes.
> 
> v3:
> - Drop region to nid function, deadcode.
> - Set hpa_alias default to ~0ULL to indicate no alias. (Jonathan)
> - Add endpoint check for mce handler. (Ming)
> - Add mce notifier unregister. (Ming)
> 
> v2:
> - Fix 0-day issues
> - Fix checking of cache flag. (Ming)
> - Add comment about cache range vs CFMWS. (Ming)
> - Update EXPORT_SYMBOL_(). (Jonathan)
> - Fix various code comments. (Jonathan)
> - Emit hpa_alias0 instead of hpa_alias. (Jonathan)
> - Introduce CONFIG_CXL_MCE to address kernel build dep issues.
> 
> v1:
> - Drop RFC prefix
> - Drop MMIO hole discovery. Will implement if there's real world implementation.
> - Drop MCE_PRI_CXL. Use MCE_PRI_UC. (Boris)
> - Minor refactors and grammar fixes. (Jonathan)
> - Rename 'mode' to 'address_mode'. (Jonathan)
> 
> RFCv2:
> - Dropped 1/6 (ACPICA definition merged)
> - Change UNKNOWN to RESERVED for cache definition. (Jonathan)
> - Fix spelling errors (Jonathan)
> - Rename region_res_match_range() to region_res_match_cxl_range(). (Jonathan)
> - Add warning when cache is not 1:1 with backing region. (Jonathan)
> - Code and comments cleanup. (Jonathan)
> - Make MCE code access in CXL arch independent. (Jonathan)
> - Fixup 0-day reports.
> 
> Certain systems provide an exclusive caching memory configurations where a
> 1:1 layout of DRAM and far memory (FM) such as CXL memory is utilized. In
> this configuration, the memory region is provided as a single memory region
> to the OS. For example such as below:
> 
>              128GB DRAM                         128GB CXL memory
> |------------------------------------|------------------------------------|
> 
> The kernel sees the region as a 256G system memory region. Data can reside
> in either DRAM or FM with no replication. Hot data is swapped into DRAM by
> the hardware behind the scenes.
> 
> This kernel series introduces code to enumerate the side cache by the kernel
> when configured in a exclusive-cache configuration. It also adds RAS support
> to deal with the aliased memory addresses.
> 
> A new ECN [1] to ACPI HMAT table was introduced and was approved to describe
> the "extended-linear" addressing for direct-mapped memory-side caches. A
> reserved field in the Memory Side Cache Information Structure of HMAT is
> redefined as "Address Mode" where a value of 1 is defined as Extended-linear
> mode. This value is valid if the cache is direct mapped. "It indicates that
> the associated address range (SRAT.MemoryAffinityStructure.Length) is
> comprised of the backing store capacity extended by the cache capacity." By
> augmenting the HMAT and SRAT parsing code, this new information can be stored
> by the HMAT handling code.
> 
> Current CXL region enumeration code is not enlightened with the side cache
> configuration and therefore only presents the region size as the size of the
> CXL region. Add support to allow CXL region enumeration code to query the HMAT 
> handling code and retrieve the information regarding the side cache and adjust
> the region size accordingly. This should allow the CXL CLI to display the
> full region size rather than just the CXL only region size.
> 
> There are 3 sources where the kernel may be notified that error is detected for
> memory.
> 1. CXL DRAM event. This is a CXL event that is generated when an error is
>    detected by the CXL device patrol or demand scrubber. The trace_event is
>    augmented to display the aliased System Phyiscal Address (SPA) in addition
>    to the alerted address.  However, reporting of memory failure is TBD until
>    the discussion [2] of failure reporting is settled upstream.
> 2. UCNA event from DRAM patrol or demand scrubber. This should eventually go
>    through the MCE callback chain.
> 3. MCE from kernel consume poison.
> 
> It is possible that all 3 sources may report at the same time and all report
> at the error.
> 
> For 2 and 3, a MCE notifier callback is registered by the CXL on a per device
> basis. The callback will determine if the reported address is in one of the
> special regions and offline the aliased address if that is the case.
> 
> [1]: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> [2]: https://lore.kernel.org/linux-cxl/20240808151328.707869-2-ruansy.fnst@fujitsu.com/
> 
> ---
> 
> Dave Jiang (4):
>       acpi: numa: Add support to enumerate and store extended linear address mode
>       acpi/hmat / cxl: Add extended linear cache support for CXL
>       cxl: Add extended linear cache address alias emission for cxl events
>       cxl: Add mce notifier to emit aliased address for extended linear cache
> 
>  Documentation/ABI/stable/sysfs-devices-node |   6 +++
>  arch/x86/mm/pat/set_memory.c                |   1 +
>  drivers/acpi/numa/hmat.c                    |  44 +++++++++++++++++++
>  drivers/base/node.c                         |   2 +
>  drivers/cxl/Kconfig                         |   4 ++
>  drivers/cxl/core/Makefile                   |   2 +
>  drivers/cxl/core/acpi.c                     |  11 +++++
>  drivers/cxl/core/core.h                     |   3 ++
>  drivers/cxl/core/mbox.c                     |  20 +++++++--
>  drivers/cxl/core/mce.c                      |  65 +++++++++++++++++++++++++++
>  drivers/cxl/core/mce.h                      |  20 +++++++++
>  drivers/cxl/core/region.c                   | 114 +++++++++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/trace.h                    |  31 ++++++++-----
>  drivers/cxl/cxl.h                           |   8 ++++
>  drivers/cxl/cxlmem.h                        |   2 +
>  include/linux/acpi.h                        |  11 +++++
>  include/linux/node.h                        |   7 +++
>  tools/testing/cxl/Kbuild                    |   2 +
>  18 files changed, 332 insertions(+), 21 deletions(-)
> 
>  base-commit: 0ad2507d5d93f39619fc42372c347d6006b64319

