Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BB43F2A11
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Aug 2021 12:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbhHTKX1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 20 Aug 2021 06:23:27 -0400
Received: from foss.arm.com ([217.140.110.172]:58326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237258AbhHTKX0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 20 Aug 2021 06:23:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01F0D101E;
        Fri, 20 Aug 2021 03:22:49 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5173F70D;
        Fri, 20 Aug 2021 03:22:46 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        robin.murphy@arm.com, will@kernel.org, wanghuiqiang@huawei.com,
        guohanjun@huawei.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <02a2c1cf-11f2-e3c1-95b5-828ceda88517@arm.com>
Date:   Fri, 20 Aug 2021 11:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 05/08/2021 09:07, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/linux/iommu.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..bd0e4641c569 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,13 @@ enum iommu_resv_type {
>  	IOMMU_RESV_SW_MSI,
>  };
>  
> +struct iommu_iort_rmr_data {
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +	u32 flags;
> +	u32 sid;	/* Stream Id associated with RMR entry */
> +	void *smmu;	/* Associated IORT SMMU node pointer */
> +};
> +
>  /**
>   * struct iommu_resv_region - descriptor for a reserved memory region
>   * @list: Linked list pointers
> @@ -121,6 +128,7 @@ enum iommu_resv_type {
>   * @length: Length of the region in bytes
>   * @prot: IOMMU Protection flags (READ/WRITE/...)
>   * @type: Type of the reserved region
> + * @rmr: ACPI IORT RMR specific data

NIT: This will provoke a kernel-doc warning as the field name in the
structure is 'fw_data' not 'rmr' ('rmr being a field of the anonymous
union).

I've also retested this series on my Juno setup, so feel free to add:

Tested-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

>   */
>  struct iommu_resv_region {
>  	struct list_head	list;
> @@ -128,6 +136,9 @@ struct iommu_resv_region {
>  	size_t			length;
>  	int			prot;
>  	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>  };
>  
>  /**
> 

