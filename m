Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D58D3E1BEF
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Aug 2021 21:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhHETCq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 5 Aug 2021 15:02:46 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:44021 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbhHETCp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Aug 2021 15:02:45 -0400
Received: by mail-oi1-f170.google.com with SMTP id bh26so7155396oib.10;
        Thu, 05 Aug 2021 12:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhAdb2Kihhg6rVG3uFDeKcl+JBG5IM2thW4aNaeXliY=;
        b=USHj5Jr1fJsBigcQGjfVD5kM6WsmDrVp6btFJWP+K2mT0ki6rycHU/IIhkjTNBtoog
         WqrQReFN5Vk1yrOiRXoX75SkbuggqvwAxSgNQty2JSr2JLsMbPdr6lB5BWBOEWRpcaRW
         IheHT95Tm3vbqEuBhsQZv78c0spv9I7ZTb1rrZ0zzGoBDWRUyQLKQcnshYBQRsOfnVbl
         AqHUQlSuvQnwtjIMWOuRQq53Dx8wIBx7EwqhRgnHTiv5Yo+SllSDGJOZUQACeMIPWpwZ
         MOz9U31qiJJa2u4Q1CipOUIQxsveUEa/ocfd+fr2Mv46dkukE33IwqYCZFhxPP0wFIKz
         TUJg==
X-Gm-Message-State: AOAM533YAzaaVQte17tW/yo/ybSpyWlqipwPYiCOOtNRYwPGdIEoOqXo
        UFsNwXrXXXjxlxPV+aj6aZ46QAAjXzdjPdLVqiA=
X-Google-Smtp-Source: ABdhPJxal+2hfkY2GCDIFlz0tFgaMCTJ8e8FxAgZveO2IVjKnwnmsi5xxZOnGFQssFG52p0/Loe7bbGcOFNVextj2GQ=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr4752045oib.71.1628190150002;
 Thu, 05 Aug 2021 12:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-4-lorenzo.pieralisi@arm.com> <20210802164622.GJ18685@arm.com>
 <20210803091605.GA9637@lpieralisi>
In-Reply-To: <20210803091605.GA9637@lpieralisi>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 5 Aug 2021 21:02:19 +0200
Message-ID: <CAJZ5v0jikZd_SMZxL0SAwVGH_-h8C9aUPH9LoG-PUFUZG3eLjA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI: Add memory semantics to acpi_os_map_memory()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 3, 2021 at 11:16 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Mon, Aug 02, 2021 at 05:46:22PM +0100, Catalin Marinas wrote:
> > On Mon, Aug 02, 2021 at 04:23:59PM +0100, Lorenzo Pieralisi wrote:
> > > The memory attributes attached to memory regions depend on architecture
> > > specific mappings.
> > >
> > > For some memory regions, the attributes specified by firmware (eg
> > > uncached) are not sufficient to determine how a memory region should be
> > > mapped by an OS (for instance a region that is define as uncached in
> > > firmware can be mapped as Normal or Device memory on arm64) and
> > > therefore the OS must be given control on how to map the region to match
> > > the expected mapping behaviour (eg if a mapping is requested with memory
> > > semantics, it must allow unaligned accesses).
> > >
> > > Rework acpi_os_map_memory() and acpi_os_ioremap() back-end to split
> > > them into two separate code paths:
> > >
> > > acpi_os_memmap() -> memory semantics
> > > acpi_os_ioremap() -> MMIO semantics
> > >
> > > The split allows the architectural implementation back-ends to detect
> > > the default memory attributes required by the mapping in question
> > > (ie the mapping API defines the semantics memory vs MMIO) and map the
> > > memory accordingly.
> > >
> > > Link: https://lore.kernel.org/linux-arm-kernel/31ffe8fc-f5ee-2858-26c5-0fd8bdd68702@arm.com
> > > Tested-by: Hanjun Guo <guohanjun@huawei.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Ard Biesheuvel <ardb@kernel.org>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Hanjun Guo <guohanjun@huawei.com>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > For the arm64 bits:
> >
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> >
> > I presume this will get merged via the ACPI tree?
>
> Thank you, I don't know what's the best option in Rafael's opinion
> (of course if he is OK with the patches which are mostly touching
> ACPI code).

Well, I can apply them.

I'll queue them up tomorrow, but next week I'm on vacation, so they
will show up in linux-next after -rc6.  Hopefully, that's not too
late.
