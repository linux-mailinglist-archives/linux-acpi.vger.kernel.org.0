Return-Path: <linux-acpi+bounces-18249-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7763EC0FEB1
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 19:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EECA2343ECF
	for <lists+linux-acpi@lfdr.de>; Mon, 27 Oct 2025 18:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9F22D948D;
	Mon, 27 Oct 2025 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnzzAYeY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE602D876B
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761589557; cv=none; b=RT4g1+2szjq8h8plGPmNd8KaYn6qTXf6QQWdc6ybOYqxJNwOYSVlExIsw6/qpNDGTLHRg53O5xd0sun6ScK9VUcV8nF22CxKDDGcFGtfeGzdaotpOQlrI1+S4q5AxtTOVPel9hVU2pfeaabE+wkTamHo4Da7H6/nOgUETpWVohU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761589557; c=relaxed/simple;
	bh=x0GdLq5oDT2bsye4+zTGepjhdJueRV6Y+YQZ4kwiQjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTzGPBcf4AWDlxPP26RNfSZjBVSK55APaauBip8oAFriJMhHsxmUPIXppWc7Gd7O9IywZUCwNnM2GCogvHgRuUXtak9XeclSnxz0nzUhyR/aToCW2eU5UoNzCfVURLCbL+bfsjA1b4PZ9cwZ1gQ9JVPr10B4Bu8ADaoyZqI0QmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnzzAYeY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762F9C116C6
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 18:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761589556;
	bh=x0GdLq5oDT2bsye4+zTGepjhdJueRV6Y+YQZ4kwiQjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gnzzAYeYRz3Mqb8WaFg/u8kWKIHC/9wtZNUsL4sZFO0qmlko7bbcQ5ilEk18RYcCN
	 LMG90WoISGQMs1krcPexq6q4y92QG+z9J+f3in7KMugAUCKqZhExUxSCj0pG4E649y
	 KUXbjdGTiyAgfKEKoD6swr13seSDIgUh5H9i6X9iRJk4F2JJ9kEGD2SKR9gMDdHENQ
	 JAw7PKzgHEgQniBjIVBL96yyHNDWGtVLaP6CJQnfD6d2S83uAPlJGAPefNSGzpHFqt
	 7uL6o8q9/8nSAAYvvOfZd6XZO9B8beUEIgdyEd+MbRlL74heJiEQhNWSCsQao9JcLz
	 nxDz1foQ+lTiQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-44da774cc9dso1369191b6e.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 11:25:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXo1UPlo9GPoIwHPdFVSQfn4nwZIpproOa630tBNeMtAcNYzRR3eGG54f+WEPaPMrobOnLgf703lJAI@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFpJ0AdtfvEuvdc61/on5LbOiGXXmLs/G3SbDDnXcza8opctT
	nRQho/49MsVh9wjt+4SorKuN8xvONkVmfCU7LDCtYqzVqbpkxpjqn05XwiCAQW+dDW+CT/Mi3FX
	29O4/BjYwMLsxsIZ9hIy3Fz9e22H2Hb8=
X-Google-Smtp-Source: AGHT+IH+/v+LQw9DzQQ8Vvjc8o5cD0s9vYZfdVPNB6aKtMkLpGObabhiy1PrnQHxjpgsbBapAIOim4OcgWEv0zzMosQ=
X-Received: by 2002:a05:6808:f89:b0:44b:1f75:dee7 with SMTP id
 5614622812f47-44f6b911a0cmr399801b6e.8.1761589555767; Mon, 27 Oct 2025
 11:25:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_EAFBEC2D1967D73F4F76B8048D2F59BB1105@qq.com>
In-Reply-To: <tencent_EAFBEC2D1967D73F4F76B8048D2F59BB1105@qq.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 19:25:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0httK0xmvA5zcYruU1Ypsw1YXHBOaPQxwCai8YDLsGkvA@mail.gmail.com>
X-Gm-Features: AWmQ_bkhyJQvdvhTfLeogaWPxZqKwt3rdWh3HYbs3GEZYZulKc9_EJEohW0F2fg
Message-ID: <CAJZ5v0httK0xmvA5zcYruU1Ypsw1YXHBOaPQxwCai8YDLsGkvA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: PRM: Skip the initialization when boot from
 legacy BIOS
To: "Shang song (Lenovo)" <shangsong2@foxmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shangsong2@lenovo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 10:38=E2=80=AFAM Shang song (Lenovo)
<shangsong2@foxmail.com> wrote:
>
> To address the confusion caused by the misleading "Failed to find VA for =
GUID..."
> message during legacy BIOS boot, making 'EFI_RUNTIME_SERVICES's earlier j=
udgment
> can prevent this false alert.
>
> Signed-off-by: Shang song (Lenovo) <shangsong2@foxmail.com>
> ---
>  drivers/acpi/prmt.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 6792d4385eee..ec367d322ab2 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -305,11 +305,6 @@ static acpi_status acpi_platformrt_space_handler(u32=
 function,
>         efi_status_t status;
>         struct prm_context_buffer context;
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> -               pr_err_ratelimited("PRM: EFI runtime services no longer a=
vailable\n");
> -               return AE_NO_HANDLER;
> -       }
> -

The check removed by this change addresses a different case than the
similar check in init_prmt(), so removing it when relocating the other
check is questionable.

Please limit this patch to the init_prmt() changes.

>         /*
>          * The returned acpi_status will always be AE_OK. Error values wi=
ll be
>          * saved in the first byte of the PRM message buffer to be used b=
y ASL.
> @@ -388,6 +383,14 @@ void __init init_prmt(void)
>         acpi_status status;
>         int mc;
>
> +       /*
> +        * Return immediately if EFI_RUNTIME_SERVICES is not enabled.
> +        */

One-line comment would be sufficient here.

> +       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> +               pr_info("PRM: EFI runtime services unavailable, can not i=
nitialize.\n");
> +               return;
> +       }
> +
>         status =3D acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
>         if (ACPI_FAILURE(status))
>                 return;
> @@ -404,11 +407,6 @@ void __init init_prmt(void)
>
>         pr_info("PRM: found %u modules\n", mc);
>
> -       if (!efi_enabled(EFI_RUNTIME_SERVICES)) {
> -               pr_err("PRM: EFI runtime services unavailable\n");
> -               return;
> -       }
> -
>         status =3D acpi_install_address_space_handler(ACPI_ROOT_OBJECT,
>                                                     ACPI_ADR_SPACE_PLATFO=
RM_RT,
>                                                     &acpi_platformrt_spac=
e_handler,
> --

