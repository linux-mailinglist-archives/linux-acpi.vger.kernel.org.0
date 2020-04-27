Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE5F81BA474
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Apr 2020 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgD0NSf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 27 Apr 2020 09:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727074AbgD0NSf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 27 Apr 2020 09:18:35 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30370C0610D5;
        Mon, 27 Apr 2020 06:18:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 145so8981573pfw.13;
        Mon, 27 Apr 2020 06:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c1k+gEIx9g2n5bow6vtVN4S2Oq2hdJ7Izd4HZYhlGy4=;
        b=uLbgawqSZf5WmYOM6BphwUPZqqeTRvTEk8pAY4dpAvTaPyUI3Y0DC5A60nnhZCrm+L
         VH5NKdG0wLRYVt3tL8XIP82+eQ4HH5ADJKRpbBWuq5vc2IN1ifhUkkGQkUuBWHvxH1sL
         pKoTyCmQWMyrZiVbmnjh+Y5gfOSvRe3jJNva9GzRINDm2kFPNThnMeUSCNlRRgYjtlb5
         upDacs7OkHBiQUjo7G35XrknjRJ6fds0AA2hlBW1ANBBRKQ5nEIrofcAR8KqH/likuj+
         1GFxuVEsSXMc2JKVe7PqWXCvEfHNRZsFBaJD3FuzRKTuL4sJqDBwKnTmxJda1d/4Tchx
         j8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c1k+gEIx9g2n5bow6vtVN4S2Oq2hdJ7Izd4HZYhlGy4=;
        b=UlhedcFGgoGGfMRFFEew5PpDh+wNGpkH/F0Lt31eD7WWJLdbMRlWF3qBjeRzNj39wB
         2O1BkyzEbXD0AkoWaSlhfo1ZRYtvxcP5/ZHwgN+esHAZBe4H0YNJlUFQiqPoWJ50wZn4
         WNCjwKZI6/GkzVtXSATL4J392vG9GTOGRVUsEAmfToasrExufOvQcBbAw4N99JL/YhIO
         r3EAwgfULd+lJIIfFITP95Ft8eUzHAyW+//dWpjHbud+kpvTxuKZD/JUWCLzNAjE1R19
         iqsVIrizMs0lwVa2m+gHU9CiPz8UO3PU7uUfc5LUZ/XokpWrAEG83XeQokwNWtKrHEAt
         LqmQ==
X-Gm-Message-State: AGi0PuYVLSy6v5yxv16wZQwwlgv7FIuDKQi6LBBh0aAUDoxB+F9odeGf
        A67h1cr9KH4IEmrQvB8oj2MznXneS+KHDYHm6BM=
X-Google-Smtp-Source: APiQypIl5JhShfbLXk210/ONkEo4RLpOUlw3JnX3koAy0fh72SXGm0PXh4t+wpSJFLk7CwNMI6rOAM2DC1qKtbSLiXU=
X-Received: by 2002:a63:1c1:: with SMTP id 184mr23868927pgb.203.1587993514639;
 Mon, 27 Apr 2020 06:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200426104713.216896-1-hdegoede@redhat.com> <20200426104713.216896-2-hdegoede@redhat.com>
 <CAHp75VdOd6C36oR7HAnqrKiinVBr4YcqqJ=dv3NpR3=Xp0QQ-Q@mail.gmail.com> <b5bdffb4-0af2-abb7-21f7-2f5da56d5dc6@redhat.com>
