Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769F03CB817
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Jul 2021 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhGPNzm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Jul 2021 09:55:42 -0400
Received: from foss.arm.com ([217.140.110.172]:39198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhGPNzl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Jul 2021 09:55:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C26D6E;
        Fri, 16 Jul 2021 06:52:46 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1C043F774;
        Fri, 16 Jul 2021 06:52:44 -0700 (PDT)
Subject: Re: [PATCH v6 8/9] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210716083442.1708-1-shameerali.kolothum.thodi@huawei.com>
 <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b73d3408-7b2e-4cab-3b8c-efc22d08d99e@arm.com>
Date:   Fri, 16 Jul 2021 14:52:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716083442.1708-9-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 16/07/2021 09:34, Shameer Kolothum wrote:
> From: Jon Nettleton <jon@solid-run.com>
> 
> Check if there is any RMR info associated with the devices behind
> the SMMU and if any, install bypass SMRs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMU during probe().
> 
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c | 48 +++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index f22dbeb1e510..e9fb3d962a86 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2063,6 +2063,50 @@ err_reset_platform_ops: __maybe_unused;
>  	return err;
>  }
>  
> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> +{
> +	struct list_head rmr_list;
> +	struct iommu_resv_region *e;
> +	int i, cnt = 0;
> +	u32 reg;
> +
> +	INIT_LIST_HEAD(&rmr_list);
> +	if (iommu_dma_get_rmrs(dev_fwnode(smmu->dev), &rmr_list))
> +		return;
> +
> +	/*
> +	 * Rather than trying to look at existing mappings that
> +	 * are setup by the firmware and then invalidate the ones
> +	 * that do no have matching RMR entries, just disable the
> +	 * SMMU until it gets enabled again in the reset routine.
> +	 */
> +	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);
> +	reg &= ~ARM_SMMU_sCR0_CLIENTPD;

This looks backwards, the spec states:

  Client Port Disable. The possible values of this bit are:
  0 - Each SMMU client access is subject to SMMU translation, access
      control, and attribute generation.
  1 - Each SMMU client access bypasses SMMU translation, access control,
      and attribute generation.
  This bit resets to 1.

And indeed with the current code if sCR0_USFCFG was set when
sCR0_CLIENTPD is cleared then I get a blank screen until the smmu is reset.

So I believe this should be ORing in the value, i.e.

  reg |= ARM_SMMU_sCR0_CLIENTPD;

And in my testing that works fine even if sCR0_USFCFG is set.

Steve

> +	arm_smmu_gr0_write(smmu, ARM_SMMU_GR0_sCR0, reg);
> +
> +	list_for_each_entry(e, &rmr_list, list) {
> +		u32 sid = e->fw_data.rmr.sid;
> +
> +		i = arm_smmu_find_sme(smmu, sid, ~0);
> +		if (i < 0)
> +			continue;
> +		if (smmu->s2crs[i].count == 0) {
> +			smmu->smrs[i].id = sid;
> +			smmu->smrs[i].mask = 0;
> +			smmu->smrs[i].valid = true;
> +		}
> +		smmu->s2crs[i].count++;
> +		smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +		smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +
> +		cnt++;
> +	}
> +
> +	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
> +		   cnt == 1 ? "" : "s");
> +	iommu_dma_put_rmrs(dev_fwnode(smmu->dev), &rmr_list);
> +}
> +
>  static int arm_smmu_device_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
> @@ -2189,6 +2233,10 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  
>  	platform_set_drvdata(pdev, smmu);
> +
> +	/* Check for RMRs and install bypass SMRs if any */
> +	arm_smmu_rmr_install_bypass_smr(smmu);
> +
>  	arm_smmu_device_reset(smmu);
>  	arm_smmu_test_smr_masks(smmu);
>  
> 

