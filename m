Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAF64E45FB
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Mar 2022 19:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiCVS3J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239371AbiCVS3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 14:29:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37D4D90246
        for <linux-acpi@vger.kernel.org>; Tue, 22 Mar 2022 11:27:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC250152B;
        Tue, 22 Mar 2022 11:27:33 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332BA3F66F;
        Tue, 22 Mar 2022 11:27:31 -0700 (PDT)
Message-ID: <5cf2c21b-6974-b2f9-140d-382985cf3095@arm.com>
Date:   Tue, 22 Mar 2022 18:27:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 02/11] iommu: Introduce a union to struct
 iommu_resv_region
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     linuxarm@huawei.com, lorenzo.pieralisi@arm.com, joro@8bytes.org,
        will@kernel.org, wanghuiqiang@huawei.com, guohanjun@huawei.com,
        steven.price@arm.com, Sami.Mujawar@arm.com, jon@solid-run.com,
        eric.auger@redhat.com, yangyicong@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-21 15:43, Shameer Kolothum wrote:
> A union is introduced to struct iommu_resv_region to hold
> any firmware specific data. This is in preparation to add
> support for IORT RMR reserve regions and the union now holds
> the RMR specific information.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>   include/linux/iommu.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index de0c57a567c8..b06952a75f95 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -126,6 +126,11 @@ enum iommu_resv_type {
>   	IOMMU_RESV_SW_MSI,
>   };
>   
> +struct iommu_iort_rmr_data {
> +	u32 *sids;	/* Stream Ids associated with IORT RMR entry */

Please make this const.

Further nit: capitalisation of "IDs" in the comment, otherwise I might 
worry about the possibility of Stream Egos too :P

> +	u32 num_sids;
> +};
> +
>   /**
>    * struct iommu_resv_region - descriptor for a reserved memory region
>    * @list: Linked list pointers
> @@ -133,6 +138,7 @@ enum iommu_resv_type {
>    * @length: Length of the region in bytes
>    * @prot: IOMMU Protection flags (READ/WRITE/...)
>    * @type: Type of the reserved region
> + * @fw_data: FW specific reserved region data

Nit: we've got plenty of room to spell out "Firmware-specific", and it 
never hurts to make documentation as easy to read as possible.

Thanks,
Robin.

>    */
>   struct iommu_resv_region {
>   	struct list_head	list;
> @@ -140,6 +146,9 @@ struct iommu_resv_region {
>   	size_t			length;
>   	int			prot;
>   	enum iommu_resv_type	type;
> +	union {
> +		struct iommu_iort_rmr_data rmr;
> +	} fw_data;
>   };
>   
>   /**
