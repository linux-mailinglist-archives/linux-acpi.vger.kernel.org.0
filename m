Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8B23536E
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Aug 2020 18:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgHAQhC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 Aug 2020 12:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgHAQhC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 1 Aug 2020 12:37:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8BFC061756
        for <linux-acpi@vger.kernel.org>; Sat,  1 Aug 2020 09:37:01 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o23so6978475ejr.1
        for <linux-acpi@vger.kernel.org>; Sat, 01 Aug 2020 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7nWoFZS16KHN7ELInZM3NkAqbsw8HmgfQtV5PkaAdOs=;
        b=sLJ2YymDgCE2aYqkgcFgGI6naddEomHT1AI/LblO1I2CIpKzR/X4HC0D8kFfsN6b+L
         XCYiypkgq9U/ws9p617+waX57F8r3r9xw2IEJINKnzTBI1kuSBY9ijEvHwlcNtuSjqeZ
         Hc2tgLSldiumX+1XnZPsDgJMdf1x61SK6XNyMc3TiFxkjVUQDHk06pK8LV6TXULby89E
         Q+sc+6B4I8vfJLc3o9x4Nzoa4qysw9eANsa9JKWVrWyM3DFMjubaz5YpI0uzS2O4ob16
         LSXsaZKRopTp92npa1jce/IFsU1kV5YolRnKSOBrqMK/vKjOiSQ1Nztp40qAyj1R/fd9
         WV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7nWoFZS16KHN7ELInZM3NkAqbsw8HmgfQtV5PkaAdOs=;
        b=lDARlK/PXHeH9Q4vI+6k3wao4ItbmCMspxpdBjOoULfBCrgA0QQtv20zRMnpX0hNam
         zNKppVR70JtDDysg9tvqFCkd1znxKesFExkMhMJ1YtYEx04ZHchjivBTdFL7MrnkDDuf
         lIrvjKFDtdJxbBV4DoCwMsOC9XhO5+Lxc9fHopLgwoA3Z03HCVSdWPBEpVFL+aultKnR
         zMDLXqjHmQQpvDeSzVMHKAsB6XFyaYo7YBOeV+IoQoZr8Y2SvrSODvumbLZx2ATqV3m0
         qgREY1Y0SnZsWXwP5RHchu/BdP9x+wziBU6cs2PGl69JFJw8FRqHefEdQ6tZwweR8QKo
         wqSA==
X-Gm-Message-State: AOAM532gab4fFjNlfnjprh8u3eCP3VAGn6YbotHlzbTTRnVhDcz8BVA0
        0trivZPtwlq1Gn3o74PKzPztkHMRzNlWVOQTjQ9Z1w==
X-Google-Smtp-Source: ABdhPJxOFGsY8qnjWmioIMQMzSoQMpAmcXHTZevYKI2hHLGadP9/WqNGAW9biPUhi7/KRXBONqPTrbpeIRc4H0g10M8=
X-Received: by 2002:a17:907:72c8:: with SMTP id du8mr9038155ejc.237.1596299819131;
 Sat, 01 Aug 2020 09:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <159625229779.3040297.11363509688097221416.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159625231266.3040297.2759117253481288037.stgit@dwillia2-desk3.amr.corp.intel.com>
 <545078f8-d6d3-5db7-02f6-648218513752@infradead.org>
In-Reply-To: <545078f8-d6d3-5db7-02f6-648218513752@infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 1 Aug 2020 09:36:48 -0700
Message-ID: <CAPcyv4iUtQ1Edau5e7GQumu1MxcAvorSNwnw9HGhzFDNuBS7=Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/23] x86/numa: Add 'nohmat' option
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 31, 2020 at 8:51 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 7/31/20 8:25 PM, Dan Williams wrote:
> > Disable parsing of the HMAT for debug, to workaround broken platform
> > instances, or cases where it is otherwise not wanted.
> >
> > ---
> >  arch/x86/mm/numa.c       |    2 ++
> >  drivers/acpi/numa/hmat.c |    8 +++++++-
> >  include/acpi/acpi_numa.h |    8 ++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> > index 87c52822cc44..f3805bbaa784 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -41,6 +41,8 @@ static __init int numa_setup(char *opt)
> >               return numa_emu_cmdline(opt + 5);
> >       if (!strncmp(opt, "noacpi", 6))
> >               disable_srat();
> > +     if (!strncmp(opt, "nohmat", 6))
> > +             disable_hmat();
>
> Hopefully that will be documented in
> Documentation/x86/x86_64/boot-options.rst.

Sorry, yes, you gave that feedback before. I can do a quick respin
with this and the kbuild-robot compile fixups.
