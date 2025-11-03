Return-Path: <linux-acpi+bounces-18457-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E087FC2CFAA
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 17:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B731883676
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 15:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31AD314D1A;
	Mon,  3 Nov 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRP4vZgv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99945314D01
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185527; cv=none; b=P7vzOqF3gGlYAMGXfN7YV66pGBpSa44CKlPVStkCGfHrlpb+FEPuTlsaHEtR14hd+3LmTvQ0VPnF5kaN36QUnHtc+IoXQJJ7EEGm5YUFI6Igf1MdkNRYSNV6zTcPbZVk29LYwWdCgj0GnFdBltmIaUVKHgQfVkyE8ad6kk0afeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185527; c=relaxed/simple;
	bh=6sNwot6c2txvkTTgDc9KqDSKoc5ES2W0Sdcj1U9hQJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gVP61uYWu6SBX13dXnJRVCnQgz6wv08Jcqb1roRKSyTSBcVlzzMrh/ap/SzfKPN0i/1PZ4+hU232bfwY6j4NvWsi0/WRz9//6bC2q93PruOXRo39Jy0UcBQdDCA83/CbiwYi6Rvh6mJ4OZePUYkk0MFabZ3dPUo2ps0qN5JITQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRP4vZgv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C6C19425
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762185527;
	bh=6sNwot6c2txvkTTgDc9KqDSKoc5ES2W0Sdcj1U9hQJQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RRP4vZgvbly2iVnBkpHAfvJkKm9R3PnEmZDFgWBlUUJQ24qHfz99F2W++Fr8+8hwa
	 gIW2BXDp0J7E9DJaHdcVMni2Cmg9dErptRaTdWhP6ieWjfD46khLAibz7Ef7Py/q7u
	 amcZLJjdv2A6PBkF3wtouCOfz/bWAu/mn5Q7uCc1Fp3pGAIHiiRPHjNoVB1A+Zzy/N
	 MGkmuEuoO3WJqifG+KFDvQHVKboeB7zJI4XJv/rGz4EIC8E0nQL78NzeutIkskYtX8
	 xWwV4U4bBwZ/b38D4abX40hMnMblfeU5yU5sNQ/D204pBpIPTf6yWyoZxDPGi4yLV6
	 YxYSTABE4PvGQ==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-654fb0921a6so1401592eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 07:58:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV46TInR2sRZ1Dc2l/zr5UmkdTQYGwQeGHB2DP41Ej+bntH+UXRfrEgzms5QmaTWXZexo/XQhbexpdn@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQlCzdRyXZ05Vs97/f4YnBMzKDSFDqtbsMCz+qySIrtIb+WI5
	2yjOGLKVVe16k09IdTrzmD3eUBG67OFBrmAYRHCLPr6T4syZk6bNs3v7UYhfUsHHkZawX9Cfxg8
	hNf3Vpq7XroNYDqcU/GEsKkRnPqIFEWc=
X-Google-Smtp-Source: AGHT+IHwyP0Phjpc2s38qn/oZxruTdIIn7PKBOPN5KG1sxvTkmy54EzyPJG22TN/QEB3zluCjdZUh9RneIiK7JNNkqk=
X-Received: by 2002:a05:6820:201:b0:656:735e:9eff with SMTP id
 006d021491bc7-6568a69fb65mr5049990eaf.7.1762185526398; Mon, 03 Nov 2025
 07:58:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026081240.997038-1-derekjohn.clark@gmail.com> <20251026081240.997038-2-derekjohn.clark@gmail.com>
In-Reply-To: <20251026081240.997038-2-derekjohn.clark@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 16:58:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ipOL+Z3SVdUZdnW1hJ2cCUb_BxU1fFqkeXiZxazEERpA@mail.gmail.com>
X-Gm-Features: AWmQ_bm0iHFRxjhDHxAHe7E8gceedtOfet6LkEw2iD05WGiSua6iCrB6v_X-dgw
Message-ID: <CAJZ5v0ipOL+Z3SVdUZdnW1hJ2cCUb_BxU1fFqkeXiZxazEERpA@mail.gmail.com>
Subject: Re: [PATCH 1/3] acpi: platform_profile - Add Extreme profile option
To: "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Len Brown <lenb@kernel.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Mario Limonciello <superm1@kernel.org>, Zhixin Zhang <zhangzx36@lenovo.com>, Mia Shao <shaohz1@lenovo.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>, Kurt Borja <kuurtb@gmail.com>, 
	platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2025 at 9:12=E2=80=AFAM Derek J. Clark
<derekjohn.clark@gmail.com> wrote:
>
> Some devices, namely Lenovo Legion devices, have an "extreme" mode where
> power draw is at the maximum limit of the cooling hardware. Add a new
> "extreme" platform profile to properly reflect this operating mode.
>
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

This is fine with me from the ACPI angle, so

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  Documentation/ABI/testing/sysfs-class-platform-profile | 2 ++
>  drivers/acpi/platform_profile.c                        | 1 +
>  include/linux/platform_profile.h                       | 1 +
>  3 files changed, 4 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-class-platform-profile b/Doc=
umentation/ABI/testing/sysfs-class-platform-profile
> index dc72adfb830a..9bee8deb4dc9 100644
> --- a/Documentation/ABI/testing/sysfs-class-platform-profile
> +++ b/Documentation/ABI/testing/sysfs-class-platform-profile
> @@ -23,6 +23,8 @@ Description:  This file contains a space-separated list=
 of profiles supported
>                                         power consumption with a slight b=
ias
>                                         towards performance
>                 performance             High performance operation
> +               extreme                 Higher performance operation that=
 may exceed
> +                                       internal battery draw limits when=
 on AC power
>                 custom                  Driver defined custom profile
>                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_prof=
ile.c
> index b43f4459a4f6..78da17e16d9b 100644
> --- a/drivers/acpi/platform_profile.c
> +++ b/drivers/acpi/platform_profile.c
> @@ -37,6 +37,7 @@ static const char * const profile_names[] =3D {
>         [PLATFORM_PROFILE_BALANCED] =3D "balanced",
>         [PLATFORM_PROFILE_BALANCED_PERFORMANCE] =3D "balanced-performance=
",
>         [PLATFORM_PROFILE_PERFORMANCE] =3D "performance",
> +       [PLATFORM_PROFILE_EXTREME] =3D "extreme",
>         [PLATFORM_PROFILE_CUSTOM] =3D "custom",
>  };
>  static_assert(ARRAY_SIZE(profile_names) =3D=3D PLATFORM_PROFILE_LAST);
> diff --git a/include/linux/platform_profile.h b/include/linux/platform_pr=
ofile.h
> index a299225ab92e..2bf178bde2b5 100644
> --- a/include/linux/platform_profile.h
> +++ b/include/linux/platform_profile.h
> @@ -24,6 +24,7 @@ enum platform_profile_option {
>         PLATFORM_PROFILE_BALANCED,
>         PLATFORM_PROFILE_BALANCED_PERFORMANCE,
>         PLATFORM_PROFILE_PERFORMANCE,
> +       PLATFORM_PROFILE_EXTREME,
>         PLATFORM_PROFILE_CUSTOM,
>         PLATFORM_PROFILE_LAST, /*must always be last */
>  };
> --
> 2.51.1
>

