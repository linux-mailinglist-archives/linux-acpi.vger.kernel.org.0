Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8388C28B19C
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Oct 2020 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgJLJa5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Oct 2020 05:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJa4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 12 Oct 2020 05:30:56 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D811C208B6
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 09:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602495056;
        bh=jXNGarK7xqv4fXaRCcbqZJvIyIbGfZXmjWodnU8jsNI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b9c2yhroyCUMH503COMX1EhHfLwyiUhxjnGHtN7nODVgVpbOBA0FO5DyQQsesGjpD
         kJ5OOMX8q9pOJODLKwF1i80mtWkJCrKEJyfjX40N46fJD8NjtCg47zrQaJkKH1tzD8
         3d55xklTWDJ4CQlzQkCk00HxcK7Ndo8R+45ZesN8=
Received: by mail-ot1-f52.google.com with SMTP id m11so15237723otk.13
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2020 02:30:55 -0700 (PDT)
X-Gm-Message-State: AOAM532bxIQJBUXywdl8QJ6VzMmNVZKuxZFJbCIw4vXfnsyLy/o3//FN
        ++nsG0OolyXi/d+ddNqGEwG0jCIPgCby1sKWkVU=
X-Google-Smtp-Source: ABdhPJxk9RNK8BvLkloJ8dx/oKbZHAjjdfpKwYc+lBLkbc0vIsK9xi0Jk6Nai41+QFSQBsgunpXgTDZlKMK/Lc6RrYg=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr18826344otq.77.1602495055077;
 Mon, 12 Oct 2020 02:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20201010093153.30177-1-ardb@kernel.org> <20201012092821.GB9844@gaia>
In-Reply-To: <20201012092821.GB9844@gaia>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 12 Oct 2020 11:30:44 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
Message-ID: <CAMj1kXFej2jM_rRSEuRgyQ0W2A9eK=obBfaeNdvWZjydf2RJeg@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: set ZONE_DMA size based on early IORT scan
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 12 Oct 2020 at 11:28, Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Oct 10, 2020 at 11:31:53AM +0200, Ard Biesheuvel wrote:
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index f0599ae73b8d..829fa63c3d72 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -191,6 +191,14 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max)
> >       unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
> >
> >  #ifdef CONFIG_ZONE_DMA
> > +     if (IS_ENABLED(CONFIG_ACPI)) {
> > +             extern unsigned int acpi_iort_get_zone_dma_size(void);
>
> Nitpick: can we add this prototype to include/linux/acpi_iort.h?
>
> > +
> > +             zone_dma_bits = min(zone_dma_bits,
> > +                                 acpi_iort_get_zone_dma_size());
> > +             arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> > +     }
> > +
> >       max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>
> I think we should initialise zone_dma_bits slightly earlier via
> arm64_memblock_init(). We'll eventually have reserve_crashkernel()
> called before this and it will make use of arm64_dma_phys_limit for
> "low" reservations:
>
> https://lore.kernel.org/linux-arm-kernel/20200907134745.25732-7-chenzhou10@huawei.com/
>

We don't have access to the ACPI tables yet at that point.
