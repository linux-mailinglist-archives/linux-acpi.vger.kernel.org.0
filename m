Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75FF42FF405
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbhAUTO3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:14:29 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2396 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbhAUTOG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:14:06 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMBmJ0NSQz67dSK;
        Fri, 22 Jan 2021 03:10:08 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 21 Jan 2021 20:13:18 +0100
Received: from localhost (10.47.68.198) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 21 Jan
 2021 19:13:17 +0000
Date:   Thu, 21 Jan 2021 19:12:36 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <robin.murphy@arm.com>, <eric.auger@redhat.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-accelerators@lists.ozlabs.org>, <baolu.lu@linux.intel.com>,
        <jacob.jun.pan@linux.intel.com>, <kevin.tian@intel.com>,
        <vdumpa@nvidia.com>, <zhangfei.gao@linaro.org>,
        <shameerali.kolothum.thodi@huawei.com>, <vivek.gautam@arm.com>
Subject: Re: [PATCH v10 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <20210121191236.00000103@Huawei.com>
In-Reply-To: <20210121123623.2060416-11-jean-philippe@linaro.org>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
        <20210121123623.2060416-11-jean-philippe@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.68.198]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 21 Jan 2021 13:36:24 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

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
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

One thing inline + one comment which was mostly a case of I ran
out of time to walk through why probe and release aren't symmetric...

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  43 ++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 185 +++++++++++++++++-
>  3 files changed, 273 insertions(+), 14 deletions(-)
> 

...



> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index db5d6aa76c3a..af6982aca42e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -32,6 +32,7 @@


...
>  
>  	master->domain = smmu_domain;
> @@ -2484,6 +2624,11 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  		master->ssid_bits = min_t(u8, master->ssid_bits,
>  					  CTXDESC_LINEAR_CDMAX);
>  
> +	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
> +	     device_property_read_bool(dev, "dma-can-stall")) ||
> +	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
> +		master->stall_enabled = true;
> +
>  	return &smmu->iommu;
>  
>  err_free_master:
> @@ -2502,6 +2647,7 @@ static void arm_smmu_release_device(struct device *dev)
>  
>  	master = dev_iommu_priv_get(dev);
>  	WARN_ON(arm_smmu_master_sva_enabled(master));
> +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
>  	arm_smmu_detach_dev(master);
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);

The lack of symmetry here bothers me a bit, but it's already true, so I guess
this case is fine as well.

...
>  
> @@ -2785,6 +2946,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
>  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  {
>  	int ret;
> +	bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;

FEAT_SVA?

>  
>  	/* cmdq */
>  	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> @@ -2804,6 +2966,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
>  	if (ret)
>  		return ret;
>  
> +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {

Isn't this checking same thing twice?

> +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> +		if (!smmu->evtq.iopf)
> +			return -ENOMEM;
> +	}
> +
>  	/* priq */
>  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
>  		return 0;
> @@ -3718,6 +3886,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
>  	iommu_device_unregister(&smmu->iommu);
>  	iommu_device_sysfs_remove(&smmu->iommu);
>  	arm_smmu_device_disable(smmu);
> +	iopf_queue_free(smmu->evtq.iopf);
>  
>  	return 0;
>  }

