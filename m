Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B87779BD09
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 02:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbjIKVT2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238795AbjIKOFP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 10:05:15 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C200E40
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 07:05:09 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a9f87adfe1so3561871b6e.1
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 07:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694441108; x=1695045908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMUzoM2nvRIzJjPclDRKLCa7rjsT0iIQkBMPh70+kwU=;
        b=Cr50etxPqqWs5r3HD0NShMKivbaQMKgDeSeyfOVGzvRYMUAm7Gg+ENjqKYinT91Ks/
         G6iDOceWOT82txvAiFEpKdAmaTMPWuMAfxeQzGKfTD+r/OKAl+kjc18MceJMKQDM6PDi
         I9+DpbsuYkez5nwGybhFFunx03H0pjbyBFP6nMWtdekggAWvtbquFSY2POzkpJ9C0l8b
         kkyLLe6k3I9PtjQa4YwNgYQNk3552XAE+I6rY+mp2MKbbhwI/SVjwoLsmBBQkkSnH86o
         kWaXUkkT0ZVV4Bc251GR1lrVoNZdrV1EgNmGH7N7rmkryIj2BZ8gZr7l26nLBldeQik6
         92/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694441108; x=1695045908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMUzoM2nvRIzJjPclDRKLCa7rjsT0iIQkBMPh70+kwU=;
        b=R6WMDsd/QC13Rd1tsaS+EN2JmLrMXPtodW3zOL4jFUaMHsu41b7f4oYBPN6d+ZAidp
         vUkAU4LB75A6rXH5M9cgVcqrrV2UFxekxD/eGFiQBk7hAimrq3t0blbtcSFqpHIGBfh6
         BfkxVo7wSJVehsjnbaSe5TokRdqETg1j133olJWh+Xv3jgvJdIjSA3+P7+21JC44N51I
         bBXHsZyq7Hfw095M2aVfSJi3/s99JjOF416co1KncBy2bndFhxkQ3lCdvfD8k/EpeooE
         ANMlPiuKx+VTlXz9sNgNfDrMfkMqOZMQ7xIQCcUYoJvlLGDLjRyTq8XR1mmvFeGxw7+s
         cU9w==
X-Gm-Message-State: AOJu0Yy3Yn4kMwWagrQjb8G961m7w4FSA/WYzX1PIMY1XnCEjSw7Bk36
        S/SuDonE07eNNQ+neULtZNlZmTfb7c9NpHM2zB6aXA==
X-Google-Smtp-Source: AGHT+IGPc9A/GJXvjTtLdL7ua4zmkHZFQOoTcIpvGP2SRPsH312V77DPtsfFl6v8PPhhUyKgJ5eRdG9FjSVMl1S4kP8=
X-Received: by 2002:a05:6808:30a0:b0:3a7:88ce:7ac8 with SMTP id
 bl32-20020a05680830a000b003a788ce7ac8mr13391205oib.47.1694441108270; Mon, 11
 Sep 2023 07:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAMRc=MfeKirks7N7scu+dh+M1Nf0bNxzC7PE2Q7J4bxgpRnECw@mail.gmail.com>
 <0b1e0312-9144-85ed-666e-a84110b26418@redhat.com> <CAMRc=MfVZCqc-v+5oMkTkhfLvq1pE66E7GykqT2ymxzS_kw83w@mail.gmail.com>
 <01a85a3d-c888-11d8-f47e-be2a26d0cb9d@redhat.com> <CAMRc=MeGRreVVz=tCnEWtvixV+ZNEXXvG5SVRRmmnWG_sawMcg@mail.gmail.com>
 <bf866db7-1231-2fd6-eedf-b287ca4fa1b8@redhat.com>
In-Reply-To: <bf866db7-1231-2fd6-eedf-b287ca4fa1b8@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 16:04:57 +0200
Message-ID: <CAMRc=MdXLBnjFPE8Ac9tFQj6BXEyV6kRyDFNytsdQa++Yk6suw@mail.gmail.com>
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

