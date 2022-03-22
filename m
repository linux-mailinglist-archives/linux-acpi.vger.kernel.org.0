Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2F4E46B4
	for <lists+linux-acpi@lfdr.de>; Tue, 22 Mar 2022 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiCVTdG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Mar 2022 15:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiCVTdF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Mar 2022 15:33:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 419DE8A302
        for <linux-acpi@vger.kernel.org>; Tue, 22 Mar 2022 12:31:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0299023A;
        Tue, 22 Mar 2022 12:31:37 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD2D3F66F;
        Tue, 22 Mar 2022 12:31:35 -0700 (PDT)
Message-ID: <065a11de-da43-6854-f940-d1537227f191@arm.com>
Date:   Tue, 22 Mar 2022 19:31:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 01/11] ACPI/IORT: Add temporary RMR node flag
 definitions
Content-Language: en-GB
To:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     jon@solid-run.com, linuxarm@huawei.com, steven.price@arm.com,
        guohanjun@huawei.com, yangyicong@huawei.com, Sami.Mujawar@arm.com,
        will@kernel.org, wanghuiqiang@huawei.com
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-2-shameerali.kolothum.thodi@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220221154344.2126-2-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
> IORT rev E.d introduces more details into the RMR node Flags
> field. Add temporary definitions to describe and access these
> Flags field until ACPICA header is updated to support E.d.
> 
> This patch can be reverted once the include/acpi/actbl2.h has
> all the relevant definitions.
> 
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
> Please find the ACPICA E.d related changes pull request here,
> https://github.com/acpica/acpica/pull/752
> 
> ---
>   drivers/acpi/arm64/iort.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index f2f8f05662de..0730c4dbb700 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -25,6 +25,30 @@
>   #define IORT_IOMMU_TYPE		((1 << ACPI_IORT_NODE_SMMU) |	\
>   				(1 << ACPI_IORT_NODE_SMMU_V3))
>   
> +/*
> + * The following RMR related definitions are temporary and
> + * can be removed once ACPICA headers support IORT rev E.d
> + */
> +#ifndef ACPI_IORT_RMR_REMAP_PERMITTED
> +#define ACPI_IORT_RMR_REMAP_PERMITTED	(1)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ACCESS_PRIVILEGE
> +#define ACPI_IORT_RMR_ACCESS_PRIVILEGE	(1 << 1)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ACCESS_ATTRIBUTES
> +#define ACPI_IORT_RMR_ACCESS_ATTRIBUTES(flags)	(((flags) >> 2) & 0xFF)
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ATTR_DEVICE_GRE
> +#define ACPI_IORT_RMR_ATTR_DEVICE_GRE	0x03
> +#endif
> +
> +#ifndef ACPI_IORT_RMR_ATTR_NORMAL
> +#define ACPI_IORT_RMR_ATTR_NORMAL	0x05

For the record, I've commented directly on the ACPICA pull request that 
I think this should be more clearly named to indicate that it means 
Normal Write-Back Cacheable, rather than being potentially ambiguous 
about cacheability.

Robin.

> +#endif
> +
>   struct iort_its_msi_chip {
>   	struct list_head	list;
>   	struct fwnode_handle	*fw_node;
