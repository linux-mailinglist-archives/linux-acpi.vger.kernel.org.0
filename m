Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE0C79B396
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbjIKVTG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbjIKMvO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 08:51:14 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB95E4B
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:51:09 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id 71dfb90a1353d-4935f2d6815so2752541e0c.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694436668; x=1695041468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6UC8FbJRnPQ7ZD0ReOlZPTmyF8Yoq6dUR2p60YXF9I=;
        b=k7JizPrL8b5nsitOdPvyjHvhWVLWd7yOjRv0J0hYmffNEYbybS+qqC+KWQhpW+nOLU
         2QBjzbAPVolunq7/sJVOQBBDbBvqdLpgLTgFNSMXymaXniHQenWOTybDSJulTEbuowK/
         pKuTcT/XMePkR06PvLOeZZyD8dzvYm5NVjDUO59iOY+KHhYlU256uzIuVHhJpplE6VWj
         G9Rb6ibBKWcz7Kmhvyv0zT6DZq9PBD6SdqcbLvqFpSKsckyWhUMCE/5OHOLVHbMssJnK
         krcxb2mjMsC+JKKvheIor7mf2CkekNjc4XS051nJy20jKLmfmCyOlpwTUe106lfsE/dX
         NK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436668; x=1695041468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6UC8FbJRnPQ7ZD0ReOlZPTmyF8Yoq6dUR2p60YXF9I=;
        b=ruoX/Z5iEBquOtemA1ckzi4NUKeBwLPj6NevH1D5MDVurxeNv06JvOsYE5GqLZ1AT5
         gn5ZTB/i09D1JpbyyDbpI4K3gyuqBqa52OOoE7h+ag1WYBrBY5OsZwuSO+8Ku0B9SOG9
         cGqetVz4lO0GrqvgP1SNpF+ga8lYjexbcP/QobnIUAYFN8M6Ln+4bpgvSjpZBTcZhIw8
         5jrSCPmvqu1f7In1z8sQBZAIay3vCFvHttx91w0eg1I6tSFg89ZIuJGDQHiF0Ztxc9SI
         Qr8Qz1ktE3LanjqFudkcR4QQoOCtps5tLAbwnRi6eP69od78h8i9xNODBxIaeqUu42wn
         Mvvw==
X-Gm-Message-State: AOJu0Yxa1vClcO1M2G6rpoeyDYTwCOumiyvIggkk1H+hyI3EZbziiMn6
        TZgkk65k8u+0Y2Rim/BoeWQu71u7XOvFL3NJPZ0YaQ==
X-Google-Smtp-Source: AGHT+IEgFqLrfkfnYxc00t1yJAQxjV1vCpl1FovrLEWk0fRy8zkAgiq/ouRKpLyb/73QkSWuZWaN/UkdCfmWP1WdVGI=
X-Received: by 2002:a1f:2cd4:0:b0:48e:1463:914e with SMTP id
 s203-20020a1f2cd4000000b0048e1463914emr4025807vks.7.1694436668228; Mon, 11
 Sep 2023 05:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-7-hdegoede@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 14:50:57 +0200
Message-ID: <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Refactor x86_android_tablet_get_gpiod() to no longer use
> gpiolib private functions like gpiochip_find().
>
> As a bonus this allows specifying that the GPIO is active-low,
> like the /CE (charge enable) pin on the bq25892 charger on
> the Lenovo Yoga Tablet 3.
>
> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131295=
-12-brgl@bgdev.pl/
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++--------
>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
>  5 files changed, 55 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers/pl=
atform/x86/x86-android-tablets/asus.c
> index f9c4083be86d..227afbb51078 100644
> --- a/drivers/platform/x86/x86-android-tablets/asus.c
> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103c_i=
2c_clients[] __initconst =3D
>                         .index =3D 28,
>                         .trigger =3D ACPI_EDGE_SENSITIVE,
>                         .polarity =3D ACPI_ACTIVE_LOW,
> +                       .con_id =3D "atmel_mxt_ts_irq",
>                 },
>         },
>  };
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/pl=
atform/x86/x86-android-tablets/core.c
> index 3d3101b2848f..673f3a14941b 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -12,7 +12,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> -#include <linux/gpio/driver.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/irq.h>
>  #include <linux/module.h>
> @@ -21,35 +21,39 @@
>  #include <linux/string.h>
>
>  #include "x86-android-tablets.h"
> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> -#include "../../../gpio/gpiolib.h"
> -#include "../../../gpio/gpiolib-acpi.h"
>
>  static struct platform_device *x86_android_tablet_device;
>
> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
> -{
> -       return gc->label && !strcmp(gc->label, data);
> -}
> -
> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio=
_desc **desc)
> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const char *=
con_id,
> +                                bool active_low, enum gpiod_flags dflags=
,
> +                                struct gpio_desc **desc)
>  {
> +       struct gpiod_lookup_table *lookup;
>         struct gpio_desc *gpiod;
> -       struct gpio_chip *chip;
>
> -       chip =3D gpiochip_find((void *)label, gpiochip_find_match_label);
> -       if (!chip) {
> -               pr_err("error cannot find GPIO chip %s\n", label);
> -               return -ENODEV;
> -       }
> +       lookup =3D kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
> +       if (!lookup)
> +               return -ENOMEM;
> +
> +       lookup->dev_id =3D KBUILD_MODNAME;
> +       lookup->table[0].key =3D chip;
> +       lookup->table[0].chip_hwnum =3D pin;
> +       lookup->table[0].con_id =3D con_id;
> +       lookup->table[0].flags =3D active_low ? GPIO_ACTIVE_LOW : GPIO_AC=
TIVE_HIGH;
> +
> +       gpiod_add_lookup_table(lookup);
> +       gpiod =3D devm_gpiod_get(&x86_android_tablet_device->dev, con_id,=
 dflags);
> +       gpiod_remove_lookup_table(lookup);
> +       kfree(lookup);
>

Any reason for not creating static lookup tables for GPIOs here?

Bart

> -       gpiod =3D gpiochip_get_desc(chip, pin);
>         if (IS_ERR(gpiod)) {
> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), =
label, pin);
> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), =
chip, pin);
>                 return PTR_ERR(gpiod);
>         }
>
