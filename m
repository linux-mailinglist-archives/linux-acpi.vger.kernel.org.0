Return-Path: <linux-acpi+bounces-3551-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EFE856A65
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 18:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA12E1C225E6
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Feb 2024 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291FB135A75;
	Thu, 15 Feb 2024 17:01:19 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017AFA41;
	Thu, 15 Feb 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708016479; cv=none; b=n+6mHVnF4HUd0jVvKnCEfwYwQUTI0YojmfXEB2DLCpkQK4pUktNJpmC8TZNK2dfedjp9TUXruE90ZsfYLsAB9PY7rXkHmHpXnGrxyfXVL7DPuXXjkxyWS1VttVdr1gAlO2QsqPzLWR6Uu0qXszjh9M1udzXb5psgzkraDXpCq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708016479; c=relaxed/simple;
	bh=FcdyDPdxc0B0ultlSQMtjfrWCFBtg6uBOpbw8odt3h4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQs1W5QbbuMhmaXPjoP6N1lZ/Q1Jz6Kx03Hy8SXceKyXhSfri0cUm6CTSpRB4KklALhkHS/dVjHWIKZlZWtLOWeXSQrw4ZL6726Dxnr0nste0ZSKFQKbOxL3BbRwYS6dlUiErmLpCKq0f2a+W63c66c2c2qJPz7mxRUqJWxN4Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbLnz1hsYz67j73;
	Fri, 16 Feb 2024 00:57:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 181051400D4;
	Fri, 16 Feb 2024 01:01:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 17:01:13 +0000
Date: Thu, 15 Feb 2024 17:01:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<dave@stgolabs.net>, <rafael@kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 08/12] cxl: Set cxlmd->endpoint before adding port
 device
Message-ID: <20240215170112.000056a6@Huawei.com>
In-Reply-To: <20240206222951.1833098-9-dave.jiang@intel.com>
References: <20240206222951.1833098-1-dave.jiang@intel.com>
	<20240206222951.1833098-9-dave.jiang@intel.com>
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

On Tue, 6 Feb 2024 15:28:36 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Move setting of cxlmd->endpoint to before calling add_device() on the port
> device. Otherwise when referencing cxlmd->endpoint in region discovery code
> that is triggered by the port driver probe function, the endpoint port
> pointer is not valid.

Maybe make it clear this only matters (I assume) when we start doing
such a look up?  Otherwise description sounds like a fix.


> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Change looks fine

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>

> ---
>  drivers/cxl/core/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e8029170b8c6..2f2b7af9275e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -822,6 +822,7 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
>  		 */
>  		port->reg_map = cxlds->reg_map;
>  		port->reg_map.host = &port->dev;
> +		cxlmd->endpoint = port;
>  	} else if (parent_dport) {
>  		rc = dev_set_name(dev, "port%d", port->id);
>  		if (rc)
> @@ -1374,7 +1375,6 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>  
>  	get_device(host);
>  	get_device(&endpoint->dev);
> -	cxlmd->endpoint = endpoint;
>  	cxlmd->depth = endpoint->depth;
>  	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
>  }


