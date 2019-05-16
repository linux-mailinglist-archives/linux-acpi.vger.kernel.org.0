Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEA891FD45
	for <lists+linux-acpi@lfdr.de>; Thu, 16 May 2019 03:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfEPBqe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 21:46:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726277AbfEPBlx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 21:41:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E9099E131540A4194732;
        Thu, 16 May 2019 09:41:51 +0800 (CST)
Received: from [127.0.0.1] (10.177.19.180) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 09:41:43 +0800
Subject: Re: [PATCH RESEND] ACPI/IORT: Fix build error when IOMMU_SUPPORT
 disabled
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
CC:     Will Deacon <will.deacon@arm.com>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <guohanjun@huawei.com>,
        "Jean-Philippe Brucker" <jean-philippe.brucker@arm.com>,
        Hulk Robot <hulkci@huawei.com>, <joro@8bytes.org>
References: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
 <20190515034253.79348-1-wangkefeng.wang@huawei.com>
 <20190515101534.GF24357@fuggles.cambridge.arm.com>
 <20190515120652.GA27269@e121166-lin.cambridge.arm.com>
 <a7efd571-d82e-1d8f-147f-3bf8d1152d0d@arm.com>
 <20190515164110.GA22536@e121166-lin.cambridge.arm.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <15f19985-fb84-18ed-d5b8-e06079fb83ac@huawei.com>
Date:   Thu, 16 May 2019 09:39:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190515164110.GA22536@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.177.19.180]
X-CFilter-Loop: Reflected
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org


On 2019/5/16 0:41, Lorenzo Pieralisi wrote:
> On Wed, May 15, 2019 at 01:46:28PM +0100, Robin Murphy wrote:
>> On 15/05/2019 13:06, Lorenzo Pieralisi wrote:
>>> [+Joerg, Robin]
>>>
>>> On Wed, May 15, 2019 at 11:15:34AM +0100, Will Deacon wrote:
>>>> On Wed, May 15, 2019 at 11:42:53AM +0800, Kefeng Wang wrote:
>>>>> drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
>>>>> drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
>>>>>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>>>>>                       ^~
>>>>> drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
>>>>> undeclared (first use in this function)
>>>>>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>>>>>                                  ^~~~~~~~~~~~~~~~~~~~~~~
>>>>> drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
>>>>>
>>>>> If IOMMU_SUPPORT not enabled, struct iommu_fwspec without members and
>>>>> IOMMU_FWSPEC_PCI_RC_ATS not defined, add new iommu_fwspec_set_ats_flags()
>>>>> to set IOMMU_FWSPEC_PCI_RC_ATS flags to solve build error.
>>>>>
>>>>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>>>> Cc: Will Deacon <will.deacon@arm.com>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>> What's this "Hulk Robot"? Does it report things publicly?
>>> AFAIK it is Huawei CI system, I had some doubts about leaving
>>> that tag for other patches I dealt with, I am not sure it is
>>> really useful (other than giving Hulk some credit).

As Lorenzo said, it is Huawei CI system to improve the robustness of

our inner Linux kernel version, we also use it to test the latest Linux kernel.

The system is still being developed, and  still need to enhance and improve.

>>>
>>>> Anyway, I can pick this up if Lorenzo acks it.
>>> Actually I think we should compile out iort_iommu_configure() for
>>> !IOMMU_SUPPORT unless I am missing something, so that we are
>>> removing this source of errors.
>> Indeed, much as I like the compile coverage of not having things #ifdefed
>> out in general, this particular case seems like a fairly atypical
>> configuration so I'm not sure all the extra fluff of struct accessors is
>> really worth it.
This is founded by randconfig built, it seems that no one use this kind of configuration
> Ok, I will send a patch shortly to address this issue, if Kefeng
> does not object I will drop the CI bot as reporter and add him
> instead.
Either way is ok, thanks.
>
> Thanks,
> Lorenzo
>
>> Robin.
>>
>>> If that does not cut it, for this patch:
>>>
>>> iommu_fwspec_set_ats_flags() should be iommu_fwspec_set_ats_flag()
>>>
>>> The commit log should be fixed (it is pretty weird to start with the
>>> build error and then explain it):
>>>
>>> "If IOMMU_SUPPORT is not enabled, struct iommu_fwspec is an empty
>>> struct and IOMMU_FWSPEC_PCI_RC_ATS is not defined, resulting in
>>> the following build error:
>>>
>>> drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
>>> drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
>>>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>>>                       ^~
>>> drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
>>> undeclared (first use in this function)
>>>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>>>                                  ^~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
>>>
>>> Add a iommu_fwspec_set_ats_flag() helper function (that is an empty
>>> stub on !IOMMU_SUPPORT) to fix it."
>>>
> .
>

