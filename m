Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50EF79ACEC
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbjIKVSX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238101AbjIKNhu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 09:37:50 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6FACC3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:37:45 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-49040dc5cedso1587773e0c.3
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694439465; x=1695044265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DBjVU8xoqTxVeBdjw5DQAtCVxxc+Wceya3iiHagqYw=;
        b=BiF7l6RKG/jvkwHSH2mjHSvFzmGidhxn8PtF3vgCzeu+vMcP+/V5YuwuKvMpwgyqGP
         bDrqM79WFpHOjSqkCvFU+UeS2S+sZL+hmXJuTXo0fmeYpT+55KwnI9k7AUqWVcnbyB1U
         4W5ujVoV8d5IubJl7MnRCD4ttWlk/sSlGx/z9DaA/TNJ0EsKq8OID8oWOw3rVS3fg4MZ
         awvO0As4spmZUbLd9StWOxrZa9qoyvLMmha6RVA6xiICbwNWt8tPbwzw+/VoSNp27uDt
         Ta5c/GAZOznAQ7Ziu7wq06g1bz16yYue9lststrDbUXhtf5rfrxVAm3bOn1n+0k4Dede
         hSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439465; x=1695044265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DBjVU8xoqTxVeBdjw5DQAtCVxxc+Wceya3iiHagqYw=;
        b=ttiqu6aXAX0csU6O2kHod7Ld7y7lfjilXjODO80sYBrzOkQqj7eGDMqrNUTWGwbKIL
         iRIT2CsJc4Q33DqOwjLRPisVcC3VvSf0hrduy0YJhiB4cSgUBcpMWcAE9kwxjeNiiLWy
         0lNnv/IC58Jc6O/PqTjP8HnRL8pFWGlPj1+EsUrH/RjTOaQtP9S/bfPDUAEXEF8bZglG
         t+vD7PZbu4B9T8y40qIHsprcVca5tXSlUUNXlLnRUb8IgPPS9hmwgXoy8pQgP/k2o9Oh
         zjHMlMJfznkLQnPKTIEemkqBDiANDOs4VHq7/naeMZnp6ldXueN5/drLgZdAm6YWlIZI
         yndQ==
X-Gm-Message-State: AOJu0Yxr33wPMRXj7J2jPlaWBaQe9xXCzs2CCxKA7a2TBoVZuyt9f+5z
        yv2PJE5Fj8sE9h3PEI40wpzWqbC0qW5Slqrb9Q/O5w==
X-Google-Smtp-Source: AGHT+IEy0h1HWpl5jX3bshyTtKFKNGqBO1pN8FBH3gT/WDAJ4F5oF0f5YCpM+mx6nULFtg5/ERhEVB303Go/mHER5iQ=
X-Received: by 2002:ac5:cb79:0:b0:495:bca8:63f5 with SMTP id
 l25-20020ac5cb79000000b00495bca863f5mr4830126vkn.15.1694439465000; Mon, 11
 Sep 2023 06:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
 <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com> <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
 <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com>
In-Reply-To: <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 15:37:33 +0200
Message-ID: <CAMRc=MeGRreVVz=tCnEWtvixV+ZNEXXvG5SVRRmmnWG_sawMcg@mail.gmail.com>
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

