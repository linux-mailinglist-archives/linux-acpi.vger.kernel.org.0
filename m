Return-Path: <linux-acpi+bounces-10901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53975A29B00
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 21:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D174F188A6AB
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Feb 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B102135B1;
	Wed,  5 Feb 2025 20:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKPsZqO5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2028211A1E;
	Wed,  5 Feb 2025 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738786445; cv=none; b=B92v3fNl63sXqG3gN8/b9M+7UAjJZQ+jo+lITBZHEaHdjJFTc0h5d7sy3qb0xpniQGA+Ws6S7+4yC4pCUbg5nnbe89TI21XJ1abtn/cqjsIivENgjLcGQmWrgaiPf0tk70f3B7iU/OX4EBpep9rO2qgGEJHJbLVmgrF5dp+BxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738786445; c=relaxed/simple;
	bh=/Wub+YrcYQhT3DJInKawKPxJJIQyMqOWirwYBaVx8ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MPsbi0XMKvnjkgNroGwj06JjDhlzh2YasgysSkU17xHPjGeKw3ylmdd7xekYvv8N9PNX+eF0PFIOH7ImPzGb2fV7InbmrgCJrjnvyAlruj1UgHHTxKy1IcqtXW1h497Bv+NLdVcsXXUltvt01SdfzI4hvf9retTHkjQiOg6ft3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKPsZqO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A985C4CED1;
	Wed,  5 Feb 2025 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738786444;
	bh=/Wub+YrcYQhT3DJInKawKPxJJIQyMqOWirwYBaVx8ao=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dKPsZqO5cq0khZ9H9F2rwcbWZV/OYzUgXTeIo7VuNplnN0FfodX4g/RpST8NnJdCB
	 AOFHPaTUgn2KWqGP7ErYwLcisZd/n8zdrG8PY+UAG5/C0Y1YMA5XccWqzp4n/IRp5M
	 eG6Pzj44acxPf41cXJLWmPLCTjlcfGJ97KXMfqFQz3e8XNmG9fSbrScKld5t9HdG+O
	 RkU3S7cvzd4i9/iWDay8fj+qd8CrMdw9ro7pF7od1CzYOwgST2ZLhPm/Qr7ymTlXcu
	 ZwBgaz22VlMvvG4elENSzwbDdlGuPxzl2866GDx+DXXW1kmx8x/uV34ZD+ifP1wSX5
	 7GcI9K1zG9mHA==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3eba50d6da7so66893b6e.2;
        Wed, 05 Feb 2025 12:14:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUj3YWN/QruBzGwv7ROd9n99P7Wskrsz+uvypnCKU67dO8MCOGr8uDEwHSI/mlPAqlXUlHC+kZLOSML@vger.kernel.org, AJvYcCVjC9trqjwH0B6lMcpyo7HosLH2u4Cx1gujeIgkGeCtt9CjKJHy+sqFHJ2YjnoHslu+BaKQKU4iG3pLBxKi@vger.kernel.org
X-Gm-Message-State: AOJu0YyTpULX6AY0/MNpKmmkCXhoXgeSXC20N8ur7C9tYlUXELlnyRp6
	PuZYoaLqcXbsDveht9n7gAuZJSbHvgrxbZMjrh4uZHVJ4L86moyRZ2KIYX0B0Vii7UaVMwUO+h5
	KLsTVawLTI/tsPQ8ryyBXb73Ws2s=
X-Google-Smtp-Source: AGHT+IGJEq/npDc6Y6YsYNNv8WHDDkC7T8jyksL8z/E/YUvQJ4sgVEyOUiC+BZcR2/jeZ0MPcjzvUqZNT/HMGqir9Cs=
X-Received: by 2002:a05:6808:bc8:b0:3f3:3331:96f2 with SMTP id
 5614622812f47-3f37c1531aamr2843197b6e.22.1738786443690; Wed, 05 Feb 2025
 12:14:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127093902.328361-1-gannon.kolding@gmail.com>
In-Reply-To: <20250127093902.328361-1-gannon.kolding@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 5 Feb 2025 21:13:52 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gvSY+4Hdoedo0Hm6Rap_1kig1z0G0NuYcEKBsLPsMo8Q@mail.gmail.com>
X-Gm-Features: AWEUYZkovbgRPGTxE5riochLatWY89A6pEh4qL3RakCvjeNFKH0W5Y-ssDE9C2I
Message-ID: <CAJZ5v0gvSY+4Hdoedo0Hm6Rap_1kig1z0G0NuYcEKBsLPsMo8Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: IRQ override for Eluktronics MECH-17
To: Gannon Kolding <gannon.kolding@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 10:39=E2=80=AFAM Gannon Kolding
<gannon.kolding@gmail.com> wrote:
>
> The Eluktronics MECH-17 (GM7RG7N) needs IRQ overriding for the
> keyboard to work. Adding a DMI_MATCH entry for this laptop model
> makes the internal keyboard function normally.
>
> Signed-off-by: Gannon Kolding <gannon.kolding@gmail.com>
> ---
>  drivers/acpi/resource.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 90aaec923889..b4cd14e7fa76 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -563,6 +563,12 @@ static const struct dmi_system_id irq1_edge_low_forc=
e_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "RP-15"),
>                 },
>         },
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Eluktronics Inc."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "MECH-17"),
> +               },
> +       },
>         {
>                 /* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
>                 .matches =3D {
> --

Applied as 6.14-rc material, thanks!

