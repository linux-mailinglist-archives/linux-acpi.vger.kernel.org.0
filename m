Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0914FF783A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Nov 2019 16:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKKP6s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Nov 2019 10:58:48 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5765 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726902AbfKKP6s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Nov 2019 10:58:48 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A07C8F3FE9416791CFD4;
        Mon, 11 Nov 2019 23:58:46 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 11 Nov 2019
 23:58:39 +0800
Date:   Mon, 11 Nov 2019 15:58:30 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lorenzo.pieralisi@arm.com>, <guohanjun@huawei.com>,
        <sudeep.holla@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <will@kernel.org>, <robin.murphy@arm.com>,
        <zhangfei.gao@linaro.org>, <eric.auger@redhat.com>
Subject: Re: [PATCH v2 7/8] iommu/arm-smmu-v3: Improve add_device() error
 handling
Message-ID: <20191111155830.00000a56@huawei.com>
In-Reply-To: <20191108152508.4039168-8-jean-philippe@linaro.org>
References: <20191108152508.4039168-1-jean-philippe@linaro.org>
        <20191108152508.4039168-8-jean-philippe@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 8 Nov 2019 16:25:07 +0100
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> Let add_device() clean up after itself. The iommu_bus_init() function
> does call remove_device() on error, but other sites (e.g. of_iommu) do
> not.
> 
> Don't free level-2 stream tables because we'd have to track if we
> allocated each of them or if they are used by other endpoints. It's not
> worth the hassle since they are managed resources.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Potentially some fun around reordering of last few actions, but
doesn't seem there is any real connection between them so should be
fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/iommu/arm-smmu-v3.c | 28 +++++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index 82eac89ee187..88ec0bf33492 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2826,14 +2826,16 @@ static int arm_smmu_add_device(struct device *dev)
>  	for (i = 0; i < master->num_sids; i++) {
>  		u32 sid = master->sids[i];
>  
> -		if (!arm_smmu_sid_in_range(smmu, sid))
> -			return -ERANGE;
> +		if (!arm_smmu_sid_in_range(smmu, sid)) {
> +			ret = -ERANGE;
> +			goto err_free_master;
> +		}
>  
>  		/* Ensure l2 strtab is initialised */
>  		if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB) {
>  			ret = arm_smmu_init_l2_strtab(smmu, sid);
>  			if (ret)
> -				return ret;
> +				goto err_free_master;
>  		}
>  	}
>  
> @@ -2843,13 +2845,25 @@ static int arm_smmu_add_device(struct device *dev)
>  		master->ssid_bits = min_t(u8, master->ssid_bits,
>  					  CTXDESC_LINEAR_CDMAX);
>  
> +	ret = iommu_device_link(&smmu->iommu, dev);
> +	if (ret)
> +		goto err_free_master;
> +
>  	group = iommu_group_get_for_dev(dev);
> -	if (!IS_ERR(group)) {
> -		iommu_group_put(group);
> -		iommu_device_link(&smmu->iommu, dev);
> +	if (IS_ERR(group)) {
> +		ret = PTR_ERR(group);
> +		goto err_unlink;
>  	}
>  
> -	return PTR_ERR_OR_ZERO(group);
> +	iommu_group_put(group);
> +	return 0;
> +
> +err_unlink:
> +	iommu_device_unlink(&smmu->iommu, dev);
> +err_free_master:
> +	kfree(master);
> +	fwspec->iommu_priv = NULL;
> +	return ret;
>  }
>  
>  static void arm_smmu_remove_device(struct device *dev)