On Mon, Sep 11, 2023 at 3:32=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 9/11/23 15:18, Bartosz Golaszewski wrote:
> > On Mon, Sep 11, 2023 at 3:08=E2=80=AFPM Hans de Goede <hdegoede@redhat.=
com> wrote:
> >>
> >> Hi,
> >>
> >> On 9/11/23 14:50, Bartosz Golaszewski wrote:
> >>> On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redhat=
.com> wrote:
> >>>>
> >>>> Refactor x86_android_tablet_get_gpiod() to no longer use
> >>>> gpiolib private functions like gpiochip_find().
> >>>>
> >>>> As a bonus this allows specifying that the GPIO is active-low,
> >>>> like the /CE (charge enable) pin on the bq25892 charger on
> >>>> the Lenovo Yoga Tablet 3.
> >>>>
> >>>> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >>>> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309.1=
31295-12-brgl@bgdev.pl/
> >>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>> ---
> >>>>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
> >>>>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++-----=
---
> >>>>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
> >>>>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
> >>>>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
> >>>>  5 files changed, 55 insertions(+), 37 deletions(-)
> >>>>
> >>>> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/drive=
rs/platform/x86/x86-android-tablets/asus.c
> >>>> index f9c4083be86d..227afbb51078 100644
> >>>> --- a/drivers/platform/x86/x86-android-tablets/asus.c
> >>>> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
> >>>> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_tf1=
03c_i2c_clients[] __initconst =3D
> >>>>                         .index =3D 28,
> >>>>                         .trigger =3D ACPI_EDGE_SENSITIVE,
> >>>>                         .polarity =3D ACPI_ACTIVE_LOW,
> >>>> +                       .con_id =3D "atmel_mxt_ts_irq",
> >>>>                 },
> >>>>         },
> >>>>  };
> >>>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drive=
rs/platform/x86/x86-android-tablets/core.c
> >>>> index 3d3101b2848f..673f3a14941b 100644
> >>>> --- a/drivers/platform/x86/x86-android-tablets/core.c
> >>>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> >>>> @@ -12,7 +12,7 @@
> >>>>
> >>>>  #include <linux/acpi.h>
> >>>>  #include <linux/dmi.h>
> >>>> -#include <linux/gpio/driver.h>
> >>>> +#include <linux/gpio/consumer.h>
> >>>>  #include <linux/gpio/machine.h>
> >>>>  #include <linux/irq.h>
> >>>>  #include <linux/module.h>
> >>>> @@ -21,35 +21,39 @@
> >>>>  #include <linux/string.h>
> >>>>
> >>>>  #include "x86-android-tablets.h"
> >>>> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> >>>> -#include "../../../gpio/gpiolib.h"
> >>>> -#include "../../../gpio/gpiolib-acpi.h"
> >>>>
> >>>>  static struct platform_device *x86_android_tablet_device;
> >>>>
> >>>> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *da=
ta)
> >>>> -{
> >>>> -       return gc->label && !strcmp(gc->label, data);
> >>>> -}
> >>>> -
> >>>> -int x86_android_tablet_get_gpiod(const char *label, int pin, struct=
 gpio_desc **desc)
> >>>> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const c=
har *con_id,
> >>>> +                                bool active_low, enum gpiod_flags d=
flags,
> >>>> +                                struct gpio_desc **desc)
> >>>>  {
> >>>> +       struct gpiod_lookup_table *lookup;
> >>>>         struct gpio_desc *gpiod;
> >>>> -       struct gpio_chip *chip;
> >>>>
> >>>> -       chip =3D gpiochip_find((void *)label, gpiochip_find_match_la=
bel);
> >>>> -       if (!chip) {
> >>>> -               pr_err("error cannot find GPIO chip %s\n", label);
> >>>> -               return -ENODEV;
> >>>> -       }
> >>>> +       lookup =3D kzalloc(struct_size(lookup, table, 2), GFP_KERNEL=
);
> >>>> +       if (!lookup)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       lookup->dev_id =3D KBUILD_MODNAME;
> >>>> +       lookup->table[0].key =3D chip;
> >>>> +       lookup->table[0].chip_hwnum =3D pin;
> >>>> +       lookup->table[0].con_id =3D con_id;
> >>>> +       lookup->table[0].flags =3D active_low ? GPIO_ACTIVE_LOW : GP=
IO_ACTIVE_HIGH;
> >>>> +
> >>>> +       gpiod_add_lookup_table(lookup);
> >>>> +       gpiod =3D devm_gpiod_get(&x86_android_tablet_device->dev, co=
n_id, dflags);
> >>>> +       gpiod_remove_lookup_table(lookup);
> >>>> +       kfree(lookup);
> >>>>
> >>>
> >>> Any reason for not creating static lookup tables for GPIOs here?
> >>
> >> Not sure what you mean with static?
> >>
> >> I guess you mean using global or stack memory instead of kmalloc() ?
> >>
> >> gcc did not like me putting a struct with a variable length array
> >> at the end on the stack, so I went with a kzalloc using the
> >> struct_size() helper for structs with variable length arrays instead.
> >>
> >> Note this only runs once at boot, so the small extra cost of
> >> the malloc + free is not really a big deal here.
> >>
> >> I did not try making it global data as that would make the function
> >> non re-entrant. Not that it is used in a re-entrant way anywhere,
> >> but generally I try to avoid creating code which is not re-entrant.
> >>
> >
> > I meant static-per-compilation-unit.
>
> I see.
>
> > It doesn't have to be a variable
> > length array either. Typically GPIO lookups are static arrays that are
> > added once and never removed.
>
> Right.
>
> > The SPI example I posted elsewhere is
> > different as it addresses a device quirk and cannot be generalized
> > like this. How many GPIOs would you need to describe for this
> > use-case? If it's just a few, then I'd go with static lookup tables.
> > If it's way more than disregard this comment.
>
> ATM x86_android_tablet_get_gpiod() gets called for 24 GPIOs,
> so more the just a few.

For different devices? As in: dev_id would differ? If not then I'd go
with a static table, you can use GPIO_LOOKUP() macro and have one line
per GPIO. If there are more devices, then I agree - let's keep dynamic
allocation.

Just please: add a comment why you're doing it this way so that people
don't just copy and paste it elsewhere.

Bart.

>
> Regards,
>
> Hans
>
>
