Return-Path: <linux-acpi+bounces-3544-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BF6856970
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74DE1F2145A
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 16:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2535513473A;
	Thu, 15 Feb 2024 16:21:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B0713472A;
	Thu, 15 Feb 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014064; cv=none; b=mv0fGkRtxRH0smed98+ZnsjJh+UHTDVhYoV1gNdJwDSV3ov6uGOM5mtagUHcfiXYPW7dOvDzr5svM+UTAA/MJp5oxMVSWFQOp0lTWAbN1/hO0bwa2H6xAYdPh207RqU/XNyvIpiZL1hAs5O7++IbKN+Z5up6bfgybklh5++8yFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014064; c=relaxed/simple;
	bh=xfrVHtHYfwvVy+QioVK9q5U7iRtvHWc4YRt9liqCBDw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NlxuA8JvyZ1d5ebCykGmuZB25Lq9B6PUqtTktPWw6/5AamnbCoNnT5kkS3pan7s3ixabs5q1IASNO2vbEeOFM8Db7+r6pFwgQq5jh+VramW6kXC2HLEe6K5uavK3FiIuvRMy8qAnaFmjL4b0PmDXbKE04aMq/keoJYMXXtS8i38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbKwB3KqCz6K8pm;
	Fri, 16 Feb 2024 00:17:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 54B18140682;
	Fri, 16 Feb 2024 00:20:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 16:20:57 +0000
Date: Thu, 15 Feb 2024 16:20:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 01/12] ACPI: HMAT: Remove register of memory node for
 generic target
Message-ID: <20240215162056.0000656e@Huawei.com>
In-Reply-To: <20240206222951.1833098-2-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-2-dave.jiang@intel.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 6 Feb 2024 15:28:29 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> For generic targets, there's no reason to call
> register_memory_node_under_compute_node() with the access levels that are
> only visible to HMAT handling code. Only update the attributes and rename
> hmat_register_generic_target_initiators() to hmat_update_generic_target().

What goes wrong as a result of this bug?

Looks like a cleanup at first glance.

With some more description if it is a fix.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Fixes: a3a3e341f169 ("acpi: numa: Add setting of generic port system locality attributes")
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/acpi/numa/hmat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d6b85f0f6082..a26e7793ec4e 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -770,12 +770,12 @@ static void __hmat_register_target_initiators(struct memory_target *target,
>  	}
>  }
>  
> -static void hmat_register_generic_target_initiators(struct memory_target *target)
> +static void hmat_update_generic_target(struct memory_target *target)
>  {
>  	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>  
> -	__hmat_register_target_initiators(target, p_nodes,
> -					  NODE_ACCESS_CLASS_GENPORT_SINK);
> +	hmat_update_target_attrs(target, p_nodes,
> +				 NODE_ACCESS_CLASS_GENPORT_SINK);
>  }
>  
>  static void hmat_register_target_initiators(struct memory_target *target)
> @@ -835,7 +835,7 @@ static void hmat_register_target(struct memory_target *target)
>  	 */
>  	mutex_lock(&target_lock);
>  	if (*(u16 *)target->gen_port_device_handle) {
> -		hmat_register_generic_target_initiators(target);
> +		hmat_update_generic_target(target);
>  		target->registered = true;
>  	}
>  	mutex_unlock(&target_lock);


