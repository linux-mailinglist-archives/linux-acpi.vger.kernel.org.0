Return-Path: <linux-acpi+bounces-8848-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CD89A2923
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 18:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B55C1C20947
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Oct 2024 16:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3328C1DF256;
	Thu, 17 Oct 2024 16:38:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004EB1DED74;
	Thu, 17 Oct 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183101; cv=none; b=BnNSF+W4TaQuYC2NAkZYZkmDNL/1yg3pJ4wVuIW8Mr+n/+j2aEa4QzMXeOuKIxxIBWNQsttYfL3p9xqfWlBB1NuGGy5/Srk5SXZ3ORKzF0Qi5RFyBe/tCeWs4UPEstkhyt8cfEMhPJHqffr4hWMblLLk6cWIQFVjjuB+GytTflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183101; c=relaxed/simple;
	bh=5N4uNrS+xY4pcwtFdklkZVYi/zVmNV3g4matm9nbIfY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S62Irj0mkKNVfvDIXkOpOJ8lI4YWat8Z0Gbza1cjNwsBfS/eoJ+6dv9SontiYqayOiyonqtH47vTyw0PrFIdVwjjBVtqn3Es7Y+KRZEdIsmFK8nQEUpbizT+hQ9I27XInO8SUGSx8td5RBPxNkIRr3O8+0TsvNo36y8z2Z9E3zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTtmD3lNZz6K9Fp;
	Fri, 18 Oct 2024 00:37:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E6B714011A;
	Fri, 18 Oct 2024 00:38:13 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 18:38:12 +0200
Date: Thu, 17 Oct 2024 17:38:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>, <bp@alien8.de>, <dan.j.williams@intel.com>,
	<tony.luck@intel.com>, <dave@stgolabs.net>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>
Subject: Re: [RFC PATCH 5/6] cxl: Add extended linear cache address alias
 emission for cxl events
Message-ID: <20241017173810.00002ab5@Huawei.com>
In-Reply-To: <20240927142108.1156362-6-dave.jiang@intel.com>
References: <20240927142108.1156362-1-dave.jiang@intel.com>
	<20240927142108.1156362-6-dave.jiang@intel.com>
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

On Fri, 27 Sep 2024 07:16:57 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add the aliased address of exteneded linear cache when emitting event
extended

> trace for DRAM and general media of CXL events.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Trivial comment inline. 
> ---
>  drivers/cxl/core/acpi.c   | 10 ++++++++++
>  drivers/cxl/core/core.h   |  7 +++++++
>  drivers/cxl/core/mbox.c   | 42 ++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/core/region.c |  2 +-
>  drivers/cxl/core/trace.h  | 24 ++++++++++++++--------
>  5 files changed, 73 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> index f13b4dae6ac5..f74136320fc3 100644
> --- a/drivers/cxl/core/acpi.c
> +++ b/drivers/cxl/core/acpi.c
> @@ -9,3 +9,13 @@ int cxl_acpi_get_extended_linear_cache_size(struct resource *backing_res,
>  {
>  	return hmat_get_extended_linear_cache_size(backing_res, nid, size);
>  }
> +
> +int cxl_acpi_extended_linear_cache_address_xlat(u64 *address, u64 alias, int nid)
> +{
> +	return hmat_extended_linear_cache_address_xlat(address, alias, nid);

Can we just stub them out in acpi.h?  I'm not sure wrapping them gives us
anything useful.

> +}
> +
> +int cxl_acpi_extended_linear_cache_alias_xlat(u64 address, u64 *alias, int nid)
> +{
> +	return hmat_extended_linear_cache_alias_xlat(address, alias, nid);
> +}



