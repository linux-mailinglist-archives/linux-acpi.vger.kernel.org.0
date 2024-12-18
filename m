Return-Path: <linux-acpi+bounces-10181-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1623A9F6E2F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5999516D03F
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Dec 2024 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891C1F8AD2;
	Wed, 18 Dec 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXQrr+pa"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64361ACEA5
	for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 19:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734550061; cv=none; b=ZHoni5wrNY1lIz60eSR6w0J1sE2LMSFiRHbxfxCcsdusktgN03ybIDaxJvNR7bzQEJXNWtL61/2IgunbBnlDxg/2NhAzhdL48avKI/x5bZP3pS2vmxLD4GNXSWT7WmF+FguP454V45++ze9FKEnPpD5VG/Y1gTw0FZtx9fQllUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734550061; c=relaxed/simple;
	bh=x7R49/wWLH++ipJOjAslBQWt2vKhJ0yXOsUhQNXdghA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ast6X5G8GKVkHflPgX+tCbHHBB93OuUQYmIjilpF4rIRZrEM0sg0bz68k/sw0U0fJKobBrM2DezpFOOhKQkD09gGV26HQVzVJU05tej0AZGSdB1soQLrAcL9QLr+sZqb0YdGyZeIIxrGuDot34kWWDA9jQsxqE+fjIUiE3tUl1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXQrr+pa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63601C4CED0
	for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 19:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734550061;
	bh=x7R49/wWLH++ipJOjAslBQWt2vKhJ0yXOsUhQNXdghA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AXQrr+paD3GWexYLTQGXG5kEDtQjQ1ie/Rh1B39tHvwszdBkWAmNyZYhfpq1y2XiX
	 AmoHW1BrNAB+Ph7Zi4eOADgGjBgZ9t+Lt4Wy49RTP01pJVNMytTUNFx76eXDYGDBpn
	 YUV67xZ58Ne8lv2TuUadpvuLOwweFo0vCBri4DSTNde7sltYJClpSzkyfiwFaamT3b
	 rIELcTDS5DGO7fgX0ikJVsEOdkvBOO0gnmfpPPiJNbANeK8PStrks0IoKfBNfn9/id
	 8acdHKxCbiEsbASd3fJYy4XEvqEOQuaQ0fMnN+T3xUFvqhI97ri+76WqDvtA/xFwA+
	 KHmu9oHLnL/RQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb6b16f1a0so2160476b6e.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Dec 2024 11:27:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUkMsH76utESUL61PqQM7H2ivsWrThLIouOPGuX3b5l1bCIAGIfJVpUIeBT5cK0R86JXS3Wu25Ai9bf@vger.kernel.org
X-Gm-Message-State: AOJu0YzHh/0+JramJMGvky1uBoxNnQrh9Kyv22f6f+ZyUQHM94PsNUkJ
	7rVN9UBxUm07FOpT7tCVHgv3tLKjjoFXNXk9wm1POLUluzqQn6O8B2n29g1a109xRtT98KNJ3jv
	78O2i0ZqfX8KWhSTCqVPl4XvsfTw=
X-Google-Smtp-Source: AGHT+IF2IX2FB76Rwm9FkyoAjv+M/SkNYoduVau18eDVVr+EFxe/HPfg8zd1cyugSnBv8OaKwZdJvrv0MQrlpOZqbnc=
X-Received: by 2002:a05:6808:1902:b0:3e7:c7c1:e6cf with SMTP id
 5614622812f47-3ecdcdddbd9mr540554b6e.43.1734550060671; Wed, 18 Dec 2024
 11:27:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217073704.3339587-1-chenhuacai@loongson.cn>
In-Reply-To: <20241217073704.3339587-1-chenhuacai@loongson.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 18 Dec 2024 20:27:29 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jZY5o7h-=+UqvVcUPL7DRTSFTuqY8CKazXR+3r6K8JOQ@mail.gmail.com>
Message-ID: <CAJZ5v0jZY5o7h-=+UqvVcUPL7DRTSFTuqY8CKazXR+3r6K8JOQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Enable EC support on LoongArch by default
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, 
	Len Brown <lenb@kernel.org>, loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	Xuefeng Li <lixuefeng@loongson.cn>, Jianmin Lv <lvjianmin@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Xiaotian Wu <wuxiaotian@loongson.cn>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 8:37=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> Commit a6021aa24f6417416d933 ("ACPI: EC: make EC support compile-time
> conditional") only enable ACPI_EC on X86 by default, but the embedded
> controller is also widely used on LoongArch laptops so we also enable
> ACPI_EC for LoongArch.
>
> The laptop driver cannot work without EC, so also update the dependency
> of LOONGSON_LAPTOP to let it depend on APCI_EC.
>
> Reported-by: Xiaotian Wu <wuxiaotian@loongson.cn>
> Tested-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/acpi/Kconfig               | 4 ++--
>  drivers/platform/loongarch/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index d65cd08ba8e1..d81b55f5068c 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -135,10 +135,10 @@ config ACPI_REV_OVERRIDE_POSSIBLE
>  config ACPI_EC
>         bool "Embedded Controller"
>         depends on HAS_IOPORT
> -       default X86
> +       default X86 || LOONGARCH
>         help
>           This driver handles communication with the microcontroller
> -         on many x86 laptops and other machines.
> +         on many x86/LoongArch laptops and other machines.
>
>  config ACPI_EC_DEBUGFS
>         tristate "EC read/write access through /sys/kernel/debug/ec"
> diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loonga=
rch/Kconfig
> index 5633e4d73991..447528797d07 100644
> --- a/drivers/platform/loongarch/Kconfig
> +++ b/drivers/platform/loongarch/Kconfig
> @@ -18,7 +18,7 @@ if LOONGARCH_PLATFORM_DEVICES
>
>  config LOONGSON_LAPTOP
>         tristate "Generic Loongson-3 Laptop Driver"
> -       depends on ACPI
> +       depends on ACPI_EC
>         depends on BACKLIGHT_CLASS_DEVICE
>         depends on INPUT
>         depends on MACH_LOONGSON64
> --

Applied as 6.13-rc material, thanks!

