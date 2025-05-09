Return-Path: <linux-acpi+bounces-13662-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E834AB1D34
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 21:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBD61C412CA
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 19:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2AF25B1EB;
	Fri,  9 May 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpOoRgXR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D325B1F0
	for <linux-acpi@vger.kernel.org>; Fri,  9 May 2025 19:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818172; cv=none; b=oo0SS9FpDKDVaMpbnYkdulEbq7wdZSZreqOzC6V5yZlaIDaj8iiXoSHo7i9m9CuPKWPsHx7a3shUziG5IjPjofRw0vOGbcgi1vRPqe5Fngo4kFzS4YKGChsP2J7zHs1n+h9+sMfjxTACmxTWAm1OiplAwdvjNvZlD1/EGqhaLn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818172; c=relaxed/simple;
	bh=jqEA/h3DHx/Bp+SpKiKe2ChVUhS4J6c83G+PK49NbRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW9QF5nnEyjw5ZWRnyWrpf5r7g7Uno/sBOEvB0WqvWD3vGwu3PzukUYWLDzB7P6YFSwpXcN6DAWRY+gxsatHZg3nAN3DJV9Qpe5Y55C6+0LdRm7yrVx4jOmOjD98W4dRTSjuBQ+EdWDnIO/0/3fa1U9glI78sPqEc+kSJZP8Tlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpOoRgXR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274B6C4CEEE
	for <linux-acpi@vger.kernel.org>; Fri,  9 May 2025 19:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746818172;
	bh=jqEA/h3DHx/Bp+SpKiKe2ChVUhS4J6c83G+PK49NbRA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LpOoRgXR3H9gQEws20U2SsiB+owzU+tLPb40lSZq2Re2AoGkGqgES+dRXQOYWg0qj
	 v06PQDoUWaSf7b/IM3SL5vb035SbAL2g2UXBaP1z6PoQE1e9B/KQ0BHm7spslJiikm
	 35hn+w1+q8GCKfYpLs4z7JjcnUgwVBeKrZok4hTKSL5DINKbF5qByUBgAOZhDQiVIK
	 QpQtNRdLWDaBaeeN66Jz/A63X9D1HohIZBfphqwdM63RoKlrUz3ocSRfJntdEfRGlk
	 wfcRhUbM7zVwmS1Z1298o2wLa5Ild5x2NDUEmbaqwGoDM9Iqo2ustHqye9//dSleoa
	 vlE+w4X7YYDGw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6064207317eso1422982eaf.1
        for <linux-acpi@vger.kernel.org>; Fri, 09 May 2025 12:16:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuP7m5Vc10AjqNnuC6v++9UJcIEJ/8HLIN9VKAQhqHFLKsY7HNwWfYgVZkVCOZJBxnn7hGgc6hwLaR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe+NXdYdVo+X3aqt/Y+Jc3TZQTJ8tssbe6o6OvqLC1PyOQIFnt
	mQ7vaJa9L2DXoRTT5APcPNXtgg7Fud8+ArL/nEHg4YcaXqaM/f53pt46HE/X6f9KRxI4VB+spvE
	Llr1f+mAolss8f48okIf/n+1qDQ8=
X-Google-Smtp-Source: AGHT+IFAwOWNJExACv2OLMcCnd/mdJQJMTs+kodHDAOHrL/aW/VVNlehBI6mIVQAsm7xmn3bZXYN2T7ybhrQI8Fv4qY=
X-Received: by 2002:a05:6820:983:b0:606:894b:fd23 with SMTP id
 006d021491bc7-6084b651b84mr2852696eaf.4.1746818171377; Fri, 09 May 2025
 12:16:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG_X_pA0vW6ZWcT2K5R4DnOmz3R-Kz4vpiSC9oyAwKrATXMkZA@mail.gmail.com>
 <20250508024146.1436129-1-pmarheine@chromium.org>
In-Reply-To: <20250508024146.1436129-1-pmarheine@chromium.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 21:16:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gf6+uena7_AJyT-p77Lu2vd6Ns2RyG-3Syg=papYp3hg@mail.gmail.com>
X-Gm-Features: ATxdqUH5lvg0h8FKbE4CbpCB7xJ1yX5QJbz8c-3Lg6NfPqpAonxt-yVxyEL02vM
Message-ID: <CAJZ5v0gf6+uena7_AJyT-p77Lu2vd6Ns2RyG-3Syg=papYp3hg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: battery: negate current when discharging
To: Peter Marheine <pmarheine@chromium.org>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 4:42=E2=80=AFAM Peter Marheine <pmarheine@chromium.o=
rg> wrote:
>
> The ACPI specification requires that battery rate is always positive,
> but the kernel ABI for POWER_SUPPLY_PROP_CURRENT_NOW
> (Documentation/ABI/testing/sysfs-class-power) specifies that it should
> be negative when a battery is discharging. When reporting CURRENT_NOW,
> massage the value to match the documented ABI.
>
> This only changes the sign of `current_now` and not `power_now` because
> documentation doesn't describe any particular meaning for `power_now` so
> leaving `power_now` unchanged is less likely to confuse userspace
> unnecessarily, whereas becoming consistent with the documented ABI is
> worth potentially confusing clients that read `current_now`.
>
> Signed-off-by: Peter Marheine <pmarheine@chromium.org>
> ---
>  drivers/acpi/battery.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 6760330a8a..93bb1f7d90 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -243,10 +243,23 @@ static int acpi_battery_get_property(struct power_s=
upply *psy,
>                 break;
>         case POWER_SUPPLY_PROP_CURRENT_NOW:
>         case POWER_SUPPLY_PROP_POWER_NOW:
> -               if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN)
> +               if (battery->rate_now =3D=3D ACPI_BATTERY_VALUE_UNKNOWN) =
{
>                         ret =3D -ENODEV;
> -               else
> -                       val->intval =3D battery->rate_now * 1000;
> +                       break;
> +               }
> +
> +               val->intval =3D battery->rate_now * 1000;
> +               /*
> +                * When discharging, the current should be reported as a
> +                * negative number as per the power supply class interfac=
e
> +                * definition.
> +                */
> +               if (psp =3D=3D POWER_SUPPLY_PROP_CURRENT_NOW &&
> +                   (battery->state & ACPI_BATTERY_STATE_DISCHARGING) &&
> +                   acpi_battery_handle_discharging(battery)
> +                               =3D=3D POWER_SUPPLY_STATUS_DISCHARGING)
> +                       val->intval =3D -val->intval;
> +
>                 break;
>         case POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN:
>         case POWER_SUPPLY_PROP_ENERGY_FULL_DESIGN:
> --

Applied as 6.16 material, thanks!

