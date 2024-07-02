Return-Path: <linux-acpi+bounces-6742-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5D924769
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 20:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E981F1C24E97
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DF1CB301;
	Tue,  2 Jul 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqct6og+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68E71DFE3
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jul 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719945739; cv=none; b=L9FiS58zbbhGQE3skUIIq6+CqeMCGuZm35fP3O0+p0gLYK5U4q6cW9VN1qcHGkGqOt4kSQa8FmzvZJGNq/3Uyl2//sCsMEk868sxxkJaNgronP/o6HiRFbX2Eo+nKbFNLkH5PywsJeiZJ3PP/En9oPtPEMJVdt70OtawuYhSHIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719945739; c=relaxed/simple;
	bh=b2BR/UYprBae4j1tO65LFVYKqbFUb8Ys74+QV/tUexw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PdkaGx8xTqbh/FThGSCxY/9CEHQ/MR6JED8IQeaXVvhLQr9C8bZ6vsIKPWjjsXegmjdHI9vXfmc6crLrsuFAMnOfmre7EUfZL6sz6KNI1OLr2IICxiHPNeZpJY/g0jPbj1PSYYvj8AtytPIE48Hh2vcu5fSF2qsrdePrRj+9eFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqct6og+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6357AC4AF07
	for <linux-acpi@vger.kernel.org>; Tue,  2 Jul 2024 18:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719945739;
	bh=b2BR/UYprBae4j1tO65LFVYKqbFUb8Ys74+QV/tUexw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zqct6og+yolwNe0kGL2b2tvJi9RQPeusrIzXIZ7fy/7iL4n7+N1q0i/4K2kUtDVxf
	 NGzo8oqg5YVOdRAYOhOpeOlXFvYG1lBSkPtnzz1x0rM4Io5sSPJh3Tn+Ge63g6wvz/
	 JKoJiS3yll+sWIOGykWon2Nh7an+kKAHZ9np42LfT3MafyUrtlcpWC7SrBnH/MmerB
	 YCtwOoVLMli3ESWlpqJd6JlwjzgrmjYVfeQ+y4wvVo/Vti++SIvC4gwgAuZeBZCBo6
	 Q/VrR0fx4+5yG0fBv3m5eEkHPv6aQO5LV2HnofDqiB8BCvcRgcTS7UoLKmFb3YfCqu
	 Ab+uaR+zAwCMg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-254925e6472so649018fac.0
        for <linux-acpi@vger.kernel.org>; Tue, 02 Jul 2024 11:42:19 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx9Ahq6Z+qFYQwVm3O0pUyKJ43KLjOkPk+W1yZy/YGeX1mv0zC9
	az/LFtK9WwaQVq077WyJVBfSHTB+1zYPMWClbpluhQZXmHIgVQSfFtF3HAUPnuZNr+H7/nSvTRh
	1oJttJjxldNsb7a5EMlbBG6R/B+g=
X-Google-Smtp-Source: AGHT+IE5dVPBpKbKjtXBaYIdBWLmiS6pfRf7jj7YgOEPtCZcCmUUJM/dMOdxEapIbWJeF/E5hE9ywpr23T5k5Lc83Ig=
X-Received: by 2002:a05:6820:ec6:b0:5c4:5cbc:b1b4 with SMTP id
 006d021491bc7-5c45cbcb217mr4106208eaf.0.1719945738668; Tue, 02 Jul 2024
 11:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702125918.34683-1-tamim@fusetak.com>
In-Reply-To: <20240702125918.34683-1-tamim@fusetak.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jul 2024 20:42:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iHVx+7Z2QTRncZPGZg4_F7DPQojFrE43qXuqaaWn=QdQ@mail.gmail.com>
Message-ID: <CAJZ5v0iHVx+7Z2QTRncZPGZg4_F7DPQojFrE43qXuqaaWn=QdQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Pro N6506MU
To: Tamim Khan <tamim@fusetak.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org, 
	Lefteris <eleftherios.giapitzakis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 3:00=E2=80=AFPM Tamim Khan <tamim@fusetak.com> wrote=
:
>
> Like various other Asus laptops, the Asus Vivobook Pro N6506MV has a
> DSDT table that describes IRQ 1 as ActiveLow while the kernel is overridi=
ng
> it to Edge_High. This prevents the internal keyboard from working. This p=
atch
> prevents this issue by adding this laptop to the override table that prev=
ents
> the kernel from overriding this IRQ
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218954
> Tested-by: Lefteris <eleftherios.giapitzakis@gmail.com>
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index b5bf8b81a050..b3ae5f9ac551 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -524,6 +524,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "N6506MV"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook Pro N6506MU */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "N6506MU"),
> +               },
> +       },
>         {
>                 /* LG Electronics 17U70P */
>                 .matches =3D {
> --

Applied as 6.11 material, thanks!

