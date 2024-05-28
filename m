Return-Path: <linux-acpi+bounces-6067-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 335088D2542
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 21:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E63FFB2781C
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 19:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A51176FAE;
	Tue, 28 May 2024 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtvtadSa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DC723BF;
	Tue, 28 May 2024 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716925971; cv=none; b=HehpqcypmkKEHdFEzdGSeyzZCv3dbtvRfieI/s/MfmD///iPr7QdS0o+iAOoCbOf/iBZbW+5feIlwb0MQbb6P8PHP+FZ9yKegroT/ifRfwVAATCAUWr9QaSRem9v28RIjiYYiMF2oQFGAJub4u2ciHMKbKj9TtF9GfMAZNIvtlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716925971; c=relaxed/simple;
	bh=2rE+lKrC2cS6x32lg8GfCW7VB+hGia9MQvA1fyHT52w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6BdV2p0ROO2ZUjLPvO0MUF/Ty9V/Y/TI8u3G9za2hFAL2SMy64toe5wZUJv1g7MsfAw1Do1ec2p0t8hedZ+Ae48xcDT3chiAl+HEF8azOkdx0MpxRom9aypuYINPddPc8vwamWMmUn39Yw5G+ziZVJF2bpADPI22R2jKneIq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtvtadSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B2C4AF0D;
	Tue, 28 May 2024 19:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716925970;
	bh=2rE+lKrC2cS6x32lg8GfCW7VB+hGia9MQvA1fyHT52w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jtvtadSah/DUsRjW2L+ZN28387g6sHS7xxWab/j4+NLdrh21yV3GIb/lgxxx05cg+
	 Cil9YBBxY7ZYoeIvJWp1jYldhnHuEaVRNGaQ3R41LOQYxnZgM0DZHS3dbTXacbtpeR
	 1L2feMz6wRSACAtNAI9xcbfFa0gxyzXtzfNeETXJt+sMvTMcQLC/4LN5jK/nvzU+0z
	 lIOnSHL8QdIPGstQmpZziQthUg668FLbGnpJaTKXBiOlTfoaCXMtD1iB0fdSIoXaSr
	 wVv6LLEnn8BWhdGbtErOctWI9zdl1KjE49egcymHxRvWmY0L8n5aHS7ZVRbeuWhJv1
	 61saiWnXriDWw==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5b96a587d79so77960eaf.0;
        Tue, 28 May 2024 12:52:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA6CAEvXDrcdawbCsqrJoWSMKmquzx40kPFAaJZTgMh3StQqicXrXEXCHSH8vd2VMg9YX59DIUxknUoi9mckNGo1/s0sBY7UTixfEundJpGt2SWc1ONWMsjWqleZrUPNxgWGVcskA3fC/2Cp4W2DF7DdDLaRZqw3CcNmJMGyEe2Qy0g5K7YJxeqV//2X1XreCT11HODO43+NFb9+EZs/Kn69dSVG36cDODpw==
X-Gm-Message-State: AOJu0Ywfz2QqaJ2lm9inp7clhaHMV2QvJPaYoG4ZDWh+mL68E5halkGi
	hek5Tb6p5JbWFD/zBeAAhk0xOPIm0jclg+r8BI2gKCuhm2+3/knFMQMI9rTO/pfarXx81Z4SrN+
	cHv9YI2OyrRZfdXx0FSMd0/CKDEc=
X-Google-Smtp-Source: AGHT+IGnYKb/NKYpWDWiLrDI+pojlbT5VGeR3HVdpe1f5QZ5p+LPLue1yFCYgOwjFvGILYE5/bLzY9T3vt5p752HIcI=
X-Received: by 2002:a4a:4b06:0:b0:5b2:f29:93f0 with SMTP id
 006d021491bc7-5b95cceba96mr14248384eaf.0.1716925969529; Tue, 28 May 2024
 12:52:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510201242.3886-1-W_Armin@gmx.de> <CAJZ5v0gu=yvFeXH4uwHeAQZ8p1JyCs8uuiKzr6F+yNkD2E1ZAA@mail.gmail.com>
 <92415bd8-4231-4c68-8034-e4f7a0ea5651@gmx.de>
