Return-Path: <linux-acpi+bounces-3477-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A0D854BA5
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 15:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148231C221DF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Feb 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FF85C90D;
	Wed, 14 Feb 2024 14:37:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54C055C2B;
	Wed, 14 Feb 2024 14:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707921459; cv=none; b=QDLLwDBvW6gOrkK0d7apk1usYNBTRshmFsy0T3Faqcbln2S/L1aQezTbBLBtfzux/PVQEBCk57R+G5cAJMZOsBF2osczXol5J/VbhfhETJR4VGGv2alUe8UbV3R+vaaZKX7Mcq9seEBMocSjBllf5jice3aj5NiNGUr0XcDQC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707921459; c=relaxed/simple;
	bh=ZNfdoSdf/MHhb+FrmDp/v26fcivX0hWS3WAneNQnGR4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKRtAWteLepu8d4bBJTQZisnv7D1N7BndpK+YI0aZZ820SvjuZthRyUPqSXVCbIG7c7AuSX0WEQEicN9dlctC1sPbmdiH9okujPlXL6+b6JgOm37ZN63tUeLR/LBOU1Gqco+hr+4bkthluzGdtGfXfQtlJq5rhVlDdaa258gZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZgg40VpXz688jJ;
	Wed, 14 Feb 2024 22:33:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 51B1C1420F3;
	Wed, 14 Feb 2024 22:37:33 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 14:37:32 +0000
Date: Wed, 14 Feb 2024 14:37:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <dave@stogolabs.net>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rafael@kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v11 2/4] EINJ: Migrate to a platform driver
Message-ID: <20240214143732.000068b5@Huawei.com>
In-Reply-To: <20240208200042.432958-3-Benjamin.Cheatham@amd.com>
References: <20240208200042.432958-1-Benjamin.Cheatham@amd.com>
	<20240208200042.432958-3-Benjamin.Cheatham@amd.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Feb 2024 14:00:40 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Change the EINJ module to install a platform device/driver on module
> init and move the module init() and exit() functions to driver probe and
> remove. This change allows the EINJ module to load regardless of whether
> setting up EINJ succeeds, which allows dependent modules to still load
> (i.e. the CXL core).
> 
> Since EINJ may no longer be initialized when the module loads, any
> functions that are called from dependent/external modules should check
> the einj_initialized variable before calling any EINJ functions.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

As there is not a platform device about, could reduce the number of globals
in here, but job for another day.

Also devm fun might be useful to reduce the need for manual error handling
and remove().

So generally this enables some potential tidying up, but what you have
here LGTM and would be first step in that process anyway.
If I run out of other stuff to do (unlikely ;) then I might take a stab
at such a cleanup sometime.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> ---
>  drivers/acpi/apei/einj.c | 44 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
> index 013eb621dc92..73dde21d3e89 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj.c
> @@ -21,6 +21,7 @@
>  #include <linux/nmi.h>
>  #include <linux/delay.h>
>  #include <linux/mm.h>
> +#include <linux/platform_device.h>
>  #include <asm/unaligned.h>
>  
>  #include "apei-internal.h"
> @@ -136,6 +137,11 @@ static struct apei_exec_ins_type einj_ins_type[] = {
>   */
>  static DEFINE_MUTEX(einj_mutex);
>  
> +/*
> + * Exported APIs use this flag to exit early if einj_probe() failed.
> + */
> +static bool einj_initialized __ro_after_init;
> +
>  static void *einj_param;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
> @@ -684,7 +690,7 @@ static int einj_check_table(struct acpi_table_einj *einj_tab)
>  	return 0;
>  }
>  
> -static int __init einj_init(void)
> +static int __init einj_probe(struct platform_device *pdev)
>  {
>  	int rc;
>  	acpi_status status;
> @@ -782,7 +788,7 @@ static int __init einj_init(void)
>  	return rc;
>  }
>  
> -static void __exit einj_exit(void)
> +static void __exit einj_remove(struct platform_device *pdev)
>  {
>  	struct apei_exec_context ctx;
>  
> @@ -801,6 +807,40 @@ static void __exit einj_exit(void)
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
>  }



