Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE423ED7FF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Aug 2021 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhHPN46 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 16 Aug 2021 09:56:58 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38628 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhHPN45 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Aug 2021 09:56:57 -0400
Received: by mail-oi1-f181.google.com with SMTP id u25so26782416oiv.5;
        Mon, 16 Aug 2021 06:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uKKAqouMrQ5RgAbl37XN2HPKshvq14pMZ68Q1KvZR4=;
        b=GoE6oa48lNfNl1J4y5toavcHOWmP+I7MQpWI+llmbsBWT/bsFQw+3xWrh669vhyagO
         DkY/KJNHivFeg3qXwnex4KVyhQruDt31sPOpPAoQ6vb0wRondhnzQaVpR4mm7XoeR3O/
         1RLXISFU5urDA8eGKOIVicFacEGmh0kwuD3v3t8fwc4ow+cduQ+Brfnui2j0tB2YyG2R
         C7Kuvo1y1obDz4IYSD5PIonRANsIyKuXF4PQW0TTULv+E7qnQiGMTosO3csvYpHe3T49
         2njrR2N5ziOT6jF6wuEX7gZlHLwrTmU874nX0i4GSKRDngMNs5opLlh4KtI9XESm0hV9
         di3g==
X-Gm-Message-State: AOAM530sx8cho9lAiOcPWTJbeVfJ1cex5TbluSKaRh7RF7HFFdAVlIFJ
        zen15Yif3xHxSE9ZH3bSV0XKRoHl9OXKxc/bE1c=
X-Google-Smtp-Source: ABdhPJzr4FSgkxW5uRL0cvQgUoHQ2a9lqILSFnzzFljV07kigV/zFHRKEVbH4KzCPm8eekeCuQ0eIA+Kxb0DZTa0IdE=
X-Received: by 2002:a05:6808:220c:: with SMTP id bd12mr12147522oib.157.1629122185765;
 Mon, 16 Aug 2021 06:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210806143711.37553-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0iTNwQfh6ZZxry16hOjokGOOSZthq6C_yed07a2HQ7h2Q@mail.gmail.com> <YRppqnAqJ1G+4mva@smile.fi.intel.com>
In-Reply-To: <YRppqnAqJ1G+4mva@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 16 Aug 2021 15:55:59 +0200
Message-ID: <CAJZ5v0ib7oP5EG2k6_Q0Yiq=_WGu01iGVDmV+QoVRLaxTXZHDw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] x86/platform: Increase maximum GPIO number for X86_64
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Aug 16, 2021 at 3:35 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Aug 16, 2021 at 03:25:13PM +0200, Rafael J. Wysocki wrote:
> > On Fri, Aug 6, 2021 at 4:44 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > By default the 512 GPIOs is a maximum on any x86 platform.
> > > With, for example, Intel Tiger Lake-H the SoC based controller
> > > occupies up to 480 pins. This leaves only 32 available for
> > > GPIO expanders or other drivers, like PMIC. Hence, bump the
> > > maximum GPIO number to 1024 for X86_64 and leave 512 for X86_32.
>
> Thanks for review, my answers below.
>
> > > +# The GPIO number here must be sorted by descending number. In case of
> > > +# a multiplatform kernel, we just want the highest value required by the
> > > +# selected platforms.
> > > +config ARCH_NR_GPIO
> > > +       int
> > > +       default 1024 if X86_64
> > > +       default 512 if X86_32
> > > +       default 0
> >
> > Wouldn't
> >
> > default 1024 if X86_64
> > default 512
> >
> > be sufficient?
> >
> > It's either X86_64 or X86_32 anyway AFAICS.
>
> I guess so.
>
> > > +       help
> > > +         Maximum number of GPIOs in the system.
> > > +
> > > +         If unsure, leave the default value.
>
> Btw, what do you think. do we need comment above and help text here? I copied
> these from ARM, but I'm not sure it would be useful on x86 as much.

Both the comment and the help text aren't particularly useful IMO.

The comment is a bit confusing even, because x86 kernels are
multiplatform as a rule.
