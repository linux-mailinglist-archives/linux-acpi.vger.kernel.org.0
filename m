Return-Path: <linux-acpi+bounces-10423-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B3A04978
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD7703A5FC2
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 18:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8101F428E;
	Tue,  7 Jan 2025 18:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oq45e6Wa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EC418C937;
	Tue,  7 Jan 2025 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275584; cv=none; b=GW8KXwXhbE3+lLXEr/o9tgABmqVYSxto5KVRYa/LJ70WKSj5RkXT4+4UizsDuviXRnmtQCuMOxIaudxGqw2PXhqxw+6ZgnCNLLEE6xAgVoDr4IRLuokQjPGyAzgbMnorD0nlnvFqztOezURpvlP/+v4NjkxygFZ8OPfrO26eQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275584; c=relaxed/simple;
	bh=uIOiT+eWmOm2E4larc9CS/AZuK4Bj92iOncd6UmTiso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IOBjc+W2DfrS7hiIWePYsXA6pJgkRaL1bylnZhHrXXuAc9KeWBZ+3g5MJNJMP5p5HkqXlbGfkisGNGdyJ2eyXQ3NFyKPvlwpRkZ+NXsSV+k+/3GZ9LglJTYi0xkZy+SuKHv6/dYFrUSzTDdeJ6mjkN6anHcEpLR4LNjhjpLM8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oq45e6Wa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05ECC4CEDE;
	Tue,  7 Jan 2025 18:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736275583;
	bh=uIOiT+eWmOm2E4larc9CS/AZuK4Bj92iOncd6UmTiso=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Oq45e6WasYKc998P6sfLSQkdFovoP7/+bsJ341pfGoZ/1hBAzG9FQpKhgXSXvKSWf
	 yPnapg5byAUuYQiwRsCcDqTXVnbhQFK06p7KSS5tHzqoR1VhYPzQWObKE9oGan2XTx
	 lf6XmhBfIBoFsYgeGmV7p1yaJVqXB6NXf1kM3XkjQFAoJEfNlMPqh4pcSA2835UvyV
	 Y+gadV+dbhjXyV8oIWUfdU0Fqpalc1iM/zvACfa6X9J7JB0BINywFIWICl6bNhGlmJ
	 SuZ9w9hATVgKPGD9zmknnvnS1Fsg63JtbzgYoXOu2+rzcdOEVrQaAUkqAZZq+kqwhu
	 yHWwqwO6nsNCg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5f4ce54feb8so7631559eaf.3;
        Tue, 07 Jan 2025 10:46:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlqA4kNsKRBWf/vwxYe9ZN8pNw4mThR2uRGf6IlSehmp0WR4p3B8OqcLbQD4UKnv2t9th3VzK1Zwla@vger.kernel.org, AJvYcCXg58BhJ096rmLFOmw1gbMvC7OXV1B2PDF9XbykaJgH5N5CxKFbRjFlg5BhlZ1g5RfZkufYOK/snJznD3c7@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpDIwhkTkvNuJrr80iP4YI2X3a9cw/iYHI/xwrQXK/i+EUclo
	SJ6idFoh6tQ0cBrGlSRsGEkS2esY0iUEM6XJ3POFCMffeERBN13sjGom4X0KeZiI9hgsZkjye9J
	zhGUx5DNAK4j+sVIThkivFTHf13k=
X-Google-Smtp-Source: AGHT+IHMEf1iHs1I89Sulr91TxTQd64FM84M60ywU4pPxg2O+t9kYUnBBZ56Rc4Z1uPRoSe3IccYBVudtVB4cs6rVTs=
X-Received: by 2002:a05:6871:374a:b0:29e:5c37:a1c0 with SMTP id
 586e51a60fabf-2aa06722377mr39015fac.21.1736275582878; Tue, 07 Jan 2025
 10:46:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fdf629284a00da61384eadea6ac0cd78c20e7e11.1735490662.git.mail@maciej.szmigiero.name>
In-Reply-To: <fdf629284a00da61384eadea6ac0cd78c20e7e11.1735490662.git.mail@maciej.szmigiero.name>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 Jan 2025 19:46:11 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0j+gUjTGAVCxBQad3Bb5D0ai+dRa5kmNu_ohf5TCnpUhQ@mail.gmail.com>
X-Gm-Features: AbW1kvZCOjzoTm_M_pMuo07ezvHTr3JeIgxl1wEaPTAyoxwGjV1wfX3z943c8V0
Message-ID: <CAJZ5v0j+gUjTGAVCxBQad3Bb5D0ai+dRa5kmNu_ohf5TCnpUhQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Add HP EliteBook 855 G7 WWAN modem power
 resource quirk
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2024 at 5:45=E2=80=AFPM Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> This laptop (and possibly similar models too) has power resource called
> "GP12.PXP_" for its Intel XMM7360 WWAN modem.
>
> For this power resource to turn ON power for the modem it needs certain
> internal flag called "ONEN" to be set:
> Method (_ON, 0, NotSerialized) // _ON_: Power On
> {
>         If (^^^LPCB.EC0.ECRG)
>         {
>                 If ((ONEN =3D=3D Zero))
>                 {
>                         Return (Zero)
>                 }
> (..)
>         }
> }
>
>
> This flag only gets set from this power resource "_OFF" method, while the
> actual modem power gets turned off during suspend by "GP12.PTS" method
> called from the global "_PTS" (Prepare To Sleep) method.
>
> In fact, this power resource "_OFF" method implementation just sets the
> aforementioned flag:
> Method (_OFF, 0, NotSerialized) // _OFF: Power Off
> {
>         OFEN =3D Zero
>         ONEN =3D One
> }
>
> Upon hibernation finish we try to set this power resource back ON since i=
ts
> "_STA" method returns 0 and the resource is still considered in use as it
> is declared as required for D0 for both the modem ACPI device (GP12.PWAN)
> and its parent PCIe port ACPI device (GP12).
> But the "_ON" method won't do anything since that "ONEN" flag is not set.
>
> Overall, this means the modem is dead after hibernation finish until the
> laptop is rebooted since the modem power has been cut by "_PTS" and its P=
CI
> configuration was lost and not able to be restored.
>
> The easiest way to workaround this issue is to call this power resource
> "_OFF" method before calling the "_ON" method to make sure the "ONEN"
> flag gets properly set.
>
> This makes the modem alive once again after hibernation finish - with
> properly restored PCI configuration space.
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Thanks for the patch, but I'd rather find a different way of
addressing the problem at hand because there are at least two
potential issues with this approach.

