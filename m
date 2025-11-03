Return-Path: <linux-acpi+bounces-18470-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA0C2D8A2
	for <lists+linux-acpi@lfdr.de>; Mon, 03 Nov 2025 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 119514E5725
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Nov 2025 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BF92690D5;
	Mon,  3 Nov 2025 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/w/M1B4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1882234963
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762192399; cv=none; b=YRZoPl+Ad89wsuFvrNdTX9H9oh6I5e/F4gVK4pW3FrsMAtDbjqiCcdOv8a3nxQrkhIWUXaEqQYTkJ8A9cyTxJw4sVUzDOVaqQ2t8kMjFq1chhl95bFDkwtpJtA9XbmEa2UjNUDj09kh9tH42dyEspb8BfDQ1okJcyeeRkE0+cN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762192399; c=relaxed/simple;
	bh=kRz5NCFPt76Nzr5HVYhD8KPbHsfnEkUg2YPSu0m4pKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWV0YRoHkrBi7j4R/o0TCEE6UhqDEe8lLcu6ElXOP1SwoUKPJaXDiMey4AcOfPJkZSp/i3h1HTRelNaDpNKmLNPdqFJrlsvuXbafEdLXWgXA3VQOT9Tcz+yveoPZ2vYkwPqmSEYd9CdofWR4LEu0VeRl0n8RebxNTpCyld3so3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/w/M1B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D429C19422
	for <linux-acpi@vger.kernel.org>; Mon,  3 Nov 2025 17:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762192399;
	bh=kRz5NCFPt76Nzr5HVYhD8KPbHsfnEkUg2YPSu0m4pKA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J/w/M1B4l0FKMNWXTEw5ghSr/3AI0+1LTk2u1zgvfffCNkzPiiGuY7F98TaI9MRwz
	 zNdnGCqfxDbAyA5lJ8dg1QepmMjdJi2jY+yaI1/n5c+GZ3qtMWnM0mAQmyfrMWahY8
	 2rIaoBkOt0GBypUv8RdQhNgu8zN5t+l58ue7iyZBS7Xv0o0nikqBz5D8EEHQX56KZi
	 guAfS/Hlnh1uoylTBvYf1ITNEDT4OkGNhniokSYr0sfc39oKGWU5OPiS5BsJ4gwc+R
	 C7b+JPttfhKw45s+3DsIRIywEh2rTl1b/ol3/q1u3IU5AwpbM42/Gj9bK+qAH2hccL
	 eYWba1cCsQVeA==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-651cda151f0so2465058eaf.3
        for <linux-acpi@vger.kernel.org>; Mon, 03 Nov 2025 09:53:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVhxNziMUfvIPBSuH4J0PLDTaIHkgtYiSbQKqaWu0RNT1uSlJqtH0UqVA2aUsm/8rXeZrNmL2W6Kqce@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+qYVO15dkbxvKhGqS20LYEVzhPcbU/aVvzQyAjczXzRS3Dczd
	EqTim8CXUsPL/iC4NQnoKLDXUex6DcyjI1t06d9Ife3fve5G82d1yHslXeAiErMrqbre/0MwhTo
	U8DzVwQDqflIZ7oV1Ln8T7mj0Y8NLaTs=
X-Google-Smtp-Source: AGHT+IEcXdmOQmN3JBxBZ4sFhRKt3lfebjC6JXBS82nSOaQqB2VCsAV/E2V2MrwJZynvhgkroY5ZCPVIuiZl0qK7PdQ=
X-Received: by 2002:a05:6808:2223:b0:44d:a8aa:f0ce with SMTP id
 5614622812f47-44f95e4d17dmr5695525b6e.6.1762192398819; Mon, 03 Nov 2025
 09:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103084244.2654432-1-lihuisong@huawei.com> <20251103084244.2654432-3-lihuisong@huawei.com>
In-Reply-To: <20251103084244.2654432-3-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 3 Nov 2025 18:53:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1z6sUiP5LOWCJJoCvJzo5oNUgdA3de2rYA2n4NWBbeQ@mail.gmail.com>
X-Gm-Features: AWmQ_blEbNIQIA-ct9hEgY2GhrWwVlvQNOQjDLIeMGYXslETbTALuji4JhiyNnA
Message-ID: <CAJZ5v0g1z6sUiP5LOWCJJoCvJzo5oNUgdA3de2rYA2n4NWBbeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] ACPI: processor: idle: Mark the state as invalid
 when get lpi_state->arch_flags failed
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 9:42=E2=80=AFAM Huisong Li <lihuisong@huawei.com> wr=
ote:
>
> The architecture specific context loss flags is important for ARM.
> And this flag is used to control the execution of different code
> flows in acpi_processor_ffh_lpi_enter().
>
> So mark the state as invalid when get lpi_state->arch_flags of this
> state failed.
>
> Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Power Id=
le(LPI) states")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/processor_idle.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.=
c
> index 9f1040eac051..5213a545fa78 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -983,8 +983,12 @@ static int acpi_processor_evaluate_lpi(acpi_handle h=
andle,
>                 if (obj_get_integer(pkg_elem + 2, &lpi_state->flags))
>                         lpi_state->flags =3D 0;
>
> -               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)=
)
> -                       lpi_state->arch_flags =3D 0;
> +               if (obj_get_integer(pkg_elem + 3, &lpi_state->arch_flags)=
) {
> +                       pr_err("Get state-%d architecture specific contex=
t loss flags failed, disable it.\n",
> +                              state_idx);
> +                       lpi_state->flags =3D 0;
> +                       continue;

This is ARM-specific behavior you want to put into generic code.

I'm not going to apply this.

> +               }
>
>                 if (obj_get_integer(pkg_elem + 4, &lpi_state->res_cnt_fre=
q))
>                         lpi_state->res_cnt_freq =3D 1;
> --
> 2.33.0
>

