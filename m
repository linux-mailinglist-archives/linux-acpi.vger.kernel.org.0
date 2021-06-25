Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC83B4827
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbhFYRY0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 13:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYRY0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jun 2021 13:24:26 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46586C061766
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 10:22:05 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id bj15so19832959qkb.11
        for <linux-acpi@vger.kernel.org>; Fri, 25 Jun 2021 10:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2z0hYR4qZDbPeXnuWj9Is6jWI/yIGVyr6fyPfLsmt7Y=;
        b=UN5Lh9ANhla6VN4F1QD8w1JeDJNi4VxG9hzPq+Db++QzK085kjPr2giQmAS7BFAvU7
         iesC9u+njajQui/3/2KKB1hiENfpQuzchXodvLJZ/kQk3cRAiR/OSuu3SyMMiwtUJ3ZR
         jyszWtuI0FKJU2b++uXmaLSXyfyP5Gjjhdp1sBfMCmEuwSy3LuJbpmULvNIxHpqV2aGa
         1uQ28lB3QQ+OAD7pVpI8k1G8GMYf5qHru8jXFeDgbS2JfFiAZJtNsQUpxfzM0zHr8I7M
         t0QEvUefo7FHbJvEN6RRee6jeHWl7pkpQyubkh6pbQQS/7qhA64rLl29u+q522VH53TY
         a81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2z0hYR4qZDbPeXnuWj9Is6jWI/yIGVyr6fyPfLsmt7Y=;
        b=XSjk0BdkQKJGKlBCTDMxwSMHFeGvzv+8B90SuLpyigytn4jN2inFicVKgAcjxy6kpi
         ngB539ItsYsCb0dMRVy4R9PEczAwW1fixlaosYXpjQxUVR/VRtHOVmsskpejkAyPNVE1
         u9IOAt3hdSAOMnsJ+kd9qgabY2F8I1r7vvgCCAzPlCn8DLsc1z1G5TJFcDzwUjYT/hIy
         Ua5CpPpsvhiGivcBXQR5Q+kRS/LAyrEuhjuuhsY971luynu0s2f7QcbPAVNpd2f3eCLy
         5IeowUCNZiaWeDXWHxrEQGsc7LXHLRJGLVb3meG4vbeWJ1UkoeuixZ07CRWWSdr93zhf
         fBXQ==
X-Gm-Message-State: AOAM531Ab0tl38jPNilx3ElspbXfMjtrlkjkC9w7e7AvkYcMWkUXeAJi
        7SDaGdURwUf76+N13jgDYXT3By8VugMiGlzu6ghxBQ==
X-Google-Smtp-Source: ABdhPJx1K3VjsapFQagfcpO4ZS4XXTSvptTptw/Ju5J4GN1SnoVtiC+IrNTvcH5sjs2m0z3X7zeEHviTf0MC4UJ+ljg=
X-Received: by 2002:a37:311:: with SMTP id 17mr11694250qkd.295.1624641724420;
 Fri, 25 Jun 2021 10:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210621200459.3558199-1-mw@semihalf.com> <CAPv3WKctDU7WOxHzeHc49-G_h42qX-pUpinJN2CVHNoRH86QHw@mail.gmail.com>
 <CAPv3WKf=ufj-RbqOKm3cjOQcG1PDAEAkVLdLQUkRK94=_vtj9w@mail.gmail.com> <CAJZ5v0j9eTL476N7FJ+-m0VpbCdtOQZkZBtgvQ__3U1Jvs_cPg@mail.gmail.com>
In-Reply-To: <CAJZ5v0j9eTL476N7FJ+-m0VpbCdtOQZkZBtgvQ__3U1Jvs_cPg@mail.gmail.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Fri, 25 Jun 2021 19:21:52 +0200
Message-ID: <CAPv3WKeuL7GZRrs2XGuyoXsf6x=6S0_gROpq0H3YZKykUJFKxg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: SPCR: Add new 16550-compatible Serial Port Subtype
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

pt., 25 cze 2021 o 19:20 Rafael J. Wysocki <rafael@kernel.org> napisa=C5=82=
(a):
>
> On Fri, Jun 25, 2021 at 7:18 PM Marcin Wojtas <mw@semihalf.com> wrote:
> >
> > Hi,
> >
> > pon., 21 cze 2021 o 22:06 Marcin Wojtas <mw@semihalf.com> napisa=C5=82(=
a):
> > >
> > > Apologies for the patch prefix, of course it's a first version and
> > > unrelated to the networking subsystem.
> > >
> > > Best regards,
> > > Marcin
> > >
> > >
> > > pon., 21 cze 2021 o 22:05 Marcin Wojtas <mw@semihalf.com> napisa=C5=
=82(a):
> > > >
> > > > The Microsoft Debug Port Table 2 (DBG2) specification revision
> > > > May 31, 2017 adds support for 16550-compatible Serial Port
> > > > Subtype with parameters defined in Generic Address Structure (GAS) =
[1]
> > > >
> > > > Add its support in SPCR parsing routine.
> > > >
> > > > [1] https://docs.microsoft.com/en-us/windows-hardware/drivers/bring=
up/acpi-debug-port-table
> > > >
> > > > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > > > ---
> > > >  include/acpi/actbl1.h | 1 +
> > > >  drivers/acpi/spcr.c   | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> > > > index ce59903c2695..f746012eba8d 100644
> > > > --- a/include/acpi/actbl1.h
> > > > +++ b/include/acpi/actbl1.h
> > > > @@ -498,6 +498,7 @@ struct acpi_dbg2_device {
> > > >  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
> > > >  #define ACPI_DBG2_ARM_DCC           0x000F
> > > >  #define ACPI_DBG2_BCM2835           0x0010
> > > > +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> > > >
> > > >  #define ACPI_DBG2_1394_STANDARD     0x0000
> > > >
> > > > diff --git a/drivers/acpi/spcr.c b/drivers/acpi/spcr.c
> > > > index 88460bacd5ae..25c2d0be953e 100644
> > > > --- a/drivers/acpi/spcr.c
> > > > +++ b/drivers/acpi/spcr.c
> > > > @@ -136,6 +136,7 @@ int __init acpi_parse_spcr(bool enable_earlycon=
, bool enable_console)
> > > >                 break;
> > > >         case ACPI_DBG2_16550_COMPATIBLE:
> > > >         case ACPI_DBG2_16550_SUBSET:
> > > > +       case ACPI_DBG2_16550_WITH_GAS:
> > > >                 uart =3D "uart";
> > > >                 break;
> > > >         default:
> > > > --
> >
> > Do you have any comments / remarks to the patch?
>
> Yes, I do, but I will get back to you next week.
>

Great, thank you!

Marcin
