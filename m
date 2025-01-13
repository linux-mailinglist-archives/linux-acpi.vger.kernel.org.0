Return-Path: <linux-acpi+bounces-10571-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4A6A0C107
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE761885457
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788AD1B86D5;
	Mon, 13 Jan 2025 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QfZKqT2b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B90F240243;
	Mon, 13 Jan 2025 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795437; cv=none; b=AnXiMgyVqm5QTQBlAke76dVWg/ySKpX3d5AnTuEg2jf2Z2ZFQb6O0SkOVPbDwSZY2O6WfdsIYACC2VgYmF95OSV7hK7JCZQpDVg5AYyMGa4JJ3zJyJWlByryuR3nGaANpoaEWlKoXSRSBBLI4SW7GLysdeNZRXAP9RRrddjmMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795437; c=relaxed/simple;
	bh=bTCFDf8vCyq8nYMCcZs1lYvphn31XnUPAGDIocgH0TE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koUL0DOE85iNNYrCRn4avLkbCfu/G/c6zm+OM3qsZi/liXjC3VKs9xxB6oXsqc0MBrI95QeJz8TRU1GXtB1nUEOo1nSFjGpw7NATYlhyhiapBrztbzh/pOk1nE3BHQEcNPbcUX42RtOaaA2ghJrBHgaVMcYZqRX0zD/qBqO7LNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QfZKqT2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2167C4CEE2;
	Mon, 13 Jan 2025 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795436;
	bh=bTCFDf8vCyq8nYMCcZs1lYvphn31XnUPAGDIocgH0TE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QfZKqT2bWMTV/3L/AcUNm1kI0/42VI/83XLFG+qRjhnr8V5mZlg9LNN+N56COT0ny
	 w3gWs9QaxKfLzQydZoQubYcwkQUy12ZQOMvGC8/UHpzXalH9dFtUNBlgDEza/UtyAF
	 zEvqO2XlEcSPgu4T0D4otttk3Q9WJqmUCUQ0TbnostfDoFd6cahXn84D3Bx3KUa1JK
	 zsoqEGyiGQFjuW+ve/HszINNuYpSTNypmmHJefmnyDVaOKjktQ5UdQHmlRdWNJSz14
	 fKN6KkX0++qnil9MFVfOqtBw1HAdHSHgCft9oL4iwBIFdw1E+0oN5e8q0yAMfsCak2
	 ehAE19pqC1cPA==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-29fc424237bso3969586fac.0;
        Mon, 13 Jan 2025 11:10:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV/q6As6Yx9FHbQPejnySYuSIYCmAayMkrug2bRHMeYx05bgrl3C63a+mDh22jcnQnSU/ptrLqED713bi1m@vger.kernel.org, AJvYcCVbl8A9N14XnGRIBVmM/FdRSSdPh2nPN45RwFJb/nVD2CLUf4SOjrWhSUbjjGBxZSat7wonNzaQa+J8@vger.kernel.org
X-Gm-Message-State: AOJu0YxPv8tL6OnPnZcliw+EEChfESYSsxSqku+DKNrFZsEHvlSWVMdv
	VRtIHpbH6Sa8BV4oVxXxpNuS+2WxZ1zTS50Lhd+A22KIT4TGmaiASfYlnho/37D89ebdOrN7FWx
	OCr+PGl6F56IRZuVkpx3rTBUcRNQ=
X-Google-Smtp-Source: AGHT+IHbOkT372wvF7l4NndlribXQWuRLbK8G76+BOB3qhvYxzram7wGgZ0+Qn1COcLDTgfu52NR/4dzjR3YhbbyM/M=
X-Received: by 2002:a05:6870:ef11:b0:29e:34ef:bd7d with SMTP id
 586e51a60fabf-2aa06647c89mr12263944fac.2.1736795436000; Mon, 13 Jan 2025
 11:10:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113174439.1965168-1-gourry@gourry.net> <20250113174439.1965168-4-gourry@gourry.net>
In-Reply-To: <20250113174439.1965168-4-gourry@gourry.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 13 Jan 2025 20:10:24 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gU-VF_wDYP-WLxt3MsT4WqXQZStCwB4YkBphqQrS6y1w@mail.gmail.com>
X-Gm-Features: AbW1kvbwxtKXkdt67DuIfKDHva3LhOsCwSa18Z-abQ2l0M082G5kljHn9SOjGqk
Message-ID: <CAJZ5v0gU-VF_wDYP-WLxt3MsT4WqXQZStCwB4YkBphqQrS6y1w@mail.gmail.com>
Subject: Re: [RESEND v7 3/3] acpi,srat: give memory block size advice based on
 CFMWS alignment
To: gourry@gourry.net
Cc: linux-mm@kvack.org, linux-acpi@vger.kernel.org, kernel-team@meta.com, 
	x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com, 
	luto@kernel.org, peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, rafael@kernel.org, lenb@kernel.org, 
	david@redhat.com, osalvador@suse.de, gregkh@linuxfoundation.org, 
	akpm@linux-foundation.org, dan.j.williams@intel.com, 
	Jonathan.Cameron@huawei.com, alison.schofield@intel.com, rrichter@amd.com, 
	rppt@kernel.org, bfaccini@nvidia.com, haibo1.xu@intel.com, 
	dave.jiang@intel.com, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 6:44=E2=80=AFPM Gregory Price <gourry@gourry.net> w=
rote:
>
> Capacity is stranded when CFMWS regions are not aligned to block size.
> On x86, block size increases with capacity (2G blocks @ 64G capacity).
>
> Use CFMWS base/size to report memory block size alignment advice.
>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> Tested-by: Fan Ni <fan.ni@samsung.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/numa/srat.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 59fffe34c9d0..7526119fe945 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>
>  #include <linux/acpi.h>
>  #include <linux/memblock.h>
> +#include <linux/memory.h>
>  #include <linux/numa.h>
>  #include <linux/nodemask.h>
>  #include <linux/topology.h>
> @@ -425,13 +426,22 @@ static int __init acpi_parse_cfmws(union acpi_subta=
ble_headers *header,
>  {
>         struct acpi_cedt_cfmws *cfmws;
>         int *fake_pxm =3D arg;
> -       u64 start, end;
> +       u64 start, end, align;
>         int node;
>
>         cfmws =3D (struct acpi_cedt_cfmws *)header;
>         start =3D cfmws->base_hpa;
>         end =3D cfmws->base_hpa + cfmws->window_size;
>
> +       /* Align memblock size to CFMW regions if possible */
> +       align =3D 1UL << __ffs(start | end);
> +       if (align >=3D SZ_256M) {
> +               if (memory_block_advise_max_size(align) < 0)
> +                       pr_warn("CFMWS: memblock size advise failed\n");
> +       } else {
> +               pr_err("CFMWS: [BIOS BUG] base/size alignment violates sp=
ec\n");
> +       }
> +
>         /*
>          * The SRAT may have already described NUMA details for all,
>          * or a portion of, this CFMWS HPA range. Extend the memblks
> --
> 2.47.1
>

