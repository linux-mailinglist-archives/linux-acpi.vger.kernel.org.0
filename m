Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B5F4E7CB5
	for <lists+linux-acpi@lfdr.de>; Sat, 26 Mar 2022 01:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiCYU4r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Mar 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiCYU4q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Mar 2022 16:56:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D94D522BFA
        for <linux-acpi@vger.kernel.org>; Fri, 25 Mar 2022 13:55:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54000D6E;
        Fri, 25 Mar 2022 10:49:48 -0700 (PDT)
Received: from [10.57.41.19] (unknown [10.57.41.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4619F3F73D;
        Fri, 25 Mar 2022 10:49:46 -0700 (PDT)
Message-ID: <c982f1d7-c565-769a-abae-79c962969d88@arm.com>
Date:   Fri, 25 Mar 2022 17:49:39 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR memory
 regions
Content-Language: en-GB
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20220221154344.2126-1-shameerali.kolothum.thodi@huawei.com>
 <20220221154344.2126-6-shameerali.kolothum.thodi@huawei.com>
 <479ae561-e03e-163e-f945-d0c8fdf8dcea@arm.com>
 <ad7ae652a2b54261a522008a25238039@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ad7ae652a2b54261a522008a25238039@huawei.com>
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

On 2022-03-23 16:06, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: 22 March 2022 19:09
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: jon@solid-run.com; Linuxarm <linuxarm@huawei.com>;
>> steven.price@arm.com; Guohanjun (Hanjun Guo) <guohanjun@huawei.com>;
>> yangyicong <yangyicong@huawei.com>; Sami.Mujawar@arm.com;
>> will@kernel.org; wanghuiqiang <wanghuiqiang@huawei.com>
>> Subject: Re: [PATCH v8 05/11] ACPI/IORT: Add a helper to retrieve RMR
>> memory regions
>>
>> On 2022-02-21 15:43, Shameer Kolothum via iommu wrote:
>>> Add helper functions (iort_iommu_get/put_rmrs()) that
>>> retrieves/releases RMR memory descriptors associated
>>> with a given IOMMU. This will be used by IOMMU drivers
>>> to set up necessary mappings.
>>>
>>> Invoke it from the generic iommu helper functions.
>>
>> iommu_dma_get_resv_regions() already exists - please extend that rather
>> than adding a parallel implementation of the same thing but different.
>> IORT should export a single get_resv_regions helper which combines the
>> new RMRs with the existing MSI workaround, and a separate "do I need to
>> bypass this StreamID" helper for the SMMU drivers to call directly at
>> reset time, since the latter isn't really an iommu-dma responsibility.
> 
> Right. I actually had couple of back and forth on the interfaces and settled
> on this mainly because it just requires a single interface from IORT for both
> get_resv_regions() and SMMU driver reset bypass path.
> ie, iort_iommu_get/put_rmrs()).
> 
> But agree the above comment is also valid.
> 
>> I'm happy to do that just by shuffling wrappers around for now - we can
>> come back and streamline the code properly afterwards - but the sheer
>> amount of indirection currently at play here is so hard to follow that
>> it's not even all that easy to see how it's crossing abstraction levels
>> improperly.
> 
> Please find below the revised ones. Please take a look and let me know.

Yeah, that looks like it should work!

Cheers,
Robin.

> 
> Thanks,
> Shameer
> 
> iommu-dma:
> 
> void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list) {
> 
>          if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>                  iort_iommu_get_resv_regions(dev, list);
> }
> 
> void iommu_dma_put_resv_regions(struct device *dev, struct list_head *list) {
> 
>          if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
>                  iort_iommu_put_resv_regions(dev, list);
>          generic_iommu_put_resv_regions(dev, list);
> }
> 
> iort:
> 
> void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head) {
>          struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> 
>          iort_iommu_msi_get_resv_regions(dev, head);
>          iort_iommu_get_rmrs(fwspec->iommu_fwnode, dev, head);
> }
> 
> void iort_iommu_put_resv_regions(struct device *dev, struct list_head *head) {
>     ./*Free both RMRs and HW MSI ones */
> }
> 
> /* The below ones will be directly called from SMMU drivers during reset */
> void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
>          iort_iommu_get_rmrs(iommu_fwnode, NULL, head); }
> }
> 
> void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *head) {
>          iort_iommu_put_resv_regions(NULL, head);
> }
