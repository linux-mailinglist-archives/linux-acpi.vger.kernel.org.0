Return-Path: <linux-acpi+bounces-16364-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644CBB44061
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 17:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8B11C85E5B
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Sep 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCCA224892;
	Thu,  4 Sep 2025 15:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrrJ2aGZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C9E21CC44;
	Thu,  4 Sep 2025 15:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756999225; cv=none; b=pXIPt8tjcNqm6fhWQqWPTMfygI7P86R/xpRA4fMa/X2JZ4xjFvuaa9ues7O7PbFl9klzXjpldSczUznypjX+36TcyGl7dIDgmSkPukzu6WItk7Nx/VYJ9BizYlVQEi3Ui2LnCa+3FV44DSqSG7ObGlB8jJWSueIdQl23icL/fAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756999225; c=relaxed/simple;
	bh=kbjqAXm6KOvoqjjIDZ5w54X46wy4q1JKVOfyfJM+g98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWSlDceidxVSiND85uwQcWOwHtCYspJ7Ie0N5rDXXKSvgG+lZZYCrMMNAoTHyxlD4ibTQYhPoZbrdV5uGZWT1+33RleK1DzY6ZnZn/iZ6qH0ZlEzhpCaIGPXIIzUB67fwpAN8ixaYrhU29csrvmIRTuuTRgBc/NRwGhnbTjvjAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrrJ2aGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87246C4CEF0;
	Thu,  4 Sep 2025 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756999224;
	bh=kbjqAXm6KOvoqjjIDZ5w54X46wy4q1JKVOfyfJM+g98=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VrrJ2aGZKc8cdK4A+fZgyFB3W4dJyjXTcCtOuCUKJRalKcA9yL+KPhZ+yTN54GbiZ
	 2wUMDA/6irzJWEFXbEMj0suMgpVpej9vE+TNxQ6SEzKCu28c3SMmhi9TkzBYhCYaLA
	 1sZmJciDYaJ9Cer3AXlgO54AeDBEnvABzy5gOk4HOT9xzgCEJMv4VUmF9+7Irm60NZ
	 ZcOX4QOxoq8woJ+WLUHjJXJem64ItO3TLNMRbVfDVx7vuInGvY63L6mNCgs6h3e3dR
	 G8fk0B4HcKCEdJAnMVL8ZOvJi5sorK8aJy5hAli6zF1XQrKTh0YIMFKogJ/6ANjNPO
	 W1zwrQSIjf95w==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-61e266ab733so1394310eaf.1;
        Thu, 04 Sep 2025 08:20:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn/VGaaErJWaWoeM1oaAXrYw0wEfsSzKsz0fb7necILUGgq56KqMhtn2ki3m6WhhBq/En1e9f9DFxH6JcN@vger.kernel.org, AJvYcCXCuHG8jfWL1r6YeGpWjcNXHpYCDLVCJAMFfsGkM1FovbVfO3zEBwpaAfBNsf+RqXFOL0nN3NXzR/mL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nxD33b2THMfrLnUdxT8z07GpuVA4wx7BBRgHPV9xCR3/3uR+
	FunS9VG2QCyqVQW254gOeQKLVh9UL47EHVNHFlaoDp7MjYK9+Ens9Bvqd43FHLBW7xOS18xPgN0
	51PtYRPBx0wSjb4Zc5k3+7MVaAZENt7w=
X-Google-Smtp-Source: AGHT+IE5MoQ2WWj2053lBW6qTVvPfCJO1m5NC1OOM+i9pZjbzcZcoYrOBpBjCBI4So4kTgzt5rlOVRdyXe5N2L4rV/w=
X-Received: by 2002:a05:6808:14d5:b0:438:1edb:9bec with SMTP id
 5614622812f47-439ae60826cmr11405b6e.12.1756999223876; Thu, 04 Sep 2025
 08:20:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_0FBB187910C3E168E5C9468DDF6764C94308@qq.com>
In-Reply-To: <tencent_0FBB187910C3E168E5C9468DDF6764C94308@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 4 Sep 2025 17:20:12 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0idDF5b5WsQz-fSNxe0-nR+2zX1_DRnCo9uu2jLkv2Q9Q@mail.gmail.com>
X-Gm-Features: Ac12FXyv6BXoaOWlmb8EFKqaUuQOo7TzkBV83x0n1oLtMvTOh5F96xRNMfi9moc
Message-ID: <CAJZ5v0idDF5b5WsQz-fSNxe0-nR+2zX1_DRnCo9uu2jLkv2Q9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ACPI: PRM: Optimize the judgment logic for the PRM handler_address
To: "Shang song (Lenovo)" <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shangsong2@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:02=E2=80=AFAM Shang song (Lenovo)
<shangsong2@foxmail.com> wrote:
>
> If the handler_address or mapped VA is NULL, the related buffer
> address and VA can be ignored.
>
> Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
>
> Changes in v2: Demote pr_err to pr_info for incorrect handler_address.
> ---
>  drivers/acpi/prmt.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index be033bbb126a..6792d4385eee 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -150,15 +150,28 @@ acpi_parse_prmt(union acpi_subtable_headers *header=
, const unsigned long end)
>                 th =3D &tm->handlers[cur_handler];
>
>                 guid_copy(&th->guid, (guid_t *)handler_info->handler_guid=
);
> +
> +               /*
> +                * Print an error message if handler_address is NULL, the=
 parse of VA also
> +                * can be skipped.
> +                */
> +               if (unlikely(!handler_info->handler_address)) {
> +                       pr_info("Skipping handler with NULL address for G=
UID: %pUL",
> +                                       (guid_t *)handler_info->handler_g=
uid);
> +                       continue;
> +               }
> +
>                 th->handler_addr =3D
>                         (void *)efi_pa_va_lookup(&th->guid, handler_info-=
>handler_address);
>                 /*
> -                * Print a warning message if handler_addr is zero which =
is not expected to
> -                * ever happen.
> +                * Print a warning message and skip the parse of VA if ha=
ndler_addr is zero
> +                * which is not expected to ever happen.
>                  */
> -               if (unlikely(!th->handler_addr))
> +               if (unlikely(!th->handler_addr)) {
>                         pr_warn("Failed to find VA of handler for GUID: %=
pUL, PA: 0x%llx",
>                                 &th->guid, handler_info->handler_address)=
;
> +                       continue;
> +               }
>
>                 th->static_data_buffer_addr =3D
>                         efi_pa_va_lookup(&th->guid, handler_info->static_=
data_buffer_address);
> --

Applied as 6.18 material with edited subject and changelog, thanks!

