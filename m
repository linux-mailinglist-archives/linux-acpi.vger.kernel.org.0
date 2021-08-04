Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8053E0534
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Aug 2021 18:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhHDQEC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Aug 2021 12:04:02 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38588 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbhHDQD4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2021 12:03:56 -0400
Received: by mail-oi1-f174.google.com with SMTP id u25so3407395oiv.5;
        Wed, 04 Aug 2021 09:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tKSdWR6LuP7/2+zwPkH2rMp+y8qOWa7f1FszBegCdng=;
        b=Pnr3VZ/Zzim2ilv4g2t5ExrJQvxpVtJA+gUVhl4SmHrY5nv8V9CAUPrBfUfrGtBwuC
         2wRa3FYGQyHJZwAnqlbS7I53AGVX++qyg3a3lN4zw3Gvh5UaRnZ+l5QT5GjHqAS36RLv
         qWVcbuxgEeGsu5nz6VEe2098tYYumHDGCC4GMY8A039sASw6VQqhgATemA1QjO7piB0k
         fJkP6IqPZyroJVWEKk8QRV7MmUuCZcV3vZFPqPiyq7qQuzHIp9yq7Re4hxdbXaRaXJc7
         kZuDq0IPF1j0du6x1Vbh40bOyGxUkiQ9A1DuJ9F+bOvdDPuEg4sm0V+2caj25Rk6O7Ix
         It+w==
X-Gm-Message-State: AOAM531L5RbLaiE3ntJqU4tjJEu7lF7Tl5ENiAJSS2Zn0S9f01ThCRqp
        z6uR4K7O7Uz1LYGrsASe2hVDZxJRWLw2O4ID/EM=
X-Google-Smtp-Source: ABdhPJwb+AFSuQFd9Qt4IaQNDfDv9oeVcM8t2rpq2EZ4QBkdI/asefkWq9s+RrEs9nAXHu5UoYJMOy8tNNLKUXyy6Qo=
X-Received: by 2002:a05:6808:198c:: with SMTP id bj12mr136049oib.71.1628093023170;
 Wed, 04 Aug 2021 09:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210722193450.35321-1-andriy.shevchenko@linux.intel.com> <CAJZ5v0h6OQDB2hijnfinwpwpo_483UkcjGi8jYX4J6VETqLBEA@mail.gmail.com>
In-Reply-To: <CAJZ5v0h6OQDB2hijnfinwpwpo_483UkcjGi8jYX4J6VETqLBEA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Aug 2021 18:03:31 +0200
Message-ID: <CAJZ5v0iCmu+P=phePuNeWC4MgMJ08hMtJrKoCUAzjSSnxBzObw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: x86: Rename clk-lpt to more specific clk-lpss-atom
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 23, 2021 at 3:40 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jul 22, 2021 at 9:34 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The LPT stands for Lynxpoint PCH. However the driver is used on a few
> > Intel Atom SoCs. Rename it to reflect this in a way how another clock
> > driver, i.e. clk-pmc-atom, is called.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >
> > Good to go either via ACPI or CCF tree.
>
> In case you want the latter:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Assuming that this hasn't been picked up, I'm going to apply it as
5.15 material.

Thanks!

> >  drivers/acpi/acpi_lpss.c                       |  6 ++++--
> >  drivers/clk/x86/Makefile                       |  2 +-
> >  drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} | 12 ++++++------
> >  include/linux/platform_data/x86/clk-lpss.h     |  2 +-
> >  4 files changed, 12 insertions(+), 10 deletions(-)
> >  rename drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} (76%)
> >
> > diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> > index 894b7e6ae144..7f163074e4e4 100644
> > --- a/drivers/acpi/acpi_lpss.c
> > +++ b/drivers/acpi/acpi_lpss.c
> > @@ -385,7 +385,9 @@ static struct platform_device *lpss_clk_dev;
> >
> >  static inline void lpt_register_clock_device(void)
> >  {
> > -       lpss_clk_dev = platform_device_register_simple("clk-lpt", -1, NULL, 0);
> > +       lpss_clk_dev = platform_device_register_simple("clk-lpss-atom",
> > +                                                      PLATFORM_DEVID_NONE,
> > +                                                      NULL, 0);
> >  }
> >
> >  static int register_device_clock(struct acpi_device *adev,
> > @@ -1337,7 +1339,7 @@ void __init acpi_lpss_init(void)
> >         const struct x86_cpu_id *id;
> >         int ret;
> >
> > -       ret = lpt_clk_init();
> > +       ret = lpss_atom_clk_init();
> >         if (ret)
> >                 return;
> >
> > diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> > index 18564efdc651..1244c4e568ff 100644
> > --- a/drivers/clk/x86/Makefile
> > +++ b/drivers/clk/x86/Makefile
> > @@ -1,6 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
> >  obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  += clk-fch.o
> > -clk-x86-lpss-objs              := clk-lpt.o
> > +clk-x86-lpss-y                 := clk-lpss-atom.o
> >  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
> >  obj-$(CONFIG_CLK_LGM_CGU)      += clk-cgu.o clk-cgu-pll.o clk-lgm.o
> > diff --git a/drivers/clk/x86/clk-lpt.c b/drivers/clk/x86/clk-lpss-atom.c
> > similarity index 76%
> > rename from drivers/clk/x86/clk-lpt.c
> > rename to drivers/clk/x86/clk-lpss-atom.c
> > index fbe9fd3ed948..aa9d0bb98f8b 100644
> > --- a/drivers/clk/x86/clk-lpt.c
> > +++ b/drivers/clk/x86/clk-lpss-atom.c
> > @@ -13,7 +13,7 @@
> >  #include <linux/platform_data/x86/clk-lpss.h>
> >  #include <linux/platform_device.h>
> >
> > -static int lpt_clk_probe(struct platform_device *pdev)
> > +static int lpss_atom_clk_probe(struct platform_device *pdev)
> >  {
> >         struct lpss_clk_data *drvdata;
> >         struct clk *clk;
> > @@ -34,14 +34,14 @@ static int lpt_clk_probe(struct platform_device *pdev)
> >         return 0;
> >  }
> >
> > -static struct platform_driver lpt_clk_driver = {
> > +static struct platform_driver lpss_atom_clk_driver = {
> >         .driver = {
> > -               .name = "clk-lpt",
> > +               .name = "clk-lpss-atom",
> >         },
> > -       .probe = lpt_clk_probe,
> > +       .probe = lpss_atom_clk_probe,
> >  };
> >
> > -int __init lpt_clk_init(void)
> > +int __init lpss_atom_clk_init(void)
> >  {
> > -       return platform_driver_register(&lpt_clk_driver);
> > +       return platform_driver_register(&lpss_atom_clk_driver);
> >  }
> > diff --git a/include/linux/platform_data/x86/clk-lpss.h b/include/linux/platform_data/x86/clk-lpss.h
> > index 207e1a317800..41df326583f9 100644
> > --- a/include/linux/platform_data/x86/clk-lpss.h
> > +++ b/include/linux/platform_data/x86/clk-lpss.h
> > @@ -15,6 +15,6 @@ struct lpss_clk_data {
> >         struct clk *clk;
> >  };
> >
> > -extern int lpt_clk_init(void);
> > +extern int lpss_atom_clk_init(void);
> >
> >  #endif /* __CLK_LPSS_H */
> > --
> > 2.30.2
> >
