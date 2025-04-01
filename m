Return-Path: <linux-acpi+bounces-12589-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1175A77C98
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1157A4713
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A53204594;
	Tue,  1 Apr 2025 13:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNEHXotH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B4120371A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515345; cv=none; b=tCId4xodrqJzpZgmL0hS9/O3zX6eYyZjrtGflPwPQ2v/MiX9UK0zM6725USiqWrZbMIJQNLx+EkHZM2xrAbElsLlcOZDWcnjCtQD2Ua/9FMFVc2Cj2lP3oPef81h8v/G37inbbZNdGXKu+g06Y8lM31ZDDTwCGntKXLyTcnYKHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515345; c=relaxed/simple;
	bh=HPtKIlt9O7URXt5LvOect8Ci9k7l7R3g8A6nOABjSfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfzT8NMPrrgaDjRgWxq889eC2Q/sOcR8WqYbyoX0NATzZsaG2zh4AnAMmIcIotPOxIBCwUhsWr8Q4pNGa11TgBvmyig1T+Yp50sWZmB5RhRMVgg66U5QmlyKF1iarg7vNr/QrNudz9KYd2Zs/qm9uxRtFnjxR59Ql4B7roI4lqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNEHXotH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBE5C4CEEE
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 13:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743515344;
	bh=HPtKIlt9O7URXt5LvOect8Ci9k7l7R3g8A6nOABjSfo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CNEHXotHEwOl7gFXRCRS2aKj7ljBFP2HJ7O26frhqie+Ro0Z2DX6sAPxfOT+9qoAW
	 Y75gaUXod0UyVJsN1Fj4PxJshPaKqxVHpV1xpUYJlSQi7yiCvdQva8zzFpsdV2sPhP
	 IP0PR6mmAVm21KBs7/lGjpXcIduc407qO7joTfNXH6JoXkdX6HSMmM/Zye6+UK+GPR
	 ps4TKKz8Fjt3rD5r6GJThbJjoHHskJKn2POs6PGJA8i10v803JiUmBTsbVWxyVVtDu
	 Ai4wtVBDEWp0ysxaZD8XcMCIi2RMnLaMGbu4Dcco7d3PlZdNFbSsNjHuUHYgtQ8AFX
	 rfrdjZb50S0AQ==
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72bd828f18dso1645435a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 01 Apr 2025 06:49:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn0j7KTxYvyOmfuJSyD641NZtndHFrDJFcGqBIxhwBI7OF+xEtiVe3xrjomy9n491/BHHRHBdgYBS3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87cLiN9CWyx9g8XesMmpZVjFsd6Cz/nxvNhYatbMw3HIVYSrr
	zDz5rqTZyLjy/OHMyppS8gIiMRlaTqhTOFMCBtPPtUYE5SicQtQrcMgm33exbQLXL6Fe7QxRs/A
	8tjFNfCVy4On0/V/g3z40pcmdjgk=
X-Google-Smtp-Source: AGHT+IGX1rb50c4rWOgNKQJQxdInSnxK92MWvW7iSbCN6sahFJ07M3Rx1Kdk2OegnW8w3KvZhcFYfWLbuqqPtVi20eU=
X-Received: by 2002:a05:6830:4391:b0:72c:320c:d4ed with SMTP id
 46e09a7af769-72c63817c41mr7360902a34.22.1743515343967; Tue, 01 Apr 2025
 06:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401133858.1892077-1-superm1@kernel.org>
In-Reply-To: <20250401133858.1892077-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 1 Apr 2025 15:48:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqFhUSu5_JiA3Z3qZACcqa+9Tdqv6DqHCq_b5HGbF7Sg@mail.gmail.com>
X-Gm-Features: AQ5f1Jofr8zmqTLSu-biMb2OPpFbWD8SIe_Bx6z1LDjkJmd0IgkQJQvudkgdI5Q
Message-ID: <CAJZ5v0gqFhUSu5_JiA3Z3qZACcqa+9Tdqv6DqHCq_b5HGbF7Sg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Mario Limonciello <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, 
	Xino JS1 Ni <nijs1@lenovo.com>, Antheas Kapenekakis <lkml@antheas.dev>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 3:39=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> When AC adapter is unplugged or plugged in EC wakes from
> HW sleep but APU doesn't enter back into HW sleep.
>
> The reason this happens is that when APU exits HW sleep the power rails
> the EC controls will power up the TCON.

I think that the above should be

"The reason this happens is that, when the APU exits HW sleep, the
power rails controlled by the EC will power up the TCON."

If I'm not mistaken, please let me know and I'll make this change when
applying the patch.

> The TCON has a GPIO that will
> be toggled during this time.  The GPIO is not marked as a wakeup source,
> however GPIO controller still has an unserviced interrupt. Unserviced
> interrupts will block entering HW sleep again. Clearing the GPIO doesn't
> help as the TCON continues to assert it until it's been initialized by
> i2c-hid.
>
> Fixing this would require TCON F/W changes and it's already broken
> in the wild on production hardware.
>
> To avoid triggering this issue add a quirk to avoid letting EC wake
> up system at all.  The power button still works properly on this system.
>
> Cc: Xino JS1 Ni <nijs1@lenovo.com>
> Reported-by: Antheas Kapenekakis <lkml@antheas.dev>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> Link: https://github.com/bazzite-org/patchwork/commit/95b93b2852718ee1e80=
8c72e6b1836da4a95fc63
> Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>  Add more tags
>  Fix a typo and grammar in commit
> ---
>  drivers/acpi/ec.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 8db09d81918fb..3c5f34892734e 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2301,6 +2301,34 @@ static const struct dmi_system_id acpi_ec_no_wakeu=
p[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHA=
N 66 Pro"),
>                 },
>         },
> +       /*
> +        * Lenovo Legion Go S; touchscreen blocks HW sleep when woken up =
from EC
> +        * https://gitlab.freedesktop.org/drm/amd/-/issues/3929
> +        */
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83L3"),
> +               }
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83N6"),
> +               }
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q2"),
> +               }
> +       },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "83Q3"),
> +               }
> +       },
>         { },
>  };
>
> --
> 2.43.0
>

