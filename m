Return-Path: <linux-acpi+bounces-5990-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52E38CFE67
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 12:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E758A1C214F2
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 10:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572F13B597;
	Mon, 27 May 2024 10:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOzR9u1W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40A26AFA;
	Mon, 27 May 2024 10:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807154; cv=none; b=ek6Kq/rH9rwTRphxxZQo+dcqpbaeXonJNGCS0i6BUcOU9DpOx64bHgfo0FecLMYuOOajDBnkm8BfPzf+S/7W6OmYQROTPRamm4vkJyKVPVNWulYcgF1niTPM9mlNCCA3PNeWMzW5396WxlF8xvQYAkeQ5OEUE6sLwwGmNQOqWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807154; c=relaxed/simple;
	bh=5/ZLDV8Iyzas1ubq92DLJv9DNZaEGKWqIJPqjORoDqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hos3VSMZCVPzPwmTte5yMe2SB+H8D9j1nBZTzF9M7C/aJgTCqcjrEb/EsChkBkQ++L0bMPZzDOp0pVpj12Qjw9Vxp7m9TLee+m5UUFAF4caM2NeHdZfLmM/X2uAfmwq/WdExObsMl2QlGvoaLRUz6oldY6HGHPf5sGWTUUSFmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOzR9u1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA37FC32781;
	Mon, 27 May 2024 10:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716807153;
	bh=5/ZLDV8Iyzas1ubq92DLJv9DNZaEGKWqIJPqjORoDqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VOzR9u1WOXecn/8ojc6gcvkP2Bd6HM8IMvEqbJaHEiqz49dAM5MINItVPXATIjclD
	 USXxeXxl2xsv5eVeY0TpwQi75c2yFw1O9WH/K5BVfNrKHgzox/Wouz+NWN+MnNDZxB
	 uS4u26frYlKc+sLELcTbiFU0VJNIAkjcC8eawUSYWfAG8Q8gzCJmdc0kJrOfQCLOMT
	 +eGQSQteZPBUWLPjhQ2+nqmMX68mt0U62ZodmV2WK8pBixKDJHiuhRbPacrshW4cPZ
	 W/gwb4J+eKhxONVtBRHflqKA1uQg3ZGut4HaGA1gOnit5dPDR28L6JnIw+Uy+ZTq8G
	 5LMYZhsEc/oMg==
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2501408eb85so604fac.0;
        Mon, 27 May 2024 03:52:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWcUAPWtUHkTNzq9BI5QFFrftvrhvOJv6enfYwHVhpZmzuUYKww1ZudsA5xNIbLCp/RZaEzcZUZD6JZdCd9tOn+yxsf3K2pWlFElgj6Uo3cRRG6bgPJZEU8BWooWHfFcEb82JCw+go0YQ==
X-Gm-Message-State: AOJu0YyNJoYcvXttNEn1b//TyMF0T4Ff2uk3d4FLxsxsVunHoOMS48Lu
	6LPQ/vStyyebCSkWIrM0o2IBHtRgYhKCm3s1RaIuMi6E+OZrwUA/yXZuA7w9Bt45UU8oJjLKRiL
	nyP7qXCdLRF4ampocqUSOlI84+y8=
X-Google-Smtp-Source: AGHT+IEVgIrphZbV4ggMaDxk7ostdI5gisbGfw3n+55rF2MNOFiQA0javgihIJybPLh+h8YY0KmyaWJbqIj5VsX9EiI=
X-Received: by 2002:a05:6870:7012:b0:24f:bd2f:28d0 with SMTP id
 586e51a60fabf-24fbd311cc0mr7298472fac.0.1716807153145; Mon, 27 May 2024
 03:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240524094149.189329-1-chunjie.zhu@cloud.com>
In-Reply-To: <20240524094149.189329-1-chunjie.zhu@cloud.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 May 2024 12:52:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
Message-ID: <CAJZ5v0gcyZM7PZPrKccLhNtNDhHvqrZsgD-+Xx+W9WesD3yhyw@mail.gmail.com>
Subject: Re: [PATCH] fix kdump kernel cannot find ACPI RSDP
To: Chunjie Zhu <chunjie.zhu@cloud.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 11:43=E2=80=AFAM Chunjie Zhu <chunjie.zhu@cloud.com=
> wrote:
>
> kexec/kdump must pass acpi_rsdp (physical address of ACPI RSDP table) to =
the
> crash kernel, especially in EFI case, otherwise, the crash kernel fails t=
o
> locate ACPI RSDP table. Consequently, ACPI init runs into error, and APIC
> mmio read page fault happens, finally crash kernel gets stuck.

Fair enough.

So has this ever worked before?  Presumably it has, in which case it
has regressed and so it would be prudent to say when it broke and why
and explain why the proposed change is the right one to make.

> Signed-off-by: Chunjie Zhu <chunjie.zhu@cloud.com>
> ---
>  drivers/acpi/osl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f725813d0cce..39474468dba1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -174,7 +174,7 @@ void acpi_os_vprintf(const char *fmt, va_list args)
>  #endif
>  }
>
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>  static unsigned long acpi_rsdp;
>  static int __init setup_acpi_rsdp(char *arg)
>  {
> @@ -187,7 +187,7 @@ acpi_physical_address __init acpi_os_get_root_pointer=
(void)
>  {
>         acpi_physical_address pa;
>
> -#ifdef CONFIG_KEXEC
> +#ifdef CONFIG_KEXEC_CORE
>         /*
>          * We may have been provided with an RSDP on the command line,
>          * but if a malicious user has done so they may be pointing us
> --
> 2.34.1
>

