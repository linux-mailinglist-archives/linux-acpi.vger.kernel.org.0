Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8001896D9
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbgCRIYM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Mar 2020 04:24:12 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:32864 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRIYM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2020 04:24:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id x26so7593854otk.0;
        Wed, 18 Mar 2020 01:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQ0AIpy6289Hs4+0vUajVZqxzUHEdUAVpK8eg8j+VHE=;
        b=VpCXkmUMJ9vmCsRMm7NT0Xj8R6wNxNEUEmONuevzauY8IZt0iaDFp4Ar+rTotAJXRD
         r1meyr6HfWoBaAXmgpHsz6Afkt3lufdid4UAZ1GzvWBDzKxqAAtb87WrYbwvSWL30y4z
         kYL1ko3XwjOMwrmDnxPH9X5oNuGuBgRS1x5tF7dqu+4LjaksmC50s+2v9BwAXIhIjoST
         j1tGDSnA2009rL7a7oek+Lro94SiBaYsFtT3JaqM/l68icGF+9RAAv6GXJdHpS4qSWv1
         Ndq5u8GfqEiqs47bdc8NX67H/P+1KWlhwtbnB3vv6kge6KoaTB68ijUaUBtAsMUrKOqJ
         NGug==
X-Gm-Message-State: ANhLgQ1Pa1z55vj794HJIaAGAkXOnsZuiDpO/Io7GECI4TrVxk87QMIA
        FccVBvA5+FKmGCCwyIkuZ2sWMg8+yIceqbHqUbY=
X-Google-Smtp-Source: ADFU+vtDUu/ENup+aXfCBKJZoHwE4fbxddOCHcfz5Gp/eR5kvQBbgkz/udoMueN3CldSwYbzXoAKDhG5hexnUlr09kY=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr2678697otm.167.1584519851446;
 Wed, 18 Mar 2020 01:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
In-Reply-To: <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 18 Mar 2020 09:24:00 +0100
Message-ID: <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 18, 2020 at 1:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > Disable parsing of the HMAT for debug, to workaround broken platform
> > instances, or cases where it is otherwise not wanted.
>
> Rafael, any heartburn with this change to the numa= option?
>
> ...as I look at this I realize I failed to also update
> Documentation/x86/x86_64/boot-options.rst, will fix.

Thanks!

Apart from this just a minor nit below.

> >
> > Cc: x86@kernel.org
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  arch/x86/mm/numa.c       |    4 ++++
> >  drivers/acpi/numa/hmat.c |    3 ++-
> >  include/acpi/acpi_numa.h |    1 +
> >  3 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 59ba008504dc..22de2e2610c1 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
> >  #ifdef CONFIG_ACPI_NUMA
> >         if (!strncmp(opt, "noacpi", 6))
> >                 acpi_numa = -1;
> > +#ifdef CONFIG_ACPI_HMAT
> > +       if (!strncmp(opt, "nohmat", 6))
> > +               hmat_disable = 1;
> > +#endif

I wonder if IS_ENABLED() would work here?

> >  #endif
> >         return 0;
> >  }
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 2c32cfb72370..d3db121e393a 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sysfs.h>
> >
> >  static u8 hmat_revision;
> > +int hmat_disable __initdata;
> >
> >  static LIST_HEAD(targets);
> >  static LIST_HEAD(initiators);
> > @@ -814,7 +815,7 @@ static __init int hmat_init(void)
> >         enum acpi_hmat_type i;
> >         acpi_status status;
> >
> > -       if (srat_disabled())
> > +       if (srat_disabled() || hmat_disable)
> >                 return 0;
> >
> >         status = acpi_get_table(ACPI_SIG_SRAT, 0, &tbl);
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..48ca468e9b61 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -18,6 +18,7 @@ extern int node_to_pxm(int);
> >  extern int acpi_map_pxm_to_node(int);
> >  extern unsigned char acpi_srat_revision;
> >  extern int acpi_numa __initdata;
> > +extern int hmat_disable __initdata;
> >
> >  extern void bad_srat(void);
> >  extern int srat_disabled(void);
> >
