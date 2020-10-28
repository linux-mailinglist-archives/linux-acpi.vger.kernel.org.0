Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2292229D3B8
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Oct 2020 22:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgJ1VqI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Oct 2020 17:46:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6919 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbgJ1VqI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 28 Oct 2020 17:46:08 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CLm6P095sz6yKv;
        Wed, 28 Oct 2020 19:09:01 +0800 (CST)
Received: from [10.174.179.182] (10.174.179.182) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 19:08:54 +0800
Subject: Re: [PATCH v4 6/7] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>, <hch@lst.de>,
        <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-rpi-kernel@lists.infradead.org>, <jeremy.linton@arm.com>,
        <iommu@lists.linux-foundation.org>, <devicetree@vger.kernel.org>,
        <will@kernel.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
 <20201021123437.21538-7-nsaenzjulienne@suse.de>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <3a1480f7-7fd6-247c-73a2-f761f9ce3362@huawei.com>
Date:   Wed, 28 Oct 2020 19:08:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201021123437.21538-7-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.182]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2020/10/21 20:34, Nicolas Saenz Julienne wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> incorporating masters that can address less than 32 bits of DMA, in
> particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> peripherals that can only address up to 1 GB (and its PCIe host
> bridge can only access the bottom 3 GB)
> 
> Instructing the DMA layer about these limitations is straight-forward,
> even though we had to fix some issues regarding memory limits set in
> the IORT for named components, and regarding the handling of ACPI _DMA
> methods. However, the DMA layer also needs to be able to allocate
> memory that is guaranteed to meet those DMA constraints, for bounce
> buffering as well as allocating the backing for consistent mappings.
> 
> This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> problems with kdump, and potentially in other places where allocations
> cannot cross zone boundaries. Therefore, we should avoid having two
> separate DMA zones when possible.
> 
> So let's do an early scan of the IORT, and only create the ZONE_DMA
> if we encounter any devices that need it. This puts the burden on
> the firmware to describe such limitations in the IORT, which may be
> redundant (and less precise) if _DMA methods are also being provided.
> However, it should be noted that this situation is highly unusual for
> arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> the _DMA method if implemented, and so we will not lose the ability to
> perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> it.
> 
> Cc: Jeremy Linton <jeremy.linton@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> [nsaenz: Rebased, removed documentation change and add declaration in acpi_iort.h]
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> ---
> 
> Changes since v3:
>   - Use min_not_zero()
>   - Check ACPI revision
>   - Remove unnecessary #ifdef in zone_sizes_init()
> 
>   arch/arm64/mm/init.c      |  3 ++-
>   drivers/acpi/arm64/iort.c | 52 +++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi_iort.h |  4 +++

Acked-by: Hanjun Guo <guohanjun@huawei.com>
