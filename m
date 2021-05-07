Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5D4376736
	for <lists+linux-acpi@lfdr.de>; Fri,  7 May 2021 16:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236870AbhEGOur (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 May 2021 10:50:47 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:39689 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhEGOur (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 May 2021 10:50:47 -0400
Received: by mail-ot1-f41.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso8121947otv.6
        for <linux-acpi@vger.kernel.org>; Fri, 07 May 2021 07:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l66WwrIfYXPPqt7FNouM4SijVky0kURl9BRKhLx5Olw=;
        b=rHUoPnc7iZjZSWfOiFFiArn7GPsHAzxrE8ZBhasaYAtyWFV4vPwlS9/wfmxUAXsiwZ
         7ZLxDGsc+6ErOyVHEhDTy5uk6hJLr68+rQfvBVYBZUHc7kSnu1nrgYKvQ+5A/UXNnbJI
         yOBbdLCoFe/i/roH7fm8oY1E5LWkEonEAcdXz9ymn2nb0N28lK8k66wMtnZxXOzPEj8q
         wOagHSBHc1Gn4lON8BaZAHG9DaJvvYyXCJwWxb1cbX29c73G7cfq/B1FNOOwIMgq9SPh
         7zME4mmqZSyBscn8imhkeguuwM6yO9i1WbmoHlg/phhKrKa96hfm5sEflGvtF0PanLB2
         V0Fw==
X-Gm-Message-State: AOAM533Uf/1JSoPP7xqBK6z/1JHed4x98KcW7KXQVr9rqTHmQeQELv9n
        RIfpq7GZWrKEKaS/nKSDufh3zcEj698UqofC7bnicjsW
X-Google-Smtp-Source: ABdhPJwJ/Efd8Ja1dPWdSMymvbhACucR7P1kJhsAmSyKlyVRN8WDUqINXHChWukdv3xi3dM/kIb3SuazbyBGmIIg5xM=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr8640979otd.321.1620398987013;
 Fri, 07 May 2021 07:49:47 -0700 (PDT)
MIME-Version: 1.0
References: <162037273007.1195827.10907249070709169329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAJZ5v0gBCxFQ1pC1PTRximwzGXOSQDCzOfjX497aqBq5GQ48tA@mail.gmail.com> <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
In-Reply-To: <CAPcyv4jUdebFQvrhi0yzNyZ1wwzeGDpf6T34m=bfL593s-PEcA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 7 May 2021 16:49:35 +0200
Message-ID: <CAJZ5v0g_q7ceyLmmVzhAyruFd4CxSJj+JdigFURPoHNwG_DRyw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NFIT: Fix support for variable 'SPA' structure size
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Yi Zhang <yi.zhang@redhat.com>, nvdimm@lists.linux.dev,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, May 7, 2021 at 4:12 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, May 7, 2021 at 2:47 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Hi Dan,
> >
> > On Fri, May 7, 2021 at 9:33 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > >
> > > ACPI 6.4 introduced the "SpaLocationCookie" to the NFIT "System Physical
> > > Address (SPA) Range Structure". The presence of that new field is
> > > indicated by the ACPI_NFIT_LOCATION_COOKIE_VALID flag. Pre-ACPI-6.4
> > > firmware implementations omit the flag and maintain the original size of
> > > the structure.
> > >
> > > Update the implementation to check that flag to determine the size
> > > rather than the ACPI 6.4 compliant definition of 'struct
> > > acpi_nfit_system_address' from the Linux ACPICA definitions.
> > >
> > > Update the test infrastructure for the new expectations as well, i.e.
> > > continue to emulate the ACPI 6.3 definition of that structure.
> > >
> > > Without this fix the kernel fails to validate 'SPA' structures and this
> > > leads to a crash in nfit_get_smbios_id() since that routine assumes that
> > > SPAs are valid if it finds valid SMBIOS tables.
> > >
> > >     BUG: unable to handle page fault for address: ffffffffffffffa8
> > >     [..]
> > >     Call Trace:
> > >      skx_get_nvdimm_info+0x56/0x130 [skx_edac]
> > >      skx_get_dimm_config+0x1f5/0x213 [skx_edac]
> > >      skx_register_mci+0x132/0x1c0 [skx_edac]
> > >
> > > Cc: Bob Moore <robert.moore@intel.com>
> > > Cc: Erik Kaneda <erik.kaneda@intel.com>
> > > Fixes: cf16b05c607b ("ACPICA: ACPI 6.4: NFIT: add Location Cookie field")
> >
> > Do you want me to apply this (as the commit being fixed went in
> > through the ACPI tree)?
>
> Yes, I would need to wait for a signed tag so if you're sending urgent
> fixes in the next few days please take this one, otherwise I'll circle
> back next week after -rc1.

I'll be doing my next push after -rc1 either, so I guess it doesn't
matter time-wise.
