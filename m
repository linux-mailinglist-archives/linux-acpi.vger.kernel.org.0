Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504B979B2B8
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbjIKVSW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237424AbjIKMuB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 08:50:01 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAEE4B
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:49:56 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id 71dfb90a1353d-493639d616eso1569993e0c.0
        for <linux-acpi@vger.kernel.org>; Mon, 11 Sep 2023 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1694436596; x=1695041396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJZ1FZwiFkPljuovGYCrOATIkTG/B1uJPfFfZJohEuw=;
        b=amV62cb6zjsK3BgqTlvyU5CbPPaAxDgiHXEodGwK8PlpUqgVVVvHhQuMu2ovS8Lf6A
         OBB2JrG1s7WbWDSsut50VfptuFbrr5xfSFkh8X5XWVaOb/uqJX97jOH+V3IEWtxn3ovg
         +W2EI3A0jZ0csZuqOfO119WhG/Lh84k++lbVqfjr5Ndp/DMaoDdM5HA7p7eVQhZmE1D/
         zYshZ/vKJynDkKjd6dxbO3HOBlNvKXni2jWuwdxuj9ULUe5KCqNQJdxk0v1iv8L/vjV5
         t1KYu5bSS3DAMM5IZ9qtbUBsyXP9P2K9K0RDWe0YSOHO/ui35FuG21necvJHY8YuXwwS
         HY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694436596; x=1695041396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJZ1FZwiFkPljuovGYCrOATIkTG/B1uJPfFfZJohEuw=;
        b=JKeLY/9eJgEv+og/DRcO1+CCHheX73iCJSJzCZ9vtE1QZ84cG2WyhJyVsBs10rV6Gd
         zxUqFDCECVutE/8pUSPWPbnHGRri9MKGVDIdtAnJZUEIRAFjKidGQXNC4E8TItozHlHm
         Km+dql12N3K6TyBptNpqITL8Y0nlJbzDeITGM5wGoQW5+w+lTXtXVqiIQujHjaJsqn+4
         iHtnY2qx0muYBoag2iJ4e4ET6/6jDrULRiaqak+JQ7GrBmAB53RaW5zahRtZmi/iwDoW
         TEFtwJmxfCmdsfsm76xo4an9jWDCg7hpo5sMElEYD9zjBjis0LcZ4GVKj/8wCe6Y0cee
         FW7Q==
X-Gm-Message-State: AOJu0Yx2Rhd2GUkvECyyZlYguxjtIB1SRynAWMTfVJ2EIz9napP+ZoON
        lhyxOVep+0d1jztrAqCLPP3nPjNFByPW74YAnu1k6A==
X-Google-Smtp-Source: AGHT+IFCrtVF9FUlezN8ZWtoWSPV7p/2FrBeRPbP47fzBvVOA2broT4NKCJmO8TCIWnhGp8D7wN3K3NpXEYH5P+5oAQ=
X-Received: by 2002:a05:6122:251f:b0:48f:cd3a:108 with SMTP id
 cl31-20020a056122251f00b0048fcd3a0108mr6700350vkb.12.1694436595827; Mon, 11
 Sep 2023 05:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230909141816.58358-1-hdegoede@redhat.com> <20230909141816.58358-7-hdegoede@redhat.com>
 <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com> <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com>
In-Reply-To: <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Sep 2023 14:49:44 +0200
Message-ID: <CAMRc=MdmzPWeZ7CtFe2b6xZFAges2cD-ckq4vn-+52CG=tVRSA@mail.gmail.com>
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using gpiolib
 private APIs
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
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

On Sun, Sep 10, 2023 at 1:26=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Hi,
>
> On 9/10/23 10:24, Andy Shevchenko wrote:
> > On Sat, Sep 9, 2023 at 5:18=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
> >>
> >> Refactor x86_android_tablet_get_gpiod() to no longer use
> >> gpiolib private functions like gpiochip_find().
> >>
> >> As a bonus this allows specifying that the GPIO is active-low,
> >> like the /CE (charge enable) pin on the bq25892 charger on
> >> the Lenovo Yoga Tablet 3.
> >
> > The best patch in the series!
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> > See below a couple of questions.
> >
> > ...
> >
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
> >> -       gpiod =3D gpiochip_get_desc(chip, pin);
> >>         if (IS_ERR(gpiod)) {
> >> -               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod=
), label, pin);
> >> +               pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod=
), chip, pin);
> >>                 return PTR_ERR(gpiod);
> >>         }
> >
> >> -       *desc =3D gpiod;
> >> +       if (desc)
> >> +               *desc =3D gpiod;
> >
> > Are we expecting that callers may not want the GPIO descriptor out of
> > this function?
> > Sounds a bit weird if so.
>
> Yes specifically the Charge-enable and OTG (Vboost enable) pins on the
> bq25892 charger on the Lenovo Yoga Tab 3 just need to be set to a fixed
> value, so we request the pins with GPIOD_OUT_LOW / _HIGH and then
> leave them at that value.
>

You mean you leak the descriptor? It would warrant either a comment or
storing the descriptor somewhere and cleaning it up if the device can
be unbound (I guess it can since the driver can be built as module).

Bart

> I think similar stuff may come up later, so it seems nice to be able
> to not have to pass an otherwise unused gpio_desc pointer.
>
>
> >
> >>         return 0;
> >>  }
> >
> > ...
> >
> >>          * The bq25890_charger driver controls these through I2C, but =
this only
> >>          * works if not overridden by the pins. Set these pins here:
> >> -        * 1. Set /CE to 0 to allow charging.
> >
> >> +        * 1. Set /CE to 1 to allow charging.
> >>          * 2. Set OTG to 0 disable V5 boost output since the 5V boost =
output of
> >>          *    the main "bq25892_1" charger is used when necessary.
> >
> > Shouldn't we use terminology "active"/"non-active" instead of plain 0
> > and 1 in the above?
>
> Well the flags are called GPIOD_OUT_HIGH / GPIOD_OUT_LOW and
> with gpiod_set_value 0/1 is used. I'm not in favor of adding
> "active"/"non-active" into the mix. That just adds a 3th way to
> say 0/low or 1/high.
>
> Regards,
>
> Hans
>
>
>
>
> >
> >>          */
> >
> > ...
> >
> >> -       ret =3D x86_android_tablet_get_gpiod("INT33FF:02", 22, &gpiod)=
;
> >> +       ret =3D x86_android_tablet_get_gpiod("INT33FF:02", 22, "bq2589=
2_0_ce",
> >> +                                          true, GPIOD_OUT_HIGH, NULL)=
;
> >>         if (ret < 0)
> >>                 return ret;
> >
> > Hmm... Maybe better this function to return an error pointer or valid
> > pointer, and in the code you choose what to do with that?
> >
> > ...
> >
> >>         /* OTG pin */
> >> -       ret =3D x86_android_tablet_get_gpiod("INT33FF:03", 19, &gpiod)=
;
> >> +       ret =3D x86_android_tablet_get_gpiod("INT33FF:03", 19, "bq2589=
2_0_otg",
> >> +                                          false, GPIOD_OUT_LOW, NULL)=
;
> >
> > Ditto.
> >
> >>         if (ret < 0)
> >>                 return ret;
> >
>
