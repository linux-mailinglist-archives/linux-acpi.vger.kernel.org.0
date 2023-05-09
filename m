Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA206FC655
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbjEIM22 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 08:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjEIM2Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 08:28:24 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADA1BD4
        for <linux-acpi@vger.kernel.org>; Tue,  9 May 2023 05:28:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75785057afeso194368085a.3
        for <linux-acpi@vger.kernel.org>; Tue, 09 May 2023 05:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683635298; x=1686227298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xu5I8cSBKc8RRAnhxX7fcNJPRn7J4k5h2NyOW/avvTA=;
        b=c2qSRxGFOk6Paf8Dequ5KD3pe9mBzQKhmR77KI9TaNUORs+7TW2URNM86vArQ+nbL6
         D4loIO1TLUtHVMrfC3zs8BvU5P0axqc5woFc2vTDTxtRzQLqLx3FtvZLagMUaYKxzq5h
         O7Dl8QUMTn7honv/eMWZy4aFbysWP7CZBIkMyzk7anzBL4bISb//tPvOM52JR6KQh0TI
         qe99YifrYmebxTOxsevnYNp8RIniyH2/zBcT8dHTGQmTOSnAYT4LybE4WY6+Sck1EaaO
         pD/56sQ8OgaxFF7bA2vSdv42tAiHXyLl4IG6DZtnZ019FWSHSWTwaWu5rwtViKMQdfnB
         V77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683635298; x=1686227298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xu5I8cSBKc8RRAnhxX7fcNJPRn7J4k5h2NyOW/avvTA=;
        b=F5oiZajmrrWcGDY/+oOVGF6gCfQxjHbfg1+MGrb2/ckIymyUydDKV7YWpNJ2BvE3lN
         eH3cmATxiz+TUgvyV/2li/Giwerb3wFUGCq/fEV/YYTrQOIzHqB/h829IWlFcUAjz/3S
         ZwEkfKgj45GzBzgxWL+vUohjFSHiOvlEQ89/lAGilqRgw1QCUiDe91Vk1mwHuuJ4lJsZ
         jhVULIwPUXKqam3jq/bDNossmRUP+4s4JRVrfSZCtmoiuTfPqExBHO35at9pZi/n0CHp
         vHXgvbUGPYYGXtZuLkrpKZU0lYeCbKzHucwgxUYbcpGnpHtJdJJxAzdJj3sB4uriIZJt
         ygGA==
X-Gm-Message-State: AC+VfDycfZfJ1wUtjXTCXS8Lk6FoqKkAxGO3iUQQ5i3wn046CjF+kpBh
        2CHvHnhKHQoThVEiVrFjU2RZXJ9hPdwiCF/gZK4EcxYY9TuM0Q==
X-Google-Smtp-Source: ACHHUZ6bb0vpiU95lMOThhsM9USXNzjtofGqqLvvHqtXFhxEQC5FOxUpzDzoeCqWNdPvvFnsNOZShfRNb9u0QfSDOBk=
X-Received: by 2002:a05:6214:27c5:b0:61b:5ca6:b7fb with SMTP id
 ge5-20020a05621427c500b0061b5ca6b7fbmr20530786qvb.28.1683635298480; Tue, 09
 May 2023 05:28:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230509115226.287318-1-hdegoede@redhat.com>
In-Reply-To: <20230509115226.287318-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 May 2023 15:27:42 +0300
Message-ID: <CAHp75VcHzYBYbuOrHEdDTajux_AE3HmhMsSvppGhnJMtt0HEkw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: LPSS: Add pwm_lookup_table entry for second PWM on
 CHT/BSW devices
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, linux-acpi@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 9, 2023 at 2:52=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> BSW PWM2 is used for backlight control for fixed (etched into the glass)
> touch controls on some models.
>
> Add an entry for the second PWM controller to bsw_pwm_lookup,
> so that drivers can use pwm_get() to get a referene to it.

reference

> These touch-controls have specialized drivers which bind to different
> devices on different models, so the consumer-device-name in the lookup
> table entry is set to NULL, so that only con-id matching is used.
>
> The con-id is set to "pwm_soc_lpss_2" which describes the PWM controller
> rather then the usual approach of describing its function.

than

> The specialized (model specific) drivers which need access to the PWM
> controller know they need the "pwm_soc_lpss_2" con-id.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_lpss.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index 77186f084d3a..539e700de4d2 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -201,11 +201,19 @@ static void byt_i2c_setup(struct lpss_private_data =
*pdata)
>         writel(0, pdata->mmio_base + LPSS_I2C_ENABLE);
>  }
>
> -/* BSW PWM used for backlight control by the i915 driver */
> +/*
> + * BSW PWM1 is used for backlight control by the i915 driver
> + * BSW PWM2 is used for backlight control for fixed (etched into the gla=
ss)
> + * touch controls on some models. These touch-controls have specialized
> + * drivers which know they need the "pwm_soc_lpss_2" con-id.
> + */
>  static struct pwm_lookup bsw_pwm_lookup[] =3D {
>         PWM_LOOKUP_WITH_MODULE("80862288:00", 0, "0000:00:02.0",
>                                "pwm_soc_backlight", 0, PWM_POLARITY_NORMA=
L,
>                                "pwm-lpss-platform"),
> +       PWM_LOOKUP_WITH_MODULE("80862289:00", 0, NULL,
> +                              "pwm_soc_lpss_2", 0, PWM_POLARITY_NORMAL,
> +                              "pwm-lpss-platform"),
>  };
>
>  static void bsw_pwm_setup(struct lpss_private_data *pdata)
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