> ---
>  drivers/acpi/power.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 25174c24d3d7..1db93cf8e4f6 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -23,6 +23,7 @@
>
>  #define pr_fmt(fmt) "ACPI: PM: " fmt
>
> +#include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -991,9 +992,57 @@ struct acpi_device *acpi_add_power_resource(acpi_han=
dle handle)
>  }
>
>  #ifdef CONFIG_ACPI_SLEEP
> +static const struct dmi_system_id dmi_hp_elitebook_gp12pxp_quirk[] =3D {
> +/*
> + * This laptop (and possibly similar models too) has power resource call=
ed
> + * "GP12.PXP_" for its WWAN modem.
> + *
> + * For this power resource to turn ON power for the modem it needs certa=
in
> + * internal flag called "ONEN" to be set.
> + * This flag only gets set from this power resource "_OFF" method, while=
 the
> + * actual modem power gets turned off during suspend by "GP12.PTS" metho=
d
> + * called from the global "_PTS" (Prepare To Sleep) method.
> + * On the other hand, this power resource "_OFF" method implementation j=
ust
> + * sets the aforementioned flag without actually doing anything else (it
> + * doesn't contain any code to actually turn off power).
> + *
> + * The above means that when upon hibernation finish we try to set this
> + * power resource back ON since its "_STA" method returns 0 (while the r=
esource
> + * is still considered in use) its "_ON" method won't do anything since
> + * that "ONEN" flag is not set.
> + * Overall, this means the modem is dead until laptop is rebooted since =
its
> + * power has been cut by "_PTS" and its PCI configuration was lost and n=
ot able
> + * to be restored.
> + *
> + * The easiest way to workaround the issue is to call this power resourc=
e
> + * "_OFF" method before calling the "_ON" method to make sure the "ONEN"
> + * flag gets properly set.
> + */
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "HP EliteBook 855 G7 =
Notebook PC"),
> +               },
> +       },
> +       {}
> +};
> +
> +static bool resource_is_gp12pxp(acpi_handle handle)
> +{
> +       const char *path;
> +       bool ret;
> +
> +       path =3D acpi_handle_path(handle);
> +       ret =3D path && strcmp(path, "\\_SB_.PCI0.GP12.PXP_") =3D=3D 0;
> +       kfree(path);
> +
> +       return ret;
> +}
> +
>  void acpi_resume_power_resources(void)
>  {
>         struct acpi_power_resource *resource;
> +       bool hp_eb_gp12pxp_quirk =3D dmi_check_system(dmi_hp_elitebook_gp=
12pxp_quirk);
>
>         mutex_lock(&power_resource_list_lock);
>
> @@ -1012,8 +1061,34 @@ void acpi_resume_power_resources(void)
>
>                 if (state =3D=3D ACPI_POWER_RESOURCE_STATE_OFF
>                     && resource->ref_count) {
> +                       bool eb_gp12pxp =3D hp_eb_gp12pxp_quirk &&
> +                               resource_is_gp12pxp(resource->device.hand=
le);

This is quite a bit of a useless overhead for all of the systems that
don't actually contain this defective power resource.

Also, according to your description, the problem is
hibernation-specific and this function is also called on resume from
suspend-to-RAM.

> +
> +                       if (eb_gp12pxp) {
> +                               acpi_handle_notice(resource->device.handl=
e,
> +                                                  "HP EB quirk - turning=
 OFF before ON\n");
> +                               __acpi_power_off(resource);
> +                       }
> +
>                         acpi_handle_debug(resource->device.handle, "Turni=
ng ON\n");
>                         __acpi_power_on(resource);
> +
> +                       if (eb_gp12pxp) {
> +                               /*
> +                                * Use the same delay as DSDT uses in mod=
em _RST
> +                                * method.
> +                                *
> +                                * Otherwise we get "Unable to change pow=
er
> +                                * state from unknown to D0, device
> +                                * inaccessible" error for the modem PCI =
device
> +                                * after thaw.
> +                                *
> +                                * This power resource is normally being =
enabled
> +                                * only during thaw (once) so this wait i=
s not
> +                                * a performance issue.
> +                                */
> +                               msleep(200);
> +                       }
>                 }
>
>                 mutex_unlock(&resource->resource_lock);

It looks like the modem's driver is modular and not included into the
initrd image, so the restore kernel doesn't initialize it during
resume from hibernation.

Have you tried to build that driver into the kernel or add it to the initrd=
?

