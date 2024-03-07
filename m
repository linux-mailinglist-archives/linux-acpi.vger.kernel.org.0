Return-Path: <linux-acpi+bounces-4162-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 084CC874EA0
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 13:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62728B234BF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Mar 2024 12:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17856129A75;
	Thu,  7 Mar 2024 12:09:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017DC1292CA;
	Thu,  7 Mar 2024 12:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813366; cv=none; b=CzCZKB2kunX5Etq1gukTEhzA3ZtCzRnNH2FDReKr7ypJoKWLm1gtNW64MdzIQN1tBFlf3eul4440a/NmK+3fennBrkA5LAaPkens8HROBumNWh7LFOTLWpeHwiQnoHg851LzhjVCFxDfoFrbauRj3SJRR675XzWmLsFdzXsQSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813366; c=relaxed/simple;
	bh=au39YmGx8ilYO3dZwJkJ5QjFYvpS3MxTfxRBS6yr7RY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWL8Eo18QYxY43MQNCZdJuzpSPQ4/yUakn+UCC38hykvCIAZFzRfcPD9XzmdGamEqyGPMakeihMLtj3ZTDZ8TbksJrouVQUjaHGS+jwrrAXza0f/1iBGOQ2k7aDkuZuQfsTbSBZB3CjCD1oaXWxTZTiZDFCa6p3cmY8PWtWaVKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr7KY6hWlz6K9Fd;
	Thu,  7 Mar 2024 20:05:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 379DD14142C;
	Thu,  7 Mar 2024 20:09:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 12:09:19 +0000
Date: Thu, 7 Mar 2024 12:09:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <dan.j.williams@intel.com>, <rafael@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <dave@stogolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v14 2/4] EINJ: Add CXL error type support
Message-ID: <20240307120918.00003c56@Huawei.com>
In-Reply-To: <20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
References: <20240226222704.1079449-1-Benjamin.Cheatham@amd.com>
	<20240226222704.1079449-3-Benjamin.Cheatham@amd.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 26 Feb 2024 16:27:02 -0600
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Remove CXL protocol error types from the EINJ module and move them to
> a new einj_cxl module. The einj_cxl module implements the necessary
> handling for CXL protocol error injection and exposes an API for the
> CXL core to use said functionality. Because the CXL error types
> require special handling, only allow them to be injected through the
> einj_cxl module and return an error when attempting to inject through
> "regular" EINJ.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
Hi Ben,

Some minor comments inline given you are doing a v15 (yikes!)

Jonathan

> diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj-core.c
> similarity index 94%
> rename from drivers/acpi/apei/einj.c
> rename to drivers/acpi/apei/einj-core.c
> index 937c69844dac..1a5f53d81d09 100644
> --- a/drivers/acpi/apei/einj.c
> +++ b/drivers/acpi/apei/einj-core.c

...

> @@ -640,29 +648,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> -{
> -	*val = error_type;
> -
> -	return 0;
> -}
> -
> -static int error_type_set(void *data, u64 val)
> +int einj_validate_error_type(u64 type)
>  {
> +	u32 tval, vendor, available_error_type = 0;
>  	int rc;
> -	u32 available_error_type = 0;
> -	u32 tval, vendor;
>  
>  	/* Only low 32 bits for error type are valid */
> -	if (val & GENMASK_ULL(63, 32))
> +	if (type & GENMASK_ULL(63, 32))
>  		return -EINVAL;
>  
>  	/*
>  	 * Vendor defined types have 0x80000000 bit set, and
>  	 * are not enumerated by ACPI_EINJ_GET_ERROR_TYPE
>  	 */
> -	vendor = val & ACPI5_VENDOR_BIT;
> -	tval = val & 0x7fffffff;
> +	vendor = type & ACPI5_VENDOR_BIT;
> +	tval = type & GENMASK(30, 0);
>  
>  	/* Only one error type can be specified */
>  	if (tval & (tval - 1))
> @@ -671,9 +671,37 @@ static int error_type_set(void *data, u64 val)
>  		rc = einj_get_available_error_type(&available_error_type);
>  		if (rc)
>  			return rc;
> -		if (!(val & available_error_type))
> +		if (!(type & available_error_type))
>  			return -EINVAL;
>  	}
> +
> +	return 0;
> +}
> +
> +bool einj_is_cxl_error_type(u64 type)
> +{
> +	return (type & CXL_ERROR_MASK) && (!(type & ACPI5_VENDOR_BIT));
> +}
> +
> +static int error_type_get(void *data, u64 *val)
This is reordered, but fairly sure no need to do so and it will
make patch cleaner to leave it above the validation code.

