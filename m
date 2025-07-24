Return-Path: <linux-acpi+bounces-15307-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D404CB1073A
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 12:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01AA3189806C
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Jul 2025 10:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5262417C6;
	Thu, 24 Jul 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPVMQvNw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565221E5B70;
	Thu, 24 Jul 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753351265; cv=none; b=kaWcL0CspNB7Gimn9fJyH64MIBzkEkE0uIq7dfVI9J6AcCYpkYW7oce90r31He+vU9QhYeJOtBCZGUMtHAwi6tRGWgei8sggW45He2Rn3faon9qNIvP4AQNrxhqZJe7r/T2TdFOekzfLoc7XonIMrtvtd4Kd91+sdoNsdXuZRFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753351265; c=relaxed/simple;
	bh=Jvnb9bcGTflRPkSQ0MQ6PievHjIiWNxPoId9/0UcpjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxUCT3bzyN9sg0r/uWHJfub7nGJbghwFjffnaF99c1rPsLIjxFlbuOxVEx7jzoMW6rsDnizXuxNOoCmd76D6PrZ6mpiRhlKr+HPrqwH4898D4KCZrdHlRY7JLK0DtrtNp56+RHTRr3XZ8rGepdbM0gZqseDFj3Vd4PxS/xyVUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPVMQvNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EA9C4CEF4;
	Thu, 24 Jul 2025 10:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753351265;
	bh=Jvnb9bcGTflRPkSQ0MQ6PievHjIiWNxPoId9/0UcpjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kPVMQvNw+tFknLzp7W0RewMwmFLWF303GHBv2JZJg/jb5e4KPVp2Xzqw7vYoYA3sm
	 Gt3zkr5LcCnQvBl+/UjfseyAH+ZQr9BYuJ4hB75QkM472SQoCBJAkxb1B/bRjvw/z1
	 i2pdNSKwRJGLLOtWXKnwkK/Aa6UOPTu2Lm+KzaxIpnDBJww0frH7AA8rgraxIFym9x
	 70VwA5K+XxXUNWIkrxkX/SitSJFWLM66tEEFh5/qVeOpfmlxufBiwCCOgGBqaeU6Yv
	 T9dLWO5cEwnZUJIZSHV1y11R6CK+tkoNDrJXZRDDGy8JZdY9ITBel4NCH+blhAAh+d
	 moOzX9WwrJqng==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-41b6561d3c5so243099b6e.1;
        Thu, 24 Jul 2025 03:01:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3KXfk1kKsPtVpB+TuhUhAdeTs3xg1HdPLD8bl30DgLX7h8BkLiNuF0KW41Hni/H58pRDuv8KJXCsHsqAh@vger.kernel.org, AJvYcCVkgQBkFCGwhLwOuf2Ba25ibntyPpARjC48JUueOyY1tyzayYyJc8rhSNLNkwmuihBpIMWeMyN/MmCy@vger.kernel.org
X-Gm-Message-State: AOJu0YxUtsoHJj9DgFLipYtCquOkA0yANgjToTWgQqqjcGaXBGhNfzlk
	YDvdjSDRNxwnR8ImrHczDiSoX51+vaDpyU1apJEDQc1k49e595bpbdnDcju0rK7e2oByKerVpix
	EJQC4dwHCtuya2eDB6DJ6hw1ox5Pdph0=
X-Google-Smtp-Source: AGHT+IG0VpRMV13kyn/0VIfoN+vbV+KNcMVo86M/mLHjEMCVHQVgZcHP3SrilMm7KPM5fy027Inlma6TAJiy3+FAkjk=
X-Received: by 2002:a05:6808:22a2:b0:409:f8e:727f with SMTP id
 5614622812f47-426c43f3cfbmr4516741b6e.3.1753351264161; Thu, 24 Jul 2025
 03:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724092058.10075-1-409411716@gms.tku.edu.tw>
In-Reply-To: <20250724092058.10075-1-409411716@gms.tku.edu.tw>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 24 Jul 2025 12:00:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
X-Gm-Features: Ac12FXxaEgr_R9b4MSGDugMK_lMOPeobENuYDNrsOB1tUlloJwxlD6tsf-wOBts
Message-ID: <CAJZ5v0hG0pfuz_WUfZAwd1iKumjxsX_+K5ZAfsOs2iSHdGwNrA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Use nearest power-manageable ancestor
To: "Guan-Chun.Wu" <409411716@gms.tku.edu.tw>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 11:21=E2=80=AFAM Guan-Chun.Wu <409411716@gms.tku.ed=
u.tw> wrote:
>
> When a device=E2=80=99s power_manageable flag is false, we currently only
> fall back to the direct parent=E2=80=99s power state.  In a deep hierarch=
y
> there may be a more distant ancestor that does support power
> management.
>
> Walk up the parent chain until we find the closest power_manageable
> ancestor and use its power state.  If none is found, default to
> ACPI_STATE_D0 (fully on).

Is there a specific use case in the field in which this change is needed?

If there's none, let's not make it.

> Signed-off-by: Guan-Chun.Wu <409411716@gms.tku.edu.tw>
> ---
>  drivers/acpi/device_pm.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index dbd4446025ec..81b47fb00e80 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -84,8 +84,23 @@ int acpi_device_get_power(struct acpi_device *device, =
int *state)
>         parent =3D acpi_dev_parent(device);
>
>         if (!device->flags.power_manageable) {
> -               /* TBD: Non-recursive algorithm for walking up hierarchy.=
 */
> -               *state =3D parent ? parent->power.state : ACPI_STATE_D0;
> +               /*
> +                * If the device itself is not power-manageable,
> +                * walk up the parent hierarchy to find the closest
> +                * ancestor that is power-manageable.
> +                * Use that ancestor's power state as an estimate
> +                * for this device. If no such ancestor exists,
> +                * default to D0 (Fully On).
> +                */
> +               struct acpi_device *ancestor =3D parent;
> +               /*
> +                * Keep traversing up until a power-manageable ancestor
> +                * is found or the root is reached
> +                */
> +               while (ancestor && !ancestor->flags.power_manageable)
> +                       ancestor =3D acpi_dev_parent(ancestor);
> +               /* Use the found ancestor's power state, or D0 if none is=
 found */
> +               *state =3D ancestor ? ancestor->power.state : ACPI_STATE_=
D0;
>                 goto out;
>         }
>
> --
> 2.34.1
>

