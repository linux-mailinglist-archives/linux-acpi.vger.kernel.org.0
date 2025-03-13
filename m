Return-Path: <linux-acpi+bounces-12171-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46112A5EFAA
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 10:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFE4179D4E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 09:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA408263C8E;
	Thu, 13 Mar 2025 09:37:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377C25FA0D;
	Thu, 13 Mar 2025 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858674; cv=none; b=iduVa5Dzk964c+IlTL8Xybmh6kKb9vI/AimsmXK5rgddvdhnetOHFjFNKs0OsuzQcjk4v9RlEnmv/WXjbJvEvgJPwRwXOSyBCmhoua9NCHjkh+DYbKxTU/NHfkgKnvMYHTcr19qeET381xe5m7Am+lbrNOps/mDORJg18uBWDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858674; c=relaxed/simple;
	bh=znEuZ53TxTz0nJRHhcA3Sgdlgmi6R1MC4XsIZjxIggY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nuf+8LpGsSDmnS7P45f449AChQyC83fbhxO97PyE/DoAdaVMruwUQozy9sDMxBLXjYZ8ExDegr0WdXkyqkJ0mlGS1gCjKGszGO5De2Slz8L8SQXA2AoV+qlGITa3tIFXRdJw3ahHrEcmwrdB4uOHjmoUeVCdS4GnGT5gyA4Mdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2R26Wnkz6K9cg;
	Thu, 13 Mar 2025 17:35:10 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A0647140D26;
	Thu, 13 Mar 2025 17:37:48 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:37:44 +0100
Date: Thu, 13 Mar 2025 09:37:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <20250313093743.00007602@huawei.com>
In-Reply-To: <20250306234810.75511-4-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-4-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:48:04 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
Hi Zaid,

I'm not so keen on loosing the type of the pointer as that leads
to slightly odd situation of using the size of where we care copying it
to later for the dma mapping. Kind of fine, but weird looking!
Also, if you keep original naming and introduce a new v_copy or similar
then you can end up with a shorter and probably easier to review patch.
(slightly)

Jonathan

