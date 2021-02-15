Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8F231C3D7
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbhBOV6U (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 16:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhBOV6S (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 16:58:18 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37941C061788
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 13:57:38 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id c131so3751231ybf.7
        for <linux-acpi@vger.kernel.org>; Mon, 15 Feb 2021 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sRa/U5Kzs1JI5RnyoYklyv1NRbU9v8LrTPHarr/PE8=;
        b=gJEho7HAFjs40VouEGob2eg5Oy9aEdcZUBjHihE6mZQzi6czZHwv0m73BpYkXKdo5q
         68ZV+goSq9Fae1dld8Dj2zZYLuDTZktAzE0ZwFkpES3da8W1hs5RObUljgUwwZubEMQR
         Ca4nrFf96n+Kq21fygN6AVWqtnC1b+1lh90Ad/OFDLwRqlp57eBni+kkmVmwYsQmfAjJ
         NcDt4L5//G6ue+WDbsA4Z4M/o7lFxOzbQQJ4D6/zpk72I1HGrEAZGi0vXqowaDBLiSCa
         tPx3s6gkUPD/Kyv6NGu1ljv+0hfUIqhnOIrU799/0jGVFl7RUVlE+Da+9mHdD+VFVUH6
         Lj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sRa/U5Kzs1JI5RnyoYklyv1NRbU9v8LrTPHarr/PE8=;
        b=CTpNudBol7qb8s2P63yyY6SK8Fv53loQouCVM/wXXxSx9F3TtpcM9NIQqIV2LSw+iy
         tgPqhMd4ZMqAF0tfM0FSlPNR26QbMIgONyt80s11zEmGasW+GUiKvZ68gKW/xnknJfYg
         19gkbhutdXw+AV8nXl2QRWUQRqROQugnJedhqNaN2w8Ssk9ryaTFTEeEiVR/0Ctdc851
         t/SFhLkriyKtlnjo4tXqOMAQVZVZz72kyAk/6Cw4hAK9aCubZ3A2FHl12T7uXxNeJ51p
         thXQaMRtk5h5jlh+RlABDaoU133aiIij3Ef6HGSMCZWlWAtr+xdTa6wFFyiYA5gPpSrT
         6Q7w==
X-Gm-Message-State: AOAM533XztWOdIcz6h6+39UtVkQXqKrusJgmBF9p93SsG0ZWD/ukd3T0
        OlUVgm1k7LOC06qPfvi07g5reOgOHwUiNmCItob4+Q==
X-Google-Smtp-Source: ABdhPJwKttGJ/WSxMO3AOYN0BMrFeAFmWmg7rlKUzB3nt2oaOmB07PQ56EVlNxhui2daNXPCPW1sMy0iGvA9c5ZrRD4=
X-Received: by 2002:a25:aa43:: with SMTP id s61mr27067882ybi.32.1613426257227;
 Mon, 15 Feb 2021 13:57:37 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
 <CAGETcx-668+uGigaOMcsvv00mo6o_eGPcH0YyD28OCVEyVbw+w@mail.gmail.com> <CAMuHMdWFp_teT5Lgxe6BOpOb4UMM2_4FrKJm-2C6kuCH2YUMrw@mail.gmail.com>
In-Reply-To: <CAMuHMdWFp_teT5Lgxe6BOpOb4UMM2_4FrKJm-2C6kuCH2YUMrw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 15 Feb 2021 13:57:00 -0800
Message-ID: <CAGETcx9AZct4h0AdjbNzF5vjoYxT+M+zJ2ddsEN5SV9ALqV48A@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Make fw_devlink=on more forgiving
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

On Mon, Feb 15, 2021 at 7:16 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Fri, Feb 12, 2021 at 4:00 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Thu, Feb 11, 2021 at 5:00 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >   1. R-Car Gen2 (Koelsch), R-Car Gen3 (Salvator-X(S), Ebisu).
> > >
> > >       - Commit 2dfc564bda4a31bc ("soc: renesas: rcar-sysc: Mark device
> > >         node OF_POPULATED after init") is no longer needed (but already
> > >         queued for v5.12 anyway)
> >
> > Rob doesn't like the proliferation of OF_POPULATED and we don't need
> > it anymore, so maybe work it out with him? It's a balance between some
> > wasted memory (struct device(s)) vs not proliferating OF_POPULATED.
>
> > >   2. SH/R-Mobile AG5 (kzm9g), APE6 (ape6evm), A1 (armadillo800-eva)
> > >
> > >       - "PATCH] soc: renesas: rmobile-sysc: Set OF_POPULATED and absorb
> > >         reset handling" is no longer needed
> > >         https://lore.kernel.org/linux-arm-kernel/20210205133319.1921108-1-geert+renesas@glider.be/
> >
> > Good to see more evidence that this series is fixing things at a more
> > generic level.
>
> I spoke too soon: if CONFIG_POWER_RESET_RMOBILE=n,
> booting fails again, as everything is waiting on the system controller,
> which never becomes available.
> Rcar-sysc doesn't suffer from this problem, cfr. above.
> Perhaps because the rmobile-sysc bindings use a hierarchical instead
> of a linear PM domain description, and thus consumers point to the
> children of the system controller node?
> Cfr. system-controller@e6180000 in arch/arm/boot/dts/r8a7740.dtsi.

Ok, I see what's going on. The problem is that the "power domain"
fwnode being registered is not the node that contains the "compatible"
property and becomes a device. So this patch[1] is not helping here.
Fix is to do something like this (to avoid using OF_POPULATED flag and
breaking reset):

diff --git a/drivers/soc/renesas/rmobile-sysc.c
b/drivers/soc/renesas/rmobile-sysc.c
index 9046b8c933cb..b7e66139ef7d 100644
--- a/drivers/soc/renesas/rmobile-sysc.c
+++ b/drivers/soc/renesas/rmobile-sysc.c
@@ -344,6 +344,7 @@ static int __init rmobile_init_pm_domains(void)
                        of_node_put(np);
                        break;
                }
+               fwnode_dev_initialized(&np->fwnode, true);
        }

        put_special_pds();

