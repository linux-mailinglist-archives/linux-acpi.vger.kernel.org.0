Return-Path: <linux-acpi+bounces-8845-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7559A27D0
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1957B1C20C2F
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1629B1DF994;
	Thu, 17 Oct 2024 16:01:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408D1DF990;
	Thu, 17 Oct 2024 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729180866; cv=none; b=fudtTSS5iYW1HejNVme+/R1ex59ZhI68ACRRim5s1bXZlNTntmTATjyWoiE8VJZEw5A7KjPoac/Ot3n5KgGA/pKdNQX8Nk6fG1j1UA/LsXr+n6lW+ydbVSRQhO0oajGLkLuhkK1aq2p+k0p721XbeapZ/to3G2sLVC2C6vR7+Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729180866; c=relaxed/simple;
	bh=bS+rkQucKSUcZJ7eB4PfrXLRFrOfFerBhkp+0sbyatY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiZWyVAdKC8pUv+0/FeQFDgUNTz6ur1Y7r4TrH6K66ICy+nCX4q52YOjWIOcxKE1ABSrcYRfRD1cQOPgCol74OxiCVTu9C0gUU9ggU3kSvZ3BvgfD6m0+0MscsGfzmpKTLrSgdOj6HRAdpIVW29Rx82xYee/qlHeGmEw4cgOEKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTsw11gMqz6FHM1;
	Thu, 17 Oct 2024 23:59:13 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id AA879140B67;
	Fri, 18 Oct 2024 00:00:57 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:00:56 +0200
Date: Thu, 17 Oct 2024 17:00:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 2/6] acpi: numa: Add support to enumerate and store
 extended linear address mode
Message-ID: <20241017170055.00003547@Huawei.com>
In-Reply-To: <20240927142108.1156362-3-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-3-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 27 Sep 2024 07:16:54 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Store the address mode as part of the cache attriutes. Export the mode
> attribute to sysfs as all other cache attributes.
> 
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Minor things inline. Basically looks fine.

Jonathan

> ---
>  Documentation/ABI/stable/sysfs-devices-node | 7 +++++++
>  drivers/acpi/numa/hmat.c                    | 3 +++
>  drivers/base/node.c                         | 2 ++
>  include/linux/node.h                        | 7 +++++++
>  4 files changed, 19 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 402af4b2b905..9016cc4f027c 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -177,6 +177,13 @@ Description:
>  		The cache write policy: 0 for write-back, 1 for write-through,
>  		other or unknown.
>  
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/mode
> +Date:		September 2024
> +Contact:	Dave Jiang <dave.jiang@intel.com>
> +Description:
> +		The address mode: 0 for reserved, 1 for extended-lniear,

linear

also, is 0 reserved or unknown? I'm confused.


> +		other unknown.
> +
>  What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>  Date:		November 2021
>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 1a902a02390f..39524f36be5b 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -506,6 +506,9 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
>  		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> +		/* Extended Linear mode is only valid if cache is direct mapped */
> +		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR)
> +			tcache->cache_attrs.mode = NODE_CACHE_MODE_EXTENDED_LINEAR;
>  		break;
>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>  		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index eb72580288e6..744be5470728 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
>  CACHE_ATTR(line_size, "%u")
>  CACHE_ATTR(indexing, "%u")
>  CACHE_ATTR(write_policy, "%u")
> +CACHE_ATTR(mode, "%u")
>  
>  static struct attribute *cache_attrs[] = {
>  	&dev_attr_indexing.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_line_size.attr,
>  	&dev_attr_write_policy.attr,
> +	&dev_attr_mode.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(cache);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 9a881c2208b3..589951c5e36f 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -57,6 +57,11 @@ enum cache_write_policy {
>  	NODE_CACHE_WRITE_OTHER,
>  };
>  
> +enum cache_mode {
> +	NODE_CACHE_MODE_UNKOWN,
UNKNOWN

> +	NODE_CACHE_MODE_EXTENDED_LINEAR,
> +};
> +
>  /**
>   * struct node_cache_attrs - system memory caching attributes
>   *
> @@ -65,6 +70,7 @@ enum cache_write_policy {
>   * @size:		Total size of cache in bytes
>   * @line_size:		Number of bytes fetched on a cache miss
>   * @level:		The cache hierarchy level
> + * @mode:		The address mode
>   */
>  struct node_cache_attrs {
>  	enum cache_indexing indexing;
> @@ -72,6 +78,7 @@ struct node_cache_attrs {
>  	u64 size;
>  	u16 line_size;
>  	u8 level;
> +	u16 mode;
>  };
>  
>  #ifdef CONFIG_HMEM_REPORTING


