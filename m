Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31E3F4AAA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Aug 2021 14:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236981AbhHWMbo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 23 Aug 2021 08:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233755AbhHWMbl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 23 Aug 2021 08:31:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A53A76138B;
        Mon, 23 Aug 2021 12:30:55 +0000 (UTC)
Date:   Mon, 23 Aug 2021 13:30:52 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH RESEND v3] ACPI: Add memory semantics to
 acpi_os_map_memory()
Message-ID: <20210823123052.GC8603@arm.com>
References: <20210802152359.12623-1-lorenzo.pieralisi@arm.com>
 <20210823104618.14552-1-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823104618.14552-1-lorenzo.pieralisi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 23, 2021 at 11:46:18AM +0100, Lorenzo Pieralisi wrote:
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
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> ---
> Resending with all lists CC'ed.
> 
> Patch series is a v3 of a previous version[2]:
> 
> v2->v3:
> 	- Dropped first two-patches following LKML feedback[2]
> v1->v2
> 	- Added patch 1 and 2 according to feedback received on[1]
> 
> [1] https://lore.kernel.org/linux-acpi/20210726100026.12538-1-lorenzo.pieralisi@arm.com
> [2] https://lore.kernel.org/linux-acpi/20210802152359.12623-1-lorenzo.pieralisi@arm.com
> 
>  arch/arm64/include/asm/acpi.h |  3 +++
>  arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
>  drivers/acpi/osl.c            | 23 ++++++++++++++++-------
>  include/acpi/acpi_io.h        |  8 ++++++++
>  4 files changed, 43 insertions(+), 10 deletions(-)

For arm64:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

I presume this patch would go in via the acpi tree.

-- 
Catalin
