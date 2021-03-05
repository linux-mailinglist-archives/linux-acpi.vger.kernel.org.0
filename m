Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B654232F4CE
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 21:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhCEUz6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 15:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhCEUzk (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 15:55:40 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CCCC06175F;
        Fri,  5 Mar 2021 12:55:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id p1so4497894edy.2;
        Fri, 05 Mar 2021 12:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=thrXrLjLF5z/SKJCD+pGwIOuWV3vLVJ4ZtDl+1J1x0k=;
        b=BvlOojU3y4cr6Tr29mW2pAJL7JS7bRcYr9Wca1Z5mhWKgyWeoXFAxXUwmqSDJBXVVt
         8QsQj05UKy9jLOYjQ7nJdsALDUYYnOmkID5zpIlYNyAzvkpT69URsdh3k14NV1bV3UDc
         HOZURVMYYDFQb2cZ6ldiBAnE7yCwUzqocXCX2z+dL0R0Fz6BnmnsNSfPKkfSDAi3ek1+
         uYrkuKva3lOI3fsaBGy3S3JizhhFl9xeZIENUhe7RLgn1DDnipoBAqquwEnLu0yxerov
         H6N9x1tXDu1wy1HoZu2UEV+zHZcxp49ZDm+oQz5hy+yVtu+4VIu1bXEKRHo+VwuFKkn4
         WoQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=thrXrLjLF5z/SKJCD+pGwIOuWV3vLVJ4ZtDl+1J1x0k=;
        b=hW7S0KooH9HixcfJK97kBm39GCoTDO2nv8vflsb0WdLQBj6JzStxJIdigW9SelU0fP
         vZYUQB2AfBO0EkzdH3hmPn1SrRKlpMqfAOgPnBFycXYWEW1/dodCfPctG1yyoXevOJI2
         3VVDSUEqK+kO3sD32IbiymWQdedxRQJqNuJmiLJ6U/JLCf8QVD+EfQAVtanFc1xMh8oX
         SNzXBcrMezxxlGrvkXHYEm4CCasnfFLEedP2GOaYR0VXj74eLvVlyhoEljLl+nU6zvzF
         TGc5/UDcDAceyVGwhrO8Tc/UFOGYKHiEvJJBufoiHAJcW6BqbBjWjAZ680INyvzkv0Ek
         x+gA==
X-Gm-Message-State: AOAM530mq4AksaM2tu/Dndd7JPeka/760AaCjRPEOa8XRvU/zAc0VLin
        /dT06Mz4NsyodXxxlzZ9vP30fizQWPlyIVvEjC0=
X-Google-Smtp-Source: ABdhPJwUmXRp2xC9V4m4xZU4Jww/9AMAY3nxS9fB2d/LVjXF1qyegYzTj9deji0ITt3n2M7Ooin0mJ5IVdMUx4CsLZA=
X-Received: by 2002:aa7:d74d:: with SMTP id a13mr1111123eds.199.1614977738465;
 Fri, 05 Mar 2021 12:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com> <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
 <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <BYAPR11MB3256B80EC10AF4965083CCD087969@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB3256B80EC10AF4965083CCD087969@BYAPR11MB3256.namprd11.prod.outlook.com>
Reply-To: weidongcui@gmail.com
From:   Weidong Cui <weidongcui@gmail.com>
Date:   Fri, 5 Mar 2021 12:55:26 -0800
Message-ID: <CADFYyO5B2Mf50+gu6Dr7W3y9hGh9P2wOjyiYqJwLKcX_2pX8QA@mail.gmail.com>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
 only when ACPI_PCI_CONFIGURED is defined
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     "Kaneda, Erik" <erik.kaneda@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Xinyang Ge <aegiryy@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Mar 5, 2021 at 12:46 PM Moore, Robert <robert.moore@intel.com> wrote:
>
> After giving this some thought, I think we can #define ACPI_PCI_CONFIGURED in the global configuration file (I think it is acconfig.h) - and document why and when it should be removed.
> Bob

Hi Bob,

Thank you very much for your new suggestion!  Let me make sure I understand it.

1. We should move the following define from aclinux.h to acconfig.h.

#ifdef CONFIG_PCI
#define ACPI_PCI_CONFIGURED
#endif

2. We should add a comment there to "document why and when it should
be removed".
I don't really know "why and when" since I'm not an expert on ACPI (we
were just trying
to fix a bug :-)).

Thanks!
Weidong

> -----Original Message-----
> From: Moore, Robert <robert.moore@intel.com>
> Sent: Thursday, March 04, 2021 9:37 AM
> To: weidongcui@gmail.com
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> Subject: [Devel] Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
>
>
>
> -----Original Message-----
> From: Weidong Cui <weidongcui@gmail.com>
> Sent: Thursday, March 04, 2021 9:06 AM
> To: Moore, Robert <robert.moore@intel.com>
> Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
> Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
>
> > Well, I don't like the fact that PCI_CONFIGURED would have to be defined by each current host:
> >
> > > +#ifdef ACPI_PCI_CONFIGURED
> >
> > I would rather the logic be reversed:
> >
> > > +#ifdef ACPI_PCI_NOT_CONFIGURED
>
> Thank you for the comments, Erik and Bob!
>
> ACPI_PCI_CONFIGURED is defined in aclinux.h (see below) and used in several places in evhandler.c and exregion.c.
> I'm not sure why we want to introduce ACPI_PCI_NOT_CONFIGURED.  Bob, I don't understand your concerns about "have to be defined by each current host".  Can you please shed some light on it?
>
> It is required in aclinux.h, and thus it is required in every host-dependent configuration file (acfreebsd.h, acmacosx.h, acnetbsd.h, achaiku.h, etc.) I would rather not force these host-specific header files to change.
> Bob
>
>
> #ifdef CONFIG_PCI
> #define ACPI_PCI_CONFIGURED
> #endif
>
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
> _______________________________________________
> Devel mailing list -- devel@acpica.org
> To unsubscribe send an email to devel-leave@acpica.org %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
