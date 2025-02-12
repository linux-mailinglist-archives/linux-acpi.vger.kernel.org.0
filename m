Return-Path: <linux-acpi+bounces-11124-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EC3A32C8D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C543AB213
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A74256C7B;
	Wed, 12 Feb 2025 16:54:48 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D794520C49B;
	Wed, 12 Feb 2025 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379288; cv=none; b=OpqlPatJkrXOFG1UKgNKre8puL4CTFoRd1J00B69Vciee7hEOZ0hn1czsz6R/scb1CtapaaktYEpKZcc45ke1KwH6GYmdsdyOOhUgv8vDPYiDr4EZSKBLfj064lTgsfdhXqyBqgZvX+TtHNYFLij4xMoBlJlgUYX4AegU7YtRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379288; c=relaxed/simple;
	bh=GuygkFi22sYK5b+cU+tCC++IxONC5HFqPoaVnz3mWM8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=idIWd3yry4CU2mK940Zhe/lLyISPbvVtGxN5vFLEeMxTqJmqAfo+KVcEYW8AqHecelxdULENUEPshMSGoKTFQzOJ+p78+2zz8UYCHSPQJ+GrPWuONPArQIY+zTeo7bCRvj4i3X52Kt6Fz7kZf5nldSzo/e69Q0VUS6aWwsiP6j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPV61hYCz6L5Lh;
	Thu, 13 Feb 2025 00:51:42 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF601400CB;
	Thu, 13 Feb 2025 00:54:42 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 17:54:42 +0100
Date: Wed, 12 Feb 2025 16:54:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2
 support
Message-ID: <20250212165440.0000728b@huawei.com>
In-Reply-To: <20250210183705.1114624-8-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-8-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Feb 2025 10:37:03 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Create a debugfs blob file to be used for reading the user
> input for the component array. EINJv2 enables users to inject
> errors to multiple components/devices at the same time using
> component array.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index c604aa875644..40ebdbc4961f 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -33,6 +33,7 @@
>  #define SLEEP_UNIT_MAX		5000			/* 5ms */
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
> +#define COMP_ARR_SIZE		1024
>  #define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> @@ -107,6 +108,9 @@ static struct debugfs_blob_wrapper vendor_blob;
>  static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
> +static struct debugfs_blob_wrapper einjv2_component_arr;
> +static u64 component_count;
> +static void *user_input;
>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -892,6 +896,19 @@ static int __init einj_probe(struct platform_device *pdev)
>  				   &error_param4);
>  		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
>  				   einj_debug_dir, &notrigger);
> +		if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			debugfs_create_x64("einjv2_component_count", S_IRUSR | S_IWUSR,
> +					einj_debug_dir,	&component_count);
> +			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
> +			if (!user_input) {
> +				rc = -ENOMEM;
> +				goto err_release;
I think you need a new label as need to undo a few more things.
At least call apei_exec_post_unmap_gars() probably given it is called
in the remove function.

> +			}
> +			einjv2_component_arr.data = user_input;
> +			einjv2_component_arr.size = COMP_ARR_SIZE;
> +			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
> +					einj_debug_dir, &einjv2_component_arr);
> +		}
>  	}
>  
>  	if (vendor_dev[0]) {
> @@ -941,6 +958,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  	apei_resources_fini(&einj_resources);
>  	debugfs_remove_recursive(einj_debug_dir);
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
> +	kfree(user_input);
Should be place din equivalent location of where you allocate it in probe.
So probably before einj_exec_ctx_init()

Whilst it may make no actual difference a clean reverse order
is much easier to review as any exception can be easily spotted
and typically should have a comment on why the order is different.

>  }
>  
>  static struct platform_device *einj_dev;


