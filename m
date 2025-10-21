Return-Path: <linux-acpi+bounces-18057-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628BBF8472
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 21:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE00E18C72F6
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3281A26E16C;
	Tue, 21 Oct 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzKmvT3U"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA27264A76
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761075409; cv=none; b=jsIUw7ZhobxJYGhe2jcKrnqK6MjSL9MujbrIUWFpgO1MWOvFP+tUn1hWNGkaiAIK2I/r+5CQgNCSBL3gGOnEZ3YEQ8yKXAsCIK1fYhRq6iaIFlOUj7w3m2TSSRPDkPUhIkyH3Ve0g1E1zw85H7n4CDoXNrEediNiotwv4bSMQ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761075409; c=relaxed/simple;
	bh=fD53NSeheVGD5ilvGQlQJ3w4BfULuDpC7tDXATvYvyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I3DuMdJSiFbnmLpYUlmAPTy8nfrdWDFvyO3Gezw9SonAA0yLgh+wzXgiCbGk5rOoGBEWsUIQO4/b/T2G3l3wC0lP9W92g+VXX1qXL8bG6lO3uOBZK9I7RHhh0OuveR+v7JJPInWtQO0IqGikKDrv18P20tXPD/8QJZwB7XsxB74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzKmvT3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D8AC4CEF7
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 19:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761075408;
	bh=fD53NSeheVGD5ilvGQlQJ3w4BfULuDpC7tDXATvYvyk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BzKmvT3UVMf1vnnvtxIKl+hWheRSPxOu+MLvYWAXBkCArnEtqo0TH59hk3dHcIeeh
	 g5TDL6Ty0t1ODwlEU2T+50yP9ubr0DoyjNXRNJyqNNdMcBcgFEWKpe5zEaNDt3fkt6
	 7qaQFMg9TT8EYHUUcCHku+LZM6BAeNppFuFr9wrEnw7QeMirKm3HZ8dWoS9amhGpPr
	 s0RgDjm/lgRtVJzqXxw7rI89rN8GrsTtOiHp6ouTuVdRw3g5MrT/ARHxTwGF3USGun
	 19VxRMPnl2kZ75TGtZQBDkEiJDerwL1NKWSZUWXkMUzv6lefSt4Hd+ZDu76XPlgiWE
	 dun9LCAJ63o+g==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-651c521980cso3085606eaf.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 12:36:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW24PCI+amX3SdpbowEssomsFt3UEcraYxvhmzlJ3krJSeE1GMdVkABNbaGm2L7+9mgNdBEu3NljWhL@vger.kernel.org
X-Gm-Message-State: AOJu0YxflLBRGLfZfW/AiTuUNlxprN7bWqS3KKYtL+SL6P1NxeEfd5I/
	OAnLuwI0UC/ZdnP4U5kvR2nrSpJ4rtCr8Q2VN+5H/1sGuoLPAAPF5urqW5zb1N/Pq/EoeZGwiV7
	ITVIVTj40G94JCTh0vAN+oSuwiApD0Xc=
X-Google-Smtp-Source: AGHT+IFdFB1NU8Lb0ZeOSJsZphamzHl+1d7l1lG6nQ5xDsp8+ZzuFVZhzR2PIKrxfCr0ImNXbNZc4JLg4AlB6LaMaFs=
X-Received: by 2002:a05:6808:6c88:b0:439:b9b4:2d77 with SMTP id
 5614622812f47-443a30e144amr7768970b6e.34.1761075408021; Tue, 21 Oct 2025
 12:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929093754.3998136-1-lihuisong@huawei.com> <20250929093754.3998136-4-lihuisong@huawei.com>
In-Reply-To: <20250929093754.3998136-4-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 21:36:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
X-Gm-Features: AS18NWDKUPYpjMI2_yN8FWJU_8eX0_kVDFH6sFPwxkCyjIdFMyu8WfmwbxaPnyw
Message-ID: <CAJZ5v0hNj817g=rr8+YTGaeBkkfNuuU7FGuZyyb1j61BMOKTGA@mail.gmail.com>
Subject: Re: [PATCH v1 3/9] ACPI: processor: idle: Return failure when get
 lpi_state->arch_flags failed
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 29, 2025 at 11:38=E2=80=AFAM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> The architecture specific context loss flags is important for ARM.
> And this flag is used to control the execution of different code
> flows in acpi_processor_ffh_lpi_enter().
>
> So it is better to return failure when get lpi_state->arch_flags
> failed.

A failure means no idle states at all.

Wouldn't it be better to skip the state with invalid arch flags?

> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 681587f2614b..f36f9514b6c7 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -984,8 +984,11 @@ static int acpi_processor_evaluate_lpi(acpi_handle h=
andle,
>                 if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
>                         lpi_state->flags =3D 0;
>
> -               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)=
)
> -                       lpi_state->arch_flags =3D 0;
> +               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)=
) {
> +                       pr_err("Get architecture specific context loss fl=
ags failed.\n");
> +                       ret =3D -EINVAL;
> +                       goto end;
> +               }
>
>                 if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_fre=
q))
>                         lpi_state->res_cnt_freq =3D 1;
> --
> 2.33.0
>

