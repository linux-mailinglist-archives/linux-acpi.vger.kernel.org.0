Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463E046D5E1
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Dec 2021 15:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhLHOl1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Dec 2021 09:41:27 -0500
Received: from foss.arm.com ([217.140.110.172]:33218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229611AbhLHOl0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Dec 2021 09:41:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50D3101E;
        Wed,  8 Dec 2021 06:37:54 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25543F73B;
        Wed,  8 Dec 2021 06:37:52 -0800 (PST)
Message-ID: <b268f857-52a4-62fb-c748-176dc86769fb@arm.com>
Date:   Wed, 8 Dec 2021 14:37:49 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
Content-Language: en-GB
To:     Jon Nettleton <jon@solid-run.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
 <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
 <20211208121854.GA7317@e123427-lin.cambridge.arm.com>
 <CABdtJHvOo+xG3pp0U1LyEAKqeUdU68tXNFN3PZBhgKVe0N=fUA@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CABdtJHvOo+xG3pp0U1LyEAKqeUdU68tXNFN3PZBhgKVe0N=fUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Jon,

On 2021-12-08 13:26, Jon Nettleton wrote:
[...]
>>> Even marking them as IOMMU_READ/WRITE is as much of an assumption as
>>> using IOMMU_MMIO or IOMMU_CACHE. It just seems IOMMU_MMIO is the most
>>> popular since all the examples use it for MSI doorbells in the
>>> documentation.
>>
>> We don't merge code based on assumptions that can easily break because
>> the specifications don't contemplate the details that are required.
>>
>>> I am interested why this concern is only being brought up at this point
>>> on a patchset that has been on the mailing list for 8+ months?
>>
>> See above. We don't merge code that we know can break and is based on
>> assumptions, we need to update the IORT specifications to make them
>> cover all the use cases - in a predictable way - and that's what we are
>> working on.
> 
> This is not really an answer to the question.  The latest version of the
> IORT RMR spec was published in Feb 2021. Why was this issue not
> brought up with Rev 1 of this patchset? Instead you have wasted
> 10 months of developer and customer time. This could have easily been
> turned into a code first spec change request, which is a valid option
> for ACPI changes.

It was only on v5 of the patchset - *six months* after the original RFC 
posting - that anyone even first started to question the initial 
assumptions made about attributes[1], and even then somebody familiar 
countered that it didn't appear to matter[2]. Sorry, but you don't get 
to U-turn and throw unjust shade at Arm for not being prescient.

Yes, when those of us within Arm set out the initial RMR spec, an 
assumption was made that it seemed reasonable for an OS to simply pick 
some default strong memory type (Device or Normal-NC) and full 
permissions if it did need to map RMRs at stage 1. That spec was 
reviewed and published externally and no interested parties came forth 
asking "hey, what about attributes?". Linux patches were written around 
that assumption and proceeded through many rounds of review until we 
eventually received sufficient feedback to demonstrate that the 
assumption did not in fact hold well enough in general and there seemed 
to be a genuine need for RMR attributes, and at that point we started 
work on revising the spec.

In the meantime, these patches have sat at v7 for four months - the 
*other* outstanding review comments have not been addressed; I still 
don't recall seeing an answer about whether LX2160 or anything else 
currently deployed actually *needs* cacheable mappings or whether it 
could muddle through with the IOMMU_MMIO assumption until proper "RMR 
v2" support arrived later; even if so, an interim workaround specific to 
LX2160 could have been proposed but hasn't. It is hardly reasonable to 
pretend that Arm or the upstream maintainers are responsible for a lack 
of development activity on the part of the submitters, no matter how 
much blatant misinformation is repeated on Twitter.

Regards,
Robin.

[1] 
https://lore.kernel.org/linux-iommu/13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com/
[2] 
https://lore.kernel.org/linux-iommu/CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com/

>>
>>> This is based on a spec that has existed from Arm since 2020 with the
>>> most recent revisions published in Feb 2021.  The lack of RMR support
>>> in the kernel is affecting real world products, and the ability for
>>> SystemReady ES certified systems from just fully working with recent
>>> distributions.
>>
>> I answered above - if you have any questions please ask them, here,
>> as far as Linux code is concerned.
>>
>> I understand this is taking a long time, it is also helping us
>> understand all the possible use cases and how to cover them in
>> a way that is maintainable in the long run.
> 
> Every month that this patchset has sat being unattended by the
> maintainers is another kernel dev cycle missed, it is another
> another distribution release where users need to add hackish
> kernel command-line options to disable security features that
> were forced on by default. Not to mention Linux is just one
> platform. What if other platforms have already adopted the
> existing spec? These are Arm specs and Arm maintainers and
> yet nobody seems to agree on anything and absolutely nothing
> has been achieved except wasting the time of Shameer, myself,
> our companies, and our customers.
> 
> -Jon
> 
>>
>> Thanks,
>> Lorenzo
>>
>>> Even worse, is that without this patchset customers are forced to jump
>>> through hoops to purposefully re-enable smmu bypass making their
>>> systems less secure.
>>>
>>> How is this a good experience for customers of SystemReady hardware
>>> when for any mainline distribution to work the first thing they have
>>> to do is make their system less secure?
>>>
>>> -Jon
>>>
>>>>
>>>> Thanks,
>>>> Robin.
>>>
