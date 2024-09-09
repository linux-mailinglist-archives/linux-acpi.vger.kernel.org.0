Return-Path: <linux-acpi+bounces-8203-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8611D970BD8
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Sep 2024 04:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E24282894
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Sep 2024 02:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581A318C332;
	Mon,  9 Sep 2024 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RetZ0NgE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1CC42A8A;
	Mon,  9 Sep 2024 02:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725849296; cv=none; b=eD2Rutgz69yGb374uiWeabZQVNTHfHODLLi1R2IQWYmCB0ZAX6obWwEjODb4JlVHX9f+1ybJn0iEQVuEMwIz8vwQSfqHZERYUYR1uB0MqXI/JiPCswsiiuxDmm3w+uGe1Jl4izkUmSnGFNfj7Hxd0ML3QiCGW2BUQUqszy0rAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725849296; c=relaxed/simple;
	bh=EiOjDPobUg58X61kTYvvizyZ8wDCC5yuIxRnPX8Y0xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUNGGw/3POgFYj9akSZLb19GFOIW8g1V62tKBFpjdqwEDv4htXEW8owS90SVp/jOXje13+3e6wfYhms+8yYT9dW/IWgk0HmXJvi/CROFECHMhU0v5hQVtFzLuuYR74K8FficsN1oivhFf17dqsTkkQHcehuoVaYmFCnX2kxHOZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RetZ0NgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD28C4AF0B;
	Mon,  9 Sep 2024 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725849295;
	bh=EiOjDPobUg58X61kTYvvizyZ8wDCC5yuIxRnPX8Y0xs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=RetZ0NgEguPLE/Vp+kx9ZgKr3r+ylEIkdHnOjFvVV5GYUd3YsuaaEhQ+5+jMjbnbk
	 5xZMnf8QNL2T1w1z/NWGFZkliPkef46Wm48Cp8V77kHsMzMCUD9RGkkB24FI7ykdYl
	 99xAcAuW9DeRJj3P3aqdKToyikywNQifbiJD65Vbbe7P+bKbp2rArJC3esh1d4PjAJ
	 LJfD/44h2iHWXT1ltr93U7gkeFbkWj0bvEKRXJLGU7/B/wdRNFJenT3wJmHjwYE5G0
	 XebFaNmDYPEhEp/aEWex2VIH4VN6GvnSytYsN9K/+YBs9Pz/UMRhQ/EJRE7adblHTN
	 hFXEtHrofkBgA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f759b87f83so15312131fa.2;
        Sun, 08 Sep 2024 19:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+JvWSKR4AXwY95pfY0h/7veR0gohTRm5X7mE/uIOfi788hZLLeFCG2h0I5EE7yYxQmcHwd0pqIifg@vger.kernel.org, AJvYcCXzJsLtn4kLqmXA/kvPHTvUjAur9JOEyGRAHo6N+Q2kHcYuKb7Ky1rcDfYtcK4k8L9SI6Vy3GA+5+HSkJhK@vger.kernel.org
X-Gm-Message-State: AOJu0YwPaQt2m1YsRaqRJIZOxXhXbYwzG5ZnjqaK72aqp3GEvxgtunRh
	Cw6dwiiylcc/EfvqAXfQjRvH8T8Uk3pQmEtxmh9lCR6W+6yyiM1/bpZOyi8TzU5f/jHLkKUSnBt
	n7JSCHx/G/m93tTFlTYHEuaHpVjU=
X-Google-Smtp-Source: AGHT+IGcZ1Nc4erQMEN94hYI31vIZJJ4Rg80cIvzXQEIPGSlkuZGdx3yCmGUGIGEulY4ozSvH/XDB4JbRyKom4fSnro=
X-Received: by 2002:a2e:b8c7:0:b0:2f3:e2f0:2b74 with SMTP id
 38308e7fff4ca-2f751f8289amr52804841fa.36.1725849294181; Sun, 08 Sep 2024
 19:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909015514.597253-1-maobibo@loongson.cn>
In-Reply-To: <20240909015514.597253-1-maobibo@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 9 Sep 2024 10:34:42 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6NQLKEORZvhvNr=iORNzA+WG=cX4zxAx+Vit714ST+4A@mail.gmail.com>
Message-ID: <CAAhV-H6NQLKEORZvhvNr=iORNzA+WG=cX4zxAx+Vit714ST+4A@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Enable ACPI BGRT handling
To: Bibo Mao <maobibo@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jianmin,

On Mon, Sep 9, 2024 at 9:55=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrote=
:
>
> Add ACPI BGRT support on LoongArch so it can display image provied by
> acpi table at boot stage and switch to graphical UI smoothly.
This patch seems very useful, could you please confirm it on real
machines? Or you can only provide me with a BIOS with BGRT.

Huacai

>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  arch/loongarch/kernel/acpi.c | 4 ++++
>  drivers/acpi/Kconfig         | 2 +-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index 929a497c987e..f1a74b80f22c 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
> @@ -9,6 +9,7 @@
>
>  #include <linux/init.h>
>  #include <linux/acpi.h>
> +#include <linux/efi-bgrt.h>
>  #include <linux/irq.h>
>  #include <linux/irqdomain.h>
>  #include <linux/memblock.h>
> @@ -212,6 +213,9 @@ void __init acpi_boot_table_init(void)
>         /* Do not enable ACPI SPCR console by default */
>         acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
>
> +       if (IS_ENABLED(CONFIG_ACPI_BGRT))
> +               acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
> +
>         return;
>
>  fdt_earlycon:
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index e3a7c2aedd5f..d67f63d93b2a 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -451,7 +451,7 @@ config ACPI_HED
>
>  config ACPI_BGRT
>         bool "Boottime Graphics Resource Table support"
> -       depends on EFI && (X86 || ARM64)
> +       depends on EFI && (X86 || ARM64 || LOONGARCH)
>         help
>           This driver adds support for exposing the ACPI Boottime Graphic=
s
>           Resource Table, which allows the operating system to obtain
>
> base-commit: b31c4492884252a8360f312a0ac2049349ddf603
> --
> 2.39.3
>

