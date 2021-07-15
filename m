Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0633CA1A7
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jul 2021 17:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbhGOPtn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 15 Jul 2021 11:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbhGOPtn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Jul 2021 11:49:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAB1C061760
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 08:46:50 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id q190so5616480qkd.2
        for <linux-acpi@vger.kernel.org>; Thu, 15 Jul 2021 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wgs63a+PlXUyAcP9loz5v+J4Lbh2jAL3wVDQpLoayFY=;
        b=glOWmH1hxE89FSiR2M95VQYHxvaK101zwu24VIHevlBstICEF3Yk5YQLNJv2wL60Rc
         +7/xZwUt3dhaOYmqJVAcgFoGpbQHFbOE9ruzo80TfoRUnsTKXQu5oSAGllvHpenfchgV
         y8blQxAs6etptfcSiIscIs+0dAp43fymriHg1gYH+9KxffwFE2EIW6du9FXC4bICsurs
         mdcHwfyQmkk9LEr6SO81bZ5q7g9EGH0A1AiSZPqk/Hzj8FEX/TQuBfn0pw/EDl0tdzpy
         00TvI8eOTqg8lkVZNRhngnvptP7LUcPY+E9APeR9M5Zvwam4JfuwFvOr8+Dy8yMhtMZT
         KfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wgs63a+PlXUyAcP9loz5v+J4Lbh2jAL3wVDQpLoayFY=;
        b=GNXN6Z3tc+vCS+dlcK6EIUKUCp6BvI0GnNKOKPlnXhIfeE3objrc5WSxaLpnNfLIvp
         yYk7eKZXZs8enE8flKE80VFgvvi4C77kDMuXs8SCN667kYZO5RfQ12iIHRbpWFnaNond
         zX/94Kq2nTAwuWtCKc0M+6MuXA+9FXAguhu0KSCsrn1NBVtLRz/77/WojkuIBcYxcQ7N
         yiECCojR/haHFFQ7+gvWK9LCv/L7dEcak9gkP+078hHftQ8O6Q635Abk5DezhrnLcFUw
         UtdTlgDPkYqpfZ6QxKPDUKBLYszMDzJfxOxL3xTDOKiVWE+AqMAXRNZqo4lo1Jxgl6ri
         kh+w==
X-Gm-Message-State: AOAM531Opx5xB/PycEHGh/0li8MdYxUX0q8q8dDK1zIXbkAsG6jstPhj
        tLbSD79l1hamO+dvOgEQpdBvKGSngvsKG/doSbFrmm0sjxE=
X-Google-Smtp-Source: ABdhPJxkedmxZtlhSFUhXqTM9YTLPxlkbpSvX8iwDTZRzDuUXOrbYlA3WVzNtxjE8aVXysiR8wJL+N6pXyYuirI1SRQ=
X-Received: by 2002:a37:313:: with SMTP id 19mr4552177qkd.295.1626364009325;
 Thu, 15 Jul 2021 08:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210714214346.1397942-1-mw@semihalf.com> <20210714214346.1397942-2-mw@semihalf.com>
 <BYAPR11MB3256CACCFB4A08B5D450D3A087129@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CAPv3WKeN55zEW65yfyPizB0WA4HLtcf=m-7yUgpk7O1hCKW4SA@mail.gmail.com> <BYAPR11MB32569C7DB2041874F540A7A987129@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB32569C7DB2041874F540A7A987129@BYAPR11MB3256.namprd11.prod.outlook.com>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 15 Jul 2021 17:46:38 +0200
Message-ID: <CAPv3WKcBKNAD880Mpf8z4vpY=3wbyyd3PiQ=uzKupaw=P_JpQg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "jaz@semihalf.com" <jaz@semihalf.com>,
        "gjb@semihalf.com" <gjb@semihalf.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "Samer.El-Haj-Mahmoud@arm.com" <Samer.El-Haj-Mahmoud@arm.com>,
        "jon@solid-run.com" <jon@solid-run.com>,
        "tn@semihalf.com" <tn@semihalf.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

czw., 15 lip 2021 o 17:44 Moore, Robert <robert.moore@intel.com> napisa=C5=
=82(a):
>
> The patch was posted as a pull request on our github site.
>

I'm aware of that, semihalf-wojtas-marcin is me :)

> The merged patch will be released as part of the normal ACPICA release pr=
ocess, which will then make it into Linux. You should then rebase.

