Return-Path: <linux-acpi+bounces-11361-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52CA3EA49
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 02:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A09F18944BD
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Feb 2025 01:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE29313B787;
	Fri, 21 Feb 2025 01:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbM4hPQP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8222AE96;
	Fri, 21 Feb 2025 01:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740102192; cv=none; b=sIzTek45kQ5nKf/3GKVn8TE+aISTAyXxcX9H68nM8s5TrokxIWC/DLoVFTRAaOyE3WJkCnPBTShyP/XM6hhl0pn3/zTLiIEUwoSya/rA6YuXUnkzjiqB06gPr+wphS4HhfWxC4IdcmFlHnECDBGAHt7gRcMwo1J3GBRcl9KJ/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740102192; c=relaxed/simple;
	bh=nuMeZBRKJTujTmHVhRHwrNWiDuH5SuGF/xsDo8aTjro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FavK8MQuR3QsXXXRNEIjiJM8ZJvCa23KjceE8OBxCXoVHwcoi+RPfUC6lbaLaI+SgmKhrlJ0O0n9IbXSQ+rWDxT/z0/z6meI6pI2wafU+0c8eyTB/0e3hoV5D0Cy/CaKpiGW2LYKAHI3Pl1jQQ7nkcmxa+j/Lm6LoUZ0dJixIh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbM4hPQP; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740102191; x=1771638191;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nuMeZBRKJTujTmHVhRHwrNWiDuH5SuGF/xsDo8aTjro=;
  b=DbM4hPQP8/UxBkDdt2KAtsKN7ggLf/fxOk9nBKPbwiDTsdJ2jMu+UApG
   BIsk7JjvqXKvAPgq80vfpaNYZoBBqAbupCP9fFfVWsF4AuHSHpmi7cMfK
   VVTDmi+Imq3/tJvSDdRTB5saNErSqtgZzI2uawqOIfDC6EFLD0e6Pn051
   B27GGN6yIL1YfPBATPa9IZYY3Z1Tm+EW+lyXd8Xnma4BnNDfH/5GrEBHH
   Gz5LvZlSkTqVLzO7/Iml7VOcfu24uQLYcYKuR+lMU6BOVNYK9RLvh5Ots
   mL44dQw+fgoCLa3su9pl18iaMjttB/ZYDizzbBk4FM0ypReB5hj5vIMlY
   Q==;
X-CSE-ConnectionGUID: qYpUTRAqTCGVPVLVXGz0Vw==
X-CSE-MsgGUID: umQSe0GqRniNw3NAjpUC2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="41172059"
X-IronPort-AV: E=Sophos;i="6.13,303,1732608000"; 
   d="scan'208";a="41172059"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:43:10 -0800
X-CSE-ConnectionGUID: M7DPpj4+R+CzFLZRuxDp1Q==
X-CSE-MsgGUID: egPIynnEQLW1ZjveRhczGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="146115349"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 17:43:01 -0800
Date: Thu, 20 Feb 2025 17:42:56 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	rafael@kernel.org, bp@alien8.de, dan.j.williams@intel.com,
	tony.luck@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
	ira.weiny@intel.com, ming.li@zohomail.com
Subject: Re: [PATCH v3 1/4] acpi: numa: Add support to enumerate and store
 extended linear address mode
Message-ID: <Z7faINPWuDaWtq1C@aschofie-mobl2.lan>
References: <20250117173054.4147877-1-dave.jiang@intel.com>
 <20250117173054.4147877-2-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117173054.4147877-2-dave.jiang@intel.com>

