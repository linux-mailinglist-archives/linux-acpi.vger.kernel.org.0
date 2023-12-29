Return-Path: <linux-acpi+bounces-2644-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B138200F3
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 18:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7289281406
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96C412B84;
	Fri, 29 Dec 2023 17:49:44 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08E12B82
	for <linux-acpi@vger.kernel.org>; Fri, 29 Dec 2023 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-594172c5785so192839eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 29 Dec 2023 09:49:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703872182; x=1704476982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeozkvIdKrkamCgm5fSGljjMhGfXrRVeCiwdQ5jE6t8=;
        b=wjLktnwAU7N2SQlDd33aUoMGjSbZmeXgQ0Ok7Q5rQ6bGq1qsmX0NYtTW7NsaC5b7dG
         FmWi9TRM+zgHYrlLP/GJA+M4S3H+68D+5kKiRf+PI0Z0cdmr0BkfztqoNMab6wtfEo7R
         +0+v1ep5b7SAdVYk1pWSpnkizy3FQ4fEEKuA/dloUjqchMnkokNuTckBUAC3cBLxGqSk
         0FeArqnHAxu/G2NxDhF6IGrS9aExbHGDHxTumwxrQcGflcEZ9/UP2RfIDodo4tTGqth/
         T9ip1hvMq61mdYNFY0FRk8F3HWXBvfc+PDtsklWnAI5Zoks4LwK/D2iI33y25Y8nzxat
         A37Q==
X-Gm-Message-State: AOJu0YwQKftYxVZAK2xiarsbklrzPKgyN6d7NjDo9x/JuoKJ7kBYvNO0
	4/2BmWF0igdZzOXDfwvpg33m43+sovmLzBbAF0sJAHxD
X-Google-Smtp-Source: AGHT+IHwqyIxJareOXo+MGMv5Ke4r+PfCil+jkzwE0/Apc4UOHkS1ZymWF1K9yZ8Pp+W5gikloqB9vgn/rwQTmn02DI=
X-Received: by 2002:a05:6820:2801:b0:594:cb36:b255 with SMTP id
 dm1-20020a056820280100b00594cb36b255mr7746421oob.1.1703872182599; Fri, 29 Dec
 2023 09:49:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231225055835.1052555-1-Ken.Xue@amd.com>
In-Reply-To: <20231225055835.1052555-1-Ken.Xue@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:49:31 +0100
Message-ID: <CAJZ5v0iaEq6Do_6axWOBFuWROkFHtM0wMpLs1ZrqXjdqvAGgKw@mail.gmail.com>
Subject: Re: [PATCH V6] acpi: button: trigger wakeup key event
To: Ken Xue <Ken.Xue@amd.com>
Cc: rafael@kernel.org, andriy.shevchenko@linux.intel.com, 
	linux-acpi@vger.kernel.org, cwhuang@linux.org.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 7:00=E2=80=AFAM Ken Xue <Ken.Xue@amd.com> wrote:
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
> V5->V6: report WAKEUP event from button driver instead of acpi sleep.c
> ---
>  drivers/acpi/button.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 1e76a64cce0a..cc61020756be 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -480,6 +480,7 @@ static int acpi_button_suspend(struct device *dev)
>
>  static int acpi_button_resume(struct device *dev)
>  {
> +       struct input_dev *input;
>         struct acpi_device *device =3D to_acpi_device(dev);
>         struct acpi_button *button =3D acpi_driver_data(device);
>
> @@ -489,6 +490,14 @@ static int acpi_button_resume(struct device *dev)
>                 button->last_time =3D ktime_get();
>                 acpi_lid_initialize_state(device);
>         }
> +
> +       if (button->type =3D=3D ACPI_BUTTON_TYPE_POWER) {
> +               input =3D button->input;
> +               input_report_key(input, KEY_WAKEUP, 1);
> +               input_sync(input);
> +               input_report_key(input, KEY_WAKEUP, 0);
> +               input_sync(input);
> +       }
>         return 0;
>  }
>  #endif
> @@ -579,6 +588,7 @@ static int acpi_button_add(struct acpi_device *device=
)
>         switch (button->type) {
>         case ACPI_BUTTON_TYPE_POWER:
>                 input_set_capability(input, EV_KEY, KEY_POWER);
> +               input_set_capability(input, EV_KEY, KEY_WAKEUP);
>                 break;
>
>         case ACPI_BUTTON_TYPE_SLEEP:
> --

Applied as 6.8 material with minor edits in the subject, thanks!

