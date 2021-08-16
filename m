Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638893ED175
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 11:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhHPJ7d (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 05:59:33 -0400
Received: from foss.arm.com ([217.140.110.172]:42214 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhHPJ7d (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 05:59:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F9F6D;
        Mon, 16 Aug 2021 02:59:01 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F163F40C;
        Mon, 16 Aug 2021 02:59:00 -0700 (PDT)
Date:   Mon, 16 Aug 2021 10:58:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
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
Message-ID: <20210816095854.GA2599@lpieralisi>
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com>
 <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
 <YRPZ2Kqb/MFggHzQ@infradead.org>
 <20210811145508.GA3650@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811145508.GA3650@lpieralisi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Aug 11, 2021 at 03:55:08PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Aug 11, 2021 at 03:08:24PM +0100, Christoph Hellwig wrote:
> > On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> > > The whole problem we are solving here is that ACPI, being based on
> > > x86, conflates MMIO mappings with memory mappings, and has been using
> > > the same underlying infrastructure for either.
> > 
> > So let's fix that problem instead of papering over it.
> 
> Patch (3) in this series is a fix - I would ask whether it makes
> sense to merge patches (2-3) now and think about reworking the current
> ACPI IO/MEM mapping API later, it can be an invasive change for a fix,
> assuming we agree on how to rework the ACPI IO/MEM mapping API.

What should we do then with this series ?

Thanks,
Lorenzo
