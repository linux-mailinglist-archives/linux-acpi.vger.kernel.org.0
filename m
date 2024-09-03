Return-Path: <linux-acpi+bounces-8102-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2848A96A0AE
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 16:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B9191C20E2B
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 14:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE1C2E636;
	Tue,  3 Sep 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/rU8AMR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3532F63D5;
	Tue,  3 Sep 2024 14:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373857; cv=none; b=bnHaUiI9P/92849krTxG4CwOYyqfKgfRYDKpZwLL45LV349tCvt5XpouaTZu8CoRZp4wym/Ml5FDqw6yOOJzs2UZmF8iWVnHz5hOaWMXPY1oUNe6xqiITg1Q2DVHK7DRDIlYajGx6jsDakGRmTwXF2MY2JG+sa6GZpdeBFhlyng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373857; c=relaxed/simple;
	bh=ng10fXMSIbglVvgpS3F6PzsqD0v9lSG8ZP384jizzaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaY1TH4ksivSUDaI85Aop9jFgM1fltCbHezNZ463CL+eAN3Bh7m2hkNlYdjTiOxMoDSNd3IzVIFEPHkDXmyntHiiKIQCacxi1EB5LbMrYwvv8yiJI7UeglKmhETwI2UeV9PfTZONRY7X3TvWjx4MqK+k4bU+59gHZyUkVjFm8z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/rU8AMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160F7C4CEC9;
	Tue,  3 Sep 2024 14:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373857;
	bh=ng10fXMSIbglVvgpS3F6PzsqD0v9lSG8ZP384jizzaI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H/rU8AMRTNR2upgjV48BAUDGmasBQUaAvZtX1m3Fl451bVhlZtPaDt5Qvk/SdfswZ
	 4TzsZZmPyPNjwQlJZ5Gt0g+DJJBEixmtKt0rslJDXHwVulgv893QzFe+QNgc2r7lDW
	 4fwa+29pYPayl3PPIzHlQDl3LjnuYvPU0gZHP9GJf2EnGVRVM5HHaqxCenZ9su/vsJ
	 ztkiC9NzYkJDyCoj7QGdlirbJIefPnVoOCqcQCUOoEPMQ4Lx7URO1ys7hvvYJdbmMV
	 vZe+Sp72LFT2ZAAUF5Y/oGPDDENc3LXR3oRb2snPVprkuzSdKX2qp76Dxy7BEeTJp4
	 ff/SYtBNDKMKg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-277fdd7d509so744562fac.0;
        Tue, 03 Sep 2024 07:30:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfuekvPAtnqTdhEypn1NN7TMK5+CyCjUVoV8bAvqPam5I2QLAd7lWIaOua4LLDZqXbZ4O+VHDVBdVy@vger.kernel.org, AJvYcCWoMa9gmCCrk4i1fQoVa1tvnAhdG92kJdLa0EweU/vpDt8R5j+IY8oIU4zvBudgvA0iEqacqdATevRt7Ocn@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt/HpfhbNsKShj1+5KadJpOrBhraLAYcdS/N0fwfwMBe0InDmy
	nFmjDNPHA/vWLuS+YqArmFzFOBuH+PzmaRP9hrY8DQwlOUHSEmZZtqLtLRS1pXlH6IvtOBXJOs9
	AM5wRzl1jsNLGEY7xEOYBo7vbynA=
X-Google-Smtp-Source: AGHT+IHidGuDcfJhNYB8lVH6jw75x8DJ+qJkP1fEBrjss/T5vOxd8XE8bR0P5BBUD+6Uq6y4Ue9Ttjdpqm8eDdSTIEY=
X-Received: by 2002:a05:6870:e0d4:b0:268:282b:bdec with SMTP id
 586e51a60fabf-277932a8e8emr7330831fac.8.1725373856368; Tue, 03 Sep 2024
 07:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901191826.421488-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240901191826.421488-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 16:30:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jeP0+mT_xA5vJGhSPSCJtpZY9QiLU91Zn1WrO3tovMcg@mail.gmail.com>
Message-ID: <CAJZ5v0jeP0+mT_xA5vJGhSPSCJtpZY9QiLU91Zn1WrO3tovMcg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: Use strscpy instead of strcpy.
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 9:18=E2=80=AFPM Muhammad Qasim Abdul Majeed
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
> <This is more than advertised in the changelog>
> The patch has been updated.
> ---
>  drivers/acpi/button.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cc61020756be..51470208e6da 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -547,20 +547,20 @@ static int acpi_button_add(struct acpi_device *devi=
ce)
>             !strcmp(hid, ACPI_BUTTON_HID_POWERF)) {
>                 button->type =3D ACPI_BUTTON_TYPE_POWER;
>                 handler =3D acpi_button_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_POWER);
> +               strscpy(name, ACPI_BUTTON_DEVICE_NAME_POWER, MAX_ACPI_DEV=
ICE_NAME_LEN);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_POWER);
>         } else if (!strcmp(hid, ACPI_BUTTON_HID_SLEEP) ||
>                    !strcmp(hid, ACPI_BUTTON_HID_SLEEPF)) {
>                 button->type =3D ACPI_BUTTON_TYPE_SLEEP;
>                 handler =3D acpi_button_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP);
> +               strscpy(name, ACPI_BUTTON_DEVICE_NAME_SLEEP, MAX_ACPI_DEV=
ICE_NAME_LEN);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_SLEEP);
>         } else if (!strcmp(hid, ACPI_BUTTON_HID_LID)) {
>                 button->type =3D ACPI_BUTTON_TYPE_LID;
>                 handler =3D acpi_lid_notify;
> -               strcpy(name, ACPI_BUTTON_DEVICE_NAME_LID);
> +               strscpy(name, ACPI_BUTTON_DEVICE_NAME_LID, MAX_ACPI_DEVIC=
E_NAME_LEN);
>                 sprintf(class, "%s/%s",
>                         ACPI_BUTTON_CLASS, ACPI_BUTTON_SUBCLASS_LID);
>                 input->open =3D acpi_lid_input_open;
> --

Applied as 6.12 material, thanks!

