Return-Path: <linux-acpi+bounces-4139-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CF98739D2
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 15:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC7F287F10
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Mar 2024 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5576B134404;
	Wed,  6 Mar 2024 14:53:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012D12F5B8;
	Wed,  6 Mar 2024 14:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736819; cv=none; b=c+bPuj2WiTABAZUwMDGBVY6Zd0WzahxOz4yES9A7maoLAxJ3aaw/BYT9icibbX2IpW6C2V9xThTFmnkXLfIQnZ9IEi3Ftq/R4HACiF8r3vY5rzhXfzeJhzFhFh71UwEIMS40wEX4WsQ69enyL18aUM3oaCYj5yuDKO65167JzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736819; c=relaxed/simple;
	bh=DacPkcywhRs8arIiyR5rIigak2u8kl6uK8hDkqAtC4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOrBtSjuVBOU8y6UJeznRdPHMMdddLXC34jgZ915p08t6VEpAzJhqSNGM0BGZurPG4E2BH+oBZP8WkKhtCC4Qd7IKYdFlZPH5YZiz+8UeFigJ2lHT1tFRlLc9g1+PmyYi3Qji5KuJ7C9KqEO+XzDkeF9CqxOZIlt7VWq2AnQUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqb0K16MZz6D8r3;
	Wed,  6 Mar 2024 22:48:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C64F914256C;
	Wed,  6 Mar 2024 22:53:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 14:53:32 +0000
Date: Wed, 6 Mar 2024 14:53:31 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
	<ying.huang@intel.com>
Subject: Re: [PATCH v6 11/12] cxl/region: Add memory hotplug notifier for
 cxl region
Message-ID: <20240306145331.00003e54@Huawei.com>
In-Reply-To: <20240220231402.3156281-12-dave.jiang@intel.com>
References: <20240220231402.3156281-1-dave.jiang@intel.com>
	<20240220231402.3156281-12-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 20 Feb 2024 16:12:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> When the CXL region is formed, the driver would computed the performance
> data for the region. However this data is not available at the node data
> collection that has been populated by the HMAT during kernel
> initialization. Add a memory hotplug notifier to update the access
> coordinates to the 'struct memory_target' context kept by the
> HMAT_REPORTING code.
> 
> Add CXL_CALLBACK_PRI for a memory hotplug callback priority. Set the
> priority number to be called before HMAT_CALLBACK_PRI. The CXL update must
> happen before hmat_callback().
> 
> A new HMAT_REPORING helper hmat_update_target_coordinates() is added in

REPORTING

> order to allow CXL to update the memory_target access coordinates.
> 
> A new ext_updated member is added to the memory_target to indicate that
> the access coordinates within the memory_target has been updated by an
> external agent such as CXL. This prevents data being overwritten by the
> hmat_update_target_attrs() triggered by hmat_callback().
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

One missing error check and another trivial comment.
With error check handled.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> +static void remove_coord_notifier(void *data)
> +{
> +	struct notifier_block *memory_notifier = data;
> +
> +	unregister_memory_notifier(memory_notifier);

Trivial but no real loss of info if you do

	unregister_memory_notifier(data);

> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3081,6 +3151,12 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> +	register_memory_notifier(&cxlr->memory_notifier);
> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier,
> +				      &cxlr->memory_notifier);
> +

Check rc?  Very unlikely to fail, but you never know..

>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.


