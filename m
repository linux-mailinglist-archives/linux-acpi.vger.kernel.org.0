Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4A42906A
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Oct 2021 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbhJKOIL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Oct 2021 10:08:11 -0400
Received: from foss.arm.com ([217.140.110.172]:56870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238654AbhJKOGN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Oct 2021 10:06:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6A4101E;
        Mon, 11 Oct 2021 07:04:09 -0700 (PDT)
Received: from [10.57.95.157] (unknown [10.57.95.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB0BD3F694;
        Mon, 11 Oct 2021 07:04:07 -0700 (PDT)
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Jon Nettleton <jon@solid-run.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com>
 <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
Date:   Mon, 11 Oct 2021 15:04:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-10-09 08:06, Jon Nettleton wrote:
[...]
>>> +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
>>> +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
>>> +                     /*
>>> +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
>>> +                      * normally used for allocated system memory that is
>>> +                      * then used for device specific reserved regions.
>>> +                      */
>>> +                     prot |= IOMMU_CACHE;
>>> +             } else {
>>> +                     type = IOMMU_RESV_DIRECT;
>>> +                     /*
>>> +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
>>> +                      * for device memory like MSI doorbell.
>>> +                      */
>>> +                     prot |= IOMMU_MMIO;
>>> +             }
>>
>> I'm not sure we ever got a definitive answer to this - does DPAA2
>> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
>> make the fewest possible assumptions, since at this point it's basically
>> just a stop-gap until we can fix the spec. It's become clear that we
>> can't reliably rely on guessing attributes, so I'm not too fussed about
>> theoretical cases that currently don't work (due to complete lack of RMR
>> support) continuing to not work for the moment, as long as we can make
>> the real-world cases we actually have work at all. Anything which only
>> affects performance I'd rather leave until firmware can tell us what to do.
> 
> Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
> mappings.  DPAA2 is just one connected device.

Apologies if I'm being overly loose with terminology there - my point of 
reference for this hardware is documentation for the old LS2080A, where 
the "DPAA2 Reference Manual" gives a strong impression that the MC is a 
component belonging to the overall DPAA2 architecture. Either way it 
technically stands to reason that the other DPAA2 components would only 
be usable if the MC itself works (unless I've been holding a major 
misconception about that for years as well).

In the context of this discussion, please consider any reference I may 
make to bits of NXP's hardware to be shorthand for "the thing for which 
NXP have a vested interest in IORT RMRs".

Thanks,
Robin.
