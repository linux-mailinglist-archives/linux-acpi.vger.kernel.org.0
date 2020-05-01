Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339521C0F83
	for <lists+linux-acpi@lfdr.de>; Fri,  1 May 2020 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgEAIaZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 1 May 2020 04:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbgEAIaY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 1 May 2020 04:30:24 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBE7C21924
        for <linux-acpi@vger.kernel.org>; Fri,  1 May 2020 08:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588321824;
        bh=CJNhGsCpd6AQPVX8P6NqaBV7vRnnyDedFup5oxfD/YY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpyOlVfibyZ1/AhCZU+5fcBkGQm6h4egfZDk5SBIz96/bbRK9slzNF67UkfXbTAic
         p7rGsw7jhm//qUYUqtA/7cKw1edRziN/oVxDSv1lPjIK23LJovBL9JNkyauWIQh/Os
         QLra+uEpVfPHrae/LIoUGme0lI68QklkUHLePACI=
Received: by mail-wr1-f46.google.com with SMTP id f13so10661486wrm.13
        for <linux-acpi@vger.kernel.org>; Fri, 01 May 2020 01:30:23 -0700 (PDT)
X-Gm-Message-State: AGi0Pua63B9P/MIpE32bsNx8XNnVFgtDwrH4VWZqhJbAo3WApaJq6dlZ
        yTJ0QketLzVGAi4K8/DFrpN4pduLtUh+z/JyC97s6Q==
X-Google-Smtp-Source: APiQypIEoE7lZmfaNRjexQvHHOulSLBq541VjjKRzYkC8E/9BVk2V6iByn/+BWZm6DjWOdlaBwt4QwywVIC2Z0PmYQk=
X-Received: by 2002:a5d:6145:: with SMTP id y5mr2947927wrt.126.1588321822377;
 Fri, 01 May 2020 01:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <1579004051-48797-1-git-send-email-guohanjun@huawei.com>
 <20200117121448.GA8199@willie-the-truck> <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200117123226.GA9918@e121166-lin.cambridge.arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 1 May 2020 10:30:11 +0200
X-Gmail-Original-Message-ID: <CAKv+Gu-24EzfM+d7wBKUK7BC3gy+kQ2-T7CvemqtJsdQay7EjQ@mail.gmail.com>
Message-ID: <CAKv+Gu-24EzfM+d7wBKUK7BC3gy+kQ2-T7CvemqtJsdQay7EjQ@mail.gmail.com>
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

On Fri, 17 Jan 2020 at 13:32, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Jan 17, 2020 at 12:14:49PM +0000, Will Deacon wrote:
> > On Tue, Jan 14, 2020 at 08:14:11PM +0800, Hanjun Guo wrote:
> > > The IORT specification [0] (Section 3, table 4, page 9) defines the
> > > 'Number of IDs' as 'The number of IDs in the range minus one'.
> > >
> > > However, the IORT ID mapping function iort_id_map() treats the 'Number
> > > of IDs' field as if it were the full IDs mapping count, with the
> > > following check in place to detect out of boundary input IDs:
> > >
> > > InputID >= Input base + Number of IDs
> > >
> > > This check is flawed in that it considers the 'Number of IDs' field as
> > > the full number of IDs mapping and disregards the 'minus one' from
> > > the IDs count.
> > >
> > > The correct check in iort_id_map() should be implemented as:
> > >
> > > InputID > Input base + Number of IDs
> > >
> > > this implements the specification correctly but unfortunately it breaks
> > > existing firmwares that erroneously set the 'Number of IDs' as the full
> > > IDs mapping count rather than IDs mapping count minus one.
> > >
> > > e.g.
> > >
> > > PCI hostbridge mapping entry 1:
> > > Input base:  0x1000
> > > ID Count:    0x100
> > > Output base: 0x1000
> > > Output reference: 0xC4  //ITS reference
> > >
> > > PCI hostbridge mapping entry 2:
> > > Input base:  0x1100
> > > ID Count:    0x100
> > > Output base: 0x2000
> > > Output reference: 0xD4  //ITS reference
> > >
> > > Two mapping entries which the second entry's Input base = the first
> > > entry's Input base + ID count, so for InputID 0x1100 and with the
> > > correct InputID check in place in iort_id_map() the kernel would map
> > > the InputID to ITS 0xC4 not 0xD4 as it would be expected.
> > >
> > > Therefore, to keep supporting existing flawed firmwares, introduce a
> > > workaround that instructs the kernel to use the old InputID range check
> > > logic in iort_id_map(), so that we can support both firmwares written
> > > with the flawed 'Number of IDs' logic and the correct one as defined in
> > > the specifications.
> > >
> > > [0]: http://infocenter.arm.com/help/topic/com.arm.doc.den0049d/DEN0049D_IO_Remapping_Table.pdf
> > >
> > > Reported-by: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > Link: https://lore.kernel.org/linux-acpi/20191215203303.29811-1-pankaj.bansal@nxp.com/
> > > Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> > > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Pankaj Bansal <pankaj.bansal@nxp.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > ---
> >
> > I'm a bit confused about the SoB chain here and which tree this is
> > targetting.
> >
> > Lorenzo?
>
> Hi Will,
>
> sorry about that. It targets arm64 - previously wasn't addressed
> to you and Catalin:
>
> https://lore.kernel.org/linux-arm-kernel/1577708824-4873-1-git-send-email-guohanjun@huawei.com/
>
> I rewrote the commit log and asked Hanjun to repost it to target an arm64
> merge.
>
> Having said that, this patch makes me nervous, it can break on platforms
> that have non-compliant firmware, I wonder whether it is best to leave
> it in -next for a whole cycle (I can send it to -next) to catch any
> fall-out rather than targeting v5.6 given that technically is _not_ a
> fix (we may even have to revert it - it requires coverage on all ARM64
> ACPI systems).
>
> What do you think ?
>

I just ran into this while playing with the LX2160 I received this week.

I wonder if it would be better to detect the failure case dynamically,
rather than having these hardcoded quirks. It should be rather
straightforward to detect overlaps at the edges of these multi-range
mappings, in which case we could just let the spurious one (living at
the end of the region) be superseded by the correct one (living at the
start of the next region).
