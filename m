Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67073DE997
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Aug 2021 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhHCJQY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Aug 2021 05:16:24 -0400
Received: from foss.arm.com ([217.140.110.172]:45196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234805AbhHCJQX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Aug 2021 05:16:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83B5411D4;
        Tue,  3 Aug 2021 02:16:12 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 11A933F40C;
        Tue,  3 Aug 2021 02:16:10 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:16:05 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>, rjw@rjwysocki.net
Cc:     linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 3/3] ACPI: Add memory semantics to acpi_os_map_memory()
Message-ID: <20210803091605.GA9637@lpieralisi>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-4-lorenzo.pieralisi@arm.com>
 <20210802164622.GJ18685@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802164622.GJ18685@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 02, 2021 at 05:46:22PM +0100, Catalin Marinas wrote:
> On Mon, Aug 02, 2021 at 04:23:59PM +0100, Lorenzo Pieralisi wrote:
> > The memory attributes attached to memory regions depend on architecture
> > specific mappings.
> > 
> > For some memory regions, the attributes specified by firmware (eg
> > uncached) are not sufficient to determine how a memory region should be
> > mapped by an OS (for instance a region that is define as uncached in
> > firmware can be mapped as Normal or Device memory on arm64) and
> > therefore the OS must be given control on how to map the region to match
> > the expected mapping behaviour (eg if a mapping is requested with memory
> > semantics, it must allow unaligned accesses).
> > 
> > Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> > them into two separate code paths:
> > 
> > acpi_os_memmap() -> memory semantics
> > acpi_os_ioremap() -> MMIO semantics
> > 
> > The split allows the architectural implementation back-ends to detect
> > the default memory attributes required by the mapping in question
> > (ie the mapping API defines the semantics memory vs MMIO) and map the
> > memory accordingly.
> > 
> > Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Ard Biesheuvel <ardb@kernel.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Hanjun Guo <guohanjun@huawei.com>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> For the arm64 bits:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> I presume this will get merged via the ACPI tree?

Thank you, I don't know what's the best option in Rafael's opinion
(of course if he is OK with the patches which are mostly touching
ACPI code).

Lorenzo
