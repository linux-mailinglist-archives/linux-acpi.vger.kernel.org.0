Return-Path: <linux-acpi+bounces-7831-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265F95F7BC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 19:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B48292827D8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F81198A02;
	Mon, 26 Aug 2024 17:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlM/pQTS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A65319409E;
	Mon, 26 Aug 2024 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724692502; cv=none; b=Ci/Fl0iq0BvFTva08ytLmmNAVZxhf3AU8wfVIg77pAW3Uv7ULqtWVjkaRHDf5x1UxTJCkf20xl5v3K7zSinaylfM9YawCO8VGr9wTw0r/zxm2s2TVvCbvNpUDIy9X82X0cdXFW5Y/97Mcu7Pwp3niLE4om3LnrlwcdCgbigwvo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724692502; c=relaxed/simple;
	bh=LnIWP7fLaV4chONzOOcBQIguRxPmZAjFOGjrt1sMyHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAoaIDN4AFsPBxc+VV54xPqyLLQXoMTmugjox0EWK6awr0TJ1q9/O7N3pCictXOjoNCRTyXod4CzuAHi4uIMk88tltLnRmNHM/yaW+ktGKvgwJB69/vemqOck1Vk8SKwmet9VC9VBQ6vdIonNZXZvgef2Nu7w6jcmvp0wQaQz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlM/pQTS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F11C53760;
	Mon, 26 Aug 2024 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724692501;
	bh=LnIWP7fLaV4chONzOOcBQIguRxPmZAjFOGjrt1sMyHk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WlM/pQTStFRGsqyxF2CKbC3WY1Gr3aaru+duCxx6C+PhRur1UbIeQSBlU2sLB3e0X
	 D/z9h6E3VMY8kGssdWRL5dhXacCQe5seeXDjJtnSR77AubHfa6diuoyt93MYJRTJ9Q
	 yjbmkczyd8JIQVWKxiQe2U09VIH1+5aRFSKQJu1LV/9f6i4jD4f/mMn5E82af1e5V4
	 jOzSyLzNiQNmxtN8E+hTF5HvqL8W3NUYkk2vu+nWwRI7RC/5fLayI+2d2vEv7usIz0
	 9TKz1WtxedAxKJJlZPT9RDuDgOVLlTzu97Hg7lUac2ywCr2guEOlZupJFC78c0AcCT
	 j5QmeuvrVE92Q==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-27012aa4a74so2980609fac.0;
        Mon, 26 Aug 2024 10:15:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUbazMGr3jsMYTjyDEemzZkF/bh8/PFqdJEsLOL0uiLVNSJ4TPGJXPg904D8z+N6AgPn+A5oGBNw0Kfbmrb@vger.kernel.org, AJvYcCXunv6C0aCr80jHTvcYDngtwHKoSJ+5StJkP1RL8vsLjfPjzBkL2OdFY15rw0DVxJpsdGU7UfP2xQHM@vger.kernel.org
X-Gm-Message-State: AOJu0YwonqZQU/zeGXmsDC8jVLK+5hLd5Hjs31P9VKxl17O/2HAmoK8M
	nAmjROfzm9vaYbsvMnNX6lCCSLtFdVfoKRZnGayOgusrIGx1y1c8Pv56qaLu0hlm6LYvRHHT2VV
	NCRSox1GqCN9tZRbDhpfACwhtiS4=
X-Google-Smtp-Source: AGHT+IEwWJoPUsHxLU1Hz2XVFDhmnSN1PQEoapvZpSBftJtdEaqK0x09gaNC3gLvWIbrzfjl8Mx4dOAlBjFUvZLAUKQ=
X-Received: by 2002:a05:6870:c6a2:b0:260:ff24:fb32 with SMTP id
 586e51a60fabf-273e63d0d32mr12290196fac.1.1724692500682; Mon, 26 Aug 2024
 10:15:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804123313.16211-1-qasim.majeed20@gmail.com>
In-Reply-To: <20240804123313.16211-1-qasim.majeed20@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:14:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h72S=9mMWOx=mh+A4jJKHBKX_cEetk1fpi0c9VH_df8g@mail.gmail.com>
Message-ID: <CAJZ5v0h72S=9mMWOx=mh+A4jJKHBKX_cEetk1fpi0c9VH_df8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ACPI: ac: Use strscpy() instead of strcpy().
To: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 4, 2024 at 2:34=E2=80=AFPM Muhammad Qasim Abdul Majeed
<qasim.majeed20@gmail.com> wrote:
>
> Replace strcpy() with strscpy() in the ACPI ac driver.
> strcpy() has been deprecated because it is generally unsafe, so help to
> eliminate it from the kernel source.
>
> Link: https://github.com/KSPP/linux/issues/88
>
> Signed-off-by: Muhammad Qasim Abdul Majeed <qasim.majeed20@gmail.com>
> ---
>  drivers/acpi/ac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> index 09a87fa222c7..ad1427a384e4 100644
> --- a/drivers/acpi/ac.c
> +++ b/drivers/acpi/ac.c
> @@ -213,8 +213,8 @@ static int acpi_ac_probe(struct platform_device *pdev=
)
>                 return -ENOMEM;
>
>         ac->device =3D adev;
> -       strcpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> -       strcpy(acpi_device_class(adev), ACPI_AC_CLASS);
> +       strscpy(acpi_device_name(adev), ACPI_AC_DEVICE_NAME);
> +       strscpy(acpi_device_class(adev), ACPI_AC_CLASS);
>
>         platform_set_drvdata(pdev, ac);
>
> --

Applied as 6.12 material with some subject and changelog edits along
with patches [2-4/6] and [6/6].

Patch [6/6] needs more work (I'll send a reply to it directly).

Thanks!

