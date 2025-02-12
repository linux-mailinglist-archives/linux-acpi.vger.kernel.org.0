Return-Path: <linux-acpi+bounces-11120-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A14CAA32BE3
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 17:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68944169A76
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 16:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E91257AC4;
	Wed, 12 Feb 2025 16:36:03 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848EA25743C;
	Wed, 12 Feb 2025 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378163; cv=none; b=R4rAheX3Dwp6xf+uFWO3+0MWV4NtF2DKHEcdFC2fLnDLXR0MsCc4LLGyAuWOs22/5BWTSHGZnHHx8Zh6jP3U2iYObql5vHCK6Egwi9sU9gxF8SJrQo/mYc+84K22jwIxjA+c198QaPkLzHp++O/b75xNiE21y2rfRPWNSdMXbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378163; c=relaxed/simple;
	bh=ZMAg6hrHch02TEW9KwhVyvGvyK/uaAv+0dyBhqCFIhY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6/91/oZBWAIvkwgfQF2ALZW5awwxWrWnXk+p+e9cpdIPTpN0RMOKcpUSDu8cyJsXYN6DQ4/RvmfWPc6GAol75B3fiP7uENsZWGcMAGV0TA4j1HihTAirG87GJGKORRfm4mMSvo9nkzo8lC/sCdvlRKjF9dNSgE8NQnSOMxqDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtP57467Jz6H8Ct;
	Thu, 13 Feb 2025 00:33:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 185C3140390;
	Thu, 13 Feb 2025 00:35:57 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 17:35:56 +0100
Date: Wed, 12 Feb 2025 16:35:55 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zaid Alali <zaidal@os.amperecomputing.com>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
	<tony.luck@intel.com>, <bp@alien8.de>, <robert.moore@intel.com>,
	<dan.j.williams@intel.com>, <Benjamin.Cheatham@amd.com>,
	<Avadhut.Naik@amd.com>, <viro@zeniv.linux.org.uk>, <arnd@arndb.de>,
	<ira.weiny@intel.com>, <dave.jiang@intel.com>,
	<sthanneeru.opensrc@micron.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <acpica-devel@lists.linux.dev>
Subject: Re: [PATCH v3 3/9] ACPI: APEI: EINJ: Fix kernel test robot sparse
 warning
Message-ID: <20250212163555.000025ca@huawei.com>
In-Reply-To: <20250210183705.1114624-4-zaidal@os.amperecomputing.com>
References: <20250210183705.1114624-1-zaidal@os.amperecomputing.com>
	<20250210183705.1114624-4-zaidal@os.amperecomputing.com>
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

On Mon, 10 Feb 2025 10:36:59 -0800
Zaid Alali <zaidal@os.amperecomputing.com> wrote:

> This patch fixes the kernel test robot warning reported here:
> https://lore.kernel.org/all/202410241620.oApALow5-lkp@intel.com/
> 
> Signed-off-by: Zaid Alali <zaidal@os.amperecomputing.com>

Hi Zaid,

Why in the read direction use structures on the stack, but in the
write direction kmalloc them? I think they could all just be 
stack variables as they are all pretty small.

Jonathan

>  }
> @@ -444,8 +453,10 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  		return rc;
>  	apei_exec_ctx_set_input(&ctx, type);
>  	if (acpi5) {
> -		struct set_error_type_with_address *v5param = einj_param;
> +		struct set_error_type_with_address *v5param;
>  
> +		v5param = kmalloc(sizeof(*v5param), GFP_KERNEL);
As below. Not sure why you can't just use the stack for this.
It's not very big.

> +		memcpy_fromio(v5param, einj_param, sizeof(*v5param));
>  		v5param->type = type;
>  		if (type & ACPI5_VENDOR_BIT) {
>  			switch (vendor_flags) {
> @@ -490,15 +501,21 @@ static int __einj_error_inject(u32 type, u32 flags, u64 param1, u64 param2,
>  				break;
>  			}
>  		}
> +		memcpy_toio(einj_param, v5param, sizeof(*v5param));
> +		kfree(v5param);
>  	} else {
>  		rc = apei_exec_run(&ctx, ACPI_EINJ_SET_ERROR_TYPE);
>  		if (rc)
>  			return rc;
>  		if (einj_param) {
> -			struct einj_parameter *v4param = einj_param;
> +			struct einj_parameter *v4param;

Why kmalloc rather than on stack as you did for the reads?

>  
> +			v4param = kmalloc(sizeof(*v4param), GFP_KERNEL);
> +			memcpy_fromio(v4param, einj_param, sizeof(*v4param));
>  			v4param->param1 = param1;
>  			v4param->param2 = param2;
> +			memcpy_toio(einj_param, v4param, sizeof(*v4param));
> +			kfree(v4param);
>  		}
>  	}
>  	rc = apei_exec_run(&ctx, ACPI_EINJ_EXECUTE_OPERATION);


