Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6F300220
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 12:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbhAVLz5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 06:55:57 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2399 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728020AbhAVK76 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 05:59:58 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DMbkY5sG2z67dSX;
        Fri, 22 Jan 2021 18:55:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 22 Jan 2021 11:59:15 +0100
Received: from localhost (10.47.73.222) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 22 Jan
 2021 10:59:13 +0000
Date:   Fri, 22 Jan 2021 10:58:32 +0000
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
Message-ID: <20210122105832.00002dcb@Huawei.com>
In-Reply-To: <YAqSCKeN2o+GsISZ@myrica>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
        <20210121123623.2060416-11-jean-philippe@linaro.org>
        <20210121191236.00000103@Huawei.com>
        <YAqSCKeN2o+GsISZ@myrica>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.222]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 22 Jan 2021 09:51:20 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Thu, Jan 21, 2021 at 07:12:36PM +0000, Jonathan Cameron wrote:
> > > @@ -2502,6 +2647,7 @@ static void arm_smmu_release_device(struct device *dev)
> > >  
> > >  	master = dev_iommu_priv_get(dev);
> > >  	WARN_ON(arm_smmu_master_sva_enabled(master));
> > > +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> > >  	arm_smmu_detach_dev(master);
> > >  	arm_smmu_disable_pasid(master);
> > >  	arm_smmu_remove_master(master);  
> > 
> > The lack of symmetry here bothers me a bit, but it's already true, so I guess
> > this case is fine as well.  
> 
> Normally the device driver calls iommu_dev_feat_disable(SVA) which does
> iopf_queue_remove_device(). This is just a safety net in case the device
> gets removed without the driver properly cleaning up (which will WARN as
> well) 

Ah makes sense.  Maybe it's worth a comment in the code for future generations
of tired code readers?

> 
> > 
> > ...  
> > >  
> > > @@ -2785,6 +2946,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
> > >  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> > >  {
> > >  	int ret;
> > > +	bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;  
> > 
> > FEAT_SVA?  
> 
> Ugh yes, thanks. I left this as a bool instead of moving into the test
> below because the PRI patch reuses it, but I think I'll just move it down
> when resending.

Makes sense.

> 
> Thanks,
> Jean
> 
> >   
> > >  
> > >  	/* cmdq */
> > >  	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> > > @@ -2804,6 +2966,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> > >  	if (ret)
> > >  		return ret;
> > >  
> > > +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {  
> > 
> > Isn't this checking same thing twice?
> >   
> > > +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> > > +		if (!smmu->evtq.iopf)
> > > +			return -ENOMEM;
> > > +	}
> > > +
> > >  	/* priq */
> > >  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
> > >  		return 0;
> > > @@ -3718,6 +3886,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> > >  	iommu_device_unregister(&smmu->iommu);
> > >  	iommu_device_sysfs_remove(&smmu->iommu);
> > >  	arm_smmu_device_disable(smmu);
> > > +	iopf_queue_free(smmu->evtq.iopf);
> > >  
> > >  	return 0;
> > >  }  
> >   

