Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF42FFEBD
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 09:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbhAVIxh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 03:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbhAVIwW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 03:52:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C2CC0613D6
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 00:51:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id s24so6297695wmj.0
        for <linux-acpi@vger.kernel.org>; Fri, 22 Jan 2021 00:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrASp/RtgpnkhA58OvyJAdDc1T+gTz0RiPx6wduZk8c=;
        b=up1a2h2iDNc3JdPf9XWIf2bOEaBA5o+PTzwpwYGlMWM3ZPj/bERowdcDTXhk7MzMw/
         0IFYO6oW0pkXjX1cb3hU7fdkG5CpEdf5p2OrQuENFNur3mXO1UNPNNoA78V26IXInBoj
         TajCQT15iimZzsSU1SJAar/pCn1bCAmu7IeSTP9dwglQQsZGde0nTViozhqrE/WuU4wa
         gbsoMIH3ZTkUTJskvTs16R6tGViSYH17JSudaIueKcawYY5Tbj2U9x+w96OIJ1XQBqcy
         tHESxQyCoAjop66UARHym1LLJEipIIbc8xAb1bYp5sSgO+3CD+f4WOOCCsBpjXXfzNH9
         O73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrASp/RtgpnkhA58OvyJAdDc1T+gTz0RiPx6wduZk8c=;
        b=lBa/fci8pmqEATfytvqBGEQPLN/KKOv7zVsC3OlEK3cnkS+XVpgPHSDlUru9E1oyrM
         V4HNP4b53bIGpVMK3tZ3VactD7pKYbIYRSHE/g2n2C/KxVUO2snCk36w5KPF0GD16wpH
         co5pK6AKh5bskvxhCUOvHAjIED50MS3wdvWGYlz/1D9TSI3vFIx3/cJzReEJ3FyN4vFN
         QFiXuJDhKpcbQeQDD6Vf3xWgCYUCwtoAjgK/0K1NU+IhPkOuWLKdC9UeCysFNQB5VpPa
         dFlK8QzvM8V2kZbw/e7kCquzBLhCuHFzcYG9uPKKXMlIxZl8bCJx+d4gvpBd5mfw4S4e
         ie/A==
X-Gm-Message-State: AOAM530XiaJnegMtGfmY95cRxYJKk5Cc1T8FwPaQBn04cdcoK9bfyT0r
        qn6yL82NO2kHsKcRwLpfeGSHzQ==
X-Google-Smtp-Source: ABdhPJwPXJQhdUZQz8TZ2CsHYCjCHXTUgo1cueUoveXyLgzD7Ys+eUwGva42rD/7MMLN1jYZ/pNjIQ==
X-Received: by 2002:a1c:1d12:: with SMTP id d18mr2803870wmd.121.1611305500497;
        Fri, 22 Jan 2021 00:51:40 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id l5sm11088232wrv.44.2021.01.22.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 00:51:39 -0800 (PST)
Date:   Fri, 22 Jan 2021 09:51:20 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com
Subject: Re: [PATCH v10 10/10] iommu/arm-smmu-v3: Add stall support for
 platform devices
Message-ID: <YAqSCKeN2o+GsISZ@myrica>
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
 <20210121123623.2060416-11-jean-philippe@linaro.org>
 <20210121191236.00000103@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121191236.00000103@Huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 07:12:36PM +0000, Jonathan Cameron wrote:
> > @@ -2502,6 +2647,7 @@ static void arm_smmu_release_device(struct device *dev)
> >  
> >  	master = dev_iommu_priv_get(dev);
> >  	WARN_ON(arm_smmu_master_sva_enabled(master));
> > +	iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
> >  	arm_smmu_detach_dev(master);
> >  	arm_smmu_disable_pasid(master);
> >  	arm_smmu_remove_master(master);
> 
> The lack of symmetry here bothers me a bit, but it's already true, so I guess
> this case is fine as well.

Normally the device driver calls iommu_dev_feat_disable(SVA) which does
iopf_queue_remove_device(). This is just a safety net in case the device
gets removed without the driver properly cleaning up (which will WARN as
well) 

> 
> ...
> >  
> > @@ -2785,6 +2946,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
> >  static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >  {
> >  	int ret;
> > +	bool sva = smmu->features & ARM_SMMU_FEAT_STALLS;
> 
> FEAT_SVA?

Ugh yes, thanks. I left this as a bool instead of moving into the test
below because the PRI patch reuses it, but I think I'll just move it down
when resending.

Thanks,
Jean

> 
> >  
> >  	/* cmdq */
> >  	ret = arm_smmu_init_one_queue(smmu, &smmu->cmdq.q, ARM_SMMU_CMDQ_PROD,
> > @@ -2804,6 +2966,12 @@ static int arm_smmu_init_queues(struct arm_smmu_device *smmu)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (sva && smmu->features & ARM_SMMU_FEAT_STALLS) {
> 
> Isn't this checking same thing twice?
> 
> > +		smmu->evtq.iopf = iopf_queue_alloc(dev_name(smmu->dev));
> > +		if (!smmu->evtq.iopf)
> > +			return -ENOMEM;
> > +	}
> > +
> >  	/* priq */
> >  	if (!(smmu->features & ARM_SMMU_FEAT_PRI))
> >  		return 0;
> > @@ -3718,6 +3886,7 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
> >  	iommu_device_unregister(&smmu->iommu);
> >  	iommu_device_sysfs_remove(&smmu->iommu);
> >  	arm_smmu_device_disable(smmu);
> > +	iopf_queue_free(smmu->evtq.iopf);
> >  
> >  	return 0;
> >  }
> 
