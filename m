Return-Path: <linux-acpi+bounces-15822-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50896B2B789
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 05:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2D55E4A95
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Aug 2025 03:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAEC14AD2B;
	Tue, 19 Aug 2025 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="V4tFcgxb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A1F13FEE
	for <linux-acpi@vger.kernel.org>; Tue, 19 Aug 2025 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755574220; cv=none; b=baOzgAEBJZYnzlRgKBfKyC4EQmDRJwGA3e9ln5UYEL59jMnS5cMEcLhzRCvKI20ZLva1Yda+Erd11HEdiOGA0nAkIHODBmUlyrVdOnruxXcpPVqT/nAoHZfm3oCvDr6FgBIHkqn3wz9Mvw7PxnnpV8SD5UVATv9OjA/QyfEm8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755574220; c=relaxed/simple;
	bh=hejDrutBwVtkHHg+tPFEf3z2Gzy88JBlXWqIMznyq9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAs32GiW3Nus+pYojnQ/mDS3f0mjttBUoJtNrMVRSXtyL8nD+C5Vsxm/vmQcBB2iyIYyk3OmcHSv3HSvKpcVxqTenvSxbIx6Of3XXJjRglp8YMUycy0G0t/z6Bk66OPjNqTtHgPbt891daeuwvGbPBCHHS9JxKOOkA5v5PgJgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=V4tFcgxb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-333f8ef8483so36784021fa.1
        for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 20:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755574216; x=1756179016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhVUQhRbFoSi2h18eEQkGPOra/e5Kyo+DwjDJYlDYA8=;
        b=V4tFcgxb81bq8D+Gr893gMrc7HvxC8JWS5QYQh1kARQISbZkB+5EL1juV/vljXnxgN
         TWJo1pK7sKtIxMErV1hPR5+bm02eLKnPnX27TaPiwn/TRU2uBtJq3R4CD77InBMoy7so
         460/9qt1E6t6l07iMGKh+RdRSvWv3pR1kjMS5gtvELhfYYEgoxRDoXoTSx9fH6uJ9BY/
         HPp0SM2ezMLX4ZfJJPJliB1RbKvzAsJQux6dTvPmBmrrjnz+eKvKENFFSm7R8JnTwLNv
         UHNt/l7vbfuLiPd5RDRayhoWfk8C2vk8QhIYBFMx/zb6y2MXloX7lkFZAisF8z3lQWTC
         DSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755574216; x=1756179016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhVUQhRbFoSi2h18eEQkGPOra/e5Kyo+DwjDJYlDYA8=;
        b=bA4MB4P7e4vW5CUWvgTAvsCaHOPvzEefVngqWet/DUIl1BCOxRJ3qYGsKLqrZbjd76
         Q2fWEoI4dJrao8ezq4bCyWGX8aIlkU2T7lDeOIcRyHMOcaa3W1Jn9vna4aAvotmPXiUP
         HML/fOnn78g2uROddS4dojL86h7VI13gVodFwOocnMrBzQ2kqdfii8k0GKpECAs/4xvt
         XOXYv7Mx79IiKHUbu+t8UA23LP8JtUi3UDvwzOJGrDA94/30kXHN8eAGENyTi9wkNudb
         jX7NRItq5Nr0sE7rAv1fKvfzQwE3fxFv/iW06Y3Oesgrrlr+lpWjUUFRoWw+Loy7nB69
         qHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRwdlmI4mGTGP5Jj1it35jiit1nebKN4hRrfPS/2enYpzE5JxPuvFa/qQNC+Aef1F6wccAyZxcDC7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxXzPaRQatoI/zuRaIP7qGTtYzRLmHplPi8XCwuRtedpq277WmF
	0tCEWPLk1raGdGsUk4n/wmYRees8Mt5IW2ncam0DyofAJxfjFH6zkivr2SDx10F/R63U7ee5tVm
	odaqdKRcU60lGZJOG0xDKmNgLoyZgEXiDRfSDfIQyPg==
