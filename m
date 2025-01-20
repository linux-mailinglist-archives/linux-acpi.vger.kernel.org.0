Return-Path: <linux-acpi+bounces-10760-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28FA16649
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 06:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0107A3AA80B
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2025 05:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B751684A4;
	Mon, 20 Jan 2025 05:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AfwPl5vF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB4D2F30;
	Mon, 20 Jan 2025 05:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737349714; cv=pass; b=EpErGKjd2OkpRytW9oH2SwoFOF0zrTUuirQ/ZzQj4CXAq5AChWgMs8qP4qg2g10frNwEwk+0eHv3YGOaXIlxIayWj9gu/e87n/iEZ0dprFyZ66kmoSutWJNhFV/cAjpvgP4KE2J8pjrs6za8nlLYLaDQviHA2N87x64aoiYAM0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737349714; c=relaxed/simple;
	bh=L5L+rPLH0rrdJx9JIdFvvf3WcfAV2BX+peqrJ4+T1vA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7jphqTRUh0CE9IHdtUwzCFX3+3hm2GFQyBx2UPqe4FLhic/QtPSWwaNZCIl4rc6RBLQrfSENiOgQDiJTSzfAAcFO+1WD8ZNSk09h3beroCU0e0TxKvFEIEJ4aCf2yXJYesoMOGbH/2ua3LddV1RjIJk0JfcffoZ9awagFqEQZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AfwPl5vF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1737349565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dd+LgfPbNgUIr15sPvQu9Yi3FeSd2yiA5CghXwzgF/hJxcbPJChhq+5+b8XdzlsUpBz6x92ee8yEcEV9ySs2wq5/JMjntD4RWFFmQC/CVRC6GsHSzT9Akk9HIJU6iLc/9j2O9OGAwskBKgLyUQF/v/NZU/C/mQIaJexHl6h4NUw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1737349565; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NjFuB/fstdxeC8VzsYGdqjeEf8Co8tSinnGYnTlY9wc=; 
	b=DdJv2/KEpczOnhAm1Da5Nm4YxOUDXmG44oZrOwvT/Yjed48F8fJIiWaaYXAJwsNhOWtFxoAZ20rwn+z8qzTW1FGXLIdxxnlJN9bQrzPBJDtlO6MiqDHF6cVk5fqYuM0G4W6LycynPGdgFMo3nAwknfNrKf6V7w73ThVnY2nsVDA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1737349565;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=NjFuB/fstdxeC8VzsYGdqjeEf8Co8tSinnGYnTlY9wc=;
	b=AfwPl5vFLS4z/R+lWGKI+tamRCepC13l/6yp6iC6VoNgpPdClZ884YaeOMqRaJAV
	3VsDgiyg1LI/Wp8z7ggjdxL5JiUVBfxqE0iqBSCcjhFY/J5kpDgxJB5wMId/eEWYAFD
	+IGq/1YwPrOWQ2aBDVuDKp7eVIx8mwY2eebjnuY8=
Received: by mx.zohomail.com with SMTPS id 1737349562998185.53266009921253;
	Sun, 19 Jan 2025 21:06:02 -0800 (PST)
Message-ID: <842f4604-2444-45c3-b8f2-ea97a9299671@zohomail.com>
Date: Mon, 20 Jan 2025 13:05:58 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] cxl: Add mce notifier to emit aliased address for
 extended linear cache
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-acpi@vger.kernel.org
Cc: rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
 tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, ira.weiny@intel.com
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-5-dave.jiang@intel.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250117173054.4147877-5-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122766e80ba439f4ad05398228710000fb79fde2150372fca3f7b118fe818c78067e90031a13eb3ada:zu08011227c666930302942366d1f481000000a865f425dc3c5ffe689be044e94e4933ada9b7faf6eda9799a:rf0801122ddbf496c40d5b512b7e9c1f390000b7e8d604b9d4fddc267a41d075a92902ba731e47c128b86aa88464d2063e33:ZohoMail
X-ZohoMailClient: External