Can you give it a shot?

[1] - https://lore.kernel.org/lkml/20210205222644.2357303-8-saravanak@google.com/

> > >       - On R-Mobile A1, I get a BUG and a memory leak:
> > >
> > >             BUG: spinlock bad magic on CPU#0, swapper/1
> > >              lock: lcdc0_device+0x10c/0x308, .magic: 00000000, .owner:
> > > <none>/-1, .owner_cpu: 0
> > >             CPU: 0 PID: 1 Comm: swapper Not tainted
> > > 5.11.0-rc5-armadillo-00032-gf0a85c26907e #266
> > >             Hardware name: Generic R8A7740 (Flattened Device Tree)
> > >             [<c010c3c8>] (unwind_backtrace) from [<c010a49c>]
> > > (show_stack+0x10/0x14)
> > >             [<c010a49c>] (show_stack) from [<c0159534>]
> > > (do_raw_spin_lock+0x20/0x94)
> > >             [<c0159534>] (do_raw_spin_lock) from [<c04089d8>]
> > > (dev_pm_get_subsys_data+0x30/0xa0)
> > >             [<c04089d8>] (dev_pm_get_subsys_data) from [<c0413698>]
> > > (genpd_add_device+0x34/0x1c0)
> > >             [<c0413698>] (genpd_add_device) from [<c041389c>]
> > > (of_genpd_add_device+0x34/0x4c)
> > >             [<c041389c>] (of_genpd_add_device) from [<c0a1e9bc>]
> > > (board_staging_register_device+0xf8/0x118)
> > >             [<c0a1e9bc>] (board_staging_register_device) from
>
> This is indeed a pre-existing problem.
> of_genpd_add_device() is called before platform_device_register(),
> as it needs to attach the genpd before the device is probed.
> But the spinlock is only initialized when the device is registered.
> This was masked before due to an unrelated wait context check failure,
> which disabled any further spinlock checks, and exposed by fw_devlinks
> changing probe order.
> Patch sent.
> "[PATCH] staging: board: Fix uninitialized spinlock when attaching genpd"
> https://lore.kernel.org/r/20210215151405.2551143-1-geert+renesas@glider.be
>

Great!

Thanks,
Saravana
