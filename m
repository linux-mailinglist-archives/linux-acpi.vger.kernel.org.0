Return-Path: <linux-acpi+bounces-13663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB66AB1D3A
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 21:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA63B50634C
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 19:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F89525CC5A;
	Fri,  9 May 2025 19:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ucxRDLJQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566D25C82E;
	Fri,  9 May 2025 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746818492; cv=none; b=a7SS3lAQRZbNUGoLBEXaKcdjkquDm0jYwm6iXvWfwFL2SPsuiZoGbTVVoEvi79w2rdEG5s44je1ducb/vBMcSnt0dy1GGCxbi86ND0vsA62ORKvNj69ZdzFbya/QEYYKgciB12mu2xKXyMI/Ku9Rf4f/+/n+EgVCJPf0R1W4KLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746818492; c=relaxed/simple;
	bh=78mBXi9qO6qcRLA4DTbvOKgTYqTpkwc+nO2qiF16nuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUXDCGhcxR1Ka813ZsLvHsCs4K7Shq/OSQgpvr93CrAo99K4YTYRneWHz4MzE97vlBhIRzI9P2kkmTfaIzaNFR0gF9tPFLHEuFpL1Udc5yyGPyAAnLJI2ezOuiM25S3p6DcROfWvVx4hOxFt+PxFGJzGszRrf53AuMkzXXoe5Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ucxRDLJQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66092C4CEE4;
	Fri,  9 May 2025 19:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746818490;
	bh=78mBXi9qO6qcRLA4DTbvOKgTYqTpkwc+nO2qiF16nuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ucxRDLJQVF1vTWWDpK0jp0GsHkw4jWOdt7TstoDmotZh/t/rV6tbRAkn5Mb8FboKQ
	 3Iwnv5XGn1nIO9LkYVnn0W3qJykvXQK2zk3VIrSmDHzjSWcJXcl30EPg7OKG+xdlfr
	 8YPqIF3C+9/bCi+f8ON2OU835vORi1G8obEMjbvn1iouL3EG/vqkN/YPDslxyk6L1G
	 pStUVL3Kbpv8ugV6iq0VukxGgWrmbGBI4CiIOMtdrdzVPKQ3088lNd0EqV8qU3KzAV
	 E6IDocSIsuVpuxia+QiYcuBcFo70KiSfZrTuBVVvB41+EC+/Pxl9D2WCGc0el32P5s
	 2wGbq7PdRJa8w==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2d54b936ad9so1127027fac.1;
        Fri, 09 May 2025 12:21:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX2Dl7NTOo8NTI9Y4JkoceznRsAId2AIHxmUBc++x5UFJA1CO1G83NrQUXWHG8uKNyGLMXzmYgwhvYcyjzG@vger.kernel.org, AJvYcCXHfDgkb/YwzhOCINs9VJJiRrdZgmbp773ZPDJg/IqB7WwUpV07BzF2Wbd/6psZE9dlgSTd3Jup/pfE@vger.kernel.org
X-Gm-Message-State: AOJu0YxllCdCtFhgQlPHTMCUu4gWBNXf4sK/E+KZlFbeH0ux1VdiTngD
	tOpgkAqvqRhGm40pfq/i+PRpdhX+KlJQ7QrMksnXZICorBLXOIoSCWFjTeHSFYUWuP+pmGGNyZP
	m1KZ32+tasryRlJDSOkLtnl7EBQU=
X-Google-Smtp-Source: AGHT+IE06Zct7yQAKfnLNm6gN+Mv2ys68hsbRR1uSoRCw37UOZC5An9uVI/MDRoE8ibL0g5hrkR/qXZ4EQJHYQrpv0Y=
X-Received: by 2002:a05:6871:80d:b0:2d5:b7b7:2d6e with SMTP id
 586e51a60fabf-2dba45e8ce5mr2714795fac.38.1746818489728; Fri, 09 May 2025
 12:21:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508111625.12149-1-wse@tuxedocomputers.com>
In-Reply-To: <20250508111625.12149-1-wse@tuxedocomputers.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 21:21:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com>
X-Gm-Features: ATxdqUE0GH5Baf3x4WtsMwgeJqGixifeCFcTJu45KyqyICB0g6atnB_TAXRroN0
Message-ID: <CAJZ5v0g+_8LT6YKSuOXHtxE-HLCZ2hxKuT2514HgQ45xyWy76A@mail.gmail.com>
Subject: Re: [PATCH] acpi/ec: Add device to acpi_ec_no_wakeup qurik
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:16=E2=80=AFPM Werner Sembach <wse@tuxedocomputers.=
com> wrote:
>
> Add the TUXEDO InfinityBook Pro AMD Gen9 to the acpi_ec_no_wakeup quirk
> list to prevent spurious wakeups.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  drivers/acpi/ec.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 8db09d81918fb..de45a5b59effd 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -2301,6 +2301,12 @@ static const struct dmi_system_id acpi_ec_no_wakeu=
p[] =3D {
>                         DMI_MATCH(DMI_PRODUCT_FAMILY, "103C_5336AN HP ZHA=
N 66 Pro"),
>                 },
>         },
> +       {
> +               // TUXEDO InfinityBook Pro AMD Gen9
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_NAME, "GXxHRXx"),
> +               },
> +       },
>         { },
>  };
>
> --

Applied as 6.16 material, thanks!

