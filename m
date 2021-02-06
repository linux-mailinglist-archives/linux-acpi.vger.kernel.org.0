Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286DF311C18
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 09:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBFILR (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Feb 2021 03:11:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:53428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhBFILN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 6 Feb 2021 03:11:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CF8E64FD6;
        Sat,  6 Feb 2021 08:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612599032;
        bh=/BF/s61QDvT4oGsaXBL7qxBGoPv1gu0wNk6KP39BBvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MAPIgso2qJJ5tqqxtliaY6VdwIlivhDJ+jUGr0ZkR6sWEHeYy25TIS6vhFzM/5BIZ
         0xOu4OH+CWb4FDysxnbRJsGi34QRN3WmGt1kfqXXThCQgwI11t7PltnYHkOEhYY5Bj
         qfh0aSNScqyd5zDcg2RS+rbHDb/e48Vx7me7mDM9AByqtMMnga5ekp1VmGV5+WCRsL
         h0j0EFWLlM9XU133vzA0yqLRnTVGBp38PFPBjidT92EJOx7RpwUImddmInCGKjSNHC
         cijAHphYs+rtNSvQfFxybORTjsBqC8pclLWAbgInF2YK/MQmJ1tE1MAzdq1LuaiK5u
         P+IIu0sz4qhMQ==
Received: by mail-ot1-f51.google.com with SMTP id y11so9327176otq.1;
        Sat, 06 Feb 2021 00:10:32 -0800 (PST)
X-Gm-Message-State: AOAM533XALLia7gKuKyhnngE733E6q+lufzCm59kbGdPJLumT8CvYz6r
        n5pnKQCmoJf6JL/cxVnw7eeKVen1YEGnQfznf1w=
X-Google-Smtp-Source: ABdhPJwAaCLSqHaW66O9yAzs2WLP+cDwtnC1zOLfF+9sbsnLezO5f5YYWBIcDZocwo6NAJ6w+emwDsxRl0aGdzF2JZo=
X-Received: by 2002:a05:6830:1e2a:: with SMTP id t10mr6170595otr.90.1612599031222;
 Sat, 06 Feb 2021 00:10:31 -0800 (PST)
MIME-Version: 1.0
References: <20200626155832.2323789-1-ardb@kernel.org> <20200626155832.2323789-3-ardb@kernel.org>
 <20210206031145.GA27503@dragon>
In-Reply-To: <20210206031145.GA27503@dragon>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 6 Feb 2021 09:10:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHSkBcSDuHbsFMJjC89JrO8TxYUoabDmWerNp27s45Ngw@mail.gmail.com>
Message-ID: <CAMj1kXHSkBcSDuHbsFMJjC89JrO8TxYUoabDmWerNp27s45Ngw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64/acpi: disallow writeable AML opregion
 mapping for EFI code regions
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, 6 Feb 2021 at 04:11, Shawn Guo <shawn.guo@linaro.org> wrote:
>
> Hi Ard,
>
> On Fri, Jun 26, 2020 at 05:58:32PM +0200, Ard Biesheuvel wrote:
> > Given that the contents of EFI runtime code and data regions are
> > provided by the firmware, as well as the DSDT, it is not unimaginable
> > that AML code exists today that accesses EFI runtime code regions using
> > a SystemMemory OpRegion. There is nothing fundamentally wrong with that,
> > but since we take great care to ensure that executable code is never
> > mapped writeable and executable at the same time, we should not permit
> > AML to create writable mapping.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>
> I'm booting Lenovo Flex 5G laptop with ACPI, and seeing this change
> causes a memory abort[1] when upgrading ACPI tables via initrd[2].
> Dropping this change seems to fix the issue for me.  But does that
> looks like a correct fix to you?
>
> Shawn
>
> [1] https://fileserver.linaro.org/s/iDe9SaZeNNkyNxG
> [2] Documentation/admin-guide/acpi/initrd_table_override.rst
>

Can you check whether reverting

32cf1a12cad43358e47dac8014379c2f33dfbed4

fixes the issue too?

If it does, please report this as a regression. The OS should not
modify firmware provided tables in-place, regardless of how they were
delivered.

BTW I recently started using my Yoga C630 with Debian, and I am quite
happy with it! Thanks a lot for spending the time on the installer
etc.

I have observed some issues while using mine - I'm happy to share
them, on a mailing list or anywhere else.



> > ---
> >  arch/arm64/kernel/acpi.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
> > index 01b861e225b0..455966401102 100644
> > --- a/arch/arm64/kernel/acpi.c
> > +++ b/arch/arm64/kernel/acpi.c
> > @@ -301,6 +301,15 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
> >                       pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
> >                       return NULL;
> >
> > +             case EFI_RUNTIME_SERVICES_CODE:
> > +                     /*
> > +                      * This would be unusual, but not problematic per se,
> > +                      * as long as we take care not to create a writable
> > +                      * mapping for executable code.
> > +                      */
> > +                     prot = PAGE_KERNEL_RO;
> > +                     break;
> > +
> >               case EFI_ACPI_RECLAIM_MEMORY:
> >                       /*
> >                        * ACPI reclaim memory is used to pass firmware tables
> > --
> > 2.27.0
