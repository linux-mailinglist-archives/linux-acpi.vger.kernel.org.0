Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893C1520F6F
	for <lists+linux-acpi@lfdr.de>; Tue, 10 May 2022 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbiEJIMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 10 May 2022 04:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiEJILE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 10 May 2022 04:11:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FBA2207921
        for <linux-acpi@vger.kernel.org>; Tue, 10 May 2022 01:07:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60D6B12FC;
        Tue, 10 May 2022 01:07:08 -0700 (PDT)
Received: from [10.57.80.111] (unknown [10.57.80.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 039643F73D;
        Tue, 10 May 2022 01:07:05 -0700 (PDT)
Message-ID: <5c8ae673-f8e3-0ed3-e62d-d445913b012c@arm.com>
Date:   Tue, 10 May 2022 09:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "steven.price@arm.com" <steven.price@arm.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220503163330.509-1-shameerali.kolothum.thodi@huawei.com>
 <2234ad60-c49f-8c72-616c-dfa5300354ef@huawei.com>
 <8e4f012717e34195a53cb73f8ce28627@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8e4f012717e34195a53cb73f8ce28627@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-05-10 08:23, Shameerali Kolothum Thodi wrote:
> Hi Joerg/Robin,
> 
> I think this series is now ready to be merged. Could you please let
> me know if there is anything missing.

Fine by me - these patches have had enough review and testing now that 
even if anything else did come up, I think it would be better done as 
follow-up work on the merged code.

Cheers,
Robin.

> 
> Thanks,
> Shameer
> 
>> -----Original Message-----
>> From: Guohanjun (Hanjun Guo)
>> Sent: 05 May 2022 02:24
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; steven.price@arm.com;
>> Sami.Mujawar@arm.com; jon@solid-run.com; eric.auger@redhat.com;
>> laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v12 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 2022/5/4 0:33, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v11 --> v12
>>>     -Minor fix in patch #4 to address the issue reported by the kernel test
>> robot.
>>>     -Added R-by tags by Christoph(patch #1) and Lorenzo(patch #4).
>>>     -Added T-by from Steve to all relevant patches. Many thanks!.
>>>
>>> Please note, this series has a dependency on the ACPICA header patch
>>> here[1].
>>
>> Tested on a Kunpeng920 server machine with SMMUv3, the 3408iMR RAID
>> controller card works as expected,
>>
>> Tested-by: Hanjun Guo <guohanjun@huawei.com>
>>
>> Thanks
>> Hanjun
