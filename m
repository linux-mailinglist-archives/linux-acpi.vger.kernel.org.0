Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC0B3A5FFA
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Jun 2021 12:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhFNKZR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Jun 2021 06:25:17 -0400
Received: from foss.arm.com ([217.140.110.172]:59746 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232764AbhFNKZR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 14 Jun 2021 06:25:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D144A1FB;
        Mon, 14 Jun 2021 03:23:14 -0700 (PDT)
Received: from [10.57.9.136] (unknown [10.57.9.136])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C1A973F694;
        Mon, 14 Jun 2021 03:23:12 -0700 (PDT)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_5/8=5d_iommu/arm-smmu-v3=3a_Add_bypass_?=
 =?UTF-8?B?ZmxhZyB0b8KgYXJtX3NtbXVfd3JpdGVfc3RydGFiX2VudCgp?=
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210524110222.2212-1-shameerali.kolothum.thodi@huawei.com>
 <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <ab9a8ca2-8611-2dcc-8b03-e13715521905@arm.com>
Date:   Mon, 14 Jun 2021 11:23:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210524110222.2212-6-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-05-24 12:02, Shameer Kolothum wrote:
> By default, disable_bypass is set and any dev without an iommu domain
> installs STE with CFG_ABORT during arm_smmu_init_bypass_stes(). Introduce
> a "bypass" flag to arm_smmu_write_strtab_ent() so that we can force it to
> install CFG_BYPASS STE for specific SIDs. This will be useful in follow
> up patch to install bypass for IORT RMR SIDs.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 754bad6092c1..f9195b740f48 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1174,7 +1174,7 @@ static void arm_smmu_sync_ste_for_sid(struct arm_smmu_device *smmu, u32 sid)
>   }
>   
>   static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> -				      __le64 *dst)
> +				      __le64 *dst, bool bypass)
>   {
>   	/*
>   	 * This is hideously complicated, but we only really care about
> @@ -1245,7 +1245,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
>   
>   	/* Bypass/fault */
>   	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
> -		if (!smmu_domain && disable_bypass)
> +		if (!smmu_domain && disable_bypass && !bypass)

Umm...

>   			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
>   		else
>   			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_BYPASS);
> @@ -1320,7 +1320,7 @@ static void arm_smmu_init_bypass_stes(__le64 *strtab, unsigned int nent)
>   	unsigned int i;
>   
>   	for (i = 0; i < nent; ++i) {
> -		arm_smmu_write_strtab_ent(NULL, -1, strtab);
> +		arm_smmu_write_strtab_ent(NULL, -1, strtab, false);

...and in particular, an operation named "init_bypass_stes" passing 
bypass=false is just breaking my brain. Can we pull the logic for 
default bypass/fault out to here as part of the refactoring so that it 
actually makes sense?

Robin.

>   		strtab += STRTAB_STE_DWORDS;
>   	}
>   }
> @@ -2097,7 +2097,7 @@ static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master)
>   		if (j < i)
>   			continue;
>   
> -		arm_smmu_write_strtab_ent(master, sid, step);
> +		arm_smmu_write_strtab_ent(master, sid, step, false);
>   	}
>   }
>   
> 
