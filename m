Return-Path: <linux-acpi+bounces-11270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29634A3A731
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 20:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B12A61897C23
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Feb 2025 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D2121B9D1;
	Tue, 18 Feb 2025 19:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dDASz/CG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F91921B9CE;
	Tue, 18 Feb 2025 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906012; cv=none; b=ESsRl4WzYr6ztWgzEHkZlL7f7UPMzhb/dpMwHIEghv7sT59rxQPYEpn2VULZuLvunhgEZX42hQHG2Y7k2WzxRZtWq5b+3TLLq2reb4KeG8vWhK/qPmyQWLp2lKA/iY9TPN5W28lFd/UkaqJG+B851i0x9TcqhhytSDIwe9pRYkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906012; c=relaxed/simple;
	bh=mqFua839X3otW9mntlMXXTriKw26cBoTyCvBh+BPcG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q4WCXkU5gM1iUeAyhalwsgv8JxaUVWPh+qAplUySWsDK8CqFATBHSFfPjlZzuKlM2pTE0c3FjunUpXI6ZOuuxdYFVxNqwI9ezFyz29lbtrqV7Eq7x4hXOlf+/GUQmRHMXq4WgXVcHSuJFgPtrbkaGa+TyWXVkw0lyBoc36NQ/pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dDASz/CG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25E2C4CEE2;
	Tue, 18 Feb 2025 19:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906011;
	bh=mqFua839X3otW9mntlMXXTriKw26cBoTyCvBh+BPcG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dDASz/CGzfE96rfuNz1QoRf/LY+Bf6+Cf+xQ8NHIhwECu0wMo2GTcOnIToISZMoGH
	 Hc7YzzrlnrT/OGTfB4X+ZKTHCGZuHIPtn+shN+p4u6WoeHCIYiBYJfr7Cr2z8szd3K
	 SxamnLYoQU19uaCHOm5B9vrbADg/SkninvbIPNqlLDiR+8JyrKUrG/KR8ag/aMM+lN
	 FN1zZD8QIp/byZRVE1q9XsNTmOva48HNUew7/ViZ+jxE16Y6Jbg+gvv9i1kZfAfQdG
	 ulx69Tk7R13XvRXrR8tz1kpU6sSqa57BBO1KigB/wnMqd82BmhEa5eidmPnlcq7Td/
	 A7pMl05G95igA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5f4d935084aso2964263eaf.2;
        Tue, 18 Feb 2025 11:13:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVn9EOLgP26tslRNFug2qu8ke3GE+tgbKg/SoBaIcX95d5ImsXfBE7HZdx2X7RO0B44RWn/ZsbPxDgv@vger.kernel.org, AJvYcCXCNxDhEl9QrZJUgfuamxCDTEwS+b8Acb/TM0c2MR9knM1nPTCJJCab0xWDJLkfwx9yRnLr7i6ygdBG7V9C@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi0IjM5PEaz7dx2yAQ8Svfvz7L2uXtIOUBVl+2KFXXke8Ym0ql
	MTEf6DkVrcGe+ggxq0XVdMkb/yvMun4NiZ9mpc2a9t0IbW7nzE2tb3Zghti2SuV7C/FsYPUNuM8
	6ueHX8UIJKsyVpChEktBOpNJ3Iw4=
X-Google-Smtp-Source: AGHT+IHnT542pbaCPG4GXoYXSOJu6BNO8e0j15N0WsfLQU3GP/0+KK12Mdcizit7/qc6zh7QTnS+szc4hw29M+p2vh0=
X-Received: by 2002:a05:6808:448d:b0:3f4:b29:2407 with SMTP id
 5614622812f47-3f40b29264bmr2346593b6e.17.1739906011002; Tue, 18 Feb 2025
 11:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213181610.718343-1-colin.i.king@gmail.com>
In-Reply-To: <20250213181610.718343-1-colin.i.king@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Feb 2025 20:13:20 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>
X-Gm-Features: AWEUYZk8YxcXHsGtwZwM3R4unEYqEb0x8puCnbA4smAOkWgzZEhgNRyHTXuHt8Y
Message-ID: <CAJZ5v0i6m6B4D_TGCkNu69SJbTdQ5vq0QzjYtHqKZpiaCnGSOA@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: OSL: ratelimit ACPICA kernel messages
To: Colin Ian King <colin.i.king@gmail.com>, Saket Dumbre <saket.dumbre@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Saket Dumbre

On Thu, Feb 13, 2025 at 7:16=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> In cases where the ACPI AML contains errors there can be quite a large
> amount of ACPICA kernel log spamming.

Except when someone wants to see them all which also happens.

And wouldn't this also rate limit debug messages from ACPICA
specifically enabled via the kernel command line?

If so, I'd rather find a way to tell ACPICA to be less verbose.

> Reduce this by rate limiting the messages.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/osl.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 5ff343096ece..d4ece68e0fd6 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -159,17 +159,21 @@ void __printf(1, 0) acpi_os_vprintf(const char *fmt=
, va_list args)
>         if (acpi_in_debugger) {
>                 kdb_printf("%s", buffer);
>         } else {
> -               if (printk_get_level(buffer))
> -                       printk("%s", buffer);
> -               else
> -                       printk(KERN_CONT "%s", buffer);
> +               if (printk_ratelimit()) {
> +                       if (printk_get_level(buffer))
> +                               printk("%s", buffer);
> +                       else
> +                               printk(KERN_CONT "%s", buffer);
> +               }
>         }
>  #else
>         if (acpi_debugger_write_log(buffer) < 0) {
> -               if (printk_get_level(buffer))
> -                       printk("%s", buffer);
> -               else
> -                       printk(KERN_CONT "%s", buffer);
> +               if (printk_ratelimit()) {
> +                       if (printk_get_level(buffer))
> +                               printk("%s", buffer);
> +                       else
> +                               printk(KERN_CONT "%s", buffer);
> +               }
>         }
>  #endif
>  }
> --

