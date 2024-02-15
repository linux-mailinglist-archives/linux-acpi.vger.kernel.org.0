Return-Path: <linux-acpi+bounces-3548-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F48569FC
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADC5E1F256E4
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFAE39FFA;
	Thu, 15 Feb 2024 16:51:36 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662D4135A7D;
	Thu, 15 Feb 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708015896; cv=none; b=sa5nNeiUIkw6W1E4XDlaSxvAvLtFTyCmVELfL3cEtxT335oXOf6QmoQUI10R4LZskgX1fbuoSu1TMBxztSjAZnsXDlCp9nsS4FCDTHCg6RtchBohX+l2sGDrYu6uQP8QJ6nshcqJKd/16+NCs5w/+LXn8Ci0Nvvy4dUZ+hPEF1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708015896; c=relaxed/simple;
	bh=4hbT1C+tlh4y+T8AqrAvJ6y5luSzfJ65W8ysjp38A6A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuW2O9Emk4QVBGE2r7I+Q4Aio02/uH9Xk0CalInyJR3kler3lm4rAMOwwqmRAR4w7x6/kEgkgiSHf1N9sLntBAmqNfO4OGYdwNPiT/xVMBXS7ivZzNmc69FUpAN3cu3PrQfFax6dnnzby4m4Rzdq6i1zIpP50qRjtYo661X1KUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLb63Vnjz67Q1Y;
	Fri, 16 Feb 2024 00:47:46 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 34405140A87;
	Fri, 16 Feb 2024 00:51:31 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:51:30 +0000
Date: Thu, 15 Feb 2024 16:51:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 05/12] cxl: Split out combine_coordinates() for
 common shared usage
Message-ID: <20240215165129.00001e01@Huawei.com>
In-Reply-To: <20240206222951.1833098-6-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-6-dave.jiang@intel.com>
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

On Tue, 6 Feb 2024 15:28:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Refactor the common code of combining coordinates in order to reduce code.
> Create a new function cxl_cooordinates_combine() it combine two 'struct
> access_coordinate'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v5:
> - Fix comment header (0-day)
> - Remove EXPORT_SYMBOL (Dan)
> ---
>  drivers/cxl/core/cdat.c | 32 +++++++++++++++++++++++---------
>  drivers/cxl/core/port.c | 18 ++----------------
>  drivers/cxl/cxl.h       |  4 ++++
>  3 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 08fd0baea7a0..096320390ad9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -185,15 +185,7 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
>  	xa_for_each(dsmas_xa, index, dent) {
>  		int qos_class;
>  
> -		dent->coord.read_latency = dent->coord.read_latency +
> -					   c.read_latency;
> -		dent->coord.write_latency = dent->coord.write_latency +
> -					    c.write_latency;
> -		dent->coord.read_bandwidth = min_t(int, c.read_bandwidth,
> -						   dent->coord.read_bandwidth);
> -		dent->coord.write_bandwidth = min_t(int, c.write_bandwidth,
> -						    dent->coord.write_bandwidth);
> -
> +		cxl_coordinates_combine(&dent->coord, &dent->coord, &c);
>  		dent->entries = 1;
>  		rc = cxl_root->ops->qos_class(cxl_root, &dent->coord, 1,
>  					      &qos_class);
> @@ -484,4 +476,26 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>  
> +/**
> + * cxl_coordinates_combine - Combine the two input coordinates into the first
> + *
> + * @out: Output coordinate of c1 and c2 combined
> + * @c1: first coordinate, to be written to

When you say to be written to, what do you mean?
Left over from adding out?

No obvious reason for this to have any idea that c1 and c2 are
ordered.  

> + * @c2: second coordinate
> + */
> +void cxl_coordinates_combine(struct access_coordinate *out,
> +			     struct access_coordinate *c1,
> +			     struct access_coordinate *c2)
> +{
> +		if (c2->write_bandwidth)
> +			out->write_bandwidth = min(c1->write_bandwidth,
> +						   c2->write_bandwidth);

Why check c2->write_bandwidth?
Code already does it, but I'm not sure why + I don't think you should
treat c1 and c2 differently.

> +		out->write_latency = c1->write_latency + c2->write_latency;
> +
> +		if (c2->read_bandwidth)
> +			out->read_bandwidth = min(c1->read_bandwidth,
> +						  c2->read_bandwidth);
> +		out->read_latency = c1->read_latency + c2->read_latency;
> +}
> +
>  MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 612bf7e1e847..af9458b2678c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -2096,20 +2096,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
>  
> -static void combine_coordinates(struct access_coordinate *c1,
> -				struct access_coordinate *c2)
> -{
> -		if (c2->write_bandwidth)
> -			c1->write_bandwidth = min(c1->write_bandwidth,
> -						  c2->write_bandwidth);
> -		c1->write_latency += c2->write_latency;
> -
> -		if (c2->read_bandwidth)
> -			c1->read_bandwidth = min(c1->read_bandwidth,
> -						 c2->read_bandwidth);
> -		c1->read_latency += c2->read_latency;
> -}
> -
>  /**
>   * cxl_endpoint_get_perf_coordinates - Retrieve performance numbers stored in dports
>   *				   of CXL path
> @@ -2143,7 +2129,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	 * nothing to gather.
>  	 */
>  	while (iter && !is_cxl_root(to_cxl_port(iter->dev.parent))) {
> -		combine_coordinates(&c, &dport->sw_coord);
> +		cxl_coordinates_combine(&c, &c, &dport->sw_coord);
>  		c.write_latency += dport->link_latency;
>  		c.read_latency += dport->link_latency;
>  
> @@ -2152,7 +2138,7 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  	}
>  
>  	/* Augment with the generic port (host bridge) perf data */
> -	combine_coordinates(&c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
> +	cxl_coordinates_combine(&c, &c, &dport->hb_coord[ACCESS_COORDINATE_LOCAL]);
>  
>  	/* Get the calculated PCI paths bandwidth */
>  	pdev = to_pci_dev(port->uport_dev->parent);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fe7448f2745e..fab2da4b1f04 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -882,6 +882,10 @@ int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
>  
>  void cxl_memdev_update_perf(struct cxl_memdev *cxlmd);
>  
> +void cxl_coordinates_combine(struct access_coordinate *out,
> +			     struct access_coordinate *c1,
> +			     struct access_coordinate *c2);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.


