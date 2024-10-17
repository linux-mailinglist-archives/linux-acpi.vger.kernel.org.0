Return-Path: <linux-acpi+bounces-8847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC1F9A28E7
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729061C20D81
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F171DEFC9;
	Thu, 17 Oct 2024 16:33:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884331DB37B;
	Thu, 17 Oct 2024 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182817; cv=none; b=AiujQwsbKSJy1UTqn+RH9UEZv4NzNRiS33UkMTp1TmvhJ7WfeuqNVpPHKfYSjf8Fodg8+8LQsSWJ8u7LSJkJHRvk8lqgeNA7Bp/R1s7KAKFqbq551tohtBWhgW8JufIFVr3ERh/QFJzxMCwpQGWleh7BPv/0cO3eo8vyVaW8LME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182817; c=relaxed/simple;
	bh=payJ+qbMnh5YCJAyD0pJDmioS7v1nlw+mr2SnfH7ix4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+soPNIaGMNriBoaDs8jARq0FMpwue8Dd+3RizLFebrVsMu4k7nYnrTQRlncTd6Sh5F4n1BxMSHrRDBZbjZI+ytODxpb+BSxzSHtEgpQy1CJbJ8r3eDFnkLlSKYmhlDYfKSXi8rB5ev39XRxxa0AQ0e3lS9SYsQrJDOtnrn3i8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTtdX2hd4z6K5sl;
	Fri, 18 Oct 2024 00:31:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EE842140B67;
	Fri, 18 Oct 2024 00:33:28 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:33:28 +0200
Date: Thu, 17 Oct 2024 17:33:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 4/6] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Message-ID: <20241017173326.0000191a@Huawei.com>
In-Reply-To: <20240927142108.1156362-5-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-5-dave.jiang@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Sep 2024 07:16:56 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to help do address translation for either the address
> of the extended linear cache or its alias address. The translation function
> attempt to detect an I/O hole in the proximity domain and adjusts the address
> if the hole impacts the aliasing of the address. The range of the I/O hole
> is retrieved by walking through the associated memory target resources.

What does the I/O hole correspond to in the system?

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c | 136 +++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h     |  14 ++++
>  2 files changed, 150 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d299f8d7af8c..834314582f4c 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -152,6 +152,142 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>  }
>  EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
>  
> +static int alias_address_find_iohole(struct memory_target *target,
> +				     u64 address, u64 alias, struct range *hole)
> +{
> +	struct resource *alias_res = NULL;
> +	struct resource *res, *prev;
> +
> +	*hole = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
> +
> +	/* First find the resource that the address is in */
> +	prev = target->memregions.child;
> +	for (res = target->memregions.child; res; res = res->sibling) {
> +		if (alias >= res->start && alias <= res->end) {
> +			alias_res = res;
> +			break;
> +		}
> +		prev = res;
> +	}
> +	if (!alias_res)

	if (!res) and you can just use res instead of alias_res for the following
as you exit the loop with it set to the right value.



> +		return -EINVAL;
> +
> +	/* No memory hole */
> +	if (alias_res == prev)
> +		return 0;
> +
> +	/* If address is within the current resource, no need to deal with memory hole */
> +	if (address >= alias_res->start)
> +		return 0;
> +
> +	*hole = (struct range) {
> +		.start = prev->end + 1,
> +		.end = alias_res->start - 1,
> +	};
Ordering assumption should be avoided in such a generic
sounding function.  Can the hole be first?

or rename the function to include preceding_hole or something like that.
> +
> +	return 0;
> +}
> +
> +int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
> +{
> +	unsigned int pxm = node_to_pxm(nid);
> +	struct memory_target *target;
> +	struct range iohole;
> +	int rc;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -EINVAL;
> +
> +	rc = alias_address_find_iohole(target, address, *alias, &iohole);
> +	if (rc)
> +		return rc;
> +
> +	if (!range_len(&iohole))
> +		return 0;
> +
Maybe reformat like this and add comments on each condition.

	if (address >= iohole.start)
		return 0;

	if (*alias <= iohole.start)
		return 0;

	*alias += range_len(&iohole);

	return 0;

	
> +	if (address < iohole.start) {
> +		if (*alias > iohole.start) {
> +			*alias = *alias + range_len(&iohole);
> +			return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_alias_xlat, CXL);
> +
> +static int target_address_find_iohole(struct memory_target *target,
> +				      u64 address, u64 alias,
> +				      struct range *hole)
> +{
> +	struct resource *addr_res = NULL;
> +	struct resource *res, *next;
> +
> +	*hole = (struct range) {
> +		.start = 0,
> +		.end = -1,
> +	};
> +
> +	/* First find the resource that the address is in */
> +	for (res = target->memregions.child; res; res = res->sibling) {
> +		if (address >= res->start && address <= res->end) {
> +			addr_res = res;

Could just use res as it's scope is outside the loop.

> +			break;
> +		}
> +	}
> +	if (!addr_res)
> +		return -EINVAL;
> +
> +	next = res->sibling;
> +	/* No memory hole after the region */
> +	if (!next)
> +		return 0;
> +
> +	/* If alias is within the current resource, no need to deal with memory hole */
> +	if (alias <= addr_res->end)
> +		return 0;
> +
> +	*hole = (struct range) {
> +		.start = addr_res->end + 1,
> +		.end = next->start - 1,
> +	};
> +
> +	return 0;
> +}
> +
> +int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
> +{
> +	unsigned int pxm = node_to_pxm(nid);
> +	struct memory_target *target;
> +	struct range iohole;
> +	int rc;
> +
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return -EINVAL;
> +
> +	rc = target_address_find_iohole(target, *address, alias, &iohole);
> +	if (rc)
> +		return rc;
> +
> +	if (!range_len(&iohole))
> +		return 0;
> +

Similar to above, maybe break into multiple reasons to exit early.

> +	if (alias > iohole.end) {
> +		if (*address < iohole.end) {
> +			*address = *address - range_len(&iohole);
> +			return 0;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(hmat_extended_linear_cache_address_xlat, CXL);
>

Jonathan

