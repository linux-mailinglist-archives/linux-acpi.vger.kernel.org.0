Return-Path: <linux-acpi+bounces-18116-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B116BFDEC3
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 20:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8734D4E754C
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Oct 2025 18:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3534FF62;
	Wed, 22 Oct 2025 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uP8/rY+I"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62034FF4D
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158779; cv=none; b=bn5sZsWK2uR54dTV2ARHgVW7vRPOF9G1dWBkrm3qa/mW4WfuaS2Zy6E9ohN8kgd78KksHrmJIXyTkFB7DnYIGSOqI1c089kDK3ZnuWzcQe03BVAm2dF6G9creACANA82FArnMTxcyRWRUspvbJ46eVHW76A53yXYzdC385VJL2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158779; c=relaxed/simple;
	bh=CRfotCoe9SQHv1OTWomqUA/H7RP+2gFgJgYZ+czZZb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mpVrxKf42y2+ad1cDeYQGU6W/34no2J6uxh9bLgeaeET9gdSUwhK8MCU63FI1oeb/lvUtIHn6DgxhfXzu8btRokgsmFUkzjlD6UbNyOGu0Cg0+7cyaK/Khjn6BsKBMa+gMPHxke+LPFsBKBfOuHtSVRPeo3vqKwy+24KXaoE38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uP8/rY+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4AFC4CEF7
	for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761158778;
	bh=CRfotCoe9SQHv1OTWomqUA/H7RP+2gFgJgYZ+czZZb4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uP8/rY+IcoT+nErXGNLyRG1KKIwvegWXdNgcgeITeuk/Lgjf0juBcQX6ZHsontW7d
	 UhFWZl5ZzZL4/5UhNY/CRmLR6oyJMF12Hfjtprq9KWU1VQnQ2IQDQ4+RDqF1veMRFo
	 KjYMM8jdFnSdlIcfMlaa+9YDTcS4klIZFBjacLZyG7i0bGn6gYuq61bSGsGqpjyKUN
	 XoXanA5WV7aIrgkG10JZKf6UbOJjIcSw1LdlKb1Xl9FsKr/dq3QzpCLfA55RruvB4G
	 GpEjidfk7u5WbjzTHxcDhPjvNMyxKD4rfoQKbxR6PatcGkEXp5OoPW76u7wzY73+cZ
	 iox/cCg1nNGBA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-638135d9f65so450807eaf.0
        for <linux-acpi@vger.kernel.org>; Wed, 22 Oct 2025 11:46:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAyMh37AGE6487ZjkC17YYS4m7K01LL+ITBwCCD+uiOkhCfOu7ki0aWlVVKkCSR7KM+K3P/1zUIDpw@vger.kernel.org
X-Gm-Message-State: AOJu0YzPYjUmPX0hT73QHQKbz/bhctzd6uJsUUrPepQmYH84WfhjESSR
	9iehq+BXXQs4SchRLCzeTWkZ3Av1BF3egRJ7s7srCxbdebXCiMEYQBOYmnuZqI3B4EkpYQTfFLJ
	xk3lpTpqJnMWld0K95USTtmHsVAf6TDk=
X-Google-Smtp-Source: AGHT+IF0Go3QZaY0sR7Uk0LlJ2916uwfYqqfe08bbNZiqAW3ZIsbhLDPDgT5JfxOs8NV3Tzc2+SzVQNws7PoG4UOIHc=
X-Received: by 2002:a05:6870:c985:b0:3c1:d7af:de66 with SMTP id
 586e51a60fabf-3cdb084746dmr959589fac.7.1761158777900; Wed, 22 Oct 2025
 11:46:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002113404.3117429-1-srosek@google.com> <20251002113404.3117429-3-srosek@google.com>
In-Reply-To: <20251002113404.3117429-3-srosek@google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 22 Oct 2025 20:46:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
X-Gm-Features: AS18NWDpbczN0ssars57S7xFDLVK0_R40wGVzPrhxdZ80ZVrBubL70Dv_3WqrJI
Message-ID: <CAJZ5v0iQToOkedruYqsowSm8=fxpnyJf86JJHB36E8+aCSZ5Hw@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] ACPI: DPTF: Move INT340X device IDs to header
To: Slawomir Rosek <srosek@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Alex Hung <alexhung@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, 
	AceLan Kao <acelan.kao@canonical.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Tomasz Nowicki <tnowicki@google.com>, 
	Stanislaw Kardach <skardach@google.com>, Michal Krawczyk <mikrawczyk@google.com>, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 1:34=E2=80=AFPM Slawomir Rosek <srosek@google.com> w=
