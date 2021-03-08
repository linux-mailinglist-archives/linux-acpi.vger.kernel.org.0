Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B398C33176A
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhCHTgq (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:36:46 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:42948 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhCHTgg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 14:36:36 -0500
Received: by mail-ot1-f52.google.com with SMTP id e45so10371442ote.9;
        Mon, 08 Mar 2021 11:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sMozmf0FAGcQpfOJDKUILz3GVYyoKZuy87bou4sVN/k=;
        b=LtGxE2GuKR8aG6cCaCHD/q0tsvvD2rA2jG2QvK1tCI5qiCkJ6/MN2R1N4tuFatRK0z
         nR8JuEkeEiLEWQHSa+8fNhGeH00IUuAXrRSrOoYOAzGbZ7rYfsE+AvP89LNHpKQ6X/GN
         jJflXpQF/dRjQS6lprJ+tqrwCRdqaiiIPQM+nf2wIFubpvH+Y04rr+Iy8c81Q0MAPmQ4
         xsNR+0rRrcY7CTspPzoQalDYlBoUTOcBscdehArxwt9rziqcSsfWUkjoTYpKQuSbnPQt
         Xm+tXNIqxiITT/YiYQbbyJhyiZNw3m0wlJfEl+rQIN0PJaWrzqdsxnNiHPvpkD+SEwTf
         H7eg==
X-Gm-Message-State: AOAM5322R3NcNcdC3kTfFRQrS80b39/z0QqL+PSBjW/23YKQPjOusc+v
        kN6ydI61+PrCtrfiT8QI8cOjFvu0y5Kbg1Bvf1A=
X-Google-Smtp-Source: ABdhPJy+BnlNdkFYdkntgjM8pouPXrNOu+hytY7VBuXqkSLLdBJk4H+rZ+j4z80t7M85rMlp9zSiXj0y3mJu/2uItwA=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr21847435otp.206.1615232196053;
 Mon, 08 Mar 2021 11:36:36 -0800 (PST)
MIME-Version: 1.0
References: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 20:36:25 +0100
Message-ID: <CAJZ5v0hh8Q=9Ss4SDNfL0tqcEKXZ2oZyxo2F==W86JPSU5BpiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] gpiolib: Reuse device's fwnode to create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 8, 2021 at 8:33 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> When IRQ domain is created for an ACPI case, the name of it becomes unknown-%d
> since for now it utilizes of_node member only and doesn't consider fwnode case.
> Convert IRQ domain creation code to utilize fwnode instead.
>
> Before/After the change on Intel Galileo Gen 2 with two GPIO (IRQ) controllers:
>
>   unknown-1     ==>     \_SB.PCI0.GIP0.GPO
>   unknown-2     ==>     \_SB.NIO3
>
> Due to the nature of this change we may also deduplicate the WARN():s
> because in either case (DT or ACPI) the fwnode will be set correctly
> and %pfw is an equivalent to what the current code prints as a prefix.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v4: added a paragraph about WARN changes, split out ops optimizations (Rafael)

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

>  drivers/gpio/gpiolib.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 1853075df741..afee48e7dd41 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1456,9 +1456,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                                 struct lock_class_key *lock_key,
>                                 struct lock_class_key *request_key)
>  {
> +       struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
>         struct irq_chip *irqchip = gc->irq.chip;
>         const struct irq_domain_ops *ops = NULL;
> -       struct device_node *np;
>         unsigned int type;
>         unsigned int i;
>
> @@ -1470,7 +1470,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                 return -EINVAL;
>         }
>
> -       np = gc->gpiodev->dev.of_node;
>         type = gc->irq.default_type;
>
>         /*
> @@ -1478,16 +1477,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>          * used to configure the interrupts, as you may end up with
>          * conflicting triggers. Tell the user, and reset to NONE.
>          */
> -       if (WARN(np && type != IRQ_TYPE_NONE,
> -                "%s: Ignoring %u default trigger\n", np->full_name, type))
> +       if (WARN(fwnode && type != IRQ_TYPE_NONE,
> +                "%pfw: Ignoring %u default trigger\n", fwnode, type))
>                 type = IRQ_TYPE_NONE;
>
> -       if (has_acpi_companion(gc->parent) && type != IRQ_TYPE_NONE) {
> -               acpi_handle_warn(ACPI_HANDLE(gc->parent),
> -                                "Ignoring %u default trigger\n", type);
> -               type = IRQ_TYPE_NONE;
> -       }
> -
>         if (gc->to_irq)
>                 chip_warn(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
>
> @@ -1508,7 +1501,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>
>                 if (!ops)
>                         ops = &gpiochip_domain_ops;
> -               gc->irq.domain = irq_domain_add_simple(np,
> +               gc->irq.domain = irq_domain_create_simple(fwnode,
>                         gc->ngpio,
>                         gc->irq.first,
>                         ops, gc);
> --
> 2.30.1
>
