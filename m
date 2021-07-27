Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2260E3D6D35
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jul 2021 06:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhG0EVu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Jul 2021 00:21:50 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:12266 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhG0EVt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2021 00:21:49 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GYk492wt2z1CPJS;
        Tue, 27 Jul 2021 12:15:53 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 12:21:47 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Jul 2021 12:21:46 +0800
Subject: Re: [PATCH] ACPI: Add memory semantics to acpi_os_map_memory()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <linux-kernel@vger.kernel.org>
CC:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <eaa04e3d-f262-22df-4dce-c88cbaa6a45a@huawei.com>
Date:   Tue, 27 Jul 2021 12:21:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 2021/7/26 18:00, Lorenzo Pieralisi wrote:
> The memory attributes attached to memory regions depend on architecture
> specific mappings.
> 
> For some memory regions, the attributes specified by firmware (eg
> uncached) are not sufficient to determine how a memory region should be
> mapped by an OS (for instance a region that is define as uncached in
> firmware can be mapped as Normal or Device memory on arm64) and
> therefore the OS must be given control on how to map the region to match
> the expected mapping behaviour (eg if a mapping is requested with memory
> semantics, it must allow unaligned accesses).
> 
> Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> them into two separate code paths:
> 
> acpi_os_memmap() -> memory semantics
> acpi_os_ioremap() -> MMIO semantics
> 
> The split allows the architectural implementation back-ends to detect
> the default memory attributes required by the mapping in question
> (ie the mapping API defines the semantics memory vs MMIO) and map the
> memory accordingly.
> 
> Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
>   arch/arm64/include/asm/acpi.h |  3 +++
>   arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
>   drivers/acpi/osl.c            | 23 ++++++++++++++++-------
>   include/acpi/acpi_io.h        |  8 ++++++++

Acked-by: Hanjun Guo <guohanjun@huawei.com>

I did the boot test on both x86 and ARM64 server machines,
and no regressions,

Tested-by: Hanjun Guo <guohanjun@huawei.com>

Thanks
Hanjun
