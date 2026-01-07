Return-Path: <linux-acpi+bounces-20014-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A935CFFECE
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 21:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90C4D31A3468
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 19:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA96342510;
	Wed,  7 Jan 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StBIBeHy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264B826E6E8
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767814794; cv=none; b=vEakQX2O65QnqHcWFgGiK8tQ+k4A15xf8z1n55uHMC1XMND20DmdjkmNd4KDU+xN/do5FRPUVqguxT4IlnOWel4FThcP9k5mXUsLIGHWl0laV3aJNtW/PUNvqomZnsE0mW/NACMCyO6OQVEof7Zhq5tmxXwwULjtGsz8UBI6Jc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767814794; c=relaxed/simple;
	bh=C9HFQFC4PPZiW+RYDt7+yFgPqwT7sflfxDvc8rrfEO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/SS3rGNLXjDOd4ZoLncY+LehoPtGxolhOnBy1X+3vV36/uBg100DCDattDHUfMVLqwDys0Tnkr40Yh4N2dt4AcikHZChZrrpvSGQ36jv57NfGcVHL++GksJcRqgpUSTlQ5zV5vmL4AWHjI0WfmtsNovWZlHLYFG1Cm4Vz6XEOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StBIBeHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34706C19423
	for <linux-acpi@vger.kernel.org>; Wed,  7 Jan 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767814791;
	bh=C9HFQFC4PPZiW+RYDt7+yFgPqwT7sflfxDvc8rrfEO0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=StBIBeHysHiyag+mS0RQ+35/gHXBl0SBfp2oQjqw6Eucto0iKW70RcZUsUyBiMy5y
	 VHeZ7BRWlUhQRVVYHEb+UhbKzMMXCvmAfh6t+AcCYcsMVbRc8AOVsCrTn4jgljaCa0
	 s0b/zSgH4D2iXhXENj9yE8CHEPWXZEdyaQf0pp5v8u+9e0OFkClR4uUBkW9wI90FGq
	 /R65JM5FxM3fS0396Pqb1N7H8m0hoE5r4gDmvEjwKqtXgzzXA6fcYE2wepSic5Wyln
	 Q/pgQSc0c+UO7d4u/i8NyF1Bpw+jL3yGhx+PaMhGkeSyGUF91gNOutht9DTvwOQI8o
	 jj9OBaP5+ip0g==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-65ec86c5e70so1412941eaf.3
        for <linux-acpi@vger.kernel.org>; Wed, 07 Jan 2026 11:39:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVCA0AfptyZNWEFELQUV89jDcAcmRl+pwfT1eeSThH9F31wngduLRo3xCnbVU9ZsWMjsdWtBsC1RZmq@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fBZeFmCi/G0OM+/dHtywH9xGyR5anctPxURcRPQFtnnzViCw
	gKddiA58twDMiJ8uhaIs5ZBOui3+VQ8VXJL31fcHBPI0xCr5EmR72HBA3KNs5kj+VNw9/ilfl7I
	ZbXzVlbo03b7ELDNVl9nGbRCGGBZOrF4=
X-Google-Smtp-Source: AGHT+IGeGlYVjMyEnbSSu+1/+moevZu/gztGPmbycRE0hhgXmeau2riH5uStIVYQlK6VezsA0RxePiV5P1YZ7gRGf0Q=
X-Received: by 2002:a05:6820:438e:b0:65c:ff20:a3b5 with SMTP id
 006d021491bc7-65f5509337cmr975804eaf.77.1767814790211; Wed, 07 Jan 2026
 11:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251209072757.3110467-1-pengcan@kylinos.cn>
In-Reply-To: <20251209072757.3110467-1-pengcan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 Jan 2026 20:39:38 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g1dnFcgj45760QaREiX5DH-JyYeCug0LwYdb0RZF+sLA@mail.gmail.com>
X-Gm-Features: AQt7F2p_UKKSU8VHngTqPGji5wM8O4xbKfNqgbClA03MBrpYm4bAYHPazQp1iAE
Message-ID: <CAJZ5v0g1dnFcgj45760QaREiX5DH-JyYeCug0LwYdb0RZF+sLA@mail.gmail.com>
Subject: Re: [PATCH] acpi: use LIST_HEAD for stack-allocated list in acpi_watchdog_init
To: Can Peng <pengcan@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 9, 2025 at 8:29=E2=80=AFAM Can Peng <pengcan@kylinos.cn> wrote:
>
> Replace the separate declaration of 'resource_list' and subsequent
> INIT_LIST_HEAD() call with LIST_HEAD(), which declares and initializes
> the list head in one idiomatic step. This reduces code verbosity and
> aligns with common kernel coding patterns, without functional change.
>
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/acpi/acpi_watchdog.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpi_watchdog.c b/drivers/acpi/acpi_watchdog.c
> index 14b24157799c..709993c535d1 100644
> --- a/drivers/acpi/acpi_watchdog.c
> +++ b/drivers/acpi/acpi_watchdog.c
> @@ -103,7 +103,7 @@ void __init acpi_watchdog_init(void)
>  {
>         const struct acpi_wdat_entry *entries;
>         const struct acpi_table_wdat *wdat;
> -       struct list_head resource_list;
> +       LIST_HEAD(resource_list);
>         struct resource_entry *rentry;
>         struct platform_device *pdev;
>         struct resource *resources;
> @@ -125,8 +125,6 @@ void __init acpi_watchdog_init(void)
>             wdat->pci_device !=3D 0xff || wdat->pci_function !=3D 0xff)
>                 goto fail_put_wdat;
>
> -       INIT_LIST_HEAD(&resource_list);
> -
>         entries =3D (struct acpi_wdat_entry *)(wdat + 1);
>         for (i =3D 0; i < wdat->entries; i++) {
>                 const struct acpi_generic_address *gas;
> --

Applied as 6.20 material, thanks!

