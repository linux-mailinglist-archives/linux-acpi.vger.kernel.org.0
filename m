Return-Path: <linux-acpi+bounces-3416-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB05B8515A1
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663E6288595
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Feb 2024 13:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C8C4439E;
	Mon, 12 Feb 2024 13:38:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B912E446C6
	for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745121; cv=none; b=R2df4NONTZB8c+UpPAOirkknpx1HRIq9UfaR8HuqYX0GTas5E/J65tXpDDAYCHxWbpSdNtH/9oIdsqUiILEfsBLEh8HBJ/4+8txX9HPgLtLkx9MIVkvbjiM2sDJC+7sH426yZ3NDDxsA8YhH+uku5etDgiZ1Gndr/1a6u/qy5Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745121; c=relaxed/simple;
	bh=Tv+rZN3c0yAaCzNpEQ39WIKdzCZsc4gnkhqK36Aj9V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hcq1fMFqukZByOh2DeUi2Ipx7mjNcEW7YxK8mUbQBNTPAaJ4lpbRZjiZv0TPtT3nUBJRHPivKMmi4givZEG3sCzi8sT2384htc4LXRwMEBROspRAwU89YoM+snRUuhSt9qdAOdbCou0LyUQ6HBX0nWAT5MyY/suzl9IppBOyNi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59584f41f1eso1347504eaf.1
        for <linux-acpi@vger.kernel.org>; Mon, 12 Feb 2024 05:38:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707745119; x=1708349919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTsyxjARW0EsskB7PhCXr+hS0dPV5PwVgeA2725p3vI=;
        b=XKEooWPjbWtaKLpaEHo1qjtl+2g2971/6rdVyAM3CditlJlzwHDtbEbhU4YTH4FbbG
         qMKZf0EUtnpkxgS7JKN5tBGXLUCt7xm3o+wZ/zlS16+zOAfB6+zu/4DLKFbnJUY6islT
         3uBKX2bTV0aUYNIe51keUoj63rdt5d2PHny3DS61bz2gaePSDEfMFPUxu2FOpq+D+HUV
         3+5iqLY6dmyMjr51bjOQ1vN/HJza4LTyXtgHcuJqPssIFEFNvMUX5lPQeV+9QtcDyYUc
         TX+UziZUA6KKjhYLwcAd3PnqZBncZasR0yYE6rTeAFYNDkFWn4QPMnhWyhEASU2tT0df
         s3sg==
X-Gm-Message-State: AOJu0Yx+lDPr6hxQOmhsFP0wdBa19XVqxNbiLUCpL3PVQUZ6u9DTt07I
	USdLio5ii+SM8d2V3wva5lAnVra/LjyELRF5BYfRbCa6AimFbYJ46OreEyXOTIapwtfPENRFrzv
	Rv7neHR3YsdEbNpTGjZ5I3ib6dw9ofAGR
X-Google-Smtp-Source: AGHT+IGk3dXHbg9oGc4qo2LOM2yo+NvkIrYllYCwWkU9Tn8AiZgKOgFS/ehUjMXrCaXAO7zGv5VpIwzGdoHroid2Fiw=
X-Received: by 2002:a05:6820:2b12:b0:59a:bf5:a0da with SMTP id
 dt18-20020a0568202b1200b0059a0bf5a0damr4757504oob.0.1707745118683; Mon, 12
 Feb 2024 05:38:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095700.165544-1-nicolas.haye@proton.me>
In-Reply-To: <20240130095700.165544-1-nicolas.haye@proton.me>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 14:38:27 +0100
Message-ID: <CAJZ5v0i9XbtC92BCZYazEUOVrYm_Bd_82NBjvTu399ko7eyi4Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1502CVA
To: Nicolas Haye <nicolas.haye@proton.me>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, 
	n1coh <nicolas.haye@groupegaillard.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 10:57=E2=80=AFAM Nicolas Haye <nicolas.haye@proton.=
me> wrote:
>
> From: n1coh <nicolas.haye@groupegaillard.fr>

Why did you add this line?  It is actively confusing, because the
From: field in your message header matches the S-o-b below.

> Like many b1502 models,
> the b1502CVA keyboard doesn't work because of an ACPI DSDT table that des=
cribes IRQ 1
> as ActiveLow while the kernel overrides it to Edge_High.
>
> Signed-off-by: Nicolas Haye <nicolas.haye@proton.me>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index dacad1d846c0..65ce43ecfa8c 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -468,6 +468,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "B1502CGA"),
>                 },
>         },
> +        {
> +                /* Asus ExpertBook B1502CVA */
> +                .matches =3D {
> +                        DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC.=
"),
> +                        DMI_MATCH(DMI_BOARD_NAME, "B1502CVA"),
> +                },
> +        },
>         {
>                 /* Asus ExpertBook B2402CBA */
>                 .matches =3D {
> --

Applied as 6.9 material, thanks!