On Mon, Sep 11, 2023 at 3:53=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi Bart,
>
> On 9/11/23 15:37, Bartosz Golaszewski wrote:
> > On Mon, Sep 11, 2023 at 3:32=E2=80=AFPM Hans de Goede <hdegoede@redhat.=
com> wrote:
> >>
> >> Hi,
> >>
> >> On 9/11/23 15:18, Bartosz Golaszewski wrote:
> >>> On Mon, Sep 11, 2023 at 3:08=E2=80=AFPM Hans de Goede <hdegoede@redha=
t.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> On 9/11/23 14:50, Bartosz Golaszewski wrote:
> >>>>> On Sat, Sep 9, 2023 at 4:18=E2=80=AFPM Hans de Goede <hdegoede@redh=
at.com> wrote:
> >>>>>>
> >>>>>> Refactor x86_android_tablet_get_gpiod() to no longer use
> >>>>>> gpiolib private functions like gpiochip_find().
> >>>>>>
> >>>>>> As a bonus this allows specifying that the GPIO is active-low,
> >>>>>> like the /CE (charge enable) pin on the bq25892 charger on
> >>>>>> the Lenovo Yoga Tablet 3.
> >>>>>>
> >>>>>> Reported-by: Bartosz Golaszewski <brgl@bgdev.pl>
> >>>>>> Closes: https://lore.kernel.org/platform-driver-x86/20230905185309=
.131295-12-brgl@bgdev.pl/
> >>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>>>>> ---
> >>>>>>  .../platform/x86/x86-android-tablets/asus.c   |  1 +
> >>>>>>  .../platform/x86/x86-android-tablets/core.c   | 51 +++++++++++---=
-----
> >>>>>>  .../platform/x86/x86-android-tablets/lenovo.c | 28 +++++-----
> >>>>>>  .../platform/x86/x86-android-tablets/other.c  |  6 +++
> >>>>>>  .../x86-android-tablets/x86-android-tablets.h |  6 ++-
> >>>>>>  5 files changed, 55 insertions(+), 37 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/platform/x86/x86-android-tablets/asus.c b/dri=
vers/platform/x86/x86-android-tablets/asus.c
> >>>>>> index f9c4083be86d..227afbb51078 100644
> >>>>>> --- a/drivers/platform/x86/x86-android-tablets/asus.c
> >>>>>> +++ b/drivers/platform/x86/x86-android-tablets/asus.c
> >>>>>> @@ -303,6 +303,7 @@ static const struct x86_i2c_client_info asus_t=
f103c_i2c_clients[] __initconst =3D
> >>>>>>                         .index =3D 28,
> >>>>>>                         .trigger =3D ACPI_EDGE_SENSITIVE,
> >>>>>>                         .polarity =3D ACPI_ACTIVE_LOW,
> >>>>>> +                       .con_id =3D "atmel_mxt_ts_irq",
> >>>>>>                 },
> >>>>>>         },
> >>>>>>  };
> >>>>>> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/dri=
vers/platform/x86/x86-android-tablets/core.c
> >>>>>> index 3d3101b2848f..673f3a14941b 100644
> >>>>>> --- a/drivers/platform/x86/x86-android-tablets/core.c
> >>>>>> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> >>>>>> @@ -12,7 +12,7 @@
> >>>>>>
> >>>>>>  #include <linux/acpi.h>
> >>>>>>  #include <linux/dmi.h>
> >>>>>> -#include <linux/gpio/driver.h>
> >>>>>> +#include <linux/gpio/consumer.h>
> >>>>>>  #include <linux/gpio/machine.h>
> >>>>>>  #include <linux/irq.h>
> >>>>>>  #include <linux/module.h>
> >>>>>> @@ -21,35 +21,39 @@
> >>>>>>  #include <linux/string.h>
> >>>>>>
> >>>>>>  #include "x86-android-tablets.h"
> >>>>>> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> >>>>>> -#include "../../../gpio/gpiolib.h"
> >>>>>> -#include "../../../gpio/gpiolib-acpi.h"
> >>>>>>
> >>>>>>  static struct platform_device *x86_android_tablet_device;
> >>>>>>
> >>>>>> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *=
data)
> >>>>>> -{
> >>>>>> -       return gc->label && !strcmp(gc->label, data);
> >>>>>> -}
> >>>>>> -
> >>>>>> -int x86_android_tablet_get_gpiod(const char *label, int pin, stru=
ct gpio_desc **desc)
> >>>>>> +int x86_android_tablet_get_gpiod(const char *chip, int pin, const=
 char *con_id,
> >>>>>> +                                bool active_low, enum gpiod_flags=
 dflags,
> >>>>>> +                                struct gpio_desc **desc)
> >>>>>>  {
> >>>>>> +       struct gpiod_lookup_table *lookup;
> >>>>>>         struct gpio_desc *gpiod;
> >>>>>> -       struct gpio_chip *chip;
> >>>>>>
> >>>>>> -       chip =3D gpiochip_find((void *)label, gpiochip_find_match_=
label);
> >>>>>> -       if (!chip) {
> >>>>>> -               pr_err("error cannot find GPIO chip %s\n", label);
> >>>>>> -               return -ENODEV;
> >>>>>> -       }
> >>>>>> +       lookup =3D kzalloc(struct_size(lookup, table, 2), GFP_KERN=
EL);
> >>>>>> +       if (!lookup)
> >>>>>> +               return -ENOMEM;
> >>>>>> +
> >>>>>> +       lookup->dev_id =3D KBUILD_MODNAME;
> >>>>>> +       lookup->table[0].key =3D chip;
> >>>>>> +       lookup->table[0].chip_hwnum =3D pin;
> >>>>>> +       lookup->table[0].con_id =3D con_id;
> >>>>>> +       lookup->table[0].flags =3D active_low ? GPIO_ACTIVE_LOW : =
GPIO_ACTIVE_HIGH;
> >>>>>> +
> >>>>>> +       gpiod_add_lookup_table(lookup);
> >>>>>> +       gpiod =3D devm_gpiod_get(&x86_android_tablet_device->dev, =
con_id, dflags);
> >>>>>> +       gpiod_remove_lookup_table(lookup);
> >>>>>> +       kfree(lookup);
> >>>>>>
> >>>>>
> >>>>> Any reason for not creating static lookup tables for GPIOs here?
> >>>>
> >>>> Not sure what you mean with static?
> >>>>
> >>>> I guess you mean using global or stack memory instead of kmalloc() ?
> >>>>
> >>>> gcc did not like me putting a struct with a variable length array
> >>>> at the end on the stack, so I went with a kzalloc using the
> >>>> struct_size() helper for structs with variable length arrays instead=
.
> >>>>
> >>>> Note this only runs once at boot, so the small extra cost of
> >>>> the malloc + free is not really a big deal here.
> >>>>
> >>>> I did not try making it global data as that would make the function
> >>>> non re-entrant. Not that it is used in a re-entrant way anywhere,
> >>>> but generally I try to avoid creating code which is not re-entrant.
> >>>>
> >>>
> >>> I meant static-per-compilation-unit.
> >>
> >> I see.
> >>
> >>> It doesn't have to be a variable
> >>> length array either. Typically GPIO lookups are static arrays that ar=
e
> >>> added once and never removed.
> >>
> >> Right.
> >>
> >>> The SPI example I posted elsewhere is
> >>> different as it addresses a device quirk and cannot be generalized
> >>> like this. How many GPIOs would you need to describe for this
> >>> use-case? If it's just a few, then I'd go with static lookup tables.
> >>> If it's way more than disregard this comment.
> >>
> >> ATM x86_android_tablet_get_gpiod() gets called for 24 GPIOs,
> >> so more the just a few.
> >
> > For different devices? As in: dev_id would differ? If not then I'd go
> > with a static table, you can use GPIO_LOOKUP() macro and have one line
> > per GPIO.
>
> I know GPIO_LOOKUP() is already used for normal GPIO lookup cases
> like e.g. a reset pin where the gpiod_get() is done by the i2c_driver
> for the i2c_client.
>
> > If there are more devices, then I agree - let's keep dynamic
> > allocation.
>
> These are used to lookup GPIOs which the code needs access to *before*
> instantiating the actual device consuming the GPIO.
>
> Specifically these GPIOS either become i2c_board_info.irq which is
> passed to i2c_client_new() to instantiate i2c_client-s; or
> desc_to_gpio() is called on them for old fashioned platform-data
> which still uses old style GPIO numbers (gpio_keys platform data).
>
> Needing these GPIOs before instantiating their actual consumer
> devices is the whole reason why the code used to call gpiolib
> private APIs in the first place.
>
> Note since the consuming device is not instantiated yet there really
> is no dev_id. Instead the newly added x86_android_tablets
> platform_device gets used as dev_id so that the code has a device
> to do the lookups on to remove the gpiolib private API use.
>
> This trick with using the x86_android_tablets pdev is why the whole
> lookup is done dynamically.
>
> > Just please: add a comment why you're doing it this way so that people
> > don't just copy and paste it elsewhere.
>
> Ok, I can do a follow-up patch adding a comment above
> x86_android_tablet_get_gpiod() explaining that it should only
> be used for GPIOs which are needed before their consumer
> device has been instantiated.
>

I'd just fold it into the existing patch but do as you prefer.

Bart

> Regards,
>
> Hans
>
>
