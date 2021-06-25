Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A223B481F
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 19:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbhFYRWz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 25 Jun 2021 13:22:55 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42801 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYRWz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jun 2021 13:22:55 -0400
Received: by mail-oi1-f175.google.com with SMTP id s23so12064012oiw.9;
        Fri, 25 Jun 2021 10:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iQHYTvyd4a0AyeWeHM8/s+AdYzRSjG7DUNNZmMzSrVs=;
        b=rcU/CBtQzf1B9Ya3msGe6yHGtOlKhIP5HkS4Yr90WgxGD28XB5/Y9ddAy4HeHeh1JK
         nNLi/nhIyOGnTdv+LUHcBII7iTuSKYawXkEejnREjgBzkiz7yZ7oHlWACTyNDLjnvuMn
         jDjyvY0+P/sxOjRobaNCCowOOp4h4zKCNA5dsDY09HxCjSdgKhMBys3n4uWLiU9PxWQc
         INCaK757go6ziIsI1hB9gniR5SinYL2YtkbK31/mI4FZWAK8LeFXTtVUokKboKM7etYV
         nuf3Xc+9JTVXC58fDWQPYQr8wloqPd6fCBM0dfvWMcvehGJNVOZ4m5auZHr2Hmilti6u
         oovA==
X-Gm-Message-State: AOAM532zqY+WXysfI2A1SPWpqdKxWwUi0wZx8t8c0FbU1b9hYrzbDeFG
        VBYdAvqFAMEnjCIjg+donrP3tZyriNPHTY0iCA0=
X-Google-Smtp-Source: ABdhPJwviMtRjL4//xOjfoZkWyYtshQCaFM/jcVobJ3k3NM5Bk3nG1/Kf8yQOqfOuO5JQTsz5UFALVRC33pbcmDXe/w=
X-Received: by 2002:aca:f0d5:: with SMTP id o204mr9019606oih.71.1624641633957;
 Fri, 25 Jun 2021 10:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com> <CAPv3WKctDU7WOxHzeHc49-G_h42qX-pUpinJN2CVHNoRH86QHw@mail.gmail.com>
 <CAPv3WKf=ufj-RbqOKm3cjOQcG1PDAEAkVLdLQUkRK94=_vtj9w@mail.gmail.com>
In-Reply-To: <CAPv3WKf=ufj-RbqOKm3cjOQcG1PDAEAkVLdLQUkRK94=_vtj9w@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jun 2021 19:20:23 +0200
Message-ID: <CAJZ5v0j9eTL476N7FJ+-m0VpbCdtOQZkZBtgvQ__3U1Jvs_cPg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Add new 16550-compatible Serial Port Subtype
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Grzegorz Bernacki <gjb@semihalf.com>, upstream@semihalf.com,
        Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>,
        Jon Nettleton <jon@solid-run.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Robert Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 25, 2021 at 7:18 PM Marcin Wojtas <mw@semihalf.com> wrote:
>
> Hi,
>
> pon., 21 cze 2021 o 22:06 Marcin Wojtas <mw@semihalf.com> napisał(a):
> >
> > Apologies for the patch prefix, of course it's a first version and
> > unrelated to the networking subsystem.
> >
> > Best regards,
> > Marcin
> >
> >
> > pon., 21 cze 2021 o 22:05 Marcin Wojtas <mw@semihalf.com> napisał(a):
> > >
> > > The Microsoft Debug Port Table 2 (DBG2) specification revision
> > > May 31, 2017 adds support for 16550-compatible Serial Port
> > > Subtype with parameters defined in Generic Address Structure (GAS) [1]
> > >
> > > Add its support in SPCR parsing routine.
> > >
> > > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi-debug-port-table
> > >
> > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > ---
> > >  include/acpi/actbl1.h | 1 +
> > >  drivers/acpi/spcr.c   | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > > index ce59903c2695..f746012eba8d 100644
> > > --- a/include/acpi/actbl1.h
> > > +++ b/include/acpi/actbl1.h
> > > @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
> > >  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
> > >  #define ACPI_DBG2_ARM_DCC           0x000F
> > >  #define ACPI_DBG2_BCM2835           0x0010
> > > +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> > >
> > >  #define ACPI_DBG2_1394_STANDARD     0x0000
> > >
> > > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > > index 88460bacd5ae..25c2d0be953e 100644
> > > --- a/drivers/acpi/spcr.c
> > > +++ b/drivers/acpi/spcr.c
> > > @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon, bool enable_console)
> > >                 break;
> > >         case ACPI_DBG2_16550_COMPATIBLE:
> > >         case ACPI_DBG2_16550_SUBSET:
> > > +       case ACPI_DBG2_16550_WITH_GAS:
> > >                 uart = "uart";
> > >                 break;
> > >         default:
> > > --
>
> Do you have any comments / remarks to the patch?

Yes, I do, but I will get back to you next week.

Thanks!
