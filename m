Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321D73F7BA9
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Aug 2021 19:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhHYRrS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Aug 2021 13:47:18 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34725 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbhHYRrR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Aug 2021 13:47:17 -0400
Received: by mail-ot1-f44.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso46287otp.1;
        Wed, 25 Aug 2021 10:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCtlcERoYNnbif+Y8zhh0368pArdTRgkUQL9JCAr/bg=;
        b=aU3+zl9Ig2KOMEVT6lqGqif9khEA4zJjDPFqkDkV/bOKNPOPSjCGfedxHo7TrAlSEA
         /XXeJLOgSYjRgWcu7ukW152rmTwX1nJPjAW/eScUfoKocta0E0bfwDwKVYMVdcAHDqEN
         Bqh/p/JtcjV7a4hTHzjd3eZUrVlMQdp6O/sIMv3GVJaBYOW9mgGd8CpGBFwky9GCeWpz
         vWjxA9/dDW0lsOOx9c82ReuTA0eSrdRc2VwCHLKaUo3HLQStmCqWCfCZyzojie1yuMGF
         3bNp9OPRztC5jpND0WWpahWJtSmZRbSJBdE9/3DNDwNF/iqwAUnMY1HXL4UWzna/gs+3
         A8hA==
X-Gm-Message-State: AOAM530lCMcyd7ry0zoUlUD5RnR/XbptUWTT2Da3V3rYrTazBDatiADI
        Cde/93OfWgocTmcsM5KNkZC7UTTdbGKTNRKXUuM=
X-Google-Smtp-Source: ABdhPJwoeMOzINNBvR+IsBC8Rp3PRgkA7Hhn/rQT6zvv0kkQFzdSIQX5dqxRXMbB/GrayCzX5YJnbcfGv2nDsGqM6ko=
X-Received: by 2002:a9d:a57:: with SMTP id 81mr24620521otg.260.1629913590155;
 Wed, 25 Aug 2021 10:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210802152359.12623-1-lorenzo.pieralisi@arm.com>
 <20210823104618.14552-1-lorenzo.pieralisi@arm.com> <20210823123052.GC8603@arm.com>
In-Reply-To: <20210823123052.GC8603@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Aug 2021 19:46:19 +0200
Message-ID: <CAJZ5v0g9_jq4xgHTkxX8WFGwTwmSUUMKkMUF2HadauWqGrLiHA@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] ACPI: Add memory semantics to acpi_os_map_memory()
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 23, 2021 at 2:31 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Aug 23, 2021 at 11:46:18AM +0100, Lorenzo Pieralisi wrote:
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
> > ---
> > Resending with all lists CC'ed.
> >
> > Patch series is a v3 of a previous version[2]:
> >
> > v2->v3:
> >       - Dropped first two-patches following LKML feedback[2]
> > v1->v2
> >       - Added patch 1 and 2 according to feedback received on[1]
> >
> > [1] https://lore.kernel.org/linux-acpi/20210726100026.12538-1-lorenzo.pieralisi@arm.com
> > [2] https://lore.kernel.org/linux-acpi/20210802152359.12623-1-lorenzo.pieralisi@arm.com
> >
> >  arch/arm64/include/asm/acpi.h |  3 +++
> >  arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
> >  drivers/acpi/osl.c            | 23 ++++++++++++++++-------
> >  include/acpi/acpi_io.h        |  8 ++++++++
> >  4 files changed, 43 insertions(+), 10 deletions(-)
>
> For arm64:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
> I presume this patch would go in via the acpi tree.

Applied as 5.15 material, thanks!
