Return-Path: <linux-acpi+bounces-5799-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE88C567D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 15:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35C36283DFF
	for <lists+linux-acpi@lfdr.de>; Tue, 14 May 2024 13:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0110113FD78;
	Tue, 14 May 2024 13:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNSMtgQB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4CF12E75;
	Tue, 14 May 2024 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691828; cv=none; b=PL/L4jXABtcYSNE28AeueLpWNNIInHTKwoFWcZCy4qwHbN9xYuR/Sa5cYyD7AwSOoZgNUbJFty0Zedl+XkYOtdRFNi+T/KrIomQR/tWn8A2+u5y1WTMVAGwNS52qQ3lGBJoa3gKJbPFIr/XeT923bQvntwVMpzsy2s+WgVu0eaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691828; c=relaxed/simple;
	bh=HqBo9A89PNEMl9VLVy5CJp43eeNiSHmRyiXz/Vb2A0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLesUqTt9WSUmfvtHyj2RMv/vzfHjlEBEJ79S2/L+h9rM/jnbmIUaImzvNkcokrJ9GhHKdv471eU4RTyGw3l7J5yjoUlllbDS6hLiQ7CBvDbwZfqF11VaUMKKBR6pRDB6aOBTldlh6bcGa0Hpd0txYh8zuyZoFJAfp5cVHmxkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vNSMtgQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37857C4AF0F;
	Tue, 14 May 2024 13:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715691828;
	bh=HqBo9A89PNEMl9VLVy5CJp43eeNiSHmRyiXz/Vb2A0A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vNSMtgQBy5+FhUDvPnsfj4VjvY8lih4Icl2zSQRbE5lRa7sxxS41M+udD5KrE29hz
	 qpZ25z5+jQQ8l0DPq63a+trlez0Cd8msSRG7M+aZNP+ou9Ez6f9yxaXsZzHXcZ6P1d
	 KiPjQWgQw4obgt+Z9RbHpFNE3dxQIarDJHL3dVpcM31kYGdAARGXEhW4ed+V3QFfvf
	 /BBT7rQFJkC86aCLsE9MpDQKmgtqf518PRFRmC53zHQPpsm3zgJ9JguYRcrHMR84Tv
	 mVsAzlAh1hApKzQJ7xjpl/+dA3rqexK/4acIsIifp6f9Y9Raxf3CxyzL1wHi5rbqup
	 JZsiCym2KmKdw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5b27cc76e9aso600101eaf.2;
        Tue, 14 May 2024 06:03:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWN93/GxluvS4ldnF+rQ1ku2ZrKVqnkItMIPseJPFpEYdPlDPc6toO4loUGd3E+pMbH/SXCL9EDB/m8PbcSolVmHB1Au/jAfCpthPXdN9xelmky6es4XTa49Ri3xUGWQImNXygrp9BM0A==
X-Gm-Message-State: AOJu0YzhMkuVdUTHt6QvfGDoUni8w5dNcQo0E3+OojU5a3RRyy3cMxBu
	qgRiGnU78D8igjsVJySHhHzzlL9UmP0Qtp27PKqqa30eYuU8wKU83VrnoYjniv5Y4DsBGuA2h7g
	klM8UW9rk3im9eLvdApvKKhwfrnQ=
X-Google-Smtp-Source: AGHT+IFkzN0bAkSzxCTo2iZF2l6+nNstB2lidsWaMXQj1Iqp2FDLUZLjXO47zq1eWNcH2/pJmgU1Uq1fQ8vBdxtgvlg=
X-Received: by 2002:a05:6820:1f16:b0:5b2:7d9f:e708 with SMTP id
 006d021491bc7-5b28193e476mr13727969eaf.1.1715691827324; Tue, 14 May 2024
 06:03:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <BYAPR03MB4168E7E5A2616EB82D3883E8ADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
In-Reply-To: <BYAPR03MB4168E7E5A2616EB82D3883E8ADE02@BYAPR03MB4168.namprd03.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 May 2024 15:03:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jfoNqgKZj=vFN53B1GPOA88GWYrF61Yutqs=h8R3fZ4Q@mail.gmail.com>
Message-ID: <CAJZ5v0jfoNqgKZj=vFN53B1GPOA88GWYrF61Yutqs=h8R3fZ4Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Add missing check for kstrdup()
To: Jiasheng Jiang <jiashengjiangcool@outlook.com>
Cc: rafael@kernel.org, lenb@kernel.org, lv.zheng@intel.com, 
	rui.zhang@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 11, 2024 at 9:36=E2=80=AFPM Jiasheng Jiang
<jiashengjiangcool@outlook.com> wrote:
>
> Add check for the return value of kstrdup() in order to gurantee
> the success of allocation.
> Moreover, move the code forward to simplify the error handling.
>
> Fixes: ccf78040265b ("ACPI: Add _UID support for ACPI devices.")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@outlook.com>
> ---
>  drivers/acpi/scan.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index d1464324de95..59246757a207 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1385,6 +1385,15 @@ static void acpi_set_pnp_ids(acpi_handle handle, s=
truct acpi_device_pnp *pnp,
>                         return;
>                 }
>
> +               if (info->valid & ACPI_VALID_UID) {
> +                       pnp->unique_id =3D kstrdup(info->unique_id.string=
,
> +                                                       GFP_KERNEL);
> +                       if (!pnp->unique_id) {
> +                               kfree(info);
> +                               return;

No, this is not sufficient for the function to return.

> +                       }
> +               }
> +
>                 if (info->valid & ACPI_VALID_HID) {
>                         acpi_add_id(pnp, info->hardware_id.string);
>                         pnp->type.platform_id =3D 1;
> @@ -1398,9 +1407,6 @@ static void acpi_set_pnp_ids(acpi_handle handle, st=
ruct acpi_device_pnp *pnp,
>                         pnp->bus_address =3D info->address;
>                         pnp->type.bus_address =3D 1;
>                 }
> -               if (info->valid & ACPI_VALID_UID)
> -                       pnp->unique_id =3D kstrdup(info->unique_id.string=
,
> -                                                       GFP_KERNEL);

This is optional, so it can be NULL.

>                 if (info->valid & ACPI_VALID_CLS)
>                         acpi_add_id(pnp, info->class_code.string);
>
> --

