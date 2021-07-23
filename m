Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB7A3D3B4F
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Jul 2021 15:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233488AbhGWNAE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Jul 2021 09:00:04 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:46966 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233486AbhGWNAE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Jul 2021 09:00:04 -0400
Received: by mail-ot1-f50.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso1207170ota.13;
        Fri, 23 Jul 2021 06:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EK7j/8f4gJtwvDFYwPxgaI/qysAXeirsjJ8IaeWGx4A=;
        b=DtI0+IUTfd6sCTqduX3k2nhToE3k9/m7fF/5yrI9QRa5ip1cV8A3iALPHVSLsPBO+z
         y4Rv5cqYgyjZpNsPEDIjPT9/njr41lVBT+lZuecNVVZRkl02attzZTSor3nb93wLdDPS
         bzxu+37+N++xr7u5KoB3GlSXnyq8msqFqIghaVETc08/VV7Poe4TjF7egJyhqRbg+UWX
         oFCUfB/hXr8PnPkH/0UzNylFKBI5WSpfcrygIk9zmtA8l77uxm8Si+J66gWJHUeyEQ5a
         LkPxKuNjjC/itLm1XJiB0yM9WhpxGZHObnVmPpmeikeVOGEF8pA6pqXilb/lCQtM+qG5
         jJiw==
X-Gm-Message-State: AOAM532B79Ky999GihIWvi+Rl6QrCHinQiGSmFIdTgXroGLYa/SH6raO
        Aidkl4bdfDjny0ePCVHrzJ7L/J8L08D6MdB3Ut3dJ/xu
X-Google-Smtp-Source: ABdhPJxBOZZg33/bX+Gj1drL35xj7bWjUJV3tMno5E8SowAWHUbHFlYrmLbxlMDTjkDck0noTY8oYgoTuzqltlVYAIE=
X-Received: by 2002:a9d:2968:: with SMTP id d95mr3048634otb.321.1627047625746;
 Fri, 23 Jul 2021 06:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210722193450.35321-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210722193450.35321-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 23 Jul 2021 15:40:14 +0200
Message-ID: <CAJZ5v0h6OQDB2hijnfinwpwpo_483UkcjGi8jYX4J6VETqLBEA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] clk: x86: Rename clk-lpt to more specific clk-lpss-atom
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
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

On Thu, Jul 22, 2021 at 9:34 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The LPT stands for Lynxpoint PCH. However the driver is used on a few
> Intel Atom SoCs. Rename it to reflect this in a way how another clock
> driver, i.e. clk-pmc-atom, is called.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> Good to go either via ACPI or CCF tree.

In case you want the latter:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  drivers/acpi/acpi_lpss.c                       |  6 ++++--
>  drivers/clk/x86/Makefile                       |  2 +-
>  drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} | 12 ++++++------
>  include/linux/platform_data/x86/clk-lpss.h     |  2 +-
>  4 files changed, 12 insertions(+), 10 deletions(-)
>  rename drivers/clk/x86/{clk-lpt.c => clk-lpss-atom.c} (76%)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 894b7e6ae144..7f163074e4e4 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -385,7 +385,9 @@ static struct platform_device *lpss_clk_dev;
>
>  static inline void lpt_register_clock_device(void)
>  {
> -       lpss_clk_dev = platform_device_register_simple("clk-lpt", -1, NULL, 0);
> +       lpss_clk_dev = platform_device_register_simple("clk-lpss-atom",
> +                                                      PLATFORM_DEVID_NONE,
> +                                                      NULL, 0);
>  }
>
>  static int register_device_clock(struct acpi_device *adev,
> @@ -1337,7 +1339,7 @@ void __init acpi_lpss_init(void)
>         const struct x86_cpu_id *id;
>         int ret;
>
> -       ret = lpt_clk_init();
> +       ret = lpss_atom_clk_init();
>         if (ret)
>                 return;
>
> diff --git a/drivers/clk/x86/Makefile b/drivers/clk/x86/Makefile
> index 18564efdc651..1244c4e568ff 100644
> --- a/drivers/clk/x86/Makefile
> +++ b/drivers/clk/x86/Makefile
> @@ -1,6 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_PMC_ATOM)         += clk-pmc-atom.o
>  obj-$(CONFIG_X86_AMD_PLATFORM_DEVICE)  += clk-fch.o
> -clk-x86-lpss-objs              := clk-lpt.o
> +clk-x86-lpss-y                 := clk-lpss-atom.o
>  obj-$(CONFIG_X86_INTEL_LPSS)   += clk-x86-lpss.o
>  obj-$(CONFIG_CLK_LGM_CGU)      += clk-cgu.o clk-cgu-pll.o clk-lgm.o
> diff --git a/drivers/clk/x86/clk-lpt.c b/drivers/clk/x86/clk-lpss-atom.c
> similarity index 76%
> rename from drivers/clk/x86/clk-lpt.c
> rename to drivers/clk/x86/clk-lpss-atom.c
> index fbe9fd3ed948..aa9d0bb98f8b 100644
> --- a/drivers/clk/x86/clk-lpt.c
> +++ b/drivers/clk/x86/clk-lpss-atom.c
> @@ -13,7 +13,7 @@
>  #include <linux/platform_data/x86/clk-lpss.h>
>  #include <linux/platform_device.h>
>
> -static int lpt_clk_probe(struct platform_device *pdev)
> +static int lpss_atom_clk_probe(struct platform_device *pdev)
>  {
>         struct lpss_clk_data *drvdata;
>         struct clk *clk;
> @@ -34,14 +34,14 @@ static int lpt_clk_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> -static struct platform_driver lpt_clk_driver = {
> +static struct platform_driver lpss_atom_clk_driver = {
>         .driver = {
> -               .name = "clk-lpt",
> +               .name = "clk-lpss-atom",
>         },
> -       .probe = lpt_clk_probe,
> +       .probe = lpss_atom_clk_probe,
>  };
>
> -int __init lpt_clk_init(void)
> +int __init lpss_atom_clk_init(void)
>  {
> -       return platform_driver_register(&lpt_clk_driver);
> +       return platform_driver_register(&lpss_atom_clk_driver);
>  }
> diff --git a/include/linux/platform_data/x86/clk-lpss.h b/include/linux/platform_data/x86/clk-lpss.h
> index 207e1a317800..41df326583f9 100644
> --- a/include/linux/platform_data/x86/clk-lpss.h
> +++ b/include/linux/platform_data/x86/clk-lpss.h
> @@ -15,6 +15,6 @@ struct lpss_clk_data {
>         struct clk *clk;
>  };
>
> -extern int lpt_clk_init(void);
> +extern int lpss_atom_clk_init(void);
>
>  #endif /* __CLK_LPSS_H */
> --
> 2.30.2
>
