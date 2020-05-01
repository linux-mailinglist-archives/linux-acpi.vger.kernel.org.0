Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5335F1C1022
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 11:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEAJDB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 05:03:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728159AbgEAJDB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 05:03:01 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 062B621973
        for <linux-acpi@vger.kernel.org>; Fri,  1 May 2020 09:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588323780;
        bh=UdjDLYW2XbhdiO1ICKPG0sn4bQLtbUlhsHoujrktrWw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T8m+QTx6hrVJDFpl0cq2YFejb7W4ox1MRy3/ZJI8FkXuSyVV3Oqk+co45UL/DmI2R
         SAQQqksmUpkYHFc1esk6O4pfdfgrmVDI3qc+x2Yy3OtGSQtGo5X+JnhA6L3++3Us3N
         LwRY4HnaGk+OYxTwJcNeXC+1LdM5Ct/W31TNlJ5c=
Received: by mail-il1-f171.google.com with SMTP id c18so3940823ile.5
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2020 02:02:59 -0700 (PDT)
X-Gm-Message-State: AGi0Puabyib7maEbrZBCp45tSjcqp6pXG852YpSQXarvAtoGgSEARKYd
        KRx6Xvw++6Cscpnma+IbyzNxzx/eQyG4hJXP+jk=
X-Google-Smtp-Source: APiQypJkoZql6j4GoNMviNq5a2Ssl9t7GbRgh9uGOBsuwEwS1JJGVXvgDbZ8utcPzFkJAbnhK83EfkIhwYMBAdB8qug=
X-Received: by 2002:a92:3c55:: with SMTP id j82mr2712575ila.258.1588323779330;
 Fri, 01 May 2020 02:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
 <20200117121448.GA8199@willie-the-truck> <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
 <CAKv+Gu-24EzfM+d7wBKUK7BC3gy+kQ2-T7CvemqtJsdQay7EjQ@mail.gmail.com> <20200501085404.GA3449@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200501085404.GA3449@e121166-lin.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 May 2020 11:02:48 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFULq=KpLA-n4KfpYqAJ2Rg96VDr-7awUnsTEVB5vq6Lg@mail.gmail.com>
Message-ID: <CAMj1kXFULq=KpLA-n4KfpYqAJ2Rg96VDr-7awUnsTEVB5vq6Lg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/IORT: Fix 'Number of IDs' handling in iort_id_map()
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Tyler Baicar <baicar@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, 1 May 2020 at 10:54, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, May 01, 2020 at 10:30:11AM +0200, Ard Biesheuvel wrote:
> > On Fri, 17 Jan 2020 at 13:32, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > On Fri, Jan 17, 2020 at 12:14:49PM +0000, Will Deacon wrote:
> > > > On Tue, Jan 14, 2020 at 08:14:11PM +0800, Hanjun Guo wrote:
> > > > > The IORT specification [0] (Section 3, table 4, page 9) defines the
> > > > > 'Number of IDs' as 'The number of IDs in the range minus one'.
> > > > >
> > > > > However, the IORT ID mapping function iort_id_map() treats the 'Number
> > > > > of IDs' field as if it were the full IDs mapping count, with the
> > > > > following check in place to detect out of boundary input IDs:
> > > > >
> > > > > InputID >= Input base + Number of IDs
> > > > >
> > > > > This check is flawed in that it considers the 'Number of IDs' field as
> > > > > the full number of IDs mapping and disregards the 'minus one' from
> > > > > the IDs count.
> > > > >
> > > > > The correct check in iort_id_map() should be implemented as:
> > > > >
> > > > > InputID > Input base + Number of IDs
> > > > >
> > > > > this implements the specification correctly but unfortunately it breaks
> > > > > existing firmwares that erroneously set the 'Number of IDs' as the full
> > > > > IDs mapping count rather than IDs mapping count minus one.
> > > > >
> > > > > e.g.
> > > > >
> > > > > PCI hostbridge mapping entry 1:
> > > > > Input base:  0x1000
> > > > > ID Count:    0x100
> > > > > Output base: 0x1000
> > > > > Output reference: 0xC4  //ITS reference
> > > > >
> > > > > PCI hostbridge mapping entry 2:
> > > > > Input base:  0x1100
> > > > > ID Count:    0x100
> > > > > Output base: 0x2000
> > > > > Output reference: 0xD4  //ITS reference
> > > > >
> > > > > Two mapping entries which the second entry's Input base = the first
> > > > > entry's Input base + ID count, so for InputID 0x1100 and with the
> > > > > correct InputID check in place in iort_id_map() the kernel would map
> > > > > the InputID to ITS 0xC4 not 0xD4 as it would be expected.
> > > > >
> > > > > Therefore, to keep supporting existing flawed firmwares, introduce a
> > > > > workaround that instructs the kernel to use the old InputID range check
> > > > > logic in iort_id_map(), so that we can support both firmwares written
> > > > > with the flawed 'Number of IDs' logic and the correct one as defined in
> > > > > the specifications.
> > > > >
> > > > > [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> > > > >
> > > > > Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > > Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
> > > > > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > > > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > > > Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > > > Cc: Will Deacon <will@kernel.org>
> > > > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > ---
> > > >
> > > > I'm a bit confused about the SoB chain here and which tree this is
> > > > targetting.
> > > >
> > > > Lorenzo?
> > >
> > > Hi Will,
> > >
> > > sorry about that. It targets arm64 - previously wasn't addressed
> > > to you and Catalin:
> > >
> > > https://lore.kernel.org/linux-arm-kernel/1577708824-4873-1-git-send-email-guohanjun@huawei.com/
> > >
> > > I rewrote the commit log and asked Hanjun to repost it to target an arm64
> > > merge.
> > >
> > > Having said that, this patch makes me nervous, it can break on platforms
> > > that have non-compliant firmware, I wonder whether it is best to leave
> > > it in -next for a whole cycle (I can send it to -next) to catch any
> > > fall-out rather than targeting v5.6 given that technically is _not_ a
> > > fix (we may even have to revert it - it requires coverage on all ARM64
> > > ACPI systems).
> > >
> > > What do you think ?
> > >
> >
> > I just ran into this while playing with the LX2160 I received this week.
>
> Side note: that firmware must be updatable or there is something I am
> missing in relation to the ongoing ITS/SMMU mapping discussions.
>

Sure. But they are following the spec, and they use num_ids = 0x0 for
regions consisting of a single mapping. This is completely broken
without this patch.

> > I wonder if it would be better to detect the failure case dynamically,
> > rather than having these hardcoded quirks. It should be rather
> > straightforward to detect overlaps at the edges of these multi-range
> > mappings, in which case we could just let the spurious one (living at
> > the end of the region) be superseded by the correct one (living at the
> > start of the next region).
>
> This could be done I think but probably requires some boot time parsing
> to create some structure defining ranges (to avoid running the logic you
> describe above every time a device has to be mapped).
>

It could be done much simpler than that: if iort_id_map() matches on
the last value of a region with size > 1 (so num_ids > 0), we return
the mapping but don't exit the loop. If we match it again, we use that
value, otherwise we use the tentative value from the first iteration.

> Given that I have not heard of any regressions on the existing crop
> of platforms and the one you mentioned has FW that is not set in stone
> I think we can live with the quirk mechanism for the time being,
> what do you think ?
>

The more quirks we keep, the harder it becomes to push back on new ones.

So if we can fix this cleanly, I'd much prefer it.
