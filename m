Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDC046D68B
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Dec 2021 16:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhLHPPY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Dec 2021 10:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhLHPPX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Dec 2021 10:15:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97243C061746
        for <linux-acpi@vger.kernel.org>; Wed,  8 Dec 2021 07:11:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id v1so9531693edx.2
        for <linux-acpi@vger.kernel.org>; Wed, 08 Dec 2021 07:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N3yl9v2atpilSDgp9e8S6T68cXXaaZdtU6LZvrpjcbM=;
        b=CPS/QAob2L+Gi18nwuq6qFA+AIRa1j7Hixi5N0EIxPErClUtTUgrGZ8RAcY5/XNP19
         qstSpq8UK3xpRrNDb20jYMu9PI8vC3Ce/TVViJN5IbIDIuEyrY452QUAT03WvfDgYUZJ
         eSLIIQBNziq9uJR4zO8460E7oPsFoABSjNHuSDMI0uxqlp5Y78CuSH52CzLKvvyDEAyZ
         qLddtmBN4k8cbqPjQVYEppM8OjhkpVp6/NDbQXU4ay9TDxHRExlFBfOJbmkdEmGcILIb
         FDTmSdEgHCTnRDfKlyIPWKyVDyPnq7C5W/BFd2iWajydryA2/R0xdhaKJEML4mtdHrhy
         +OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N3yl9v2atpilSDgp9e8S6T68cXXaaZdtU6LZvrpjcbM=;
        b=8Jprn5rC3xU0ix0HHoIeVj1uCMhtMmLzjJ64uSo6wlmYed2rrLVV+/76z63ObrDxw6
         bmEwnEYZrfjYCkAVEOty2/CedGZkS7v5HolBrKnqVFe0rNYDW8O5SETnwehyzhkRye7n
         XQpsCyylCgaGmW4DhjHDLFKKDi5pKcq7QlzDwiiBXgqZGUVbFxGQ6wga6gEW4Qry/8Ka
         aUDP97f8EuBB/LcWxDB+jn1+ktMm7pIGKDM+hBixF6X6qwRHU3FPS4VD4vrLYsvYVAzg
         6IJFNdlzG3GNc2I9OJPvicOqrDYlEqUPe291djFIh0cPBH+3bwMBoQQjbV+JrNJoUWWX
         c6WQ==
X-Gm-Message-State: AOAM532mi2ciK4R8RvESTxQY6FnMUD9kRgMgur29U2r4Xb0klg0JNVhc
        vSLewqQDwZe+qMBduEvVfg9sV/BxHa9h8YZkXBZZeA==
X-Google-Smtp-Source: ABdhPJw+RBPuSMwIoUELluUHpcF5vz2y2SOiBJKHsLSueuCQHaQ+wd08UsfA39AmY2SoWbItXXs1NnsqYUe5HrHUdss=
X-Received: by 2002:a17:906:4791:: with SMTP id cw17mr8208331ejc.493.1638976308788;
 Wed, 08 Dec 2021 07:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com> <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com> <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
 <20211208121854.GA7317@e123427-lin.cambridge.arm.com> <CABdtJHvOo+xG3pp0U1LyEAKqeUdU68tXNFN3PZBhgKVe0N=fUA@mail.gmail.com>
 <b268f857-52a4-62fb-c748-176dc86769fb@arm.com>
In-Reply-To: <b268f857-52a4-62fb-c748-176dc86769fb@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Wed, 8 Dec 2021 16:11:10 +0100
Message-ID: <CABdtJHs=mo8a=Xm9Nf8aGaU-G4xbV5WNkV=Csb-m46y_y0BqPw@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Wed, Dec 8, 2021 at 3:37 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Jon,
>
> On 2021-12-08 13:26, Jon Nettleton wrote:
> [...]
> >>> Even marking them as IOMMU_READ/WRITE is as much of an assumption as
> >>> using IOMMU_MMIO or IOMMU_CACHE. It just seems IOMMU_MMIO is the most
> >>> popular since all the examples use it for MSI doorbells in the
> >>> documentation.
> >>
> >> We don't merge code based on assumptions that can easily break because
> >> the specifications don't contemplate the details that are required.
> >>
> >>> I am interested why this concern is only being brought up at this point
> >>> on a patchset that has been on the mailing list for 8+ months?
> >>
> >> See above. We don't merge code that we know can break and is based on
> >> assumptions, we need to update the IORT specifications to make them
> >> cover all the use cases - in a predictable way - and that's what we are
> >> working on.
> >
> > This is not really an answer to the question.  The latest version of the
> > IORT RMR spec was published in Feb 2021. Why was this issue not
> > brought up with Rev 1 of this patchset? Instead you have wasted
> > 10 months of developer and customer time. This could have easily been
> > turned into a code first spec change request, which is a valid option
> > for ACPI changes.
>
> It was only on v5 of the patchset - *six months* after the original RFC
> posting - that anyone even first started to question the initial
> assumptions made about attributes[1], and even then somebody familiar
> countered that it didn't appear to matter[2]. Sorry, but you don't get
> to U-turn and throw unjust shade at Arm for not being prescient.
>
> Yes, when those of us within Arm set out the initial RMR spec, an
> assumption was made that it seemed reasonable for an OS to simply pick
> some default strong memory type (Device or Normal-NC) and full
> permissions if it did need to map RMRs at stage 1. That spec was
> reviewed and published externally and no interested parties came forth
> asking "hey, what about attributes?". Linux patches were written around
> that assumption and proceeded through many rounds of review until we
> eventually received sufficient feedback to demonstrate that the
> assumption did not in fact hold well enough in general and there seemed
> to be a genuine need for RMR attributes, and at that point we started
> work on revising the spec.

