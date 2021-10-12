Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7378D429F3B
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhJLIFz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 04:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhJLIDF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 04:03:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6385C061745
        for <linux-acpi@vger.kernel.org>; Tue, 12 Oct 2021 01:01:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p13so78376278edw.0
        for <linux-acpi@vger.kernel.org>; Tue, 12 Oct 2021 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfJZrcgRfPAygYP1cdVoz79nAFWF3P3lNeyc+uUIYy0=;
        b=2GavBjqfc+oauQ9xOAv56VtYHUSnaWMHkv3yliYOgbjt48jD3qN80dyj86rTmA5k4f
         K7rG4wq2/4PxHHkgurfbM+NLG0HbLsoHzGt3xS7DmUoKpgU9EuL/xptkDo9n2DqOl45m
         QmkwQPSDs9xEIuSnRiV00CtEm/tWfambYn38xUMR+41TOdUMUnL2qgZ27M/2dEQ2dzIM
         ovVxoXoX2lR+TCCLcNYigt7Rp2sji6rRSlD81bICT0h+ax6v2W/dWTezPVrirYHUKVRA
         lC53GgSbTN7E5wj7rGQBSJXy5SJQIyZSuZdx/nkilhum2cM4blcO5YdPTDe8N11l2xEX
         Ir/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfJZrcgRfPAygYP1cdVoz79nAFWF3P3lNeyc+uUIYy0=;
        b=cthQbNWF7oXFQf02e5d2PwzufOs+Y12MhTKmALgCLxrACw/wjFKZlmu4V8lAA1StQb
         8VLR/hrKtqW6dCo4h1WSwaX0yxJZmlm79xSBYhk9TS41GpNR3AI52xTkZzPYNaw8LHah
         8oCLOfD6NzzXYd+PpToRftNaDmhbZmrBa9ay/PS4U6XjZEaEoU+Ba6KizimLnqEY3sY+
         cx037UINd5TQFPCFwA1I92YHH3RD9vIhWahNVitQDhf9rinZ7d+je1RHOEDJ5kczcCiv
         MvF7Ay7AjGNSHJiWPi1DT3Iz3S20C3q0z017igXH1T9tPOTGj+a3Jw6F+fs4HxDFgrha
         oiZg==
X-Gm-Message-State: AOAM5311Hagl3TESlxNtUJcvPkUNocoH7/u0ADYnJny3kyltAvQ6bFhv
        Z9udC0y8gk8+2z6L/r4uG89ijpP9k7PoiJBVf5YKCA==
X-Google-Smtp-Source: ABdhPJyjgryazzbSrVkxnCARQE8G78mXqDfLQsroBl7jBnOTY8o6Kw5ZQHxSm1C864LdjD10IKOkyEedslIu0pOhgsA=
X-Received: by 2002:a17:906:52d6:: with SMTP id w22mr28980498ejn.248.1634025661043;
 Tue, 12 Oct 2021 01:01:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210805080724.480-1-shameerali.kolothum.thodi@huawei.com>
 <20210805080724.480-3-shameerali.kolothum.thodi@huawei.com>
 <e24df2a9-1332-0eb3-b52a-230662fe46ba@arm.com> <CABdtJHvY5XnQN7wgQ9D8Zcu-NgHRmaUMFPgaPGZwM+AhmVpULw@mail.gmail.com>
 <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
In-Reply-To: <3225875e-ebd9-6378-e92c-ed3894d8aedc@arm.com>
From:   Jon Nettleton <jon@solid-run.com>
Date:   Tue, 12 Oct 2021 10:00:24 +0200
Message-ID: <CABdtJHsOShKrRMp33JvbVKuTMLEcHQKaDw0wtZ0igoeGeWJTQg@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] ACPI/IORT: Add support for RMR node parsing
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
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

On Mon, Oct 11, 2021 at 4:04 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-10-09 08:06, Jon Nettleton wrote:
> [...]
> >>> +             if (rmr->flags & IOMMU_RMR_REMAP_PERMITTED) {
> >>> +                     type = IOMMU_RESV_DIRECT_RELAXABLE;
> >>> +                     /*
> >>> +                      * Set IOMMU_CACHE as IOMMU_RESV_DIRECT_RELAXABLE is
> >>> +                      * normally used for allocated system memory that is
> >>> +                      * then used for device specific reserved regions.
> >>> +                      */
> >>> +                     prot |= IOMMU_CACHE;
> >>> +             } else {
> >>> +                     type = IOMMU_RESV_DIRECT;
> >>> +                     /*
> >>> +                      * Set IOMMU_MMIO as IOMMU_RESV_DIRECT is normally used
> >>> +                      * for device memory like MSI doorbell.
> >>> +                      */
> >>> +                     prot |= IOMMU_MMIO;
> >>> +             }
> >>
> >> I'm not sure we ever got a definitive answer to this - does DPAA2
> >> actually go wrong if we use IOMMU_MMIO here? I'd still much prefer to
> >> make the fewest possible assumptions, since at this point it's basically
> >> just a stop-gap until we can fix the spec. It's become clear that we
> >> can't reliably rely on guessing attributes, so I'm not too fussed about
> >> theoretical cases that currently don't work (due to complete lack of RMR
> >> support) continuing to not work for the moment, as long as we can make
> >> the real-world cases we actually have work at all. Anything which only
> >> affects performance I'd rather leave until firmware can tell us what to do.
> >
> > Well it isn't DPAA2, it is FSL_MC_BUS that fails with IOMMU_MMIO
> > mappings.  DPAA2 is just one connected device.
>
> Apologies if I'm being overly loose with terminology there - my point of
> reference for this hardware is documentation for the old LS2080A, where
> the "DPAA2 Reference Manual" gives a strong impression that the MC is a
> component belonging to the overall DPAA2 architecture. Either way it
> technically stands to reason that the other DPAA2 components would only
> be usable if the MC itself works (unless I've been holding a major
> misconception about that for years as well).
>
> In the context of this discussion, please consider any reference I may
> make to bits of NXP's hardware to be shorthand for "the thing for which
> NXP have a vested interest in IORT RMRs".

Ultimately the spec doesn't mention what IOMMU properties the regions
should have.  Even marking them as IOMMU_READ/WRITE is as much
of an assumption as using IOMMU_MMIO or IOMMU_CACHE. It just seems
IOMMU_MMIO is the most popular since all the examples use it for MSI
doorbells in the documentation.

I am interested why this concern is only being brought up at this point
in a patchset that has been on the mailing list for 8+ months?  This is
based on a spec that has existed from Arm since 2020 with the most recent
revisions published in Feb 2021.  The lack of RMR support in the kernel
is affecting real world products, and the ability for SystemReady ES
certified systems from just fully working with recent distributions.  Even
worse, is that without this patchset customers are forced to jump through
hoops to purposefully re-enable smmu bypass making their systems less
secure.

How is this a good experience for customers of SystemReady hardware
when for any mainline distribution to work the first thing they have to do is
make their system less secure?

-Jon

>
> Thanks,
> Robin.
