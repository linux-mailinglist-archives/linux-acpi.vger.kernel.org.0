Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E24333162C
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 19:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCHSdO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 13:33:14 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41856 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhCHSc6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 13:32:58 -0500
Received: by mail-oi1-f171.google.com with SMTP id y131so9113162oia.8;
        Mon, 08 Mar 2021 10:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ORULzCjnXPb/eOQixg/gznJjWj+kBCZLN3pQYNFPoWI=;
        b=fANIWjkr4YGz7W6fxyIEWAErXweUtz2svDjEf0nyN3nZaH1Wgn+fL0lD3X2SMK/WWL
         aPU6w4n8lwcaaeo1tSoh34ykg32a1g9WzgF1L2sX5Amu6AGGPcYkXF4DYl1aiifuN/yl
         fjqq96k8LU4caM1zwr4ctrIH1iSnl7lx4VharCW3FfH4RfNIZLPmg6m9+SdnVGUN0/vk
         R1pNfbxeka5jszHh7iWi4XdZqsK22dCUoDsFrRFpQXKJrYqUDrOhPw/1QE3JIQbfDopn
         jlUwFijohA5zYBGcoK9MBFFtmPjltq3mVF5jtDQ636g1YkFES48SmVQwGi6cKy5cThhv
         dTVQ==
X-Gm-Message-State: AOAM532/OsqlrFuNYa8Pu+hnk9V/OU9G+M0JukGgniKma1L0rZMsyoG7
        4bUoN0lApbI2UUEsU/RYe834RVfJhFSgexUKQffmdi3x
X-Google-Smtp-Source: ABdhPJwusjwrfgz1HhuY7d2RR+wDiiBn94dofEw7gcVvopI+S03bpDjL7POeGuKn66Vkpsfj4gOg7y7rmmggjMJBEZI=
X-Received: by 2002:aca:f245:: with SMTP id q66mr113635oih.69.1615228378107;
 Mon, 08 Mar 2021 10:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20210304150215.80652-1-andriy.shevchenko@linux.intel.com> <20210304150215.80652-6-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210304150215.80652-6-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 19:32:47 +0100
Message-ID: <CAJZ5v0juZyx0f9L6erdNdmhFdJQ=Q9hPGatNEJm9v_oija=oiQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] gpiolib: Reuse device's fwnode to create IRQ domain
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Mar 4, 2021 at 4:02 PM Andy Shevchenko
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
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 6827736ba05c..254d59b088fe 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1457,9 +1457,9 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                                 struct lock_class_key *lock_key,
>                                 struct lock_class_key *request_key)
>  {
> +       struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
>         struct irq_chip *irqchip = gc->irq.chip;
> -       const struct irq_domain_ops *ops = NULL;
> -       struct device_node *np;
> +       const struct irq_domain_ops *ops;
>         unsigned int type;
>         unsigned int i;
>
> @@ -1471,7 +1471,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                 return -EINVAL;
>         }
>
> -       np = gc->gpiodev->dev.of_node;
>         type = gc->irq.default_type;
>
>         /*
> @@ -1479,16 +1478,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
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

Why is the above message not worth printing any more?  If there is a
good enough reason, it would be good to mention it in the changelog.

> -
>         if (gc->to_irq)
>                 chip_warn(gc, "to_irq is redefined in %s and you shouldn't rely on it\n", __func__);
>
> @@ -1504,15 +1497,10 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                         return ret;
>         } else {
>                 /* Some drivers provide custom irqdomain ops */
> -               if (gc->irq.domain_ops)
> -                       ops = gc->irq.domain_ops;
> -
> -               if (!ops)
> -                       ops = &gpiochip_domain_ops;

I'm guessing that the code above is replaced in order to avoid
initializing ops to NULL, but IMO that should be a separate patch or
at least the extra cleanup should be mentioned in the changelog.

Personally, I would do the essential change first and put all of the
tangentially related cleanups into a separate follow-up patch.

> -               gc->irq.domain = irq_domain_add_simple(np,
> -                       gc->ngpio,
> -                       gc->irq.first,
> -                       ops, gc);
> +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
> +               gc->irq.domain = irq_domain_create_simple(fwnode, gc->ngpio,
> +                                                                 gc->irq.first,
> +                                                                 ops, gc);
>                 if (!gc->irq.domain)
>                         return -EINVAL;
>         }
> --
