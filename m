Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDA231B7E5
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Feb 2021 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBOLUb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 15 Feb 2021 06:20:31 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:39330 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhBOLUZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Feb 2021 06:20:25 -0500
Received: by mail-oi1-f173.google.com with SMTP id l19so7380179oih.6;
        Mon, 15 Feb 2021 03:20:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g+2l6KM1UP6n61yvg+ftleSaZOAPmTS96UBlT5bgVOw=;
        b=EQX1VzOfpryADedahZgHDQ/na8KZ5NFdG8eGPrKMAjbAhkaibs/wx9FsgtbVTBrjh/
         jFTxZYUORcw23zr8hRa6LVJBq9CRTVWOM2tQbcF3Oifqy9bPEfIOBLJKoLRpOz77xcad
         YQ3PsgccOH96XkLEE3u8qvVEQum1CEeiq5VjZbxrS0eRdjQnz0ROIgptVGECQNHkGjHn
         Kqw/PshVAswVrq0dktl3YuDwOARSvR9BAjoKR9r80tt74Ey9oEgJnQBf/hPspsPXFARM
         GDYahSsuWANpZdTBuTDFLBwz24kO4g6Cdvv6tJHUnuM7UD9oXeRNb4XzPGrsDskAiNJA
         0lLA==
X-Gm-Message-State: AOAM5326cj/POgmd+sUbJmRp7UgbMeJFeqIosFN1FEAlLqLXZ5QXuWyB
        3xGF4LAvNl1kxNBIZ9tFWzTmTkGaWBmuNdcJKOg=
X-Google-Smtp-Source: ABdhPJzMI39m+KunbmWjRc0zXWvqEeHuECgd3ZsHjx+5rhHkVKdfXJ1QGr9mXD/zemLpBd0PNc0mqgI1Ax9YA4EUGXE=
X-Received: by 2002:aca:d8c6:: with SMTP id p189mr8141707oig.54.1613387983592;
 Mon, 15 Feb 2021 03:19:43 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com> <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
In-Reply-To: <CAMuHMdVL-1RKJ5u-HDVA4F4w_+8yGvQQuJQBcZMsdV4yXzzfcw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 15 Feb 2021 12:19:32 +0100
Message-ID: <CAMuHMdUi-_LJBB7fYB9ugpcj0J+FWXrqn2u44n7MemmvwiWQWw@mail.gmail.com>
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

On Thu, Feb 11, 2021 at 2:00 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Feb 5, 2021 at 11:26 PM Saravana Kannan <saravanak@google.com> wrote:
> > There are a lot of devices/drivers where they never have a struct device
> > created for them or the driver initializes the hardware without ever
> > binding to the struct device.
> >
> > This series is intended to avoid any boot regressions due to such
> > devices/drivers when fw_devlink=on and also address the handling of
> > optional suppliers.

>       - Some devices are reprobed, despite their drivers returning
>         a real error code, and not -EPROBE_DEFER:
>
>             renesas_wdt e6020000.watchdog: Watchdog blacklisted on r8a7791 ES1.*
>             (rwdt_probe() returns -ENODEV)
>
>             sh-pfc e6060000.pinctrl: pin GP_7_23 already requested by
> ee090000.pci; cannot claim for e6590000.usb
>             sh-pfc e6060000.pinctrl: pin-247 (e6590000.usb) status -22
>             sh-pfc e6060000.pinctrl: could not request pin 247
> (GP_7_23) from group usb0  on device sh-pfc
>             renesas_usbhs e6590000.usb: Error applying setting,
> reverse things back
>             renesas_usbhs: probe of e6590000.usb failed with error -22
>
>             rcar-pcie fe000000.pcie: host bridge /soc/pcie@fe000000 ranges:
>             rcar-pcie fe000000.pcie:       IO
> 0x00fe100000..0x00fe1fffff -> 0x0000000000
>             rcar-pcie fe000000.pcie:      MEM
> 0x00fe200000..0x00fe3fffff -> 0x00fe200000
>             rcar-pcie fe000000.pcie:      MEM
> 0x0030000000..0x0037ffffff -> 0x0030000000
>             rcar-pcie fe000000.pcie:      MEM
> 0x0038000000..0x003fffffff -> 0x0038000000
>             rcar-pcie fe000000.pcie:   IB MEM
> 0x0040000000..0x00bfffffff -> 0x0040000000
>             rcar-pcie fe000000.pcie:   IB MEM
> 0x0200000000..0x02ffffffff -> 0x0200000000
>             rcar-pcie fe000000.pcie: PCIe link down
>             (rcar_pcie_probe() returns -ENODEV)
>
>             xhci-hcd ee000000.usb: xHCI Host Controller
>             xhci-hcd ee000000.usb: new USB bus registered, assigned bus number 7
>             xhci-hcd ee000000.usb: Direct firmware load for
> r8a779x_usb3_v3.dlmem failed with error -2
>             xhci-hcd ee000000.usb: can't setup: -2
>             xhci-hcd ee000000.usb: USB bus 7 deregistered
>             xhci-hcd: probe of ee000000.usb failed with error -2

Consumers are added to the deferred probe pending list before
they are probed, but not removed on probe failure.
Patch sent
"[PATCH] driver core: Fix double failed probing with fw_devlink=on"
https://lore.kernel.org/linux-renesas-soc/20210215111619.2385030-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
