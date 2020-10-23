Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4216529777D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Oct 2020 21:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbgJWTFw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Oct 2020 15:05:52 -0400
Received: from foss.arm.com ([217.140.110.172]:58414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462847AbgJWTFw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Oct 2020 15:05:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07FFE101E;
        Fri, 23 Oct 2020 12:05:51 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ABDA3F66E;
        Fri, 23 Oct 2020 12:05:50 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] arm64: Default to 32-bit wide ZONE_DMA
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        will@kernel.org, lorenzo.pieralisi@arm.com, guohanjun@huawei.com,
        linux-acpi@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org
References: <20201021123437.21538-1-nsaenzjulienne@suse.de>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <9bccc5ef-9457-044b-7193-d002a395e461@arm.com>
Date:   Fri, 23 Oct 2020 14:05:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021123437.21538-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 10/21/20 7:34 AM, Nicolas Saenz Julienne wrote:
> Using two distinct DMA zones turned out to be problematic. Here's an
> attempt go back to a saner default.
> 
> I tested this on both a RPi4 and QEMU.

I've tested this in ACPI mode on the rpi4 (4+8G with/without the 3G 
limiter) as well, with Ard's IORT patch. Nothing seems to have regressed.

Thanks,

Tested-by: Jeremy Linton <jeremy.linton@arm.com>




> 
> ---
> 
> Changes since v3:
>   - Drop patch adding define in dma-mapping
>   - Address small review changes
>   - Update Ard's patch
>   - Add new patch removing examples from mmzone.h
> 
> Changes since v2:
>   - Introduce Ard's patch
>   - Improve OF dma-ranges parsing function
>   - Add unit test for OF function
>   - Address small changes
>   - Move crashkernel reservation later in boot process
> 
> Changes since v1:
>   - Parse dma-ranges instead of using machine compatible string
> 
> Ard Biesheuvel (1):
>    arm64: mm: Set ZONE_DMA size based on early IORT scan
> 
> Nicolas Saenz Julienne (6):
>    arm64: mm: Move reserve_crashkernel() into mem_init()
>    arm64: mm: Move zone_dma_bits initialization into zone_sizes_init()
>    of/address: Introduce of_dma_get_max_cpu_address()
>    of: unittest: Add test for of_dma_get_max_cpu_address()
>    arm64: mm: Set ZONE_DMA size based on devicetree's dma-ranges
>    mm: Remove examples from enum zone_type comment
> 
>   arch/arm64/mm/init.c      | 16 ++++++------
>   drivers/acpi/arm64/iort.c | 52 +++++++++++++++++++++++++++++++++++++++
>   drivers/of/address.c      | 42 +++++++++++++++++++++++++++++++
>   drivers/of/unittest.c     | 18 ++++++++++++++
>   include/linux/acpi_iort.h |  4 +++
>   include/linux/mmzone.h    | 20 ---------------
>   include/linux/of.h        |  7 ++++++
>   7 files changed, 130 insertions(+), 29 deletions(-)
> 

