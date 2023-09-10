Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A8799D0B
	for <lists+linux-acpi@lfdr.de>; Sun, 10 Sep 2023 10:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbjIJIY7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 10 Sep 2023 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIJIY6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 10 Sep 2023 04:24:58 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9C5187;
        Sun, 10 Sep 2023 01:24:54 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3aa1446066aso2448500b6e.1;
        Sun, 10 Sep 2023 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694334294; x=1694939094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2cGCOGMca8vRbxpjpl725cbqGH/LHkCUZen9VKcUek=;
        b=Jv3pL9RMMN6N/29pv51ftrI3Yq+KmR43X9zcO0yLQf1Ia0EaXhq3ywT7gh4PZG6RSb
         QWfVARc5JinrTOBBW+3tnicdkAy5GrkJDLRgHpX/eU5T5s9sCUfgwy6vOKIu5W3jHXHe
         GB2C/9cOApta23/QseAKgJIraHUQ6H3pCQVZ1IM33ZPwUd7r12T5qT5FmbBKpuDV7VjB
         2QZzyIFBlYiq91YC8iGTLShpQXRx2k+R3oszy2FF3BFsDEUEPxjZQhdMCQGR7wgca+CO
         8jpyf1kXwUwNmj4JAEJ6ZgJhuXxyMQhtrTX8VpVMCc7wb+9uuK53NyaMWWbgJBSSxg45
         bKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694334294; x=1694939094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K2cGCOGMca8vRbxpjpl725cbqGH/LHkCUZen9VKcUek=;
        b=Kr7XXLNyhvBu69FyBFHCFb6ewmVvbU5ll3b64vfJWN+XefrY3G+zyaci4vyGe+jRNm
         isChTcRQrtWIGx5Q40LpKx8FrTw1dc3m++chzveMuEzIDl0nxNBeGdDB4/fF/pOpxwyy
         hS06w/6nocMzK8oI6WKBn3/hk8DlBn3D9+RNknDy/8BpM+kZvJbIlT1MEryKb+6ye/Jq
         KH3ciPHzhOxyX/+18G/gwudwqu1VZiGwB4VQgUYsdUycSFUch3nBDT5c4Av7WIeiwb06
         CM2yclvlLHY7bmFk9U7QNpwCMG1lq51bujULVQd41hZNCtOdNzPpr3+dKpqOToJpbxsL
         8Nhg==
X-Gm-Message-State: AOJu0YxVq/3ifs0N3KiSwPifUUvcSanB7t1v4UnRT1MiFhh/cKxdETXs
        8hI4DFhc6sUBYUhurM/ifDI995nYrVY8QN7sM8s=
X-Google-Smtp-Source: AGHT+IG6O8mlffcP4XE6eq2h4Vi9eII81dNGZfQRo+IsflXyPKpvt3hprW7orspTgAXNvq2eT4yCxQmMRLhPttzQg4w=
X-Received: by 2002:a05:6870:f116:b0:1ba:1998:1d23 with SMTP id
 k22-20020a056870f11600b001ba19981d23mr9322327oac.35.1694334293778; Sun, 10
 Sep 2023 01:24:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
In-Reply-To: <20230909141816.58358-7-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 10 Sep 2023 11:24:17 +0300
Message-ID: <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Refactor x86_android_tablet_get_gpiod() to no longer use
> gpiolib private functions like gpiochip_find().
>
> As a bonus this allows specifying that the GPIO is active-low,
> like the /CE (charge enable) pin on the bq25892 charger on
> the Lenovo Yoga Tablet 3.

The best patch in the series!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

See below a couple of questions.

...

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
> -       gpiod =3D gpiochip_get_desc(chip, pin);
>         if (IS_ERR(gpiod)) {
> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), =
label, pin);
> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), =
chip, pin);
>                 return PTR_ERR(gpiod);
>         }

> -       *desc =3D gpiod;
> +       if (desc)
> +               *desc =3D gpiod;

Are we expecting that callers may not want the GPIO descriptor out of
this function?
Sounds a bit weird if so.

>         return 0;
>  }

...

>          * The bq25890_charger driver controls these through I2C, but thi=
s only
>          * works if not overridden by the pins. Set these pins here:
> -        * 1. Set /CE to 0 to allow charging.

> +        * 1. Set /CE to 1 to allow charging.
>          * 2. Set OTG to 0 disable V5 boost output since the 5V boost out=
put of
>          *    the main "bq25892_1" charger is used when necessary.

Shouldn't we use terminology "active"/"non-active" instead of plain 0
and 1 in the above?

>          */

...

> -       ret =3D x86_android_tablet_get_gpiod("INT33FF:02", 22, &gpiod);
> +       ret =3D x86_android_tablet_get_gpiod("INT33FF:02", 22, "bq25892_0=
_ce",
> +                                          true, GPIOD_OUT_HIGH, NULL);
>         if (ret < 0)
>                 return ret;

Hmm... Maybe better this function to return an error pointer or valid
pointer, and in the code you choose what to do with that?

...

>         /* OTG pin */
> -       ret =3D x86_android_tablet_get_gpiod("INT33FF:03", 19, &gpiod);
> +       ret =3D x86_android_tablet_get_gpiod("INT33FF:03", 19, "bq25892_0=
_otg",
> +                                          false, GPIOD_OUT_LOW, NULL);

Ditto.

>         if (ret < 0)
>                 return ret;

--=20
With Best Regards,
Andy Shevchenko
