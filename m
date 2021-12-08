Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03DF646D463
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Dec 2021 14:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhLHNaQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Dec 2021 08:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLHNaQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2021 08:30:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473D9C061746
        for <linux-acpi@vger.kernel.org>; Wed,  8 Dec 2021 05:26:44 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so8418623edd.3
        for <linux-acpi@vger.kernel.org>; Wed, 08 Dec 2021 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oic/H0eibgpvYK9YlRVFzjs4buhurwdafqB6p7wt1gg=;
        b=gFTfP9zXMmGrM2fQKjzRKpDcpdgcs0u1wKFHppS43AcWEfJOB/qmIQiuj2/GXEozLK
         rCl+RaML6IMr2vPzt/o7Iv5n8UsZxbU+1km3N2ewuZEO2J9/NYH4K+4nrjD5M1u28h/W
         QXhMs21GnU+VIbl1Hr3dfrFpfDLDx46W4PIdjsb1snjzWfB208EMKS8uk93GTKCvG4vV
         5wJYlyihqzQJsiYimdLXEKhHI8YnZPLiBfM7ynuGG9p4JEb0gh/WQATN2B8csHoikwul
         NCYiJMZ3U7Gn7uaAv3ySJdlEuiXirC1qtxlm5Sp9SrPUT3rjvJu10yV689OB7ZK+OfCO
         aSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oic/H0eibgpvYK9YlRVFzjs4buhurwdafqB6p7wt1gg=;
        b=fbMNSDMoym/LmuQncWG1ZfxPmgB2MHUSH/dVqZxj1ESHcuK2og6uOCilW7mfjbpVT6
         ybL/SUcmrTnrSNHQV1uJNiMH1qLtiHi8EDWE9peFe+NT5SC/7qzKJ5Wx3jMxUufsvinh
         q36j9t1GGCqCsoe55oRFPTKXS7teJ4Pwfqjgf3j3qwF5VGly7UgWR+m3ZGD45PmWi2gp
         q338c9Jk8eOpPHj9P9kKEoz4O+olFS6VpZE06I/6LEJN9t80wI97kzHN4Gny7Hqvka9g
         h5rmvK64lVp8waloh3y9fhv/ygmdAP8p5z3b4ifQtj1Uic60UBJ9Rf+awCpL7wTcM+2L
         bWcA==
X-Gm-Message-State: AOAM5311Iwe8YL2dGR/cOoFExuczRr15/QBQeG6V6NRsP1f0djZ9khXX
        0/B+bl6LCTUY2yl8WSZBxM5BNA2V7Hrb4Ds5fyFlXQ==
X-Google-Smtp-Source: ABdhPJzSd5Fh649ioX+CtSM5HNKxQ3C5K8lO+Ao0towYG6kOtjW+E0DKdrHJ2Qs5Ond+R584IiGb92lM0V9J89dHunk=
X-Received: by 2002:a17:906:4fcc:: with SMTP id i12mr7336404ejw.309.1638970002737;
 Wed, 08 Dec 2021 05:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com> <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com> <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
 <20211208121854.GA7317@e123427-lin.cambridge.arm.com>
In-Reply-To: <20211208121854.GA7317@e123427-lin.cambridge.arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Wed, 8 Dec 2021 14:26:05 +0100
Message-ID: <CABdtJHvOo+xG3pp0U1LyEAKqeUdU68tXNFN3PZBhgKVe0N=fUA@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>,
        Steven Price <steven.price@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        yangyicong <yangyicong@huawei.com>,
        Sami Mujawar <Sami.Mujawar@arm.com>,
        Will Deacon <will@kernel.org>,
        wanghuiqiang <wanghuiqiang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 8, 2021 at 1:19 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Tue, Oct 12, 2021 at 10:00:24AM +0200, Jon Nettleton wrote:
