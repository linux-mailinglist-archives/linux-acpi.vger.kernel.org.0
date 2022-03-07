Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32C654CFE0C
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Mar 2022 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiCGMUa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Mar 2022 07:20:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbiCGMU3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Mar 2022 07:20:29 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C78646676
        for <linux-acpi@vger.kernel.org>; Mon,  7 Mar 2022 04:19:34 -0800 (PST)
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5BD5D3F5FC
        for <linux-acpi@vger.kernel.org>; Mon,  7 Mar 2022 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646655573;
        bh=+KCTSBW6pFEjmloS4eWdJPVt5+ZQog9npEec5fTl3gE=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=KWdgBskv5riPATe1Ad5Mn3CZ8gtJp5cWbai/8q3ZAgOgLRzWQP1HpLetgwDUb9oiy
         VToze8YqzHMKzn85qko7GUL/+5eBcCoP5rEq4+Cg5e52rOMeSnsLlQnFfgscrOjWmz
         5YXkll7PbJwf3ze+gttTvP++qFTqCn5Xwr8E7RJuDK4hTEt3Uvw0+0DEAB8FJ3Li6w
         3ZN5CWBPNuvxOG42XAmZkR1tz+/c94fsuzyx4i8iPeqyr3Z0i/c9Cha48vPmAGjgpA
         +tWwgfoKYqSuEvRNLAKlq3kcVcskwIiL/Egn99axcZ9ER6dLtLhVy2pqpTPGda7tFd
         oUkiOiOHHwiTw==
Received: by mail-oi1-f200.google.com with SMTP id k8-20020a0568080e8800b002ccac943a76so9434965oil.15
        for <linux-acpi@vger.kernel.org>; Mon, 07 Mar 2022 04:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KCTSBW6pFEjmloS4eWdJPVt5+ZQog9npEec5fTl3gE=;
        b=c44RWww+ZqyeGfpHuAajkUKyNGdp+PN6c04Cz+WccbCGX3ewfArUgpHQqs75NskyB9
         YqV/BuSV6MXvSjmCdrtQ6VR6dTh9VasfmK9K1F9NdLrLypB39qdlJYiaHVRPdnfmSQ6j
         cvIdPMfLZqev5xdJ0J/yt3Sx5SvdEP/+ERzYjTKgeBVnoD940WQORzBtZdKLUAxdWutV
         obMcI+RJkwIgV9+TxyQQd/j9aF9nNDaroMrBxHhgOu4N0fjbQvX0cEf9gMzexe5agxKg
         i/c4lVgXBvzgizsA4V5hXnTcgEOF1aWB09me2VGwO+8atAOR2euNiX/gS/30OS8QM8hn
         fZcA==
X-Gm-Message-State: AOAM533NikIfyvtPmSBck7kjaYSIt5Dcu8rxXICN4ru5lvYL+SRiDAUW
        4GDmCL8wmRpHvbkYKjM5vGs97w9g6VEbUbB9JJwZoYXWTL4Vbx2ZGtV5ukqIT5iPiY1kjtkNG+J
        72KoFmnUjG2lvsGt8VKqAURMsSGte/lWkIYTRh0h9wK9mObnXNl2OcZM=
X-Received: by 2002:a05:6870:14c3:b0:da:3703:329b with SMTP id l3-20020a05687014c300b000da3703329bmr3786482oab.54.1646655571408;
        Mon, 07 Mar 2022 04:19:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0BauCYXUUtV8NW70lSCdhxqJhNg/9xRdwnGXnEFZMiy9VS3n4OvNo9dbPPyEE7RHVfdYiF9oRCjrHiODIwkk=
X-Received: by 2002:a05:6870:14c3:b0:da:3703:329b with SMTP id
 l3-20020a05687014c300b000da3703329bmr3786467oab.54.1646655571116; Mon, 07 Mar
 2022 04:19:31 -0800 (PST)
MIME-Version: 1.0
References: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220307115623.37492-1-andriy.shevchenko@linux.intel.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Mon, 7 Mar 2022 20:19:20 +0800
Message-ID: <CAAd53p6UvOqGkhGuwtZ0hvEAQFb4DR-RUd7R1uZuR+Duhf72EQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: acpi: Convert ACPI value of debounce to microseconds
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Mar 7, 2022 at 7:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> It appears that GPIO ACPI library uses ACPI debounce values directly.
> However, the GPIO library APIs expect the debounce timeout to be in
> microseconds.
>
> Convert ACPI value of debounce to microseconds.
>
> While at it, document this detail where it is appropriate.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215664
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Fixes: 8dcb7a15a585 ("gpiolib: acpi: Take into account debounce settings")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This works for me. Thanks!

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/gpio/gpiolib-acpi.c |  6 ++++--
>  drivers/gpio/gpiolib.c      | 10 ++++++++++
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index c0f6a25c3279..a5495ad31c9c 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -307,7 +307,8 @@ static struct gpio_desc *acpi_request_own_gpiod(struct gpio_chip *chip,
>         if (IS_ERR(desc))
>                 return desc;
>
> -       ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout);
> +       /* ACPI uses hundredths of milliseconds units */
> +       ret = gpio_set_debounce_timeout(desc, agpio->debounce_timeout * 10);
>         if (ret)
>                 dev_warn(chip->parent,
>                          "Failed to set debounce-timeout for pin 0x%04X, err %d\n",
> @@ -1035,7 +1036,8 @@ int acpi_dev_gpio_irq_get_by(struct acpi_device *adev, const char *name, int ind
>                         if (ret < 0)
>                                 return ret;
>
> -                       ret = gpio_set_debounce_timeout(desc, info.debounce);
> +                       /* ACPI uses hundredths of milliseconds units */
> +                       ret = gpio_set_debounce_timeout(desc, info.debounce * 10);
>                         if (ret)
>                                 return ret;
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index f5e7443208d4..f956c533f218 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2223,6 +2223,16 @@ static int gpio_set_bias(struct gpio_desc *desc)
>         return gpio_set_config_with_argument_optional(desc, bias, arg);
>  }
>
> +/**
> + * gpio_set_debounce_timeout() - Set debounce timeout
> + * @desc:      GPIO descriptor to set the debounce timeout
> + * @debounce:  Debounce timeout in microseconds
> + *
> + * The function calls the certain GPIO driver to set debounce timeout
> + * in the hardware.
> + *
> + * Returns 0 on success, or negative error code otherwise.
> + */
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce)
>  {
>         return gpio_set_config_with_argument_optional(desc,
> --
> 2.34.1
>
