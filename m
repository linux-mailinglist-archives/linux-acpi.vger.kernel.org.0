Return-Path: <linux-acpi+bounces-2642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FCE48200E9
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 18:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBABC1C209B8
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Dec 2023 17:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E3E125CE;
	Fri, 29 Dec 2023 17:43:39 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F612B6B;
	Fri, 29 Dec 2023 17:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3bb631656e5so1011440b6e.0;
        Fri, 29 Dec 2023 09:43:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703871817; x=1704476617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4NCIsXvRaT4RUXj2m5CrwiiUoqF/vM7/zwxLNbADhY4=;
        b=t/nLF1Lq7PEpuhZsisdQoswfbnssc56AlPP9A0KM6ylfydfungAmljU37HWK9B21Yq
         PVel8KRhZxrBUR0UAuysRzJ9scsjjgERXQezGRtpLNwb5sS7r0Fm0HsisZDN6gWLAJoY
         b1qDSK1Ta2pdw7nMP2k7SFB4UiAe1OuJnz/479a4/gBNbI/1vqGOHkByoN5cNFeNFW6o
         tsfdYiKI1uWAkgQfwyCKnSRdDjl2tTHJCzuTQh/L7KX+V7rbz3PjOs/xYYp54PD/G0o/
         TA1rXrWoW94aBbZ09y8hQQopiWlEOxkPx9O1pQ2I+MR+xSTQDbLIYyCMAovnBYZ+KVNq
         j6jQ==
X-Gm-Message-State: AOJu0YxYfqk3IIHaA+L76PL31cU1+te5aKXp27PywVJknMeOIaijg1qs
	pWvJl4Nd5XY1DDU8mikSjy8Z1DLVmw8wqDBLB9Y=
X-Google-Smtp-Source: AGHT+IHlVF4Xs1j4xT4Y+EVTCqK0APhhjEuh3RMTHKTTM8xckFBD6GS8pbV9tAGGzg1O3RlTR1QYjsP1Ew6IWoHW6F0=
X-Received: by 2002:a05:6871:3a26:b0:1fb:e5f:c530 with SMTP id
 pu38-20020a0568713a2600b001fb0e5fc530mr21569924oac.4.1703871817171; Fri, 29
 Dec 2023 09:43:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223001044.1401226-1-alison.schofield@intel.com>
In-Reply-To: <20231223001044.1401226-1-alison.schofield@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 29 Dec 2023 18:43:26 +0100
Message-ID: <CAJZ5v0jLkeTMDsatHB_uabj3yuyQswPm1nve=sv=kE=96qcpcg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: NUMA: Fix overlap when extending memblks to fill CFMWS
To: alison.schofield@intel.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 1:10=E2=80=AFAM <alison.schofield@intel.com> wrote:
>
> From: Alison Schofield <alison.schofield@intel.com>
>
> When the BIOS only partially describes a CFMWS Window in the SRAT
> the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> to fill the entire CFMWS Window, thereby applying the proximity domain
> to the entire CFMWS.
>
> The calculation of the memblks to fill has an off-by-one error, that
> causes numa_init to fail when it sees the overlap:
>
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x1000=
00000-0x1ffffffffff]
>
> Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
>
> Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CF=
MWS window")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>
> Changes in v2:
> - Send to ACPI maintainer, reviewer, and mailing list.
>
>
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 12f330b0eac0..b99062f7c412 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_subtabl=
e_headers *header,
>
>         cfmws =3D (struct acpi_cedt_cfmws *)header;
>         start =3D cfmws->base_hpa;
> -       end =3D cfmws->base_hpa + cfmws->window_size;
> +       end =3D cfmws->base_hpa + cfmws->window_size - 1;
>
>         /*
>          * The SRAT may have already described NUMA details for all,
>
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> --

Applied as 6.8 material, thanks!

