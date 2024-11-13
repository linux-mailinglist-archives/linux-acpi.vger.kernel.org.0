Return-Path: <linux-acpi+bounces-9543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE019C6EA5
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 13:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932F92819F7
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACC204001;
	Wed, 13 Nov 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2W8dYcu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FDA2038DC;
	Wed, 13 Nov 2024 12:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731499448; cv=none; b=cE4VVe0soCqj4PA2rTaq55ltS5F/RcR/rJ2zew4LV8iOB68+cy+njENIxkkFgDSK0OgykmP86sVtq06TBN1/Owgl4cDKLpizHpoWGHT7aK1mxHka9F/DEqyr+yN2Qu1ualN8lUn7l83L2UIOI3qYlsyZG+GbOohK7p3KWkYu1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731499448; c=relaxed/simple;
	bh=zimZ9HPJGkJizGvih0IRUV4F/vn8f9eeAOk9pvKpxB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AbGA/qRTD+/5IV1zB/xNusKKJvZ2o89+2gx1Fx2O2gIEq/BB7a5RQ3C3zQ9bqe4BGRTgWK86X3bUCdupyg7UgC6gY8AIbRzSxf+FDAah46X0N2eO/yL0NWtvxnaZu7XAPWjF+tfDhIxmIzAHG88A8+wBWSMt5k+DHkH1RuL05+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2W8dYcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCEEC4CED5;
	Wed, 13 Nov 2024 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731499448;
	bh=zimZ9HPJGkJizGvih0IRUV4F/vn8f9eeAOk9pvKpxB0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=j2W8dYcu/+VHe60hd193lvrhH8p3+8AlOzNxySEpCHzVerzGQWJq4N7TDRmd+8j0u
	 fnFyuzpgia+x13HtSsZc5/ABp5HCnPI/p5oYEIHy8Z1X/KWCMtNjO8J8FKThUvZgZe
	 lkC/cjKyTOPOZu0eBhQX5+YK2A9nwrNuBD1NXDg/u1Fs9zc1iYaJAA2cwWVb3k1vET
	 4eqZjahOCqR97QUMOPRBIDJ9662O/vl/mjZeh0hDWTf5qtdGTiPFvajJBV+aFPm7YH
	 iUwPI3T95DPEM0v5grWbVRN0loZVmdTFBMb5pZXDg6dbKZvfCKEDC0FxHsU2u8dlpY
	 qypac9AZlUnmQ==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2884e7fadb8so3392324fac.2;
        Wed, 13 Nov 2024 04:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXUse4D5kKvxoQEq8jt9Q/u6lrrYsTaDq5zbbVvRkOHaDy4bwMLi5up7Jz4VRL6ugzAEDZ3AYK7W3+x@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PoG/2VLs1futw8D68ne9mDPfJlYG9k/jBxNa1+xoCpW2EGUw
	U4quN9Al41vxCtw+Ruy3qr74j+9jAth/pHABhMWC7gU4gRnqwEUxBNtZv+PKdRPGCBxL6798wI4
	qBfi7WA7tsZ0DEQliEyXHhQtBpQc=
X-Google-Smtp-Source: AGHT+IGR3F9Ud9nAhyCawnQV7OOgqFhCKNKzqVF1mSBVYicb4T3jhpuZ8JFXB8nNZDZ14osz/3b6bBmSx0ZK2IeRmPA=
X-Received: by 2002:a05:6871:5213:b0:25e:24a0:4c96 with SMTP id
 586e51a60fabf-295600661d2mr17838227fac.11.1731499447257; Wed, 13 Nov 2024
 04:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid>
In-Reply-To: <20241112222516.1.I7fa78e6acbbed56ed5677f5e2dacc098a269d955@changeid>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Nov 2024 13:03:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hXbLaw7vqLGxjpnAgen4r1sz6neKWk2gEzi97DX95cBg@mail.gmail.com>
Message-ID: <CAJZ5v0hXbLaw7vqLGxjpnAgen4r1sz6neKWk2gEzi97DX95cBg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: force native for Apple MacbookPro11,2 and Air7,2
To: Jonathan Denose <jdenose@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, 
	Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 11:25=E2=80=AFPM Jonathan Denose <jdenose@google.co=
m> wrote:
>
> There is a bug in the Macbook Pro 11,2 and Air 7,2 firmware similar to
> what is described in:
>
> commit 7dc918daaf29 ("ACPI: video: force native for Apple
> MacbookPro9,2")
>
> This bug causes their backlights not to come back after resume.
>
> This commit adds DMI quirks to select the working native intel firmware
> interface such that the backlght comes back on after resume.
>
> Signed-off-by: Jonathan Denose <jdenose@google.com>
> ---
>
>  drivers/acpi/video_detect.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 015bd8e66c1cf..d507d5e084354 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -549,6 +549,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "iMac12,2"),
>                 },
>         },
> +       {
> +        .callback =3D video_detect_force_native,
> +        /* Apple MacBook Air 7,2 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "MacBookAir7,2"),
> +               },
> +       },
>         {
>          .callback =3D video_detect_force_native,
>          /* Apple MacBook Air 9,1 */
> @@ -565,6 +573,14 @@ static const struct dmi_system_id video_detect_dmi_t=
able[] =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro9,2"),
>                 },
>         },
> +       {
> +        .callback =3D video_detect_force_native,
> +        /* Apple MacBook Pro 11,2 */
> +        .matches =3D {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro11,2"),
> +               },
> +       },
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=3D1217249 */
>          .callback =3D video_detect_force_native,
> --

Applied as 6.13 material, thanks!

