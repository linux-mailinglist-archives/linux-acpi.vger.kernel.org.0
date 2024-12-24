Return-Path: <linux-acpi+bounces-10300-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7E69FBFD6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 16:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83CF1885943
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C501D63DE;
	Tue, 24 Dec 2024 15:57:15 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C08836;
	Tue, 24 Dec 2024 15:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055835; cv=none; b=vGp3qIONZ+MNGoKuFYDItWHvawDohmBMrMI2YnBfYSs39BV7iMByEiwkBOjYsL5bLNw4t8SODVNRvRWFYuARpLKU3KIEumPfQy5ndzyGMlicDCPt8HBYmnZ2gIaz+LwSFBk/3JXiO/8pglAeFzqW2GV0XHbBufeghaTGOtdWsis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055835; c=relaxed/simple;
	bh=4Xb80o2Er7OeJ3kvIVcLh8DZa9zXBH2vRFWWdfveFBA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=feO4tBq/YVR/jtd/tbt4mbVNAYH3XNlkUucFqB0TfRu1ICxTk040+MItphMD8IeYyigyxriHMws81jEGzLB5mb2icoMxsH45XTTrEe2UZG76tPDTaItyHdhuIkijCqwBn5NZnj5E7+BIbLWhTrONspho5lyXlazcUtABe+elkyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfYm2h5bz6K5rS;
	Tue, 24 Dec 2024 23:53:16 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CDE4140C72;
	Tue, 24 Dec 2024 23:57:09 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:57:08 +0100
Date: Tue, 24 Dec 2024 15:57:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <20241224155705.0000347e@huawei.com>
In-Reply-To: <20241205211854.43215-9-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-9-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  5 Dec 2024 13:18:53 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Enable the driver to inject EINJv2 type errors. The component
> array values are parsed from user_input and expected to contain
> hex values for component id and syndrome separated by space,
> and multiple components are separated by new line as follows:
> 
> component_id1 component_syndrome1
> component_id2 component_syndrome2
>  :
> component_id(n) component_syndrome(n)
> 
> for example:
> 
> $comp_arr="0x1 0x2
> >0x1 0x4
> >0x2 0x4"  
> $cd /sys/kernel/debug/apei/einj/
> $echo "$comp_arr" > einjv2_component_array
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 82 +++++++++++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 1961f140ada8..d8ce859e6b5c 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -87,6 +87,13 @@ enum {
>  	SETWA_FLAGS_APICID = 1,
>  	SETWA_FLAGS_MEM = 2,
>  	SETWA_FLAGS_PCIE_SBDF = 4,
> +	SETWA_FLAGS_EINJV2 = 8,
> +};
> +
> +enum {
> +	EINJV2_PROCESSOR_ERROR = 0x1,
> +	EINJV2_MEMORY_ERROR = 0x2,
> +	EINJV2_PCIE_ERROR = 0x4,
>  };
>  
>  /*
> @@ -111,6 +118,7 @@ static char vendor_dev[64];
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static u64 component_count;
>  static void *user_input;
> +static int nr_components;
>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -181,6 +189,7 @@ static DEFINE_MUTEX(einj_mutex);
>  bool einj_initialized __ro_after_init;
>  
>  static void *einj_param;
> +static bool is_V2;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -290,9 +299,19 @@ static void *einj_get_parameter_address(void)
>  
>  		p = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
>  		if (p) {
> +			int offset, len;
>  			v5param = __io_virt(p);
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param->einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / 32;
> +				acpi_os_unmap_iomem(p, sizeof(*v5param));
> +				p = acpi_os_map_iomem(pa_v5, sizeof(*v5param) +
> +					((nr_components) * sizeof(struct syndrome_array)));

Use struct_size() which is there to help with variable elements on the end of structures.


> +				v5param = __io_virt(p);

As before. This to me looks like a hack where we should be using standard accessors
for the __iomem addresses.

> +			}
>  			return v5param;
>  		}
>  	}
> @@ -505,8 +524,49 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (is_V2) {
> +				int count = 0, bytes_read, pos = 0;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				if (component_count > nr_components)
> +					goto err_out;
> +
> +				v5param->einjv2_struct.component_arr_count = component_count;
> +				component_arr = v5param->einjv2_struct.component_arr;
> +
> +				while (sscanf(user_input + pos, "%x %x\n%n", &comp, &synd,
> +					&bytes_read) == 2) {
> +					pos += bytes_read;
> +					if (count > component_count)
> +						goto err_out;
> +
> +					switch (type) {
> +					case EINJV2_PROCESSOR_ERROR:
> +						component_arr[count].comp_id.acpi_id = comp;
> +						component_arr[count].comp_synd.proc_synd = synd;
> +						break;
> +					case EINJV2_MEMORY_ERROR:
> +						component_arr[count].comp_id.device_id = comp;
> +						component_arr[count].comp_synd.mem_synd = synd;
> +						break;
> +					case EINJV2_PCIE_ERROR:
> +						component_arr[count].comp_id.pcie_sbdf = comp;
> +						component_arr[count].comp_synd.pcie_synd = synd;
> +						break;
> +					}
> +					count++;
> +				}
> +				if (count != component_count)
> +					goto err_out;
> +
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -579,6 +639,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
> +	return -EINVAL;
>  }
>  
>  /* Inject the specified hardware error */
> @@ -590,9 +653,14 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  
>  	/* If user manually set "flags", make sure it is legal */
>  	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF|SETWA_FLAGS_EINJV2)))
Whilst here, make it compliant with kernel style and add space around | 

>  		return -EINVAL;
>  
> +	/*check if type is a valid EINJv2 error type*/
Space after /* 
Make sure to run checkpatch (I'm not sure it catches this though!)

> +	if (is_V2) {
> +		if (!(type & available_error_type_v2))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -753,12 +821,14 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
>  	u64 val;
>  
>  	memset(einj_buf, 0, sizeof(einj_buf));
> +	is_V2 = false;
>  	if (copy_from_user(einj_buf, buf, count))
>  		return -EFAULT;
>  
>  	if (strncmp(einj_buf, "V2_", 3) == 0) {
>  		if (!sscanf(einj_buf, "V2_%llx", &val))
>  			return -EINVAL;
> +		is_V2 = true;
>  	} else
>  		if (!sscanf(einj_buf, "%llx", &val))
>  			return -EINVAL;
> @@ -782,6 +852,9 @@ static int error_inject_set(void *data, u64 val)
>  	if (!error_type)
>  		return -EINVAL;
>  
> +	if (is_V2)
> +		error_flags |= SETWA_FLAGS_EINJV2;
> +
>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
>  		error_param3, error_param4);
>  }
> @@ -942,7 +1015,8 @@ static void __exit einj_remove(struct platform_device *pdev)
>  			sizeof(struct set_error_type_with_address) :
>  			sizeof(struct einj_parameter);
>  
> -		acpi_os_unmap_iomem((void __iomem *)einj_param, size);
> +		acpi_os_unmap_iomem((void __iomem *)einj_param,
> +				size + (nr_components * sizeof(struct syndrome_array)));
struct_size()

>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}


