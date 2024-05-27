Return-Path: <linux-acpi+bounces-6010-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E418D0960
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 19:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3328E1F213F5
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 17:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FA815E5A0;
	Mon, 27 May 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZz6eWFX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171E817E8FB;
	Mon, 27 May 2024 17:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716830991; cv=none; b=jz8Ys2CYLf0edFfjLLSlCibnpnT9Jouk59B88wPWgn8skc69/aYP85x5ziGDqnLjFXYz5ApM/3gnmgA06jKTZYbe+hfjBURBp/2R7AU6czbZRd2b5ZtsUzlZXcFINBoFZ22+mIMij57bNYdsupjglQ0za61LlxTlGEZsXmXdPss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716830991; c=relaxed/simple;
	bh=PUrrLCRvcPbKZwNqh9gBTonRjxko9pwKOrHTc7+D6s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJHIjw689hbIY3JhHe2ZlTVFNkVXdBgB4PCFAUmRStvhoYJcoNWavpkb0WKtq16591FsHJG+IMNPSphEmrqW0ByAt05Pfz5LGhtMkfHihKPzk8g01MQWMnkn3M0nkuSI0aYZdro6sAlljf6YcPctPIr+Xro02smrEADtxin0aBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZz6eWFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5863C4AF0C;
	Mon, 27 May 2024 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716830990;
	bh=PUrrLCRvcPbKZwNqh9gBTonRjxko9pwKOrHTc7+D6s0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kZz6eWFXf7mo2Ksr34+InE/IUTpt1DDIbyL4cJnOKPSAgREimm5XodDazzhUVv9Ig
	 b4cqyRnokISbwhm06HUPGVhPty8+9KNqeRNfqi8fUz+cEQgm79yMRbSqq9FJOZRi9k
	 x+yHio+SxzOaoP6zJs6Ww3Z0XmrLmLivhEJO1yXIL6zq6fw+wTRAJQ+lqT/wbNNefM
	 P8zU7BEHcgggSQXdfCZC4GYxfhAlc9F7V5OfruZYmshyFjcYLOnwM0eGbjPlQfVi+m
	 xkcM3wkslBWGdUmQtMP07RnojdDHC4irFPaFdJerBBJnnkAqMtbNNkpBfT1Y1mHoi2
	 wTSLcMzyiwiNg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5b3356fd4f3so26540eaf.1;
        Mon, 27 May 2024 10:29:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXbF0QXcgGcatj/sA7fKCBX2oryhTeK0AW214KzqeUl4GXKNIAqGrNe7bXtcoK0XlGzQSAsgppXhR7YD+2uaVTZJhsteoSLptKz9suUqJc9zFZ3afb9QGVKQVGWxfNdXcSO4faHWASDHi5Z07ymGfQt7+j5nQxi15IsLOtEK9aW4z30ndMFL3g5GfOpVQRuNZtPr+4QklAnSux3XdTzt/graw97JMcxGGgs9g==
X-Gm-Message-State: AOJu0Yw5otR4RrmBNIZ5S8E/e9kA7DjXc4qsOpx/827IXwLSAFWei6jh
	pbbg++j4D3mB+sYE9WL6rwYSxtfnDK89erOj+MeKIYpSzE8QSolvTNAewRFTogWqOUiEEocKpqW
	qs74xAKrc1HPDbQuw4k0ueKQYu7Y=
X-Google-Smtp-Source: AGHT+IFsY+3JtQrOnWj2tIFFkxehQLX2havvuRTjFeGeqMraJJgIiHtRLUC5ebpqsf24htFkMIgKTy2AVwB/5CbZsxI=
X-Received: by 2002:a05:6870:d20a:b0:24f:e599:9168 with SMTP id
 586e51a60fabf-24fe5999dd0mr5367474fac.1.1716830989877; Mon, 27 May 2024
 10:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201242.3886-1-W_Armin@gmx.de>
In-Reply-To: <20240510201242.3886-1-W_Armin@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 May 2024 19:29:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gu=yvFeXH4uwHeAQZ8p1JyCs8uuiKzr6F+yNkD2E1ZAA@mail.gmail.com>
Message-ID: <CAJZ5v0gu=yvFeXH4uwHeAQZ8p1JyCs8uuiKzr6F+yNkD2E1ZAA@mail.gmail.com>
Subject: Re: [PATCH v8] ACPI: fan: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	jdelvare@suse.com, andy.shevchenko@gmail.com, linux@roeck-us.net, 
	linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 10:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Currently, the driver does only support a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
