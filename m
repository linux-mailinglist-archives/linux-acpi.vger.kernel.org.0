Return-Path: <linux-acpi+bounces-8101-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12E96A055
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2DDD281365
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279866F30D;
	Tue,  3 Sep 2024 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBM235gS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F6D54BD8
	for <linux-acpi@vger.kernel.org>; Tue,  3 Sep 2024 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373458; cv=none; b=LnE6t7Wb6FWS5uELBWJg+H7KxTpiIWhZVGx7kZBhK8tOxPgoeCkZrntbvSr7P+BNpV8UIAqozON5J289FU1S1bRjUYgoTadCSr1uPEig9chXTf9AJ40wRy6Y3PQvCKj/AKvAU+Tq4a1byz1iz6vx4UEbw/zxUS2YAAvJn/gIh/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373458; c=relaxed/simple;
	bh=KnoBDT2kkMcFjv7DNQPU3i6KJHOALL98MmlRgoFn7CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bMIC73dAK/e7Z19VF301+ai+9uxyxqc/UyNO+SvlNpA+SxZiiDC/hfrNmHB7roVXJYTX2vfeZf1IWcd207ppd5XSDANGPXpGO5PSRlVnGbkPP3vZ6R7EeuXJaTZgtGpQm51D1y/0Sc/WqPLfWBejv/v6dot8Y1udqMQbdoI8Wv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBM235gS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935A9C4CEC4
	for <linux-acpi@vger.kernel.org>; Tue,  3 Sep 2024 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725373457;
	bh=KnoBDT2kkMcFjv7DNQPU3i6KJHOALL98MmlRgoFn7CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HBM235gSuevhC/5o5Qxg8Yb8kduZQeAA8nG49R5AFux/EeUaEBtXZjv5aeMEmjYjQ
	 zICyJntsQRFTdnKpNDq1EcGZiX6gTa2/8dxb4hoxXCElo17cVtwkJaNWWK3Syx36YP
	 epGOj4LUVOYSsnJbaHeFQPtdTlNmln3dSwQ/joFC5DjiyCvye1PgvjURomvvrSoCDk
	 Qdwj6KZzDPoGbTDKibSj8x2L54Gq2KJXGeW2ZouPNOcVtkd9zUafcFVhKxlsNt+Wu5
	 O6ReYY1sWFx84dMCtOtrHxbCdGH2SYqbnnZuTuvsQwdrt13amSyOfN1yZAq0fHL573
	 s3jxIRmjVbGcw==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5c7f24372so3253076eaf.0
        for <linux-acpi@vger.kernel.org>; Tue, 03 Sep 2024 07:24:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yybvmh/wA5rOAR0HPGHCPBIbOyo59r3/xBrzqzIjoqiwnyO8IuN
	IcgHBCCHekkrZC5vc81UrSJ1vDzYSvp7f36R1h0cIWJLFniBt9JAySyC4VkN2pL/ld6rObQIiZ6
	EVpm1JbGdhobDwT+HOHUCw62dES0=
X-Google-Smtp-Source: AGHT+IEnpQPwjHHCih3d3/25M8sIU8MNfBJtZJxH8XT8tmshNAx+y01T6DU7pzVv7XHXXrkWgrOVLi3b6I4tOuJNF4o=
X-Received: by 2002:a05:6870:9d98:b0:277:e6bc:330c with SMTP id
 586e51a60fabf-277e6bc3a0bmr8934400fac.29.1725373456978; Tue, 03 Sep 2024
 07:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240903014317.38858-1-tamim@fusetak.com>
In-Reply-To: <20240903014317.38858-1-tamim@fusetak.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Sep 2024 16:24:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQj7bxbJPtVsCaQRzC-VN0JQWyx1KNqnKTS-v5dyzsSw@mail.gmail.com>
Message-ID: <CAJZ5v0gQj7bxbJPtVsCaQRzC-VN0JQWyx1KNqnKTS-v5dyzsSw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Vivobook Go E1404GAB
To: Tamim Khan <tamim@fusetak.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 3:43=E2=80=AFAM Tamim Khan <tamim@fusetak.com> wrote=
:
>
> Like other Asus Vivobooks, the Asus Vivobook Go E1404GAB has a DSDT
> that describes IRQ 1 as ActiveLow, while the kernel overrides to Edge_Hig=
h.
> This override prevents the internal keyboard from working. This patch fix=
es
> this problem by adding this laptop to the table that prevents the kernel =
from
> overriding the IRQ.
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219212
> Signed-off-by: Tamim Khan <tamim@fusetak.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index df5d5a554b38..c65c72c515e6 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -503,6 +503,13 @@ static const struct dmi_system_id irq1_level_low_ski=
p_override[] =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "B2502FBA"),
>                 },
>         },
> +       {
> +               /* Asus Vivobook Go E1404GAB */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "E1404GAB"),
> +               },
> +       },
>         {
>                 /* Asus Vivobook E1504GA */
>                 .matches =3D {
> --

Applied as 6.12 material, thanks!

