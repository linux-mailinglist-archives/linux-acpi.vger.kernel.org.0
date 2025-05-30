Return-Path: <linux-acpi+bounces-13962-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC92AC85A5
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 02:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F99D189CFED
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 00:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28303D6F;
	Fri, 30 May 2025 00:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iq0wqHmS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8BE632;
	Fri, 30 May 2025 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748564475; cv=none; b=eQw/MvGRPfabfXVme2QBy3kxM3rfzxme3pUpkDy7YNVECMJujgcbOXUlUh7pb+H/hFp+t4Jx71xf1HB9UPLtzDbuVjfFvOubdVZttnb7TBSdz3kLInjvt1RLb6ZPeZmALuOAIDtfhZ/Q+IeHcnyif3Pa8C0gB+705k+a9Wu1QPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748564475; c=relaxed/simple;
	bh=P5gWbhrcucId5s76sLp62JDJ45ZrdXT7Z3T+FJU+Wt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ar7T46ZgrR3rEMbM7UpcaRZxjTG1zlc2wlIgacmjA2akTkYoui6Xs+6Tl/IDzpf/LManT1mYECA9t5U+Hr02TeCZsmmLbMz7rVXHFra+2hHCSVqEl88FhpS/HRKeU7L0CgiIVT9F4SxwLGi3u96yTaxBVpJa+0jtt896v/iBc6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iq0wqHmS; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748564474; x=1780100474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=P5gWbhrcucId5s76sLp62JDJ45ZrdXT7Z3T+FJU+Wt0=;
  b=iq0wqHmS5ek5oHELrPTXWhUIkprOrV6wZWTm0qexkfpRjvCRzTNNb6M/
   NyjOZdlgSo5KPBp+8amiWpa7g8JbDLYqVjhlu0MkIU2TDLe0I+/Q1CoCG
   MTIVPQ8BJ6I19Qa5uR/+E68FAQ7zQGOEJ79fIn1FadbtX4GdC6kxcNYzS
   U+8PsG6qEfe7Asw1D37q80/c/GI8Ut6CD6enxUwlYAN3Kyg9qZ9E/QX/m
   wOO5OBaYuo73nHul12BQRLzsOvHo/id1O0uP2tMSpZoD7v8a0rkCYjtgx
   Lj18BpEFyOfq/jb/resBz+7d+ED9pGHu1T2JJgn03+Dp3W7wpeF8RbmFT
   A==;