>
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> Tested witha custom ACPI SSDT, available here:
> https://github.com/Wer-Wolf/acpi-fan-ssdt
>
> Changes since v7:
> - add Reviewed-by tag
> - spelling fixes
> - add missing types.h include
>
> Changes since v6:
> - add "hwmon" to the names of functions and variables
> related to hwmon
> - replace -ENODATA with -EIO/-ENODEV
>
> Changes since v5:
> - fix coding style issues
> - replace double break with return
> - add missing includes
>
> Changes since v4:
> - fix spelling issues
> - check power values for overflow condition too
>
> Changes since v3:
> - drop fault attrs
> - rework initialization
>
> Changes since v2:
> - add support for fanX_target and power attrs
>
> Changes since v1:
> - fix undefined reference error
> - fix fan speed validation
> - coding style fixes
> - clarify that the changes are compile-tested only
> - add hwmon maintainers to cc list
> ---
>  drivers/acpi/Makefile    |   1 +
>  drivers/acpi/fan.h       |   9 +++
>  drivers/acpi/fan_core.c  |   4 +
>  drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 184 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 39ea5cfa8326..61ca4afe83dc 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  +=3D tiny-power-b=
utton.o
>  obj-$(CONFIG_ACPI_FAN)         +=3D fan.o
>  fan-objs                       :=3D fan_core.o
>  fan-objs                       +=3D fan_attr.o
> +fan-$(CONFIG_HWMON)            +=3D fan_hwmon.o
>
>  obj-$(CONFIG_ACPI_VIDEO)       +=3D video.o
>  obj-$(CONFIG_ACPI_TAD)         +=3D acpi_tad.o
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index f89d19c922dc..db25a3898af7 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -10,6 +10,8 @@
>  #ifndef _ACPI_FAN_H_
>  #define _ACPI_FAN_H_
>
> +#include <linux/kconfig.h>
> +
>  #define ACPI_FAN_DEVICE_IDS    \
>         {"INT3404", }, /* Fan */ \
>         {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> @@ -57,4 +59,11 @@ struct acpi_fan {
>  int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst *fs=
t);
>  int acpi_fan_create_attributes(struct acpi_device *device);
>  void acpi_fan_delete_attributes(struct acpi_device *device);
> +
> +#if IS_REACHABLE(CONFIG_HWMON)
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> +#else
> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *device)=
 { return 0; };
