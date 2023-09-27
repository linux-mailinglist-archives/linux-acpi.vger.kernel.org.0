Return-Path: <linux-acpi+bounces-189-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C5D7B042E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 108A31C2093E
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BB28DC0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 12:31:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DDA8C08
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 10:44:45 +0000 (UTC)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3660E1A5
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 03:44:43 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-49441300156so7083319e0c.0
        for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 03:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1695811482; x=1696416282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIY6FN2lfitSz4qDRVZqEKQkYNhz4efZRKxVEBkV/XU=;
        b=tck8UzOtayD0BEXwOkNO3d1/I2GCKGMpzh1m5fqb9qOQrlebmn4e5OTssyJ5NUbNag
         jBINy4+tvVWPYvunDKwYl/Ka5w1P7YJykoI26rmVfe5+/FyTdP9hznLRgoSBOGWAAsRZ
         U+/bGxh8FX2ki3L/plts/6WlvrkAhTwFMxjE+k+EEUk2an1mNb8YkmSC6Z2Ab889iIF8
         0W1yunP4a0dxG/yeFqrw0rGblGZ8VYMlO+ocryjv3Rf/kDD7mOeCraN6VOGsseHJuCxC
         Jjgz/v/d0kMPL1g7JMyrcCp65zGxrQq1elS4Qn28/6qeR3HojySya/huayli9x9XtZsT
         sAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695811482; x=1696416282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIY6FN2lfitSz4qDRVZqEKQkYNhz4efZRKxVEBkV/XU=;
        b=af3DCOEa9BVeGeCMTDWv2XH9PLpQgMJr9bV9cgjnNI/YWUViFZEu7Eh+Zi4210VUqC
         iD6RdY8sw48NxwJQJz0HahBlvxsa1OPcTRSQVPgecMNmJ087eNK7hI4o2WeHz4Stty2g
         5LOv+mXzFGmdwwAeaDxIYUDomheC4u703xXazprbbnR/oW+1J/vzUeUYtL/Eit0DmhUl
         Y1tbJ33mz3zuDVCXiJoXR6JrRaGLpO+CqVmm+foXj6ZTmuYqC6BcFpBRdGhALZBsGFMb
         ncbc1/b2TFZM/D8sWUyCf3LoL6FzUPbl9XKpKA4WjETYWpJnpSVpnChYQwFxpojKKh+v
         7H3w==
X-Gm-Message-State: AOJu0YxXRZS94p9Z53JgxqdGrEL4cAk0ujefjhQuYABtOsHO/zSMWgqr
	Zv5yFaOv6LHA3uhvm1VW7n45Hdc6yblNQsBclOG3Gvz35KeyHZGx3OE=
X-Google-Smtp-Source: AGHT+IHlpiKxFDrQE7H2nhagvef0n/Ur4n5e6glsq/q61ZhdqNzd7K2FGju+wqsPKfIYRXdttsvmz+1dQiTmIZi/taM=
X-Received: by 2002:a05:6122:4214:b0:499:72ff:1459 with SMTP id
 cm20-20020a056122421400b0049972ff1459mr2761227vkb.1.1695811482189; Wed, 27
 Sep 2023 03:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230926145943.42814-1-brgl@bgdev.pl> <20230926145943.42814-3-brgl@bgdev.pl>
 <2b5db794-c00f-e9f5-c0c9-4c5fb4df0802@redhat.com>
In-Reply-To: <2b5db794-c00f-e9f5-c0c9-4c5fb4df0802@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 27 Sep 2023 12:44:31 +0200
Message-ID: <CAMRc=MeSK-ZReyt4556Dik4GwgtitD-NBgVE0swe=4i+5gBLwA@mail.gmail.com>
Subject: Re: [RFT PATCH 2/4] platform/x86: int3472: led: don't use gpiod_toggle_active_low()
To: Hans de Goede <hdegoede@redhat.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 11:40=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Hi,
>
> On 9/26/23 16:59, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Instead of acpi_get_and_request_gpiod() + gpiod_toggle_active_low(), us=
e
> > temporary lookup tables with appropriate lookup flags.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> >  drivers/platform/x86/intel/int3472/led.c | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platfor=
m/x86/intel/int3472/led.c
> > index bca1ce7d0d0c..62e0cd5207a7 100644
> > --- a/drivers/platform/x86/intel/int3472/led.c
> > +++ b/drivers/platform/x86/intel/int3472/led.c
> > @@ -25,18 +25,14 @@ int skl_int3472_register_pled(struct int3472_discre=
te_device *int3472,
> >       if (int3472->pled.classdev.dev)
> >               return -EBUSY;
> >
> > -     int3472->pled.gpio =3D acpi_get_and_request_gpiod(path, agpio->pi=
n_table[0],
> > -                                                          "int3472,pri=
vacy-led");
> > +     int3472->pled.gpio =3D skl_int3472_gpiod_get_from_temp_lookup(
> > +                             int3472->dev, path, agpio->pin_table[0],
> > +                             "int3472,privacy-led", polarity,
> > +                             GPIOD_OUT_LOW);
>
> Yeah so this is not going to work, path here is an ACPI device path, e.g.
> on my laptop (which actually uses the INT3472 glue code) the path-s of
> the 2 GPIO controllers are: `\_SB_.GPI0` resp `\_SB_.PC00.XHCI.RHUB.HS08.=
VGPO`
>
> Where as skl_int3472_gpiod_get_from_temp_lookup() stores the passed in pa=
th
> in  gpiod_lookup_table.table[0].key, which is the dev_name() of the GPIO
> controller's parent dev which are `INTC1055:00` resp. `INTC1096:00` .
>
> So we are going to need to add some code to INT3472 to go from path to
> a correct value for gpiod_lookup_table.table[0].key which means partly
> reproducing most of acpi_get_gpiod:
>
>         struct gpio_chip *chip;
>         acpi_handle handle;
>         acpi_status status;
>
>         status =3D acpi_get_handle(NULL, path, &handle);
>         if (ACPI_FAILURE(status))
>                 return ERR_PTR(-ENODEV);
>
>         chip =3D gpiochip_find(handle, acpi_gpiochip_find);
>         if (!chip)
>                 return ERR_PTR(-EPROBE_DEFER);
>
> And then get the key from the chip. Which means using gpiochip_find
> in the int3472 code now, which does not sound like an improvement.
>
> I think that was is needed instead is adding an active_low flag
> to acpi_get_and_request_gpiod() and then have that directly
> set the active-low flag on the returned desc.
>

Ultimately I'd like everyone to use gpiod_get() for getting
descriptors but for now I get it's enough. Are you find with this
being done in a single patch across GPIO and this driver?

Bart

> Regards,
>
> Hans
>
>
>
>
>
>
>
>
> >       if (IS_ERR(int3472->pled.gpio))
> >               return dev_err_probe(int3472->dev, PTR_ERR(int3472->pled.=
gpio),
> >                                    "getting privacy LED GPIO\n");
> >
> > -     if (polarity =3D=3D GPIO_ACTIVE_LOW)
> > -             gpiod_toggle_active_low(int3472->pled.gpio);
> > -
> > -     /* Ensure the pin is in output mode and non-active state */
> > -     gpiod_direction_output(int3472->pled.gpio, 0);
> > -
> >       /* Generate the name, replacing the ':' in the ACPI devname with =
'_' */
> >       snprintf(int3472->pled.name, sizeof(int3472->pled.name),
> >                "%s::privacy_led", acpi_dev_name(int3472->sensor));
>

