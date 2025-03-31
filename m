Return-Path: <linux-acpi+bounces-12552-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4801A76523
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 13:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CDB0169E7A
	for <lists+linux-acpi@lfdr.de>; Mon, 31 Mar 2025 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5755A1BEF77;
	Mon, 31 Mar 2025 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fEYtBSlO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23F3FE4;
	Mon, 31 Mar 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743421582; cv=none; b=mvQ3Qw/uL7wzLmoKO9hsQzsjR1PpRmErQn5cLUDo5E5cmu8Ne7GE47fD5B5Dw+ikVTjb9Z++ociFLkJHgLk42QC8OcXZXXuLbm1E389KR0E6nwUZE19Vklt/tctQKgvICwWtMhBpRkGDigKbecPnOCSg9lEWKF1qLCgVUg2rLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743421582; c=relaxed/simple;
	bh=u9p15OXm9QZMTai0Gqz2IJw0gWsmXXWW9BWXZRpKvQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUMJ6dHVCr0nG/CKAZrnUEfNc56WrprzTllbgjlzagcOZ4xjQFJrTf2Jl6E2WF7Q+ScRwjBdoqJ4G24z+Y1emZ+lc/Otz03PfQ7RBm+vR4F1gmEkmHF5notG7iI8v4t0noIDi3EB/vN1LuRcEvJ1gFMoJ92hX4cTiUZdiyqIbfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fEYtBSlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E01C4CEE3;
	Mon, 31 Mar 2025 11:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743421581;
	bh=u9p15OXm9QZMTai0Gqz2IJw0gWsmXXWW9BWXZRpKvQs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fEYtBSlOFmnS9FWcnFnLjzCgnlu7b2kKqKIw2MwC6epbB64lpGjYpJAzNDcFNB64d
	 HUL8cagWLDUpWkuXxeFhxZLJpgfy2SCg/zth7Wwh2VcSiUj40U1h224UBYOcH/Vo0r
	 G+i3rMyfJePmIQ8SNvkS17L8STUl8Akw+9AI7u9PDNbXdYCX2+yTkuH0xOww4qffQ8
	 DfkhtlfzOSqW7Bku5XGtGFvPaPQ6qON/iKiiWDGqN8VU7KVxEvGzxEx95NSGmjXFoB
	 8S/nWukTs0YkAMte1jcgd+H2GXgvA4X0vFOPs7alu9LjcHt3eWFFJRNU0QoJpOmpaZ
	 EeeJT6Af9u53g==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2c764f2c223so1023045fac.0;
        Mon, 31 Mar 2025 04:46:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUK6nq4ZBAayyJh/9U+8BK4UjThOYTo9H7l5x8U+q1EOJvGe3BGE1bvv8vfL5nPAZylcE6EkKGlSP0i@vger.kernel.org, AJvYcCXaZYuzOd+VD46e2RN5HcanvqvoIXv9LLKB3lcG6TXl7aUOVcvQ4L/VUgB0fkd6ZYEzO3hd38ZYYOvMVUww@vger.kernel.org
X-Gm-Message-State: AOJu0YxOeuzYwcNYJbNbVQ24GvS5wwkJpUvH6zXSRpJxcgAKJgfSfL2d
	bmMCOZ7i8jTJ4Lz7UyYkbf4cTB7BnOeRMOuAQyiFIYzRToOd1ckFYH5jQ3/DNvS9eWGWjQJp2yM
	VBgLIdMvgGrtO8bAcpyszlLkhXo4=
X-Google-Smtp-Source: AGHT+IGLHSPjnj0ONYF56bwe4e8CV95FtIHFoYEUDj6FI0sTgHCoDe9OUqqcTrF3/hupBFyV4rvUitZaUVoNtiZpj4k=
X-Received: by 2002:a05:6870:418d:b0:29e:255e:9551 with SMTP id
 586e51a60fabf-2cbcf474c3cmr4598743fac.2.1743421580976; Mon, 31 Mar 2025
 04:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
In-Reply-To: <61c3df83ab73aba0bc7a941a443cd7faf4cf7fb0.1743195250.git.soyer@irl.hu>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 31 Mar 2025 13:46:10 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
X-Gm-Features: AQ5f1JpzlMUyTy2jsegu95KUagJIz4NmCHKhw5-yyzojW0dsktwnVlH68O3aG4M
Message-ID: <CAJZ5v0jBONZ7UFL0HCOV=7xmnUphL_UTV=_1PnYmR6n0oN4pcg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: video: Handle fetching EDID as ACPI_TYPE_PACKAGE
To: Gergo Koteles <soyer@irl.hu>, Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, Alex Hung <alex.hung@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
	Alex Deucher <alexander.deucher@amd.com>, linux-acpi@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 10:09=E2=80=AFPM Gergo Koteles <soyer@irl.hu> wrote=
:
>
> The _DDC method should return a buffer, or an integer in case of an error=
.
> But some Lenovo laptops incorrectly return EDID as buffer in ACPI package=
.
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
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/Apx_B_Video_Extension=
s/output-device-specific-methods.html#ddc-return-the-edid-for-this-device
> Cc: stable@vger.kernel.org
> Fixes: c6a837088bed ("drm/amd/display: Fetch the EDID from _DDC if availa=
ble for eDP")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4085
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
> Changes in v2:
>  - Added comment
>  - Improved commit message
>  - Link to v1: https://lore.kernel.org/all/4cef341fdf7a0e877c50b502fc95ee=
8be28aa811.1743129387.git.soyer@irl.hu/

Hans, any concerns here?

>  drivers/acpi/acpi_video.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index efdadc74e3f4..103f29661576 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -649,6 +649,13 @@ acpi_video_device_EDID(struct acpi_video_device *dev=
ice, void **edid, int length
>
>         obj =3D buffer.pointer;
>
> +       /*
> +        * Some buggy implementations incorrectly return the EDID buffer =
in an ACPI package.
> +        * In this case, extract the buffer from the package.
> +        */
> +       if (obj && obj->type =3D=3D ACPI_TYPE_PACKAGE && obj->package.cou=
nt =3D=3D 1)
> +               obj =3D &obj->package.elements[0];
> +
>         if (obj && obj->type =3D=3D ACPI_TYPE_BUFFER) {
>                 *edid =3D kmemdup(obj->buffer.pointer, obj->buffer.length=
, GFP_KERNEL);
>                 ret =3D *edid ? obj->buffer.length : -ENOMEM;
> @@ -658,7 +665,7 @@ acpi_video_device_EDID(struct acpi_video_device *devi=
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

