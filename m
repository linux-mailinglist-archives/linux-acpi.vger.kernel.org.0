Return-Path: <linux-acpi+bounces-11501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0D1A46D80
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 22:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC53188A5A2
	for <lists+linux-acpi@lfdr.de>; Wed, 26 Feb 2025 21:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C1B25A655;
	Wed, 26 Feb 2025 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OKywNdjf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8790C226D12;
	Wed, 26 Feb 2025 21:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605485; cv=none; b=lL/NA/kuU0jjvZ4h/l+NamtmxKuwW005F4ezqtVsJTYBf5YCWeMKdfY3bugLW5JyhXNs8ugiCCkjCuZDWMER9B7Hi6jw50hGUb421sUGKe+led2uh2vE/plVqjwKLf3zwyuv7LipsTqq5inBJTKI57BO/w3l54gKLiocOXItjws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605485; c=relaxed/simple;
	bh=yH552KIZnT+3BDdJ5B61rVruiEu0IYKP62NYot6DI24=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TRi/XL7nrwpnOdZ7q7QAQPtgy6aIwtkNJ2AJAySjF0Qox1ScqJaDU3dbGSg3HSZMy1bveD9HWjxEejLOUEAHjpLtqNW9rTWUXy/ZHJ5XhzGi6jFpnj+VABmZQyETC6GHdW2w2w9SDM9z4Zt6P8WMQJB/X2WDi/1DnumOV6a/5gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OKywNdjf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740605484; x=1772141484;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=yH552KIZnT+3BDdJ5B61rVruiEu0IYKP62NYot6DI24=;
  b=OKywNdjfv1SPF91eS1TRC0JCq9kUbUElqkchcBq3nuCwPbl67yTm5AkH
   wOm2LzVrApIAQKc6upICTQ5TrDK1X/1QEt3guwM5ZCv05t6SJilin9Zyk
   dnB4rE6WOYD0HRJNzVEuFGP+91vhMq7hYwDshfJ0lTWOa/7KBtd3ZvJlZ
   x8Zo7Zuh3kMydmYkVa/spxpQpLIig0xNzctSpQ2tK+EClkkXAbcBXhlQX
   Lm55oVjnN2w8DwwBAo2w3+91BrBwmPEaU4W+ivQKUWFTeDMR290E4GAfL
   o/n2qKLLQAQf/S+MOgrmvFVTCvVLM2sMiceRQm3WFcVfFw5NuhNx2LqF9
   Q==;
X-CSE-ConnectionGUID: /OABZhV/SRqE5OH2oSiVPA==
X-CSE-MsgGUID: 0Fb8tupURPaUF2eU8oBSkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52464431"
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="52464431"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:31:23 -0800
X-CSE-ConnectionGUID: gJjyUcBFQrelofgP74LWfg==
X-CSE-MsgGUID: +N8FfdR5SButsZzountYaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,318,1732608000"; 
   d="scan'208";a="116634718"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.108.7]) ([10.125.108.7])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 13:31:22 -0800
Message-ID: <d8459e65-74df-4ce8-8475-cd9badc19a82@intel.com>
Date: Wed, 26 Feb 2025 14:31:18 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] acpi/hmat / cxl: Add exclusive caching enumeration
 and RAS support
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com, ming.li@zohomail.com
References: <20250226162224.3633792-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20250226162224.3633792-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/25 9:21 AM, Dave Jiang wrote:
> v5:
> - Update couple dev_dbg() emits. (Alison)
> - Add hpa_alias emits for poison events. (Alison)
> - Drop cxlr_hpa_cache_alias() and opencode the one invocation. (Alison)
> - See individual patches for detailed changes.

Applied to cxl/next

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
> 


