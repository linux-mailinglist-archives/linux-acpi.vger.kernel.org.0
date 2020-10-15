Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CC928F814
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Oct 2020 20:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgJOSDs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Oct 2020 14:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgJOSDs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 15 Oct 2020 14:03:48 -0400
Received: from gaia (unknown [95.149.105.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEC820797;
        Thu, 15 Oct 2020 18:03:43 +0000 (UTC)
Date:   Thu, 15 Oct 2020 19:03:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        robh+dt@kernel.org, hch@lst.de, ardb@kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 7/8] arm64: mm: Set ZONE_DMA size based on early IORT
 scan
Message-ID: <20201015180340.GB2624@gaia>
References: <20201014191211.27029-1-nsaenzjulienne@suse.de>
 <20201014191211.27029-8-nsaenzjulienne@suse.de>
 <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3df60a-4568-cb72-db62-36127d0ffb7e@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 10:26:18PM +0800, Hanjun Guo wrote:
> On 2020/10/15 3:12, Nicolas Saenz Julienne wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> > 
> > We recently introduced a 1 GB sized ZONE_DMA to cater for platforms
> > incorporating masters that can address less than 32 bits of DMA, in
> > particular the Raspberry Pi 4, which has 4 or 8 GB of DRAM, but has
> > peripherals that can only address up to 1 GB (and its PCIe host
> > bridge can only access the bottom 3 GB)
> > 
> > Instructing the DMA layer about these limitations is straight-forward,
> > even though we had to fix some issues regarding memory limits set in
> > the IORT for named components, and regarding the handling of ACPI _DMA
> > methods. However, the DMA layer also needs to be able to allocate
> > memory that is guaranteed to meet those DMA constraints, for bounce
> > buffering as well as allocating the backing for consistent mappings.
> > 
> > This is why the 1 GB ZONE_DMA was introduced recently. Unfortunately,
> > it turns out the having a 1 GB ZONE_DMA as well as a ZONE_DMA32 causes
> > problems with kdump, and potentially in other places where allocations
> > cannot cross zone boundaries. Therefore, we should avoid having two
> > separate DMA zones when possible.
> > 
> > So let's do an early scan of the IORT, and only create the ZONE_DMA
> > if we encounter any devices that need it. This puts the burden on
> > the firmware to describe such limitations in the IORT, which may be
> > redundant (and less precise) if _DMA methods are also being provided.
> > However, it should be noted that this situation is highly unusual for
> > arm64 ACPI machines. Also, the DMA subsystem still gives precedence to
> > the _DMA method if implemented, and so we will not lose the ability to
> > perform streaming DMA outside the ZONE_DMA if the _DMA method permits
> > it.
> 
> Sorry, I'm still a little bit confused. With this patch, if we have
> a device which set the right _DMA method (DMA size >= 32), but with the
> wrong DMA size in IORT, we still have the ZONE_DMA created which
> is actually not needed?

With the current kernel, we get a ZONE_DMA already with an arbitrary
size of 1GB that matches what RPi4 needs. We are trying to eliminate
such unnecessary ZONE_DMA based on some heuristics (well, something that
looks "better" than a OEM ID based quirk). Now, if we learn that IORT
for platforms in the field is that broken as to describe few bits-wide
DMA masks, we may have to go back to the OEM ID quirk.

-- 
Catalin