X-Gm-Gg: ASbGncvJzbb3qeEA3vaYy7Jxq1v5xSDElRk1Lb+blstVhmMLbkhhl0XIDAURtux9Mwy
	CY+fFKKpZIwIVtWA5KimvZc83cpWXyJeKKteFVHQsbABMyH/h48ZL+hWOGTprQIx14dXmL47m8H
	mqLNXIF6SF/LkImg8WfOBZUNOiXIOZBPsNXRGKrqnY8ZCqqFw78BeyEkFXD6a3e7pdMaXKxvFvM
	yXnXaaHxD+sL5ry5A==
X-Google-Smtp-Source: AGHT+IGVnqZwPZZ7hgdjw/Q7u1vNN+1/ztdFP7S/ua4HnZs+KOgdIAGptOekgKLMoLxA7IyVYjoIfKDqA+WjmTJ71Ns=
X-Received: by 2002:a2e:a99a:0:b0:332:362c:c775 with SMTP id
 38308e7fff4ca-3353026d3edmr2279561fa.0.1755574216021; Mon, 18 Aug 2025
 20:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818143600.894385-1-apatel@ventanamicro.com>
 <20250818143600.894385-3-apatel@ventanamicro.com> <aKPu2g1MOZBBzQbV@pie>
In-Reply-To: <aKPu2g1MOZBBzQbV@pie>
From: Anup Patel <apatel@ventanamicro.com>
Date: Tue, 19 Aug 2025 09:00:03 +0530
X-Gm-Features: Ac12FXzDuQ7Umqrf04wpGpc5VzWEYp9wpAAjguHv23M1BEzrlXyzJmRKwCFKs3o
Message-ID: <CAK9=C2XmDGOz9_euC4vtchOxr+8f+m+9zZYVewCc2s7GZhd4Pw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Yao Zi <ziyao@disroot.org>
Cc: Sunil V L <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Andrew Jones <ajones@ventanamicro.com>, Anup Patel <anup@brainfault.org>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 8:56=E2=80=AFAM Yao Zi <ziyao@disroot.org> wrote:
>
> On Mon, Aug 18, 2025 at 08:06:00PM +0530, Anup Patel wrote:
> > In RISC-V, there is no CSR read/write instruction which takes CSR
> > number via register so add common csr_read_num() and csr_write_num()
> > functions which allow accessing certain CSRs by passing CSR number
> > as parameter. These common functions will be first used by the
> > ACPI CPPC driver and RISC-V PMU driver.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  arch/riscv/include/asm/csr.h |   3 +
> >  arch/riscv/kernel/Makefile   |   1 +
> >  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
> >  drivers/acpi/riscv/cppc.c    |  17 ++--
> >  drivers/perf/riscv_pmu.c     |  54 ++----------
> >  5 files changed, 184 insertions(+), 56 deletions(-)
> >  create mode 100644 arch/riscv/kernel/csr.c
> >
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 6fed42e37705..1540626b3540 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> > @@ -575,6 +575,9 @@
> >                             : "memory");                      \
> >  })
> >
> > +extern unsigned long csr_read_num(unsigned long csr_num, int *out_err)=
;
> > +extern void csr_write_num(unsigned long csr_num, unsigned long val, in=
t *out_err);
>
> I think it's more consistent to directly return the error code, and for
> csr_read_num, we could pass out the read value by a pointer. e.g.
>
>         int csr_read_num(unsigned long csr_num, unsigned long *val);
>         int csr_write_num(unsigned long csr_num, unsigned long val);
>
> This allows the caller to eliminate a variable for temporarily storing
> the error code if they use it just after the invokation, and fits the
> common convention of Linux better.

Drew had similar comments so see my response in the previous
patch revision. (Refer, https://www.spinics.net/lists/kernel/msg5808113.htm=
l)

Regards,
Anup

