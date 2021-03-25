Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36249348686
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 02:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhCYBpe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 21:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbhCYBpE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 21:45:04 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E503C06174A;
        Wed, 24 Mar 2021 18:45:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt15so273601ejb.12;
        Wed, 24 Mar 2021 18:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UFKtpzNTUw0dZnmqUKCddBhitT5Nzt1XRd2rQyF5h/A=;
        b=StxL8O/JXAprzxFi/JoWeK6y6WR4zWuPSyMoTcJggPhfE1B9XvOlK7K/VuvD/4p87H
         fgp6JyfXU2IIqLOa1pZ5ZhBIm86FXscuw8qbufCnI/6jKXAoVRxQDo/vDg//hXcszo6v
         /YyuxCttia/vK/CBlpra+SpOu4viuAeSCGe9ccpYwutatH+1PRr030zPFDpxDcrJYam+
         NkPOe2ZuZes2FbDBCxfaM5akiBBS5wjFDXSieW0/YDTQhyu+TmS905RZzC5L1lmlsb4B
         UD1U7OYlYW5MV5Iyzebr07wM+8NfCmL/IIcKLS0OVrkeVAGVjpboRMKc8Q+2i0yph6AU
         cUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UFKtpzNTUw0dZnmqUKCddBhitT5Nzt1XRd2rQyF5h/A=;
        b=O1NFx+pE/cKmT9GmC3zuijqprVTbsI1nlPYGYfFszL+vD4g6esa0FoBwP644EVf9Hr
         Rmf5x45JaHoqAxGM3xbeVU17H6t8YQCCPamyVph1SYsL+llOUhCOeWEgl2ov8M+Dl2pE
         oPnH2ER49aQl7wDvT1BemwhseoxXk6fez2/CigZ9gLyyNnVsfYiGjGk1vStgTSJimDww
         oq5mmDw2Etj4Q1cRU+ucr1q2l3myZCdxXjXfUw+5ot26vHXHjU6ypR6EgWPyawvHBDJj
         zsb7hn2Y2jtu2kQQi6/BE3l6JEeKgRFYlADnRL0mu5t4A+67+7Sqisgsj7Lvq9JKJ9AH
         UfLA==
X-Gm-Message-State: AOAM533vsvgDSrlY/ycD+1XoEFHbaK9tt2Ml5qzOYH6WCKdB9bGFijCD
        C+OH5I6++0UmXWJhiCJx1W6kdjpJ1qIQeF9hVjE=
X-Google-Smtp-Source: ABdhPJyQbgFaw+TFMYupQqo+/aqax3pYOmC2+EiGYI6eAR1yOda786c4U1Je/qAIiPGqDL7x+/LZ/7CBbu/BfI8mrYQ=
X-Received: by 2002:a17:906:6044:: with SMTP id p4mr6832160ejj.82.1616636703059;
 Wed, 24 Mar 2021 18:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com> <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
 <BYAPR11MB3256FD804E3F3CE584B6D3B387979@BYAPR11MB3256.namprd11.prod.outlook.com>
 <BYAPR11MB3256B80EC10AF4965083CCD087969@BYAPR11MB3256.namprd11.prod.outlook.com>
 <CADFYyO5B2Mf50+gu6Dr7W3y9hGh9P2wOjyiYqJwLKcX_2pX8QA@mail.gmail.com>
In-Reply-To: <CADFYyO5B2Mf50+gu6Dr7W3y9hGh9P2wOjyiYqJwLKcX_2pX8QA@mail.gmail.com>
Reply-To: weidongcui@gmail.com
From:   Weidong Cui <weidongcui@gmail.com>
Date:   Wed, 24 Mar 2021 18:44:52 -0700
Message-ID: <CADFYyO6JwZvS6SAy5+QF65X0pQvpT2Hse+mnC9L8ronb-TieTA@mail.gmail.com>
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

Hi Bob and Erik,

> Hi Bob,
>
> Thank you very much for your new suggestion!  Let me make sure I understand it.
>
> 1. We should move the following define from aclinux.h to acconfig.h.
>
> #ifdef CONFIG_PCI
> #define ACPI_PCI_CONFIGURED
> #endif
>
> 2. We should add a comment there to "document why and when it should
> be removed".
> I don't really know "why and when" since I'm not an expert on ACPI (we
> were just trying
> to fix a bug :-)).
>
> Thanks!
> Weidong

Hi Bob and Erik,

I would like to ping you about my two questions above.  Can you please
advise on how I should proceed?

Thanks!
Weidong

