Return-Path: <linux-acpi+bounces-19999-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B91CFDCE4
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 14:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E462305F801
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 12:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4153254AF;
	Wed,  7 Jan 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BunwL1ll"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DCD318139
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790480; cv=none; b=OfV7fTby/GNFSgsj6K4mraecWEpD9lfuTAsa8Yxwe4la8ijP4iXZF1AOXOeiiWRAcYjrI2jVYRlm0GyClYZjTZGC2c5biho1j2ZESIpYuvSZqcGffOiHm5ZKYeIUjLt/YqSopEBNEJ/cOsyga/Mhm3zIrAZWtGAm0kc2LZIHotw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790480; c=relaxed/simple;
	bh=+baMWu4Y/Aqb91iEV79MfVzqxaWsGmtJy+iR6UsBRXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqMlEjrb7PB5/lgMNluN4UJWxxZiLuoA8o0JIXs2D9ITsVnlMku44fNhBYzrDyjWurNzPlE2rXBLSsKdCQETbgTrixM7wAa7DDbIa96AjiUf7akt0SDuGom/1Qiv8ZUAzDo+QTqSQCm52t0uLGnLJANIEg+whEEU0jtFVG+LeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BunwL1ll; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BEFC4CEF7
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 12:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767790480;
	bh=+baMWu4Y/Aqb91iEV79MfVzqxaWsGmtJy+iR6UsBRXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BunwL1lllQL0pqHRfKcvZpyS8O8fNTqtyAv71IpGpxG/ux0X7n67ZFGWIzEV1/UiE
	 dtxNVzDkzSKvlcAhfygAuKTLO45bamRH/Un2tkVaKH5nrjgcNWmSRc36eDfo61J+Vr
	 zhpcNtNPg/NFncPicZ3ZvwezWf2SpqInHpBTSCZ7u3BGorUXlkePOfsk1Dz7H9QcM9
	 +Fm6RmlWprL6AUMJhyuoM7eTxUpNB4GFQTXTfjcHTEUPGiYCOa9jisQC8Ing4KlAJB
	 BfC4QEG9reyx9y82x8oh0ZlnacmLmvc8BxI7za+lei0f9NHSfwN8Q3m/0DCW4u8wmb
	 yzTBIwC6e/Tpg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-65f54073b63so355260eaf.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 04:54:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMxb/2PiYDy9fU17557DUUCrFle1lj+saEJo4Z7ghxJkdjP1dXLmkD6g4iTJTgiJ//uDz9UwlVlN+o@vger.kernel.org
X-Gm-Message-State: AOJu0YwdO6odbgf5LGsUg9y22nzwsTtx9KQkArCbW41XMz+sVot3SRIY
	hjYORHwI2ai3Vx2e2V0bJCruIuw2QEJ0I8tDWoGijxzeEoc3NjotrqJJaQbtScCNSBI5tRn6QG7
	DL0UcVVRswB9DE2n2oManlSJE2sD1nOI=
X-Google-Smtp-Source: AGHT+IE3bcoqXQpsCGQQJ2E2ShgMocmvzJ2mTRe799TBn0Sqt+FogMDHmhmMxJx0B5g3+BJxXTbTXsRZl8UlOvP7wPw=
X-Received: by 2002:a4a:da4c:0:b0:65b:3520:daa0 with SMTP id
 006d021491bc7-65f54ef22a8mr697350eaf.11.1767790479650; Wed, 07 Jan 2026
 04:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107120318.13130-1-kkartik@nvidia.com>
In-Reply-To: <20260107120318.13130-1-kkartik@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 13:54:28 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gbqXrj+Zq42CWL11-d4uJPb6NcGKrnf+ZQWvBSJGqZxA@mail.gmail.com>
X-Gm-Features: AQt7F2rZNfiqCma3gkodJIXNUDGJH1WS5TkjMHeRSe4Wyt7RnKsLf1t-hUW14xE
Message-ID: <CAJZ5v0gbqXrj+Zq42CWL11-d4uJPb6NcGKrnf+ZQWvBSJGqZxA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: bus: Use OF match data for PRP0001 matched devices
To: Kartik Rajput <kkartik@nvidia.com>
Cc: lenb@kernel.org, sakari.ailus@linux.intel.com, 
	mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com, 
	thierry.reding@gmail.com, jonathanh@nvidia.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 1:03=E2=80=AFPM Kartik Rajput <kkartik@nvidia.com> w=
rote:
>
> When a device is matched via PRP0001, the driver's OF (DT) match table
> must be used to obtain the device match data. If a driver provides both
> an acpi_match_table and an of_match_table, the current
> acpi_device_get_match_data() path consults the driver's acpi_match_table
> and returns NULL (no ACPI ID matches).
>
> Explicitly detect PRP0001 and fetch match data from the driver's
> of_match_table via acpi_of_device_get_match_data().
>
> Fixes: 886ca88be6b3 ("ACPI / bus: Respect PRP0001 when retrieving device =
match data")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kartik Rajput <kkartik@nvidia.com>
> ---
> Changes in v2:
>         * Fix build errors.
> ---
>  drivers/acpi/bus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 5e110badac7b..6658c4339656 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1031,8 +1031,9 @@ const void *acpi_device_get_match_data(const struct=
 device *dev)
>  {
>         const struct acpi_device_id *acpi_ids =3D dev->driver->acpi_match=
_table;
>         const struct acpi_device_id *match;
> +       struct acpi_device *adev =3D ACPI_COMPANION(dev);
>
> -       if (!acpi_ids)

You still need to check acpi_ids against NULL or (better) check adev
against NULL.

> +       if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev)))
>                 return acpi_of_device_get_match_data(dev);
>
>         match =3D acpi_match_device(acpi_ids, dev);
> --

