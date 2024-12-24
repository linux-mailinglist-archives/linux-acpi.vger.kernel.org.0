Return-Path: <linux-acpi+bounces-10292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 267A49FBD35
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 13:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827DB1885212
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 12:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70361B653E;
	Tue, 24 Dec 2024 12:18:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38583DDC5;
	Tue, 24 Dec 2024 12:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735042696; cv=none; b=X/2bgKfX3LZjLZD40syf0hQ+mEH41Cu/QShNkFPqGxh2u6HUDyWSrdoAAeEt5iEsL+gOpEvBQhMHj+oIT4D3+ozleEYZPdb1hi4a4PfBQ1GHzRmYUj30rqIgAcmGYmPb7xl+9LrP2904kDdxpxn5X8NDbIC2amcvrdXpF+lKjrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735042696; c=relaxed/simple;
	bh=wKXXfgGuVK51SEFt+YOZKJbK2fI7BR/n7Zm9VXMNcSA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSJsBVw72pPXeZ5KaYPLbF2zZkj2xJsqyZbRNxObWkTH6jYx5bBXkyIMKLR+t4GgyOGZ6g9ZYlXUfaBS9iEq3i06ilDfpNTE469q0DtSaQeil/aJlHyozlCvBH44Tw9HOBhOhv8EjeREYiG1uFI9037Xigmc/yuQ2ttERMedyhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHYmB6Vzjz6LDF0;
	Tue, 24 Dec 2024 20:16:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20607140447;
	Tue, 24 Dec 2024 20:18:12 +0800 (CST)
Received: from localhost (10.126.171.172) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 13:18:11 +0100
Date: Tue, 24 Dec 2024 12:18:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [PATCH 4/4] cxl: Add mce notifier to emit aliased address for
 extended linear cache
Message-ID: <20241224121809.0000439c@huawei.com>
In-Reply-To: <20241204224827.2097263-5-dave.jiang@intel.com>
References: <20241204224827.2097263-1-dave.jiang@intel.com>
	<20241204224827.2097263-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 4 Dec 2024 15:46:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

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
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A couple of minor editorial comments.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> new file mode 100644
> index 000000000000..f983822992a4
> --- /dev/null
> +++ b/drivers/cxl/core/mce.c
> @@ -0,0 +1,52 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
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
> +	struct mce *mce = (struct mce *)data;

Explicit cast not needed or useful. C lets us not bother when casting
from void *

> +	u64 spa, spa_alias;
> +	unsigned long pfn;
> +
> +	if (!mce || !mce_usable_address(mce))
> +		return NOTIFY_DONE;
> +
> +	spa = mce->addr & MCI_ADDR_PHYSADDR;
> +
> +	pfn = spa >> PAGE_SHIFT;
> +	if (!pfn_valid(pfn))
> +		return NOTIFY_DONE;
> +
> +	spa_alias = cxl_port_get_spa_cache_alias(endpoint, spa);
> +	if (!spa_alias)
> +		return NOTIFY_DONE;
> +
> +	pfn = spa_alias >> PAGE_SHIFT;
> +
> +	/*
> +	 * Take down the aliased memory page. The original memory page flagged
> +	 * by the MCE will be taken cared of by the standard MCE handler.
> +	 */
> +	dev_emerg(mds->cxlds.dev, "Offlining aliased SPA address: %#llx\n",
> +		  spa_alias);
> +	if (!memory_failure(pfn, 0))
> +		set_mce_nospec(pfn);
> +
> +	return NOTIFY_OK;
> +}


> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 8bf4efb2c48c..b279148ec3ff 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3435,6 +3435,31 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
>  
> +u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
> +{
> +	struct cxl_region_ref *iter;
> +	unsigned long index;
> +
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +
> +	xa_for_each(&endpoint->regions, index, iter) {
> +		struct cxl_region_params *p = &iter->region->params;
> +
> +		if (p->res->start <= spa && spa <= p->res->end) {
> +			if (!p->cache_size)
> +				return 0;
> +
> +			if (spa > p->res->start + p->cache_size)
> +				return spa - p->cache_size;
> +
> +			return spa + p->cache_size;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_get_spa_cache_alias, CXL);

Quotes needed (the patch that changed that has been annoying this cycle!)



