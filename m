Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142733327B4
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Mar 2021 14:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhCINt0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Mar 2021 08:49:26 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:33262 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbhCINs5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Mar 2021 08:48:57 -0500
Received: by mail-ot1-f47.google.com with SMTP id j8so12877234otc.0;
        Tue, 09 Mar 2021 05:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mpza37x2a6jOovJHwQKMXxHs0CUszPBiFGSPamapf+Y=;
        b=Vm+ziBbgzb9jzKIdrPvLMr3V1+dC1/IVrey11QCKSJS+YyCsL4AkEbmcu/YhL81IZM
         ZiJSeRA4HAvTjPcz4iY/VL5oh6p2rkZUUiKrKLkPYOIaeWbWc87tmMgmnKPHNaUs/B67
         f9H04ux1h5rKu67oLSqEexA/3y64wEmngyk5/K2kOAnTDSVYpwz5BrrCmVIj3VkMV0Fz
         TQ8OsiLzytxVumOnseygx+FB7QJaX4RtszLC3vM9Vuikak4X0x0u1qsiURolfG6GIuqg
         qShXZWGfd58Ns9FY16uEmkXALrberZcBNDJdkrmeCtrQL93r5qT3OHGxvh07YewS0W9F
         MZAA==
X-Gm-Message-State: AOAM531uVllYbxPHne4sSJuE1x1gSMLytalcWseVlU8tfvk7U/MzdNXm
        Ojsw+B3PKFBd7QNrksFLYwxVn25mR8obzfGC7nY=
X-Google-Smtp-Source: ABdhPJyC5dNphe6C3nIg/ocHMyKLDanpr2WztK8rHJ2jhVEQkEbs8vWPuTu7WsVpzoBnHVqtq7Z3lSZLo/h+GSM/3o8=
X-Received: by 2002:a05:6830:1e03:: with SMTP id s3mr13608965otr.321.1615297736685;
 Tue, 09 Mar 2021 05:48:56 -0800 (PST)
MIME-Version: 1.0
References: <20210309093736.67925-1-andriy.shevchenko@linux.intel.com> <20210309093736.67925-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210309093736.67925-7-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Mar 2021 14:48:44 +0100
Message-ID: <CAJZ5v0jHnCE0=k8GG6r5VKFjJ-vYHnaDOas5BSxiu+oa=rfUcQ@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] gpiolib: Fold conditionals into a simple ternary operator
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
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

On Tue, Mar 9, 2021 at 10:37 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It's quite spread code to initialize IRQ domain options.
> Let's fold it into a simple oneliner.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/gpio/gpiolib.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index afee48e7dd41..cee4333f8ac7 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1458,7 +1458,6 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>  {
>         struct fwnode_handle *fwnode = dev_fwnode(&gc->gpiodev->dev);
>         struct irq_chip *irqchip = gc->irq.chip;
> -       const struct irq_domain_ops *ops = NULL;
>         unsigned int type;
>         unsigned int i;
>
> @@ -1496,15 +1495,11 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>                         return ret;
>         } else {
>                 /* Some drivers provide custom irqdomain ops */
> -               if (gc->irq.domain_ops)
> -                       ops = gc->irq.domain_ops;
> -
> -               if (!ops)
> -                       ops = &gpiochip_domain_ops;
>                 gc->irq.domain = irq_domain_create_simple(fwnode,
>                         gc->ngpio,
>                         gc->irq.first,
> -                       ops, gc);
> +                       gc->irq.domain_ops ?: &gpiochip_domain_ops,
> +                       gc);
>                 if (!gc->irq.domain)
>                         return -EINVAL;
>         }
> --
> 2.30.1
>