In-Reply-To: <92415bd8-4231-4c68-8034-e4f7a0ea5651@gmx.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 28 May 2024 21:52:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iLNZT4jU1QV=HTbAv76s6Ay3tx93_K_QoM0XbvSgZF1w@mail.gmail.com>
Message-ID: <CAJZ5v0iLNZT4jU1QV=HTbAv76s6Ay3tx93_K_QoM0XbvSgZF1w@mail.gmail.com>
Subject: Re: [PATCH v8] ACPI: fan: Add hwmon support
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, mlj@danelec.com, rafael.j.wysocki@intel.com, 
	lenb@kernel.org, jdelvare@suse.com, andy.shevchenko@gmail.com, 
	linux@roeck-us.net, linux@weissschuh.net, ilpo.jarvinen@linux.intel.com, 
	linux-acpi@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 12:31=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 27.05.24 um 19:29 schrieb Rafael J. Wysocki:
>
> > On Fri, May 10, 2024 at 10:13=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
> >> Currently, the driver does only support a custom sysfs
> >> interface to allow userspace to read the fan speed.
> >> Add support for the standard hwmon interface so users
> >> can read the fan speed with standard tools like "sensors".
> >>
> >> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> >> ---
> >> Tested witha custom ACPI SSDT, available here:
> >> https://github.com/Wer-Wolf/acpi-fan-ssdt
> >>
> >> Changes since v7:
> >> - add Reviewed-by tag
> >> - spelling fixes
> >> - add missing types.h include
> >>
> >> Changes since v6:
> >> - add "hwmon" to the names of functions and variables
> >> related to hwmon
> >> - replace -ENODATA with -EIO/-ENODEV
> >>
> >> Changes since v5:
> >> - fix coding style issues
> >> - replace double break with return
> >> - add missing includes
> >>
> >> Changes since v4:
> >> - fix spelling issues
> >> - check power values for overflow condition too
> >>
> >> Changes since v3:
> >> - drop fault attrs
> >> - rework initialization
> >>
> >> Changes since v2:
> >> - add support for fanX_target and power attrs
> >>
> >> Changes since v1:
> >> - fix undefined reference error
> >> - fix fan speed validation
> >> - coding style fixes
> >> - clarify that the changes are compile-tested only
> >> - add hwmon maintainers to cc list
> >> ---
> >>   drivers/acpi/Makefile    |   1 +
> >>   drivers/acpi/fan.h       |   9 +++
> >>   drivers/acpi/fan_core.c  |   4 +
> >>   drivers/acpi/fan_hwmon.c | 170 +++++++++++++++++++++++++++++++++++++=
++
> >>   4 files changed, 184 insertions(+)
> >>   create mode 100644 drivers/acpi/fan_hwmon.c
> >>
> >> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> >> index 39ea5cfa8326..61ca4afe83dc 100644
> >> --- a/drivers/acpi/Makefile
> >> +++ b/drivers/acpi/Makefile
> >> @@ -77,6 +77,7 @@ obj-$(CONFIG_ACPI_TINY_POWER_BUTTON)  +=3D tiny-powe=
r-button.o
> >>   obj-$(CONFIG_ACPI_FAN)         +=3D fan.o
> >>   fan-objs                       :=3D fan_core.o
> >>   fan-objs                       +=3D fan_attr.o
> >> +fan-$(CONFIG_HWMON)            +=3D fan_hwmon.o
> >>
> >>   obj-$(CONFIG_ACPI_VIDEO)       +=3D video.o
> >>   obj-$(CONFIG_ACPI_TAD)         +=3D acpi_tad.o
> >> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> >> index f89d19c922dc..db25a3898af7 100644
> >> --- a/drivers/acpi/fan.h
> >> +++ b/drivers/acpi/fan.h
> >> @@ -10,6 +10,8 @@
> >>   #ifndef _ACPI_FAN_H_
> >>   #define _ACPI_FAN_H_
> >>
> >> +#include <linux/kconfig.h>
> >> +
> >>   #define ACPI_FAN_DEVICE_IDS    \
> >>          {"INT3404", }, /* Fan */ \
> >>          {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> >> @@ -57,4 +59,11 @@ struct acpi_fan {
> >>   int acpi_fan_get_fst(struct acpi_device *device, struct acpi_fan_fst=
 *fst);
> >>   int acpi_fan_create_attributes(struct acpi_device *device);
> >>   void acpi_fan_delete_attributes(struct acpi_device *device);
> >> +
> >> +#if IS_REACHABLE(CONFIG_HWMON)
> >> +int devm_acpi_fan_create_hwmon(struct acpi_device *device);
> >> +#else
> >> +static inline int devm_acpi_fan_create_hwmon(struct acpi_device *devi=
ce) { return 0; };
> >> +#endif
> >> +
> >>   #endif
> >> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> >> index ff72e4ef8738..7cea4495f19b 100644
> >> --- a/drivers/acpi/fan_core.c
> >> +++ b/drivers/acpi/fan_core.c
> >> @@ -336,6 +336,10 @@ static int acpi_fan_probe(struct platform_device =
*pdev)
> >>                  if (result)
> >>                          return result;
> >>
> >> +               result =3D devm_acpi_fan_create_hwmon(device);
> >> +               if (result)
> >> +                       return result;
> >> +
> >>                  result =3D acpi_fan_create_attributes(device);
> >>                  if (result)
> >>                          return result;
> >> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> >> new file mode 100644
> >> index 000000000000..bd0d31a398fa
> >> --- /dev/null
> >> +++ b/drivers/acpi/fan_hwmon.c
> >> @@ -0,0 +1,170 @@
> >> +// SPDX-License-Identifier: GPL-2.0-or-later
> >> +/*
> >> + * hwmon interface for the ACPI Fan driver.
> >> + *
> >> + * Copyright (C) 2024 Armin Wolf <W_Armin@gmx.de>
> >> + */
> >> +
> >> +#include <linux/acpi.h>
> >> +#include <linux/device.h>
> >> +#include <linux/err.h>
> >> +#include <linux/hwmon.h>
> >> +#include <linux/limits.h>
> >> +#include <linux/types.h>
> >> +#include <linux/units.h>
> >> +
> >> +#include "fan.h"
> >> +
> >> +/* Returned when the ACPI fan does not support speed reporting */
> >> +#define FAN_SPEED_UNAVAILABLE  U32_MAX
> >> +#define FAN_POWER_UNAVAILABLE  U32_MAX
> >> +
> >> +static struct acpi_fan_fps *acpi_fan_get_current_fps(struct acpi_fan =
*fan, u64 control)
> >> +{
> >> +       unsigned int i;
> >> +
> >> +       for (i =3D 0; i < fan->fps_count; i++) {
> >> +               if (fan->fps[i].control =3D=3D control)
> >> +                       return &fan->fps[i];
> >> +       }
> >> +
> >> +       return NULL;
> >> +}
> >> +
> >> +static umode_t acpi_fan_hwmon_is_visible(const void *drvdata, enum hw=
mon_sensor_types type,
> >> +                                        u32 attr, int channel)
> >> +{
> >> +       const struct acpi_fan *fan =3D drvdata;
> >> +       unsigned int i;
> > AFAICS, the code below can be rewritten as follows:
> >
> > if (fan->fif.fine_grain_ctrl)
> >           return 0;
>
> Hi,
>
> this would break hwmon_fan_input.

Ah, I overlooked the first branch.  Fair enough.

Applied as 6.11 material, thanks!

