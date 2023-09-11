Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4632E79B466
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjIKVTC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjIKNSz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 09:18:55 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304DFEB
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:18:51 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49351972cbeso1434118e0c.2
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694438330; x=1695043130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tOwZ3PqGkQm9ofbRLCvZJFp++8f4cNKLlNK9XpNhLu8=;
        b=0pF69P13+fjFwP6i+38Q2rltPsvi5wPz6uZLTv5z2EFn/8bGTmqhOHVrr+UOLTXGe5
         Soe/4jZOZ+R/pkubVC1FfHPmyFLH0biuGmLN/4K8yKoEV3s9IpQNgonghEXq26S7HrcX
         uFcerWlysc8MUNQEDDBk5theCBMrNKKz0CCC9JTZwXvxh8ztLhoKHjWLxxYzMEfs7hrD
         rO5lVAiGbEr2ium/mGul1cf07ehvVHOTpYzbI1suY/diehrK965m0uKupRxCovXnko02
         4s7os3CtWOsiL7yd877XGyFeZKfVYjzAHxnIMVDuL1H9DR4i0IUAYe2vYAugUnYWSimY
         q/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438330; x=1695043130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tOwZ3PqGkQm9ofbRLCvZJFp++8f4cNKLlNK9XpNhLu8=;
        b=QmFiX878t0kV7FjcTx6kZcsC76PBpv2KZXyXZ3KhZRLmNvg+p/voaEMkGAPVERBrDk
         S5maxFphjJiBzEXjOKPvn1GgiMS1qv9BETQoZLG7hbz30r9wKKyyygqeubpkVDEJrac2
         QuNZmKXOjyoUusO0Ff0+c+YNgaI/Tgfi/i5jWDfNBFBZH/5rDQpna9dJyVKKAaI1Vo96
         DLjeSqEGe36ZYqVfet2JToqfzBHKxJWoB4FoGN7vOQgplTMFnwB/j0czKEzHW8d85Edv
         JvPjCn7QactN2x/4SvTUIikOsYuOFP9oZ5q84AqZG7pldm5Le0ENS5OHs8YEL5xP+3R8
         Ofjw==
X-Gm-Message-State: AOJu0Yz+iNdUblrKjXZEqodW1rZcM9o3CDZYQS6tgP8Xi4TtYJVZ2Xhy
        WTjgOYPva0HegcQ+hWt2lWeWrJf2le+4fIi6ULhs6w==
X-Google-Smtp-Source: AGHT+IEb6yZR04UHL1Vjshp/bpdQmyW+Y8SQySHEdgnLvcZXY9znHtE5aje0yqXsxexkQR/XxtVzqpCo9ll/gBUY6Wg=
X-Received: by 2002:a1f:c806:0:b0:490:e790:a15b with SMTP id
 y6-20020a1fc806000000b00490e790a15bmr7477248vkf.10.1694438330068; Mon, 11 Sep
 2023 06:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com> <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com>
