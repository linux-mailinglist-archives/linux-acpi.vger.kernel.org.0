Return-Path: <linux-acpi+bounces-14732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49460AEA5DE
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 20:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0BBD3B28D5
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Jun 2025 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205162EE999;
	Thu, 26 Jun 2025 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKMeFV4P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E142EE989;
	Thu, 26 Jun 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750964048; cv=none; b=eg5DpFJjqO+VdelTMhLkUDopvkchBEnRr+iXnywN06MTvDz13CeU9I/io/yT+aJUMxjzIGZrJldF/aVR7H1KuhN3FsP2W02ameLU5nBlPf4Qy5nv+N90FkEK+lyERjiXocZQJZWkz1dKL+gsihlc9oNfHTlcUH5vlu6bAqlJvNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750964048; c=relaxed/simple;
	bh=CRPdtuLM0CcNjNtofnI5MLiYSs0adD0lF4Xm5lnvrSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1CyzZZdAbYEhDcb4Rn2dJEP5lIslo4d9Yyw92ut0jrK4uriOO81JriKlOFBzKL33AFNBfkIcZCEqE8/Ksvgsjgptnuuq5IMgoF9B/6wFJxB0/UxtF7qQJcFa62DNaGIhQQq2cSacnbIWP3+qlQKFVNJi7dI0AY/i+IbLyRDhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKMeFV4P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFADC4CEF1;
	Thu, 26 Jun 2025 18:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750964047;
	bh=CRPdtuLM0CcNjNtofnI5MLiYSs0adD0lF4Xm5lnvrSY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BKMeFV4PVPkKfOkFYr695gOqYIoTw8tVSq+8qGOBqPV5pBZHFPuiW8dPKLpxw79lG
	 iXnfSkPEAJYJBJRFRDciBichjIVqYZBWaGSr2c65mSg7OWaEfYUx4k8zXu6OKEjkhP
	 vnDnKcr3hDGvIsPLt5Jor+ZXaoRjLIneA74QD3Q5LPP3PYisTyL0fgIIIMitmt2fYW
	 mJPMHBU0mEmHM4jbWcFZnrZXWYTc4p1zCIXnC+uFIDqHCRI22lSbodDtF/253PeElI
	 ooyF6kcSQV8r88m5P4St3PfGUSyv+QMut5poOMJHuOQF0+59voheNnKdGwltsbHjSX
	 JPjul0kSWhHCw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-60f24b478e3so695334eaf.3;
        Thu, 26 Jun 2025 11:54:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU77djavVfHa6FYpIIHrBj5W6xNyFbrGQR2C8hRnWmXrRLumJ8K43I1yGp8EQMOB35YshN+82rlwUL6Lw==@vger.kernel.org, AJvYcCUb4WHVx6n8hsAWxU3gd6mqnx9MAFyFMKT9BvfH/RaOjzvdl/8JPta+Zg3SPb/8zbUvCATv4+wc73xT+0cx@vger.kernel.org, AJvYcCW9/UK5CCI3sH2HSGvXHF6evxtriun5XUiRAAnUBuWRDU7eNWpc64IB3umQkfDnv69WlnYIsEltZRR5BoPwhwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxInOUj+P4Q/UFqZz7bqX8SGjyVQE88dI4DNQCBgrXNH6Q1p3mo
	jN/8JCzRy20V8OQOAWjyQ8yhHSdppMxbZcczY4G/BzPldSJeGU7ikcpAuenNNVFrq64APmMYW9m
	sf3HCxncBsHtIsQEXKIglbueG0d9F3nU=
X-Google-Smtp-Source: AGHT+IHGCoFMPvy2tuyy0NuptjbS5wcFjohojwnEfFAiT+MJGpjfp5uX8uCnCT7sPgbatsQ9sYdMGOJoB5pDXOE+ZHI=
X-Received: by 2002:a4a:ee17:0:b0:611:b073:7c31 with SMTP id
 006d021491bc7-611b9174eb9mr282258eaf.8.1750964046633; Thu, 26 Jun 2025
 11:54:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624202937.523013-1-colin.i.king@gmail.com>
 <685c6cd3bf88b_2c35442946c@iweiny-mobl.notmuch> <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
In-Reply-To: <04752c56-d6fb-4fab-99d2-93449c8c5d8d@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Jun 2025 20:53:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQ54bdD38a=s1AkjCT8_aRHqd+AV3e0EXJLWs7hoM=jw@mail.gmail.com>
X-Gm-Features: Ac12FXzQq8iKHulv-jKbNd8syZa2NY8HQpU-5dzLaNTv0lklfRYcKXjpCJoIg9Q
Message-ID: <CAJZ5v0gQ54bdD38a=s1AkjCT8_aRHqd+AV3e0EXJLWs7hoM=jw@mail.gmail.com>
Subject: Re: [PATCH][next] ACPI: APEI: EINJ: Fix check and iounmap of
 uninitialized pointer p
To: "Colin King (gmail)" <colin.i.king@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 11:43=E2=80=AFPM Colin King (gmail)
<colin.i.king@gmail.com> wrote:
>
> On 25/06/2025 22:40, Ira Weiny wrote:
> > Colin Ian King wrote:
> >> In the case where a request_mem_region call fails and pointer r is nul=
l
> >> the error exit path via label 'out' will check for a non-null pointer
> >> p and try to iounmap it. However, pointer p has not been assigned a
> >> value at this point, so it may potentially contain any garbage value.
> >> Fix this by ensuring pointer p is initialized to NULL.
> >>
> >> Fixes: 1a35c88302a3 ("ACPI: APEI: EINJ: Fix kernel test sparse warning=
s")
> >> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> >> ---
> >>   drivers/acpi/apei/einj-core.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-co=
re.c
> >> index 7930acd1d3f3..fc801587df8e 100644
> >> --- a/drivers/acpi/apei/einj-core.c
> >> +++ b/drivers/acpi/apei/einj-core.c
> >> @@ -401,7 +401,7 @@ static int __einj_error_trigger(u64 trigger_paddr,=
 u32 type,
> >>      u32 table_size;
> >>      int rc =3D -EIO;
> >>      struct acpi_generic_address *trigger_param_region =3D NULL;
> >> -    struct acpi_einj_trigger __iomem *p;
> >> +    struct acpi_einj_trigger __iomem *p =3D NULL;
> >
> > Apparently my review of these was pretty weak...  :-/
> >
> > That said; Why not skip a goto as well?
>
> Because the goto uses a shared return path and hence reduces the amount
> of return epilogue used in the generated code.

Applied, thanks!

> > diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-cor=
e.c
> > index d6d7e36e3647..fae01795e7f6 100644
> > --- a/drivers/acpi/apei/einj-core.c
> > +++ b/drivers/acpi/apei/einj-core.c
> > @@ -410,7 +410,7 @@ static int __einj_error_trigger(u64 trigger_paddr, =
u32 type,
> >                         (unsigned long long)trigger_paddr,
> >                         (unsigned long long)trigger_paddr +
> >                              sizeof(trigger_tab) - 1);
> > -               goto out;
> > +               return -EIO;
> >          }
> >          p =3D ioremap_cache(trigger_paddr, sizeof(*p));
> >          if (!p) {
> > @@ -502,7 +502,6 @@ static int __einj_error_trigger(u64 trigger_paddr, =
u32 type,
> >                             table_size - sizeof(trigger_tab));
> >   out_rel_header:
> >          release_mem_region(trigger_paddr, sizeof(trigger_tab));
> > -out:
> >          if (p)
> >                  iounmap(p);
> >
>

