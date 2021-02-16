Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADBE31CACD
	for <lists+linux-acpi@lfdr.de>; Tue, 16 Feb 2021 14:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBPM7e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 16 Feb 2021 07:59:34 -0500
Received: from mail-oo1-f44.google.com ([209.85.161.44]:33618 "EHLO
        mail-oo1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhBPM7b (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Feb 2021 07:59:31 -0500
Received: by mail-oo1-f44.google.com with SMTP id f1so2260750oou.0;
        Tue, 16 Feb 2021 04:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVzLBkqKt0MyMwotNPEi8xMZ2SypGbVfWBR5eQRTmO0=;
        b=TSrlLp/dLEvzVgYJtBCOI3GotDN81ZyYyNXCWTYNpHQgk7Li5hOwwdA5DI2aVSvN9u
         QICOgn7PbSKOcD4TmUPyNR7oKuxBs3DRmjIHypg4EVgbNimg6pKuT5bwMw7moz4dwLlL
         gjdt7k5aWaERMGI3+fJDXSrlHu2OJ9hawJ1IIJ519xcScgkh+VYkKXqvBJEeJYysa/jh
         YXE+7Ldl1Zi4IScqJWUOTLySBilR7SJVmtB2c1olcSBMQ1p5so5ih9WB4v9f2GCIdtQX
         90JznuDtxze58Ae7oSVog6crOzMwV4EJrKQef2q+3GOVSCtmHuJyt0kO8hHSu38Bx9ch
         Kc3w==
X-Gm-Message-State: AOAM533dFVUWMFTeNpqtYrlApLDE2W6QZi7whbG0yNmAx4DrvYCjd2vI
        GNT/Gs4D//cYdXj1Xg9+ht5WAUkYOp5oeLp67ns=
X-Google-Smtp-Source: ABdhPJxqORgG+iXS2MUSd76bl5TBZKlc/qcbt9O7R3tRFXJ0lESsAEHwXxj7DFW88YmAQPIcXwkV95yEjue34nqZXjY=
X-Received: by 2002:a4a:ab08:: with SMTP id i8mr13952968oon.40.1613480328418;
 Tue, 16 Feb 2021 04:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com>
 <CAMuHMdWFp_teT5Lgxe6BOpOb4UMM2_4FrKJm-2C6kuCH2YUMrw@mail.gmail.com> <CAGETcx9AZct4h0AdjbNzF5vjoYxT+M+zJ2ddsEN5SV9ALqV48A@mail.gmail.com>
In-Reply-To: <CAGETcx9AZct4h0AdjbNzF5vjoYxT+M+zJ2ddsEN5SV9ALqV48A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 16 Feb 2021 13:58:37 +0100
Message-ID: <CAMuHMdULCQrjba0sM3wUFdPDTB4Txh3LVY-8ACq6P_vFJvk+SA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Saravana Kannan <saravanak@google.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Mon, Feb 15, 2021 at 10:57 PM Saravana Kannan <saravanak@google.com> wrote:
> On Mon, Feb 15, 2021 at 7:16 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > >   1. R-Car Gen2 (Koelsch), R-Car Gen3 (Salvator-X(S), Ebisu).
> > > >
> > > >       - Commit 2dfc564bda4a31bc ("soc: renesas: rcar-sysc: Mark device
> > > >         node OF_POPULATED after init") is no longer needed (but already
> > > >         queued for v5.12 anyway)
> > >
> > > Rob doesn't like the proliferation of OF_POPULATED and we don't need
> > > it anymore, so maybe work it out with him? It's a balance between some
> > > wasted memory (struct device(s)) vs not proliferating OF_POPULATED.
> >
> > > >   2. SH/R-Mobile AG5 (kzm9g), APE6 (ape6evm), A1 (armadillo800-eva)
> > > >
> > > >       - "PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
> > > >         reset handling" is no longer needed
> > > >         https://lore.kernel.org/linux-arm-kernel/20210205133319.1921108-1-geert+renesas@glider.be/
> > >
> > > Good to see more evidence that this series is fixing things at a more
> > > generic level.
> >
> > I spoke too soon: if CONFIG_POWER_RESET_RMOBILE=n,
> > booting fails again, as everything is waiting on the system controller,
> > which never becomes available.
> > Rcar-sysc doesn't suffer from this problem, cfr. above.
> > Perhaps because the rmobile-sysc bindings use a hierarchical instead
> > of a linear PM domain description, and thus consumers point to the
> > children of the system controller node?
> > Cfr. system-controller@e6180000 in arch/arm/boot/dts/r8a7740.dtsi.
>
> Ok, I see what's going on. The problem is that the "power domain"
> fwnode being registered is not the node that contains the "compatible"
> property and becomes a device. So this patch[1] is not helping here.
> Fix is to do something like this (to avoid using OF_POPULATED flag and
> breaking reset):
>
> diff --git a/drivers/soc/renesas/rmobile-sysc.c
> b/drivers/soc/renesas/rmobile-sysc.c
> index 9046b8c933cb..b7e66139ef7d 100644
> --- a/drivers/soc/renesas/rmobile-sysc.c
> +++ b/drivers/soc/renesas/rmobile-sysc.c
> @@ -344,6 +344,7 @@ static int __init rmobile_init_pm_domains(void)
>                         of_node_put(np);
>                         break;
>                 }
> +               fwnode_dev_initialized(&np->fwnode, true);
>         }
>
>         put_special_pds();
>
> Can you give it a shot?

Thanks, works.  Patch sent
"[PATCH v2] soc: renesas: rmobile-sysc: Mark fwnode when PM domain is added"
https://lore.kernel.org/linux-arm-kernel/20210216123958.3180014-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
