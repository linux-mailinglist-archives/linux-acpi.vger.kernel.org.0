Return-Path: <linux-acpi+bounces-1631-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABD27F1CC7
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 19:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FB41F25CEB
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABFB31583
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Nov 2023 18:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FF193
	for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:50:45 -0800 (PST)
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6cb552cf81dso189858b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Nov 2023 08:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700499045; x=1701103845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNWxY2vFmdBU/Kgtr0XIOaUgK/4bvyXOZ5Oxka8AZg0=;
        b=sswJs+y2OQ3d+z23rF8KcILD2jI+q7tL7BEtFlo3ZOe9z5H4MytEPEMHailGb5dBCr
         BJk0uc3mY//GFHr+Ss+jhtGpbT1BzRycdEIVgNHXV6V11m/05PZGmHAeFjsiTUNjkyXd
         sD0ry1xtoFW9OgtALQaRsWMRYxkDgDtZTb5H/XTSeTnWxYBHzo6B51P1zR5+4k6kIGcy
         im5Yvn5hYSYbGBmHLaz3blDuoh5UQnOYZSABG8ZX5YZLmOE4SJ+un1yyedVN9WXFDo5j
         pKiV2ybOVe5qSO3uL0YE93jwdSVOUUlFoQww0j6jw3zZ7HD2SBceIeI/PRAQLh8eqO0V
         Q9Pw==
X-Gm-Message-State: AOJu0YygxjJo+6uatY/Vw4QJnP+vaAJzi8aKYST9xINW9yJRoby7jBQQ
	fnzDCp3JsxN6DSk6xe4Gn72ri+ehPP1sK8dt9EM=
X-Google-Smtp-Source: AGHT+IGKVDkHndKLdgbRtrpTqHcPxyvlqSBqSoBTlrVUYQ12ZxZ4RTKOFhYqO/iYyZBLSvRmPVb4DxcaQ3x161q/Z3g=
X-Received: by 2002:a05:6a00:98e:b0:6b2:51a0:e1c9 with SMTP id
 u14-20020a056a00098e00b006b251a0e1c9mr9555399pfg.1.1700499045170; Mon, 20 Nov
 2023 08:50:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115174811.7571-1-hdegoede@redhat.com>
In-Reply-To: <20231115174811.7571-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 20 Nov 2023 17:50:32 +0100
Message-ID: <CAJZ5v0hCwJKQu5Z_6td8EaEcRaa6cgGxUiKfy-ZZBNSrb6dHTA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Drop should_check_lcd_flag()
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 6:48=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> Since commit 3dbc80a3e4c5 ("ACPI: video: Make backlight class device
> registration a separate step (v2)") acpi_video# backlights are no longer
> automatically registered. Instead they now only get registered when
> the GPU/KMS driver calls acpi_video_register_backlight() which it only
> does when it has detected an internal LCD panel.
>
> This fixes the issue of sometimes a non-working acpi_video# backlight
> showing up on Desktops / HDMI-sticks without an internal LCD display
> in a more complete and robust manner then the LCD flag check which
> gets enabled by the should_check_lcd_flag() helper does.
>
> Therefor the should_check_lcd_flag() helper is no longer necessary.
>
> The lcd_only flag itself is still necessary to only register
> a single backlight device (for the right output) on the ESPRIMO Mobile
> M9410 which has 2 ACPI video connector nodes with a _BCM control method,
> which is the issue for which the flag was originally introduced in
> commit e50b9be14ab0 ("ACPI / video: only register backlight for LCD
> device").
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/acpi_video.c | 56 +--------------------------------------
>  1 file changed, 1 insertion(+), 55 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index d321ca7160d9..5eded14f8853 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -67,7 +67,7 @@ MODULE_PARM_DESC(hw_changes_brightness,
>  static bool device_id_scheme =3D false;
>  module_param(device_id_scheme, bool, 0444);
>
> -static int only_lcd =3D -1;
> +static int only_lcd;
>  module_param(only_lcd, int, 0444);
>
>  static bool may_report_brightness_keys;
> @@ -2141,57 +2141,6 @@ static int __init intel_opregion_present(void)
>         return opregion;
>  }
>
> -/* Check if the chassis-type indicates there is no builtin LCD panel */
> -static bool dmi_is_desktop(void)
> -{
> -       const char *chassis_type;
> -       unsigned long type;
> -
> -       chassis_type =3D dmi_get_system_info(DMI_CHASSIS_TYPE);
> -       if (!chassis_type)
> -               return false;
> -
> -       if (kstrtoul(chassis_type, 10, &type) !=3D 0)
> -               return false;
> -
> -       switch (type) {
> -       case 0x03: /* Desktop */
> -       case 0x04: /* Low Profile Desktop */
> -       case 0x05: /* Pizza Box */
> -       case 0x06: /* Mini Tower */
> -       case 0x07: /* Tower */
> -       case 0x10: /* Lunch Box */
> -       case 0x11: /* Main Server Chassis */
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
> -/*
> - * We're seeing a lot of bogus backlight interfaces on newer machines
> - * without a LCD such as desktops, servers and HDMI sticks. Checking the
> - * lcd flag fixes this, enable this by default on any machines which are=
:
> - * 1.  Win8 ready (where we also prefer the native backlight driver, so
> - *     normally the acpi_video code should not register there anyways); =
*and*
> - * 2.1 Report a desktop/server DMI chassis-type, or
> - * 2.2 Are an ACPI-reduced-hardware platform (and thus won't use the EC =
for
> -       backlight control)
> - */
> -static bool should_check_lcd_flag(void)
> -{
> -       if (!acpi_osi_is_win8())
> -               return false;
> -
> -       if (dmi_is_desktop())
> -               return true;
> -
> -       if (acpi_reduced_hardware())
> -               return true;
> -
> -       return false;
> -}
> -
>  int acpi_video_register(void)
>  {
>         int ret =3D 0;
> @@ -2205,9 +2154,6 @@ int acpi_video_register(void)
>                 goto leave;
>         }
>
> -       if (only_lcd =3D=3D -1)
> -               only_lcd =3D should_check_lcd_flag();
> -
>         dmi_check_system(video_dmi_table);
>
>         ret =3D acpi_bus_register_driver(&acpi_video_bus);
> --

Applied as 6.8 material, thanks!

