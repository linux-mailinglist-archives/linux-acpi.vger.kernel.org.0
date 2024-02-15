Return-Path: <linux-acpi+bounces-3549-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F77856A53
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD61F22243
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8253E12EBDB;
	Thu, 15 Feb 2024 16:56:43 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67FD135A75;
	Thu, 15 Feb 2024 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016203; cv=none; b=lvt6V4nR0/DNO6xI6C6t5QIXo8c/vM4Fnk6FB3ODIZKs+ZQcoDFgLtXyElg12BwVR0308uhHBVgWqJel+Z+fLcNPr+9I8jncmlMByQqz94WlQtCUJnS24JF4dsAnlZvN8P5O2glfTCSMKEGoIxxSh6mov0W9chspLVML3O9N9pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016203; c=relaxed/simple;
	bh=oT3xE20Qn/Lrx/hjBOoHHD4mqet2cIaqaGM3m6WUAPU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bHsSUpn/yBgKZGosKlUY3/pRNE7ZeTDMyO/FCcRNg81iXb/8zc60m7/avigHu0zjVEiCrBMYmxVPuScw++UxqgOrYR/VHHrse8SeW+PbLZIX2Ttln/IQ1cNPjpa0XRqEAiJHSlzb1JOMCNTxtUia/Rti6VzG7hQ5CRJDOF+GFsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLj02KD7z67kwf;
	Fri, 16 Feb 2024 00:52:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0E2C5140A86;
	Fri, 16 Feb 2024 00:56:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:56:36 +0000
Date: Thu, 15 Feb 2024 16:56:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 06/12] cxl: Split out host bridge access coordinates
Message-ID: <20240215165635.000068dc@Huawei.com>
In-Reply-To: <20240206222951.1833098-7-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-7-dave.jiang@intel.com>
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

On Tue, 6 Feb 2024 15:28:34 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The difference between access class 0 and access class 1 for 'struct
> access_coordinate', if any, is that class 0 is for the distance from
> the target to the closest initiator and that class 1 is for the distance
> from the target to the cloest CPU. For CXL memory, the nearest initiator

spell check.

> may not necessarily be a CPU node. The performance path from the CXL
> endpoint to the host bridge should remain the same. However, the numbers
> extracted and stored from HMAT is the difference for the two access
> classes. Split out the performance numbers for the host bridge (generic
> target) from the calculation of the entire path in order to allow
> calculation of both access classes for a CXL region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

one suggestion on function comment.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/cdat.c | 28 ++++++++++++++++++++++------
>  drivers/cxl/core/port.c | 34 +++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h       |  2 ++
>  3 files changed, 55 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 096320390ad9..79844874a34b 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -162,15 +162,22 @@ static int cxl_cdat_endpoint_process(struct cxl_port *port,
>  static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  					struct xarray *dsmas_xa)
>  {
> -	struct access_coordinate c;
> +	struct access_coordinate ep_c;
> +	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
>  	struct dsmas_entry *dent;
>  	int valid_entries = 0;
>  	unsigned long index;
>  	int rc;
>  
> -	rc = cxl_endpoint_get_perf_coordinates(port, &c);
> +	rc = cxl_endpoint_get_perf_coordinates(port, &ep_c);
>  	if (rc) {
> -		dev_dbg(&port->dev, "Failed to retrieve perf coordinates.\n");
> +		dev_dbg(&port->dev, "Failed to retrieve ep perf coordinates.\n");
> +		return rc;
> +	}
> +
> +	rc = cxl_hb_get_perf_coordinates(port, coord);
> +	if (rc)  {
> +		dev_dbg(&port->dev, "Failed to retrieve hb perf coordinates.\n");
>  		return rc;
>  	}
>  
> @@ -185,10 +192,19 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	xa_for_each(dsmas_xa, index, dent) {
>  		int qos_class;
>  
> -		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
> +		cxl_coordinates_combine(&dent->coord, &dent->coord, &ep_c);
> +		/*
> +		 * Keeping the host bridge coordinates separate from the dsmas
> +		 * coordinates in order to allow calculation of access class
> +		 * 0 and 1 for region later.
> +		 */
> +		cxl_coordinates_combine(&coord[ACCESS_COORDINATE_LOCAL],
> +					&coord[ACCESS_COORDINATE_LOCAL],
> +					&dent->coord);
>  		dent->entries = 1;
> -		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
> -					      &qos_class);
> +		rc = cxl_root->ops->qos_class(cxl_root,
> +					      &coord[ACCESS_COORDINATE_LOCAL],
> +					      1, &qos_class);
>  		if (rc != 1)
>  			continue;
>  
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index af9458b2678c..e8029170b8c6 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2096,6 +2096,37 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
> +/**
> + * cxl_hb_get_perf_coordinates - Retrieve performance numbers from host bridge

This description confused me.  What numbers does the host bridge have?

between initiator and host bridge
perhaps?

> + *
> + * @port: endpoint cxl_port
> + * @coord: output access coordinates
> + *
> + * Return: errno on failure, 0 on success.
> + */
> +int cxl_hb_get_perf_coordinates(struct cxl_port *port,
> +				struct access_coordinate *coord)
> +{
> +	struct cxl_port *iter = port;
> +	struct cxl_dport *dport;
> +
> +	if (!is_cxl_endpoint(port))
> +		return -EINVAL;
> +
> +	dport = iter->parent_dport;
> +	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
> +		iter = to_cxl_port(iter->dev.parent);
> +		dport = iter->parent_dport;
> +	}
> +
> +	coord[ACCESS_COORDINATE_LOCAL] =
> +		dport->hb_coord[ACCESS_COORDINATE_LOCAL];
> +	coord[ACCESS_COORDINATE_CPU] =
> +		dport->hb_coord[ACCESS_COORDINATE_CPU];
> +
> +	return 0;
> +}
> +
>  /**
>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>   *				   of CXL path
> @@ -2137,9 +2168,6 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  		dport = iter->parent_dport;
>  	}
>  
> -	/* Augment with the generic port (host bridge) perf data */
> -	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
> -
>  	/* Get the calculated PCI paths bandwidth */
>  	pdev = to_pci_dev(port->uport_dev->parent);
>  	bw = pcie_bandwidth_available(pdev, NULL, NULL, NULL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fab2da4b1f04..de477eb7f5d5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -879,6 +879,8 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
>  
>  int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  				      struct access_coordinate *coord);
> +int cxl_hb_get_perf_coordinates(struct cxl_port *port,
> +				struct access_coordinate *coord);
>  
>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>  