On Fri, Jan 17, 2025 at 10:28:30AM -0700, Dave Jiang wrote:
> Store the address mode as part of the cache attriutes. Export the mode
> attribute to sysfs as all other cache attributes.
> 
> Link: https://lore.kernel.org/linux-cxl/668333b17e4b2_5639294fd@dwillia2-xfh.jf.intel.com.notmuch/
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-node | 6 ++++++
>  drivers/acpi/numa/hmat.c                    | 5 +++++
>  drivers/base/node.c                         | 2 ++
>  include/linux/node.h                        | 7 +++++++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
> index 402af4b2b905..c46b910dfe00 100644
> --- a/Documentation/ABI/stable/sysfs-devices-node
> +++ b/Documentation/ABI/stable/sysfs-devices-node
> @@ -177,6 +177,12 @@ Description:
>  		The cache write policy: 0 for write-back, 1 for write-through,
>  		other or unknown.
>  
> +What:		/sys/devices/system/node/nodeX/memory_side_cache/indexY/address_mode
> +Date:		December 2024
> +Contact:	Dave Jiang <dave.jiang@intel.com>
> +Description:
> +		The address mode: 0 for reserved, 1 for extended-linear.
> +

I was going to say something about the brevity of the description,
but when I looked in the file, I see this is like all the other
memory_side_cache descriptions.

So - I'll just say - update that Date :)


>  What:		/sys/devices/system/node/nodeX/x86/sgx_total_bytes
>  Date:		November 2021
>  Contact:	Jarkko Sakkinen <jarkko@kernel.org>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 80a3481c0470..a9172cf90002 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -506,6 +506,11 @@ static __init int hmat_parse_cache(union acpi_subtable_headers *header,
>  	switch ((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) {
>  	case ACPI_HMAT_CA_DIRECT_MAPPED:
>  		tcache->cache_attrs.indexing = NODE_CACHE_DIRECT_MAP;
> +		/* Extended Linear mode is only valid if cache is direct mapped */
> +		if (cache->address_mode == ACPI_HMAT_CACHE_MODE_EXTENDED_LINEAR) {
> +			tcache->cache_attrs.address_mode =
> +				NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR;
> +		}
>  		break;
>  	case ACPI_HMAT_CA_COMPLEX_CACHE_INDEXING:
>  		tcache->cache_attrs.indexing = NODE_CACHE_INDEXED;
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ea653fa3433..cd13ef287011 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -244,12 +244,14 @@ CACHE_ATTR(size, "%llu")
>  CACHE_ATTR(line_size, "%u")
>  CACHE_ATTR(indexing, "%u")
>  CACHE_ATTR(write_policy, "%u")
> +CACHE_ATTR(address_mode, "%#x")

why not "%u" fmt ?

>  
>  static struct attribute *cache_attrs[] = {
>  	&dev_attr_indexing.attr,
>  	&dev_attr_size.attr,
>  	&dev_attr_line_size.attr,
>  	&dev_attr_write_policy.attr,
> +	&dev_attr_address_mode.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(cache);
> diff --git a/include/linux/node.h b/include/linux/node.h
> index 9a881c2208b3..2b7517892230 100644
> --- a/include/linux/node.h
> +++ b/include/linux/node.h
> @@ -57,6 +57,11 @@ enum cache_write_policy {
>  	NODE_CACHE_WRITE_OTHER,
>  };
>  
> +enum cache_mode {
> +	NODE_CACHE_ADDR_MODE_RESERVED,
> +	NODE_CACHE_ADDR_MODE_EXTENDED_LINEAR,
> +};
> +
>  /**
>   * struct node_cache_attrs - system memory caching attributes
>   *
> @@ -65,6 +70,7 @@ enum cache_write_policy {
>   * @size:		Total size of cache in bytes
>   * @line_size:		Number of bytes fetched on a cache miss
>   * @level:		The cache hierarchy level
> + * @address_mode:		The address mode
>   */
>  struct node_cache_attrs {
>  	enum cache_indexing indexing;
> @@ -72,6 +78,7 @@ struct node_cache_attrs {
>  	u64 size;
>  	u16 line_size;
>  	u8 level;
> +	u16 address_mode;
>  };
>  
>  #ifdef CONFIG_HMEM_REPORTING
> -- 
> 2.47.1
> 

