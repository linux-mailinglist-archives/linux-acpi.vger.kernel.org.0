Return-Path: <linux-acpi+bounces-2648-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEA1821429
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jan 2024 16:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D64281A84
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Jan 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF084C6C;
	Mon,  1 Jan 2024 15:08:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4A6107;
	Mon,  1 Jan 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5958d3f2d8aso138019eaf.1;
        Mon, 01 Jan 2024 07:08:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704121712; x=1704726512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5Zfb4IyMeAIrOR5PqPAMKPdJRjsKABG63QcTNwT52c=;
        b=c0ZYfaU7Z1w6f6Pwy38PHSg6ceYe8Vrh1SlCYrsxGoYp9SLgn/7Xh0onhCa86v+lq5
         cCCIhoLLPPST+vH9clBrORT8e/MSS1SUirQjru+MgcqkeW71WSIK2TCrtNPv9YwP95kl
         JmvZzMlQ0WFhU5YqKY+Hyj2ZLjB7/G8iDDMBbrAetodbD1ib8tla3Fxb2iDof8p5cpPV
         mb5epkMyhhCIbGd1c0QuDTqb7zHQKFAxHCINmsIvvrkH13Ix1dTB4wRrnFk1m+gD+jyp
         Se4+B6hg5MOjmDc+hSKW+kFz3/ay9rVBLXEyTNi9kfD7v0KCOuIP6mZbu4q5QZr5f92h
         zEag==
X-Gm-Message-State: AOJu0Yw46UifnKRueOuhz0M0xwjZ0DdeHBAOevc0TBmUQeVpPwzlOyAV
	T2W11ZFoTC/0a90hxUQIme7PuSXu354imdGMKRI=
X-Google-Smtp-Source: AGHT+IGNRHOaeJnwDLYSDQfked1BdrsUheUxQL6CEb7m1i2xAUsY0EA99ItkKfYYaToqmGkAgLxQqSzRFKXtNvmcQLs=
X-Received: by 2002:a4a:d1b0:0:b0:594:177d:8bd6 with SMTP id
 z16-20020a4ad1b0000000b00594177d8bd6mr22873360oor.1.1704121711842; Mon, 01
 Jan 2024 07:08:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223001044.1401226-1-alison.schofield@intel.com>
 <CAJZ5v0jLkeTMDsatHB_uabj3yuyQswPm1nve=sv=kE=96qcpcg@mail.gmail.com> <ZY8mOkPKResWyY4f@aschofie-mobl2>
In-Reply-To: <ZY8mOkPKResWyY4f@aschofie-mobl2>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jan 2024 16:08:17 +0100
Message-ID: <CAJZ5v0iPm2QZyqnr5uYO80Cp45tCE5Fny2WAL-7FjeznPX=z0A@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: NUMA: Fix overlap when extending memblks to fill CFMWS
To: Alison Schofield <alison.schofield@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, 
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, 
	"Huang, Ying" <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 29, 2023 at 9:04=E2=80=AFPM Alison Schofield
<alison.schofield@intel.com> wrote:
>
> On Fri, Dec 29, 2023 at 06:43:26PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Dec 23, 2023 at 1:10=E2=80=AFAM <alison.schofield@intel.com> wr=
ote:
> > >
> > > From: Alison Schofield <alison.schofield@intel.com>
> > >
> > > When the BIOS only partially describes a CFMWS Window in the SRAT
> > > the acpi driver uses numa_fill_memblks() to extend existing memblk(s)
> > > to fill the entire CFMWS Window, thereby applying the proximity domai=
n
> > > to the entire CFMWS.
> > >
> > > The calculation of the memblks to fill has an off-by-one error, that
> > > causes numa_init to fail when it sees the overlap:
> > >
> > > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x7fffffff]
> > > [] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xffffffffff]
> > > [] ACPI: SRAT: Node 1 PXM 1 [mem 0x10000000000-0x1ffffffffff]
> > > [] node 0 [mem 0x100000000-0xffffffffff] overlaps with node 1 [mem 0x=
100000000-0x1ffffffffff]
> > >
> > > Fix by making the 'end' parameter to numa_fill_memblks() exclusive.
> > >
> > > Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entir=
e CFMWS window")
> > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >
> > > Changes in v2:
> > > - Send to ACPI maintainer, reviewer, and mailing list.
> > >
> > >
> > >  drivers/acpi/numa/srat.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > > index 12f330b0eac0..b99062f7c412 100644
> > > --- a/drivers/acpi/numa/srat.c
> > > +++ b/drivers/acpi/numa/srat.c
> > > @@ -308,7 +308,7 @@ static int __init acpi_parse_cfmws(union acpi_sub=
table_headers *header,
> > >
> > >         cfmws =3D (struct acpi_cedt_cfmws *)header;
> > >         start =3D cfmws->base_hpa;
> > > -       end =3D cfmws->base_hpa + cfmws->window_size;
> > > +       end =3D cfmws->base_hpa + cfmws->window_size - 1;
> > >
> > >         /*
> > >          * The SRAT may have already described NUMA details for all,
> > >
> > > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > > --
> >
> > Applied as 6.8 material, thanks!
>
> Sorry Rafael - this patch is bad.  Can you back it out?
>
> I got some feedback here that showed this breaks a subsequent call
> to numa_add_memblks().
> https://lore.kernel.org/linux-cxl/ZYyozZcK9g4JE11B@aschofie-mobl2/T/#m16f=
13cafc186c7ebbf6037b3ae0e3ae572a83f77
>
> ATM I expect this will lead to a fix in x86/mm/numa, not ACPI.
>
> My apologies for messing up the mailing list and causing this confusion.

No worries, thanks for letting me know.

Dropped now.

