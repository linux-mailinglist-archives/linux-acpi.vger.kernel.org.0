Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A86E50A492
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Apr 2022 17:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390262AbiDUPse (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Apr 2022 11:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390285AbiDUPsd (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Apr 2022 11:48:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F9004706E
        for <linux-acpi@vger.kernel.org>; Thu, 21 Apr 2022 08:45:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D754B1516;
        Thu, 21 Apr 2022 08:45:42 -0700 (PDT)
Received: from [10.57.41.251] (unknown [10.57.41.251])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A455D3F73B;
        Thu, 21 Apr 2022 08:45:39 -0700 (PDT)
Message-ID: <4c3cce25-cd40-092f-5316-e5c5d3adbcc6@arm.com>
Date:   Thu, 21 Apr 2022 16:45:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
Content-Language: en-GB
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
        Steven Price <steven.price@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Cc:     Linuxarm <linuxarm@huawei.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>,
        "Sami.Mujawar@arm.com" <Sami.Mujawar@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "laurentiu.tudor@nxp.com" <laurentiu.tudor@nxp.com>,
        "hch@infradead.org" <hch@infradead.org>
References: <20220420164836.1181-1-shameerali.kolothum.thodi@huawei.com>
 <b75dd20c-24b9-7944-bfb7-9f102623e725@arm.com>
 <78cd48d112b144b69bcc498748c584e3@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <78cd48d112b144b69bcc498748c584e3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2022-04-21 15:43, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Steven Price [mailto:steven.price@arm.com]
>> Sent: 21 April 2022 13:59
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org;
>> iommu@lists.linux-foundation.org
>> Cc: Linuxarm <linuxarm@huawei.com>; lorenzo.pieralisi@arm.com;
>> joro@8bytes.org; robin.murphy@arm.com; will@kernel.org; wanghuiqiang
>> <wanghuiqiang@huawei.com>; Guohanjun (Hanjun Guo)
>> <guohanjun@huawei.com>; Sami.Mujawar@arm.com; jon@solid-run.com;
>> eric.auger@redhat.com; laurentiu.tudor@nxp.com; hch@infradead.org
>> Subject: Re: [PATCH v10 0/9] ACPI/IORT: Support for IORT RMR node
>>
>> On 20/04/2022 17:48, Shameer Kolothum wrote:
>>> Hi
>>>
>>> v9 --> v10
>>>   - Dropped patch #1 ("Add temporary RMR node flag definitions") since
>>>     the ACPICA header updates patch is now in the mailing list[1]
>>>   - Based on the suggestion from Christoph, introduced a
>>>     resv_region_free_fw_data() callback in struct iommu_resv_region and
>>>     used that to free RMR specific memory allocations.
>>>
>>> Though there is a small change from v9 with respect to how we free up
>>> the FW specific data, I have taken the liberty to pick up the R-by and
>>> T-by tags from Lorenzo, Steve and Laurentiu. But please do take a look
>>> again and let me know.
>>
>> I've given this a go and it works fine on my Juno setup. So do keep my
>> T-by tag.
> 
> Many thanks for that.
> 
>> Sami has been kind enough to give me an updated firmware which also
>> fixes the RMR node in the IORT. Although as mentioned before the details
>> of the RMR node are currently being ignored so this doesn't change the
>> functionality but silences the warning.

Strictly they're not ignored, you just won't be getting past the point 
where they're not entirely not ignored. It'll appear to work because 
arm_smmu_rmr_install_bypass_smr() just bypasses the whole stream until 
the actual device turns up to join up to the StreamID and the "real" 
processing of RMRs happens via iommu_create_device_direct_mappings() - 
if there's no actual HDLCD device described in the DSDT, that will never 
happen, and even if there is, chances are that things will currently 
happen in the wrong order such we'd end up waiting to replay 
iommu_probe_device() from acpi_iommu_configure_id() once a driver binds, 
and *that* definitely can't happen without teaching the HDLCD driver 
about ACPI.

>> My concern is that with the RMR region effectively ignored we may see
>> more broken firmware, and while a length of zero produces a warning, an
>> otherwise incorrect length will currently "silently work" but mean that
>> any future tightening would cause problems. For example if the SMMU
>> driver were to recreate the mappings to only cover the region specified
>> in the RMR it may not be large enough if the RMR base/length are not
>> correct.
> 
> Not sure how we can further validate the RMR if the firmware provides an
> incorrect one. I see your point of future tightening causing problems
> with broken firmware. But then it is indeed a "broken firmware"...
> 
>   It's up to the maintainers as to whether they see this as a
>> problem or not.
> 
> Hi Robin,
> 
> Any thoughts on this?

In general we can't second-guess firmware. Even a zero-length RMR should 
have ample opportunity to blow up outside this one corner case where 
Linux never gets to associate the StreamID with a corresponding device.

Robin.