> ---
>  drivers/acpi/apei/einj-core.c | 104 +++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 04731a5b01fa..b40ed44c4983 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -149,7 +149,7 @@ static DEFINE_MUTEX(einj_mutex);
>   */
>  bool einj_initialized __ro_after_init;
>  
> -static void *einj_param;
> +static void __iomem *einj_param;
>  
>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -214,21 +214,23 @@ static void check_vendor_extension(u64 paddr,
>  				   struct set_error_type_with_address *v5param)
>  {
>  	int	offset = v5param->vendor_extension;
> -	struct	vendor_error_type_extension *v;
> +	struct	vendor_error_type_extension v;
> +	void __iomem *p;
I'd keep it typed.
	struct __iomem vendor_error_extension *p;

>  	u32	sbdf;
>  
>  	if (!offset)
>  		return;
> -	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> -	if (!v)
> +	p = acpi_os_map_iomem(paddr + offset, sizeof(v));
then this can be sizeof(*p)

Or reduce the diff and rename the copy + add __iomem
marking to the original *v definition. 
Call the copy v_copy or something like that.


> +	if (!p)
>  		return;
> -	get_oem_vendor_struct(paddr, offset, v);
> -	sbdf = v->pcie_sbdf;
> +	memcpy_fromio(&v, p, sizeof(v));
> +	get_oem_vendor_struct(paddr, offset, &v);
> +	sbdf = v.pcie_sbdf;
>  	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
>  		sbdf >> 24, (sbdf >> 16) & 0xff,
>  		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
> -		 v->vendor_id, v->device_id, v->rev_id);
> -	acpi_os_unmap_iomem(v, sizeof(*v));
> +		 v.vendor_id, v.device_id, v.rev_id);
> +	acpi_os_unmap_iomem(p, sizeof(v));
>  }
>  
>  static void *einj_get_parameter_address(void)
> @@ -252,26 +254,30 @@ static void *einj_get_parameter_address(void)
>  		entry++;
>  	}
>  	if (pa_v5) {
> -		struct set_error_type_with_address *v5param;
> +		struct set_error_type_with_address v5param;
> +		void __iomem *p;

Similar to above in remaining cases.

Jonathan

 
>  
> -		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> -		if (v5param) {
> +		p = acpi_os_map_iomem(pa_v5, sizeof(v5param));
> +		if (p) {
> +			memcpy_fromio(&v5param, p, sizeof(v5param));
>  			acpi5 = 1;
> -			check_vendor_extension(pa_v5, v5param);
> -			return v5param;
> +			check_vendor_extension(pa_v5, &v5param);
> +			return p;
>  		}
>  	}
>  	if (param_extension && pa_v4) {
> -		struct einj_parameter *v4param;
> +		struct einj_parameter v4param;
> +		void __iomem *p;
>  
> -		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> -		if (!v4param)
> +		p = acpi_os_map_iomem(pa_v4, sizeof(v4param));
> +		if (!p)
>  			return NULL;
> -		if (v4param->reserved1 || v4param->reserved2) {
> -			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
> +		memcpy_fromio(&v4param, p, sizeof(v4param));
> +		if (v4param.reserved1 || v4param.reserved2) {
> +			acpi_os_unmap_iomem(p, sizeof(v4param));
>  			return NULL;
>  		}
> -		return v4param;
> +		return p;
>  	}
>  
>  	return NULL;
> @@ -317,7 +323,7 @@ static struct acpi_generic_address *einj_get_trigger_parameter_region(
>  static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  				u64 param1, u64 param2)
>  {
> -	struct acpi_einj_trigger *trigger_tab = NULL;
> +	struct acpi_einj_trigger trigger_tab;
>  	struct apei_exec_context trigger_ctx;
>  	struct apei_resources trigger_resources;
>  	struct acpi_whea_header *trigger_entry;
> @@ -325,54 +331,57 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  	u32 table_size;
>  	int rc = -EIO;
>  	struct acpi_generic_address *trigger_param_region = NULL;
> +	void __iomem *p;
>  
> -	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
> +	r = request_mem_region(trigger_paddr, sizeof(trigger_tab),
>  			       "APEI EINJ Trigger Table");
>  	if (!r) {
>  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger table\n",
>  		       (unsigned long long)trigger_paddr,
>  		       (unsigned long long)trigger_paddr +
> -			    sizeof(*trigger_tab) - 1);
> +			    sizeof(trigger_tab) - 1);
>  		goto out;
>  	}
> -	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> -	if (!trigger_tab) {
> +	p = ioremap_cache(trigger_paddr, sizeof(trigger_tab));
> +	if (!p) {
>  		pr_err("Failed to map trigger table!\n");
>  		goto out_rel_header;
>  	}
> -	rc = einj_check_trigger_header(trigger_tab);
> +	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
> +	rc = einj_check_trigger_header(&trigger_tab);
>  	if (rc) {
>  		pr_warn(FW_BUG "Invalid trigger error action table.\n");
>  		goto out_rel_header;
>  	}
>  
>  	/* No action structures in the TRIGGER_ERROR table, nothing to do */
> -	if (!trigger_tab->entry_count)
> +	if (!trigger_tab.entry_count)
>  		goto out_rel_header;
>  
>  	rc = -EIO;
> -	table_size = trigger_tab->table_size;
> -	r = request_mem_region(trigger_paddr + sizeof(*trigger_tab),
> -			       table_size - sizeof(*trigger_tab),
> +	table_size = trigger_tab.table_size;
> +	r = request_mem_region(trigger_paddr + sizeof(trigger_tab),
> +			       table_size - sizeof(trigger_tab),
>  			       "APEI EINJ Trigger Table");
>  	if (!r) {
>  		pr_err("Can not request [mem %#010llx-%#010llx] for Trigger Table Entry\n",
> -		       (unsigned long long)trigger_paddr + sizeof(*trigger_tab),
> +		       (unsigned long long)trigger_paddr + sizeof(trigger_tab),
>  		       (unsigned long long)trigger_paddr + table_size - 1);
>  		goto out_rel_header;
>  	}
> -	iounmap(trigger_tab);
> -	trigger_tab = ioremap_cache(trigger_paddr, table_size);
> -	if (!trigger_tab) {
> +	iounmap(p);
> +	p = ioremap_cache(trigger_paddr, table_size);
> +	if (!p) {
>  		pr_err("Failed to map trigger table!\n");
>  		goto out_rel_entry;
>  	}
> +	memcpy_fromio(&trigger_tab, p, sizeof(trigger_tab));
>  	trigger_entry = (struct acpi_whea_header *)
> -		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
> +		((char *)&trigger_tab + sizeof(struct acpi_einj_trigger));
>  	apei_resources_init(&trigger_resources);
>  	apei_exec_ctx_init(&trigger_ctx, einj_ins_type,
>  			   ARRAY_SIZE(einj_ins_type),
> -			   trigger_entry, trigger_tab->entry_count);
> +			   trigger_entry, trigger_tab.entry_count);
>  	rc = apei_exec_collect_resources(&trigger_ctx, &trigger_resources);
>  	if (rc)
>  		goto out_fini;
> @@ -390,7 +399,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  
>  		apei_resources_init(&addr_resources);
>  		trigger_param_region = einj_get_trigger_parameter_region(
> -			trigger_tab, param1, param2);
> +			&trigger_tab, param1, param2);
>  		if (trigger_param_region) {
>  			rc = apei_resources_add(&addr_resources,
>  				trigger_param_region->address,
> @@ -419,13 +428,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  out_fini:
>  	apei_resources_fini(&trigger_resources);
>  out_rel_entry:
> -	release_mem_region(trigger_paddr + sizeof(*trigger_tab),
> -			   table_size - sizeof(*trigger_tab));
> +	release_mem_region(trigger_paddr + sizeof(trigger_tab),
> +			   table_size - sizeof(trigger_tab));
>  out_rel_header:
> -	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
> +	release_mem_region(trigger_paddr, sizeof(trigger_tab));
>  out:
> -	if (trigger_tab)
> -		iounmap(trigger_tab);
> +	if (p)
> +		iounmap(p);
>  
>  	return rc;
>  }
> @@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  		return rc;
>  	apei_exec_ctx_set_input(&ctx, type);
>  	if (acpi5) {
> -		struct set_error_type_with_address *v5param = einj_param;
> +		struct set_error_type_with_address *v5param, v5_struct;
>  
> +		v5param = &v5_struct;
> +		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {
> @@ -490,15 +501,18 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> +		memcpy_toio(einj_param, v5param, sizeof(*v5param));
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
>  			return rc;
>  		if (einj_param) {
> -			struct einj_parameter *v4param = einj_param;
> +			struct einj_parameter v4param;
>  
> -			v4param->param1 = param1;
> -			v4param->param2 = param2;
> +			memcpy_fromio(&v4param, einj_param, sizeof(v4param));
> +			v4param.param1 = param1;
> +			v4param.param2 = param2;
> +			memcpy_toio(einj_param, &v4param, sizeof(v4param));
>  		}
>  	}
>  	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);


