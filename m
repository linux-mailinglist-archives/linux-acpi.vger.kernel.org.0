Return-Path: <linux-acpi+bounces-9784-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5269DA5A7
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 11:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09D1B20CD2
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 10:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6884194125;
	Wed, 27 Nov 2024 10:23:37 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40872191F99;
	Wed, 27 Nov 2024 10:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732703017; cv=none; b=B4EEh26DU5xvguwEiH0Zw0647GQJZLjbMNq/DEyIQ2+kcdcFcZqsCry9O3Wqo1XQ5gsCUFU40rSAQ8ISXe9lQqhu5rbL922EBCQVYqgzZzevvUDN4Lvnst+IkFnbqVJGPPWnL9iiOYgKNHBmFmHaYt93jxLDnaDUoUZhADi+a04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732703017; c=relaxed/simple;
	bh=R5E2i29yNSZK1YbWxqIGL9nzzEA73c8GnAFir+/J/IA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HqTa6em51tmj3bWtzNa0psZOF2nnlOaFyDL0U1EH+hHcR4Utwv0n2OehvOrjERnCAjiadF1vbpfWOUfE4qLObS9xcmOLg67Lsjnwk59ZOGzhuDk7PRhexrw4ZGvawsPxrcuZQxWpamzkBNz1HAswHVu0Od6a31kWKdqFP8bLYsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XywSl6vyqz6K5sD;
	Wed, 27 Nov 2024 18:20:55 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 909021400CA;
	Wed, 27 Nov 2024 18:23:32 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 27 Nov
 2024 11:23:32 +0100
Date: Wed, 27 Nov 2024 10:23:30 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 3/5] acpi/hmat: Add helper functions to provide
 extended linear cache translation
Message-ID: <20241127102330.00004a1c@huawei.com>
In-Reply-To: <20241112221335.432583-4-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
	<20241112221335.432583-4-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 15:12:35 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to help do address translation for either the address
> of the extended linear cache or its alias address. The translation function
> attempt to detect an I/O hole in the proximity domain and adjusts the
> address if the hole impacts the aliasing of the address. The range of the
> I/O hole is retrieved by walking through the associated memory target
> resources.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
Trivial comment inline.  I'm far from expert on requirements here but it
seems to match your description.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> v2:
> - Drop extra variable and use 'res' from the loop. (Jonathan)
> - Break up multiple if statements into single blocks and add comments. (Jonathan)
> ---
>  drivers/acpi/numa/hmat.c | 148 +++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h     |  14 ++++
>  2 files changed, 162 insertions(+)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 92b818b72ecc..6c686d3c7266 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -152,6 +152,154 @@ int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>  }
>  EXPORT_SYMBOL_NS_GPL(hmat_get_extended_linear_cache_size, CXL);
>  
> +static int alias_address_find_iohole(struct memory_target *target,
> +				     u64 address, u64 alias, struct range *hole)
> +{
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
> +		if (alias >= res->start && alias <= res->end)
> +			break;
> +		prev = res;
> +	}
> +	if (!res)
> +		return -EINVAL;
> +
> +	/* No memory hole */
> +	if (res == prev)
> +		return 0;
> +
> +	/* If address is within the current resource, no need to deal with memory hole */

Rather long line that could be easily broken.

> +	if (address >= res->start)
> +		return 0;
> +
> +	*hole = (struct range) {
> +		.start = prev->end + 1,
> +		.end = res->start - 1,
> +	};
> +
> +	return 0;
> +}

