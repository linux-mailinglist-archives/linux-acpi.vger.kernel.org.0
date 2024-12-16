Return-Path: <linux-acpi+bounces-10155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31049F3AAF
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 21:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EF9188937F
	for <lists+linux-acpi@lfdr.de>; Mon, 16 Dec 2024 20:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905091D4340;
	Mon, 16 Dec 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dD5kghWk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF8C13D29A
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 20:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734380630; cv=none; b=Rap/QCba3NiO4P4D4SWFjAc/oMD9yo9wNdbWqJG9Ll3fwlqQ6X9Flce5k6OhtWZFCvCADTjnW0n4SY5og3yGIFOe0Sz43gylNBdS/UxCRAsLGQcO8jmVx00/W++XBBX8neH4+vkVNeqHd8wGXwQk8DPRT5YUuwKZdXKAmgQ4K84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734380630; c=relaxed/simple;
	bh=tvnoFuXEaVOvSd1qeGMuaI3RTP+db1p57NYzO2Dz8yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMUP2ZV+X38h58NIsFBAoYRgiJ3CnX+PrqVy76dwhbEdJH1TmxgHALcRUMj7msQWhn80L76MRbX2fqMYrhXP4J3tRJobA3Yg6Gs56VEAkvd+nlHCQFLmdRTh8+311sbL6LtzvlGdH+xEdujOCA7fUNwkwaYmfW92gcH4dp60GaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dD5kghWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0ADC4CED0
	for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 20:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734380630;
	bh=tvnoFuXEaVOvSd1qeGMuaI3RTP+db1p57NYzO2Dz8yw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dD5kghWkZDKJcM6Jw0rwEYyK6VeYvPb3yz/DhV3gk4HVML1ljQ4E0a1mw43146KvK
	 1ifrWpdEvf7VJ4DBSxn5eMMkKvNEFaPPv80HrkHE7G4UGnvua6r7h9wrc2xoveAess
	 +WkkBhwUyKtCkL6/Zwx6++f9R27md92hHTF69M7ngOgbII5oy7DlkZHkqW+mg9spQz
	 OgHljc3nz5nRHkPeBIuMno4GYVCjPuqiNpqm+wqisbcOPntQfVioFySRzS3EuXWBlD
	 E6aYX9AEkjksz+59QeK/zvV46WgDbdZjkqoMlPozToLiUnU9xNBvPsJv/Qh1Bh/i3L
	 8ozLLwwqyFa8w==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3ebb2d8dac4so1543982b6e.0
        for <linux-acpi@vger.kernel.org>; Mon, 16 Dec 2024 12:23:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtg6BPrBGHxmb728YMCRjEyN87XkrDNGco4++OaS7lDd6HWADSYbUQnr6gNrarpL2ny1DVrUKGEU4G@vger.kernel.org
X-Gm-Message-State: AOJu0YwTzC++GIjE8Tvg07e95mpMYuG8JqEsxCU8iE86KquPtqMPAIdz
	OZtoyuBmN4N2CEOfGLcMEv6ZhJmhnmmvWU3HaASM9NezwVGLfz4fjnRjoYLL1icEBPRYcdptxDl
	XB+DEHjupJqKAkmJ2dH0zK05IDws=
X-Google-Smtp-Source: AGHT+IFO4JxMc19olyI23/wooa+idWqoGBaK+OlKAFvgreRahwi2HVlwEPY6F5Ac7lXAHbgNFbhjF2xGlVhIx1OQ/js=
X-Received: by 2002:a05:6808:1805:b0:3e6:5522:b333 with SMTP id
 5614622812f47-3ebcb2f190bmr119973b6e.22.1734380629349; Mon, 16 Dec 2024
 12:23:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211032812.210164-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241211032812.210164-1-joe@pf.is.s.u-tokyo.ac.jp>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 21:23:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0id1irg3ByJNgREv_59-ekh3WmCRbQ7wbiHx92sTosEgQ@mail.gmail.com>
Message-ID: <CAJZ5v0id1irg3ByJNgREv_59-ekh3WmCRbQ7wbiHx92sTosEgQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: fan: cleanup resources in the error path of .probe()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 4:28=E2=80=AFAM Joe Hattori <joe@pf.is.s.u-tokyo.ac=
.jp> wrote:
>
> Call thermal_cooling_device_unregister() and sysfs_remove_link() in the
> error path of acpi_fan_probe() to fix possible memory leak.
>
> This bug was found by an experimental static analysis tool that I am
> developing.
>
> Fixes: 05a83d972293 ("ACPI: register ACPI Fan as generic thermal cooling =
device")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> ---
> Changes in V2:
> - Handle the case when the "thermal_cooling" symlink creation fails.
> ---
>  drivers/acpi/fan_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 3ea9cfcff46e..10016f52f4f4 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -371,19 +371,25 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
>         result =3D sysfs_create_link(&pdev->dev.kobj,
>                                    &cdev->device.kobj,
>                                    "thermal_cooling");
> -       if (result)
> +       if (result) {
>                 dev_err(&pdev->dev, "Failed to create sysfs link 'thermal=
_cooling'\n");
> +               goto err_unregister;
> +       }
>
>         result =3D sysfs_create_link(&cdev->device.kobj,
>                                    &pdev->dev.kobj,
>                                    "device");
>         if (result) {
>                 dev_err(&pdev->dev, "Failed to create sysfs link 'device'=
\n");
> -               goto err_end;
> +               goto err_remove_link;
>         }
>
>         return 0;
>
> +err_remove_link:
> +       sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
> +err_unregister:
> +       thermal_cooling_device_unregister(cdev);
>  err_end:
>         if (fan->acpi4)
>                 acpi_fan_delete_attributes(device);
> --

Applied as 6.14 material, thanks!

