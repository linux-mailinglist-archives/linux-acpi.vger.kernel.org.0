Return-Path: <linux-acpi+bounces-13864-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 842C6AC25C3
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 16:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461944A6385
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 14:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DB7295DBC;
	Fri, 23 May 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWg0rYer"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E62957A2
	for <linux-acpi@vger.kernel.org>; Fri, 23 May 2025 14:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012365; cv=none; b=LPLImHI3kYNJ/lQwHlCooK5U2VsSjipsdUlfcIkiSZwnC+DRgJFhKLuCf/qO574BHxTAPBIhfXzUhm7fexZ2AxJHYTjtCbSspB6ond8L/MADHXdsQ1LIihRc5a0cWMWLRhbWV/6XKcVkr17+DKfQZrVGYro++GY/VUsCCKOxBos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012365; c=relaxed/simple;
	bh=eD+PLaLcH45i8+Ow8HHw3WEyhSjtZKwq8L4rsvkTPmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVSQniX1UQszq6lPhR/RCcOBJFZqbOBjWUN0SDX52lCGLOHPeDQ+Rd9J9bRQy8T3k+lDeWojJFEqe53/B6PDIEaMpt+PUE+c0+JMrg+IBXYIdQpW3mnkLUrJ/7oRU4XyoF0MB1LOFY3Zns02EMKtKz9cFc4b11tnfugAwLDak/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWg0rYer; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09808C4CEEF
	for <linux-acpi@vger.kernel.org>; Fri, 23 May 2025 14:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748012365;
	bh=eD+PLaLcH45i8+Ow8HHw3WEyhSjtZKwq8L4rsvkTPmo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KWg0rYerK+mN5Mg8ysNmIKCqm88hx870u3MhX3NgI8Kf92LExVpQ3NcSqh/TwSi3F
	 bLXUPXRYDrZpPVZ4fotBrqUUrzKDmf0paiWrBmAVHnFVfRpBAan7TYMJC9B5SIQYAg
	 j4BjwZPwvZ4IggDD0Rrgap7aafvix8Fy0fU1g9nPKbnhXN6FcVg2YdUgVJvDgDoctl
	 65CWGliCfkBJrwtZX7XikBJsseg902uNlLpnnLDCAGVUU+vK5Pz/l3rPDYH5ZBpsdw
	 P5tMUS2+6udiJEksK8losfIX6YEpKOtmzLaU7zsnRuq9L4L6pj/6Tvis/WP0AIdwqe
	 RZGRAYZ7j1bKw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2dfb991cb45so30811fac.0
        for <linux-acpi@vger.kernel.org>; Fri, 23 May 2025 07:59:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZ1JgwE7gPPadC2Vc+rkuKTm87vbRm23xunD6bx3SNBqLdLvhtaf7mJsqCLBMjnbD3+DaReFZ8cjj4@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGy5yrqKU5Zqc3pF9UYdU7U/TfxM3Ot/krUYu1E5yEEASMu5H
	0EBCxFHOehjpx2zOHMrK3pCJp9RIefxqxclZ7JdKGqhb88xq7YEbJeHOthXPWD8jcwkuITzZs0+
	H6Gdb474eXT+m6WvdXg8voAm1c3bY0ks=
X-Google-Smtp-Source: AGHT+IHLfjO+kXzlC7/l7rVJC8DMiVC+UVRsAN6HET1sw6kmUHuv+B1QAojsME0TOXNQ3gzhYKKyOUkNLOATeJNs/uo=
X-Received: by 2002:a05:6870:9e0d:b0:2c2:5b08:8e42 with SMTP id
 586e51a60fabf-2e3c1ed9f7emr19486313fac.27.1748012364271; Fri, 23 May 2025
 07:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407085419.494234-1-shitao@kylinos.cn>
In-Reply-To: <20250407085419.494234-1-shitao@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 16:59:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ihW5ccV7O8RhEEGcHY7WausHo2zjzrJKAKjUCVvgHLPg@mail.gmail.com>
X-Gm-Features: AX0GCFsIRoNfLyd264HtCwmWOkNuiQ3dMJ4Atgt4-ouf08DFdApYaXjO84Q906k
Message-ID: <CAJZ5v0ihW5ccV7O8RhEEGcHY7WausHo2zjzrJKAKjUCVvgHLPg@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI / battery: Use rounding to optimize the power calculation
To: shitao <shitao@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	luriwen@kylinos.cn, xiongxin@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 10:55=E2=80=AFAM shitao <shitao@kylinos.cn> wrote:
>
> If the difference between capacity_now and full_capacity is
> within 0.5%, 100% is arguably a better number to expose than
> 99% and exposing the latter may confuse the user to think that
> there's something wrong with the battery.
>
> Use rounding to optimize the power calculation.
>
> Signed-off-by: shitao  <shitao@kylinos.cn>
>
> ---
> change for v3
> -Optimization problem description.
> -Use 100ULL.
>
> change for v2
> -battery->full_charge_capacity is changed to full_capacity.
> Thanks!
> ---
>  drivers/acpi/battery.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8af5..6905b56bf3e4 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -279,8 +279,8 @@ static int acpi_battery_get_property(struct power_sup=
ply *psy,
>                     full_capacity =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
>                         ret =3D -ENODEV;
>                 else
> -                       val->intval =3D battery->capacity_now * 100/
> -                                       full_capacity;
> +                       val->intval =3D DIV_ROUND_CLOSEST_ULL(battery->ca=
pacity_now * 100ULL,
> +                                       full_capacity);
>                 break;
>         case POWER_SUPPLY_PROP_CAPACITY_LEVEL:
>                 if (battery->state & ACPI_BATTERY_STATE_CRITICAL)
> --

Since this is a change in behavior, albeit small, I'd prefer it to get
some coverage in linux-next before it goes into the mainline.

Please resend it after 6.16-rc1 is out unless the 6.15 release is
deferred (in which case I will pick it up).

Thanks!

