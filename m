Return-Path: <linux-acpi+bounces-3474-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9121854B10
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 15:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543E91C2061B
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB5B54792;
	Wed, 14 Feb 2024 14:06:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F51CA80;
	Wed, 14 Feb 2024 14:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919564; cv=none; b=pPCk/YxxLkiCHRb962+goeYYK2CrMROeEywQJnOGsHtHgg7aQQSqYQD3A+SRsZNZ70RmEN+9ytShMhj5XgmeUY/eXzMmRCu5xdVZ1wGBiFnzUWoXixYofcCiz/1vsH3zBxAEuVd8A1XujXTh+6xsMZKCYXnPKQNRJOqaq7wY5tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919564; c=relaxed/simple;
	bh=I8uD/uWhqpZWE10BNoqp3oglC2tD95ug6K3C7j2nRW4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+fkgPAUUTw6Y1VqaQiPRk6IIVVHGKX1uB6WNPGE8Vkl4gaiQP+FnQF/1kL7QBkyKlUFcCzlbIL0PTPTHUx+tWmHfN79eVj6prLqi7q7VvXyy4rYlrIE8sZ2ldMtqoe93QwKgwxsHhVQpPIgfHGo6LXGEFyqGVZiQHzhzE6oJqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZfyG581Rz6J9wW;
	Wed, 14 Feb 2024 22:01:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 63976140FC8;
	Wed, 14 Feb 2024 22:05:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 14:05:57 +0000
Date: Wed, 14 Feb 2024 14:05:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 1/4] cxl, ACPI, APEI, EINJ: Add CXL_EINJ Kconfig
 option
Message-ID: <20240214140557.000037b8@Huawei.com>
In-Reply-To: <20240208200042.432958-2-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
	<20240208200042.432958-2-Benjamin.Cheatham@amd.com>
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

On Thu, 8 Feb 2024 14:00:39 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add CONFIG_CXL_EINJ to cxl/Kconfig. This option will allow for the CXL
> core module to access helpers inside the EINJ module, while also giving
> users the option of disabling CXL EINJ error types at build time.
> 
> Also update CONFIG_ACPI_APEI_EINJ to set CONFIG_CXL_EINJ by default.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Hi Ben,

I'm not a particular fan of Kconfig only patches, so would personally
have squashed this with patch 3 (or wherever it gets used)

That would also have had the side effect of making it clear this
doesn't actually get used (you and Dan have been discussing how
it should be).

Jonathan


> ---
>  drivers/cxl/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..95f215a2e5dc 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -157,4 +157,16 @@ config CXL_PMU
>  	  monitoring units and provide standard perf based interfaces.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_EINJ
> +	bool "CXL Error INJection Support"
> +	default ACPI_APEI_EINJ
> +	depends on ACPI_APEI_EINJ >= CXL_BUS
> +	help
> +	  Support for CXL protocol Error INJection through debugfs/cxl.
> +	  Availability and which errors are supported is dependent on
> +	  the host platform. Look to ACPI v6.5 section 18.6.4 and kernel
> +	  EINJ documentation for more information.
> +
> +	  If unsure say 'n'
>  endif


