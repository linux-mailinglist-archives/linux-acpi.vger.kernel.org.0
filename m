Return-Path: <linux-acpi+bounces-12177-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 323D8A5EFFE
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 10:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58EFC17D515
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 09:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F4263C8E;
	Thu, 13 Mar 2025 09:56:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DEB1C1F0C;
	Thu, 13 Mar 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859771; cv=none; b=QmIkgOUXiTIg3ox8wNRbWHiok4+cALERu7r5CeRC0ywKCPiIxkXDnPKObrAXWJa4Q9k3g1MKY49ZmnQ2kCYQ9NteTfXAv1KU+paWKCEhMTnD0aZKljK/QrIQv9jNtQLkg3lmncqRjYXpWEhJo47yFhDnoR+/6gvx9ga3CMjLeBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859771; c=relaxed/simple;
	bh=8S9vrq166jilX+o1O51fu4DeDsRpbJT1z2ZmakIqa1E=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrD6jS5NgcOJ9x4b+dzvDmBz77HvCe6axtokA5IhisQXI0EUA70q8L93M1o3yDHxkI8yPiRHbAAaa3uC5CRkzLTZsOM3HzQClU7ZqR9Z6pNMi/XTN6j8C8qwDPp6Dt8pec1CAiMpPPLU/2LQzXcibJ8ITR2Dvhb6zYUhyvfpPB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZD2qY1djfz6H8fW;
	Thu, 13 Mar 2025 17:52:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C1B061400CA;
	Thu, 13 Mar 2025 17:56:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Mar
 2025 10:56:05 +0100
Date: Thu, 13 Mar 2025 09:56:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v4 8/9] ACPI: APEI: EINJ: Enable EINJv2 error injections
Message-ID: <20250313095604.00001ccf@huawei.com>
In-Reply-To: <20250306234810.75511-9-zaidal@os.amperecomputing.com>
References: <20250306234810.75511-1-zaidal@os.amperecomputing.com>
	<20250306234810.75511-9-zaidal@os.amperecomputing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu,  6 Mar 2025 15:48:09 -0800
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
>  drivers/acpi/apei/einj-core.c | 101 ++++++++++++++++++++++++++++++----
>  1 file changed, 90 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
> index 4c748fa0a479..1aea84958b00 100644
> --- a/drivers/acpi/apei/einj-core.c
> +++ b/drivers/acpi/apei/einj-core.c

>  static void einj_exec_ctx_init(struct apei_exec_context *ctx)
>  {
> @@ -288,11 +298,24 @@ static void *einj_get_parameter_address(void)
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
>  			acpi5 = 1;
>  			check_vendor_extension(pa_v5, &v5param);
> +			if (available_error_type & ACPI65_EINJV2_SUPP) {
> +				len = v5param.einjv2_struct.length;
> +				offset = offsetof(struct einjv2_extension_struct, component_arr);
> +				nr_components = (len - offset) / 32;

Can we use sizeof() anything for that 32?

> +				acpi_os_unmap_iomem(p, v5param_size);
I wonder if a comment or two would be useful here to explain why we need to expand the mapping.

> +				offset = offsetof(struct set_error_type_with_address, einjv2_struct);
> +				v5param_size = offset + struct_size(&v5param.einjv2_struct,
> +					component_arr, nr_components);
> +				p = acpi_os_map_iomem(pa_v5, v5param_size);
> +			}
>  			return p;
>  		}
>  	}

...


> @@ -945,10 +1023,11 @@ static void __exit einj_remove(struct platform_device *pdev)
>  
>  	if (einj_param) {
>  		acpi_size size = (acpi5) ?
> -			sizeof(struct set_error_type_with_address) :
> +			v5param_size :
>  			sizeof(struct einj_parameter);
>  
>  		acpi_os_unmap_iomem(einj_param, size);
> +
Unrelated change that shouldn't be in this patch.


>  		if (vendor_errors.size)
>  			acpi_os_unmap_memory(vendor_errors.data, vendor_errors.size);
>  	}


