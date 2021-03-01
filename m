Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D865E3281E5
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Mar 2021 16:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhCAPL7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Mar 2021 10:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhCAPLG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Mar 2021 10:11:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8162C061788;
        Mon,  1 Mar 2021 07:10:25 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id jt13so28865041ejb.0;
        Mon, 01 Mar 2021 07:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=enXaxN7vLjCKktrl/cIhndbrb+wAz+tHQLfWMwIVKVs=;
        b=o2eS5hjNq9EJW8m9h8VpdR+nysBJ9HUZSZ5hotTvP+/D5pwfgrjFZ3OIqiQSyXxq5+
         FZjEO0J58rvV8d1U7UHu7zQlOOdSq8mojW6ER6+VSo54nzMMfIJ0dNDpmlmIaRtrBMOe
         io3ILdk+if+8KqItRzOs989+gjqTfkTOfRMxD48B7nwgbFvVS1BwL9fwmcgMp0vZDp0O
         ny2D8Vmzfix5u2Yt+tayUgpR4sSPyrKf8BZAIXFEgq2SraCJIA1lOt/OFnkQ8xf7xRmD
         fXwflv57g4wOmG+zYLiWk1WEMDzmi2AOZ9lr2YHyWKiWwVobqZiGYtHXtMBBj1mx+w8T
         616g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=enXaxN7vLjCKktrl/cIhndbrb+wAz+tHQLfWMwIVKVs=;
        b=O1W08/6vWgi59qScJNLvu7/za2JlGH4UmY59lx4bRdLFdYgB5TMc/us3m9uU+e/cGJ
         Ev+BdRkN5jBTeSnCKb6sQeFgNyt0zf4woOOUoaC80vmD2cGU1uN7BIyGRZrlPU5mA/Nk
         NxwfWW6+g5XwpNZXLY5/6OWy1hs2lRzHf1+gnLKjovYp1a5EXEcIDzKcSordmFVhhY7N
         TAD7CO6a6HqQNtns3+M1E0J7LZTAqW4UhzZAS+oni+PCD09rByLZY89Ok194P0ij/6sZ
         N2dQs8GnKfH2ktBiAfqLko78LthKkZiCH0+WKiiktUrUVjHMudoMQ8noah1UfMkYRHO8
         FNVQ==
X-Gm-Message-State: AOAM531JuYTOnQcGsvRfzXGsKoMEwxmaZohcMiPFRGPRfA3xFgRCfMIZ
        q9dVX4XsBWnlS8gOzkaInuS7cB5U4TZEdOBjAIM=
X-Google-Smtp-Source: ABdhPJw8djonXCvR9CJVa11zygfFMqpGLyPy1S2bttKHAvBsXRHRqyouqXeNjz0xyyUeOxOTmS8yer80djwsLnnAz18=
X-Received: by 2002:a17:906:d1d5:: with SMTP id bs21mr16461935ejb.242.1614611424374;
 Mon, 01 Mar 2021 07:10:24 -0800 (PST)
MIME-Version: 1.0
References: <20210209031744.26474-1-weidongcui@gmail.com> <CAJZ5v0ifzqR90BJY3u6NGvMLuVn8YApLZH=oA5COcmjs_GKFqQ@mail.gmail.com>
 <CADFYyO63S4xZHJh9Cw1NYa7W=D8h=ZtUG1qPeLxfQ88kvW7MRQ@mail.gmail.com> <MWHPR11MB159925DE73F89A71D5E67113F0859@MWHPR11MB1599.namprd11.prod.outlook.com>
In-Reply-To: <MWHPR11MB159925DE73F89A71D5E67113F0859@MWHPR11MB1599.namprd11.prod.outlook.com>
Reply-To: weidongcui@gmail.com
From:   Weidong Cui <weidongcui@gmail.com>
Date:   Mon, 1 Mar 2021 07:10:13 -0800
Message-ID: <CADFYyO6STKPEgnGVJiAAhXXKSaFEHD2h6dcJPgYMEHRtrnOKCQ@mail.gmail.com>
Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces
 only when ACPI_PCI_CONFIGURED is defined
To:     "Kaneda, Erik" <erik.kaneda@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Xinyang Ge <aegiryy@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

> Hi, I=E2=80=99ll take a look next week.. Sorry about the delay

Hi Erik,

I would like to gently ping you about this patch.  Please let us know
if you have any questions.

Thanks!
Weidong

>
> From: Weidong Cui <weidongcui@gmail.com>
> Sent: Wednesday, February 17, 2021 6:55 PM
> To: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Moore, Robert <robert.moore@intel.com>; Kaneda, Erik <erik.kaneda@int=
el.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len Brown <lenb@ke=
rnel.org>; Xinyang Ge <aegiryy@gmail.com>; ACPI Devel Maling List <linux-ac=
pi@vger.kernel.org>; open list:ACPI COMPONENT ARCHITECTURE (ACPICA) <devel@=
acpica.org>; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default=
_address_spaces only when ACPI_PCI_CONFIGURED is defined
>
>
>
> Erik and Bob, please let us know if you have any questions or comments.
>
>
>
> Thanks,
>
> Weidong
>
>
>
> On Tue, Feb 9, 2021 at 6:35 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Tue, Feb 9, 2021 at 4:22 AM Weidong Cui <weidongcui@gmail.com> wrote:
> >
> > Signed-off-by: Weidong Cui <weidongcui@gmail.com>
> > Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
>
> ACPICA material, left to Erik & Bob, thanks!
>
> > ---
> >  drivers/acpi/acpica/evhandler.c | 2 ++
> >  include/acpi/acconfig.h         | 4 ++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evha=
ndler.c
> > index 5884eba04..4c25ad433 100644
> > --- a/drivers/acpi/acpica/evhandler.c
> > +++ b/drivers/acpi/acpica/evhandler.c
> > @@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
> >  u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] =3D {
> >         ACPI_ADR_SPACE_SYSTEM_MEMORY,
> >         ACPI_ADR_SPACE_SYSTEM_IO,
> > +#ifdef ACPI_PCI_CONFIGURED
> >         ACPI_ADR_SPACE_PCI_CONFIG,
> > +#endif
> >         ACPI_ADR_SPACE_DATA_TABLE
> >  };
> >
> > diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
> > index a225eff49..790999028 100644
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
> >
