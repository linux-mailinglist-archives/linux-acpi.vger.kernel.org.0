Return-Path: <linux-acpi+bounces-13912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF4AC4FA5
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 15:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB12216F82F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 May 2025 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166BF2698A2;
	Tue, 27 May 2025 13:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqtRhEH/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D916B271453;
	Tue, 27 May 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748352253; cv=none; b=oBTCZTeInC5pNeCKXZ/+tEooDPM99r45x1taHPrzsBqEMHHmL2zJpWYfvKo/Hp60jL4XE5guhxWazFEjWtdt5tNd0N9usDx4yO7GXTsRJdskl32hWEFdZeAZSDknRPDPy141Em0fIUu/evo7G6y0+7eCo4yZjN7spsAHCPhasRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748352253; c=relaxed/simple;
	bh=XsBlf7WXvfFgBBQgPmdHNCENHxGOBUYgPaG33bCFV2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pff1wgtCeZ9hw5GvnVP6IhMMHiyr1qCRyaFEPktvGFFE4DB3Q4l6SczUVHO/5oMiINVusOmpSmR+ruTBmUQTEJpmRr2vPaAeJleupMCYWwz8Na/1ntv4E8cUOQP0m4CfvVPCkEgNbn189zBHG0ieJ9wMFh4r+1acVDjVTorVXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqtRhEH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 475BCC4CEEB;
	Tue, 27 May 2025 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748352252;
	bh=XsBlf7WXvfFgBBQgPmdHNCENHxGOBUYgPaG33bCFV2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fqtRhEH/KwDS7n/mqOOQVqEBY6MGx98uyAF8s7ki4VK5k0fuKT2DOPEh1Tq2NAKQ3
	 gutNaa5VbFvu2bh/IeRbhcRlXUPgHmlmMKNF/iaRsgTsl+ah6EX2RpKiuRo7h/Vi+W
	 159+0fblOSlCsaS/EBjVvQG0naZVAc0KQw8UHYT6gWI1kLC1sSS/xzGQ/6oyAybWyn
	 eUCg+JZCzwODXqMVVoDzPN2PM8CEDYX8wh2DIEBLpM0pYep/i+zs2nCgdLCN9hu51+
	 UnOYRyI3FWEtsAML1RJWQazkA7XGmZhQ8Bnr71LQyVEs4CP/v9MbTsm+kBJC4Ln5dZ
	 evnWMvWd8K03w==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-60634f82d1aso609116eaf.3;
        Tue, 27 May 2025 06:24:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGvOdQ72h6wEnZuux33cqKDHK/MmX7rBM6VBNMAgvjwytY830sKb38vhM/3hKaQ1HikI/LPvj1RZ7WMvf6go8=@vger.kernel.org, AJvYcCW/k7/LUlue9V9MJ7jXeWqg8ZbumbGGe37HbNxJmcd5WmZJtNAhBjDUAZ77F9aoM7w6LnRx9PM4fov2ew==@vger.kernel.org, AJvYcCX0TacuVU8nMUpRlO7cUUOH1SSX6pkIZxIK42mtyrsr4Be+iyGaforcGHt7YbgWb5wWu2FmxJip1wPHhMVq@vger.kernel.org
X-Gm-Message-State: AOJu0YxSAra744b2eyH1PdTe8LpzDI2WnF5OsMLH9frNcj0WlM3UKJ40
	0bJgLIGqHULs6aT0hmTGG4pDXso+1KZUNuAhAmSf3L/IcmGMQs1VNMmRREEJTlbTCMQXZUAtEji
	yIiydhXqbLekbAc4bEg6i5BDWEVdwGJg=
X-Google-Smtp-Source: AGHT+IELYeDaU2ll10Eg0xztB9NjW3N3H4cq+fFMup4Th1x9ZCLSD/Z6plyAOjeWBCbgiRXcA6Zzs0BAVs44XuW3ulE=
X-Received: by 2002:a05:6808:3388:b0:404:dd07:9703 with SMTP id
 5614622812f47-40646845720mr7583667b6e.26.1748352251633; Tue, 27 May 2025
 06:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aDVTfEm-Jch7FuHG@stanley.mountain>
In-Reply-To: <aDVTfEm-Jch7FuHG@stanley.mountain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 May 2025 15:24:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hWKbC2eEe-ce55PN0k4bYnPJ3D+AdPgxJNAcr8Q6rkGQ@mail.gmail.com>
X-Gm-Features: AX0GCFujLpZi6ezYoap5dx0_78ckA3aKaC73qWQ4kqyXsu9mPW5BJV8is4VBcpA
Message-ID: <CAJZ5v0hWKbC2eEe-ce55PN0k4bYnPJ3D+AdPgxJNAcr8Q6rkGQ@mail.gmail.com>
Subject: Re: [PATCH next] ACPI: MRRM: Silence error code static checker warning
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 7:54=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> The error code is not set correctly on if kasprintf() fails.  On the
> first iteration it would return -EINVAL and subsequent iterations
> would return success.  Set it to -ENOMEM.
>
> In real life, this allocation will not fail and if it did the system
> will not boot so this change is mostly to silence static checker warnings
> more than anything else.
>
> Fixes: 04f53540f791 ("ACPI: MRRM: Add /sys files to describe memory range=
s")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/acpi/acpi_mrrm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/acpi_mrrm.c b/drivers/acpi/acpi_mrrm.c
> index 2f22f013959a..70088cdfde13 100644
> --- a/drivers/acpi/acpi_mrrm.c
> +++ b/drivers/acpi/acpi_mrrm.c
> @@ -156,8 +156,10 @@ static __init int add_boot_memory_ranges(void)
>
>         for (int i =3D 0; i < mrrm_mem_entry_num; i++) {
>                 name =3D kasprintf(GFP_KERNEL, "range%d", i);
> -               if (!name)
> +               if (!name) {
> +                       ret =3D -ENOMEM;
>                         break;
> +               }
>
>                 kobj =3D kobject_create_and_add(name, pkobj);
>
> --

Applied, thanks!