> > On Mon, Oct 11, 2021 at 4:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 2021-10-09 08:06, Jon Nettleton wrote:
> > > [...]
> > > >>> +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> > > >>> +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> > > >>> +                     /*
> > > >>> +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> > > >>> +                      * normally used for allocated system memory that is
> > > >>> +                      * then used for device specific reserved regions.
> > > >>> +                      */
> > > >>> +                     prot |= IOMMU_CACHE;
> > > >>> +             } else {
> > > >>> +                     type = IOMMU_RESV_DIRECT;
> > > >>> +                     /*
> > > >>> +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> > > >>> +                      * for device memory like MSI doorbell.
> > > >>> +                      */
> > > >>> +                     prot |= IOMMU_MMIO;
> > > >>> +             }
> > > >>
> > > >> I'm not sure we ever got a definitive answer to this - does DPAA2
> > > >> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> > > >> make the fewest possible assumptions, since at this point it's basically
> > > >> just a stop-gap until we can fix the spec. It's become clear that we
> > > >> can't reliably rely on guessing attributes, so I'm not too fussed about
> > > >> theoretical cases that currently don't work (due to complete lack of RMR
> > > >> support) continuing to not work for the moment, as long as we can make
> > > >> the real-world cases we actually have work at all. Anything which only
> > > >> affects performance I'd rather leave until firmware can tell us what to do.
> > > >
> > > > Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
> > > > mappings.  DPAA2 is just one connected device.
> > >
> > > Apologies if I'm being overly loose with terminology there - my point of
> > > reference for this hardware is documentation for the old LS2080A, where
> > > the "DPAA2 Reference Manual" gives a strong impression that the MC is a
> > > component belonging to the overall DPAA2 architecture. Either way it
> > > technically stands to reason that the other DPAA2 components would only
> > > be usable if the MC itself works (unless I've been holding a major
> > > misconception about that for years as well).
> > >
> > > In the context of this discussion, please consider any reference I may
> > > make to bits of NXP's hardware to be shorthand for "the thing for which
> > > NXP have a vested interest in IORT RMRs".
> >
> > Ultimately the spec doesn't mention what IOMMU properties the regions
> > should have.
>
> It will have to and that's what we are working on.

Where is this being worked on?  I see no open tickets for this.

>
> > Even marking them as IOMMU_READ/WRITE is as much of an assumption as
> > using IOMMU_MMIO or IOMMU_CACHE. It just seems IOMMU_MMIO is the most
> > popular since all the examples use it for MSI doorbells in the
> > documentation.
>
> We don't merge code based on assumptions that can easily break because
> the specifications don't contemplate the details that are required.
>
> > I am interested why this concern is only being brought up at this point
> > on a patchset that has been on the mailing list for 8+ months?
>
> See above. We don't merge code that we know can break and is based on
> assumptions, we need to update the IORT specifications to make them
> cover all the use cases - in a predictable way - and that's what we are
> working on.

This is not really an answer to the question.  The latest version of the
IORT RMR spec was published in Feb 2021. Why was this issue not
brought up with Rev 1 of this patchset? Instead you have wasted
10 months of developer and customer time. This could have easily been
turned into a code first spec change request, which is a valid option
for ACPI changes.

>
> > This is based on a spec that has existed from Arm since 2020 with the
> > most recent revisions published in Feb 2021.  The lack of RMR support
> > in the kernel is affecting real world products, and the ability for
> > SystemReady ES certified systems from just fully working with recent
> > distributions.
>
> I answered above - if you have any questions please ask them, here,
> as far as Linux code is concerned.
>
> I understand this is taking a long time, it is also helping us
> understand all the possible use cases and how to cover them in
> a way that is maintainable in the long run.

Every month that this patchset has sat being unattended by the
maintainers is another kernel dev cycle missed, it is another
another distribution release where users need to add hackish
kernel command-line options to disable security features that
were forced on by default. Not to mention Linux is just one
platform. What if other platforms have already adopted the
existing spec? These are Arm specs and Arm maintainers and
yet nobody seems to agree on anything and absolutely nothing
has been achieved except wasting the time of Shameer, myself,
our companies, and our customers.

-Jon

>
> Thanks,
> Lorenzo
>
> > Even worse, is that without this patchset customers are forced to jump
> > through hoops to purposefully re-enable smmu bypass making their
> > systems less secure.
> >
> > How is this a good experience for customers of SystemReady hardware
> > when for any mainline distribution to work the first thing they have
> > to do is make their system less secure?
> >
> > -Jon
> >
> > >
> > > Thanks,
> > > Robin.
> >
