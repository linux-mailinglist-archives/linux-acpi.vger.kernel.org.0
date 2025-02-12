Return-Path: <linux-acpi+bounces-11126-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7E8A32CDE
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 18:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABFA93A4C1E
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78657212B31;
	Wed, 12 Feb 2025 17:04:27 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92FE260A54;
	Wed, 12 Feb 2025 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739379867; cv=none; b=FMrE+w/1/SC/WFWfNP/ORX/A94lGHqNf+DPc/qZp7gQdmIoAtD1ecObDryRNpEYFk2lO5p5IY7afrD1O0TfAjqSL6merE4REq2p5/3srtPlkkg+P7UVhtA3m5lyz39ACaQkEVhS9YpJv9eLu6ffVhaW+zJhxuDIXxHSVbD4qudI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739379867; c=relaxed/simple;
	bh=13W5/30634OZAOEp8C34fhFNef/hkBvT0Qann9WW4zE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eLxTwwsTQHF1Iuc5Xj0T7zU3HSYC4C/BuX75y6CmuPe7DqwjYyzFxWiU05rSE9PBGUeaWHwPNCvTTs87ns0g9sTOWIhzjn7j0bUN9TQ9ACMs+sUyTxjmo29Enpt1MmVRQpfDuPiClflD1LZmsk6TNpBRT+fDIwTzDPXfsX1RNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPj734z1z6L5JZ;
	Thu, 13 Feb 2025 01:01:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D503140525;
	Thu, 13 Feb 2025 01:04:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 18:04:15 +0100
Date: Wed, 12 Feb 2025 17:04:14 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <20250212170414.000059c4@huawei.com>
In-Reply-To: <20250210183705.1114624-9-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-9-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 10 Feb 2025 10:37:04 -0800
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
>  drivers/acpi/apei/einj-core.c | 103 +++++++++++++++++++++++++++++-----
>  1 file changed, 89 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 40ebdbc4961f..46359019ca03 100644
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
> @@ -181,6 +189,8 @@ static DEFINE_MUTEX(einj_mutex);
>  bool einj_initialized __ro_after_init;
>  
>  static void __iomem *einj_param;
> +static u32 v5param_size;
> +static bool is_V2;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -288,11 +298,23 @@ static void *einj_get_parameter_address(void)
>  		struct set_error_type_with_address v5param;
>  		void __iomem *p;
>  
> +		v5param_size = sizeof(v5param);
>  		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
>  		if (p) {
> -			memcpy_fromio(&v5param, p, sizeof(v5param));
> +			int offset, len;
> +
> +			memcpy_fromio(&v5param, p, v5param_size);

Here you clear the first part, but not the extra elements.

>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, &v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param.einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / 32;
> +				acpi_os_unmap_iomem(p, v5param_size);
> +				v5param_size = sizeof(v5param) +
> +					(nr_components * sizeof(struct syndrome_array));

struct_size()

> +				p = acpi_os_map_iomem(pa_v5, v5param_size);
> +			}
>  			return p;
>  		}
>  	}
> @@ -486,8 +508,8 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  	if (acpi5) {
>  		struct set_error_type_with_address *v5param;
>  
> -		v5param = kmalloc(sizeof(*v5param), GFP_KERNEL);
> -		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
> +		v5param = kmalloc(v5param_size, GFP_KERNEL);

This patch is the point where kmalloc makes sense. I'd introduce it here
rather than in earlier patch.

> +		memcpy_fromio(v5param, einj_param, v5param_size);
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {

...

>  /* Inject the specified hardware error */
> @@ -597,10 +663,15 @@ int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
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
> @@ -750,7 +821,7 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))
>  			return -EINVAL;
>  
>  	return 0;
> @@ -763,12 +834,14 @@ static ssize_t error_type_set(struct file *file, const char __user *buf,
>  	u64 val;
>  
>  	memset(einj_buf, 0, BUFF_SIZE);
> +	is_V2 = false;
>  	if (copy_from_user(einj_buf, buf, count))
>  		return -EFAULT;
>  
>  	if (strncmp(einj_buf, "V2_", 3) == 0) {
>  		if (!sscanf(einj_buf, "V2_%llx", &val))
>  			return -EINVAL;
> +		is_V2 = true;

Given you have an if / else here. Set is_V2 = false
in the else rather that default and override in one leg of
the if / else.

>  	} else
>  		if (!sscanf(einj_buf, "%llx", &val))
>  			return -EINVAL;
> @@ -792,6 +865,9 @@ static int error_inject_set(void *data, u64 val)
>  	if (!error_type)
>  		return -EINVAL;
>  
> +	if (is_V2)
> +		error_flags |= SETWA_FLAGS_EINJV2;
> +
>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
>  				error_param3, error_param4);
>  }
> @@ -944,11 +1020,10 @@ static void __exit einj_remove(struct platform_device *pdev)
>  	struct apei_exec_context ctx;
>  
>  	if (einj_param) {
> -		acpi_size size = (acpi5) ?
> -			sizeof(struct set_error_type_with_address) :
> -			sizeof(struct einj_parameter);
> -
> -		acpi_os_unmap_iomem(einj_param, size);

Unless strong reason to change I'd keep to existing style and just
replace the true condition with v5param_size

> +		if (acpi5)
> +			acpi_os_unmap_iomem(einj_param, v5param_size);
> +		else
> +			acpi_os_unmap_iomem(einj_param,	sizeof(struct einj_parameter));
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}


