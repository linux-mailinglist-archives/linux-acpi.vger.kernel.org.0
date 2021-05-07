Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE045376D1A
	for <lists+linux-acpi@lfdr.de>; Sat,  8 May 2021 01:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhEGXDH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 19:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEGXDG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 May 2021 19:03:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992BC061761
        for <linux-acpi@vger.kernel.org>; Fri,  7 May 2021 16:02:05 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id zg3so15877249ejb.8
        for <linux-acpi@vger.kernel.org>; Fri, 07 May 2021 16:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cysv76arNz3MFs69VgX48DEkoN+9KVfkGC6lPIgs6LE=;
        b=g8Uua7ZkJUkGmrfi9VOU8KXTzma6Sz/ha6C4zc2aV/dvLPFPBuro4R1QQHIupXI1K3
         Nq0ofBpyKFYN+zfIgJzSfNoYSchacVQcM/LzruoFvtv+dVO+PufL97znHHXj2rf1+cIB
         wapM++MV9+XseRUEnb9GC8DcT6lgUQ9j3nAVnLFScuw/sJ3+jM0WSbwmjR9pXsbpvjEF
         eYE9gaXgPB0JVWi7ZW1iLMhAEJ+Icu8UmkixAEjfU4q2PGCAgLJdlGzxNd4aYczL0NWq
         9edVVRwc5zWREXezpVsrimURLVLQ4MkNiyoNvaWBs3MhYSnGuNGRgEvL9o+vC7/bG4i0
         cVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cysv76arNz3MFs69VgX48DEkoN+9KVfkGC6lPIgs6LE=;
        b=ePvKtRQVNdWOgUJMFCTc4Vrk9qh5FsvHcbn0W4++dNqeu63r25NuCYMHKeIoPeTe5U
         qGONJffio1YkmgK5D4W0rAzqLmC+cmTpqYjmdABTURd6RqE6Ept0xntLXXrv3pvkRv5Z
         zUfYSMxuc0V1n+PErAZS4L3QrdfJ21X1ySIbLiaJ9pIMUPzVjOIQbQ2XNbiyuJk2BKad
         Uc6BsTItyay4bG17nIcAu2l7/AEKOVQbxkmEeCawVLfIBlpRpPKWYhKDiNQO6Emt3Cq4
         5C3vFwoD5bk2n5kWyjs5AJQpYu/RTEGdt4dUNKCxb1/8qQHvc26g0PSeMnnCCLuTU+lc
         PYGg==
X-Gm-Message-State: AOAM533tRpbgGjVPF7wLPpl4Y7HWaNlMzKDB10coQzAlXZ2izCbDVnCS
        fFBDeoIrbFt0BftKtLV5Ht3D0nqBSSJHwco5ANltQw==
X-Google-Smtp-Source: ABdhPJx0vlXi8joVqX/bKq6BizKlwHJaiCJq3xBs6gTLXhtM3osxEcKR8qoOa8bY8Rty55XhIwEh7d0ppVWIj9mVfww=
X-Received: by 2002:a17:906:33da:: with SMTP id w26mr12947744eja.472.1620428524398;
 Fri, 07 May 2021 16:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com>
 <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com> <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
In-Reply-To: <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 7 May 2021 16:01:53 -0700
Message-ID: <CAPcyv4hVLc0hpZ5ft-XQ7a4OMrYbH=Y6t_tUbiteKcR4G0NT+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 7, 2021 at 7:49 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Fri, May 7, 2021 at 4:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > Hi Dan,
> > >
> > > On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > > > Address (SPA) Range Structure". The presence of that new field is
> > > > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > > > firmware implementations omit the flag and maintain the original size of
> > > > the structure.
> > > >
> > > > Update the implementation to check that flag to determine the size
> > > > rather than the ACPI 6.4 compliant definition of 'struct
> > > > acpi_nfit_system_address' from the Linux ACPICA definitions.
> > > >
> > > > Update the test infrastructure for the new expectations as well, i.e.
> > > > continue to emulate the ACPI 6.3 definition of that structure.
> > > >
> > > > Without this fix the kernel fails to validate 'SPA' structures and this
> > > > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > > > SPAs are valid if it finds valid SMBIOS tables.
> > > >
> > > >     BUG: unable to handle page fault for address: ffffffffffffffa8
> > > >     [..]
> > > >     Call Trace:
> > > >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> > > >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> > > >      skx_register_mci+0x132/0x1c0 [skx_edac]
> > > >
> > > > Cc: Bob Moore <robert.moore@intel.com>
> > > > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > > > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
> > >
> > > Do you want me to apply this (as the commit being fixed went in
> > > through the ACPI tree)?
> >
> > Yes, I would need to wait for a signed tag so if you're sending urgent
> > fixes in the next few days please take this one, otherwise I'll circle
> > back next week after -rc1.
>
> I'll be doing my next push after -rc1 either, so I guess it doesn't
> matter time-wise.

Ok, I got it, thanks for the offer.
