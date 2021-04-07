Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2815535674C
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 10:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349764AbhDGIzp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 04:55:45 -0400
Received: from 8bytes.org ([81.169.241.247]:33758 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345831AbhDGIzT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Apr 2021 04:55:19 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 2BDC52A6; Wed,  7 Apr 2021 10:55:09 +0200 (CEST)
Date:   Wed, 7 Apr 2021 10:55:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     will@kernel.org, lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, baolu.lu@linux.intel.com,
        jacob.jun.pan@linux.intel.com, kevin.tian@intel.com,
        vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com
Subject: Re: [PATCH v14 00/10] iommu: I/O page faults for SMMUv3
Message-ID: <YG1za3CYd/Y2JAB3@8bytes.org>
References: <20210401154718.307519-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401154718.307519-1-jean-philippe@linaro.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Apr 01, 2021 at 05:47:09PM +0200, Jean-Philippe Brucker wrote:
> Jean-Philippe Brucker (10):
>   iommu: Fix comment for struct iommu_fwspec
>   iommu/arm-smmu-v3: Use device properties for pasid-num-bits
>   iommu: Separate IOMMU_DEV_FEAT_IOPF from IOMMU_DEV_FEAT_SVA
>   iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
>   uacce: Enable IOMMU_DEV_FEAT_IOPF
>   iommu: Add a page fault handler
>   iommu/arm-smmu-v3: Maintain a SID->device structure

Applied the first 7 patches, thanks.
