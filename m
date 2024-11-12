Return-Path: <linux-acpi+bounces-9508-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F84E9C628E
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 21:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12962284781
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E5A219E21;
	Tue, 12 Nov 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHDMVJpD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E922218D7C
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 20:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443281; cv=none; b=RazK4daR/Ut40OJlXF/wdP81dPtvb0BaPBT9Ba9kX8SXAgr9j4wiVhR+3cESsBgdqSGp2AcFkuPSWeg9biNUq6tU/ZvPjladAFePLZw6euPPUBLphe+DqacQEtq1ojN5vFh7Av1jimRjzLQXScvhv0sH+aIljgZWdcoWQXvp8K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443281; c=relaxed/simple;
	bh=TTeSjMglRilX+OdDe3ZcLFAs5KOWBRjepnj2CyVvG80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKx+/U9s3ZPP/Tx5+InpCT5+PqV/PvFmYDgWXA0wK3rLwZ97ja55L8II6KBDkCmZaOZUg0Y/qV31sF66gmmFPWDLvRXAtnMiBAODeCr+gA8tmkOkbwSX7gSyTbsTR44Fj/626OFA48Fz20IKPJ9+vQF5cClZde415up/7dQzREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHDMVJpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19A0C4CED5
	for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731443280;
	bh=TTeSjMglRilX+OdDe3ZcLFAs5KOWBRjepnj2CyVvG80=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aHDMVJpDgy2kYC0NxuBn+bZMfv5zZMIRGLtt6pRcc4J3X+f5q0jBVW3wO2Nbpy/Ru
	 sNd156MYIJPgnWpu4mueNIfe/cJNPoiRDprYB4Faeb0vnV7m0pVSzEcEWIkANpc+o6
	 kp7o9H+k/OmX8IfbaWR/OlcwYC6iscfI6j92h55AXZDDVajTeVJEiYkhBhnBWHRoiq
	 I9FmncmCwWax+jpDeH5aXsupnazXxfGLW/x7DBjFtXJzAU0oZSy+4ZEJImeDd1ecGK
	 MiYOm1xorXuOjw3vY6BtOFUTmEXBwqAeK2YvrTsf2uZzBrnwfLoNdhfsArVg3t8Sm4
	 JcXzw/DEyEJtw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ee763f9779so1413981eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 Nov 2024 12:28:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUcKab1ruth1ZKaMsVxcLOBWmTKUTYHLn9mf2Q4NmcApsbdXypHSXJtqcSfqlhBlXY4q9H/bzVNu9TY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ovPTcoJFF/Wh/ckvHsOFlN9Weu+FuG5SKAjgOLg/1YN9p7pQ
	PtpCbETZsWdk16Z4apB2z7+50kZAfyHjgzpQStT6McGgEb1+Z3doz3StzoUO5CPVwLORkIB6tXt
	K49ElgOwmX0NozFBHQ0NBJpB0ty4=
X-Google-Smtp-Source: AGHT+IG2RV2MLmwgRmM+G93ljwyuCp3i2uB8jJBAjuzf8qsufKrkleKW9gDwKPhxfjrhG68bsXMQdet+FGL6DKa4Zmc=
X-Received: by 2002:a05:6820:1b08:b0:5ee:a5b:d172 with SMTP id
 006d021491bc7-5ee57c530cdmr11945144eaf.5.1731443279923; Tue, 12 Nov 2024
 12:27:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241109215936.83004-1-hdegoede@redhat.com>
In-Reply-To: <20241109215936.83004-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Nov 2024 21:27:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hKqWB7NCWa-83ofVPLjPeAy+dRHvRCWopcSKMixm11-A@mail.gmail.com>
Message-ID: <CAJZ5v0hKqWB7NCWa-83ofVPLjPeAy+dRHvRCWopcSKMixm11-A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Make UART skip quirks work on PCI UARTs
 without an UID
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 10:59=E2=80=AFPM Hans de Goede <hdegoede@redhat.com>=
 wrote:
>
> The Vexia EDU ATLA 10 tablet (9V version) which shipped with Android 4.2
> as factory OS has the usual broken DSDT issues for x86 Android tablets.
>
> On top of that this tablet is special because all its LPSS island
> peripherals are enumerated as PCI devices rather then as ACPI devices as
> they typically are.
>
> For the x86-android-tablets kmod to be able to instantiate a serdev clien=
t
> for the Bluetooth HCI on this tablet, an ACPI_QUIRK_UART1_SKIP quirk is
> necessary.
>
> Modify acpi_dmi_skip_serdev_enumeration() to work with PCI enumerated
> UARTs without an UID, such as the UARTs on this tablet.
>
> Also make acpi_dmi_skip_serdev_enumeration() exit early if there are no
> quirks, since there is nothing to do then.
>
> And add the necessary quirks for the Vexia EDU ATLA 10 tablet.
>
> This should compile with CONFIG_PCI being unset without issues because
> dev_is_pci() is defined as "(false)" then.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 49 ++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 6af546b21574..3eec889d4f5f 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -12,6 +12,7 @@
>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
> @@ -391,6 +392,19 @@ static const struct dmi_system_id acpi_quirk_skip_dm=
i_ids[] =3D {
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
>         },
> +       {
> +               /* Vexia Edu Atla 10 tablet 9V version */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> +                       /* Above strings are too generic, also match on B=
IOS date */
> +                       DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
> +               },
> +               .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_UART1_SKIP |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
> +       },
>         {
>                 /* Whitelabel (sold as various brands) TM800A550L */
>                 .matches =3D {
> @@ -439,18 +453,35 @@ static int acpi_dmi_skip_serdev_enumeration(struct =
device *controller_parent, bo
>         struct acpi_device *adev =3D ACPI_COMPANION(controller_parent);
>         const struct dmi_system_id *dmi_id;
>         long quirks =3D 0;
> -       u64 uid;
> -       int ret;
> -
> -       ret =3D acpi_dev_uid_to_integer(adev, &uid);
> -       if (ret)
> -               return 0;
> +       u64 uid =3D 0;
>
>         dmi_id =3D dmi_first_match(acpi_quirk_skip_dmi_ids);
> -       if (dmi_id)
> -               quirks =3D (unsigned long)dmi_id->driver_data;
> +       if (!dmi_id)
> +               return 0;
>
> -       if (!dev_is_platform(controller_parent)) {
> +       quirks =3D (unsigned long)dmi_id->driver_data;
> +
> +       /* uid is left at 0 on errors and 0 is not a valid UART UID */
> +       acpi_dev_uid_to_integer(adev, &uid);
> +
> +       /* For PCI UARTs without an UID */
> +       if (!uid && dev_is_pci(controller_parent)) {
> +               struct pci_dev *pdev =3D to_pci_dev(controller_parent);
> +
> +               /*
> +                * Devfn values for PCI UARTs on Bay Trail SoCs, which ar=
e
> +                * the only devices where this fallback is necessary.
> +                */
> +               if (pdev->devfn =3D=3D PCI_DEVFN(0x1e, 3))
> +                       uid =3D 1;
> +               else if (pdev->devfn =3D=3D PCI_DEVFN(0x1e, 4))
> +                       uid =3D 2;
> +       }
> +
> +       if (!uid)
> +               return 0;
> +
> +       if (!dev_is_platform(controller_parent) && !dev_is_pci(controller=
_parent)) {
>                 /* PNP enumerated UARTs */
>                 if ((quirks & ACPI_QUIRK_PNP_UART1_SKIP) && uid =3D=3D 1)
>                         *skip =3D true;
> --

Applied as 6.13 material, thanks!