Was it documented anywhere that the RMR spec mandated Device
or Normal-NC memory attributes? I have read through the spec
pretty thoroughly and not seen this requirement documented
anywhere. Also please feel free to point out where we can find information
regarding how the spec is being revised. I am on causeway and in
all the SC meetings and haven't seen this topic brought up at all.

>
> In the meantime, these patches have sat at v7 for four months - the
> *other* outstanding review comments have not been addressed; I still
> don't recall seeing an answer about whether LX2160 or anything else
> currently deployed actually *needs* cacheable mappings or whether it
> could muddle through with the IOMMU_MMIO assumption until proper "RMR
> v2" support arrived later; even if so, an interim workaround specific to
> LX2160 could have been proposed but hasn't. It is hardly reasonable to
> pretend that Arm or the upstream maintainers are responsible for a lack
> of development activity on the part of the submitters, no matter how
> much blatant misinformation is repeated on Twitter.

Oh the "other" comments where after 7 series of patches you decided
that the approach that was agreed upon on the mailing list was no longer
to your liking? Not to mention the month the patchset sat idle after initial
comments from Ard that were cleared up, when I pinged the thread
and it was ignored. If there was some sort of prompt response on the
threads by the maintainers with accurate information about why the
patches were being held up, or that they were working on a new
spec maybe developers would have bothered to push the patchset forward.
There is no misinformation on Twitter.  After 7 series on a patchset after
initial discussion that it would be designed so device-tree could leverage
the backend work, you just changed your mind, and basically sent
everything back to the start.  Meanwhile only now in this thread are we
finding out that the spec is getting re-worked again, which means that
we will need to update our firmware, and wait for someone to write patches
for the new spec, because guess what?... Arm didn't write the patches
for any of the initial specs.

Arm maintainers should be helping to find ways to get Arm "specifications",
integrated for SystemReady customers to use.  Instead we get delayed
responses, about right turns on the path of the patches, or just outright
ignored for a month at a time. Maybe if Arm developers had actually
written the patches when the spec was released there wouldn't have been
almost a year of wasted time by the hardware manufacturers actually
trying to build and deploy products.

-Jon

>
> Regards,
> Robin.
>
> [1]
> https://lore.kernel.org/linux-iommu/13c2499e-cc0c-d395-0d60-6c3437f206ac@nxp.com/
> [2]
> https://lore.kernel.org/linux-iommu/CABdtJHv2QBHNoWTyp51H-J_apc75imPj0FbrV70Tm8xuNjpiTA@mail.gmail.com/
>
> >>
> >>> This is based on a spec that has existed from Arm since 2020 with the
> >>> most recent revisions published in Feb 2021.  The lack of RMR support
> >>> in the kernel is affecting real world products, and the ability for
> >>> SystemReady ES certified systems from just fully working with recent
> >>> distributions.
> >>
> >> I answered above - if you have any questions please ask them, here,
> >> as far as Linux code is concerned.
> >>
> >> I understand this is taking a long time, it is also helping us
> >> understand all the possible use cases and how to cover them in
> >> a way that is maintainable in the long run.
> >
> > Every month that this patchset has sat being unattended by the
> > maintainers is another kernel dev cycle missed, it is another
> > another distribution release where users need to add hackish
> > kernel command-line options to disable security features that
> > were forced on by default. Not to mention Linux is just one
> > platform. What if other platforms have already adopted the
> > existing spec? These are Arm specs and Arm maintainers and
> > yet nobody seems to agree on anything and absolutely nothing
> > has been achieved except wasting the time of Shameer, myself,
> > our companies, and our customers.
> >
> > -Jon
> >
> >>
> >> Thanks,
> >> Lorenzo
> >>
> >>> Even worse, is that without this patchset customers are forced to jump
> >>> through hoops to purposefully re-enable smmu bypass making their
> >>> systems less secure.
> >>>
> >>> How is this a good experience for customers of SystemReady hardware
> >>> when for any mainline distribution to work the first thing they have
> >>> to do is make their system less secure?
> >>>
> >>> -Jon
> >>>
> >>>>
> >>>> Thanks,
> >>>> Robin.
> >>>
