Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC55331781
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhCHTno (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:43:44 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:44540 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhCHTnb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 14:43:31 -0500
Received: by mail-ot1-f50.google.com with SMTP id f33so10373331otf.11;
        Mon, 08 Mar 2021 11:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HNv84JQX4/NDOa1VknCFUJOHmOgLmHruHi0GFdspBM=;
        b=aeBM5iYD7UaH2PeOSmAluyCqdVqfp0FOH2A6edyaTIH4RIlDVfrzStdJQFgNE+AHPt
         Qiiy78tgplaMDuzXx0HcfjoRw4gj9RhV7L/pwxeeC8GydtjoIQJn2NU9F9IRi6mIi8bJ
         G5elkeP2PheybFfgf9g3VUWLGtB9AG4I6huO+HesiPZ57Q8LN/qDmmfj4UWPOdl+GtVB
         bgw6IM6DdYevtfT7W6rdaM9S03vcHom5fiYMv3OWIFOjZhS/lTer1Ynsk9SgoXoXJRsV
         fZC1gZyaRdcGpTArn3cAznIUj9Wczi5qDfF+f/Vx+Ao4fhgqIXQfFA8cipjK4HCrkXil
         l9vg==
X-Gm-Message-State: AOAM530YeTYXN5Sq/pqSZoVVKQGHea3TSCNONgUoK7qGmpofVFtiWHMq
        V/oLNI5bJkpGRkJo9MBrZbPz/M6ES3jUxcl/4PKR1U0xAdY=
X-Google-Smtp-Source: ABdhPJzL6lY/qcC5OhuUgViwDJUUZATGQDB3Js0xiIq7lQ4DaLMY3aCTs4rH9So5NyhbrV8nc3COFSmyA3td9hidQFA=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr21869147otp.206.1615232610761;
 Mon, 08 Mar 2021 11:43:30 -0800 (PST)
MIME-Version: 1.0
References: <20210308193146.65585-1-andriy.shevchenko@linux.intel.com> <20210308193146.65585-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210308193146.65585-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 20:43:19 +0100
Message-ID: <CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpiolib: Fold conditionals into simple ternary operator
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
> It's quite spread code to initialize IRQ domain options.
> Let's fold it into a simple oneliner.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v4: new patch (see changelog of previous one)
>  drivers/gpio/gpiolib.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index afee48e7dd41..8c5ce377accc 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1458,7 +1458,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>  {
>         struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
>         struct irq_chip *irqchip = gc->irq.chip;
> -       const struct irq_domain_ops *ops = NULL;
> +       const struct irq_domain_ops *ops;

It looks like the ops local var is redundant.

>         unsigned int type;
>         unsigned int i;
>
> @@ -1496,11 +1496,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                         return ret;
>         } else {
>                 /* Some drivers provide custom irqdomain ops */
> -               if (gc->irq.domain_ops)
> -                       ops = gc->irq.domain_ops;
> -
> -               if (!ops)
> -                       ops = &gpiochip_domain_ops;
> +               ops = gc->irq.domain_ops ?: &gpiochip_domain_ops;
>                 gc->irq.domain = irq_domain_create_simple(fwnode,
>                         gc->ngpio,
>                         gc->irq.first,

Because this can be

gc->irq.domain = irq_domain_add_simple(np,
                        gc->ngpio,
                        gc->irq.first,
                        gc->irq.domain_ops ?: &gpiochip_domain_ops,
                        gc);

(modulo white space / formatting) and this is the only place where ops
is used in this function.
