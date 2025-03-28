Return-Path: <linux-acpi+bounces-12523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C99C0A74900
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 12:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C20667A91AC
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Mar 2025 11:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A478B21517B;
	Fri, 28 Mar 2025 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEBnl8bH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD3214205;
	Fri, 28 Mar 2025 11:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743160352; cv=none; b=GKNpDi0DsX9iAApzKQzSGXH3mF9cZXLkPWiK+5RmDG133gEPlHalgQHgqkDDhLMzPBkRZRbO/KhQwiFX7ZKQk7oOot/TcAEqW5So6iocubKYUjuf8vdYSi9wt7isFKGzzWadS/HsFPRWv+Efb4sQwnVKKJCowH+rv75N01pMKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743160352; c=relaxed/simple;
	bh=tdiV8jooMBZ2aJx8rltIZQeVkN+R4v7ZLa2bFv4yEZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3PIWvAs/jIML5Q3CGOvim/VsprTEdIvnGjESMbQ8xo7Atc7u3dGhwHbmVabh2TjKUwcHjFt5tF6LObwCplmBQldplfjB4j8cRjcOQdE7gW0gxZUhybHDsvMY5KybavcPoKVLxMpInhtEiWukgZbelbV4gU6c1E309NGofO5Row=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEBnl8bH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FFEC4CEEF;
	Fri, 28 Mar 2025 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743160351;
	bh=tdiV8jooMBZ2aJx8rltIZQeVkN+R4v7ZLa2bFv4yEZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=IEBnl8bHhJyioeIdHEH9lY67XRAKZbXsAPEoB9lg5k+DMyKnQf5IfivG9qr6UWHej
	 iRdG0WCc3CweksF1PK8aDHqLjACVstWABUNSj7+8m+wTVBiD3FoNNCWbWLrXf8NR/W
	 x+8WnPCyxjY/TDS1kvUl3W37f0ezQWhKGia4tAYFaSH9TmZJYuD6n86Ev6e0AEe+k5
	 7NSr4lEjAWFwd2XzNgiYSy8nz1PgvcxilfcX6+mlilMgeosp86xL5fJkuAVaNVO9yl
	 otRR3a8TLyxGN/K+wqpRrp4VQj61+oaoZChQoaHp8Us+CUHcjEGZP9J0EtNl7b9gT0
	 e9jlZ4NbPvH4w==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3f8d2f8d890so1213121b6e.0;
        Fri, 28 Mar 2025 04:12:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvXlUchlWDvpn/r9KWlT3IIjkvArIwjCj8UtSLN2I4423HK8C2zDzSo8VirYPsh/7inmSRhNoOx33Y@vger.kernel.org, AJvYcCXyq2OZh0pPKyaHqzvUiw5HJ7VMX5+aBGJjTFZJhObwHoRBBv6cc5+OoKwa89zsCaDzTcfkUgwChjllZpSK@vger.kernel.org
X-Gm-Message-State: AOJu0Yy863+cExLAxDBuTbghb5h6uwL8nBzLK0gvCtzuWhHNXmKcNU93
	dk/cc9hfPeXmy+0hA0CkUZQ+E0wcYumvcb+4RZvUHo6b1zhcfYHRN3dkYo8lfHfGD0pmSRt2S8Y
	KGzEhJTIAvTHLFSn5hj1IwMMCfGg=
X-Google-Smtp-Source: AGHT+IEBc+PzLf7kQyxJxN660tXPVD8Ng9hOTrCSQoAZZFYeWPUf39m1FWqMoEkTz6Jp39FXpjE7W9d+1x3MNw5s7Jg=
X-Received: by 2002:a05:6808:1524:b0:3fa:3d63:ac58 with SMTP id
 5614622812f47-3fefa54d450mr4877883b6e.17.1743160350106; Fri, 28 Mar 2025
 04:12:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
In-Reply-To: <4cef341fdf7a0e877c50b502fc95ee8be28aa811.1743129387.git.soyer@irl.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 28 Mar 2025 12:12:17 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
X-Gm-Features: AQ5f1JoH6FMgp2NUlC4f-9Wruph1kv2VPl-kjHMMoGcMuzoeBNdH473Vgx71Wpo
Message-ID: <CAJZ5v0hAZ6nYbQ7M5BPbkeMh2_VQFdonBdrFYOfGbq3Y_Kh51w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Gergo Koteles <soyer@irl.hu>
Cc: Len Brown <lenb@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	Rodrigo Siqueira <siqueira@igalia.com>, Alex Hung <alex.hung@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

CC: Hans

On Fri, Mar 28, 2025 at 3:51=E2=80=AFAM Gergo Koteles <soyer@irl.hu> wrote:
>
> Some Lenovo laptops incorrectly return EDID as
> buffer in ACPI package (instead of just a buffer)
> when calling _DDC.
>
> Calling _DDC generates this ACPI Warning:
> ACPI Warning: \_SB.PCI0.GP17.VGA.LCD._DDC: Return type mismatch - \
> found Package, expected Integer/Buffer (20240827/nspredef-254)
>
> Use the first element of the package to get the EDID buffer.
>
> The DSDT:
>
> Name (AUOP, Package (0x01)
> {
>         Buffer (0x80)
>         {
>         ...
>         }
> })
>
> ...
>
> Method (_DDC, 1, NotSerialized)  // _DDC: Display Data Current
> {
>         If ((PAID =3D=3D AUID))
>         {
>                 Return (AUOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.AUOP */
>         }
>         ElseIf ((PAID =3D=3D IVID))
>         {
>                 Return (IVOP) /* \_SB_.PCI0.GP17.VGA_.LCD_.IVOP */
>         }
>         ElseIf ((PAID =3D=3D BOID))
>         {
>                 Return (BOEP) /* \_SB_.PCI0.GP17.VGA_.LCD_.BOEP */
>         }
>         ElseIf ((PAID =3D=3D SAID))
>         {
>                 Return (SUNG) /* \_SB_.PCI0.GP17.VGA_.LCD_.SUNG */
>         }
>
>         Return (Zero)
> }
>
> Cc: stable@vger.kernel.org
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if availa=
ble for eDP")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  drivers/acpi/acpi_video.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index efdadc74e3f4..65cf36796506 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -649,6 +649,9 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
ce, void **edid, int length
>
>         obj =3D buffer.pointer;
>
> +       if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.cou=
nt =3D=3D 1)
> +               obj =3D &obj->package.elements[0];
> +
>         if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                 *edid =3D kmemdup(obj->buffer.pointer, obj->buffer.length=
, GFP_KERNEL);
>                 ret =3D *edid ? obj->buffer.length : -ENOMEM;
> @@ -658,7 +661,7 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
ce, void **edid, int length
>                 ret =3D -EFAULT;
>         }
>
> -       kfree(obj);
> +       kfree(buffer.pointer);
>         return ret;
>  }
>
> --
> 2.49.0
>

