Return-Path: <linux-acpi+bounces-452-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6457BAB86
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 22:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id E5726281F71
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 20:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35CE3F4AA
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Oct 2023 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sb3BxPRB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9375A266D5
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 19:21:50 +0000 (UTC)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4BDDB
	for <linux-acpi@vger.kernel.org>; Thu,  5 Oct 2023 12:21:49 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-49369d29be3so544776e0c.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Oct 2023 12:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696533708; x=1697138508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZ5nQ4FX57Hz3jHKgT06APZP5qfOfB/HcB4dGGZFKGk=;
        b=sb3BxPRBdVbf4n78JGnQp4Cov5mT93ycCokCfiPi3K7hfUM1rO/mChlpRPVYz070v7
         TTf1k/jIAnroFR0kET4wmBC2EKhRwAoks83VDVzaISXHbQMx/3kbFFJGIxDF3WctzgNQ
         M6FIJV3fBqBLl0G1EXDngJmYM10WGcWXT7Nm2iqZNyYSImtGO359PYoU1rYz5CeX0k3t
         iLzf0F3AsMZPLmp91rymVKgnDtWxXwO5aW5IqWNPPi/s9JDq2AbtTQ0RnpJfsvlYwVC8
         fuSUbmweDT0uRFjCPE2e2Cn56WR/mHUqqCXxjJwv3fYLQ8oh77PXZVFbGQ1i1pCukmBS
         Zt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696533708; x=1697138508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZ5nQ4FX57Hz3jHKgT06APZP5qfOfB/HcB4dGGZFKGk=;
        b=Xt7GUUiSV5g+LkyPgq0fFaIyjbNum+GDGh3jKtOv/tYJPti9oE8y4/cgcOta2Bc1jq
         srVjDm9lmfgnIAgNnOorkuvWLHS+ECEhRJFAYAgk4Mv6TDjuEyOB/Iq7LBDLPaTvPk8Y
         +4SGJsi8bO12WoEzKcgQF5YABe+ElA7xKos6QKKf5j0DVAEQ2VrV7/jJgGjKlviU0KRp
         ZputCzjdhuD4NHi3xbQk/i1Or8M+vJJQ2kxwlvUw39ieaZg0cMFSREGbJK8sg+GSVstT
         IDlohxE2Iqa2PSCl6JwqUKaCItmnzQNXAzrDVZ11CGsYwA1AI8Kk6Q8fE0hkFSPkZluV
         1aIg==
X-Gm-Message-State: AOJu0YyiPQ5Jh6KDqLt0z4D2f+rIQIdiM5e9qlmX4pkY5apBr3qLBBNZ
	nWasggIXlQQlpA5eBvmKV3gxx8mUNkrgNtVltl7pQQ==
X-Google-Smtp-Source: AGHT+IEwJl8lGnEeNibTIJXnkxtfJKixGZtnbqP5Q2WvwRFKjN9RjUnT2M2rYumDdBDVZ9T6bp8HXCnRHzv/w+QXEA8=
X-Received: by 2002:a1f:df01:0:b0:486:e696:c69a with SMTP id
 w1-20020a1fdf01000000b00486e696c69amr5398458vkg.16.1696533708218; Thu, 05 Oct
 2023 12:21:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231004162317.163488-1-hdegoede@redhat.com> <20231004162317.163488-2-hdegoede@redhat.com>
In-Reply-To: <20231004162317.163488-2-hdegoede@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 5 Oct 2023 21:21:37 +0200
Message-ID: <CAMRc=Membo2qcYGHLSNXCCk0Bvnd=pjXP_hUVP_x72DttCXUhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] platform/x86: int3472: Add new skl_int3472_fill_gpiod_lookup()
 helper
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
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 4, 2023 at 6:23=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Add a new skl_int3472_fill_gpiod_lookup() helper.
>
> This is a preparation patch for removing usage of the deprecated
> gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel/int3472/discrete.c | 32 +++++++++++++------
>  1 file changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/int3472/discrete.c b/drivers/plat=
form/x86/intel/int3472/discrete.c
> index e33c2d75975c..351ecf047944 100644
> --- a/drivers/platform/x86/intel/int3472/discrete.c
> +++ b/drivers/platform/x86/intel/int3472/discrete.c
> @@ -52,21 +52,15 @@ static void skl_int3472_log_sensor_module_name(struct=
 int3472_discrete_device *i
>         }
>  }
>
> -static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device=
 *int3472,
> -                                         struct acpi_resource_gpio *agpi=
o,
> -                                         const char *func, u32 polarity)
> +static int skl_int3472_fill_gpiod_lookup(struct gpiod_lookup *table_entr=
y,
> +                                        struct acpi_resource_gpio *agpio=
,
> +                                        const char *func, u32 polarity)
>  {
>         char *path =3D agpio->resource_source.string_ptr;
> -       struct gpiod_lookup *table_entry;
>         struct acpi_device *adev;
>         acpi_handle handle;
>         acpi_status status;
>
> -       if (int3472->n_sensor_gpios >=3D INT3472_MAX_SENSOR_GPIOS) {
> -               dev_warn(int3472->dev, "Too many GPIOs mapped\n");
> -               return -EINVAL;
> -       }
> -
>         status =3D acpi_get_handle(NULL, path, &handle);
>         if (ACPI_FAILURE(status))
>                 return -EINVAL;
> @@ -75,13 +69,31 @@ static int skl_int3472_map_gpio_to_sensor(struct int3=
472_discrete_device *int347
>         if (!adev)
>                 return -ENODEV;
>
> -       table_entry =3D &int3472->gpios.table[int3472->n_sensor_gpios];
>         table_entry->key =3D acpi_dev_name(adev);
>         table_entry->chip_hwnum =3D agpio->pin_table[0];
>         table_entry->con_id =3D func;
>         table_entry->idx =3D 0;
>         table_entry->flags =3D polarity;
>
> +       return 0;
> +}
> +
> +static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device=
 *int3472,
> +                                         struct acpi_resource_gpio *agpi=
o,
> +                                         const char *func, u32 polarity)
> +{
> +       int ret;
> +
> +       if (int3472->n_sensor_gpios >=3D INT3472_MAX_SENSOR_GPIOS) {
> +               dev_warn(int3472->dev, "Too many GPIOs mapped\n");
> +               return -EINVAL;
> +       }
> +
> +       ret =3D skl_int3472_fill_gpiod_lookup(&int3472->gpios.table[int34=
72->n_sensor_gpios],
> +                                           agpio, func, polarity);
> +       if (ret)
> +               return ret;
> +
>         int3472->n_sensor_gpios++;
>
>         return 0;
> --
> 2.41.0
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

