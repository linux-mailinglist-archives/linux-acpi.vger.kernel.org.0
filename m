Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190396A6B19
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 11:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCAKwy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 05:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCAKww (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 05:52:52 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14F3646D
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 02:52:47 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id op8so8892522qvb.11
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2023 02:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3A2mADJZkf3TyfZH1bS5cG/I+Zocrel5RU6ncF0F9U=;
        b=KqlGEelTRMU1C3OQWH8nfEBbxXixuVlbYH0klA1qLgP60wmOvh06VV8zRmiQXYOAII
         OpVC9d1liZnYvzJ3CffBRJlT2lM2p38qK65geLp613GCfRArb2t7aM19k+adLaWFFy3r
         i3eAJdhMekQfJagNDmA5OoOxrW6+BkvbWCdk6EpIm5cAKrA62/m5jRAtGdp3oUI2LPBH
         U9ZbRDuMnyMOLv/AgnDV5D3CbytCH3oTDK8aKaaQ93Dph9xLMkdGCG5O0EmZ6Q1O2Jy2
         pVQsfK6XGovbYk5faU7VWW2+hbQeLI1y2kI3356U9XxrzMIUmdtWTbcMnk5sT0rLWYSd
         PQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3A2mADJZkf3TyfZH1bS5cG/I+Zocrel5RU6ncF0F9U=;
        b=A4n6VhKE1LTJFnpnFwpEY6aQpAITD7BF3dFqavE1lPdWv3Fpx6zTytQHP6tkp1c66x
         BjxaRaz6oje2DPsWcbTYzDn5UK8vrv4tPOSN0ASnIQYiaXd8MQlvhIIqVIWdF96hEYv+
         WLrQa8Jg1OLxhki45LQVj4oS4+wvfGS3Tlqe6ZuDof50Eo9ucqFm7or0bL0soB/Nz85l
         qsXM11mxvsrRGiu+Jtzf1Zvyz4pU5QaaRAmA+Z0N4FQ/LmtrHZZlKPfnWwZ/x/Y/8vTl
         8zTWBn+qvXFaJ219hobo0VTxFRB/c49kU5j3nRByz43uLwbdZjN0ckRd2/uDbfSARjIo
         cwoA==
X-Gm-Message-State: AO0yUKVdSFxnPvJbKymYjEA5FSCvfRvX4YGrKZjFK6RvOnECseQffFI+
        dMPVdp9kv/COV7/sSrvRcQopUQzoYYoh1iM4f3s=
X-Google-Smtp-Source: AK7set9ErZZX2Jx6wCMqNYqSKKD2Gjf+kS4M52gMsueCw/lsABNedagXJuLxhSxbf/F1HhVb0HZyhrFRrI2zJjj+Lqs=
X-Received: by 2002:ad4:58f4:0:b0:56f:3aef:1633 with SMTP id
 di20-20020ad458f4000000b0056f3aef1633mr1638573qvb.1.1677667966711; Wed, 01
 Mar 2023 02:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20230301100436.132521-1-hdegoede@redhat.com> <20230301100436.132521-2-hdegoede@redhat.com>
In-Reply-To: <20230301100436.132521-2-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Mar 2023 12:52:10 +0200
Message-ID: <CAHp75VcG5Yf+aJ8YmK6Rp+RRXz3uGOdy_P7wazqXJ8YZN9OsiA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] ACPI: x86: Introduce an acpi_quirk_skip_gpio_event_handlers()
 helper
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Andy Shevchenko <andy@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 1, 2023 at 12:04=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> x86 ACPI boards which ship with only Android as their factory image usual=
ly
> have pretty broken ACPI tables, relying on everything being hardcoded in
> the factory kernel image and often disabling parts of the ACPI enumeratio=
n
> kernel code to avoid the broken tables causing issues.
>
> Part of this broken ACPI code is that sometimes these boards have _AEI
> ACPI GPIO event handlers which are broken.
>
> So far this has been dealt with in the platform/x86/x86-android-tablets.c
> module, which contains various workarounds for these devices, by it calli=
ng
> acpi_gpiochip_free_interrupts() on gpiochip-s with troublesome handlers t=
o
> disable the handlers.
>
> But in some cases this is too late, if the handlers are of the edge type
> then gpiolib-acpi.c's code will already have run them at boot.
> This can cause issues such as GPIOs ending up as owned by "ACPI:OpRegion"=
,
> making them unavailable for drivers which actually need them.
>
> Boards with these broken ACPI tables are already listed in
> drivers/acpi/x86/utils.c for e.g. acpi_quirk_skip_i2c_client_enumeration(=
).
> Extend the quirks mechanism for a new acpi_quirk_skip_gpio_event_handlers=
()
> helper, this re-uses the DMI-ids rather then having to duplicate the same
> DMI table in gpiolib-acpi.c .
>
> Also add the new ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS quirk to existing
> boards with troublesome ACPI gpio event handlers, so that the current
> acpi_gpiochip_free_interrupts() hack can be removed from
> x86-android-tablets.c .
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c    | 24 +++++++++++++++++++++---
>  drivers/gpio/gpiolib-acpi.c |  3 +++
>  include/acpi/acpi_bus.h     |  5 +++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 4e816bb402f6..4a6f3a6726d0 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -262,6 +262,7 @@ bool force_storage_d3(void)
>  #define ACPI_QUIRK_UART1_TTY_UART2_SKIP                                B=
IT(1)
>  #define ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTERY                    BIT(2)
>  #define ACPI_QUIRK_USE_ACPI_AC_AND_BATTERY                     BIT(3)
> +#define ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS                    BIT(4)
>
>  static const struct dmi_system_id acpi_quirk_skip_dmi_ids[] =3D {
>         /*
> @@ -297,7 +298,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi=
_ids[] =3D {
>                 },
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
>                                         ACPI_QUIRK_UART1_TTY_UART2_SKIP |
> -                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
>         },
>         {
>                 .matches =3D {
> @@ -305,7 +307,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi=
_ids[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "TF103C"),
>                 },
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> -                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
>         },
>         {
>                 /* Lenovo Yoga Tablet 2 1050F/L */
> @@ -347,7 +350,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi=
_ids[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "M890BAP"),
>                 },
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> -                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
>         },
>         {
>                 /* Whitelabel (sold as various brands) TM800A550L */
> @@ -424,6 +428,20 @@ int acpi_quirk_skip_serdev_enumeration(struct device=
 *controller_parent, bool *s
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(acpi_quirk_skip_serdev_enumeration);
> +
> +bool acpi_quirk_skip_gpio_event_handlers(void)
> +{
> +       const struct dmi_system_id *dmi_id;
> +       long quirks;
> +
> +       dmi_id =3D dmi_first_match(acpi_quirk_skip_dmi_ids);
> +       if (!dmi_id)
> +               return false;
> +
> +       quirks =3D (unsigned long)dmi_id->driver_data;
> +       return (quirks & ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS);
> +}
> +EXPORT_SYMBOL_GPL(acpi_quirk_skip_gpio_event_handlers);
>  #endif
>
>  /* Lists of PMIC ACPI HIDs with an (often better) native charger driver =
*/
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index 34ff048e70d0..7c9175619a1d 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -536,6 +536,9 @@ void acpi_gpiochip_request_interrupts(struct gpio_chi=
p *chip)
>         if (ACPI_FAILURE(status))
>                 return;
>
> +       if (acpi_quirk_skip_gpio_event_handlers())
> +               return;

Not that I'm a fan of this, but at least it's not so ugly and invasive,
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
for GPIO ACPI library part.

>         acpi_walk_resources(handle, METHOD_NAME__AEI,
>                             acpi_gpiochip_alloc_event, acpi_gpio);
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e44be31115a6..d69545cd6a48 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -656,6 +656,7 @@ static inline bool acpi_quirk_skip_acpi_ac_and_batter=
y(void)
>  #if IS_ENABLED(CONFIG_X86_ANDROID_TABLETS)
>  bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_device *adev);
>  int acpi_quirk_skip_serdev_enumeration(struct device *controller_parent,=
 bool *skip);
> +bool acpi_quirk_skip_gpio_event_handlers(void);
>  #else
>  static inline bool acpi_quirk_skip_i2c_client_enumeration(struct acpi_de=
vice *adev)
>  {
> @@ -667,6 +668,10 @@ acpi_quirk_skip_serdev_enumeration(struct device *co=
ntroller_parent, bool *skip)
>         *skip =3D false;
>         return 0;
>  }
> +static inline bool acpi_quirk_skip_gpio_event_handlers(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #ifdef CONFIG_PM
> --
> 2.39.1
>


--=20
With Best Regards,
Andy Shevchenko