In-Reply-To: <b5bdffb4-0af2-abb7-21f7-2f5da56d5dc6@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Apr 2020 16:18:28 +0300
Message-ID: <CAHp75VegakBqAzxn1e+MzF3EgB6fNya3L0eZHMh11yct6HHNKw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: i2c-multi-instantiate: Add flag for
 passing fwnode
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 27, 2020 at 3:51 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 4/26/20 7:59 PM, Andy Shevchenko wrote:
> > On Sun, Apr 26, 2020 at 1:47 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>
> >> In some cases the driver for the i2c_client-s which i2c-multi-instantiate
> >> instantiates may need access some fields / methods from to the ACPI fwnode
> >> for which i2c_clients are being instantiated.
> >>
> >> An example of this are CPLM3218 ACPI device-s. These contain CPM0 and
> >> CPM1 packages with various information (e.g. register init values) which
> >> the driver needs.
> >>
> >> Passing the fwnode through the i2c_board_info struct also gives the
> >> i2c-core access to it, and if we do not pass an IRQ then the i2c-core
> >> will use the fwnode to get an IRQ, see i2c_acpi_get_irq().
> >
> > I'm wondering, can we rather do it in the same way like we do for
> > GPIO/APIC case here.
> > Introduce IRQ_RESOURCE_SHARED (or so) and
> >
> > case _SHARED:
> >   irq = i2c_acpi_get_irq();
> > ...
> >
> > ?
>
> I think you are miss-understanding the problem. The problem is not that
> we want to share the IRQ, the problem is that we want to pass the single
> IRQ in the resources to only 1 of the instantiated I2C-clients. But if we
> do not pass an IRQ (we leave it at 0) and we do pass the fwnode then
> i2c-core-base.c will see that there is an ACPI-node attached to the
> device and will call i2c_acpi_get_irq().

Do we know ahead which device should take IRQ resource and which should not?
Can we use current _NONE flag for them?

> So the solution is definitely not calling i2c_acpi_get_irq() inside
> i2c-multi-instantiate.c we want to avoid the i2c_acpi_get_irq(),
> leaving the other 2 clients for the BSG1160 device without an IRQ
> and thus avoiding the IRQ mismatch (it is a mismatch because the
> drivers do not set the shared flag; and that is ok, we do not want
> to share the IRQ, it is just for the accelerometer AFAIK).

> >> This is a problem when there is only an IRQ for 1 of the clients described
> >> in the ACPI device we are instantiating clients for. If we unconditionally
> >> pass the fwnode, then i2c_acpi_get_irq() will assign the same IRQ to all
> >> clients instantiated, leading to kernel-oopses like this (BSG1160 device):
> >>
> >> [   27.340557] genirq: Flags mismatch irq 76. 00002001 (bmc150_magn_event) vs. 00000001 (bmc150_accel_event)
> >> [   27.340567] Call Trace:
> >> ...
> >>
> >> So we cannot simply always pass the fwnode. This commit adds a PASS_FWNODE
> >> flag, which can be used to pass the fwnode in cases where we do not have
> >> the IRQ problem and the driver for the instantiated client(s) needs access
> >> to the fwnode.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/platform/x86/i2c-multi-instantiate.c | 6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
> >> index 6acc8457866e..dcafb1a29d17 100644
> >> --- a/drivers/platform/x86/i2c-multi-instantiate.c
> >> +++ b/drivers/platform/x86/i2c-multi-instantiate.c
> >> @@ -20,6 +20,8 @@
> >>   #define IRQ_RESOURCE_GPIO      1
> >>   #define IRQ_RESOURCE_APIC      2
> >>
> >> +#define PASS_FWNODE            BIT(2)
> >> +
> >>   struct i2c_inst_data {
> >>          const char *type;
> >>          unsigned int flags;
> >> @@ -93,6 +95,10 @@ static int i2c_multi_inst_probe(struct platform_device *pdev)
> >>                  snprintf(name, sizeof(name), "%s-%s.%d", dev_name(dev),
> >>                           inst_data[i].type, i);
> >>                  board_info.dev_name = name;
> >> +
> >> +               if (inst_data[i].flags & PASS_FWNODE)
> >> +                       board_info.fwnode = dev->fwnode;
> >> +
> >>                  switch (inst_data[i].flags & IRQ_RESOURCE_TYPE) {
> >>                  case IRQ_RESOURCE_GPIO:
> >>                          ret = acpi_dev_gpio_irq_get(adev, inst_data[i].irq_idx);
> >> --
> >> 2.26.0
> >>
> >
> >
>


-- 
With Best Regards,
Andy Shevchenko
