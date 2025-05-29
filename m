Return-Path: <linux-acpi+bounces-13960-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADFEAC8506
	for <lists+linux-acpi@lfdr.de>; Fri, 30 May 2025 01:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5A499E3D08
	for <lists+linux-acpi@lfdr.de>; Thu, 29 May 2025 23:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5E221733;
	Thu, 29 May 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToY9hXjM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782122D7B8;
	Thu, 29 May 2025 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748561769; cv=none; b=FTbV51iQ3wXSbDb7udMcTeuzR0SD/RtPeYV9MJCbuXKQLJE/gD9M3j06edzh5GvQpq6/7l8TSQkoG8RtcYutHVZzSB2ONXGdlVifwZS2vnejnc/yxWMvuUpQgxIjB82tnRmWXK07IuF4Dt6zmcm9p2yTPkUDAU41pIlJ+kgeoR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748561769; c=relaxed/simple;
	bh=Q2XwdLQnrIkll8t6+9mdiBU9jJB2NiAhwlt3aabO7FU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwuOe9UDKdpa75vC7UA8YaYqh6tz3GZda9Kp6EQViAE0B2dczyxKtbK1eyl1Hfo/gI2ET1Y7cZ7Of0vHAwhtCLJ/WcBt70xX7TNjTz529nLSWF0vLVD8mKOwENQ5JQ1O1ZtWKnMpP0jLenzdWpmd6P2ZKAg4FR84bG//81kR1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToY9hXjM; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748561768; x=1780097768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q2XwdLQnrIkll8t6+9mdiBU9jJB2NiAhwlt3aabO7FU=;
  b=ToY9hXjMTjR0a3iI5E4SEZ+/kD5NvjUwAs+RF3i7mWLlXCjRDLLzBO4f
   Xnf8GIL7MOgbguPnHMPGTz2W4ZGQ+HYYv6b3S6kpu0Q59hA0Cc43pXWa1
   RaFp/scbb46LfZiV8yepfy243X6XoH4nI5IIr10ISwZyVuuAdOE3nkadB
   mCAlyIeQas1j22sZqgi+WswUQ40dKQ8jSHaVA8l02UB8MYTtVsXCtiOfu
   mwfHvgHqH2Az9iG+RWuPvkB4PaSBMYJtBsYhSjmzsXT2M8pDwiDLqXSKF
   RcR8sKw9L3e83sK+3dxz4dMoMdQ9eOKC2AHnI4gMsFEPrrfbyXjbNHt01
   Q==;
X-CSE-ConnectionGUID: SvA0uToCTYGm+0oxG5ju9A==
X-CSE-MsgGUID: Oz6jk4KDRWKBQAed4IiBRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61309731"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="61309731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 16:36:07 -0700
X-CSE-ConnectionGUID: xkSmuDiqQNe++hBVgTDbiA==
X-CSE-MsgGUID: GUAqWgrhSrml+jXCTsCGOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="144356843"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.103.51])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 16:36:06 -0700
Date: Thu, 29 May 2025 16:36:05 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
Cc: rafael@kernel.org, lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
	robert.moore@intel.com, Jonathan.Cameron@huawei.com,
	ira.weiny@intel.com, Benjamin.Cheatham@amd.com,
	dan.j.williams@intel.com, arnd@arndb.de, Avadhut.Naik@amd.com,
	u.kleine-koenig@pengutronix.de, john.allen@amd.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: Re: [PATCH v7 7/9] ACPI: APEI: EINJ: Add debugfs files for EINJv2
 support
Message-ID: <aDjvZVUU_GJ4dxQ_@agluck-desk3>
References: <20250506213814.2365788-1-zaidal@os.amperecomputing.com>
 <20250506213814.2365788-8-zaidal@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506213814.2365788-8-zaidal@os.amperecomputing.com>

On Tue, May 06, 2025 at 02:38:11PM -0700, Zaid Alali wrote:
> Create a debugfs blob file to be used for reading the user
> input for the component array. EINJv2 enables users to inject
> errors to multiple components/devices at the same time using
> component array.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 60e4f3dc7055..44f9166c3881 100644
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
> @@ -107,6 +108,8 @@ static struct debugfs_blob_wrapper vendor_blob;
>  static struct debugfs_blob_wrapper vendor_errors;
>  static char vendor_dev[64];
>  
> +static struct debugfs_blob_wrapper einjv2_component_arr;
> +static void *user_input;

Better name for this? "user_input" is too generic.

>  static u32 available_error_type;
>  static u32 available_error_type_v2;
>  
> @@ -689,6 +692,7 @@ static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
>  static char einj_buf[32];
> +static bool EINJv2_enabled;
>  static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(0), "Processor Correctable" },
>  	{ BIT(1), "Processor Uncorrectable non-fatal" },
> @@ -718,7 +722,7 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
>  				   einj_error_type_string[pos].str);
> -	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +	if ((available_error_type & ACPI65_EINJV2_SUPP) && EINJv2_enabled) {
>  		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++) {
>  			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
>  				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> @@ -901,8 +905,22 @@ static int __init einj_probe(struct platform_device *pdev)
>  				   &error_param4);
>  		debugfs_create_x32("notrigger", S_IRUSR | S_IWUSR,
>  				   einj_debug_dir, &notrigger);
> +		if (available_error_type & ACPI65_EINJV2_SUPP) {
> +			user_input = kzalloc(COMP_ARR_SIZE, GFP_KERNEL);
> +			if (!user_input) {
> +				EINJv2_enabled = false;
> +				pr_info("EINJv2 is disabled: not enough memory\n");
> +				goto skip_EINJv2;
> +			}
> +			EINJv2_enabled = true;
> +			einjv2_component_arr.data = user_input;
> +			einjv2_component_arr.size = COMP_ARR_SIZE;
> +			debugfs_create_blob("einjv2_component_array", S_IRUSR | S_IWUSR,
> +					einj_debug_dir, &einjv2_component_arr);
> +		}
>  	}
>  
> +skip_EINJv2:
>  	if (vendor_dev[0]) {
>  		vendor_blob.data = vendor_dev;
>  		vendor_blob.size = strlen(vendor_dev);
> @@ -944,6 +962,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}
> +	kfree(user_input);
>  	einj_exec_ctx_init(&ctx);
>  	apei_exec_post_unmap_gars(&ctx);
>  	apei_resources_release(&einj_resources);
> -- 
> 2.43.0
> 

