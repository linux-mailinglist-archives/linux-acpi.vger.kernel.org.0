Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB664F810A
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Apr 2022 15:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiDGNzr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Apr 2022 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDGNzr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Apr 2022 09:55:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 031F2101F01
        for <linux-acpi@vger.kernel.org>; Thu,  7 Apr 2022 06:53:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0EF012FC;
        Thu,  7 Apr 2022 06:53:44 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A90933F73B;
        Thu,  7 Apr 2022 06:53:42 -0700 (PDT)
Message-ID: <b50cded6-6777-c9c7-7030-a57f28771bc3@arm.com>
Date:   Thu, 7 Apr 2022 14:53:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v9 06/11] ACPI/IORT: Add support to retrieve IORT RMR
 reserved regions
Content-Language: en-GB
To:     Christoph Hellwig <hch@infradead.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org, jon@solid-run.com,
        linuxarm@huawei.com, steven.price@arm.com, guohanjun@huawei.com,
        yangyicong@huawei.com, Sami.Mujawar@arm.com, will@kernel.org,
        wanghuiqiang@huawei.com
References: <20220404124209.1086-1-shameerali.kolothum.thodi@huawei.com>
 <20220404124209.1086-7-shameerali.kolothum.thodi@huawei.com>
 <Yk7m8oDPtusDzReK@infradead.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yk7m8oDPtusDzReK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-04-07 14:28, Christoph Hellwig wrote:
>> +static void iort_rmr_desc_check_overlap(struct acpi_iort_rmr_desc *desc, u32 count)
> 
> Overly long line.
> 
>>   void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list)
>>   {
>> +	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>> +		iort_iommu_put_resv_regions(dev, list);
>> +
>>   	generic_iommu_put_resv_regions(dev, list);
>>   }
> 
> Why can't this just go into generic_iommu_put_resv_regions?  The idea
> that the iommu low-level drivers need to call into dma-iommu which is
> a consumer of the IOMMU API is odd.  Especially if that just calls out
> to ACPI code and generic IOMMU code only anyway.

Because assuming ACPI means IORT is not generic. Part of the aim in 
adding the union to iommu_resv_region is that stuff like AMD's 
unity_map_entry and Intel's dmar_rmrr_unit can be folded into it as 
well, and their reserved region handling correspondingly simplified too.

The iommu_dma_{get,put}_resv_region() helpers are kind of intended to be 
specific to the fwnode mechanism which deals with IORT and devicetree 
(once the reserved region bindings are fully worked out).

Thanks,
Robin.
