Return-Path: <linux-acpi+bounces-3553-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CD856ABB
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96201C234BC
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6877213666D;
	Thu, 15 Feb 2024 17:16:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF9136672;
	Thu, 15 Feb 2024 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017404; cv=none; b=iry33AgEHV25Uh1NDhVbjOJYEGI65G0EgCkRCaT3uHWf0hsD6Hu+tZ8I7yEImQqk+dfhwBLh1kGgWrbQ5DftBO6cilZS2Zn1mGxhX58wvlvvCRIbjsGh4Yw4Tsss0UXDhZvrbURmsTD/oZMYzmgqkb53HHPr3LKwZsjzMewbJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017404; c=relaxed/simple;
	bh=cBbpyWIU8tHZNvv5CnQy+mP5KwE8z6k0fRWcX+D+bIs=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=le57hLWwKbzhqi6lnt279h7qfpeKwc9VBsRW8G7ipsegrTFeV0kYDpJG9uQFefk8UYmZQ/4rlw/Pbf9a1nNjohXJ7ksQuFDze8J5Fwxe+3UTx1DGdHHVWnmA7AgYzs1kmyR2yLK2EOhFQ0UM9JIDyj2EFnmf9HVnvH9yrYgSAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbM861xrZz67G9Y;
	Fri, 16 Feb 2024 01:12:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0736B1400CF;
	Fri, 16 Feb 2024 01:16:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 17:16:38 +0000
Date: Thu, 15 Feb 2024 17:16:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying"
	<ying.huang@intel.com>
Subject: Re: [PATCH v5 11/12] cxl/region: Add memory hotplug notifier for
 cxl region
Message-ID: <20240215171637.00000350@Huawei.com>
In-Reply-To: <20240206222951.1833098-12-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-12-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:39 -0700
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

A few trivial things inline.

>  static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
>  {
>  	struct memory_locality *loc;
> @@ -699,6 +729,12 @@ static void hmat_update_target_attrs(struct memory_target *target,
>  	u32 best = 0;
>  	int i;
>  
> +	/*
> +	 * Don't update if an external agent has changed the data.

Single line comment fine here I think.

> +	 */
> +	if (target->ext_updated)
> +		return;
> +



> +
> +static void remove_coord_notifier(void *data)
> +{
> +	struct cxl_region *cxlr = data;
> +
> +	unregister_memory_notifier(&cxlr->memory_notifier);

Simpler to pass in the notifier not the region.
More obvious that a remove notifier would take a notifier
and less code.

> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3091,6 +3161,11 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxlr->memory_notifier.notifier_call = cxl_region_perf_attrs_callback;
> +	cxlr->memory_notifier.priority = CXL_CALLBACK_PRI;
> +	register_memory_notifier(&cxlr->memory_notifier);
> +	rc = devm_add_action_or_reset(&cxlr->dev, remove_coord_notifier, cxlr);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.


