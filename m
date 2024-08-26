Return-Path: <linux-acpi+bounces-7832-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0C395F7D2
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 19:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8014281D45
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 17:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2FE192D64;
	Mon, 26 Aug 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iaamlpw+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2A64A;
	Mon, 26 Aug 2024 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692800; cv=none; b=JL0mnMJ6FcmwUkqsTo/x6QrFiYAF0Sf5nSm3AjbriNkmiF1Y6AP/PehXx8FxRYeCLFcb5xP2/98XY04EV7Q/DNYXm83gzzv0GMeEnyiAMLJN3tNjuuoi07OOQTLpVpt/B4IX2tSh/Bxv3bfZDssEMaTc+bYB/wZHny59smKiRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692800; c=relaxed/simple;
	bh=zZA917AU/vTe5PvQuurV9fm0VhaPxXJy0ybi4SbcrO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/z7cEsATzA1pD7F44ebg2Bkwuve1lwVyWWYD2hTW4LuB4HqVZMwrSWLWp/EJgb+7x3Enjy+u4EXoXCUl4lO6XM39kKJgP9oLGbHfHCnY3babOLWSsGgIJwJ/I73VMLle2VWpDrAg+aoz5HSQoNq5YVt/WD6KQGhE+eZ9htv3A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iaamlpw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9A6C4CA4C;
	Mon, 26 Aug 2024 17:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692800;
	bh=zZA917AU/vTe5PvQuurV9fm0VhaPxXJy0ybi4SbcrO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iaamlpw++bnI9enTy2/cRdELLVqOzq4cSjPGkpnQRpg1yL+7CY98yNeHEkQXzCitD
	 W6Helb6PL7BFSNTdEm5KaRR5eoPDVGaCvNtRoU1CbNF5iRHZfh8V2rnjykCFuyi8J9
	 fvjSqcWpmCulBCBeLPlcMGq5+/diFj+CMLXccXYB6+blg9tWdftklZ0lHSXSi+w2N9
	 OOv4xcj6rujGylB7V5/zRw3WZBE41U0GMSLsrl7CQy3vB3d7lVPkiELocYhGa8PydJ
	 v4AOiBxZJrkmNQR1M1XImDp7g2g1Ha4N3xLXAjO0r2qghs4zaY1jvmpWgnpneFds5x
	 dr9PG/0MlDB/Q==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-27012aa4a74so2985563fac.0;
        Mon, 26 Aug 2024 10:20:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9khktxmJMjNPp2zMy0Iq7p1HsbJYX/4TNP8dd7QgqfGkWiAEkIv5Ah14vG95BGd7xL2sqePYaVdWeIYDG@vger.kernel.org, AJvYcCVfUlm5QKHyPakRRp7BCProLCujxqW866KzrIys/YcdKPKYK0B5TS2J/e42xTwM8K/t+Ts6ajgfWNxg@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlnTrPlLjOpL3S8Zb+cdL8/ic8V62NY9pZhlU0esS3Os/zmhh
	TTCEtQaKaGUlYcgaqbtabWHB+JgLfgjqRwwibqpoS4HpObTMwKX326C4WGk0BrnAYkGeHW+OjsT
	nz0sPoam1L9OU7VJLcRngBguLYIg=
X-Google-Smtp-Source: AGHT+IHXoIpiIuedW82SImap+65Jyk4M/K2ZhA9uVNXNyBhjrFQLtm/t49b7Uhv/K8crQc63kqHN8W+EdSnicptzi9M=
X-Received: by 2002:a05:6870:e311:b0:261:21e9:1f19 with SMTP id
 586e51a60fabf-273e66201b6mr12840768fac.35.1724692799422; Mon, 26 Aug 2024
 10:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804123313.16211-1-qasim.majeed20@gmail.com> <20240804123313.16211-5-qasim.majeed20@gmail.com>
In-Reply-To: <20240804123313.16211-5-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:19:48 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jKxxjTnOCQEMYWjUZkf4kmTB8Va3AypRYnaBHswyrpXA@mail.gmail.com>
Message-ID: <CAJZ5v0jKxxjTnOCQEMYWjUZkf4kmTB8Va3AypRYnaBHswyrpXA@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] ACPI: button: Use strscpy instead of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 2:34=E2=80=AFPM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replace strcpy() with strscpy() in the ACPI button driver.
>
> strcpy() has been deprecated because it is generally unsafe, so help to
> eliminate it from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> ---
>  drivers/acpi/button.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cc61020756be..9dda4a3998f8 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -521,7 +521,7 @@ static int acpi_button_add(struct acpi_device *device=
)
>         struct input_dev *input;
>         const char *hid =3D acpi_device_hid(device);
>         acpi_status status;
> -       char *name, *class;
> +       char *class;
>         int error =3D 0;
>
>         if (!strcmp(hid, ACPI_BUTTON_HID_LID) &&
> @@ -540,27 +540,26 @@ static int acpi_button_add(struct acpi_device *devi=
ce)
>                 goto err_free_button;
>         }
>
> -       name =3D acpi_device_name(device);

This is more than advertised in the changelog.

Please extend the changelog to explain why this additional change is needed=
.

>         class =3D acpi_device_class(device);
>
>         if (!strcmp(hid, ACPI_BUTTON_HID_POWER) ||
>             !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
>                 button->type =3D ACPI_BUTTON_TYPE_POWER;
>                 handler =3D acpi_button_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
> +               strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME=
_POWER);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
>         } else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
>                    !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
>                 button->type =3D ACPI_BUTTON_TYPE_SLEEP;
>                 handler =3D acpi_button_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
> +               strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME=
_SLEEP);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
>         } else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
>                 button->type =3D ACPI_BUTTON_TYPE_LID;
>                 handler =3D acpi_lid_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
> +               strscpy(acpi_device_name(device), ACPI_BUTTON_DEVICE_NAME=
_LID);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
>                 input->open =3D acpi_lid_input_open;
> @@ -579,7 +578,7 @@ static int acpi_button_add(struct acpi_device *device=
)
>
>         snprintf(button->phys, sizeof(button->phys), "%s/button/input0", =
hid);
>
> -       input->name =3D name;
> +       input->name =3D acpi_device_name(device);
>         input->phys =3D button->phys;
>         input->id.bustype =3D BUS_HOST;
>         input->id.product =3D button->type;
> @@ -636,7 +635,7 @@ static int acpi_button_add(struct acpi_device *device=
)
>         }
>
>         device_init_wakeup(&device->dev, true);
> -       pr_info("%s [%s]\n", name, acpi_device_bid(device));
> +       pr_info("%s [%s]\n", input->name, acpi_device_bid(device));
>         return 0;
>
>  err_input_unregister:
> --
> 2.34.1
>