On 1/18/2025 1:28 AM, Dave Jiang wrote:
> Below is a setup with extended linear cache configuration with an example
> layout of memory region shown below presented as a single memory region
> consists of 256G memory where there's 128G of DRAM and 128G of CXL memory.
> The kernel sees a region of total 256G of system memory.
>
>               128G DRAM                          128G CXL memory
> |-----------------------------------|-------------------------------------|
>
> Data resides in either DRAM or far memory (FM) with no replication. Hot
> data is swapped into DRAM by the hardware behind the scenes. When error is
> detected in one location, it is possible that error also resides in the
> aliased location. Therefore when a memory location that is flagged by MCE
> is part of the special region, the aliased memory location needs to be
> offlined as well.
>
> Add an mce notify callback to identify if the MCE address location is part
> of an extended linear cache region and handle accordingly.
>
> Added symbol export to set_mce_nospec() in x86 code in order to call
> set_mce_nospec() from the CXL MCE notify callback.
>
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Add endpoint pointer check. (Ming)
> - Add mce notifier removal. (Ming)
> - Return ~0ULL for no cache alias.
> ---
>  arch/x86/mm/pat/set_memory.c |  1 +
>  drivers/cxl/Kconfig          |  4 +++
>  drivers/cxl/core/Makefile    |  1 +
>  drivers/cxl/core/mbox.c      |  8 +++++
>  drivers/cxl/core/mce.c       | 63 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/mce.h       | 16 +++++++++
>  drivers/cxl/core/region.c    | 28 ++++++++++++++++
>  drivers/cxl/cxl.h            |  6 ++++
>  drivers/cxl/cxlmem.h         |  2 ++
>  tools/testing/cxl/Kbuild     |  1 +
>  10 files changed, 130 insertions(+)
>  create mode 100644 drivers/cxl/core/mce.c
>  create mode 100644 drivers/cxl/core/mce.h
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 95bc50a8541c..a0df698f46a2 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2083,6 +2083,7 @@ int set_mce_nospec(unsigned long pfn)
>  		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(set_mce_nospec);
>  
>  /* Restore full speculative operation to the pfn. */
>  int clear_mce_nospec(unsigned long pfn)
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 876469e23f7a..d1c91dacae56 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -146,4 +146,8 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> +config CXL_MCE
> +	def_bool y
> +	depends on X86_MCE && MEMORY_FAILURE
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1a0c9c6ca818..61c9332b3582 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -17,3 +17,4 @@ cxl_core-y += cdat.o
>  cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_MCE) += mce.o
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f42c4c56dc43..ad11f49cb117 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -11,6 +11,7 @@
>  
>  #include "core.h"
>  #include "trace.h"
> +#include "mce.h"
>  
>  static bool cxl_raw_allow_all;
>  
> @@ -1458,6 +1459,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> +	int rc;
>  
>  	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
>  	if (!mds) {
> @@ -1473,6 +1475,12 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> +	cxl_register_mce_notifier(&mds->mce_notifier);
> +	rc = devm_add_action_or_reset(dev, cxl_unregister_mce_notifier,
> +				      &mds->mce_notifier);
> +	if (rc)
> +		return ERR_PTR(rc);
> +

maybe we can put this devm release action into cxl_register_mce_notifier() and rename cxl_register_mce_notifier() to devm_cxl_register_mce_notifier()?


>  	return mds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, "CXL");
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> new file mode 100644
> index 000000000000..dab5acce249e
> --- /dev/null
> +++ b/drivers/cxl/core/mce.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +#include <linux/mm.h>
> +#include <linux/notifier.h>
> +#include <linux/set_memory.h>
> +#include <asm/mce.h>
> +#include <cxlmem.h>
> +#include "mce.h"
> +
> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> +			  void *data)
> +{
> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
> +						    mce_notifier);
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct mce *mce = data;
> +	u64 spa, spa_alias;
> +	unsigned long pfn;
> +
> +	if (!mce || !mce_usable_address(mce))
> +		return NOTIFY_DONE;
> +
> +	if (!endpoint)
> +		return NOTIFY_DONE;
> +
> +	spa = mce->addr & MCI_ADDR_PHYSADDR;
> +
> +	pfn = spa >> PAGE_SHIFT;
> +	if (!pfn_valid(pfn))
> +		return NOTIFY_DONE;
> +
> +	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
> +	if (spa_alias == ~0ULL)
> +		return NOTIFY_DONE;
> +
> +	pfn = spa_alias >> PAGE_SHIFT;
> +
> +	/*
> +	 * Take down the aliased memory page. The original memory page flagged
> +	 * by the MCE will be taken cared of by the standard MCE handler.
> +	 */
> +	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address0: %#llx\n",
> +		  spa_alias);
> +	if (!memory_failure(pfn, 0))
> +		set_mce_nospec(pfn);
> +
> +	return NOTIFY_OK;
> +}
> +
> +void cxl_register_mce_notifier(struct notifier_block *mce_notifier)
> +{
> +	mce_notifier->notifier_call = cxl_handle_mce;
> +	mce_notifier->priority = MCE_PRIO_UC;
> +	mce_register_decode_chain(mce_notifier);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_mce_notifier, "CXL");
> +
> +void cxl_unregister_mce_notifier(void *mce_notifier)
> +{
> +	mce_unregister_decode_chain(mce_notifier);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_mce_notifier, "CXL");

My understanding is that these two functions are no need to be exported, because they are invoked inside cxl_core.ko.

I check that they are not exported in v2, any reason for this change?


Ming


