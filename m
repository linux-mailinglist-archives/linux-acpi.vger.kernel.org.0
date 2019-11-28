Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1709C10C60A
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Nov 2019 10:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfK1Jdy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 28 Nov 2019 04:33:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39176 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfK1Jdx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Nov 2019 04:33:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id f18so19497869lfj.6
        for <linux-acpi@vger.kernel.org>; Thu, 28 Nov 2019 01:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3l+cg2W4Xzdxsp+mO41BTJTyFXhrTFXLxXk55wVztoc=;
        b=o53h6oqwdTFdFdpQJ4rPt/uwDFMLcQi6W2SsTIRxRA+cb3N1zxxRCT1DYA0Dou/K1U
         eL+eERBjRRcwoYQhPkVR8g6ffKBym31VtlYS2R6D9TlR6w5cOldeSsL4XHD5m6QwT8ZB
         C9XvYZIFK58guPV649jhbAeoa6yZEYoifOahcjmHZQ6HK1vH0wTpMoFsXORNTb/ijd6B
         RwTBo+wkE0n7Wc7qTQuWO+I9YjhzZSDZotA+i5Aar/F5w02ebc+rULPqgNr4eHISQ3Rk
         aej24Wz+HOIlgB9SPG4fuZ3msiYD14wR/wQA6JL0qwcPJKg+rQkABmwJngwipWvG4Vzb
         +cXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3l+cg2W4Xzdxsp+mO41BTJTyFXhrTFXLxXk55wVztoc=;
        b=G4xSfpEzAiU5xXsZWsUDMijD5EwN9RXsW+73ZYmmlpLp7R3cOFztHbvJUPql27XhaX
         Jcqc/9jCWGPwIu2umaL+CC9ULVukXwvLFQ6cHns9864chCKgCoVhyQjHIxPddDlWZD4J
         /da7LG9phFYNopnR7zCXaE4BB4nkxMDoIPGQyl3wpDLyTov4vVWfiuw2ha0g77q7ncvF
         5Zt31HHlB9J68vrH4j0jC8TORkejaleh3wzss1U4vXVPL52KBHEYcQxC9FKfRXh2WtpS
         tn0FWuntf6m0Jp0kJp1kgnxtDpQdfsBX1bydad+YIPRafyfF+auqsh7Z1LAZV9jU84Uq
         0TCg==
X-Gm-Message-State: APjAAAWLhm4f6InIqF/4xm5PO8A6H1OZ3Kuiqs4QZpYXAzG8K/1tddmM
        ZltvijERGvIwoVCiPxydTzXo5qRjt3U9xdYyFpNLAw==
X-Google-Smtp-Source: APXvYqxfbj5pxG5YMqROUBTxW/+eod2ag0rTzoIBQOB9GKAdn4qaMOxEDphfz+rX9eoAZbteFkAt71MY9iWGiAEBwKA=
X-Received: by 2002:ac2:410a:: with SMTP id b10mr4426002lfi.135.1574933631692;
 Thu, 28 Nov 2019 01:33:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574277614.git.jan.kiszka@siemens.com> <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
In-Reply-To: <42ae6149a14f81fd86c5acb5bd33e987123b6bed.1574277614.git.jan.kiszka@siemens.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 28 Nov 2019 10:33:40 +0100
Message-ID: <CACRpkdbE_gkm4n3_V3_D0mKL4dF1pYC1ORbg07YSk24TpYrjTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] gpio: sch: Add edge event support
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Jan,

thanks for your patch!

On Wed, Nov 20, 2019 at 8:20 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:

> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Add the required infrastructure consisting of an irq_chip_generic with
> its irq_chip_type callbacks to enable and report edge events of the pins
> to the gpio core. The actual hook-up of the event interrupt will happen
> separately.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Please resend after the merge window, some comments:

First I'm pretty sure this driver can select GPIOLIB_IRQCHIP
and use infrastructure from the core to handle interrupts.

The fact that you register your own irq handler does not
stop that. See for example the solution in
drivers/gpio/gpio-mt7621.c
where we set the ->parent_handler to NULL to let
the driver handle the IRQs itself.

I will try to make this more explicit in the API as we work
with this.

>  struct sch_gpio {
>         struct gpio_chip chip;
>         spinlock_t lock;
>         unsigned short iobase;
>         unsigned short resume_base;
> +       int irq_base;

Why are you keeping this around in the state?
Why not just a local variable?

> +static int sch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
> +{
> +       struct sch_gpio *sch = gpiochip_get_data(gpio);
> +       return sch->irq_base + offset;
> +}
(...)
> +       .to_irq                 = sch_gpio_to_irq,
(...)
> +       irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, sch->chip.ngpio,
> +                                       NUMA_NO_NODE);
> +       if (irq_base < 0)
> +               return irq_base;
> +       sch->irq_base = irq_base;
> +
> +       gc = devm_irq_alloc_generic_chip(&pdev->dev, "sch_gpio", 1, irq_base,
> +                                        NULL, handle_simple_irq);
> +       if (!gc)
> +               return -ENOMEM;
(...)
> +       ret = devm_irq_setup_generic_chip(&pdev->dev, gc,
> +                                         IRQ_MSK(sch->chip.ngpio),
> +                                         0, IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> +       if (ret)
> +               return ret;

So I think you can avoid this complexity by jus doing what
gpio-mt7621.c is doing,
use devm_request_irq(), populate girq = &gc->irq; before
registering the gpio_chip pass a handle_simple_irq
and reuse core gpio irqchip infrastructure.

But I don't know everything so let's test and see!

Yours,
Linus Walleij
