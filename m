Return-Path: <linux-acpi+bounces-10298-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9579FBFC5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 16:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F447A1D10
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56D21C5491;
	Tue, 24 Dec 2024 15:46:58 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F141C1F0F;
	Tue, 24 Dec 2024 15:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735055218; cv=none; b=N4j3Za/bBx9LrDh5oSZ9VkA/PfD9JRKXK78ZidXVYcagwEaXDpU8CfZovsQqY4xQ3BQqGQVtX2hFyenT3nLiQdpEyAS5iLJXIyjaYoDiXNgQ3NZOUoA7bjNvTV4GhqfM/F/alVKOeqt0w0Hf0TMP4fKqyzG6O+BmJmsoUWqtQBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735055218; c=relaxed/simple;
	bh=t6sDP0khEBxCajt3bXytBfkQtjrQxcBJ+GsmF5qQt8g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=krMKhE3+kGu5HooPIvNVt0ijmAfX6r/Hfehi737KRrti3NDCx0cO9GSWLxbadfXmeVeg761y39JD7MPTIBdFK6bAqh+y3uRmE8femp3alUclw7nSmQN1yvEMClHJPuAi5jADEJ3r0Eaf6KzgzqMVDMkXT99Rt+RPh7re8+HYvQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHfQ209x5z6K64P;
	Tue, 24 Dec 2024 23:46:34 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1465614038F;
	Tue, 24 Dec 2024 23:46:54 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:46:53 +0100
Date: Tue, 24 Dec 2024 15:46:50 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 5/9] ACPI: APEI: EINJ: Enable the discovery of EINJv2
 capabilities
Message-ID: <20241224154650.00006a06@huawei.com>
In-Reply-To: <20241205211854.43215-6-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-6-zaidal@os.amperecomputing.com>
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

On Thu,  5 Dec 2024 13:18:50 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> Enable the driver to show all supported error injections for EINJ
> and EINJv2 at the same time. EINJv2 capabilities can be discovered
> by checking the return value of get_error_type, where bit 30 set
> indicates EINJv2 support.
> 
> This update makes the driver parse the error_type as a string to
> avoid any ambiguity with EINJv1 and EINJv2 error types that has
> the same value, where EINJv2 error types has the prefix "V2_".
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Hi Zaid,

Some comments inline.

Thanks,

Jonathan

> ---
>  drivers/acpi/apei/apei-internal.h |  2 +-
>  drivers/acpi/apei/einj-core.c     | 70 ++++++++++++++++++++++++-------
>  drivers/acpi/apei/einj-cxl.c      |  2 +-
>  3 files changed, 56 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/apei/apei-internal.h b/drivers/acpi/apei/apei-internal.h
> index cd2766c69d78..9a3dbaeed39a 100644
> --- a/drivers/acpi/apei/apei-internal.h
> +++ b/drivers/acpi/apei/apei-internal.h
> @@ -131,7 +131,7 @@ static inline u32 cper_estatus_len(struct acpi_hest_generic_status *estatus)
>  
>  int apei_osc_setup(void);
>  
> -int einj_get_available_error_type(u32 *type);
> +int einj_get_available_error_type(u32 *type, int version);

As below. I'm not sure version is a good name for this as it
is not the version number at all.

>  int einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2, u64 param3,
>  		      u64 param4);
>  int einj_cxl_rch_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index a6b648361d96..2c57e25252ac 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c

> @@ -641,6 +643,7 @@ static u64 error_param2;
>  static u64 error_param3;
>  static u64 error_param4;
>  static struct dentry *einj_debug_dir;
> +static char *einj_buf;
>  static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(0), "Processor Correctable" },
>  	{ BIT(1), "Processor Uncorrectable non-fatal" },
> @@ -656,6 +659,11 @@ static struct { u32 mask; const char *str; } const einj_error_type_string[] = {
>  	{ BIT(11), "Platform Uncorrectable fatal"},
>  	{ BIT(31), "Vendor Defined Error Types" },
>  };

blank line here.

> +static struct { u32 mask; const char *str; } const einjv2_error_type_string[] = {
> +	{ BIT(0), "EINJV2 Processor Error" },
> +	{ BIT(1), "EINJV2 Memory Error" },
> +	{ BIT(2), "EINJV2 PCI Express Error" },
> +};
>  
>  static int available_error_type_show(struct seq_file *m, void *v)
>  {
> @@ -663,18 +671,22 @@ static int available_error_type_show(struct seq_file *m, void *v)
>  	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
>  		if (available_error_type & einj_error_type_string[pos].mask)
>  			seq_printf(m, "0x%08x\t%s\n", einj_error_type_string[pos].mask,
> -				   einj_error_type_string[pos].str);
> -
> +				einj_error_type_string[pos].str);

