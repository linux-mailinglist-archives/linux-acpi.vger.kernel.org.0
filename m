Return-Path: <linux-acpi+bounces-2581-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A375E81B979
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 15:25:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435C61F21E44
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Dec 2023 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261976D6F2;
	Thu, 21 Dec 2023 14:25:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38C6D6D9
	for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbb09061c0so150429a34.0
        for <linux-acpi@vger.kernel.org>; Thu, 21 Dec 2023 06:25:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168713; x=1703773513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojQ73H35XiXrdk5BNPlpc9bz0dtavilJ7oCuNvkCpxk=;
        b=MqZwS2ND1ctcxLT32qpke03JBQXyRCYb5U7RfqF1iBkUmPEZqo5sB7tgcoP19oXnT1
         geDtsu5/PpraCtVmEBUuHTH7beAnFdCG7Q9ZlrROFOc+VGvY6DOqM1QJ/0zK+yFLhQgC
         CFOvUGDfnJMbjpUa6bHAnNSkx5PL9zpLN0pdLOAO4RCHGP7fuNl+c5LZfe9NHyjE+SUp
         lPzNdjzaCL0uTAzGZK8wJq56yqEEdD5/CMHyRu/ybnsaDCCCRAoUHjO/8C+4D+5jA1Q9
         82fbgsSX5XIjmJhpQKZMrjCCtVgBy9XRpYnOa4egphA6Y8AqxfKhy19x5YdViC+sgI7g
         wGSA==
X-Gm-Message-State: AOJu0Yxu8RXO8lcn9VoEE1obrZv/FO8f7q5pCBplp1NhsEYZmFU/pe81
	yyvg+KKwPQXcWAxHmHEhGrG4q9yMJlR4cxYyNO0iH5Dp
X-Google-Smtp-Source: AGHT+IFLwuOyMUafEaeRcZCKZIwIYPnIfuOg+4KwH9XoZBduQledVp+As9CE/E4nYRsa/3QXo8DjSMI2vFxLqOSFf9I=
X-Received: by 2002:a05:6820:2484:b0:591:4861:6b02 with SMTP id
 cq4-20020a056820248400b0059148616b02mr26217656oob.1.1703168713521; Thu, 21
 Dec 2023 06:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231007075433.555715-1-Ken.Xue@amd.com>
