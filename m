Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B407633173C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhCHT1Z (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:27:25 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:43324 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCHT0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 14:26:50 -0500
Received: by mail-ot1-f54.google.com with SMTP id v12so10332203ott.10;
        Mon, 08 Mar 2021 11:26:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LhDCvCR30nrEhblW1OV/Z84DMoZAtLVIncQRLbuBF7Y=;
        b=S4w5B6D7abLtdtAxLW5QHJan5DwBNmE+DVncpvIC45w1siED4jx9Bnv75oJp08xppE
         W6kolRBgcPb1NpXPFU53eEy+5KnT4BpCjFm+qZgaXCt2GQUrOkTdIBV3sK0hkFXQezNg
         5m/yr4o9ZF+P0fVV/pdJ8uWr4xZlGd3U7eoolpvuE+TDoeCzZiM5NC4AGFs0/dPf3BhN
         PGMpuPWDocZmGX73HgMczRpfJYiO3NcIgsAzS/6KgwwHyNN6+ODzeeYMSjcZUmqPtAOU
         GWrQA9as7a8sQHqns51P9zynktTHBT5uN9GyhG33B3OvbsQ8GS4CKGVpoNispvO5PVAt
         0ISw==
X-Gm-Message-State: AOAM533MsX/hvR7eVyzHuVjWWxRSPcMbzCjmPtYWiBVkm74JdGVi5jzD
        hXbZ54xrYe1ibebOirShE6svk4gFMUEkafhpwSg=
X-Google-Smtp-Source: ABdhPJy+U/Exrr6qB8OumxZUko03vjBHc1DHQa8O4NXiUo8jUrKY81oeRKodrpLAxFK02QS2pjf6nZv2z4OKYbwntVM=
X-Received: by 2002:a9d:3422:: with SMTP id v31mr16733025otb.260.1615231610242;
 Mon, 08 Mar 2021 11:26:50 -0800 (PST)
MIME-Version: 1.0
References: <20210304201253.14652-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gR=gN2ROo9JSOGHokw5imscMBwDERni8X83p0eWt634w@mail.gmail.com> <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
In-Reply-To: <CAMpxmJUQ3r0YCeQvPq=SW57w-5BLtoTO1_bv=2uw6CX_1-EXcQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 20:26:39 +0100
Message-ID: <CAJZ5v0h7zUMU9DMofa3fhop9fYY6UJQ6Nm3xBOmG48bcmLCj3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] gpiolib: switch to fwnode in the core
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 8, 2021 at 8:23 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Mon, Mar 8, 2021 at 7:22 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Mar 4, 2021 at 9:13 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > GPIO library uses of_node and fwnode in the core in non-unified way.
> > > The series cleans this up and improves IRQ domain creation for non-OF cases
> > > where currently the names of the domain are 'unknown'.
> > >
> > > This has been tested on Intel Galileo Gen 2.
> > >
> > > In v3:
> > > - fix subtle bug in gpiod_count
> > > - make irq_domain_add_simple() static inline (Marc)
> > >
> > > In v2:
> > > - added a new patch due to functionality in irq_comain_add_simple() (Linus)
> > > - tagged patches 2-4 (Linus)
> > > - Cc'ed to Rafael
> > >
> > > Andy Shevchenko (5):
> > >   irqdomain: Introduce irq_domain_create_simple() API
> > >   gpiolib: Unify the checks on fwnode type
> > >   gpiolib: Move of_node operations to gpiolib-of and correct fwnode use
> > >   gpiolib: Introduce acpi_gpio_dev_init() and call it from core
> > >   gpiolib: Reuse device's fwnode to create IRQ domain
> >
> > [1-4/5] applied as 5.13 material and I have a minor comment regarding
> > the last patch (will send separately).
> >
> > Thanks!
>
> Hi Rafael!
>
> AFAICT this should go through the GPIO tree as usual. Any reason for
> you to pick these patches this time?

My impression was that Andy wanted me to take them.

However, if you'd rather take care of them yourself, there you go!

I'll drop them now and assume that they will be routed through the GPIO tree.

Thanks!
