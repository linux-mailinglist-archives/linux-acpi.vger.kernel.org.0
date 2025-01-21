Return-Path: <linux-acpi+bounces-10775-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35530A180D6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C13E73A5FDC
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Jan 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95D1F426A;
	Tue, 21 Jan 2025 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dro51Q5L"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D6B1F236B;
	Tue, 21 Jan 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737472466; cv=none; b=P0dBytSe+podb4RcQzfG4VuBJoLIHM57oqayMp4TgL+AClvEr/UO9DI8IGNsKYQykKHX+FF56WGXWe3gTDHTPHcWrKdQWbGlRg0mYwHG8+42JPcjDtPR0kEhn3CDn5gf3ECzp1Er3YmVvrUBpUlxpymHnfbrZmYymOT2BTnT2zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737472466; c=relaxed/simple;
	bh=4TvIpkR//X/2B4lC5Osk6jDUGZP4NLDKja57Tw9WoeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ePgj7F+R0CDVs+mwc8ik5JdcI/QVWDk089T3T0Un3k1gEeDa51+RqPTZukEvzJJhuFGODy3kZZqDdExZnLoe0GZMD3WrlvJ1eDk9ZLPfg3+xLwhpX0WCz775FOgeTdR9FyKfsXG0jga8dEjqCNa/SN+9rQAwonihrhpZRpBRWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dro51Q5L; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737472464; x=1769008464;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4TvIpkR//X/2B4lC5Osk6jDUGZP4NLDKja57Tw9WoeY=;
  b=Dro51Q5Ll6+BQNXIYfe4rj9k0S2hNaoHqjX1jBJnOA+kyVy4fWfBPBaU
   xwGyExRbknqsjhhn4pKZ5uxmug581M+9RFADQz4203buim3842uYCnPCA
   NKr2fhNSmlI85EW7zTjho7GLL6MP41ZnXyWNDiQ3opKRxyRZFe+ilfYfS
   N5nPZZR5cUnVmuO6sGmdEkhovONZFmRQ6nD+6rjwS75bjLJNHZGQ5oh8J
   OWcgKnIgUa/j040R6XRLBfuGN7E6WvR7psIqXI2bG7Xhw88o77DbOYcGI
   mnVesu7xh3D7zdtmTgo6Lz+fz9pZc5uN5qR37jEuip8tkFu7vnt1Y21jn
   w==;
X-CSE-ConnectionGUID: /Ixg8J85TVSAszhpiG8H8Q==
X-CSE-MsgGUID: vewSCdlCT5eNQnqaPgaXrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="55439862"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="55439862"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:14:23 -0800
X-CSE-ConnectionGUID: GJ9Ms4O2RT2JFC302RZy0g==
X-CSE-MsgGUID: xa0wytn+SvSGRSu1EtXe2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="111827566"
Received: from ehanks-mobl1.amr.corp.intel.com (HELO [10.125.110.49]) ([10.125.110.49])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:14:22 -0800
Message-ID: <a7b54993-82ec-49cb-8cf6-fa06e6ce381b@intel.com>
Date: Tue, 21 Jan 2025 08:14:21 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cxl: Add mce notifier to emit aliased address for
 extended linear cache
To: Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-5-dave.jiang@intel.com>
 <842f4604-2444-45c3-b8f2-ea97a9299671@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <842f4604-2444-45c3-b8f2-ea97a9299671@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/19/25 10:05 PM, Li Ming wrote:
> On 1/18/2025 1:28 AM, Dave Jiang wrote:
>> Below is a setup with extended linear cache configuration with an example
>> layout of memory region shown below presented as a single memory region
>> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
>> The kernel sees a region of total 256G of system memory.
>>
>>               128G DRAM                          128G CXL memory
>> |-----------------------------------|-------------------------------------|
>>
>> Data resides in either DRAM or far memory (FM) with no replication. Hot
>> data is swapped into DRAM by the hardware behind the scenes. When error is
>> detected in one location, it is possible that error also resides in the
>> aliased location. Therefore when a memory location that is flagged by MCE
>> is part of the special region, the aliased memory location needs to be
>> offlined as well.
>>
>> Add an mce notify callback to identify if the MCE address location is part
>> of an extended linear cache region and handle accordingly.
>>
>> Added symbol export to set_mce_nospec() in x86 code in order to call
>> set_mce_nospec() from the CXL MCE notify callback.
>>
>> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>> v3:
>> - Add endpoint pointer check. (Ming)
>> - Add mce notifier removal. (Ming)
>> - Return ~0ULL for no cache alias.
>> ---
>>  arch/x86/mm/pat/set_memory.c |  1 +
>>  drivers/cxl/Kconfig          |  4 +++
>>  drivers/cxl/core/Makefile    |  1 +
>>  drivers/cxl/core/mbox.c      |  8 +++++
>>  drivers/cxl/core/mce.c       | 63 ++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/mce.h       | 16 +++++++++
>>  drivers/cxl/core/region.c    | 28 ++++++++++++++++
>>  drivers/cxl/cxl.h            |  6 ++++
>>  drivers/cxl/cxlmem.h         |  2 ++
>>  tools/testing/cxl/Kbuild     |  1 +
>>  10 files changed, 130 insertions(+)
>>  create mode 100644 drivers/cxl/core/mce.c
>>  create mode 100644 drivers/cxl/core/mce.h
>>
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 95bc50a8541c..a0df698f46a2 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2083,6 +2083,7 @@ int set_mce_nospec(unsigned long pfn)
>>  		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
>>  	return rc;
>>  }
>> +EXPORT_SYMBOL_GPL(set_mce_nospec);
>>  
>>  /* Restore full speculative operation to the pfn. */
>>  int clear_mce_nospec(unsigned long pfn)
>> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
>> index 876469e23f7a..d1c91dacae56 100644
>> --- a/drivers/cxl/Kconfig
>> +++ b/drivers/cxl/Kconfig
>> @@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
>>  	  If unsure, or if this kernel is meant for production environments,
>>  	  say N.
>>  
>> +config CXL_MCE
>> +	def_bool y
>> +	depends on X86_MCE && MEMORY_FAILURE
>> +
>>  endif
>> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
>> index 1a0c9c6ca818..61c9332b3582 100644
>> --- a/drivers/cxl/core/Makefile
>> +++ b/drivers/cxl/core/Makefile
>> @@ -17,3 +17,4 @@ cxl_core-y += cdat.o
>>  cxl_core-y += acpi.o
>>  cxl_core-$(CONFIG_TRACING) += trace.o
>>  cxl_core-$(CONFIG_CXL_REGION) += region.o
>> +cxl_core-$(CONFIG_CXL_MCE) += mce.o
>> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>> index f42c4c56dc43..ad11f49cb117 100644
>> --- a/drivers/cxl/core/mbox.c
>> +++ b/drivers/cxl/core/mbox.c
>> @@ -11,6 +11,7 @@
>>  
>>  #include "core.h"
>>  #include "trace.h"
>> +#include "mce.h"
>>  
>>  static bool cxl_raw_allow_all;
>>  
>> @@ -1458,6 +1459,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>  {
>>  	struct cxl_memdev_state *mds;
>> +	int rc;
>>  
>>  	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>>  	if (!mds) {
>> @@ -1473,6 +1475,12 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>>  
>> +	cxl_register_mce_notifier(&mds->mce_notifier);
>> +	rc = devm_add_action_or_reset(dev, cxl_unregister_mce_notifier,
>> +				      &mds->mce_notifier);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
> 
> maybe we can put this devm release action into cxl_register_mce_notifier() and rename cxl_register_mce_notifier() to devm_cxl_register_mce_notifier()?

ok I'll do that

> 
> 
>>  	return mds;
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
>> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
>> new file mode 100644
>> index 000000000000..dab5acce249e
>> --- /dev/null
>> +++ b/drivers/cxl/core/mce.c
>> @@ -0,0 +1,63 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>> +#include <linux/mm.h>
>> +#include <linux/notifier.h>
>> +#include <linux/set_memory.h>
>> +#include <asm/mce.h>
>> +#include <cxlmem.h>
>> +#include "mce.h"
>> +
>> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>> +			  void *data)
>> +{
>> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
>> +						    mce_notifier);
>> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct mce *mce = data;
>> +	u64 spa, spa_alias;
>> +	unsigned long pfn;
>> +
>> +	if (!mce || !mce_usable_address(mce))
>> +		return NOTIFY_DONE;
>> +
>> +	if (!endpoint)
>> +		return NOTIFY_DONE;
>> +
>> +	spa = mce->addr & MCI_ADDR_PHYSADDR;
>> +
>> +	pfn = spa >> PAGE_SHIFT;
>> +	if (!pfn_valid(pfn))
>> +		return NOTIFY_DONE;
>> +
>> +	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
>> +	if (spa_alias == ~0ULL)
>> +		return NOTIFY_DONE;
>> +
>> +	pfn = spa_alias >> PAGE_SHIFT;
>> +
>> +	/*
>> +	 * Take down the aliased memory page. The original memory page flagged
>> +	 * by the MCE will be taken cared of by the standard MCE handler.
>> +	 */
>> +	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address0: %#llx\n",
>> +		  spa_alias);
>> +	if (!memory_failure(pfn, 0))
>> +		set_mce_nospec(pfn);
>> +
>> +	return NOTIFY_OK;
>> +}
>> +
>> +void cxl_register_mce_notifier(struct notifier_block *mce_notifier)
>> +{
>> +	mce_notifier->notifier_call = cxl_handle_mce;
>> +	mce_notifier->priority = MCE_PRIO_UC;
>> +	mce_register_decode_chain(mce_notifier);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_register_mce_notifier, "CXL");
>> +
>> +void cxl_unregister_mce_notifier(void *mce_notifier)
>> +{
>> +	mce_unregister_decode_chain(mce_notifier);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_mce_notifier, "CXL");
> 
> My understanding is that these two functions are no need to be exported, because they are invoked inside cxl_core.ko.
> 
> I check that they are not exported in v2, any reason for this change?

It seems cxl_test needed the export. 
> 
> 
> Ming
> 