>
> > -----Original Message-----
> > From: Moore, Robert <robert.moore@intel.com>
> > Sent: Thursday, March 04, 2021 9:37 AM
> > To: weidongcui@gmail.com
> > Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org
> > Subject: [Devel] Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
> >
> >
> >
> > -----Original Message-----
> > From: Weidong Cui <weidongcui@gmail.com>
> > Sent: Thursday, March 04, 2021 9:06 AM
> > To: Moore, Robert <robert.moore@intel.com>
> > Cc: Kaneda, Erik <erik.kaneda@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
> > Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
> >
> > > Well, I don't like the fact that PCI_CONFIGURED would have to be defined by each current host:
> > >
> > > > +#ifdef ACPI_PCI_CONFIGURED
> > >
> > > I would rather the logic be reversed:
> > >
> > > > +#ifdef ACPI_PCI_NOT_CONFIGURED
> >
> > Thank you for the comments, Erik and Bob!
> >
> > ACPI_PCI_CONFIGURED is defined in aclinux.h (see below) and used in several places in evhandler.c and exregion.c.
> > I'm not sure why we want to introduce ACPI_PCI_NOT_CONFIGURED.  Bob, I don't understand your concerns about "have to be defined by each current host".  Can you please shed some light on it?
> >
> > It is required in aclinux.h, and thus it is required in every host-dependent configuration file (acfreebsd.h, acmacosx.h, acnetbsd.h, achaiku.h, etc.) I would rather not force these host-specific header files to change.
> > Bob
> >
> >
> > #ifdef CONFIG_PCI
> > #define ACPI_PCI_CONFIGURED
> > #endif
> >
> > > -----Original Message-----
> > > From: Kaneda, Erik <erik.kaneda@intel.com>
> > > Sent: Wednesday, March 03, 2021 10:29 AM
> > > To: Weidong Cui <weidongcui@gmail.com>; Moore, Robert
> > > <robert.moore@intel.com>; Wysocki, Rafael J
> > > <rafael.j.wysocki@intel.com>
> > > Cc: Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org;
> > > devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown
> > > <lenb@kernel.org>
> > > Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> > > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> > > defined
> > >
> > > This looks good to me. Bob, do you have any comments?
> > >
> > > Erik
> > >
> > > > -----Original Message-----
> > > > From: Weidong Cui <weidongcui@gmail.com>
> > > > Sent: Monday, February 8, 2021 7:18 PM
> > > > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > > > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > > > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> > > > Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge
> > > > <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > > > linux- kernel@vger.kernel.org
> > > > Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> > > > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> > > > defined
> > > >
> > > > Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> > > > Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> > > > ---
> > > >  drivers/acpi/acpica/evhandler.c | 2 ++
> > > >  include/acpi/acconfig.h         | 4 ++++
> > > >  2 files changed, 6 insertions(+)
> > > >
> > > > diff --git a/drivers/acpi/acpica/evhandler.c
> > > > b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
> > > > --- a/drivers/acpi/acpica/evhandler.c
> > > > +++ b/drivers/acpi/acpica/evhandler.c
> > > > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> > > >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
> > > >       ACPI_ADR_SPACE_SYSTEM_MEMORY,
> > > >       ACPI_ADR_SPACE_SYSTEM_IO,
> > > > +#ifdef ACPI_PCI_CONFIGURED
> > > >       ACPI_ADR_SPACE_PCI_CONFIG,
> > > > +#endif
> > > >       ACPI_ADR_SPACE_DATA_TABLE
> > > >  };
> > > >
> > > > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> > > > a225eff49..790999028 100644
> > > > --- a/include/acpi/acconfig.h
> > > > +++ b/include/acpi/acconfig.h
> > > > @@ -162,7 +162,11 @@
> > > >  /* Maximum space_ids for Operation Regions */
> > > >
> > > >  #define ACPI_MAX_ADDRESS_SPACE          255
> > > > +#ifdef ACPI_PCI_CONFIGURED
> > > >  #define ACPI_NUM_DEFAULT_SPACES         4
> > > > +#else
> > > > +#define ACPI_NUM_DEFAULT_SPACES         3
> > > > +#endif
> > > >
> > > >  /* Array sizes.  Used for range checking also */
> > > >
> > > > --
> > > > 2.24.3 (Apple Git-128)
> > >
> > _______________________________________________
> > Devel mailing list -- devel@acpica.org
> > To unsubscribe send an email to devel-leave@acpica.org %(web_page_url)slistinfo%(cgiext)s/%(_internal_name)s
