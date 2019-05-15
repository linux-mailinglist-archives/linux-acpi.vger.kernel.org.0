Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5369C1F4BB
	for <lists+linux-acpi@lfdr.de>; Wed, 15 May 2019 14:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfEOMqd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 May 2019 08:46:33 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43958 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbfEOMqd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 15 May 2019 08:46:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 813C9374;
        Wed, 15 May 2019 05:46:32 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CAEF83F71E;
        Wed, 15 May 2019 05:46:30 -0700 (PDT)
Subject: Re: [PATCH RESEND] ACPI/IORT: Fix build error when IOMMU_SUPPORT
 disabled
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        guohanjun@huawei.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Hulk Robot <hulkci@huawei.com>, joro@8bytes.org
References: <20190515033406.79020-1-wangkefeng.wang@huawei.com>
 <20190515034253.79348-1-wangkefeng.wang@huawei.com>
 <20190515101534.GF24357@fuggles.cambridge.arm.com>
 <20190515120652.GA27269@e121166-lin.cambridge.arm.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a7efd571-d82e-1d8f-147f-3bf8d1152d0d@arm.com>
Date:   Wed, 15 May 2019 13:46:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190515120652.GA27269@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 15/05/2019 13:06, Lorenzo Pieralisi wrote:
> [+Joerg, Robin]
> 
> On Wed, May 15, 2019 at 11:15:34AM +0100, Will Deacon wrote:
>> On Wed, May 15, 2019 at 11:42:53AM +0800, Kefeng Wang wrote:
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
>>> If IOMMU_SUPPORT not enabled, struct iommu_fwspec without members and
>>> IOMMU_FWSPEC_PCI_RC_ATS not defined, add new iommu_fwspec_set_ats_flags()
>>> to set IOMMU_FWSPEC_PCI_RC_ATS flags to solve build error.
>>>
>>> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>
>> What's this "Hulk Robot"? Does it report things publicly?
> 
> AFAIK it is Huawei CI system, I had some doubts about leaving
> that tag for other patches I dealt with, I am not sure it is
> really useful (other than giving Hulk some credit).
> 
>> Anyway, I can pick this up if Lorenzo acks it.
> 
> Actually I think we should compile out iort_iommu_configure() for
> !IOMMU_SUPPORT unless I am missing something, so that we are
> removing this source of errors.

Indeed, much as I like the compile coverage of not having things 
#ifdefed out in general, this particular case seems like a fairly 
atypical configuration so I'm not sure all the extra fluff of struct 
accessors is really worth it.

Robin.

> If that does not cut it, for this patch:
> 
> iommu_fwspec_set_ats_flags() should be iommu_fwspec_set_ats_flag()
> 
> The commit log should be fixed (it is pretty weird to start with the
> build error and then explain it):
> 
> "If IOMMU_SUPPORT is not enabled, struct iommu_fwspec is an empty
> struct and IOMMU_FWSPEC_PCI_RC_ATS is not defined, resulting in
> the following build error:
> 
> drivers/acpi/arm64/iort.c: In function iort_iommu_configure:
> drivers/acpi/arm64/iort.c:1079:21: error: struct iommu_fwspec has no member named flags
>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>                       ^~
> drivers/acpi/arm64/iort.c:1079:32: error: IOMMU_FWSPEC_PCI_RC_ATS
> undeclared (first use in this function)
>      dev->iommu_fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
>                                  ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/arm64/iort.c:1079:32: note: each undeclared identifier is reported only once for each function it appears in
> 
> Add a iommu_fwspec_set_ats_flag() helper function (that is an empty
> stub on !IOMMU_SUPPORT) to fix it."
> 