> +#endif
> +
>  #endif
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index ff72e4ef8738..7cea4495f19b 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>                 if (result)
>                         return result;
>
> +               result =3D devm_acpi_fan_create_hwmon(device);
> +               if (result)
> +                       return result;
> +
>                 result =3D acpi_fan_create_attributes(device);
>                 if (result)
>                         return result;
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> new file mode 100644
> index 000000000000..bd0d31a398fa
> --- /dev/null
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hwmon interface for the ACPI Fan driver.
> + *
> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/hwmon.h>
> +#include <linux/limits.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include "fan.h"
> +
> +/* Returned when the ACPI fan does not support speed reporting */
> +#define FAN_SPEED_UNAVAILABLE  U32_MAX
> +#define FAN_POWER_UNAVAILABLE  U32_MAX
> +
> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan *fa=
n, u64 control)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < fan->fps_count; i++) {
> +               if (fan->fps[i].control =3D=3D control)
> +                       return &fan->fps[i];
> +       }
> +
> +       return NULL;
> +}
> +
> +static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hwmon=
_sensor_types type,
> +                                        u32 attr, int channel)
> +{
> +       const struct acpi_fan *fan =3D drvdata;
> +       unsigned int i;

AFAICS, the code below can be rewritten as follows:

if (fan->fif.fine_grain_ctrl)
         return 0;

switch (type) {
case hwmon_fan:
        if (attr =3D=3D hwmon_fan_input || attr =3D=3D hwmon_fan_target)
               return 0444;

        return 0;

case hwmon_power:
        if (attr =3D=3D hwmon_power_input) {
               for (i =3D 0; i < fan->fps_count; i++) {
                       if (fan->fps[i].power !=3D FAN_POWER_UNAVAILABLE)
                               return 0444;
               }
        }

        fallthrough;
default:
       return 0;
}

without changing functionality, which is both less duplication and
fewer lines of code.

> +
> +       switch (type) {
> +       case hwmon_fan:
> +               switch (attr) {
> +               case hwmon_fan_input:
> +                       return 0444;
> +               case hwmon_fan_target:
> +                       /*
> +                        * When in fine grain control mode, not every fan=
 control value
> +                        * has an associated fan performance state.
> +                        */
> +                       if (fan->fif.fine_grain_ctrl)
> +                               return 0;
> +
> +                       return 0444;
> +               default:
> +                       return 0;
> +               }
> +       case hwmon_power:
> +               switch (attr) {
> +               case hwmon_power_input:
> +                       /*
> +                        * When in fine grain control mode, not every fan=
 control value
> +                        * has an associated fan performance state.
> +                        */
> +                       if (fan->fif.fine_grain_ctrl)
> +                               return 0;
> +
> +                       /*
> +                        * When all fan performance states contain no val=
id power data,
> +                        * when the associated attribute should not be cr=
eated.
> +                        */
> +                       for (i =3D 0; i < fan->fps_count; i++) {
> +                               if (fan->fps[i].power !=3D FAN_POWER_UNAV=
AILABLE)
> +                                       return 0444;
> +                       }
> +
> +                       return 0;
> +               default:
> +                       return 0;
> +               }
> +       default:
> +               return 0;
> +       }
> +}
> +
> +static int acpi_fan_hwmon_read(struct device *dev, enum hwmon_sensor_typ=
es type, u32 attr,
> +                              int channel, long *val)
> +{
> +       struct acpi_device *adev =3D to_acpi_device(dev->parent);
> +       struct acpi_fan *fan =3D dev_get_drvdata(dev);
> +       struct acpi_fan_fps *fps;
> +       struct acpi_fan_fst fst;
> +       int ret;
> +
> +       ret =3D acpi_fan_get_fst(adev, &fst);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (type) {
> +       case hwmon_fan:
> +               switch (attr) {
> +               case hwmon_fan_input:
> +                       if (fst.speed =3D=3D FAN_SPEED_UNAVAILABLE)
> +                               return -ENODEV;
> +
> +                       if (fst.speed > LONG_MAX)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fst.speed;
> +                       return 0;
> +               case hwmon_fan_target:
> +                       fps =3D acpi_fan_get_current_fps(fan, fst.control=
);
> +                       if (!fps)
> +                               return -EIO;
> +
> +                       if (fps->speed > LONG_MAX)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fps->speed;
> +                       return 0;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       case hwmon_power:
> +               switch (attr) {
> +               case hwmon_power_input:
> +                       fps =3D acpi_fan_get_current_fps(fan, fst.control=
);
> +                       if (!fps)
> +                               return -EIO;
> +
> +                       if (fps->power =3D=3D FAN_POWER_UNAVAILABLE)
> +                               return -ENODEV;
> +
> +                       if (fps->power > LONG_MAX / MICROWATT_PER_MILLIWA=
TT)
> +                               return -EOVERFLOW;
> +
> +                       *val =3D fps->power * MICROWATT_PER_MILLIWATT;
> +                       return 0;
> +               default:
> +                       return -EOPNOTSUPP;
> +               }
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +}
> +
> +static const struct hwmon_ops acpi_fan_hwmon_ops =3D {
> +       .is_visible =3D acpi_fan_hwmon_is_visible,
> +       .read =3D acpi_fan_hwmon_read,
> +};
> +
> +static const struct hwmon_channel_info * const acpi_fan_hwmon_info[] =3D=
 {
> +       HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_TARGET),
> +       HWMON_CHANNEL_INFO(power, HWMON_P_INPUT),
> +       NULL
> +};
> +
> +static const struct hwmon_chip_info acpi_fan_hwmon_chip_info =3D {
> +       .ops =3D &acpi_fan_hwmon_ops,
> +       .info =3D acpi_fan_hwmon_info,
> +};
> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +       struct acpi_fan *fan =3D acpi_driver_data(device);
> +       struct device *hdev;
> +
> +       hdev =3D devm_hwmon_device_register_with_info(&device->dev, "acpi=
_fan", fan,
> +                                                   &acpi_fan_hwmon_chip_=
info, NULL);
> +       return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
>
>