In-Reply-To: <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 15:18:39 +0200
Message-ID: <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 11, 2023 at 3:08=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 9/11/23 14:50, Bartosz Golaszewski wrote:
> > On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
> >>
> >> Refactor x86_android_tablet_get_gpiod() to no longer use
> >> gpiolib private functions like gpiochip_find().
> >>
> >> As a bonus this allows specifying that the GPIO is active-low,
> >> like the /CE (charge enable) pin on the bq25892 charger on
> >> the Lenovo Yoga Tablet 3.
> >>
> >> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.131=
295-12-brgl@bgdev.pl/
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
> >>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++-------=
-
> >>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
> >>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
> >>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
> >>  5 files changed, 55 insertions(+), 37 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drivers=
/platform/x86/x86-android-tablets/asus.c
> >> index f9c4083be86d..227afbb51078 100644
> >> --- a/drivers/platform/x86/x86-android-tablets/asus.c
> >> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
> >> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf103=
c_i2c_clients[] __initconst =3D
> >>                         .index =3D 28,
> >>                         .trigger =3D ACPI_EDGE_SENSITIVE,
> >>                         .polarity =3D ACPI_ACTIVE_LOW,
> >> +                       .con_id =3D "atmel_mxt_ts_irq",
> >>                 },
> >>         },
> >>  };
> >> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers=
/platform/x86/x86-android-tablets/core.c
> >> index 3d3101b2848f..673f3a14941b 100644
> >> --- a/drivers/platform/x86/x86-android-tablets/core.c
> >> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> >> @@ -12,7 +12,7 @@
> >>
> >>  #include <linux/acpi.h>
> >>  #include <linux/dmi.h>
> >> -#include <linux/gpio/driver.h>
> >> +#include <linux/gpio/consumer.h>
> >>  #include <linux/gpio/machine.h>
> >>  #include <linux/irq.h>
> >>  #include <linux/module.h>
> >> @@ -21,35 +21,39 @@
> >>  #include <linux/string.h>
> >>
> >>  #include "x86-android-tablets.h"
> >> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> >> -#include "../../../gpio/gpiolib.h"
> >> -#include "../../../gpio/gpiolib-acpi.h"
> >>
> >>  static struct platform_device *x86_android_tablet_device;
> >>
> >> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data=
)
> >> -{
> >> -       return gc->label && !strcmp(gc->label, data);
> >> -}
> >> -
> >> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct g=
pio_desc **desc)
> >> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const cha=
r *con_id,
> >> +                                bool active_low, enum gpiod_flags dfl=
ags,
> >> +                                struct gpio_desc **desc)
> >>  {
> >> +       struct gpiod_lookup_table *lookup;
> >>         struct gpio_desc *gpiod;
> >> -       struct gpio_chip *chip;
> >>
> >> -       chip =3D gpiochip_find((void *)label, gpiochip_find_match_labe=
l);
> >> -       if (!chip) {
> >> -               pr_err("error cannot find GPIO chip %s\n", label);
> >> -               return -ENODEV;
> >> -       }
> >> +       lookup =3D kzalloc(struct_size(lookup, table, 2), GFP_KERNEL);
> >> +       if (!lookup)
> >> +               return -ENOMEM;
> >> +
> >> +       lookup->dev_id =3D KBUILD_MODNAME;
> >> +       lookup->table[0].key =3D chip;
> >> +       lookup->table[0].chip_hwnum =3D pin;
> >> +       lookup->table[0].con_id =3D con_id;
> >> +       lookup->table[0].flags =3D active_low ? GPIO_ACTIVE_LOW : GPIO=
_ACTIVE_HIGH;
> >> +
> >> +       gpiod_add_lookup_table(lookup);
> >> +       gpiod =3D devm_gpiod_get(&x86_android_tablet_device->dev, con_=
id, dflags);
> >> +       gpiod_remove_lookup_table(lookup);
> >> +       kfree(lookup);
> >>
> >
> > Any reason for not creating static lookup tables for GPIOs here?
>
> Not sure what you mean with static?
>
> I guess you mean using global or stack memory instead of kmalloc() ?
>
> gcc did not like me putting a struct with a variable length array
> at the end on the stack, so I went with a kzalloc using the
> struct_size() helper for structs with variable length arrays instead.
>
> Note this only runs once at boot, so the small extra cost of
> the malloc + free is not really a big deal here.
>
> I did not try making it global data as that would make the function
> non re-entrant. Not that it is used in a re-entrant way anywhere,
> but generally I try to avoid creating code which is not re-entrant.
>

I meant static-per-compilation-unit. It doesn't have to be a variable
length array either. Typically GPIO lookups are static arrays that are
added once and never removed. The SPI example I posted elsewhere is
different as it addresses a device quirk and cannot be generalized
like this. How many GPIOs would you need to describe for this
use-case? If it's just a few, then I'd go with static lookup tables.
If it's way more than disregard this comment.

Bart

> Regards,
>
> Hans
>
>
>
>
> >> -       gpiod =3D gpiochip_get_desc(chip, pin);
> >>         if (IS_ERR(gpiod)) {
> >> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod=
), label, pin);
> >> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod=
), chip, pin);
> >>                 return PTR_ERR(gpiod);
> >>         }
> >>
> >
>