> +{
> +	*val = error_type;
> +
> +	return 0;
> +}
> +
> +static int error_type_set(void *data, u64 val)
> +{
> +	int rc;
> +
> +	/* CXL error types have to be injected from cxl debugfs */
> +	if (einj_is_cxl_error_type(val))
> +		return -EINVAL;
> +
> +	rc = einj_validate_error_type(val);

Trivial but I'd have preferred this factoring out in a precursor patch
just to make reviewing this a tiny bit easier.


> +	if (rc)
> +		return rc;
> +
>  	error_type = val;
>  
>  	return 0;
> diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
> new file mode 100644
> index 000000000000..34badc6a801e
> --- /dev/null
> +++ b/drivers/acpi/apei/einj-cxl.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * CXL Error INJection support. Used by CXL core to inject
> + * protocol errors into CXL ports.
> + *
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#include <linux/einj-cxl.h>
> +#include <linux/debugfs.h>
Follow include what you use principles a little closer
(there are always exceptions in kernel world...).
The following seems resonable to me.

#include <linux/array_size.h>
#include <linux/seq_file.h>


> +
> +#include "apei-internal.h"
> +
> +/* Defined in einj-core.c */
> +extern bool einj_initialized;
> +
> +static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
> +	{ BIT(12), "CXL.cache Protocol Correctable" },

Use the defines for the bits? Not sure why the original code didn't do so other
than maybe long line lengths?



> +	{ BIT(13), "CXL.cache Protocol Uncorrectable non-fatal" },
> +	{ BIT(14), "CXL.cache Protocol Uncorrectable fatal" },
> +	{ BIT(15), "CXL.mem Protocol Correctable" },
> +	{ BIT(16), "CXL.mem Protocol Uncorrectable non-fatal" },
> +	{ BIT(17), "CXL.mem Protocol Uncorrectable fatal" },
> +};
> +
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v)
> +{
> +	int cxl_err, rc;
> +	u32 available_error_type = 0;
> +
> +	if (!einj_initialized)
> +		return -ENXIO;
> +
> +	rc = einj_get_available_error_type(&available_error_type);
> +	if (rc)
> +		return rc;
> +
> +	for (int pos = 0; pos < ARRAY_SIZE(einj_cxl_error_type_string); pos++) {
> +		cxl_err = ACPI_EINJ_CXL_CACHE_CORRECTABLE << pos;
Hmm. This is a little ugly.
Could do something like the following bit it's of similar level of ugly
so up to you.

	int bit_pos = ACPI_EINJ_CXL_CACHE_CORRECTABLE;
	for_each_bit_set_bit_from(bit_pos, &available_error_type,
			     ARRAY_SIZE(einj_cxl_error_type_string)) {
		int pos = bit_pos - ACPI_EINJ_CXL_CACHE_CORRECTABLE;
	
	

> +
> +		if (available_error_type & cxl_err)
> +			seq_printf(m, "0x%08x\t%s\n",
> +				   einj_cxl_error_type_string[pos].mask,
> +				   einj_cxl_error_type_string[pos].str);
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(einj_cxl_available_error_type_show, CXL);


> diff --git a/include/linux/einj-cxl.h b/include/linux/einj-cxl.h
> new file mode 100644
> index 000000000000..4a1f4600539a
> --- /dev/null
> +++ b/include/linux/einj-cxl.h
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * CXL protocol Error INJection support.
> + *
> + * Copyright (c) 2023 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <benjamin.cheatham@amd.com>
> + */
> +#ifndef EINJ_CXL_H
> +#define EINJ_CXL_H
> +
> +#include <linux/pci.h>
Use a forwards def

struct pci_dev;

and drop the include. Also need

struct seq_file;


> +
> +#if IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL)
> +int einj_cxl_available_error_type_show(struct seq_file *m, void *v);
> +int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type);
> +int einj_cxl_inject_rch_error(u64 rcrb, u64 type);
> +bool einj_cxl_is_initialized(void);
> +#else /* !IS_ENABLED(CONFIG_ACPI_APEI_EINJ_CXL) */
> +static inline int einj_cxl_available_error_type_show(struct seq_file *m,
> +						     void *v)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_error(struct pci_dev *dport_dev, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline int einj_cxl_inject_rch_error(u64 rcrb, u64 type)
> +{
> +	return -ENXIO;
> +}
> +
> +static inline bool einj_cxl_is_initialized(void) { return false; }
> +#endif /* CONFIG_ACPI_APEI_EINJ_CXL */
> +
> +#endif /* EINJ_CXL_H */


