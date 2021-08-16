Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F9D3ED840
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 16:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhHPOAp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 10:00:45 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44778 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhHPN7y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 09:59:54 -0400
Received: by mail-oi1-f172.google.com with SMTP id w6so26702841oiv.11;
        Mon, 16 Aug 2021 06:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XVC/6gEUhU4vuXQZAwgAC2E+AXjHkZw8kmCwwJT5EkY=;
        b=o/meJLg2KkDJCYyiLCtWNi/xp4tMAeJFU4ojzVzTzLvSr2yK4E7KYaUMgrm2W73CDp
         gFZBwwjXv3XUxkONbauz3OT8c+GtX8K32jLtaLoCrn9Bie5aczrX+jSCC3XSVcse6csb
         2LPokq5h0z6vnIKCTztMFXLpW6/oBJ3DHsjkQvNmCOy89TKJYHHz+lxaYoGbvVTlehia
         GUIcokyRB2CbSVKtuzVKYqCHYV/5RMCvXQ6BKKo8WEoQ4iJFKFuZsFEOPiRTxo4YdFSr
         dZufibB96H6M97pnJRK+PYKy76SamCL9dC5F+E7xotQc0C8roS+IKr1NPWaNGaOYaKR/
         TG0A==
X-Gm-Message-State: AOAM532d/QDOe/ZmkWcvStc+ZokQUbmKnjp/JzdsPKR1aSCRgtgfUrHn
        vDtyTrADeuJPS8N9POd6uE+gQawxee2ChKx0gS8=
X-Google-Smtp-Source: ABdhPJyPgh9rmvAjz/JQaNbgjqpHiYubxebOtNNiEu+tbqf7o2TwycD9Yo4s0S/HWKi7unIB8UtE76WdXOPSeDIPtcg=
X-Received: by 2002:a05:6808:10c1:: with SMTP id s1mr1029801ois.69.1629122300340;
 Mon, 16 Aug 2021 06:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com>
 <20210802152359.12623-2-lorenzo.pieralisi@arm.com> <YRKtEDycefrZLB3X@infradead.org>
 <CAMj1kXEB1CFj1svCWu7yOoUi_OkEqYEUQnB_XWOd3gD+ejO_6w@mail.gmail.com>
 <YRPZ2Kqb/MFggHzQ@infradead.org> <20210811145508.GA3650@lpieralisi>
 <20210816095854.GA2599@lpieralisi> <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
In-Reply-To: <CAMj1kXHM8tG2f-i6u8Ohb0RV9XTqq2N1Oooz_Q2kvLpdfTMxqw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 15:57:54 +0200
Message-ID: <CAJZ5v0jp_cQ4gvd6TGO6dSgGtCuuEEpkmArxMMe0tcgoZAbSdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: osl: Add __force attribute in
 acpi_os_map_iomem() cast
To:     Ard Biesheuvel <ardb@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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

On Mon, Aug 16, 2021 at 12:22 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Mon, 16 Aug 2021 at 11:59, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Wed, Aug 11, 2021 at 03:55:08PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Aug 11, 2021 at 03:08:24PM +0100, Christoph Hellwig wrote:
> > > > On Wed, Aug 11, 2021 at 12:40:28PM +0200, Ard Biesheuvel wrote:
> > > > > The whole problem we are solving here is that ACPI, being based on
> > > > > x86, conflates MMIO mappings with memory mappings, and has been using
> > > > > the same underlying infrastructure for either.
> > > >
> > > > So let's fix that problem instead of papering over it.
> > >
> > > Patch (3) in this series is a fix - I would ask whether it makes
> > > sense to merge patches (2-3) now and think about reworking the current
> > > ACPI IO/MEM mapping API later, it can be an invasive change for a fix,
> > > assuming we agree on how to rework the ACPI IO/MEM mapping API.
> >
> > What should we do then with this series ?
> >
>
> It is not even clear that reworking the ACPI core is feasible to begin
> with, OTOH, fixing a sparse warning is arguably not a critical bug fix
> either, so I'd suggest we just drop that bit.

So I'm assuming that one more iteration of this series will be posted.