Ok, thanks for explanation. When approximately can this happen?

Best regards,
Marcin

> Bob
>
>
> -----Original Message-----
> From: Marcin Wojtas <mw@semihalf.com>
> Sent: Thursday, July 15, 2021 7:17 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org; devel@acpic=
a.org; jaz@semihalf.com; gjb@semihalf.com; upstream@semihalf.com; Samer.El-=
Haj-Mahmoud@arm.com; jon@solid-run.com; tn@semihalf.com; rjw@rjwysocki.net;=
 lenb@kernel.org
> Subject: Re: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
>
> Hi,
>
>
> czw., 15 lip 2021 o 16:07 Moore, Robert <robert.moore@intel.com> napisa=
=C5=82(a):
> >
> > This was already reported (with a patch that we've already merged) by
> > semihalf-wojtas-marcin
> >
>
> I'm not sure to be aware of the process. Reported where?
> Are you planning to import the upstream patch on your own and I should re=
base the SPCR driver change on top once it lands?
>
> Best regards,
> Marcin
>
> > -----Original Message-----
> > From: Marcin Wojtas <mw@semihalf.com>
> > Sent: Wednesday, July 14, 2021 2:44 PM
> > To: linux-kernel@vger.kernel.org; linux-acpi@vger.kernel.org;
> > devel@acpica.org
> > Cc: jaz@semihalf.com; gjb@semihalf.com; upstream@semihalf.com;
> > Samer.El-Haj-Mahmoud@arm.com; jon@solid-run.com; tn@semihalf.com;
> > rjw@rjwysocki.net; lenb@kernel.org; Moore, Robert
> > <robert.moore@intel.com>; Marcin Wojtas <mw@semihalf.com>
> > Subject: [PATCH 1/2] ACPICA: Add new DBG2 Serial Port Subtypes
> >
> > ACPICA commit d95c7d206b5836c7770e8e9cd613859887fded8f
> >
> > The Microsoft Debug Port Table 2 (DBG2) specification revision Septembe=
r 21, 2020 comprises additional Serial Port Subtypes [1].
> > Reflect that in the actbl1.h header file.
> >
> > [1]
> > https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/acpi
> > -debug-port-table
> >
> > Link: https://github.com/acpica/acpica/commit/d95c7d20
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> > ---
> >  include/acpi/actbl1.h | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h index
> > ef2872dea01c..7bbb3e2bd33f 100644
> > --- a/include/acpi/actbl1.h
> > +++ b/include/acpi/actbl1.h
> > @@ -482,7 +482,7 @@ struct acpi_csrt_descriptor {
> >   * DBG2 - Debug Port Table 2
> >   *        Version 0 (Both main table and subtables)
> >   *
> > - * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10,
> > 2015
> > + * Conforms to "Microsoft Debug Port Table 2 (DBG2)", September 21,
> > + 2020
> >   *
> >
> > **********************************************************************
> > ********/
> >
> > @@ -532,11 +532,24 @@ struct acpi_dbg2_device {
> >
> >  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
> >  #define ACPI_DBG2_16550_SUBSET      0x0001
> > +#define ACPI_DBG2_MAX311XE_SPI      0x0002
> >  #define ACPI_DBG2_ARM_PL011         0x0003
> > +#define ACPI_DBG2_MSM8X60           0x0004
> > +#define ACPI_DBG2_16550_NVIDIA      0x0005
> > +#define ACPI_DBG2_TI_OMAP           0x0006
> > +#define ACPI_DBG2_APM88XXXX         0x0008
> > +#define ACPI_DBG2_MSM8974           0x0009
> > +#define ACPI_DBG2_SAM5250           0x000A
> > +#define ACPI_DBG2_INTEL_USIF        0x000B
> > +#define ACPI_DBG2_IMX6              0x000C
> >  #define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
> >  #define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
> >  #define ACPI_DBG2_ARM_DCC           0x000F
> >  #define ACPI_DBG2_BCM2835           0x0010
> > +#define ACPI_DBG2_SDM845_1_8432MHZ  0x0011
> > +#define ACPI_DBG2_16550_WITH_GAS    0x0012
> > +#define ACPI_DBG2_SDM845_7_372MHZ   0x0013
> > +#define ACPI_DBG2_INTEL_LPSS        0x0014
> >
> >  #define ACPI_DBG2_1394_STANDARD     0x0000
> >
> > --
> > 2.29.0
> >
