Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8924E55C348
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Jun 2022 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiF0M0E (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Jun 2022 08:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiF0M0B (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jun 2022 08:26:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E31CC2AF6
        for <linux-acpi@vger.kernel.org>; Mon, 27 Jun 2022 05:26:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DED441758;
        Mon, 27 Jun 2022 05:26:00 -0700 (PDT)
Received: from [10.57.84.159] (unknown [10.57.84.159])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4BE53F792;
        Mon, 27 Jun 2022 05:25:58 -0700 (PDT)
Message-ID: <ff579ecb-9a37-09ef-a975-cf1e25ab731e@arm.com>
Date:   Mon, 27 Jun 2022 13:25:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     "jon@solid-run.com" <jon@solid-run.com>,
        Linuxarm <linuxarm@huawei.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>, lpieralisi@kernel.org
References: <20220615101044.1972-1-shameerali.kolothum.thodi@huawei.com>
 <03b03d88-87cd-0b29-863b-2cb2a9a117d1@arm.com>
 <44338c87254d4d439d29694de8f19435@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <44338c87254d4d439d29694de8f19435@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-06-24 16:44, Shameerali Kolothum Thodi via iommu wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 17 June 2022 13:42
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v13 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 15/06/2022 11:10, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v12 --> v13
>>>    -No changes. Rebased to 5.19-rc1.
>>>    -Picked up tags received from Laurentiu, Hanjun and Will. Thanks!.
>>
>> You've already got my Tested-by tags, but just to confirm I gave this a
>> spin and it works fine.
> 
> Thanks Steve.
> 
> I think the series is now in a good shape to be merged.
> 
> Hi Will/Robin,
> 
> Appreciate, if you could please take a look at the remaining SMMU related
> patches(7-9) and provide your approval?

I said v12 looked fine, but for the avoidance of doubt, here it is 
again, as formally as can be:

Acked-by: Robin Murphy <robin.murphy@arm.com>

Thanks,
Robin.
