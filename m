Return-Path: <linux-acpi+bounces-453-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEB87BAB88
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 22:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 437791C20837
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 20:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6104741758
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DjqUBS1Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2A7266D5
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 19:24:11 +0000 (UTC)
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA1DE
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 12:24:09 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7b0a16f0338so574714241.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Oct 2023 12:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696533848; x=1697138648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kJIBjdHm1ElO0Q/5Tg/KzhsnCInNf6ArioOkVClacUM=;
        b=DjqUBS1ZNqUaUwBp5v/sxIwfbA8cjule898WmFKphi1uUpN4iHbnTholmhcKeTMNDL
         Idd7xXoUv7pzS/q7Z70ZQpRRsvPhAC2JJ9WELCjTg5QjGQ1Jp21ONCY9e0GiVkM92sq9
         FvoYkVFiE2XjhVo8WUSpGO4VqYySoMpgi2qEL2MHTdPbRvQBGqcNQX3/24iF36+rk2x+
         3WELdSEb3TXI5N4HOOdxBYA2C43iA+puqbiyg8XJhjJVQg1zwuX07gXVj/Hr59OiMd+N
         JwXnsA1eXFG/9elj6A672kC88QO6BsnmX2Ony4634+iXmCCXpyc+GNUbG2FIjDNASkj2
         catw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533848; x=1697138648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kJIBjdHm1ElO0Q/5Tg/KzhsnCInNf6ArioOkVClacUM=;
        b=CKUCvy9NcdThz9Xp8Ou0DK3223neNY58W8z46fYLN8RjWj5iFB/5XBvkdeqbWEC6lT
         byA5w14O3U6ni+gVT4g3kGtUxIlKxHWtjtEax5snTsalDEYKu895jieQrElPEa8dZy/f
         jaFJSbP6D/cU80lbq90q7U5dStNlRhYtuOxczQWkxeIVSOaGILhbca1jQxhxDnPDPasg
         6CVFwxo/8aiE1Pc8hPKY0pcpwguAKe42s30JwkxmXoo5Ze1IFsCJjv28R/Ek30OdKHMU
         TZkTe0zEVlSvDnIHLmdz6EuyeFSxsiqH9kIZqGfr9ui1Xjy/KU5SG6MSS2/7KPaD0Sqt
         9Vuw==
X-Gm-Message-State: AOJu0YwyQ4kVFhhfPxGvAskmnd3Oh+ZpKrZVaa40WN7Bf+tT2fPCv6FJ
	9rdb62USpYRHh2QtUI+dPXGDVaD58nbJ/KKZMTCWFw==
X-Google-Smtp-Source: AGHT+IGh0duTgq7OsXC+XkKGS9kNsK8dFunWxtrrnDWf7uvEm2UFTdjxGkSLPPX416q5NVUUBUMe2HS8FIujKIqUyzg=
X-Received: by 2002:a67:f252:0:b0:454:6fb8:9d4e with SMTP id
 y18-20020a67f252000000b004546fb89d4emr6450286vsm.25.1696533848483; Thu, 05
 Oct 2023 12:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004162317.163488-1-hdegoede@redhat.com> <20231004162317.163488-5-hdegoede@redhat.com>
In-Reply-To: <20231004162317.163488-5-hdegoede@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Oct 2023 21:23:57 +0200
Message-ID: <CAMRc=Me-g+qG7-_0r0b-6bXDie5AFDNC-WVp+fo3LDrStP5NVw@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] platform/x86: int3472: Switch to devm_get_gpiod()
To: Hans de Goede <hdegoede@redhat.com>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, 
	platform-driver-x86@vger.kernel.org, Daniel Scally <djrscally@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 6:23=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Switch to devm_get_gpiod() for discrete GPIOs for clks / regulators / LED=
