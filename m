Return-Path: <linux-acpi+bounces-6825-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC0E92BF78
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 18:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0DF1283BA1
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Jul 2024 16:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4519DF50;
	Tue,  9 Jul 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V26PpVon"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB4D19D89F;
	Tue,  9 Jul 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720541481; cv=none; b=p2NQfT5Fsquae/DwjLWBpR4C+GL5vmuzmfhoAEyYUE0SsSCgvUFzM2s94T/e1ctbigyiYqP/q3uW/yg6b2/XbsmJDiUNbYNXcNt31JoBZBy82kK/1JPrBeOngLZjtaVpTUCwv78CgDo/ia+yak9B0xovk+JwuCLZl+ollBZaWnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720541481; c=relaxed/simple;
	bh=pvfRHHMEyM4nFW2ey50I0mDkZd5H1y+Ryq0X74YEc8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCoR5N7ujOGhwZiJxVc+eVblg+bSPpG5eUOSISzq70ok1jMjGkZlSS1uj+B21JBoKM8XZ1gOFRffYLT2VO9xtBkSqT6Y4dFi1vj4Yb42wj54bf80ZLw7CImOrNaIhl5hamc0K0S2F4qMBUtPAErKPvfmE5SXGkT/wutapUXccHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V26PpVon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021FFC32782;
	Tue,  9 Jul 2024 16:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720541481;
	bh=pvfRHHMEyM4nFW2ey50I0mDkZd5H1y+Ryq0X74YEc8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V26PpVongjNya1kz3lRNhrzSK2NW+jIW7dVqbEaGJZ1GAZu/GaE7SctU7MkBfNkT3
	 Vu2muCiJk/ZUwhlklWGK2nnQds85/d8LiDbfkr87O5G7M/30PcEFDumPKE2O4/3KC1
	 x6gVSAxFOZMgebHc6SoJv2BqBeImEzsQIt4xPx7Fe+44o3t92cBCk2Zx/PPzdHBllW
	 Kj7B25C8iD+LEYdYrM13xlNrVQjInaIBXvauz4UvQ6FdJr6LOMNcSaf2HO3mgAdGL4
	 ltuuyRasJVwkV7gzQyePXDpykHSiSQo4QsRO9KoQGL6Y5RJQwuy7fFzUY9vkmZkDNA
	 IVbdd6QEuuXkg==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5c6927d1969so24969eaf.3;
        Tue, 09 Jul 2024 09:11:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNOdGVXghVHj/9o+KrXk6GUVJE4KyUmJwReMp6LaZRNvhaAoFr2Khdyn4aigaNenwBmwYf6Uf4bNhicosae43qewKtfP2XtuRD0ie2r3lXRIkVnZIGvAtMdLPxkvMhcfm/fe4CA5aK3A==
X-Gm-Message-State: AOJu0YxYc7igQwmSdHaDi3M0+xnzK6LCJIbZeEzPzrqru8MN50qgLHFn
	zlNF0B5KHo5IT7Tu3Jja7oDOT917Zww70UtnSM3u2A8mlL3yng+bFzYDId1ySSmfCe8bD6x2fGL
	N+v0rV9uq0x/y0+tTsmSRcF9Lwvc=
X-Google-Smtp-Source: AGHT+IEjFhar5iSXGYsbrr8yTaAt03wty+C0y+fzLa16Zwp5Jlz/ssboxHdbqYeG7dM2MHL+s5c5uOR7zXkZAt+BYfE=
X-Received: by 2002:a4a:a28d:0:b0:5c6:6abd:b46 with SMTP id
 006d021491bc7-5c68e12a3efmr2835317eaf.1.1720541480321; Tue, 09 Jul 2024
 09:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705191835.152189-1-thomas.andreatta2000@gmail.com>
In-Reply-To: <20240705191835.152189-1-thomas.andreatta2000@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 9 Jul 2024 18:11:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iDPiz3Q-eu5AaKmi39xfxUNYPnWvpjCQCvgK_evEJ8-w@mail.gmail.com>
Message-ID: <CAJZ5v0iDPiz3Q-eu5AaKmi39xfxUNYPnWvpjCQCvgK_evEJ8-w@mail.gmail.com>
Subject: Re: [PATCH] Staging: acpi: fixed a coding style issue moving from
 strcpy to strscpy.
To: Thomas Andreatta <thomasandreatta2000@gmail.com>
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Thomas Andreatta <thomas.andreatta2000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 9:18=E2=80=AFPM Thomas Andreatta
<thomasandreatta2000@gmail.com> wrote:
>
> fixed a coding style issue moving from strcpy to strscpy.

This is not a coding style issue and the change below is not a fix.

It just replaces strcpy() with strscpy() which is preferred (for some
reason that needs to be mentioned).

> Signed-off-by: Thomas Andreatta <thomas.andreatta2000@gmail.com>
> ---
>  drivers/acpi/ac.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 09a87fa222c7..f4b5ba033df8 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -213,8 +213,11 @@ static int acpi_ac_probe(struct platform_device *pde=
v)
>                 return -ENOMEM;
>
>         ac->device =3D adev;
> -       strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> -       strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
> +       char *device_class =3D acpi_device_class(adev);
> +       char *device_name =3D acpi_device_name(adev);
> +
> +       strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME, strlen(devic=
e_name));
> +       strscpy(device_class, ACPI_AC_CLASS, strlen(device_class));

The last argument of strscpy() is not necessary in both cases.

>
>         platform_set_drvdata(pdev, ac);
>
> --

