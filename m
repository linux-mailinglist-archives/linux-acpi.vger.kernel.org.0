Return-Path: <linux-acpi+bounces-3555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E75856AE8
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0551C23B32
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69556136983;
	Thu, 15 Feb 2024 17:24:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8308C12882C;
	Thu, 15 Feb 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017883; cv=none; b=ITtoIHtKQsYs+aUqcnL7kQRO0j+Lgd2iNKuezh6bWDqzaWLBifRbev6W768WZyFz1HWDjxR/DwzokBX8x/W65Xxd1Km68I88wij/FoH6o6d15ZK/yHIxSBChQE4RfKW3CAD0tY6GOVDFr7sHdLjlLojx2nuk1jwkEt7D9Oo20nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017883; c=relaxed/simple;
	bh=12Ch5W6g5mLYmWNufdasqJaJDiOhbQpS26362nA3mvU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=awX15q37NV/3MXsSL1ITbBLrtKKIMCAjThmTn4R+Pm6z7l+NtK+gdch7X4a4J2pK3rDCRHZJkPQQsgwUQKF4HcVC3pthJ40r4tLzLhYhApzQAGP4h1S7zQFONhulq+9WvsKNF2m1u+oEYHW8zDomQgJCL17fF+JHNCjS0UfkkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbMKJ6t0gz67G9n;
	Fri, 16 Feb 2024 01:20:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B742F140682;
	Fri, 16 Feb 2024 01:24:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 17:24:37 +0000
Date: Thu, 15 Feb 2024 17:24:36 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 12/12] cxl/region: Deal with numa nodes not
 enumarated by SRAT
Message-ID: <20240215172436.000064a7@Huawei.com>
In-Reply-To: <20240206222951.1833098-13-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-13-dave.jiang@intel.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:40 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> For the numa nodes that are not created by SRAT, no memory_target is
> allocated and is not managed by the HMAT_REPORTING code. Therefore
> hmat_callback() memory hotplug notifier will exit early on those NUMA
> nodes. The CXL memory hotplug notifier will need to call
> node_set_perf_attrs() directly in order to setup the access sysfs
> attributes.
> 
> In acpi_numa_init(), the last proximity domain (pxm) id created by SRAT is
> stored. Add a helper function acpi_node_backed_by_real_pxm() in order to
> check if a NUMA node id is defined by SRAT or created by CFMWS.
> 
> node_set_perf_attrs() symbol is exported to allow update of perf attribs
> for a node. The sysfs path of
> /sys/devices/system/node/nodeX/access0/initiators/* is created by
> ndoe_set_perf_attrs() for the various attributes where nodeX is matched
node

> to the NUMA node of the CXL region.
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Trivial comment inline.
Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v5:
> - Fix ARM compile of missing prototype (0day)
> ---



> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 19e419f18472..db51e35cb44f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3084,7 +3084,12 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  
>  	for (int i = 0; i < ACCESS_COORDINATE_MAX; i++) {
>  		if (cxlr->coord[i].read_bandwidth) {
> -			rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
> +			rc = 0;
> +			if (cxl_need_node_perf_attrs_update(nid))
> +				node_set_perf_attrs(nid, &cxlr->coord[i], i);
maybe
continue;
here
> +			else
> +				rc = cxl_update_hmat_access_coordinates(nid, cxlr, i);
> +

Then no need to indent the above

>  			if (rc == 0)
>  				cset++;
>  		}


