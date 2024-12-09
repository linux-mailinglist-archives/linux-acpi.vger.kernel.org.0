Return-Path: <linux-acpi+bounces-10023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E65CC9EA048
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 21:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE5C281FB6
	for <lists+linux-acpi@lfdr.de>; Mon,  9 Dec 2024 20:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C6A13BACC;
	Mon,  9 Dec 2024 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2bvje5M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEC923315A;
	Mon,  9 Dec 2024 20:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733776318; cv=none; b=Rl87kIJ/LLPgzHlPlJVOKeECq68LGkaylxe9ubZZmcRqNDsiqWzdWkiWHyH0dSZlif2ZDZ/lyX0W7cMlSHrYPv1Uz84o22NEpmjctGv3SHCoiHy73iCLzGqRb4WqtE0tJ5fiaf2UyMI8QQ1haC5rICWr7nL67uKXijxJ+L1PxTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733776318; c=relaxed/simple;
	bh=R2nE/0VuIoejSEO81q+2TGaDkTk/hTkKZlQi25gKLuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dOdpC+4amy0HC7rbdJcAy4zE3OqESd2occ6Gy9YSQBD4mKn8dX0ifoc0s4j535Qdrvq5wsgpCyGQlKwbw6RXGKtz73ooYG+pRJUBNBBpNTJFI0jLOXv5V7vr5sgU1Eu/YBsCVZYJH08uKQBVJJqEWV44ag/Zq7mxyB1VVfWyuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2bvje5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA67C4CEE1;
	Mon,  9 Dec 2024 20:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733776317;
	bh=R2nE/0VuIoejSEO81q+2TGaDkTk/hTkKZlQi25gKLuE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y2bvje5MCpoN5yidQbm1Sx2h0a06kqCwAWrUKO+SZMwUBQ/KcJeITm3K+iFB5Y6He
	 e0+YrgyKzgKsszXsPDPiALmodU7JaQfevNalSyU5h15q0gCv+vkDwpG7B915nZZlQQ
	 0hEALDiaW+IJo0v3QwUNqaKjtgWwlOE6ho1UJuYv6/VpCt0+xGAVmg85DWLXMrZgue
	 MPOwLiEv6sfbYxwtHlajvUouYpgetBBzN9rjzZLHJ+QsSCzUDF6kGprXkDLB9Od5Te
	 3Tr9NFKPXr7PYVJ0HHiqIbkud1CPH+fLkj55qhzDMIDm7J+E6oYwLtQ0uNNf+5WYep
	 SFkEmQ3/tt4qA==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5f2c34ae517so384792eaf.1;
        Mon, 09 Dec 2024 12:31:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV6/Dof7wa8GrwjbZ8TXZfWrAUniWhbtZcDjg0U5bh1J6Xo0NKUAyfsKskOETCJFAzG4N/DZTshNQYE@vger.kernel.org, AJvYcCX6ETHimQD3fP2E87Zpk/aPfbZnG7tr8S2FqzjES0ZqGbQNFz63p1lO27vYSaaCpuqheACnOTzcMJNVzvwO@vger.kernel.org
X-Gm-Message-State: AOJu0YzIiB9TV8r8jfGhlxWISEDLeLdfcZvuTP7r2SXvQ66PRMSydyUX
	ETVjMU/+9VZirz+xndayIJFLZXHyOhG5/nRSiwBX7s4dazWM4F+njfEyoerGnvt8CgjpQGvDxdM
	CyRZftc2dksfA3BzgQcIr7ULSVEY=
X-Google-Smtp-Source: AGHT+IHanlbApy5WrT0fnl91dOQ1zPYvf0sIljTqii8nCWBb4n5ujDjRnS2CJMqKrQFr2wuS82Qoywl9ACJ469i5Ec0=
X-Received: by 2002:a05:6820:503:b0:5ee:e029:f797 with SMTP id
 006d021491bc7-5f2c8e7b112mr1486690eaf.6.1733776317012; Mon, 09 Dec 2024
 12:31:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202100614.20731-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20241202100614.20731-1-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 9 Dec 2024 21:31:46 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jvOFYcbTvZwuYNpCz446iUhdR_+FJJAXdsBeeUVMYXQA@mail.gmail.com>
Message-ID: <CAJZ5v0jvOFYcbTvZwuYNpCz446iUhdR_+FJJAXdsBeeUVMYXQA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ACPI: resource: Fix memory resource type union access
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Jiang Liu <jiang.liu@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:06=E2=80=AFAM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> In acpi_decode_space() addr->info.mem.caching is checked on main level
> for any resource type but addr->info.mem is part of union and thus
> valid only if the resource type is memory range.
>
> Move the check inside the preceeding switch/case to only execute it
> when the union is of correct type.
>
> Fixes: fcb29bbcd540 ("ACPI: Add prefetch decoding to the address space pa=
rser")
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>
> I only came across this while reading code around these parts (not
> because of investigating some issue).
>
>  drivers/acpi/resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 7fe842dae1ec..821867de43be 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -250,6 +250,9 @@ static bool acpi_decode_space(struct resource_win *wi=
n,
>         switch (addr->resource_type) {
>         case ACPI_MEMORY_RANGE:
>                 acpi_dev_memresource_flags(res, len, wp);
> +
> +               if (addr->info.mem.caching =3D=3D ACPI_PREFETCHABLE_MEMOR=
Y)
> +                       res->flags |=3D IORESOURCE_PREFETCH;
>                 break;
>         case ACPI_IO_RANGE:
>                 acpi_dev_ioresource_flags(res, len, iodec,
> @@ -265,9 +268,6 @@ static bool acpi_decode_space(struct resource_win *wi=
n,
>         if (addr->producer_consumer =3D=3D ACPI_PRODUCER)
>                 res->flags |=3D IORESOURCE_WINDOW;
>
> -       if (addr->info.mem.caching =3D=3D ACPI_PREFETCHABLE_MEMORY)
> -               res->flags |=3D IORESOURCE_PREFETCH;
> -
>         return !(res->flags & IORESOURCE_DISABLED);
>  }
>
> --

Applied as 6.13-rc material, thanks!

