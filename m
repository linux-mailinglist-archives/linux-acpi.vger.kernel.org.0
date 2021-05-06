Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E513737565D
	for <lists+linux-acpi@lfdr.de>; Thu,  6 May 2021 17:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhEFPSU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 May 2021 11:18:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234888AbhEFPST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 6 May 2021 11:18:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B63731B;
        Thu,  6 May 2021 08:17:18 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72573F718;
        Thu,  6 May 2021 08:17:16 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 09/10] iommu/arm-smmu: Get associated RMR info and
 install bypass SMR
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com
References: <20210420082751.1829-1-shameerali.kolothum.thodi@huawei.com>
 <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
Message-ID: <501cd986-7f9c-9aa7-b4e9-f2ef98fb7a95@arm.com>
Date:   Thu, 6 May 2021 16:17:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210420082751.1829-10-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 20/04/2021 09:27, Shameer Kolothum wrote:
> From: Jon Nettleton <jon@solid-run.com>
> 
> Check if there is any RMR info associated with the devices behind
> the SMMU and if any, install bypass SMRs for them. This is to
> keep any ongoing traffic associated with these devices alive
> when we enable/reset SMMU during probe().
> 
> Signed-off-by: Jon Nettleton <jon@solid-run.com>
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 42 +++++++++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h |  2 ++
>   2 files changed, 44 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index d8c6bfde6a61..4d2f91626d87 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -2102,6 +2102,43 @@ err_reset_platform_ops: __maybe_unused;
>   	return err;
>   }
>   
> +static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
> +{
> +	struct iommu_rmr *e;
> +	int i, cnt = 0;
> +	u32 smr;
> +
> +	for (i = 0; i < smmu->num_mapping_groups; i++) {
> +		smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
> +		if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
> +			continue;
> +
> +		list_for_each_entry(e, &smmu->rmr_list, list) {
> +			if (FIELD_GET(ARM_SMMU_SMR_ID, smr) != e->sid)
> +				continue;
> +
> +			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
> +			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
> +			smmu->smrs[i].valid = true;
> +
> +			smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
> +			smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
> +			smmu->s2crs[i].cbndx = 0xff;
> +
> +			cnt++;
> +		}
> +	}

If I understand this correctly - this is looking at the current
(hardware) configuration of the SMMU and attempting to preserve any
bypass SMRs. However from what I can tell it suffers from the following
two problems:

  (a) Only the ID of the SMR is being checked, not the MASK. So if the
firmware has setup an SMR matching a number of streams this will break.

  (b) The SMMU might not be enabled at all (CLIENTPD==1) or bypass
enabled for unmatched streams (USFCFG==0).

Certainly in my test setup case (b) applies and so this doesn't work.
Perhaps something like the below would work better? (It works in the
case of the SMMU not enabled - I've not tested case (a)).

Steve

----8<----
static void arm_smmu_rmr_install_bypass_smr(struct arm_smmu_device *smmu)
{
	struct iommu_rmr *e;
	int i, cnt = 0;
	u32 smr;
	u32 reg;

	reg = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_sCR0);

	if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
		/*
		 * SMMU is already enabled and disallowing bypass, so preserve
		 * the existing SMRs
		 */
		for (i = 0; i < smmu->num_mapping_groups; i++) {
			smr = arm_smmu_gr0_read(smmu, ARM_SMMU_GR0_SMR(i));
			if (!FIELD_GET(ARM_SMMU_SMR_VALID, smr))
				continue;
			smmu->smrs[i].id = FIELD_GET(ARM_SMMU_SMR_ID, smr);
			smmu->smrs[i].mask = FIELD_GET(ARM_SMMU_SMR_MASK, smr);
			smmu->smrs[i].valid = true;
		}
	}

	list_for_each_entry(e, &smmu->rmr_list, list) {
		u32 sid = e->sid;

		i = arm_smmu_find_sme(smmu, sid, ~0);
		if (i < 0)
			continue;
		if (smmu->s2crs[i].count == 0) {
			smmu->smrs[i].id = sid;
			smmu->smrs[i].mask = ~0;
			smmu->smrs[i].valid = true;
		}
		smmu->s2crs[i].count++;
		smmu->s2crs[i].type = S2CR_TYPE_BYPASS;
		smmu->s2crs[i].privcfg = S2CR_PRIVCFG_DEFAULT;
		smmu->s2crs[i].cbndx = 0xff;

		cnt++;
	}

	if ((reg & ARM_SMMU_sCR0_USFCFG) && !(reg & ARM_SMMU_sCR0_CLIENTPD)) {
		/* Remove the valid bit for unused SMRs */
		for (i = 0; i < smmu->num_mapping_groups; i++) {
			if (smmu->s2crs[i].count == 0)
				smmu->smrs[i].valid = false;
		}
	}

	dev_notice(smmu->dev, "\tpreserved %d boot mapping%s\n", cnt,
		   cnt == 1 ? "" : "s");
}
