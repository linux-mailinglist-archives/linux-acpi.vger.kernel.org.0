Return-Path: <linux-acpi+bounces-11122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 075A5A32C4C
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B481F162F9D
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A494624C68E;
	Wed, 12 Feb 2025 16:47:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8119724E4A8;
	Wed, 12 Feb 2025 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378874; cv=none; b=oLrqhIfgIj2bLhmSi9CE06vtY9pbEpXOE0hfTo2Y8bQ9gIiYzViXSzPtYahu2M6+Smbkc/A6MFoSQ/3qbisC165230EUj5MrQNWiJvEI6v8D5706d1XwPkGKoQF7FqlohRgG750rH4XYTZrzAOJ4l+XpNI9eySfetC47E3E0Nts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378874; c=relaxed/simple;
	bh=q3XwQPyJU0mqjMIdaQkGPUk0zNgXTeV2LkgIOh5TjLk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbLLlpxIVESmXurWd1QXTllfSI4u3LAa1tGeOc4VdZKnGB3mmSiULTBB23RwRyqC3+dPxPfsmj2xj/ndr/emD5kPqvG1TdjMNJBKZkXbPD0OUb0a0RVvI84LQmO+Z0gyM+Egeg8rK3Z5z4jSEBSUSJxdsHbRO5G2Ps3uDb7WkWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtPN74G05z6K5n1;
	Thu, 13 Feb 2025 00:46:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9B264140B73;
	Thu, 13 Feb 2025 00:47:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 17:47:46 +0100
Date: Wed, 12 Feb 2025 16:47:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <20250212164745.00000c5f@huawei.com>
In-Reply-To: <20250210183705.1114624-6-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-6-zaidal@os.amperecomputing.com>
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

On Mon, 10 Feb 2025 10:37:01 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Hi Zaid,
A few comments inline.

Jonathan

> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 0f65e8bc4c30..369d92e410c1 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c

> @@ -649,6 +651,8 @@ static u64 error_param2;
>  static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
> +#define BUFF_SIZE	32

That's very generic name. I'd just put value inline and where
you use it currently just use sizeof(einj_buf) instead.

> +static char einj_buf[BUFF_SIZE];
>  static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(0), "Processor Correctable" },
>  	{ BIT(1), "Processor Uncorrectable non-fatal" },
> @@ -665,6 +669,12 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(31), "Vendor Defined Error Types" },
>  };
>  
> +static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
> +	{ BIT(0), "EINJV2 Processor Error" },
> +	{ BIT(1), "EINJV2 Memory Error" },
> +	{ BIT(2), "EINJV2 PCI Express Error" },
> +};
> +
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
>  
> @@ -672,17 +682,21 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
>  				   einj_error_type_string[pos].str);
> -
> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)

Add some {} probably as multiple lines.  Coding style is a little unclear on this
but here I think it would help a little.

> +			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
> +				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,
> +					   einjv2_error_type_string[pos].str);
> +	}
>  	return 0;
>  }

>  bool einj_is_cxl_error_type(u64 type)
> @@ -715,9 +729,22 @@ int einj_validate_error_type(u64 type)
>  	return 0;
>  }
>  
> -static int error_type_set(void *data, u64 val)
> +static ssize_t error_type_set(struct file *file, const char __user *buf,
> +				size_t count, loff_t *ppos)
>  {
>  	int rc;
> +	u64 val;
> +
> +	memset(einj_buf, 0, BUFF_SIZE);
> +	if (copy_from_user(einj_buf, buf, count))
> +		return -EFAULT;
> +
> +	if (strncmp(einj_buf, "V2_", 3) == 0) {
> +		if (!sscanf(einj_buf, "V2_%llx", &val))
> +			return -EINVAL;
> +	} else

Brackets in this leg as well.
Convention is put them in all legs + this one is also multiline so
should be here anyway.

> +		if (!sscanf(einj_buf, "%llx", &val))
> +			return -EINVAL;
>  
>  	rc = einj_validate_error_type(val);
>  	if (rc)
> @@ -725,11 +752,13 @@ static int error_type_set(void *data, u64 val)
>  
>  	error_type = val;
>  
> -	return 0;
> +	return count;
>  }
>  
> -DEFINE_DEBUGFS_ATTRIBUTE(error_type_fops, error_type_get, error_type_set,
> -			 "0x%llx\n");
> +static const struct file_operations error_type_fops = {
> +	.read		= error_type_get,
> +	.write		= error_type_set,
> +};
>  
>  static int error_inject_set(void *data, u64 val)
>  {
> @@ -737,7 +766,7 @@ static int error_inject_set(void *data, u64 val)
>  		return -EINVAL;
>  
>  	return einj_error_inject(error_type, error_flags, error_param1, error_param2,
> -		error_param3, error_param4);
> +				error_param3, error_param4);
I'd avoid reformatting in a patch doing anything else.
Hard to spot if real changes...

>  }
>  


