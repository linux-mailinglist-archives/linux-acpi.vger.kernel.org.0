Return-Path: <linux-acpi+bounces-16047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42482B34999
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 20:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B7321B24732
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B00B3074AD;
	Mon, 25 Aug 2025 18:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUfUqNrl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639772877C0
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 18:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144898; cv=none; b=NxQ7rtsgYKACTeUF9rUD2V6IQq+QM67tqvR4QywCm+G3SFHq7tmkqui4XflzwjHwUPfqfrCEzek+tfKGBL6FwNj2b7zNXCFJaK1kGVIAkvarevPWH2Kygqg8BoPhFdpX75oxN8ZiBtm981K6L6JCxEJJ4fx1ATmTopUlEDyX3VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144898; c=relaxed/simple;
	bh=pz7h4icuKqwJqBNvANYAdEzlMNzdDaBsdX2lVmKZmnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cSuiRWqbhBwr2US0w5qxBTYtUKEzRo//0oePtyRu6mHhXz7yAKw8T3BzAUaLehXP2mxu7oCeTllTZchKQo+bGB0Mm1/rqLq8sbqodH1y4W792uauwUTOUlCaFstmQJr77eMesdSb4fkxe9p1MwkkqYeHtR0JgIA6+BK2keFq+2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUfUqNrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07F7C4CEF1
	for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 18:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756144896;
	bh=pz7h4icuKqwJqBNvANYAdEzlMNzdDaBsdX2lVmKZmnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LUfUqNrl9MDcMvMso86XgtDke0zE7WiQnmhE+8l4UwxVkkuwuZTiEa1+plvay0zqZ
	 CU6drgmkTQG4k/T/DYih7OPKMn2jRwXhibeps8qFLcpieT7AKfktMOo3q+ZCxpbMen
	 RtKud0HZIKb3uoAnz8bCdh9N/8XJANn4l62po3LAsNBoXCGDkpLCYQotV1g5mZbpvc
	 CM/a3U5W3cjoU6MVHGbMySgW89qWvRQu4i9khijJbmzNlg3Dcqtn08HlOBFtLrbjp2
	 PlkCgCAvTuS0EEFuJNdg0IeV2W4nzNHPWtINB2woAXVJsXlMepyRrXkiazzJYRfYwc
	 1PeWNIkW0JkvA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74374a65f35so3385195a34.1
        for <linux-acpi@vger.kernel.org>; Mon, 25 Aug 2025 11:01:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVHccbvkpNJObv5JYHrDFxjJ5ItUCOCtkeF3XxPMW2LducnMh6GiJF/JiToPzs44ZEGgeBJYeXyY4Af@vger.kernel.org
X-Gm-Message-State: AOJu0Yywiz5TXViZU+Tuyu8VHlHDIXNdaGeplm+zEnssMG0G3vt/uWLd
	5tM93CEAYT0LkJXY1742Mxw7266Xr6+2QSf/9K3CO9MHQKezXZkxavn6D+mTVYjnyS+CQCNvr+d
	uqBtZI9TfZYZyMy4Xwf2P2u2pM12EVtc=
X-Google-Smtp-Source: AGHT+IH8hMYNv2zane8uBTy4c5ZoLqGECDzCGqRoheISNkb/hzYGB+rJAgQYw90nto8i/pM+aC5zaE70FmFTuCZYptE=
X-Received: by 2002:a05:6808:6708:b0:437:b5a0:ca7b with SMTP id
 5614622812f47-437be02adc9mr292296b6e.12.1756144895822; Mon, 25 Aug 2025
 11:01:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820170927.895573-1-superm1@kernel.org>
In-Reply-To: <20250820170927.895573-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 20:01:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g8wKd_QGtb-dL7boCKF6UGaDZejy97cNtyRe9-egLP_w@mail.gmail.com>
X-Gm-Features: Ac12FXxCLdhtocX4-9zLLAB7FSDveKWf-928UsZw_r75ymN30rsPtwhOSe2tgmA
Message-ID: <CAJZ5v0g8wKd_QGtb-dL7boCKF6UGaDZejy97cNtyRe9-egLP_w@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: force native for Lenovo 82K8
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	Daniel Dadap <ddadap@nvidia.com>, Hans de Goede <hansg@kernel.org>, 
	Wilson Alvarez <wilson.e.alvarez@rubonnek.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2025 at 7:09=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Lenovo 82K8 has a broken brightness control provided by nvidia_wmi_ec.
> Add a quirk to prevent using it.
>
> Cc: Daniel Dadap <ddadap@nvidia.com>
> Cc: Hans de Goede <hansg@kernel.org>
> Reported-by: Wilson Alvarez <wilson.e.alvarez@rubonnek.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4512
> Tested-by: Wilson Alvarez <wilson.e.alvarez@rubonnek.com>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index d507d5e084354..4cf74f173c785 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -948,6 +948,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Mipad2"),
>                 },
>         },
> +       /* https://gitlab.freedesktop.org/drm/amd/-/issues/4512 */
> +       {
> +        .callback =3D video_detect_force_native,
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "82K8"),
> +               },
> +       },
>         { },
>  };
>
> --

Applied as 6.18 material, thanks!

