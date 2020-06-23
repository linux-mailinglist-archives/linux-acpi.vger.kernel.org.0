Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66432204C0C
	for <lists+linux-acpi@lfdr.de>; Tue, 23 Jun 2020 10:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731581AbgFWIQc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 23 Jun 2020 04:16:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731543AbgFWIQc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Jun 2020 04:16:32 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DF5420771
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2020 08:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592900191;
        bh=aXsCXLsXUmWEyMJxdacaFR+V3cnV0sQZuQjfpfAYPCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W8C9BCxzMShk9ypxL7jBUsO0bpz97YjR0yqVB1lWG68/dPPdjhYDeQOONWWrcS2S6
         hud637tepGFbgsOAK1v1RCfju8bEt7FuUjYDfywv0UnxiDdFwSifZx5VqNWAZ/T31e
         A9DCydv8cB9fnxWNItObS7zPE2XfebFW+cHOGNqI=
Received: by mail-ot1-f43.google.com with SMTP id v13so15723662otp.4
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2020 01:16:31 -0700 (PDT)
X-Gm-Message-State: AOAM532OrmS2DwwVki08rhOpKBgzGWF1HnrNHnn2VwJ+J2tBidoRAmp8
        yKEmQ+4KzNSdmmAOqtMrMifcnrdS9t+lzwBr76o=
X-Google-Smtp-Source: ABdhPJw+rmaojBMBU7eBhhOwcDhZDuXHLaBaD3nT7WXq4czKQbyUEfBBoRbviaQY8TUxPycNkfB8VPwfD60Pctvs638=
X-Received: by 2002:a9d:42e:: with SMTP id 43mr17213939otc.108.1592900190896;
 Tue, 23 Jun 2020 01:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200622092719.1380968-1-ardb@kernel.org> <20200623081303.GA3531@willie-the-truck>
In-Reply-To: <20200623081303.GA3531@willie-the-truck>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 23 Jun 2020 10:16:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFX5okSWZ8SgnOrbs7qVSS1A2kyL12UXQi8JcEWmcDb=w@mail.gmail.com>
Message-ID: <CAMj1kXFX5okSWZ8SgnOrbs7qVSS1A2kyL12UXQi8JcEWmcDb=w@mail.gmail.com>
Subject: Re: [RFC PATCH] arm64/acpi: disallow AML memory opregions to access
 kernel memory
To:     Will Deacon <will@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, 23 Jun 2020 at 10:13, Will Deacon <will@kernel.org> wrote:
>
> On Mon, Jun 22, 2020 at 11:27:19AM +0200, Ard Biesheuvel wrote:
> > ACPI provides support for SystemMemory opregions, to allow AML methods
> > to access MMIO registers of, e.g., GPIO controllers, or access reserved
> > regions of memory that are owned by the firmware.
> >
> > Currently, we also permit AML methods to access memory that is owned by
> > the kernel and mapped via the linear region, which does not seem to be
> > supported by a valid use case, and exposes the kernel's internal state
> > to AML methods that may be buggy and exploitable.
> >
> > So close the door on this, and simply reject AML remapping requests for
> > any memory that has a valid mapping in the linear region.
> >
> > Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >  arch/arm64/include/asm/acpi.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> > index a45366c3909b..18dcef4e6764 100644
> > --- a/arch/arm64/include/asm/acpi.h
> > +++ b/arch/arm64/include/asm/acpi.h
> > @@ -50,9 +50,9 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
> >  static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
> >                                           acpi_size size)
> >  {
> > -     /* For normal memory we already have a cacheable mapping. */
> > +     /* Don't allow access to kernel memory from AML code */
> >       if (memblock_is_map_memory(phys))
> > -             return (void __iomem *)__phys_to_virt(phys);
> > +             return NULL;
>
> I wonder if it would be better to poison this so that if we do see reports
> of AML crashes we'll know straight away that it tried to access memory
> mapped by the linear region, as opposed to some other NULL dereference.
>

We could just add a WARN_ONCE() here, no?

> Anyway, no objections to the idea. Be good for some of the usual ACPI
> suspects to check this doesn't blow up immediately, though.
>

Indeed, hence the RFC. Jason does have a point regarding the range
check, so I will try to do something about that and send a v2.
