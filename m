Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E40D832D853
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Mar 2021 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238917AbhCDRHc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Mar 2021 12:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbhCDRHQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Mar 2021 12:07:16 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DC7C061574;
        Thu,  4 Mar 2021 09:06:36 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p8so24487567ejb.10;
        Thu, 04 Mar 2021 09:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=rvG/6uXHWO/DCCgAsK5tg0uSpo1rPYAaqeQP/DGHnko=;
        b=gDM78EtbblVjqflJg2kyaom50IGZXWOSH1zoIkvCAfDuHN13/APE61JuEXPRTl4TeN
         3vcgOmR6QLIwYUmz8/49pGQBftTnFl/eyFGir+cTN1t0X3W6CM3OLF7zPei/6lVQABJO
         sii+JNZiMVFo50pdmuQDMoSuwkXS2cGk4qXBFgOcOnqBevpTbTyqv+nVtcN9sT+l6xAS
         Z4TJFyKI1qhYwLYcb8zGEospPT4Cof1Z60ZpesG3ooVQEoHJKBxaTZYMQd+RBhxbb5Fj
         pmef1bXt0JM08wUC3+A0BAhfpcFjI2T4Sj398nvKmn4Jhffp50Xs2XGgi/CZepBvKpf+
         h/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=rvG/6uXHWO/DCCgAsK5tg0uSpo1rPYAaqeQP/DGHnko=;
        b=cP2rn5lzzuTA/s+qsg0bLNPlieZthjBFoxUo1Blozme5Z6gUrHbNaBnnZgD8qaIyRP
         +/HRfECVp4RPQAtOEb3r+a+rnT7mN9N2MaECkZtOti7LqkJ5HfVQUdaLO9TeeuhIznli
         iSiPZlE7rzAr/iC3vlsG5QUfFUqllLvfLpDfcJlulHlhan3w/by6jZMBXIUWTCcnWIbX
         btmhTWor1019xgwMnyYD5RNx99uu46phMHdOH3rhlvp+okyLbZ6lvozvfNLW8JZWO5Gp
         D9b4OpiRniWvG8xcpUa0Eg9JS0aPaN+KDYBPEkyh8pWCSQcZTv09AZcZJQS23YFQvqBE
         t2VA==
X-Gm-Message-State: AOAM530xLOc6sVBEaosvwRbrC7RBUsycWW8g+DQoHtmYiwKWvyepixxh
        KkQJgGXhWdgviRiUsRwYNNGjUh4zZhOLg8sogjA=
X-Google-Smtp-Source: ABdhPJySeG1V/kNNkPl3s98FuYhnAaK6ArMh/us+UH7P9i1WOOZ+tjlUwviqRAK0KrPxMUUzBlt4h66/ZMUEGN4+QQs=
X-Received: by 2002:a17:906:11d1:: with SMTP id o17mr5291307eja.517.1614877594638;
 Thu, 04 Mar 2021 09:06:34 -0800 (PST)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com> <MWHPR11MB1599D81078925FFD128E954EF0989@MWHPR11MB1599.namprd11.prod.outlook.com>
 <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
In-Reply-To: <BYAPR11MB325658379DB73F6EEDD6C76F87979@BYAPR11MB3256.namprd11.prod.outlook.com>
Reply-To: weidongcui@gmail.com
From:   Weidong Cui <weidongcui@gmail.com>
Date:   Thu, 4 Mar 2021 09:06:22 -0800
Message-ID: <CADFYyO73g8LkgwZv4m5N2bXq0XcZru4m9+K0uudCLmcp7yewpQ@mail.gmail.com>
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

> Well, I don't like the fact that PCI_CONFIGURED would have to be defined by each current host:
>
> > +#ifdef ACPI_PCI_CONFIGURED
>
> I would rather the logic be reversed:
>
> > +#ifdef ACPI_PCI_NOT_CONFIGURED

Thank you for the comments, Erik and Bob!

ACPI_PCI_CONFIGURED is defined in aclinux.h (see below) and used in
several places in evhandler.c and exregion.c.
I'm not sure why we want to introduce ACPI_PCI_NOT_CONFIGURED.  Bob, I
don't understand your concerns
about "have to be defined by each current host".  Can you please shed
some light on it?

#ifdef CONFIG_PCI
#define ACPI_PCI_CONFIGURED
#endif

> -----Original Message-----
> From: Kaneda, Erik <erik.kaneda@intel.com>
> Sent: Wednesday, March 03, 2021 10:29 AM
> To: Weidong Cui <weidongcui@gmail.com>; Moore, Robert <robert.moore@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>
> Cc: Xinyang Ge <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; Len Brown <lenb@kernel.org>
> Subject: RE: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
>
> This looks good to me. Bob, do you have any comments?
>
> Erik
>
> > -----Original Message-----
> > From: Weidong Cui <weidongcui@gmail.com>
> > Sent: Monday, February 8, 2021 7:18 PM
> > To: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik
> > <erik.kaneda@intel.com>; Wysocki, Rafael J
> > <rafael.j.wysocki@intel.com>; Len Brown <lenb@kernel.org>
> > Cc: Weidong Cui <weidongcui@gmail.com>; Xinyang Ge
> > <aegiryy@gmail.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
> > linux- kernel@vger.kernel.org
> > Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in
> > acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is
> > defined
> >
> > Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> > Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
> > ---
> >  drivers/acpi/acpica/evhandler.c | 2 ++
> >  include/acpi/acconfig.h         | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/evhandler.c
> > b/drivers/acpi/acpica/evhandler.c index 5884eba04..4c25ad433 100644
> > --- a/drivers/acpi/acpica/evhandler.c
> > +++ b/drivers/acpi/acpica/evhandler.c
> > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
> >       ACPI_ADR_SPACE_SYSTEM_MEMORY,
> >       ACPI_ADR_SPACE_SYSTEM_IO,
> > +#ifdef ACPI_PCI_CONFIGURED
> >       ACPI_ADR_SPACE_PCI_CONFIG,
> > +#endif
> >       ACPI_ADR_SPACE_DATA_TABLE
> >  };
> >
> > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h index
> > a225eff49..790999028 100644
> > --- a/include/acpi/acconfig.h
> > +++ b/include/acpi/acconfig.h
> > @@ -162,7 +162,11 @@
> >  /* Maximum space_ids for Operation Regions */
> >
> >  #define ACPI_MAX_ADDRESS_SPACE          255
> > +#ifdef ACPI_PCI_CONFIGURED
> >  #define ACPI_NUM_DEFAULT_SPACES         4
> > +#else
> > +#define ACPI_NUM_DEFAULT_SPACES         3
> > +#endif
> >
> >  /* Array sizes.  Used for range checking also */
> >
> > --
> > 2.24.3 (Apple Git-128)
>