In-Reply-To: <20231007075433.555715-1-Ken.Xue@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 15:25:02 +0100
Message-ID: <CAJZ5v0ioghNbRXO=N1zVqksP6J=0ubfULLCoad_4A=Mz2F9UoA@mail.gmail.com>
Subject: Re: [PATCH V5] acpi: trigger wakeup key event from power button
To: Ken Xue <Ken.Xue@amd.com>
Cc: andriy.shevchenko@linux.intel.com, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, cwhuang@linux.org.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 7, 2023 at 9:55=E2=80=AFAM Ken Xue <Ken.Xue@amd.com> wrote:
>
> Andorid can wakeup from various wakeup sources, but only several wakeup
> sources can wake up screen with right events(POWER, WAKEUP) from input
> device.
>
> Regarding pressing acpi power button, it can resume system and
> ACPI_BITMASK_WAKE_STATUS and ACPI_BITMASK_POWER_BUTTON_STATUS are set in
> pm1a_sts, but kernel does not report any key event to user space during
> resuming by default.
>
> So, send wakeup key event to user space during resume from power button.
>
> Signed-off-by: Ken Xue <Ken.Xue@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ---
> V1->V2: fix some compile warning/error caused by lack of
>         "struct acpi_device" declaration by including acpi.h.
> V2->V3: use "forward declaration" to fix compile warning/error.
> V3->V4: refine coding style and commit message
> V4->V5: add "select ACPI_BUTTON" to fix build error if CONFIG_ACPI_BUTTON=
=3Dm. https://lore.kernel.org/oe-kbuild-all/202309150947.YLjvs2Vv-lkp@intel=
.com/
> ---
>  drivers/acpi/Kconfig  |  1 +
>  drivers/acpi/button.c | 17 +++++++++++++++++
>  drivers/acpi/sleep.c  |  5 +++++
>  include/acpi/button.h |  4 ++++
>  4 files changed, 27 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 00dd309b6682..001da6233fcd 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -53,6 +53,7 @@ config ACPI_GENERIC_GSI
>
>  config ACPI_SYSTEM_POWER_STATES_SUPPORT
>         bool
> +       select ACPI_BUTTON
>
>  config ACPI_CCA_REQUIRED
>         bool
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 1e76a64cce0a..3baddecd66c6 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -363,6 +363,22 @@ static int acpi_button_remove_fs(struct acpi_device =
*device)
>         return 0;
>  }
>
> +void acpi_power_button_wakeup(struct acpi_device *dev)
> +{
> +       struct acpi_button *button =3D acpi_driver_data(dev);
> +       struct input_dev *input;
> +
> +       if (button->type !=3D ACPI_BUTTON_TYPE_POWER)
> +               return;
> +
> +       input =3D button->input;
> +       input_report_key(input, KEY_WAKEUP, 1);
> +       input_sync(input);
> +       input_report_key(input, KEY_WAKEUP, 0);
> +       input_sync(input);
> +}
> +EXPORT_SYMBOL(acpi_power_button_wakeup);
> +
>  /* Driver Interface */
>  int acpi_lid_open(void)
>  {
> @@ -579,6 +595,7 @@ static int acpi_button_add(struct acpi_device *device=
)
>         switch (button->type) {
>         case ACPI_BUTTON_TYPE_POWER:
>                 input_set_capability(input, EV_KEY, KEY_POWER);
> +               input_set_capability(input, EV_KEY, KEY_WAKEUP);
>                 break;
>
>         case ACPI_BUTTON_TYPE_SLEEP:
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 808484d11209..f816606abd71 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -20,9 +20,13 @@
>  #include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/syscore_ops.h>
> +
>  #include <asm/io.h>
> +
>  #include <trace/events/power.h>
>
> +#include <acpi/button.h>

Not really.

> +
>  #include "internal.h"
>  #include "sleep.h"
>
> @@ -507,6 +511,7 @@ static void acpi_pm_finish(void)
>         pwr_btn_adev =3D acpi_dev_get_first_match_dev(ACPI_BUTTON_HID_POW=
ERF,
>                                                     NULL, -1);
>         if (pwr_btn_adev) {
> +               acpi_power_button_wakeup(pwr_btn_adev);

Why does this need to be done from here?

Can't the button driver itself to it?

>                 pm_wakeup_event(&pwr_btn_adev->dev, 0);
>                 acpi_dev_put(pwr_btn_adev);
>         }
> diff --git a/include/acpi/button.h b/include/acpi/button.h
> index af2fce5d2ee3..6126d665aa42 100644
> --- a/include/acpi/button.h
> +++ b/include/acpi/button.h
> @@ -2,17 +2,21 @@
>  #ifndef ACPI_BUTTON_H
>  #define ACPI_BUTTON_H
>
> +struct acpi_device;
> +
>  #define ACPI_BUTTON_HID_POWER  "PNP0C0C"
>  #define ACPI_BUTTON_HID_LID    "PNP0C0D"
>  #define ACPI_BUTTON_HID_SLEEP  "PNP0C0E"
>
>  #if IS_ENABLED(CONFIG_ACPI_BUTTON)
>  extern int acpi_lid_open(void);
> +extern void acpi_power_button_wakeup(struct acpi_device *dev);
>  #else
>  static inline int acpi_lid_open(void)
>  {
>         return 1;
>  }
> +static inline void acpi_power_button_wakeup(struct acpi_device *dev) {}
>  #endif /* IS_ENABLED(CONFIG_ACPI_BUTTON) */
>
>  #endif /* ACPI_BUTTON_H */
>
> base-commit: b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4
> --
> 2.35.1
>