s
> and let devm do the cleanup for us.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  .../x86/intel/int3472/clk_and_regulator.c     | 23 ++++---------------
>  drivers/platform/x86/intel/int3472/discrete.c |  2 +-
>  drivers/platform/x86/intel/int3472/led.c      |  7 +-----
>  3 files changed, 6 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/dri=
vers/platform/x86/intel/int3472/clk_and_regulator.c
> index 459f96c04ca1..16e36ac0a7b4 100644
> --- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> +++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
> @@ -177,10 +177,8 @@ int skl_int3472_register_gpio_clock(struct int3472_d=
iscrete_device *int3472,
>
>         init.name =3D kasprintf(GFP_KERNEL, "%s-clk",
>                               acpi_dev_name(int3472->adev));
> -       if (!init.name) {
> -               ret =3D -ENOMEM;
> -               goto out_put_gpio;
> -       }
> +       if (!init.name)
> +               return -ENOMEM;
>
>         int3472->clock.frequency =3D skl_int3472_get_clk_frequency(int347=
2);
>
> @@ -206,8 +204,6 @@ int skl_int3472_register_gpio_clock(struct int3472_di=
screte_device *int3472,
>         clk_unregister(int3472->clock.clk);
>  out_free_init_name:
>         kfree(init.name);
> -out_put_gpio:
> -       gpiod_put(int3472->clock.ena_gpio);
>
>         return ret;
>  }
> @@ -219,7 +215,6 @@ void skl_int3472_unregister_clock(struct int3472_disc=
rete_device *int3472)
>
>         clkdev_drop(int3472->clock.cl);
>         clk_unregister(int3472->clock.clk);
> -       gpiod_put(int3472->clock.ena_gpio);
>  }
>
>  /*
> @@ -266,7 +261,7 @@ int skl_int3472_register_regulator(struct int3472_dis=
crete_device *int3472,
>         struct regulator_config cfg =3D { };
>         const char *second_sensor =3D NULL;
>         const struct dmi_system_id *id;
> -       int i, j, ret;
> +       int i, j;
>
>         id =3D dmi_first_match(skl_int3472_regulator_second_sensor);
>         if (id)
> @@ -309,21 +304,11 @@ int skl_int3472_register_regulator(struct int3472_d=
iscrete_device *int3472,
>         int3472->regulator.rdev =3D regulator_register(int3472->dev,
>                                                      &int3472->regulator.=
rdesc,
>                                                      &cfg);
> -       if (IS_ERR(int3472->regulator.rdev)) {
> -               ret =3D PTR_ERR(int3472->regulator.rdev);
> -               goto err_free_gpio;
> -       }
>
> -       return 0;
> -
> -err_free_gpio:
> -       gpiod_put(int3472->regulator.gpio);
> -
> -       return ret;
> +       return PTR_ERR_OR_ZERO(int3472->regulator.rdev);
>  }
>
>  void skl_int3472_unregister_regulator(struct int3472_discrete_device *in=
t3472)
>  {
>         regulator_unregister(int3472->regulator.rdev);
> -       gpiod_put(int3472->regulator.gpio);
>  }
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index 0bc7cbefd9ae..07b302e09340 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -119,7 +119,7 @@ skl_int3472_gpiod_get_from_temp_lookup(struct int3472=
_discrete_device *int3472,
>                 return ERR_PTR(ret);
>
>         gpiod_add_lookup_table(lookup);
> -       desc =3D gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
> +       desc =3D devm_gpiod_get(int3472->dev, func, GPIOD_OUT_LOW);
>         gpiod_remove_lookup_table(lookup);
>
>         return desc;
> diff --git a/drivers/platform/x86/intel/int3472/led.c b/drivers/platform/=
x86/intel/int3472/led.c
> index 476cd637fc51..9cbed694e2ca 100644
> --- a/drivers/platform/x86/intel/int3472/led.c
> +++ b/drivers/platform/x86/intel/int3472/led.c
> @@ -39,7 +39,7 @@ int skl_int3472_register_pled(struct int3472_discrete_d=
evice *int3472, struct gp
>
>         ret =3D led_classdev_register(int3472->dev, &int3472->pled.classd=
ev);
>         if (ret)
> -               goto err_free_gpio;
> +               return ret;
>
>         int3472->pled.lookup.provider =3D int3472->pled.name;
>         int3472->pled.lookup.dev_id =3D int3472->sensor_name;
> @@ -47,10 +47,6 @@ int skl_int3472_register_pled(struct int3472_discrete_=
device *int3472, struct gp
>         led_add_lookup(&int3472->pled.lookup);
>
>         return 0;
> -
> -err_free_gpio:
> -       gpiod_put(int3472->pled.gpio);
> -       return ret;
>  }
>
>  void skl_int3472_unregister_pled(struct int3472_discrete_device *int3472=
)
> @@ -60,5 +56,4 @@ void skl_int3472_unregister_pled(struct int3472_discret=
e_device *int3472)
>
>         led_remove_lookup(&int3472->pled.lookup);
>         led_classdev_unregister(&int3472->pled.classdev);
> -       gpiod_put(int3472->pled.gpio);
>  }
> --
> 2.41.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

