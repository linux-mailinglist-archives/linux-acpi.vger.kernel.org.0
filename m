Return-Path: <linux-acpi+bounces-8220-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C09741D3
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 20:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F62FB22CF7
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Sep 2024 18:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1297416EB42;
	Tue, 10 Sep 2024 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh2Kmc4s"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A023774
	for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2024 18:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725992177; cv=none; b=biA7f6g0hYH+jNnms079IoOtbcHlCbNZd9A/JHmbXU0yDViYoghz5FI3XTM9bfxh8anrKY3doEtPl+v3DO0IhGx7iPYj/L/DqGS8Zic4SBW8HsgxmCn46YUYBCEedkYj8UxVmsMDzyUNCZZ2ilgFXObWsXKrAZ+Y4j7evCQsfuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725992177; c=relaxed/simple;
	bh=5E0uKI3purU3n9/JjaF6uO+5gyT02LKgmVrMIYMlSwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2PhTsMB/tXv2Sx8SRwHxP8X9LcoGD0Y0fW8h9TLc5UTg9vicqbdTgH/OVOOwtkBedxUQbYiHaDiZ9rkppPXKBbOzwviuHR9gjiQ+GnKf41A7ETzv6z0YC1bPU/bgidJLtnW7A9wUSCqw3f3twuLVszzaHZyktGAvB3h63U2dJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh2Kmc4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79290C4CEC4
	for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2024 18:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725992176;
	bh=5E0uKI3purU3n9/JjaF6uO+5gyT02LKgmVrMIYMlSwk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Hh2Kmc4sTdIAJ//0JakYYvpQYVmCPFy3uXLA/Duf2Td/t3xKfK4rhlqZBzgmMDydR
	 5n2FIuop8LcuVqYLY7SHyLVOkIGRp2MNrWj2LzsSPrYwBlDVAP0xEFTw2xS07fukml
	 g6WI8rvQ7MjRSAos7AQyxFIk6qIsJIwnUc6qVjB7iTHygCW7CzUo40Cv59+5uFx2Qc
	 ZrxPPWwaINrMSm6bKmsRfgmrZVq6glMLn22YzYZoW123vaAbJfByC0JBgiZN8b395z
	 tBL3hbAIPLBfrtc69LYIdWPwYuJrWiWU7WYPQM1GhDr1Ji8873WUSKlEvXN8WoPuuG
	 bccmJc64Pp/xA==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-2781cb281abso563619fac.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Sep 2024 11:16:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWQSo5SC8Zk7bKH9Yf+rCsD/HUOEUR+z5hiMF943IQNYvthvDTfz1LiFGdq+7y+4JnxM+jTM1mnqdJ9@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDriMFIeLEyoLklJts0jL8fboP39Oo66HvGrPGsupquC9Rjei
	5hZAVADuyVrhGIGPmKQ/3rUqznnIrzsxYl49gtBy2baC5uqotgimC3IL9hGhtrtx0vZ18QrErHE
	qyH3NyPReZkjK36DO8LMuFr/o6hg=
X-Google-Smtp-Source: AGHT+IG7ZMTJaSE0LJyTTjfYh9Y+8ns5Z+ktE/m3zAj+l0ILS30KdhewU5ICae10240ofl3vuaqoeKnpeLrwIJPXA5s=
X-Received: by 2002:a05:6870:350b:b0:277:ef2f:3dc with SMTP id
 586e51a60fabf-27c1b7d71eamr604122fac.33.1725992174755; Tue, 10 Sep 2024
 11:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240907124419.21195-1-hdegoede@redhat.com>
In-Reply-To: <20240907124419.21195-1-hdegoede@redhat.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 10 Sep 2024 20:16:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0is3pnBseDb5WjWKTucei4+MCRrueUhYnX=1L-KqHHF+A@mail.gmail.com>
Message-ID: <CAJZ5v0is3pnBseDb5WjWKTucei4+MCRrueUhYnX=1L-KqHHF+A@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add force_vendor quirk for Panasonic
 Toughbook CF-18
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 2:44=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> The Panasonic Toughbook CF-18 advertises both native and vendor backlight
> control interfaces. But only the vendor one actually works.
>
> acpi_video_get_backlight_type() will pick the non working native backligh=
t
> by default, add a quirk to select the working vendor backlight instead.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index e33ab5a2f489..68afdab5d3ab 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -254,6 +254,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "PCG-FRV35"),
>                 },
>         },
> +       {
> +        .callback =3D video_detect_force_vendor,
> +        /* Panasonic Toughbook CF-18 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Matsushita Electric Industrial=
"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "CF-18"),
> +               },
> +       },
>
>         /*
>          * Toshiba models with Transflective display, these need to use
> --

Applied as 6.12 material, thanks!

