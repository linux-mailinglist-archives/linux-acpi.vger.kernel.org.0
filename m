Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049E13ED1DA
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 12:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhHPKWe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 06:22:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230511AbhHPKWW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 16 Aug 2021 06:22:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B2BC61BA9;
        Mon, 16 Aug 2021 10:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629109309;
        bh=q6twPs/J3TsBUqyrvyOIIf0W/xvivZuTZtbkHTjpAEo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0gTHmMf+5GEEW+6EUdF5QXIm4i8RZY/9+/Y2Vx4nRXpYeL6idGh5I+NQH6gV3wHT
         A75ylTeXM/ZWiaw8isPOrt11XmFwpB2DyP+0gMXI/k56EQ7hgRtdIwzR1Dm88bf055
         jblww20ONVU7Y4QQn6L8jImw8y+3m9oP+kh4mRgPnPiQMlA+mxqEYsNFLwoMIattV/
         jp+l6QlVt+5+eyHHSj2lhhN3nGj5ZmehOnQV0OImH8O6DNDCf5fGkIeCQqcdQULgCj
         jFWvTfbYGVtO8NXqcOyr+TXBxbJnBxNuxRrrQdtLJsCKc8q2/VohL5CmSSkStECbcB
         +uHC2f19BMWyQ==
Received: by mail-ot1-f49.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so5390309otk.9;
        Mon, 16 Aug 2021 03:21:49 -0700 (PDT)
X-Gm-Message-State: AOAM532byncnJrcKWVqJxN6Y2+CSSsfOpuPN5z+brtsZslke9J5okxfL
        FQP7GV+4SAO1Hy49RYwTU3pNac6pFEYUiLdLXx0=
X-Google-Smtp-Source: ABdhPJxDyWfB3OorhOpr/8VkgJZzlutHFGK0QAZzwN0fSdOxyF1ToMppAoVNp0kDYFCWWURsbH7A8k7CndmDh+b1L1c=
X-Received: by 2002:a9d:5cb:: with SMTP id 69mr12478949otd.90.1629109308492;
 Mon, 16 Aug 2021 03:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com> <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
 <YRPZ2Kqb/MFggHzQ@infradead.org> <20210811145508.GA3650@lpieralisi> <20210816095854.GA2599@lpieralisi>
In-Reply-To: <20210816095854.GA2599@lpieralisi>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 16 Aug 2021 12:21:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
Message-ID: <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 16 Aug 2021 at 11:59, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, Aug 11, 2021 at 03:55:08PM +0100, Lorenzo Pieralisi wrote:
> > On Wed, Aug 11, 2021 at 03:08:24PM +0100, Christoph Hellwig wrote:
> > > On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> > > > The whole problem we are solving here is that ACPI, being based on
> > > > x86, conflates MMIO mappings with memory mappings, and has been using
> > > > the same underlying infrastructure for either.
> > >
> > > So let's fix that problem instead of papering over it.
> >
> > Patch (3) in this series is a fix - I would ask whether it makes
> > sense to merge patches (2-3) now and think about reworking the current
> > ACPI IO/MEM mapping API later, it can be an invasive change for a fix,
> > assuming we agree on how to rework the ACPI IO/MEM mapping API.
>
> What should we do then with this series ?
>

It is not even clear that reworking the ACPI core is feasible to begin
with, OTOH, fixing a sparse warning is arguably not a critical bug fix
either, so I'd suggest we just drop that bit.
