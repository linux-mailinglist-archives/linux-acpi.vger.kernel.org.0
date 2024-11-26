Return-Path: <linux-acpi+bounces-9780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D71969D9B9E
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2024 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD009B31EFE
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Nov 2024 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0121DB372;
	Tue, 26 Nov 2024 16:23:08 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD721DA632;
	Tue, 26 Nov 2024 16:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732638188; cv=none; b=HOONF8edDe276SHqwWZsQKrmKtbYVsM9AnMUGzBpTEnVpc5QNSIZcps9k04ccT5HgUvntCJa33cE7TfMNiCJAqyrRpTuLeZ/zYHjsUDEOhoUOWz4amdCpLUIQtEYWiB79HLga5nGlAuv466k2XuK6G93udQ1cm49WmcGkTsJ6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732638188; c=relaxed/simple;
	bh=ztdw37E2MywA3UrJ8JR1NMeivjuzw/uN5iWvXXVuqn4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8wPgaau4fINEvgyzhzYZa6usmYLP+36e43P8vWNBTRJVp9kZ/yZ1DvG+m6u8C1OOWZDiyPRjB0Q2DyxIhUp1N3FLRkCPKt5Em6zcr1upTUXXj0v/l9PP6h+MxLCloahGxZPtmqOrTUycexDO2um4G/zbSSyMFMciGyVF2MBJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XySV51vWrz6K5pk;
	Wed, 27 Nov 2024 00:20:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B6FCC140B63;
	Wed, 27 Nov 2024 00:23:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 26 Nov
 2024 17:23:03 +0100
Date: Tue, 26 Nov 2024 16:23:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 2/5] acpi/hmat / cxl: Add extended linear cache
 support for CXL
Message-ID: <20241126162301.0000090c@huawei.com>
In-Reply-To: <20241112221335.432583-3-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
	<20241112221335.432583-3-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 15:12:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The current cxl region size only indicates the size of the CXL memory
> region without accounting for the extended linear cache size. Retrieve the
> cache size from HMAT and append that to the cxl region size for the cxl
> region range that matches the SRAT range that has extended linear cache
> enabled.
> 
> The SRAT defines the whole memory range that includes the extended linear
> cache and the CXL memory region. The new HMAT ECN/ECR to the Memory Side
> Cache Information Structure defines the size of the extended linear cache
> size and matches to the SRAT Memory Affinity Structure by the memory
> proxmity domain. Add a helper to match the cxl range to the SRAT memory
> range in order to retrieve the cache size.
> 
> There are several places that checks the cxl region range against the
> decoder range. Use new helper to check between the two ranges and address
> the new cache size.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

A few minor comments inline.

Thanks,

Jonathan

> ---
>  drivers/acpi/numa/hmat.c  | 44 ++++++++++++++++++++++++
>  drivers/cxl/core/Makefile |  1 +
>  drivers/cxl/core/acpi.c   | 11 ++++++
>  drivers/cxl/core/core.h   |  3 ++
>  drivers/cxl/core/region.c | 70 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h         |  2 ++
>  include/linux/acpi.h      | 19 +++++++++++
>  tools/testing/cxl/Kbuild  |  1 +
>  8 files changed, 147 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 39524f36be5b..92b818b72ecc 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -108,6 +108,50 @@ static struct memory_target *find_mem_target(unsigned int mem_pxm)
>  	return NULL;
>  }
>  
> +/**
> + * hmat_get_extended_linear_cache_size - Retrieve the extended linear cache size
> + * @backing_res: resource from the backing media
> + * @nid: node id for the memory region
> + * @cache_size: (Output) size of extended linear cache.
> + *
> + * Return: 0 on success. Errno on failure.
> + *
> + */
> +int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> +					resource_size_t *cache_size)
> +{
> +	unsigned int pxm = node_to_pxm(nid);
> +	struct memory_target *target;
> +	struct target_cache *tcache;
> +	bool cache_found = false;
> +	struct resource *res;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -ENOENT;
> +
> +	list_for_each_entry(tcache, &target->caches, node) {
> +		if (tcache->cache_attrs.mode == NODE_CACHE_MODE_EXTENDED_LINEAR) {

I'd flip this for slightly better readability.
		if (tcache->cache_attrs.mode != NODE_CACHE_MODE_EXTENDED_LINEAR)
			continue;

		res = ...


> +			res = &target->memregions;
> +			if (!resource_contains(res, backing_res))
> +				continue;
> +
> +			cache_found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!cache_found) {
> +		*cache_size = 0;
> +		return 0;
> +	}
> +
> +	*cache_size = tcache->cache_attrs.size;

Why not set this and return in the loop?
That way no need to have a local variable.

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);

> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> new file mode 100644
> index 000000000000..f13b4dae6ac5
> --- /dev/null
> +++ b/drivers/cxl/core/acpi.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +#include <linux/acpi.h>
> +#include "cxl.h"
> +#include "core.h"

Why do you need the cxl headers?  Maybe a forwards def of
struct resource, but I'm not seeing anything else being needed.


> +
> +int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
> +					    int nid, resource_size_t *size)
> +{
> +	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
> +}


> @@ -3215,6 +3229,42 @@ static int match_region_by_range(struct device *dev, void *data)
>  	return rc;
>  }
>  
> +static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
> +					    struct resource *res)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int nid = phys_to_target_node(res->start);
> +	resource_size_t size, cache_size;
> +	int rc;
> +
> +	size = resource_size(res);
> +	if (!size)
> +		return -EINVAL;
> +
> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
> +	if (rc)
> +		return rc;
> +
> +	if (!cache_size)
> +		return 0;
> +
> +	if (size != cache_size) {
> +		dev_warn(&cxlr->dev, "Extended Linear Cache is not 1:1, unsupported!");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	/*
> +	 * Move the start of the range to where the cache range starts. The
> +	 * implementation assumes that the cache range is in front of the
> +	 * CXL range. This is not dictated by the HMAT spec but is how the
> +	 * currently known implementation configured.

is configured

> +	 */
> +	res->start -= cache_size;
> +	p->cache_size = cache_size;
> +
> +	return 0;
> +}



