Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DFE18A1AF
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 18:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgCRRjt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Mar 2020 13:39:49 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43921 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgCRRjt (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2020 13:39:49 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125so26640034oif.10
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2020 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHYLZgvsf1hWg7wss08IWO7NiACgg0ycsHnQwwOGC/o=;
        b=JBORuCypw8sBksHmM30bDIzjuQ7RWsVH6HMT8e5ZaAVU7E8G6gkLWQXlEXXe77DKFQ
         MEA/XkeQop3sDtmPEZQHtrMj94AdEeN8yd8hg/I1C9cRQ6xjEE8qLKRT47rl3r+tzT40
         6BsMYAkcZL536h8DRosc6/sOuEC/CAYbvmnqVZon/PlG100ssTNQ+6FH/8RzYwLGTpqu
         rYSGNJL2N+7JGsIO7iIdNQIE8oK+Ss3njal+LQtaT1wlGTgK5+rBFdPMv9J8LObp45tO
         tW5A2oDc//SHWgrjawQAy0iImOIi+JvH9jJRtWWByCfhxeehscEF31ycY5u8kMsPUM6o
         FIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHYLZgvsf1hWg7wss08IWO7NiACgg0ycsHnQwwOGC/o=;
        b=hq4KST679Yp6hf7Y+m14Shst57wVdFPbsQV+Z3zq4Vg3JS54yB0bh620+6nPvopoIG
         JVQK2mGBtg7+h+1InCUbtcPqQeMP30UrhHQPfaQFtTtIb/Y/5FHyO1BR5JkTm/Tif6qI
         0jEOSNdD10qli25VlekGH0/wikP0pn4aB4hG5waACHDPrp1EQA7tcwvlykKLIflRnK5k
         nIRpgcxPb4DysLnWIW/ad1cDVUSkr9fafDyuiIdXcoj+zDrDBU9IHzebnCmNXV/0nc9a
         gsQKPSsSqKp95nJY9jcx0V8dczk0tn2sIB5aM4acH8C8qCQFBGX9q67YVHfE32c6+qtz
         w7VA==
X-Gm-Message-State: ANhLgQ0GzedeMuAgqh+tJzNobA3/mOimv8B55X6GwgKCUb3jtHo4rPJp
        68vFBfP7xk14RSsHhx/3RtFmfjmx3tdHtShFB97NcA==
X-Google-Smtp-Source: ADFU+vv61FyRVYmaA9PTdDt51tbofJ336O0XLQe2BKgEmzbR6+s801/WV/yc2hI80eFyXV6kWzP+gw13nONTF6vPPUI=
X-Received: by 2002:a05:6808:495:: with SMTP id z21mr4194137oid.149.1584553188875;
 Wed, 18 Mar 2020 10:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <158318760361.2216124.13612198312947463590.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAPcyv4hjgNruY84Kr9S5HZ6P03fNcPcmL7H2DN19Z+CbPZ7d+Q@mail.gmail.com> <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com>
In-Reply-To: <CAJZ5v0heWeS1iZqHEZ5RB2a=UJbUQF0zAjeFfTa9qBxvQ193=w@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 18 Mar 2020 10:39:37 -0700
Message-ID: <CAPcyv4hH55e-tm7erJGm_jVn4gWigQfVPSAUu-DBC4XkF+WZHg@mail.gmail.com>
Subject: Re: [PATCH 1/5] ACPI: NUMA: Add 'nohmat' option
To:     "Rafael J. Wysocki" <rafael@kernel.org>
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

On Wed, Mar 18, 2020 at 1:24 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Mar 18, 2020 at 1:09 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Mar 2, 2020 at 2:36 PM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > Disable parsing of the HMAT for debug, to workaround broken platform
> > > instances, or cases where it is otherwise not wanted.
> >
> > Rafael, any heartburn with this change to the numa= option?
> >
> > ...as I look at this I realize I failed to also update
> > Documentation/x86/x86_64/boot-options.rst, will fix.
>
> Thanks!
>
> Apart from this just a minor nit below.
>
> > >
> > > Cc: x86@kernel.org
> > > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > > Cc: Andy Lutomirski <luto@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Ingo Molnar <mingo@redhat.com>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > ---
> > >  arch/x86/mm/numa.c       |    4 ++++
> > >  drivers/acpi/numa/hmat.c |    3 ++-
> > >  include/acpi/acpi_numa.h |    1 +
> > >  3 files changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > > index 59ba008504dc..22de2e2610c1 100644
> > > --- a/arch/x86/mm/numa.c
> > > +++ b/arch/x86/mm/numa.c
> > > @@ -44,6 +44,10 @@ static __init int numa_setup(char *opt)
> > >  #ifdef CONFIG_ACPI_NUMA
> > >         if (!strncmp(opt, "noacpi", 6))
> > >                 acpi_numa = -1;
> > > +#ifdef CONFIG_ACPI_HMAT
> > > +       if (!strncmp(opt, "nohmat", 6))
> > > +               hmat_disable = 1;
> > > +#endif
>
> I wonder if IS_ENABLED() would work here?

I took a look. hmat_disable, acpi_numa, and numa_emu_cmdline() are in
other compilation units. I could wrap writing those variables with
helper functions, and change numa_emu_cmdline(), to compile away when
their respective configuration options are not present.

Should we do that in general to have a touch point to report "you
specified an option that is invalid for your current kernel
configuration"? I'm happy to do that as a follow-on if you think it's
worthwhile.
