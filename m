Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89567309FF2
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 02:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbhBABV1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 31 Jan 2021 20:21:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12370 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhBABTr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 31 Jan 2021 20:19:47 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DTVRt2HX5z7dlT;
        Mon,  1 Feb 2021 09:17:46 +0800 (CST)
Received: from [127.0.0.1] (10.40.188.87) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Mon, 1 Feb 2021
 09:18:52 +0800
Subject: Re: [PATCH v12 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        <joro@8bytes.org>, <will@kernel.org>
References: <20210127154322.3959196-1-jean-philippe@linaro.org>
 <20210127154322.3959196-11-jean-philippe@linaro.org>
CC:     <vivek.gautam@arm.com>, <guohanjun@huawei.com>,
        <linux-acpi@vger.kernel.org>, <zhangfei.gao@linaro.org>,
        <lenb@kernel.org>, <devicetree@vger.kernel.org>,
        <kevin.tian@intel.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <rjw@rjwysocki.net>,
        <iommu@lists.linux-foundation.org>, <sudeep.holla@arm.com>,
        <robin.murphy@arm.com>, <linux-accelerators@lists.ozlabs.org>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <8adc79cc-7afb-dfe8-4f7b-07fa6dc5b905@hisilicon.com>
Date:   Mon, 1 Feb 2021 09:18:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210127154322.3959196-11-jean-philippe@linaro.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.188.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/1/27 23:43, Jean-Philippe Brucker wrote:
> The SMMU provides a Stall model for handling page faults in platform
> devices. It is similar to PCIe PRI, but doesn't require devices to have
> their own translation cache. Instead, faulting transactions are parked
> and the OS is given a chance to fix the page tables and retry the
> transaction.
> 
> Enable stall for devices that support it (opt-in by firmware). When an
> event corresponds to a translation error, call the IOMMU fault handler.
> If the fault is recoverable, it will call us back to terminate or
> continue the stall.
> 
> To use stall device drivers need to enable IOMMU_DEV_FEAT_IOPF, which
> initializes the fault queue for the device.
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  43 ++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 189 +++++++++++++++++-
>  3 files changed, 276 insertions(+), 15 deletions(-)
> 

[...]

> @@ -1033,8 +1076,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
>  			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
>  			CTXDESC_CD_0_V;
>  
> -		/* STALL_MODEL==0b10 && CD.S==0 is ILLEGAL */
> -		if (smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +		if (smmu_domain->stall_enabled)

Could we add ssid checking here? like: if (smmu_domain->stall_enabled && ssid).
The reason is if not CD.S will also be set when ssid is 0, which is not needed.

Best,
Zhou

>  			val |= CTXDESC_CD_0_S;
>  	}
>  
> @@ -1278,7 +1320,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>  			 FIELD_PREP(STRTAB_STE_1_STRW, strw));
>  
>  		if (smmu->features & ARM_SMMU_FEAT_STALLS &&
> -		   !(smmu->features & ARM_SMMU_FEAT_STALL_FORCE))
> +		    !master->stall_enabled)
>  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
>  
>  		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |

[...]

