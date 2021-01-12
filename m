Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC3B2F2738
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 05:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbhALElU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 23:41:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:38784 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbhALElU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 23:41:20 -0500
IronPort-SDR: xEr0/NDN2P6P/Jqp6yRqn7i1dXVf4iz19IFmNU4IQRmYqrcZ/qq3t9A6lXr9ZtHU2TSeOtUZwV
 C94qQbfGvHyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="165064784"
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="165064784"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 20:39:32 -0800
IronPort-SDR: rbtMIpU1AlGux/ENy6x92Hb2JJ7I19FCOibsAEwW3txKgPQT94r1a/Nk8Rt2IbZtTfttbufyMg
 6wmw9cE1hnAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,340,1602572400"; 
   d="scan'208";a="464389805"
Received: from allen-box.sh.intel.com (HELO [10.239.159.28]) ([10.239.159.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jan 2021 20:39:27 -0800
Cc:     baolu.lu@linux.intel.com, lorenzo.pieralisi@arm.com,
        robh+dt@kernel.org, guohanjun@huawei.com, sudeep.holla@arm.com,
        rjw@rjwysocki.net, lenb@kernel.org, robin.murphy@arm.com,
        Jonathan.Cameron@huawei.com, eric.auger@redhat.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-accelerators@lists.ozlabs.org, vdumpa@nvidia.com,
        zhangfei.gao@linaro.org, shameerali.kolothum.thodi@huawei.com,
        vivek.gautam@arm.com, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v9 03/10] iommu: Separate IOMMU_DEV_FEAT_IOPF from
 IOMMU_DEV_FEAT_SVA
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
        will@kernel.org
References: <20210108145217.2254447-1-jean-philippe@linaro.org>
 <20210108145217.2254447-4-jean-philippe@linaro.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4de8ef03-a2ed-316e-d3e3-6b8474e20113@linux.intel.com>
Date:   Tue, 12 Jan 2021 12:31:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108145217.2254447-4-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jean,

On 1/8/21 10:52 PM, Jean-Philippe Brucker wrote:
> Some devices manage I/O Page Faults (IOPF) themselves instead of relying
> on PCIe PRI or Arm SMMU stall. Allow their drivers to enable SVA without
> mandating IOMMU-managed IOPF. The other device drivers now need to first
> enable IOMMU_DEV_FEAT_IOPF before enabling IOMMU_DEV_FEAT_SVA.
> 
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
> index 583c734b2e87..701b2eeb0dc5 100644
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
> + * @IOMMU_DEV_FEAT_IOPF: I/O Page Faults such as PRI or Stall. Generally using
> + *			 %IOMMU_DEV_FEAT_SVA requires %IOMMU_DEV_FEAT_IOPF, but
> + *			 some devices manage I/O Page Faults themselves instead
> + *			 of relying on the IOMMU. When supported, this feature
> + *			 must be enabled before and disabled after
> + *			 %IOMMU_DEV_FEAT_SVA.

Is this only for SVA? We may see more scenarios of using IOPF. For
example, when passing through devices to user level, the user's pages
could be managed dynamically instead of being allocated and pinned
statically.

If @IOMMU_DEV_FEAT_IOPF is defined as generic iopf support, the current
vendor IOMMU driver support may not enough.

Best regards,
baolu

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
