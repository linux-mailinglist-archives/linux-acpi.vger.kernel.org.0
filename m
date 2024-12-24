Return-Path: <linux-acpi+bounces-10296-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6819FBFA8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B39CB163148
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Dec 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60751CCEF0;
	Tue, 24 Dec 2024 15:29:05 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341F91D63FB;
	Tue, 24 Dec 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735054145; cv=none; b=d7AkkLpeXq93SGmy2BDo60+DF3xEfoYcQ7CXVpB63jfiIDNi67EGSNljnVqonsQrCMbuN56Pj0Sd+Q1xpbAoxPTHRoxmI4IQWCgmQVFSvbXI/YVjZbO2ieWNe4jqlxYxoQJD3HDmPYZy1hFjvKicCELMvu1xT6XhGxNK9wJcoiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735054145; c=relaxed/simple;
	bh=Xxabx2yQs6nT3BkBYK659eODR+m9DbKkc0L7tI6nF8I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmXGnXPbm2I4DXGsSv7utJIxnFo1N2qYmLX5+yuCTNzbzY7jwfXY81JMhc6jKopSs+bWkEntmEUT0plHm33Hmo6LqULeT6WAYiuV7t8JR0JNq+sjkfTX4lFWyYnjToDMy+AHTPf3t+2EI6bkNhDHLBaxYx/mTt0A08eKRJ0xHu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YHf0L0sBrz67KdR;
	Tue, 24 Dec 2024 23:27:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 90601140447;
	Tue, 24 Dec 2024 23:28:59 +0800 (CST)
Received: from localhost (10.48.156.150) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Dec
 2024 16:28:58 +0100
Date: Tue, 24 Dec 2024 15:28:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v2 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <20241224152855.000044d0@huawei.com>
In-Reply-To: <20241205211854.43215-4-zaidal@os.amperecomputing.com>
References: <20241205211854.43215-1-zaidal@os.amperecomputing.com>
	<20241205211854.43215-4-zaidal@os.amperecomputing.com>
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

On Thu,  5 Dec 2024 13:18:48 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>
> ---
>  drivers/acpi/apei/einj-core.c | 41 +++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 04731a5b01fa..74dfb3daba50 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c
> @@ -215,20 +215,22 @@ static void check_vendor_extension(u64 paddr,
>  {
>  	int	offset = v5param->vendor_extension;
>  	struct	vendor_error_type_extension *v;
> +	void __iomem *p;
>  	u32	sbdf;
>  
>  	if (!offset)
>  		return;
> -	v = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> -	if (!v)
> +	p = acpi_os_map_iomem(paddr + offset, sizeof(*v));
> +	if (!p)
>  		return;
> +	v = __io_virt(p);

That's a nasty forced cast. Far as I can tell all this code
should not be assuming it can just cast away the __iomem

I think it should be fixed by using readl() etc or
memcpy_fromio()

Maybe it is safe to just ignore the marking for all current ACPI
platforms, I'm not sure.  This isn't a high performance path so
personally I'd just do it the generic way even if it is not
strictly necessary.

Jonathan



>  	get_oem_vendor_struct(paddr, offset, v);
>  	sbdf = v->pcie_sbdf;
>  	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
>  		sbdf >> 24, (sbdf >> 16) & 0xff,
>  		(sbdf >> 11) & 0x1f, (sbdf >> 8) & 0x7,
>  		 v->vendor_id, v->device_id, v->rev_id);
> -	acpi_os_unmap_iomem(v, sizeof(*v));
> +	acpi_os_unmap_iomem(p, sizeof(*v));
>  }
>  
>  static void *einj_get_parameter_address(void)
> @@ -253,9 +255,11 @@ static void *einj_get_parameter_address(void)
>  	}
>  	if (pa_v5) {
>  		struct set_error_type_with_address *v5param;
> +		void __iomem *p;
>  
> -		v5param = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> -		if (v5param) {
> +		p = acpi_os_map_iomem(pa_v5, sizeof(*v5param));
> +		if (p) {
> +			v5param = __io_virt(p);
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, v5param);
>  			return v5param;
> @@ -263,12 +267,14 @@ static void *einj_get_parameter_address(void)
>  	}
>  	if (param_extension && pa_v4) {
>  		struct einj_parameter *v4param;
> +		void __iomem *p;
>  
> -		v4param = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> -		if (!v4param)
> +		p = acpi_os_map_iomem(pa_v4, sizeof(*v4param));
> +		if (!p)
>  			return NULL;
> +		v4param = __io_virt(p);
>  		if (v4param->reserved1 || v4param->reserved2) {
> -			acpi_os_unmap_iomem(v4param, sizeof(*v4param));
> +			acpi_os_unmap_iomem(p, sizeof(*v4param));
>  			return NULL;
>  		}
>  		return v4param;
> @@ -325,6 +331,7 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  	u32 table_size;
>  	int rc = -EIO;
>  	struct acpi_generic_address *trigger_param_region = NULL;
> +	void __iomem *p;
>  
>  	r = request_mem_region(trigger_paddr, sizeof(*trigger_tab),
>  			       "APEI EINJ Trigger Table");
> @@ -335,11 +342,12 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  			    sizeof(*trigger_tab) - 1);
>  		goto out;
>  	}
> -	trigger_tab = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> -	if (!trigger_tab) {
> +	p = ioremap_cache(trigger_paddr, sizeof(*trigger_tab));
> +	if (!p) {
>  		pr_err("Failed to map trigger table!\n");
>  		goto out_rel_header;
>  	}
> +	trigger_tab = __io_virt(p);
>  	rc = einj_check_trigger_header(trigger_tab);
>  	if (rc) {
>  		pr_warn(FW_BUG "Invalid trigger error action table.\n");
> @@ -361,12 +369,13 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
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
> +	trigger_tab = __io_virt(p);
>  	trigger_entry = (struct acpi_whea_header *)
>  		((char *)trigger_tab + sizeof(struct acpi_einj_trigger));
>  	apei_resources_init(&trigger_resources);
> @@ -424,8 +433,8 @@ static int __einj_error_trigger(u64 trigger_paddr, u32 type,
>  out_rel_header:
>  	release_mem_region(trigger_paddr, sizeof(*trigger_tab));
>  out:
> -	if (trigger_tab)
> -		iounmap(trigger_tab);
> +	if (p)
> +		iounmap(p);
>  
>  	return rc;
>  }
> @@ -860,7 +869,7 @@ static void __exit einj_remove(struct platform_device *pdev)
>  			sizeof(struct set_error_type_with_address) :
>  			sizeof(struct einj_parameter);
>  
> -		acpi_os_unmap_iomem(einj_param, size);
> +		acpi_os_unmap_iomem((void __iomem *)einj_param, size);
>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}


