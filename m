Return-Path: <linux-acpi+bounces-12516-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F46A73EF9
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 20:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90FC9176103
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Mar 2025 19:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C391C7B62;
	Thu, 27 Mar 2025 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7gfPWsV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715B1C7018;
	Thu, 27 Mar 2025 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743104617; cv=none; b=MaBxbwe8m2VRUZxPsH3AVZ0goX2imVM78yFNX+iRSo9fqNxu9vrjjvzVotf/SnyykhCu7VOORTo5IPHR1Ow4r4od2M8FLDTWKTMezsrvVVq/hpUp8/XaRYdPi/AYDUSDFnAWnbB32O6NByV8BgCOu0bEI+V1fJqvpUik1zhPgWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743104617; c=relaxed/simple;
	bh=bn0cSNoEHNeCGEyc626Th6UVfiYf02iZNx4lymmxA+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NtjuiNm8o2a/cwnQvFKERmNeVjtgPN6mUn3oqdoT13VB7ZB63htZ0tB+8IwKgY6wL0fY9NRPi71W7b5FQDPs/8En36gvB4DKwnNca45a6weQ2jylEd/OpPb8gW4GFjYtJhGKqlxJEKdtgy+I8mQNYmgiAPPysiahUHRyxYVg54g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7gfPWsV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FCEC4CEEF;
	Thu, 27 Mar 2025 19:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743104616;
	bh=bn0cSNoEHNeCGEyc626Th6UVfiYf02iZNx4lymmxA+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R7gfPWsVHwwYnRLnpXDXQ8LFXDODpaYaC0FwKFurGWHUoKcOJB1RYB20vqYyzKPqL
	 /w08Qib+fAnwhwyVi8XlvWHFjFark5KLGSGynB3QBgF16EJoYolTjlI9ppMwgs7TVc
	 +CyqOabZNAWNOOpz8swUC97a+iKjqy4kAgGD4viCwZ9oInuOlu/jrmTisY8NC+cvtF
	 sAlv9m8wWCBXky7LSvcXC96SigHdAhMkh9GLDzYvlYuCUQ+om5RxMpdK3sUfXxlWeD
	 CUgaFXc5qm89R+Stmn0lZvUN4KO0N4uPiQnG0eKNCVYc3JT3e/gM+Amcuf/jEg8hzp
	 hrhs0NpgtPnPw==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-72c47631b4cso895912a34.1;
        Thu, 27 Mar 2025 12:43:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXrtJJ4mbF1XlZpDncIG1kWSn2Fn1imkKE5XeFbYE1HC9VO8VYKPqpNdw3AuWr6HEZT16qdtRb9lWqAwNeCszldWJ2pqg==@vger.kernel.org, AJvYcCXy48n21VpU93Laed0CGlj3UoVfE9+tLvgIbP90iHwZ1TlhsbsBEI/1WSnq6TwT5H02oQhoy1UB0+wh@vger.kernel.org
X-Gm-Message-State: AOJu0YxMQC8M3yR5MMNx1ktWqZSabArLJ5941IszFB4t72nc4OA8ZS7c
	twawuMunW0S04Itcs77jm/cABySWJsWSEU5L21+9hITlJghn13OGyIuFgAsqbMTCanBvQQAWUey
	yuBaV5CSfMsGlD8vBME39LMpSSoU=
X-Google-Smtp-Source: AGHT+IHct5/4hpIN9EwE1NAKFukxmxO2Wefqx/BiOgbhS7RN7kT0XZRIyQMkU8sdG9NYFoSVgmBsAxUSUCaHgs5dpPk=
X-Received: by 2002:a05:6870:c993:b0:29e:69a9:8311 with SMTP id
 586e51a60fabf-2c848228d57mr3189462fac.36.1743104615822; Thu, 27 Mar 2025
 12:43:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325210450.358506-1-hdegoede@redhat.com>
In-Reply-To: <20250325210450.358506-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 27 Mar 2025 20:43:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gk4EvViCS1bN966681LJ-cR+Fz9D2nZs18ha-Pbe56pw@mail.gmail.com>
X-Gm-Features: AQ5f1Jrwt0GxvdK_UEGnYUaWFBpPxhsXKC-7xdmgxz5_oDM09oI75h0eLAh1QoE
Message-ID: <CAJZ5v0gk4EvViCS1bN966681LJ-cR+Fz9D2nZs18ha-Pbe56pw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Extend Lenovo Yoga Tab 3 quirk with skip GPIO event-handlers
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, Agoston Lorincz <pipacsba@gmail.com>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:05=E2=80=AFPM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> Depending on the secureboot signature on EFI\BOOT\BOOTX86.EFI the
> Lenovo Yoga Tab 3 UEFI will switch its OSID ACPI variable between
> 1 (Windows) and 4 (Android(GMIN)).
>
> In Windows mode a GPIO event handler gets installed for GPO1 pin 5,
> causing Linux' x86-android-tables code which deals with the general
> brokenness of this device's ACPI tables to fail to probe with:
>
> [   17.853705] x86_android_tablets: error -16 getting GPIO INT33FF:01 5
> [   17.859623] x86_android_tablets x86_android_tablets: probe with driver
>
> which renders sound, the touchscreen, charging-management,
> battery-monitoring and more non functional.
>
> Add ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLERS to the existing quirks for this
> device to fix this.
>
> Reported-by: Agoston Lorincz <pipacsba@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/CAMEzqD+DNXrAvUOHviB2=
O2bjtcbmo3xH=3DkunKr4nubuMLbb_0A@mail.gmail.com/
> Cc: stable@kernel.org
> Fixes: fe820db35275 ("ACPI: x86: Add skip i2c clients quirk for Lenovo Yo=
ga Tab 3 Pro (YT3-X90F)")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 068c1612660b..4ee30c2897a2 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -374,7 +374,8 @@ static const struct dmi_system_id acpi_quirk_skip_dmi=
_ids[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_VERSION, "Blade3-10A-001"),
>                 },
>                 .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> -                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY),
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
>         },
>         {
>                 /* Medion Lifetab S10346 */
> --

Applied as 6.15-rc material, thanks!

