Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A8D2FFA47
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 03:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbhAVCEV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 21:04:21 -0500
Received: from mga18.intel.com ([134.134.136.126]:59189 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbhAVCEQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 21:04:16 -0500
IronPort-SDR: 99dEDPAi4MSJtr5wjwt9uUZGOCSNIENSQBNG7A9g3l5x5yU/h2P9NLBCWsD7vS5lTHCJIRij5g
 +Ts3P8ABF43Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="167055292"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="167055292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 18:02:25 -0800
IronPort-SDR: Xbl5c/D865xh6OlMgMyL0U1IZOcNA6WvEvPrOI/eUbFuSdvCK6xN46A2PhCPSr8KiBbjTQoRZM
 DDbMHc3lOXNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="467684968"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 18:02:16 -0800
Cc:     baolu.lu@linux.intel.com, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v10 04/10] iommu/vt-d: Support IOMMU_DEV_FEAT_IOPF
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
References: <20210121123623.2060416-1-jean-philippe@linaro.org>
 <20210121123623.2060416-5-jean-philippe@linaro.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <d834784c-2d96-a4be-8d9b-3a5d3939325d@linux.intel.com>
Date:   Fri, 22 Jan 2021 09:54:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210121123623.2060416-5-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 1/21/21 8:36 PM, Jean-Philippe Brucker wrote:
> Allow drivers to query and enable IOMMU_DEV_FEAT_IOPF, which amounts to
> checking whether PRI is enabled.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index f665322a0991..c777bd94df5d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -5330,6 +5330,8 @@ static int siov_find_pci_dvsec(struct pci_dev *pdev)
>   static bool
>   intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>   {
> +	struct device_domain_info *info = get_domain_info(dev);
> +
>   	if (feat == IOMMU_DEV_FEAT_AUX) {
>   		int ret;
>   
> @@ -5344,13 +5346,13 @@ intel_iommu_dev_has_feat(struct device *dev, enum iommu_dev_features feat)
>   		return !!siov_find_pci_dvsec(to_pci_dev(dev));
>   	}
>   
> -	if (feat == IOMMU_DEV_FEAT_SVA) {
> -		struct device_domain_info *info = get_domain_info(dev);
> +	if (feat == IOMMU_DEV_FEAT_IOPF)
> +		return info && info->pri_supported;
>   
> +	if (feat == IOMMU_DEV_FEAT_SVA)
>   		return info && (info->iommu->flags & VTD_FLAG_SVM_CAPABLE) &&
>   			info->pasid_supported && info->pri_supported &&
>   			info->ats_supported;
> -	}
>   
>   	return false;
>   }
> @@ -5361,6 +5363,9 @@ intel_iommu_dev_enable_feat(struct device *dev, enum iommu_dev_features feat)
>   	if (feat == IOMMU_DEV_FEAT_AUX)
>   		return intel_iommu_enable_auxd(dev);
>   
> +	if (feat == IOMMU_DEV_FEAT_IOPF)
> +		return intel_iommu_dev_has_feat(dev, feat) ? 0 : -ENODEV;
> +
>   	if (feat == IOMMU_DEV_FEAT_SVA) {
>   		struct device_domain_info *info = get_domain_info(dev);
>   
> 