Fix this up and check for any other accidental changes like this. They just
make the patches harder to review.


> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		for (int pos = 0; pos < ARRAY_SIZE(einjv2_error_type_string); pos++)
> +			if (available_error_type_v2 & einjv2_error_type_string[pos].mask)
> +				seq_printf(m, "V2_0x%08x\t%s\n", einjv2_error_type_string[pos].mask,

Long line. I'd wrap before last parameter for readability.

> +					einjv2_error_type_string[pos].str);

Align after closing bracket.

> +	}
>  	return 0;
>  }
>  
>  DEFINE_SHOW_ATTRIBUTE(available_error_type);
>  
> -static int error_type_get(void *data, u64 *val)
> +static ssize_t error_type_get(struct file *file, char __user *buf,
> +				size_t count, loff_t *ppos)
>  {
> -	*val = error_type;
> -
> -	return 0;
> +	return simple_read_from_buffer(buf, count, ppos, einj_buf, strlen(einj_buf));
>  }
>  
>  bool einj_is_cxl_error_type(u64 type)
> @@ -701,15 +713,28 @@ int einj_validate_error_type(u64 type)
>  	if (tval & (tval - 1))
>  		return -EINVAL;
>  	if (!vendor)
> -		if (!(type & available_error_type))
> +		if (!(type & (available_error_type | available_error_type_v2)))

Maybe a comment on this. Not obvious to me which the | makes sense.

>  			return -EINVAL;
>  
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
> +	memset(einj_buf, 0, sizeof(einj_buf));

sizeof the pointer?

> +	if (copy_from_user(einj_buf, buf, count))

What stops this being bigger than einj_buf?  Perhaps
best to check that.

> +		return -EFAULT;
> +
> +	if (strncmp(einj_buf, "V2_", 3) == 0) {
> +		if (!sscanf(einj_buf, "V2_%llx", &val))
> +			return -EINVAL;
> +	} else
	} else {

Both because you kernel style is same bracketing for all legs
of if / else and because what follows is multi line.

> +		if (!sscanf(einj_buf, "%llx", &val))
> +			return -EINVAL;
>  
>  	rc = einj_validate_error_type(val);
>  	if (rc)
> @@ -717,11 +742,13 @@ static int error_type_set(void *data, u64 val)
>  
>  	error_type = val;
>  
> -	return 0;
> +	return count;
>  }

>  static int error_inject_set(void *data, u64 val)
>  {
> @@ -778,9 +805,14 @@ static int __init einj_probe(struct platform_device *pdev)
>  		goto err_put_table;
>  	}
>  
> -	rc = einj_get_available_error_type(&available_error_type);
> +	rc = einj_get_available_error_type(&available_error_type, ACPI_EINJ_GET_ERROR_TYPE);
>  	if (rc)
>  		return rc;
> +	if (available_error_type & ACPI65_EINJV2_SUPP) {
> +		rc = einj_get_available_error_type(&available_error_type_v2, ACPI_EINJV2_GET_ERROR_TYPE);
The parameter is called version. I'd expect that to just be 1 or 2 giving naming.
Maybe a different parameter name would be less confusing?

> +		if (rc)
> +			return rc;
> +	}
>  
>  	rc = -ENOMEM;
>  	einj_debug_dir = debugfs_create_dir("einj", apei_get_debugfs_dir());
> @@ -828,6 +860,11 @@ static int __init einj_probe(struct platform_device *pdev)
>  				   einj_debug_dir, &notrigger);
>  	}
>  
> +	einj_buf = kzalloc(32, GFP_KERNEL);

Why 32? Can we base that on a define or similar?
Given it is global anyway and fairly small, why not just declare
a static array and skip the allocation and free?


> +	if (!einj_buf) {
> +		goto err_release;

Not sure on local style, but general kernel style is no brackets for single line if block.

> +	}
> +
>  	if (vendor_dev[0]) {
>  		vendor_blob.data = vendor_dev;
>  		vendor_blob.size = strlen(vendor_dev);
> @@ -875,6 +912,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  	apei_resources_fini(&einj_resources);
>  	debugfs_remove_recursive(einj_debug_dir);
>  	acpi_put_table((struct acpi_table_header *)einj_tab);
> +	kfree(einj_buf);
>  }
>  

>  	if (rc)
>  		return rc;
>  


