Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2F828FF2E
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Oct 2020 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404652AbgJPHeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Oct 2020 03:34:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40466 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404651AbgJPHeY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 03:34:24 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C7DCF20730CFDFF190F3;
        Fri, 16 Oct 2020 15:34:21 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 15:34:11 +0800
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Ard Biesheuvel <ardb@kernel.org>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Christoph Hellwig" <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
 <20201015180340.GB2624@gaia>
 <35faab1c-5c32-6cd3-0a14-77057dd223f5@huawei.com>
 <CAMj1kXFzYbr_mYm-zhsio2XV+KGgDBjtgy_NWNYnanyfU-U-Nw@mail.gmail.com>
 <89ed58a5-b3ca-e361-94d8-b6754ce5eb34@huawei.com>
Message-ID: <6efd3623-e758-30a7-b798-c06a624bed4e@huawei.com>
Date:   Fri, 16 Oct 2020 15:34:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <89ed58a5-b3ca-e361-94d8-b6754ce5eb34@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/16 15:27, Hanjun Guo wrote:
>> The patch only takes the address limit field into account if its value 
>> > 0.
> 
> Sorry I missed the if (*->memory_address_limit) check, thanks
> for the reminding.
> 
>>
>> Also, before commit 7fb89e1d44cb6aec ("ACPI/IORT: take _DMA methods
>> into account for named components"), the _DMA method was not taken
>> into account for named components at all, and only the IORT limit was
>> used, so I do not anticipate any problems with that.
> 
> Then this patch is fine to me.

Certainly we need to address Lorenzo's comments.

Thanks
Hanjun
