Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C176311FBA
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Feb 2021 20:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhBFTmP (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 Feb 2021 14:42:15 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:38893 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBFTmO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Feb 2021 14:42:14 -0500
Received: by mail-oi1-f175.google.com with SMTP id h6so11399159oie.5;
        Sat, 06 Feb 2021 11:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKD3uWoM232ZDb97jtcXu4bvy3RO8KL/znUc8UnnK5o=;
        b=ea5eTQmg3xpJKvaacNCZPSSh5QpyGfvc4Uckt8zldkOyDDobHf31qiKO7BDrz7sxUv
         FCM0GCUkg42l854aPPO744cttRSmzV8g5Y615mSAMo/3G8wwKDkq1SmsrBEt2sKfu5Mx
         Sv79pfMwh4sgD19AXAmy47GM8fdeSTsMYXRcGhgl8Xu74XYQiNweDyFXUinWuFOlcidK
         b7YcDMPQekm2LEI+SAJh37+LV0pwFiPdgS0O+8jP2HIAPtYvRt5V7vFWMZMuNHf1eyEJ
         gZfdE3IqteHlZPUcc1+TP/Nj6OAVpRFvRv4xlvT0Suqwr3B7ZbWIwF1J+meFrl5Qzkyw
         6Uvg==
X-Gm-Message-State: AOAM530ykiqlEeaFn+Z9XB+MKcf4RcKHwX6R2RwB97RKV51rTp5kEdyC
        sTCZd7uN76d/2wLxXjGS/A8EHyBqG/Ff8jInMeJtAvqV
X-Google-Smtp-Source: ABdhPJxQVTTEsgj9ERT0OqxlrVS5WhFx+iXJMf6D3lnCqIAwjU2C9L4GlRHxxmCD4IjzA1ObH/hGYJBKA2PuEeFOkHQ=
X-Received: by 2002:aca:744:: with SMTP id 65mr6621996oih.153.1612640492897;
 Sat, 06 Feb 2021 11:41:32 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
In-Reply-To: <20210205222644.2357303-1-saravanak@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 6 Feb 2021 20:41:22 +0100
Message-ID: <CAMuHMdXo+ShM3Ct2OSCscJwaLJ4rbytpA14=dR5q+3F9kJjNfw@mail.gmail.com>
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
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

On Fri, Feb 5, 2021 at 11:26 PM Saravana Kannan <saravanak@google.com> wrote:
> There are a lot of devices/drivers where they never have a struct device
> created for them or the driver initializes the hardware without ever
> binding to the struct device.
>
> This series is intended to avoid any boot regressions due to such
> devices/drivers when fw_devlink=on and also address the handling of
> optional suppliers.

Thanks for your series!

> Patch 5 sets up a generic API to handle drivers that never bind with
> their devices.
>
> Patch 6 through 8 update different frameworks to use the new API.

>   driver core: fw_devlink: Handle suppliers that don't use driver core
>   irqdomain: Mark fwnodes when their irqdomain is added/removed
>   PM: domains: Mark fwnodes when their powerdomain is added/removed
>   clk: Mark fwnodes when their clock provider is added/removed

I take it this is an automatic alternative for letting drivers set the
OF_POPULATED flag manually?

Is this actually safe?  It's not uncommon for a driver to register
multiple providers, sometimes even of different types (clock, genpd,
irq, reset[1], ...).
Can you be sure consumer drivers do not start probing while their
dependency is still busy registering providers?

[1] Which brings my attention to the fact that devlink does not consider
    "resets" properties yet.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
