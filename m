Return-Path: <linux-acpi+bounces-13656-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1554FAB1C25
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 20:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86CE5170F1B
	for <lists+linux-acpi@lfdr.de>; Fri,  9 May 2025 18:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0313522F166;
	Fri,  9 May 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iol9ECPQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8788366;
	Fri,  9 May 2025 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746814602; cv=none; b=puioKkWnT7k7sNClyyFQpUfpBxsnVDvTO4xuUCFWODnh+vGZ8vUw/Tn5JlpF7DT3WfZbBJ1zcBtlTe0u5vnSoGjmWZchQPFgJGq90+z9BIsakENPJ2huodaxSgP6cJY70mfwIgEuWc/gh9SNOQ/WF9scFe22tAUDsJa8aGGyQfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746814602; c=relaxed/simple;
	bh=4db0ffyZ6ZlK/hKC1+HVVn/FLoYOK7OSjsI1t3sCLoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GybozgScccty78tJ8nTOl/ea8H7X+znoymMOrMngIR8Kzyj07nBllCb6oChXEyO/py1IcBO7Kj5ueueaAPyMOTi6zkaTyxz/9vLDlYs66Ix3SQsmHVtCFTYAET+QsmB0gprOoGo/c6B8mKDKAoqoyh8AS3ZDneGbBdscDmG7XQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iol9ECPQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7FFC4CEEE;
	Fri,  9 May 2025 18:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746814602;
	bh=4db0ffyZ6ZlK/hKC1+HVVn/FLoYOK7OSjsI1t3sCLoA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iol9ECPQrn+h0Vh6sz5x69StylmsQWUw3krctN81fGyqs9z9lbSv7n3ilYNAXHI9/
	 H9cllQZatGSOJIZRdsRIwppLydq97lY2lOWuc0dDJ2tmEoOtB7gvJTPx/Gh9Ajne0I
	 36IBdKaW3kF+0LdC5UIACFALbmw68tuOztybpuWRPIe0BN4IVWf8pgMiejDXeeFt7b
	 kUMdGUgwOvjAt+lbedgDyghPxioMqCfAMvi6mN3Z7sa7cH08sF4YMnRKkRSjaiNObv
	 Q7aSsFK02Ege3kSfRNrFxXW+VJtoJltSmWP0j0KpPrlw9Y2VdTWNo7hhXObdcwY9+l
	 RSsFRKP4Gfdkw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2d4f8c42f49so2079865fac.1;
        Fri, 09 May 2025 11:16:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUzHokUbYfTqw5aLUoDti4ZQ7qGLgkpbfhcLVhA98Xy1hVdbbB6ul0Fp5bcOj97vGp7UgiIrA5nDoTXoRzL@vger.kernel.org, AJvYcCVbnekSpIBpiaUtLGZPiNFCUHBLn3dxbV2kZpuSyDFlcablJCNfuA8VRRzxABpARsr5j109B4He@vger.kernel.org, AJvYcCWcv5fRh2dJbl3M9anmYh4apsd8CeO8R41PiN+oTfCut+ul/cQMmu3rBrmfQLc83cClw3UUdjrpiVin@vger.kernel.org
X-Gm-Message-State: AOJu0YyknOi+QLVTKCspX8Y4AmNyj4ZlBqMTDLzfqMoGlhEYVirLjhcB
	HVhx4hCgep2TtTdF/gaD4p+G3YYeb93PGR6VmZcQCfDox8tvSKZAp5XZxhm7bIqWZwdbZ11cvZJ
	FmhF/NdU82KuPDZDEI9TzZ09SGoE=
X-Google-Smtp-Source: AGHT+IHLajxModkuKvg1vNWCSGkmFnN3bnSLzw735Pccv/Lt+iE2xpGn1NCsbiozWd1eosGEe8y7nH+eZe7+TuJ3ZVw=
X-Received: by 2002:a05:6870:596:b0:2d4:dc79:b92 with SMTP id
 586e51a60fabf-2dba55bc402mr2294716fac.6.1746814601884; Fri, 09 May 2025
 11:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417073947.47419-1-jeffbai@aosc.io>
In-Reply-To: <20250417073947.47419-1-jeffbai@aosc.io>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 9 May 2025 20:16:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jLoXSCTzLpP4MkLwu9tvUBbO04ZgoJHq_8P6nWQWFWWQ@mail.gmail.com>
X-Gm-Features: ATxdqUGGfJhKpwzohwWCSsK4mQ3r3XDpJAoT0Z_cfRX_fXOgAJPqm9_KZMT3cF4
Message-ID: <CAJZ5v0jLoXSCTzLpP4MkLwu9tvUBbO04ZgoJHq_8P6nWQWFWWQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: fix a typo for MECHREVO in irq1_edge_low_force_override
To: Mingcong Bai <jeffbai@aosc.io>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Kexy Biscuit <kexybiscuit@aosc.io>, Runhua He <hua@aosc.io>, 
	stable@vger.kernel.org, Len Brown <lenb@kernel.org>, Li Chen <me@linux.beauty>, 
	"open list:ACPI" <linux-acpi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 9:40=E2=80=AFAM Mingcong Bai <jeffbai@aosc.io> wrot=
e:
>
> The vendor name for MECHREVO was incorrectly spelled in commit
> b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M").
>
> Correct this typo in this trivial patch.
>
> Cc: stable@vger.kernel.org
> Fixes: b53f09ecd602 ("ACPI: resource: Do IRQ override on MECHREV GM7XG0M"=
)
> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
> ---
>  drivers/acpi/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 14c7bac4100b..7d59c6c9185f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -534,7 +534,7 @@ static const struct dmi_system_id irq1_level_low_skip=
_override[] =3D {
>   */
>  static const struct dmi_system_id irq1_edge_low_force_override[] =3D {
>         {
> -               /* MECHREV Jiaolong17KS Series GM7XG0M */
> +               /* MECHREVO Jiaolong17KS Series GM7XG0M */
>                 .matches =3D {
>                         DMI_MATCH(DMI_BOARD_NAME, "GM7XG0M"),
>                 },
> --

Applied as 6.16 material, thanks!

