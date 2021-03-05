Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F8032ED70
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 15:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhCEOsz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 09:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhCEOsr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 09:48:47 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5EC061574;
        Fri,  5 Mar 2021 06:48:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l12so2961919edt.3;
        Fri, 05 Mar 2021 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6H9zPOyf/W5Kw6m5aeYlg/9Nqu4NeEQzjbuoEKpZQaw=;
        b=COlS4amwoedEHfjmXU3R9LCbJhQiJkYsElxneD4UvAdAb/XGdTY/wArU+LpuEpM9sM
         trBGRIT0HCDYLs52oKAugEUmi+rKwnpNwne1QB14mE4zuJbphkf/ox2Anm7Ut89zJCE4
         YGWMSx07Nhkfie21Rmve+BQRVDgTlDk2M3Zk4zV1Vn2Dw5kWPEv+Un7z+Zsz8u41hY5H
         BsHRNP4rBQZGj++ZgfCa8yUaZsY6AbRBNoWxI+9fu/wx8Aki3QP5iIk5eBz+L7FnYxMn
         PANbevu5P+Xm4HLAnSQXowbf269fCUVFK7FYik/wkSQ/M/ySSuAx7u9r5O6S9LL2BSbn
         k8UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6H9zPOyf/W5Kw6m5aeYlg/9Nqu4NeEQzjbuoEKpZQaw=;
        b=iHcjrPIZgR9I48JmdcV2uDmAHz2so/BIopRi1BDCj+xaYuFXkCdG5qCIImSW447bbB
         C8LuVPEBtFz4n6erQ5EfSnKJ18UaTjYl7vNeVLFSuVyqfhT4MWVJoVnYejPypHuKyqsk
         Q21u4zozLtAovu4/XwJvoHKU7cHlx6q73F4FxOvmwivgReKXo7NG5lxFcQwQCDPbXpHn
         82WM+A4fxGEXYXqAmBcKydLbJRPG0cLwWLWJDSMLVWPl8nG/LlgUKhSL/puorbSE3r2k
         dAxJS+EtwgIONkobCdVJEwFWyT0nSWxG40VT+Hq1dnQkLMDf66DPebmBg3w+o0ZBXluu
         8AKw==
X-Gm-Message-State: AOAM533o5M1c1VYyAgo06AqG7vay8YRwF20PFf+13H68+w5jblphtEaa
        HtMpUluy+QGCSl213hmF3jF1saapoaQU9apwKSo=
X-Google-Smtp-Source: ABdhPJz3Du9SwtuPs1CxJnyaIM/a7gyGDx4WcC16HMN8RwmKw/9wCsy3DjSyT2e1F1fHAbCopSv03RFvLRmQRuf3CyY=
X-Received: by 2002:a05:6402:17d5:: with SMTP id s21mr9347085edy.65.1614955725530;
 Fri, 05 Mar 2021 06:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com> <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com> <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
Reply-To: weidongcui@gmail.com
From:   Weidong Cui <weidongcui@gmail.com>
Date:   Fri, 5 Mar 2021 06:48:34 -0800
Message-ID: <CADFYyO5wtwfUrNWjW_uN_ctdgNzQywsHUtGoLkBaUc2652OGzA@mail.gmail.com>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
 only when ACPI_PCI_CONFIGURED is defined
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Xinyang Ge <aegiryy@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 9:37 AM Moore, Robert <robert.moore@intel.com> wrote:

> It is required in aclinux.h, and thus it is required in every host-dependent configuration file (acfreebsd.h, acmacosx.h, acnetbsd.h, achaiku.h, etc.) I would rather not force these host-specific header files to change.
> Bob

Hi Bob,

I don't know the reason for ACPI_PCI_CONFIGURED to be introduced into
aclinux.h. That patch introduced the bug I'm trying to fix: if
CONFIG_PCI is not enabled, the kernel will crash.  Would it be okay to
accept this patch first to fix this kernel crash bug?  We can come up
a plan to fix this host-dependent configuration issue in a separate
patch.  What do you think?

@Erik, I would love to hear your thoughts on this.

Thank you!
Weidong

> > -----Original Message-----
> > From: Kaneda, Erik <erik.kaneda@intel.com>
> > Sent: Wednesday, March 03, 2021 10:29 AM
> > To: Weidong Cui <weidongcui@gmail.com>; Moore, Robert
> > <robert.moore@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>
> > Cc: Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org;
> > devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown
> > <lenb@kernel.org>
> > Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> > defined
> >
> > This looks good to me. Bob, do you have any comments?
> >
> > Erik
> >
> > > -----Original Message-----
> > > From: Weidong Cui <weidongcui@gmail.com>
> > > Sent: Monday, February 8, 2021 7:18 PM
> > > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> > > Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge
> > > <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > > linux- kernel@vger.kernel.org
> > > Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> > > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> > > defined
> > >
> > > Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> > > Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> > > ---
> > >  drivers/acpi/acpica/evhandler.c | 2 ++
> > >  include/acpi/acconfig.h         | 4 ++++
> > >  2 files changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/acpi/acpica/evhandler.c
> > > b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
> > > --- a/drivers/acpi/acpica/evhandler.c
> > > +++ b/drivers/acpi/acpica/evhandler.c
> > > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> > >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
> > >       ACPI_ADR_SPACE_SYSTEM_MEMORY,
> > >       ACPI_ADR_SPACE_SYSTEM_IO,
> > > +#ifdef ACPI_PCI_CONFIGURED
> > >       ACPI_ADR_SPACE_PCI_CONFIG,
> > > +#endif
> > >       ACPI_ADR_SPACE_DATA_TABLE
> > >  };
> > >
> > > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> > > a225eff49..790999028 100644
> > > --- a/include/acpi/acconfig.h
> > > +++ b/include/acpi/acconfig.h
> > > @@ -162,7 +162,11 @@
> > >  /* Maximum space_ids for Operation Regions */
> > >
> > >  #define ACPI_MAX_ADDRESS_SPACE          255
> > > +#ifdef ACPI_PCI_CONFIGURED
> > >  #define ACPI_NUM_DEFAULT_SPACES         4
> > > +#else
> > > +#define ACPI_NUM_DEFAULT_SPACES         3
> > > +#endif
> > >
> > >  /* Array sizes.  Used for range checking also */
> > >
> > > --
> > > 2.24.3 (Apple Git-128)
> >
