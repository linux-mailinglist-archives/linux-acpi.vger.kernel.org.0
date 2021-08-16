Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59433ED2B1
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbhHPLAD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 07:00:03 -0400
Received: from foss.arm.com ([217.140.110.172]:42872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232390AbhHPLAC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 07:00:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 583B36D;
        Mon, 16 Aug 2021 03:59:31 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76F743F40C;
        Mon, 16 Aug 2021 03:59:29 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
 <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
 <YRPZ2Kqb/MFggHzQ@infradead.org> <20210811145508.GA3650@lpieralisi>
 <20210816095854.GA2599@lpieralisi>
 <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <381418c8-5302-6991-b3aa-df6378dd1c64@arm.com>
Date:   Mon, 16 Aug 2021 11:59:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021-08-16 11:21, Ard Biesheuvel wrote:
> On Mon, 16 Aug 2021 at 11:59, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
>>
>> On Wed, Aug 11, 2021 at 03:55:08PM +0100, Lorenzo Pieralisi wrote:
>>> On Wed, Aug 11, 2021 at 03:08:24PM +0100, Christoph Hellwig wrote:
>>>> On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
>>>>> The whole problem we are solving here is that ACPI, being based on
>>>>> x86, conflates MMIO mappings with memory mappings, and has been using
>>>>> the same underlying infrastructure for either.
>>>>
>>>> So let's fix that problem instead of papering over it.
>>>
>>> Patch (3) in this series is a fix - I would ask whether it makes
>>> sense to merge patches (2-3) now and think about reworking the current
>>> ACPI IO/MEM mapping API later, it can be an invasive change for a fix,
>>> assuming we agree on how to rework the ACPI IO/MEM mapping API.
>>
>> What should we do then with this series ?
>>
> 
> It is not even clear that reworking the ACPI core is feasible to begin
> with, OTOH, fixing a sparse warning is arguably not a critical bug fix
> either, so I'd suggest we just drop that bit.

Indeed, the only way to truly fix the issue is to fire up the time 
machine and rewrite the ACPI and EFI specs to not define that tables and 
data may or may not be required to be mapped as Device memory depending 
on the whims of the firmware. Otherwise we're basically always going to 
have one or more casts *somewhere*, even if we were to play it safe and 
return everything as iomem instead.

I guess for read-only access to tables, the core code might be able to 
maintain a shadow copy of anything device-memory-mapped in normal memory 
and expose that instead, but if anything has to be writeable I'm not 
sure how we could abstract that "properly".

Robin.
