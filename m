Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18EEB3317AE
	for <lists+linux-acpi@lfdr.de>; Mon,  8 Mar 2021 20:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCHTsB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Mar 2021 14:48:01 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:38466 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbhCHTr6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Mar 2021 14:47:58 -0500
Received: by mail-ot1-f51.google.com with SMTP id a17so10440956oto.5;
        Mon, 08 Mar 2021 11:47:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9a4r2KV/20IK9Xvdp/DQVl6ypaKqIrZBBr+oBc+pes=;
        b=qeHWiC3jwKjgxTg2epReYBN0kUkww/ytgdnuKNl2XteCaCL3GJXhUi03CVzcx5/yo0
         ZzSTPWxjLpug9caBhraEsMp5mTG4Pn+4oa96OpCM/48sQXaWNXBpPlnhEQxzZPC/xiLG
         cJY18PkByHG8jwgAnqBJDZ8NtIeqiNoWdZ3tHCkrrDgqGRBQdCw/M4ZXkOTwhGauY0R8
         u0uGXZM2CwmQ8LO8/d2gU/diVimOMgjAGCdAixNBbJow0P8fDASGfHZSssscynchLBLT
         0NNT+Ceqml5/3ALKYYzdMqzSiG3xqYed2QhGn6e53wJ/7h5+te7XATCnG/BBiLoUx3nu
         4d8Q==
X-Gm-Message-State: AOAM5322ibJhsIWj9MU9mOTmTI36Abeqfd9acrl7YU4rVVjb7Kh2Og79
        oMSn/TDIoZh4lXj5SOeBGcJgWe9bYKVXMAMR/98=
X-Google-Smtp-Source: ABdhPJydFsK+bWDOUjzC43e6UcRCZWiDxCR+hne6xllZcsO/ByGbq3TvcGrc0npVj0y2Cag+SgmB0kL3sDZ9dg0I+S8=
X-Received: by 2002:a05:6830:1057:: with SMTP id b23mr21883025otp.206.1615232877974;
 Mon, 08 Mar 2021 11:47:57 -0800 (PST)
MIME-Version: 1.0
References: <20210308194535.66394-1-andriy.shevchenko@linux.intel.com> <20210308194535.66394-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210308194535.66394-7-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Mar 2021 20:47:47 +0100
Message-ID: <CAJZ5v0gUDtpJE0Byw765yFr-5nOsxjPd5tH8_PGsr-gVZ-XSog@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] gpiolib: Fold conditionals into a simple ternary operator
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

On Mon, Mar 8, 2021 at 8:45 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's quite spread code to initialize IRQ domain options.
> Let's fold it into a simple oneliner.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please see the comments I've just sent:

https://lore.kernel.org/linux-acpi/CAJZ5v0gpNzyBDKfBXoBYskUXs15GrZAe-E2vzhSEu2Nrj7wa7g@mail.gmail.com/T/#u

> ---
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
> --
> 2.30.1
>
