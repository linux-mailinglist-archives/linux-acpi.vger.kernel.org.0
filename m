Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98133E9333
	for <lists+linux-acpi@lfdr.de>; Wed, 11 Aug 2021 16:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhHKOCc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 11 Aug 2021 10:02:32 -0400
Received: from foss.arm.com ([217.140.110.172]:51498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhHKOCb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 11 Aug 2021 10:02:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE76C1063;
        Wed, 11 Aug 2021 07:02:07 -0700 (PDT)
Received: from e123427-lin.cambridge.arm.com (unknown [10.57.39.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09CF3F718;
        Wed, 11 Aug 2021 07:02:04 -0700 (PDT)
Date:   Wed, 11 Aug 2021 15:01:57 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
Message-ID: <20210811140157.GA28658@e123427-lin.cambridge.arm.com>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
 <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> On Tue, 10 Aug 2021 at 18:46, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Aug 02, 2021 at 04:23:57PM +0100, Lorenzo Pieralisi wrote:
> > > Add a __force attribute to the void* cast in acpi_os_map_iomem()
> > > to prevent sparse warnings.
> >
> > Err, no.  These annotation are there for a reason and need to
> > be propagated instead.  And independent of that a __force cast
> > without a comment explaining it is a complete no-go.
> 
> The whole problem we are solving here is that ACPI, being based on
> x86, conflates MMIO mappings with memory mappings, and has been using
> the same underlying infrastructure for either. On arm64, this is not
> sufficient, given that the semantics of uncached memory vs device are
> different (the former permits unaligned accesses and clear cacheline
> instructions, but the latter doesn't). A recent optimization applied
> to memcpy() on arm64 (which now relies more on unaligned accesses for
> performance) has uncovered an issue where firmware tables being mapped
> non-cacheable by the ACPI core will end up using device mappings,
> which causes memcpy() to choke on their contents.
> 
> So propagating the annotation makes no sense, as we are creating a
> memory mapping using the iomem primitive. I wouldn't object to a
> comment being added, but I think the context should have been obvious
> to anyone who had bothered to look at the entire series.

I can add a comment and respin. Basically a __force attribute is
added to ignore a sparse warning that's been ignored for aeons
anyway - I will add the rationale above.

drivers/acpi/osl.c:379:17: warning: cast removes address space '__iomem' of expression
