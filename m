Return-Path: <linux-acpi+bounces-16020-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE0DB345CE
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 17:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 173A15E4FED
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A412FC87E;
	Mon, 25 Aug 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDbqwSkM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8172FB982;
	Mon, 25 Aug 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135910; cv=none; b=K1+xk3DcPa7wl0/0FL1BbmnSv7Lw8aeFLVbb6lDD7TT95BRDVNEo69mMKPL2jp/VjlzY7X/BI15EY1NJ6PA86VALm7E6KYhszcvfKiuIrIQOODw9UqeG0V0grirrJonEPJwcdRbm5e57b87khVi6m2gRQBvuAVgE5ICDjJl7mCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135910; c=relaxed/simple;
	bh=B+IxGfVvYG8wAR5qt3DaYmTLHfh1QpptJI6sjoaEWd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTxogbCO84uJm91HPmxnaDu4ztkkIbFQmkf/EShAWfQA2wGTkCGQdMJxYRCRy5Coiv7RFjXGA7WwQlPAcvShyWYiaa6U+7QwEM+T1l7iypr06t4DS8DoIUa+tmuJk2VM1YoiiK80c+oGRHqZ7mYveLTT0hr6qOntD7H1PrOKOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDbqwSkM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E46C4CEF4;
	Mon, 25 Aug 2025 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756135909;
	bh=B+IxGfVvYG8wAR5qt3DaYmTLHfh1QpptJI6sjoaEWd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fDbqwSkMNtqZJPsl6X2zJybeq5+9IBnZeuN+QV7nHy3BATNYs/XkGxP4mVqvUevbs
	 GOXqY1EMGJssn+J8PXPPWI0TcITH00bKgJ/apiNsQ0i+S8gmqkmKllH4In6sc4K2vx
	 cwTW4ZkrQAwjql3ZBuMBP2NPEFoLc8FCb2m6A6gjJObjZ/voNS0WY1r5XAVBnL6z6+
	 DNkwFUXMjtAtJdbg9OMe/7opsZcVh/Odet3zNqOE20jQJQOQfYu02AnuUQZhqvOaKk
	 PewGm9pDbJFGYyhLddJYF7KHOnoQ8GbCvQfboeFaFKpk9mXqTUvDlFboJdxGHr1On1
	 dI7xyR5BGrT5A==
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-770530175b2so1190622b3a.3;
        Mon, 25 Aug 2025 08:31:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQnTjSzb/37w0Y928/LhXY6le5ie2uM+yRunNi4d7f37r5AB5WJwyd5YfD2x6Ag8W2xacgUTfebY0rzSgc@vger.kernel.org, AJvYcCWMoBZKfrqlxp9WNm9SxHqL6Jb5ieXweY2xcPxSd60pve1JXx+l7l1qwDM8T/OsEqlcfRId6uA6Rcfa@vger.kernel.org
X-Gm-Message-State: AOJu0Yye6T2DNOvvwyVsfCaH6fvwOJQ0zUKFsK44QQ6fCfm4AckGLsab
	I7J/6TiVN+9lQjQDCnlg/9cmTyc7BWB8qbtPEIJscPs8ytD9QPbvEqZhfnIVfJo/K4aaZbHNd5K
	lvCF7kSOAWrHs7sgXEAN2sYZLdFDaCUM=
X-Google-Smtp-Source: AGHT+IEz8IQUErAJXnE5lBIwit81kk3akHwX2DEMHmz82Jlbw/82AMruYt1ZZT8QLQzUMRtn34lKm2P3dN2DzQpLz7A=
X-Received: by 2002:a05:6a21:6da8:b0:218:96ad:720d with SMTP id
 adf61e73a8af0-24340b7c601mr16722920637.1.1756135909004; Mon, 25 Aug 2025
 08:31:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818082451.497935-1-zhao.xichao@vivo.com>
In-Reply-To: <20250818082451.497935-1-zhao.xichao@vivo.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 17:31:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ih9yjN2_jnAGhJWT0QYFJswBPc4-QRu4kjVXoEapGJiA@mail.gmail.com>
X-Gm-Features: Ac12FXxgdT4Nafbc5pic473yYl8JrymhVd-pN1H_L8pFEtQbWw5WUAWYNXcAQpc
Message-ID: <CAJZ5v0ih9yjN2_jnAGhJWT0QYFJswBPc4-QRu4kjVXoEapGJiA@mail.gmail.com>
Subject: Re: [PATCH] pnp: isapnp: use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: perex@perex.cz, rafael@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 10:25=E2=80=AFAM Xichao Zhao <zhao.xichao@vivo.com>=
 wrote:
>
> Use the string choice helper function str_plural() to simplify the code.
>
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/pnp/isapnp/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
> index d2ff76e74a05..219f96f2aaaf 100644
> --- a/drivers/pnp/isapnp/core.c
> +++ b/drivers/pnp/isapnp/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/init.h>
>  #include <linux/isapnp.h>
>  #include <linux/mutex.h>
> +#include <linux/string_choices.h>
>  #include <asm/io.h>
>
>  #include "../base.h"
> @@ -1037,7 +1038,7 @@ static int __init isapnp_init(void)
>         if (cards)
>                 printk(KERN_INFO
>                        "isapnp: %i Plug & Play card%s detected total\n", =
cards,
> -                      cards > 1 ? "s" : "");
> +                      str_plural(cards));
>         else
>                 printk(KERN_INFO "isapnp: No Plug & Play card found\n");
>
> --

Applied as 6.18 material, thanks!

