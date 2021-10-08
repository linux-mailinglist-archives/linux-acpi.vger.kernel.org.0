Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A311E426A85
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 14:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhJHMQX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 08:16:23 -0400
Received: from foss.arm.com ([217.140.110.172]:47704 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240715AbhJHMQX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Oct 2021 08:16:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C30DFED1;
        Fri,  8 Oct 2021 05:14:27 -0700 (PDT)
Received: from [10.57.22.120] (unknown [10.57.22.120])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E72F3F766;
        Fri,  8 Oct 2021 05:14:25 -0700 (PDT)
Subject: Re: [PATCH v7 1/9] iommu: Introduce a union to struct
 iommu_resv_region
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a1eddd80-4a26-4809-e681-f338d9998a24@arm.com>
Date:   Fri, 8 Oct 2021 13:14:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210805080724.480-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-08-05 09:07, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   include/linux/iommu.h | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 32d448050bf7..bd0e4641c569 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -114,6 +114,13 @@ enum iommu_resv_type {
>   	IOMMU_RESV_SW_MSI,
>   };
>   
> +struct iommu_iort_rmr_data {
> +#define IOMMU_RMR_REMAP_PERMITTED	(1 << 0)
> +	u32 flags;
> +	u32 sid;	/* Stream Id associated with RMR entry */
> +	void *smmu;	/* Associated IORT SMMU node pointer */
> +};

Do we really need to duplicate all this data? AFAICS we could just save 
the acpi_iort_rmr pointer in the iommu_resv_region (with a forward 
declaration here if necessary) and defer parsing its actual mappings 
until the point where we can directly consume the results.

Robin.

> +
>   /**
>    * struct iommu_resv_region - descriptor for a reserved memory region
>    * @list: Linked list pointers
> @@ -121,6 +128,7 @@ enum iommu_resv_type {
>    * @length: Length of the region in bytes
>    * @prot: IOMMU Protection flags (READ/WRITE/...)
>    * @type: Type of the reserved region
> + * @rmr: ACPI IORT RMR specific data
>    */
>   struct iommu_resv_region {
>   	struct list_head	list;
> @@ -128,6 +136,9 @@ struct iommu_resv_region {
>   	size_t			length;
>   	int			prot;
>   	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>   };
>   
>   /**
> 
