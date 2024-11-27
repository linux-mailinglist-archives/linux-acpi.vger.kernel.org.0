Return-Path: <linux-acpi+bounces-9785-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF959DABEA
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 17:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234B8161DCE
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Nov 2024 16:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29417200BA9;
	Wed, 27 Nov 2024 16:40:20 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D951FF7A2;
	Wed, 27 Nov 2024 16:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732725620; cv=none; b=p43OYc0Gf7CfaQofRyC1v0WorXGT7v584zV2JVJlVRT3BGI4IT8U6WtnnxjsNpb3AvcBczvA53m7Uu50+AXHn106il6izR6wl3CWFmGsUuRucCJBz8H3xVSWruIUJX0WpJobw50TX6DV+CmX2S1IOp0q0rBn/h3A65+nR79e2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732725620; c=relaxed/simple;
	bh=3lNlHugmwr43txdxbc84QtNopgv5nwA690S+GhrCdYc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z1d2DGpk1ze3aKuJnMlw6tjenkgK5I1QtfG7Sd8cO5eFiR8+KNRF7pLQAw/bztKwK98/hQryEqBhHZlYGPhu+g0y0L/hPnKyjQh5Xb/0msKmyd2AhsjuOCDlJogbqg8LFWRT4sUveOlhT8ZBaApRsNi1jr1F+daInv8P8p4tMJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xz4nx3Pkqz67QLY;
	Thu, 28 Nov 2024 00:36:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B33F1401DC;
	Thu, 28 Nov 2024 00:40:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 27 Nov
 2024 17:40:14 +0100
Date: Wed, 27 Nov 2024 16:40:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2 4/5] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20241127164013.000071ed@huawei.com>
In-Reply-To: <20241112221335.432583-5-dave.jiang@intel.com>
References: <20241112221335.432583-1-dave.jiang@intel.com>
	<20241112221335.432583-5-dave.jiang@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 12 Nov 2024 15:12:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the aliased address of extended linear cache when emitting event
> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

There is some code movement in here I wasn't expecting to see.

Otherwise looks fine to me.

Jonathan

> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 18a94d382d40..cdf6d42f5a94 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -436,34 +436,12 @@ int thermal_acpi_critical_trip_temp(struct acpi_device *adev, int *ret_temp);
>  
>  #ifdef CONFIG_ACPI_HMAT
>  int acpi_get_genport_coordinates(u32 uid, struct access_coordinate *coord);
> -int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
> -					resource_size_t *size);
> -int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
> -int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
>  #else
>  static inline int acpi_get_genport_coordinates(u32 uid,
>  					       struct access_coordinate *coord)
>  {
>  	return -EOPNOTSUPP;
>  }
> -
> -static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
> -						      int nid, resource_size_t *size)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline int hmat_extended_linear_cache_alias_xlat(u64 address,
> -							u64 *alias, int nid)
> -{
> -	return -EOPNOTSUPP;
> -}
> -
> -static inline int hmat_extended_linear_cache_address_xlat(u64 *address,
> -							  u64 alias, int nid)
> -{
> -	return -EOPNOTSUPP;
> -}
>  #endif
>  
>  #ifdef CONFIG_ACPI_NUMA
> @@ -1115,12 +1093,26 @@ static inline acpi_handle acpi_get_processor_handle(int cpu)
>  #ifdef CONFIG_ACPI_HMAT
>  int hmat_get_extended_linear_cache_size(struct resource *backing_res, int nid,
>  					resource_size_t *size);
> +int hmat_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid);
> +int hmat_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid);
If this makes sense can we put them here in the first place?

>  #else
>  static inline int hmat_get_extended_linear_cache_size(struct resource *backing_res,
>  						      int nid, resource_size_t *size)
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int hmat_extended_linear_cache_alias_xlat(u64 address,
> +							u64 *alias, int nid)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int hmat_extended_linear_cache_address_xlat(u64 *address,
> +							  u64 alias, int nid)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif
>  
>  extern void arch_post_acpi_subsys_init(void);


