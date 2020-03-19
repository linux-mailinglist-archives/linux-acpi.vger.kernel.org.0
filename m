Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D98518B03E
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Mar 2020 10:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgCSJaa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 19 Mar 2020 05:30:30 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34603 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgCSJa3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2020 05:30:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id j16so1686523otl.1;
        Thu, 19 Mar 2020 02:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AjLAxS30AF1MgyZCOHu5quIXHYjW+sHIRF2hWQ/EoKY=;
        b=VQj6VgOeP822FsFWd1xZ5GxXYl/5DjpjrfC8gPHQT0T46Mv54XN2zZYorufk0SkRIO
         FuPfSZeU5mQO1Wg0oYQEKxZmzZ3bYzerJ0NVh/LyNP08oKbJMylDfaG0dP0kMm+uffLV
         qKQ2DUQaCFkvWZFKGPtNICw3sVLWmG+9e51/8NaEOWuml+fsiqct5TX8MC3jVvPIesc/
         abwLEmJ118le7nHcbWAqTK7yY4cXPri1OWUO8nJU/qmooITnnXCkygj2Z5Wy24bkRGkm
         bk0o73hNXFx8nce00gDkUYvOfbFum5rdzLhzI8TgW0SQh+RaW4hEjbdcDMlC9rkQ1hua
         7YmQ==
X-Gm-Message-State: ANhLgQ2uXYxhDlczLoz8kd9ltflQrZMVcsQEr28hr0LxqhgNJmyWjj+C
        DFrvITZUC6QYIu8oM9C5LYUJEnGPjFl7pyJmjg0=
X-Google-Smtp-Source: ADFU+vseHcHbrSk7AUUSo3PUXOKqIYKv1JO1U1cQl24IGfaKOG7YOlKaQmPuIeQBQpYXHZhcR4/LlltnnhLNZHLlPN0=
X-Received: by 2002:a9d:1d07:: with SMTP id m7mr1419195otm.167.1584610228890;
 Thu, 19 Mar 2020 02:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com>
 <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com> <CAPcyv4hH55e-tm7erJGm_jVn4gWigQfVPSAUu-DBC4XkF+WZHg@mail.gmail.com>
In-Reply-To: <CAPcyv4hH55e-tm7erJGm_jVn4gWigQfVPSAUu-DBC4XkF+WZHg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Mar 2020 10:30:17 +0100
Message-ID: <CAJZ5v0hM7d+B9WgxiFKJS3_C1D_wrvnU8kT+85yFLSc_X+ToNA@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
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

On Wed, Mar 18, 2020 at 6:39 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 18, 2020 at 1:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Wed, Mar 18, 2020 at 1:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > Disable parsing of the HMAT for debug, to workaround broken platform
> > > > instances, or cases where it is otherwise not wanted.
> > >
> > > Rafael, any heartburn with this change to the numa= option?
> > >
> > > ...as I look at this I realize I failed to also update
> > > Documentation/x86/x86_64/boot-options.rst, will fix.
> >
> > Thanks!
> >
> > Apart from this just a minor nit below.
> >
> > > >
> > > > Cc: x86@kernel.org
> > > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > > Cc: Andy Lutomirski <luto@kernel.org>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > > Cc: Ingo Molnar <mingo@redhat.com>
> > > > Cc: Borislav Petkov <bp@alien8.de>
> > > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > > ---
> > > >  arch/x86/mm/numa.c       |    4 ++++
> > > >  drivers/acpi/numa/hmat.c |    3 ++-
> > > >  include/acpi/acpi_numa.h |    1 +
> > > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > > index 59ba008504dc..22de2e2610c1 100644
> > > > --- a/arch/x86/mm/numa.c
> > > > +++ b/arch/x86/mm/numa.c
> > > > @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
> > > >  #ifdef CONFIG_ACPI_NUMA
> > > >         if (!strncmp(opt, "noacpi", 6))
> > > >                 acpi_numa = -1;
> > > > +#ifdef CONFIG_ACPI_HMAT
> > > > +       if (!strncmp(opt, "nohmat", 6))
> > > > +               hmat_disable = 1;
> > > > +#endif
> >
> > I wonder if IS_ENABLED() would work here?
>
> I took a look. hmat_disable, acpi_numa, and numa_emu_cmdline() are in
> other compilation units. I could wrap writing those variables with
> helper functions, and change numa_emu_cmdline(), to compile away when
> their respective configuration options are not present.
>
> Should we do that in general to have a touch point to report "you
> specified an option that is invalid for your current kernel
> configuration"? I'm happy to do that as a follow-on if you think it's
> worthwhile.

Yes, please.
