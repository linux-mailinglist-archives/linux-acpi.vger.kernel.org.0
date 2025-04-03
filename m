Return-Path: <linux-acpi+bounces-12677-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAAA7A184
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 13:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBBC1896335
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Apr 2025 11:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709F21F5825;
	Thu,  3 Apr 2025 11:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asSofXP0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC7E1DF975
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743678092; cv=none; b=Gxnt+9KnpXVMgB1WjwXShle9/z4idGfklRMdhyY9qaUYr2m23jNaPH/TiR/CXLaOnmm75jN+9AINS+iwA+Eg6+WxETP+iUSq8JE6HPwIeNe6e5isj82h2wWZ9KgNFEMX+tVcOI+f9305RS/IEqnBXLvl9ekfH0brTVdLmDQBPi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743678092; c=relaxed/simple;
	bh=Eu0WUd0SjMWveoRl42wgkNPlQjAMBGviMsvLw55JReg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gb+ode9ZdNDbSI2t7afi24qtBkrMufAshPMrzovHuamPftgoNHoqNtlStwaMEkzFVyNmubgaMruSMVYQObQg9dKhs4ftbclYVhWj6DJWVGLE7YXe3mPaG6JX/WKVk8dT5VLcagDaRCimBqvqfT8LgUDo30lJgodIQiW5nzGSaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asSofXP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5383C4CEE8
	for <linux-acpi@vger.kernel.org>; Thu,  3 Apr 2025 11:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743678091;
	bh=Eu0WUd0SjMWveoRl42wgkNPlQjAMBGviMsvLw55JReg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=asSofXP0IM+MVuVBAFlxdecCsjWXhIKsUZNoDokWHSstv76diPNKWcDkQYFiLVJaU
	 iHGdY3VpaNHKf6RizLFLPJHnirRNJTKdO29ZcBMw/sjnzAvWV05OSpv4Epflk+DP9y
	 feB+WNeEnhrh0ukdQvqhHjgcBlt4Jh6HvuAXZlsUUOFdLmEZWL8RWFlgOEA+y6OhJP
	 kipgUlx0EEi0EEzUuQkUZCEFd9VtFpOasyyOYBRKOjXihvG1xKdduqGrzjUj+MTZab
	 tu7dI9izl1eE2U9oE2uCQ029B+C+KuG9FLdpZxiuJ5zmexriL1+hrV9tAO3Up7x2C/
	 fKP8MfZ4x8hJg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2c873231e7bso406830fac.3
        for <linux-acpi@vger.kernel.org>; Thu, 03 Apr 2025 04:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU05EuulfhamTI+6LfezqU5tvoUjDBfQE563/0V0SahO8HZAK6Q3zN9Ie+NhKkSxMLS17QewSWLtbtT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Fr48A03hXXFruAZzRIIq9IbkRBZlDNWx2+eqGln3XQNuW1wn
	8U/Rpthk6aXr5z9y/jio+9JvVwljHvF/x2f7r7w94g92FVu43Z629CdXP7vZElpIhQ/pS5JaVvF
	SUtZhljE6JR9A0FlgMwtkO90Irzg=
X-Google-Smtp-Source: AGHT+IGrOuAHqOznZmuWvFw35x3ofsHpGnMYAGiqCbe9w3RxyT+Gm0b3kYghvVErPVEEoE6HEaQLMD0AU+3TeskFNjc=
X-Received: by 2002:a05:6870:d60b:b0:29e:65ed:5c70 with SMTP id
 586e51a60fabf-2cc7f8abce9mr1192902fac.30.1743678091122; Thu, 03 Apr 2025
 04:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403023459.62055-1-shitao@kylinos.cn>
In-Reply-To: <20250403023459.62055-1-shitao@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 3 Apr 2025 13:01:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVQTq8f0bgeSa4+qYWosBHXADXLXviMxNnpafAV0NCmw@mail.gmail.com>
X-Gm-Features: AQ5f1JoEJdXN9qlAuthIahcCpZXsxPwmpu66I5DjknrXT6dTRuzIzdcTI9wmVls
Message-ID: <CAJZ5v0hVQTq8f0bgeSa4+qYWosBHXADXLXviMxNnpafAV0NCmw@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI / battery: Use rounding to optimize the power calculation
To: shitao <shitao@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 4:35=E2=80=AFAM shitao <shitao@kylinos.cn> wrote:
>
> Some batteries may have the problem of aging and losing power too quickly=
,
> and users may immediately display 99% battery level after unplugging
> the charger.
> This will bring some unnecessary misunderstandings or troubles to users.
>
> Use rounding to optimize the power calculation, and expect to display 100=
%
> when capacity_now is only slightly less than full_charge_capacity.
>
> Try to avoid unnecessary feedback from users about the battery not being
> fully charged or dropping out too quickly.

My problem statement for this would be that if the difference between
capacity_now and full_capacity is within 0.5%, 100% is arguably a
better number to expose than 99% and exposing the latter may confuse
the user to think that there's something wrong with the battery.

> Signed-off-by: shitao  <shitao@kylinos.cn>
> ---
>  drivers/acpi/battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8af5..8eb9dc98c2c4 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -279,8 +279,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>                     full_capacity =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
>                         ret =3D -ENODEV;
>                 else
> -                       val->intval =3D battery->capacity_now * 100/
> -                                       full_capacity;
> +                       val->intval =3D DIV_ROUND_CLOSEST_ULL((uint64_t)b=
attery->capacity_now *
> +                                       100, full_capacity);

If you use 100ULL, the explicit type cast will not be necessary.

>                 break;
>         case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>                 if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
> --

