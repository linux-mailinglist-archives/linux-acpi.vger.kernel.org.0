Return-Path: <linux-acpi+bounces-5641-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFCB8BE152
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 13:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A0F1F22FA4
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 11:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058D153809;
	Tue,  7 May 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njLZyg7m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EC6152DF5;
	Tue,  7 May 2024 11:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715082303; cv=none; b=evSyDoedgBuL5vk9BamPXO9cEZkN86S1pY/R29FG92bypy9B+edysXW+RY7UD9Xvlirht00+OJviMf9uN1HykYZTBJYl9tT7Yola8v3GSSQF5hPIuKBMjVYWx+wr5fB9lqPo3lTb0EhDnAokmTsaKFeEOwvc6IjwsWmfqDIDtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715082303; c=relaxed/simple;
	bh=yRrP8pE+cnSBCXddwAV+0wggGCo/3qBnwVjy9lG0DIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fo3riWXcnwa/4UrWBgij8s4oxffD9BCmJ5Iz/gtREztPAZpzIveHASzViIZ4Qx0LOabxJmYBiQC0IhvyAg0rIwxQt402xUwj1l7/RchF1e0Kwf7J0HxUK0TzMDbdtMyoHKjopRUIrX/ae4Zm15Ej2N7Dm23x0pZLm/cE4p9FM6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njLZyg7m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A111C4AF63;
	Tue,  7 May 2024 11:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715082303;
	bh=yRrP8pE+cnSBCXddwAV+0wggGCo/3qBnwVjy9lG0DIc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=njLZyg7mEGBsO3m/qUFsP4vDq62ehhq0lIHdF+VucBnhhXyIgj6YL0kcnufHKtsiB
	 sk6qNur6tlRM41gCqY6WMNwXhoMDMVk0XakrkwU6REBIsmlRKFdP8UDrCYV1d1NFpI
	 7k2N/lNme4dV6R/J6TYOwoFZjRJE+U5RqEOvZG8xNxBeCezVHu4hzT4yWzL8vlZZDf
	 MnMpKmvqsK0qu8M0B1IYcIamQVTdFdZtjQNGKGHPAPlre+jZ8NqzmzWQNwtQv4xpmZ
	 xNFQWICaSr6A95KGe108NGshyHDY+xa1q7tYjwGdAiTr71xTaGAq2X5qjdmB6ZwnzQ
	 Fcjwimcgp7nmQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5acdbfa7a45so940542eaf.2;
        Tue, 07 May 2024 04:45:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMeucH20J1wgTRf2GhMx128DVW5klLfJRLWcJ8VvQNahWjBY7vtUeqlpOIGxpbB5LOKIHk6ltWo+IGimgW0iWnr5uQZcPIvmU6ar3XZI3O6WCQpc6DC+SA55QT4kWcZhzajXzzALwAQw==
X-Gm-Message-State: AOJu0YzBM3U5aBpAfODjz1gQCI+YcOe0LuJCh5/zDPZqNY/lStYow+yJ
	fMBTPoMZUxYL8buUNfAw+LOaUY7hFGo2u7NqpDCXiPTuGV8vkpKwZmCLLgPmCsFMwFJVmcdex2Q
	Ubn/oQSwOeQOt+OKZugde6LpvveE=
X-Google-Smtp-Source: AGHT+IGujf0HE2s52vBaVtFJe+W6PCGHX/xRpuc+C1tN4ht2ZVbTCa6YrYMAqAxvip7nOK6smp2xCH+v30oZEFwW39Q=
X-Received: by 2002:a4a:b6c2:0:b0:5aa:3e4f:f01e with SMTP id
 w2-20020a4ab6c2000000b005aa3e4ff01emr13215058ooo.1.1715082302489; Tue, 07 May
 2024 04:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506140906.26034-1-tiwai@suse.de>
In-Reply-To: <20240506140906.26034-1-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 7 May 2024 13:44:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g0gaHQ1VxKgJYZTyEEd3foQXm315eWFoOM2U8mZpCQgQ@mail.gmail.com>
Message-ID: <CAJZ5v0g0gaHQ1VxKgJYZTyEEd3foQXm315eWFoOM2U8mZpCQgQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native quirk for Lenovo Slim 7 16ARH7
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 6, 2024 at 4:08=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> Lenovo Slim 7 16ARH7 is a machine with switchable graphics between AMD
> and Nvidia, and the backlight can't be adjusted properly unless
> acpi_backlight=3Dnative is passed.  Although nvidia-wmi-backlight is
> present and loaded, this doesn't work as expected at all.
>
> For making it working as default, add the corresponding quirk entry
> with a DMI matching "LENOVO" "82UX".
>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=3D1217750
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 9fdcc620c652..2cc3821b2b16 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -497,6 +497,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
>                 },
>         },
> +       {
> +        .callback =3D video_detect_force_native,
> +        /* Lenovo Slim 7 16ARH7 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "82UX"),
> +               },
> +       },
>         {
>          .callback =3D video_detect_force_native,
>          /* Lenovo ThinkPad X131e (3371 AMD version) */
> --

Applied as 6.10 material, thanks!