X-CSE-ConnectionGUID: 8EnRIs+9Q9+sIeHBpTWQKQ==
X-CSE-MsgGUID: zZifG9lVSU2rkivS3Nr3Rw==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61704061"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="61704061"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 17:21:13 -0700
X-CSE-ConnectionGUID: 0KjYsiXcS7C8VgXvNquWeg==
X-CSE-MsgGUID: 9cQAoHYuRDevKTrESGBrYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="143542265"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 17:21:12 -0700
Date: Thu, 29 May 2025 17:21:11 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	john.allen@amd.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <aDj597ZLqrg-uZn-@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-9-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-9-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:12PM -0700, Zaid Alali wrote:
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
>  drivers/acpi/apei/einj-core.c | 177 +++++++++++++++++++++++++++++++---
>  1 file changed, 166 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 44f9166c3881..491d33529a3d 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -34,6 +34,7 @@
>  /* Firmware should respond within 1 seconds */
>  #define FIRMWARE_TIMEOUT	(1 * USEC_PER_SEC)
>  #define COMP_ARR_SIZE		1024
> +#define COMPONENT_LEN		16
>  #define ACPI65_EINJV2_SUPP	BIT(30)
>  #define ACPI5_VENDOR_BIT	BIT(31)
>  #define MEM_ERROR_MASK		(ACPI_EINJ_MEMORY_CORRECTABLE | \
> @@ -87,6 +88,14 @@ enum {
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
> +	EINJV2_VENDOR_ERROR = 0x80000000,
>  };
>  
>  /*
> @@ -110,6 +119,7 @@ static char vendor_dev[64];
>  
>  static struct debugfs_blob_wrapper einjv2_component_arr;
>  static void *user_input;
> +static int nr_components;

Maybe call this "max_component_count"?

This code figures out the value by digging into the BIOS structure
pointed at by the ACPI_EINJ_SET_ERROR_TYPE_WITH_ADDRESS entry in
the "EINJ" table. But doesn't make this visible to the user. Only
way for them to find it out is try try injections with progressively
more components until they get the ubiquitous -EINVAL error.

Please add a read-only file in the einj debugfs directory that will
show this value.

>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -180,6 +190,8 @@ static DEFINE_MUTEX(einj_mutex);
>  bool einj_initialized __ro_after_init;
>  
>  static void __iomem *einj_param;
> +static u32 v5param_size;
> +static bool is_V2;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -304,11 +316,31 @@ static void __iomem *einj_get_parameter_address(void)
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
> +				nr_components = (len - offset) /
> +						sizeof(v5param.einjv2_struct.component_arr[0]);
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
> @@ -486,6 +518,104 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  	return rc;
>  }
>  
> +static int parse_hex_to_u8(char *str, u8 *arr)
> +{
> +	char *ptr, val[32];
s/32/COMPONENT_LEN * 2/
> +	int pad, str_len;
> +
> +
> +	if (str[0] == '0' && (str[1] == 'x' || str[1] == 'X'))
> +		str += 2;
> +
> +	str_len = strlen(str);
> +	if (str_len > 32)
s/32/sizeof(val)/
> +		return -EINVAL;
> +
> +	memcpy(val, str, str_len);
Does not copy NUL string terminator. But see my next comments.
> +
> +	ptr = val;
> +	while (*ptr != '\0') {
But you scan "val" looking for the NUL!
> +		if (!isxdigit(*ptr))
> +			return -EINVAL;
> +		ptr++;
> +	}
Perhaps do this whole sanity check against "str" instead of "val"
and drop the memcpy() above?
> +
> +	pad = 32 - str_len;
> +
Comment here? /* prefix input with '0' characters */
> +	memmove(val + pad, val, str_len);
> +	memset(val, '0', pad);
> +
> +	for (int i = 0; i < COMPONENT_LEN; ++i) {
> +		char byte_str[3] = {val[i * 2], val[i * 2 + 1], '\0'};
> +		/* write bytes in little endian format to follow ACPI specs */
> +		arr[COMPONENT_LEN - i - 1] = (u8)strtoul(byte_str, NULL, 16);
> +	}
> +
> +	return 0;
> +}
Just to check the steps here.
1) User input 0x1234
2) val[] is set to "00000000000000000000000000001234"
3) arr[] is set to { 0x34, 0x12, 0x0 ... }
> +
> +static int read_component_array(struct set_error_type_with_address *v5param)
> +{
> +	int count = 0, str_len;
> +	u8 comp_arr[COMPONENT_LEN], synd_arr[COMPONENT_LEN];
> +	struct syndrome_array *component_arr;
> +	char *tok, *comp_str, *synd_str, *user;
> +
> +	component_arr = v5param->einjv2_struct.component_arr;
> +	str_len = strlen(user_input);
> +	user = user_input;
> +	user[str_len - 1] = '\0';
> +	while ((tok = strsep(&user, "\n")) != NULL) {
> +		if (count >= nr_components)
> +			return -EINVAL;
> +
> +		comp_str = strsep(&tok, " \t");
> +		synd_str = strsep(&tok, " \t");
> +
> +		if (!comp_str || !synd_str)
> +			return -EINVAL;
> +
> +		if (parse_hex_to_u8(comp_str, comp_arr))
> +			return -EINVAL;
> +		if (parse_hex_to_u8(synd_str, synd_arr))
> +			return -EINVAL;
> +
> +		switch (v5param->type) {
> +		case EINJV2_PROCESSOR_ERROR:
> +			for (int i = 0; i < COMPONENT_LEN; ++i) {
> +				component_arr[count].comp_id.acpi_id[i] = comp_arr[i];
> +				component_arr[count].comp_synd.proc_synd[i] = synd_arr[i];
> +			}
> +			break;
> +		case EINJV2_MEMORY_ERROR:
> +			for (int i = 0; i < COMPONENT_LEN; ++i) {
> +				component_arr[count].comp_id.device_id[i] = comp_arr[i];
> +				component_arr[count].comp_synd.mem_synd[i] = synd_arr[i];
> +			}
> +			break;
> +		case EINJV2_PCIE_ERROR:
> +			for (int i = 0; i < COMPONENT_LEN; ++i) {
> +				component_arr[count].comp_id.pcie_sbdf[i] = comp_arr[i];
> +				component_arr[count].comp_synd.pcie_synd[i] = synd_arr[i];
> +			}
> +			break;
> +		case EINJV2_VENDOR_ERROR:
> +			for (int i = 0; i < COMPONENT_LEN; ++i) {
> +				component_arr[count].comp_id.vendor_id[i] = comp_arr[i];
> +				component_arr[count].comp_synd.vendor_synd[i] = synd_arr[i];
> +			}
> +			break;

These four cases are all doing exactly the same thing since the targets
of the copies are overlapping "union" fields in the syndrome_array
structure. Could you just have:

struct syndrome_array {
	u8	component_id[16];
	u8	component_syndrome[16];
};

and then remove the switch((v5param->type) and just have:

	for (int i = 0; i < COMPONENT_LEN; ++i) {
		component_arr[count].component_id[i] = comp_arr[i];
		component_arr[count].component_syndrome[i] = synd_arr[i];
	}
		
> +		}
> +		count++;
> +
> +	}
> +	v5param->einjv2_struct.component_arr_count = count;
> +
> +	/* clear buffer after user input for next injection */
> +	memset(user_input, 0, COMP_ARR_SIZE);
No. User input should be sticky across injections.

> +	return 0;
> +}
> +
>  static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			       u64 param3, u64 param4)
>  {
> @@ -500,10 +630,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
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
> @@ -523,8 +653,19 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  			v5param->flags = flags;
>  			v5param->memory_address = param1;
>  			v5param->memory_address_range = param2;
> -			v5param->apicid = param3;
> -			v5param->pcie_sbdf = param4;
> +
> +			if (is_V2) {
> +				rc = read_component_array(v5param);
> +				if (rc) {
> +					kfree(v5param);
> +					goto err_out;
> +				}
> +				/* clear buffer after user input for next injection */
> +				memset(user_input, 0, COMP_ARR_SIZE);
No. User input should be sticky across injections.

> +			} else {
> +				v5param->apicid = param3;
> +				v5param->pcie_sbdf = param4;
> +			}
>  		} else {
>  			switch (type) {
>  			case ACPI_EINJ_PROCESSOR_CORRECTABLE:
> @@ -548,7 +689,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> -		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> +		memcpy_toio(einj_param, v5param, v5param_size);
> +		kfree(v5param);
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
> @@ -600,6 +742,9 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	rc = apei_exec_run_optional(&ctx, ACPI_EINJ_END_OPERATION);
>  
>  	return rc;
> +err_out:
> +	memset(user_input, 0, COMP_ARR_SIZE);
No. User input should be sticky across injections.

> +	return -EINVAL;
>  }
>  
>  /* Inject the specified hardware error */
> @@ -610,10 +755,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
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
> @@ -764,7 +914,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;
>  
>  	return 0;
> @@ -783,9 +933,11 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
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
> @@ -807,6 +959,9 @@ static int error_inject_set(void *data, u64 val)
>  	if (!error_type)
>  		return -EINVAL;
>  
> +	if (is_V2)
> +		error_flags |= SETWA_FLAGS_EINJV2;
> +
>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
>  		error_param3, error_param4);
>  }
> @@ -955,7 +1110,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  
>  	if (einj_param) {
>  		acpi_size size = (acpi5) ?
> -			sizeof(struct set_error_type_with_address) :
> +			v5param_size :
>  			sizeof(struct einj_parameter);
>  
>  		acpi_os_unmap_iomem(einj_param, size);
> -- 
> 2.43.0
> 