rote:
>
> The ACPI INT340X device IDs are shared between the DPTF core
> and thermal drivers, thus they are moved to the common header.
>
> Signed-off-by: Slawomir Rosek <srosek@google.com>

I've actually started to wonder if int340x_thermal_handler is needed at all=
.

It just creates a platform device if the given ACPI device ID is in
its list, but acpi_default_enumeration() would do that too with the
caveat that it would also be done for CONFIG_INT340X_THERMAL unset.
That should not be a problem though because if CONFIG_INT340X_THERMAL,
there are no drivers that will bind to those platform devices, so the
net outcome should be the same.

Thus I'm wondering if the way to go might be to drop
int340x_thermal_handler and simply keep the device IDs in the drivers
that use them for device binding.

> ---
>  drivers/acpi/dptf/dptf_power.c                | 18 +----
>  drivers/acpi/dptf/int340x_thermal.c           | 51 +++-----------
>  drivers/acpi/fan.h                            | 10 +--
>  drivers/acpi/int340x_thermal.h                | 68 +++++++++++++++++++
>  .../intel/int340x_thermal/int3400_thermal.c   | 10 +--
>  .../intel/int340x_thermal/int3401_thermal.c   |  3 +-
>  .../intel/int340x_thermal/int3402_thermal.c   |  3 +-
>  .../intel/int340x_thermal/int3403_thermal.c   | 10 +--
>  .../intel/int340x_thermal/int3406_thermal.c   |  3 +-
>  9 files changed, 90 insertions(+), 86 deletions(-)
>  create mode 100644 drivers/acpi/int340x_thermal.h
>
> diff --git a/drivers/acpi/dptf/dptf_power.c b/drivers/acpi/dptf/dptf_powe=
r.c
> index 776914f31b9e..d7c59f016083 100644
> --- a/drivers/acpi/dptf/dptf_power.c
> +++ b/drivers/acpi/dptf/dptf_power.c
> @@ -8,6 +8,7 @@
>  #include <linux/module.h>
>  #include <linux/acpi.h>
>  #include <linux/platform_device.h>
> +#include "../int340x_thermal.h"
>
>  /*
>   * Presentation of attributes which are defined for INT3407 and INT3532.
> @@ -224,22 +225,7 @@ static void dptf_power_remove(struct platform_device=
 *pdev)
>  }
>
>  static const struct acpi_device_id int3407_device_ids[] =3D {
> -       {"INT3407", 0},
> -       {"INT3532", 0},
> -       {"INTC1047", 0},
> -       {"INTC1050", 0},
> -       {"INTC1060", 0},
> -       {"INTC1061", 0},
> -       {"INTC1065", 0},
> -       {"INTC1066", 0},
> -       {"INTC106C", 0},
> -       {"INTC106D", 0},
> -       {"INTC10A4", 0},
> -       {"INTC10A5", 0},
> -       {"INTC10D8", 0},
> -       {"INTC10D9", 0},
> -       {"INTC1100", 0},
> -       {"INTC1101", 0},
> +       ACPI_INT3407_DEVICE_IDS,
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3407_device_ids);
> diff --git a/drivers/acpi/dptf/int340x_thermal.c b/drivers/acpi/dptf/int3=
40x_thermal.c
> index 947fe50c2ef6..43afb6141b98 100644
> --- a/drivers/acpi/dptf/int340x_thermal.c
> +++ b/drivers/acpi/dptf/int340x_thermal.c
> @@ -9,63 +9,28 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>
> +#include "../int340x_thermal.h"
>  #include "../internal.h"
>
>  static const struct acpi_device_id int340x_thermal_device_ids[] =3D {
> -       {"INT3400"},
> -       {"INT3401"},
> -       {"INT3402"},
> -       {"INT3403"},
> -       {"INT3404"},
> -       {"INT3406"},
> -       {"INT3407"},
> +       ACPI_INT3400_DEVICE_IDS,
> +       ACPI_INT3401_DEVICE_IDS,
> +       ACPI_INT3402_DEVICE_IDS,
> +       ACPI_INT3403_DEVICE_IDS,
> +       ACPI_INT3404_DEVICE_IDS,
> +       ACPI_INT3406_DEVICE_IDS,
> +       ACPI_INT3407_DEVICE_IDS,
>         {"INT3408"},
>         {"INT3409"},
>         {"INT340A"},
>         {"INT340B"},
> -       {"INT3532"},
> -       {"INTC1040"},
> -       {"INTC1041"},
> -       {"INTC1042"},
> -       {"INTC1043"},
> -       {"INTC1044"},
>         {"INTC1045"},
> -       {"INTC1046"},
> -       {"INTC1047"},
> -       {"INTC1048"},
>         {"INTC1049"},
> -       {"INTC1050"},
> -       {"INTC1060"},
> -       {"INTC1061"},
> -       {"INTC1062"},
> -       {"INTC1063"},
>         {"INTC1064"},
> -       {"INTC1065"},
> -       {"INTC1066"},
> -       {"INTC1068"},
> -       {"INTC1069"},
> -       {"INTC106A"},
>         {"INTC106B"},
> -       {"INTC106C"},
> -       {"INTC106D"},
> -       {"INTC10A0"},
> -       {"INTC10A1"},
> -       {"INTC10A2"},
>         {"INTC10A3"},
> -       {"INTC10A4"},
> -       {"INTC10A5"},
> -       {"INTC10D4"},
> -       {"INTC10D5"},
> -       {"INTC10D6"},
>         {"INTC10D7"},
> -       {"INTC10D8"},
> -       {"INTC10D9"},
> -       {"INTC10FC"},
> -       {"INTC10FD"},
> -       {"INTC10FE"},
>         {"INTC10FF"},
> -       {"INTC1100"},
> -       {"INTC1101"},
>         {"INTC1102"},
>         {""},
>  };
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index 8a28a72a7c6a..4015ac56c009 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -11,16 +11,10 @@
>  #define _ACPI_FAN_H_
>
>  #include <linux/kconfig.h>
> +#include "int340x_thermal.h"
>
>  #define ACPI_FAN_DEVICE_IDS    \
> -       {"INT3404", }, /* Fan */ \
> -       {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> -       {"INTC1048", }, /* Fan for Alder Lake generation */ \
> -       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> -       {"INTC106A", }, /* Fan for Lunar Lake generation */ \
> -       {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
> -       {"INTC10D6", }, /* Fan for Panther Lake generation */ \
> -       {"INTC10FE", }, /* Fan for Wildcat Lake generation */ \
> +       ACPI_INT3404_DEVICE_IDS, \
>         {"PNP0C0B", } /* Generic ACPI fan */
>
>  #define ACPI_FPS_NAME_LEN      20
> diff --git a/drivers/acpi/int340x_thermal.h b/drivers/acpi/int340x_therma=
l.h
> new file mode 100644
> index 000000000000..854e4d3bb739
> --- /dev/null
> +++ b/drivers/acpi/int340x_thermal.h
> @@ -0,0 +1,68 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +/*
> + * The ACPI INT340X device IDs are shared between the DPTF core
> + * and thermal drivers.
> + */
> +
> +#ifndef _ACPI_INT340X_H_
> +#define _ACPI_INT340X_H_
> +
> +#define ACPI_INT3400_DEVICE_IDS        \
> +       {"INT3400"},    \
> +       {"INTC1040"},   \
> +       {"INTC1041"},   \
> +       {"INTC1042"},   \
> +       {"INTC1068"},   \
> +       {"INTC10A0"},   \
> +       {"INTC10D4"},   \
> +       {"INTC10FC"}
> +
> +#define ACPI_INT3401_DEVICE_IDS        \
> +       {"INT3401"}
> +
> +#define ACPI_INT3402_DEVICE_IDS        \
> +       {"INT3402"}
> +
> +#define ACPI_INT3403_DEVICE_IDS        \
> +       {"INT3403"},    \
> +       {"INTC1043"},   \
> +       {"INTC1046"},   \
> +       {"INTC1062"},   \
> +       {"INTC1069"},   \
> +       {"INTC10A1"},   \
> +       {"INTC10D5"},   \
> +       {"INTC10FD"}
> +
> +#define ACPI_INT3404_DEVICE_IDS        \
> +       {"INT3404", }, /* Fan */ \
> +       {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> +       {"INTC1048", }, /* Fan for Alder Lake generation */ \
> +       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> +       {"INTC106A", }, /* Fan for Lunar Lake generation */ \
> +       {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
> +       {"INTC10D6", }, /* Fan for Panther Lake generation */ \
> +       {"INTC10FE", } /* Fan for Wildcat Lake generation */
> +
> +#define ACPI_INT3406_DEVICE_IDS        \
> +       {"INT3406"}
> +
> +#define ACPI_INT3407_DEVICE_IDS        \
> +       {"INT3407"},    \
> +       {"INT3532"},    \
> +       {"INTC1047"},   \
> +       {"INTC1050"},   \
> +       {"INTC1060"},   \
> +       {"INTC1061"},   \
> +       {"INTC1065"},   \
> +       {"INTC1066"},   \
> +       {"INTC106C"},   \
> +       {"INTC106D"},   \
> +       {"INTC10A4"},   \
> +       {"INTC10A5"},   \
> +       {"INTC10D8"},   \
> +       {"INTC10D9"},   \
> +       {"INTC1100"},   \
> +       {"INTC1101"}
> +
> +#endif
> diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3400_thermal.c
> index 908cc1bf57f1..6311125c3ebd 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi.h>
>  #include <linux/thermal.h>
>  #include "acpi_thermal_rel.h"
> +#include "../../../../drivers/acpi/int340x_thermal.h"
>
>  #define INT3400_THERMAL_TABLE_CHANGED 0x83
>  #define INT3400_ODVP_CHANGED 0x88
> @@ -683,14 +684,7 @@ static void int3400_thermal_remove(struct platform_d=
evice *pdev)
>  }
>
>  static const struct acpi_device_id int3400_thermal_match[] =3D {
> -       {"INT3400", 0},
> -       {"INTC1040", 0},
> -       {"INTC1041", 0},
> -       {"INTC1042", 0},
> -       {"INTC1068", 0},
> -       {"INTC10A0", 0},
> -       {"INTC10D4", 0},
> -       {"INTC10FC", 0},
> +       ACPI_INT3400_DEVICE_IDS,
>         {}
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3401_thermal.c
> index 96d6277a5a8c..e0603f218d2e 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3401_thermal.c
> @@ -11,9 +11,10 @@
>
>  #include "int340x_thermal_zone.h"
>  #include "processor_thermal_device.h"
> +#include "../../../../drivers/acpi/int340x_thermal.h"
>
>  static const struct acpi_device_id int3401_device_ids[] =3D {
> -       {"INT3401", 0},
> +       ACPI_INT3401_DEVICE_IDS,
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3401_device_ids);
> diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3402_thermal.c
> index 57b90005888a..213d4535f2c1 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
> @@ -11,6 +11,7 @@
>  #include <linux/acpi.h>
>  #include <linux/thermal.h>
>  #include "int340x_thermal_zone.h"
> +#include "../../../../drivers/acpi/int340x_thermal.h"
>
>  #define INT3402_PERF_CHANGED_EVENT     0x80
>  #define INT3402_THERMAL_EVENT          0x90
> @@ -84,7 +85,7 @@ static void int3402_thermal_remove(struct platform_devi=
ce *pdev)
>  }
>
>  static const struct acpi_device_id int3402_thermal_match[] =3D {
> -       {"INT3402", 0},
> +       ACPI_INT3402_DEVICE_IDS,
>         {}
>  };
>
> diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3403_thermal.c
> index ba63796761eb..d246c69d4872 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> @@ -12,6 +12,7 @@
>  #include <linux/thermal.h>
>  #include <linux/platform_device.h>
>  #include "int340x_thermal_zone.h"
> +#include "../../../../drivers/acpi/int340x_thermal.h"
>
>  #define INT3403_TYPE_SENSOR            0x03
>  #define INT3403_TYPE_CHARGER           0x0B
> @@ -269,14 +270,7 @@ static void int3403_remove(struct platform_device *p=
dev)
>  }
>
>  static const struct acpi_device_id int3403_device_ids[] =3D {
> -       {"INT3403", 0},
> -       {"INTC1043", 0},
> -       {"INTC1046", 0},
> -       {"INTC1062", 0},
> -       {"INTC1069", 0},
> -       {"INTC10A1", 0},
> -       {"INTC10D5", 0},
> -       {"INTC10FD", 0},
> +       ACPI_INT3403_DEVICE_IDS,
>         {"", 0},
>  };
>  MODULE_DEVICE_TABLE(acpi, int3403_device_ids);
> diff --git a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c b/dr=
ivers/thermal/intel/int340x_thermal/int3406_thermal.c
> index e21fcbccf4ba..d05ca8bc4061 100644
> --- a/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> +++ b/drivers/thermal/intel/int340x_thermal/int3406_thermal.c
> @@ -12,6 +12,7 @@
>  #include <linux/backlight.h>
>  #include <linux/thermal.h>
>  #include <acpi/video.h>
> +#include "../../../../drivers/acpi/int340x_thermal.h"
>
>  #define INT3406_BRIGHTNESS_LIMITS_CHANGED      0x80
>
> @@ -187,7 +188,7 @@ static void int3406_thermal_remove(struct platform_de=
vice *pdev)
>  }
>
>  static const struct acpi_device_id int3406_thermal_match[] =3D {
> -       {"INT3406", 0},
> +       ACPI_INT3406_DEVICE_IDS,
>         {}
>  };
>
> --
> 2.51.0.618.g983fd99d29-goog
>
>

