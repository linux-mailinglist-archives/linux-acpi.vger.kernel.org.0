Return-Path: <linux-acpi+bounces-12739-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC5CA7B9FF
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B6D517A309
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 09:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6E1A5BBB;
	Fri,  4 Apr 2025 09:32:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47819E806;
	Fri,  4 Apr 2025 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759124; cv=none; b=C9NDrlW0DTzpP1YKg8fIo3xx/4n77G80aAwTwPMpL9oX2+Bzb2UWFqo2UVDYY2cDSRSBhqOG48BQsEI8ZNAg04DILd/xrYud7FCbO1rnwMD6QhscCbCDkFNg4an+mrcEZawF1gjpOvwzdRHJRnbbek0SF4+o6xvz/PogSYGqHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759124; c=relaxed/simple;
	bh=NZJxUJy7Um2sTpsSNP4Xh8mYmYG6ITY43ECPxBl8628=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oRWuR6XL2REVKpgWo9nnwhqJdmDJ+DmwH2MAzKu0rpEpLs5OjrFF0X35CPPGdYeYDZsB+0QRBtEB5NQbCbGP5bI/TB2PKEsKs5unvLRWGWJBC7dY9302ah6ZqqfulghP65fIEWdFJvf3kfg7Tl89d5rJML+4sJyL9j3dr1kIn2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZTYDx4y1qz6M4K7;
	Fri,  4 Apr 2025 17:28:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 479AB1404F9;
	Fri,  4 Apr 2025 17:31:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 4 Apr
 2025 11:31:58 +0200
Date: Fri, 4 Apr 2025 10:31:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v5 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <20250404103157.000002be@huawei.com>
In-Reply-To: <20250403231339.23708-9-zaidal@os.amperecomputing.com>
References: <20250403231339.23708-1-zaidal@os.amperecomputing.com>
	<20250403231339.23708-9-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  3 Apr 2025 16:13:38 -0700
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
>  drivers/acpi/apei/einj-core.c | 108 ++++++++++++++++++++++++++++++----
>  1 file changed, 97 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index dd7626da360c..b90865c2d995 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -34,6 +34,7 @@
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
>  #define COMP_ARR_SIZE		1024
> +#define COMPONENT_LEN		32

The thing this is a length of is a component syndrome (I think) so
the naming is confusing.  Better to just use sizeof(struct syndrome_array)
or even better the sizeof(v5param.einjv2_struct->component_arr[0])
or similar so we don't even need to check the types match.

Always better to establish size of elements from their definitions
rather than to add another define for it. 

>  #define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> @@ -87,6 +88,13 @@ enum {
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
> @@ -110,6 +118,7 @@ static char vendor_dev[64];
>  
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static void *user_input;
> +static int nr_components;
>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -180,6 +189,8 @@ static DEFINE_MUTEX(einj_mutex);
>  bool einj_initialized __ro_after_init;
>  
>  static void __iomem *einj_param;
> +static u32 v5param_size;
> +static bool is_V2;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -287,11 +298,30 @@ static void __iomem *einj_get_parameter_address(void)
>  		struct set_error_type_with_address v5param;
>  		struct set_error_type_with_address __iomem *p;
>  
> +		v5param_size = sizeof(v5param);
>  		p = acpi_os_map_iomem(pa_v5, sizeof(*p));
>  		if (p) {
> -			memcpy_fromio(&v5param, p, sizeof(v5param));
> +			int offset, len;
> +
> +			memcpy_fromio(&v5param, p, v5param_size);
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, &v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param.einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / COMPONENT_LEN;
> +				/*
> +				 * The first call to acpi_os_map_iomem above does not include the
> +				 * component array, instead it is used to read and calculate maximum
> +				 * number of components supported by the system. Below, the mapping
> +				 * is expanded to include the component array.
> +				 */
> +				acpi_os_unmap_iomem(p, v5param_size);
> +				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
> +				v5param_size = offset + struct_size(&v5param.einjv2_struct,
> +					component_arr, nr_components);
> +				p = acpi_os_map_iomem(pa_v5, v5param_size);
> +			}
>  			return p;
>  		}
>  	}
> @@ -483,10 +513,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  		return rc;
>  	apei_exec_ctx_set_input(&ctx, type);
>  	if (acpi5) {
> -		struct set_error_type_with_address *v5param, v5_struct;
> +		struct set_error_type_with_address *v5param;
>  
> -		v5param = &v5_struct;
> -		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
> +		v5param = kmalloc(v5param_size, GFP_KERNEL);
> +		memcpy_fromio(v5param, einj_param, v5param_size);
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {
> @@ -506,8 +536,50 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (is_V2) {
> +				int count = 0, bytes_read, pos = 0, nr_parsed = 0, str_len;
> +				unsigned int comp, synd;
> +				struct syndrome_array *component_arr;
> +
> +				component_arr = v5param->einjv2_struct.component_arr;
> +				str_len = strlen(user_input);
> +
> +				while ((nr_parsed = sscanf(user_input + pos, "%x %x\n%n", &comp,
> +					&synd, &bytes_read))) {
> +					pos += bytes_read;
> +
> +					if (nr_parsed != 2)
> +						goto err_out;
> +					if (count >= nr_components)
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
> +					if (pos >= str_len)
> +						break;
> +				}
> +				v5param->einjv2_struct.component_arr_count = count;
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
> @@ -531,7 +603,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> +		memcpy_toio(einj_param, v5param, v5param_size);
> +		kfree(v5param);
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
> @@ -583,6 +656,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
> +	return -EINVAL;
>  }
>  
>  /* Inject the specified hardware error */
> @@ -593,10 +669,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  	u64 base_addr, size;
>  
>  	/* If user manually set "flags", make sure it is legal */
> -	if (flags && (flags &
> -		~(SETWA_FLAGS_APICID|SETWA_FLAGS_MEM|SETWA_FLAGS_PCIE_SBDF)))
> +	if (flags && (flags & ~(SETWA_FLAGS_APICID | SETWA_FLAGS_MEM |
> +		      SETWA_FLAGS_PCIE_SBDF | SETWA_FLAGS_EINJV2)))
>  		return -EINVAL;
>  
> +	/* check if type is a valid EINJv2 error type */
> +	if (is_V2) {
> +		if (!(type & available_error_type_v2))
> +			return -EINVAL;
> +	}
>  	/*
>  	 * We need extra sanity checks for memory errors.
>  	 * Other types leap directly to injection.
> @@ -746,7 +827,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;
>  
>  	return 0;
> @@ -765,9 +846,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
>  	if (strncmp(einj_buf, "V2_", 3) == 0) {
>  		if (!sscanf(einj_buf, "V2_%llx", &val))
>  			return -EINVAL;
> +		is_V2 = true;
>  	} else {
>  		if (!sscanf(einj_buf, "%llx", &val))
>  			return -EINVAL;
> +		is_V2 = false;
>  	}
>  
>  	rc = einj_validate_error_type(val);
> @@ -789,6 +872,9 @@ static int error_inject_set(void *data, u64 val)
>  	if (!error_type)
>  		return -EINVAL;
>  
> +	if (is_V2)
> +		error_flags |= SETWA_FLAGS_EINJV2;
> +
>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
>  		error_param3, error_param4);
>  }
> @@ -942,7 +1028,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  
>  	if (einj_param) {
>  		acpi_size size = (acpi5) ?
> -			sizeof(struct set_error_type_with_address) :
> +			v5param_size :
>  			sizeof(struct einj_parameter);
>  
>  		acpi_os_unmap_iomem(einj_param, size);


