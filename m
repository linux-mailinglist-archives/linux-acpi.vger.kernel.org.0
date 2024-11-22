Return-Path: <linux-acpi+bounces-9762-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B09A9D64CA
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 21:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C72FDB20C64
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Nov 2024 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D9183CBE;
	Fri, 22 Nov 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2cfZWzg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CE1CA9C
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732306425; cv=none; b=G9iEMrrAOJcikmdN6ZvfBV4N3YrnjcQmSBlJZYdC6mHlURe185Bktbyy29SS2ACI6G11bxAEo6ejA6Ztc4icE48ARAKgqPa/wwBYM1BW55imU6BNxNct/dal9G7KbLHB4f9iDPyS2/X6vi+IIOk5VwL0XhoQUdU+yccqVlvKCWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732306425; c=relaxed/simple;
	bh=W6eD8O9QsbAHcbn8tfe6TfBSrOpvd2qB6Q+S3anPjyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LroiNOtxTabUTaJUb1RX3ThaoxSR5IKb+oybQRyfJTfPWKMwQog7xm0WOpTm2rtUMYdjIZwMOQGVz36+LNNhHuQgzE3w0buh3exoZfwSmpzsq/v/ywqsDf7EPu8/bzXzcgU+qEpD/+YbdEHovYq7WKvnknKl8LdlBKvD50ulzdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2cfZWzg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA49C4CECE
	for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 20:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732306424;
	bh=W6eD8O9QsbAHcbn8tfe6TfBSrOpvd2qB6Q+S3anPjyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U2cfZWzg8W0ozZ1KwGkExyo4PzhzsTFFzQ1a+ZUGbzmZDjBdr1cTtGZrvf2gu/5bF
	 SwR/H/RCjachbV133ohCJRnteTxWTy8r97pflh/qf+IDtnvsKPM3Z4WJT4N53ViaQH
	 t9d3GpUi3Y0MI9930eGR25s4d1S5KuT9fFnJT2aUftkXzu+OKG7gtv0MmtgQXqjQJl
	 2RCpWSVy3BlgoeA6uJYCQSfF5eVJeT9kHWhPS4yK/7cdh/zbPS7Xj5cTCkSrEUM9Tx
	 7gdUCI9pzM5qw1r6/+LvqSCb0mSDmNwK3lMc26QQUDBQRnMhuLZlwYx/YlhIGJLbij
	 s/Ilpg9vbH3Jg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-295cee3a962so1681921fac.3
        for <linux-acpi@vger.kernel.org>; Fri, 22 Nov 2024 12:13:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU0F1VLv4IskYaVC1qDxLDX5rx8hYlpYfLQkJFMdA+OYYaH09nenjphIRH75pkKm+lCF1lckMin1b1S@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+IxT7U4GjCIu+BPrYv6Lx0Mncdd5UhHUVTZPdJgThQidXo/bQ
	cQwEYuhSASMdLvrp44EhWlTnsX6AC/qzU6jDhplSt7l7uBvuOt6Eo2nO0OR7I8a+O5376I9QnPW
	r5fIq78Z8+k5JdqGwrT4U9RZdisY=
X-Google-Smtp-Source: AGHT+IERCAiWg1i7kKBBJQ3oJ/9drNbLV894o+440XhhvwqNIoM9hQQfLHoBcVD2wbXlgjgaRJZooktlsTnGRxwcrwA=
X-Received: by 2002:a05:6870:2182:b0:297:8d9:693c with SMTP id
 586e51a60fabf-29720d9058amr4332322fac.32.1732306424107; Fri, 22 Nov 2024
 12:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116095825.11660-1-hdegoede@redhat.com>
In-Reply-To: <20241116095825.11660-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 22 Nov 2024 21:13:31 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0incmvrSt0EcLrZ6rz8oB+vgrY-tWTUeAniSFS+dA+B8g@mail.gmail.com>
Message-ID: <CAJZ5v0incmvrSt0EcLrZ6rz8oB+vgrY-tWTUeAniSFS+dA+B8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: x86: Add skip i2c clients quirk for Acer Iconia
 One 8 A1-840
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 16, 2024 at 10:58=E2=80=AFAM Hans de Goede <hdegoede@redhat.com=
> wrote:
>
> The Acer Iconia One 8 A1-840 (not to be confused with the A1-840FHD which
> is a different model) ships with Android 4.4 as factory OS and has
> the usual broken DSDT issues for x86 Android tablets.
>
> Add quirks to skip ACPI I2C client enumeration and disable ACPI battery/A=
C
> and ACPI GPIO event handlers.
>
> Also add the "INT33F5" HID for the TI PMIC used on this tablet to the lis=
t
> of HIDs for which not to skip i2c_client instantiation, since we do want
> an ACPI instantiated i2c_client for the PMIC.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/x86/utils.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index 423565c31d5e..1bb425b78032 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -308,6 +308,18 @@ static const struct dmi_system_id acpi_quirk_skip_dm=
i_ids[] =3D {
>                                         ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
>                                         ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
>         },
> +       {
> +               /* Acer Iconia One 8 A1-840 (non FHD version) */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
> +                       /* Above strings are too generic also match BIOS =
date */
> +                       DMI_MATCH(DMI_BIOS_DATE, "04/01/2014"),
> +               },
> +               .driver_data =3D (void *)(ACPI_QUIRK_SKIP_I2C_CLIENTS |
> +                                       ACPI_QUIRK_SKIP_ACPI_AC_AND_BATTE=
RY |
> +                                       ACPI_QUIRK_SKIP_GPIO_EVENT_HANDLE=
RS),
> +       },
>         {
>                 .matches =3D {
>                         DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER=
 INC."),
> @@ -425,6 +437,7 @@ static const struct acpi_device_id i2c_acpi_known_goo=
d_ids[] =3D {
>         { "10EC5640", 0 }, /* RealTek ALC5640 audio codec */
>         { "10EC5651", 0 }, /* RealTek ALC5651 audio codec */
>         { "INT33F4", 0 },  /* X-Powers AXP288 PMIC */
> +       { "INT33F5", 0 },  /* TI Dollar Cove PMIC */
>         { "INT33FD", 0 },  /* Intel Crystal Cove PMIC */
>         { "INT34D3", 0 },  /* Intel Whiskey Cove PMIC */
>         { "NPCE69A", 0 },  /* Asus Transformer keyboard dock */
> --

Applied as 6.13-rc material along with the [2/2], thanks!

