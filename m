Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00A32C423
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 01:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbhCDALb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Mar 2021 19:11:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:30805 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244025AbhCCFSJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Mar 2021 00:18:09 -0500
IronPort-SDR: ma1Gl7BUMMUEkrdqYVlkPwc0O5va+3NllXxaxvuXJN7HSqKuhhEyG3p57wA/rvJvMLyRdlCMSh
 TwlEy3AWTxPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="206782342"
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="206782342"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 21:13:56 -0800
IronPort-SDR: W4v/nO9ltO4kt5+ahN8iBfKrHoekmqH21ZUT4l4BpgOpWZHofqqsHfhMkMGB1cDomKF9wWzHRs
 SGA9xegTO8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,219,1610438400"; 
   d="scan'208";a="428037288"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Mar 2021 21:13:48 -0800
Cc:     baolu.lu@linux.intel.com, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, jacob.jun.pan@linux.intel.com,
        kevin.tian@intel.com, vdumpa@nvidia.com, zhangfei.gao@linaro.org,
        shameerali.kolothum.thodi@huawei.com, vivek.gautam@arm.com,
        zhukeqian1@huawei.com, wangzhou1@hisilicon.com,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v13 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
References: <20210302092644.2553014-1-jean-philippe@linaro.org>
 <20210302092644.2553014-4-jean-philippe@linaro.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <93b369dc-2145-bebb-b20c-90018bcc69c3@linux.intel.com>
Date:   Wed, 3 Mar 2021 13:04:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210302092644.2553014-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 3/2/21 5:26 PM, Jean-Philippe Brucker wrote:
> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> mandating IOMMU-managed IOPF. The other device drivers now need to first
> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA. Enabling
> IOMMU_DEV_FEAT_IOPF on its own doesn't have any effect visible to the
> device driver, it is used in combination with other features.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>   include/linux/iommu.h | 20 +++++++++++++++++---
>   1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 16ce75693d83..45c4eb372f56 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -156,10 +156,24 @@ struct iommu_resv_region {
>   	enum iommu_resv_type	type;
>   };
>   
> -/* Per device IOMMU features */
> +/**
> + * enum iommu_dev_features - Per device IOMMU features
> + * @IOMMU_DEV_FEAT_AUX: Auxiliary domain feature
> + * @IOMMU_DEV_FEAT_SVA: Shared Virtual Addresses
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally
> + *			 enabling %IOMMU_DEV_FEAT_SVA requires
> + *			 %IOMMU_DEV_FEAT_IOPF, but some devices manage I/O Page
> + *			 Faults themselves instead of relying on the IOMMU. When
> + *			 supported, this feature must be enabled before and
> + *			 disabled after %IOMMU_DEV_FEAT_SVA.
> + *
> + * Device drivers query whether a feature is supported using
> + * iommu_dev_has_feature(), and enable it using iommu_dev_enable_feature().
> + */
>   enum iommu_dev_features {
> -	IOMMU_DEV_FEAT_AUX,	/* Aux-domain feature */
> -	IOMMU_DEV_FEAT_SVA,	/* Shared Virtual Addresses */
> +	IOMMU_DEV_FEAT_AUX,
> +	IOMMU_DEV_FEAT_SVA,
> +	IOMMU_DEV_FEAT_IOPF,
>   };
>   
>   #define IOMMU_PASID_INVALID	(-1U)
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
