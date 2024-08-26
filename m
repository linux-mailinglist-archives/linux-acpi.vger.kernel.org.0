Return-Path: <linux-acpi+bounces-7827-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB66B95F63B
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 18:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09E341C2206C
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 16:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3028194ACF;
	Mon, 26 Aug 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYWABbd0"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987B44374;
	Mon, 26 Aug 2024 16:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724688930; cv=none; b=mPIywsxa/zY1JPoOA6DuRdQyXzMrbj6DWYMRGNkWg1Lzhf6xnhTnyaRTV7TygeOEVLpNzN/+SUTrVaF+L6jLMi+wB8nDgBAp8lsX6vhGo4z+F5wzyLULYOU2fRybVrYh48FUWWL/NXZHA1Y5YR3zpPWea0uJprw9VQ+Gy0piPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724688930; c=relaxed/simple;
	bh=jkqzvuLSKjk6lxkGNGUcsw4Ig8szieDjSx37poI+59o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kysOt7e+BPTbVGfC1Lr7I0xgC1ySTtarFdgs0hTvfXdZY+HXnRzv+WuBoUTvJVzHvlWmJ7M+Ai7T4botpUHd3FTSB3iC6PTGMct2lDB+KkHaBv1jtN7itq1Z1RE+efWcGFqfRv8mNDkOHcgBFOOwwwPDIJJP/vGVSoXga7zFpEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYWABbd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE00C52FC6;
	Mon, 26 Aug 2024 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724688930;
	bh=jkqzvuLSKjk6lxkGNGUcsw4Ig8szieDjSx37poI+59o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NYWABbd0U6yyuZqn5kmSmh7Xdk00XRb45Dx7+od8kmc/pBgSbzMmA4k5NDBVX2wYI
	 5iJB/R9LzPZ6f5xCvUyJIXel4a+kYx6vhDtNmtl6Xj21jyiXxOe6qIo7uReIXrv0U2
	 F+M9qmx/R4K0bPMU1mSFNJFVApkx9rQ9jIvpqMqPKLU9E60rqVNW2O2X2nlh9/A8XC
	 UD6NzLGtFDvo0O92r7YhbEc/ge4S16B0nZ8viWUeReSOHHgRqogx3TZkk0BYqvR17X
	 b9hUpRe7laTZBx8dtKx8QUujAaTqLeNA4U+72f5NFg3PMezMyuNq/ubMbJ1jtw0oeN
	 vSDudxbd3Cijw==
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-27032e6dbf2so2927846fac.1;
        Mon, 26 Aug 2024 09:15:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU8cOdiTTO4/OnP9JU+0Q3eEaVb3u5sEDk1DzjKK1IJ34WpvfJRaf4W/B9kIA/dKaCq+wMw8Y4rws6Y@vger.kernel.org, AJvYcCUUTB6AlSMTWui6uaFyD/lRp3VYm5hgCSZw05FoB10pVVBegQZtS89eyURodjHn5CdoaBNhn+J7zTSA/mzs@vger.kernel.org
X-Gm-Message-State: AOJu0YzitKuHFV9J+FjFRFuqOD6FM7BI2mJijb+zugwxH+Uu6SyA+CH5
	IUHqZni9J98XQDYYH0wevrWVex+CJnVpWYkJuXZ9Bu5aUiVruH2yUEyCPEV12e+4l+ufYFkaBKu
	K0vGBYCTamT+l7iKxIjL2O0B8mCc=
X-Google-Smtp-Source: AGHT+IFp1BTLSWH4mpHphZAC/nONYYceOu5PBYhd0g/XSqLewTat+1/1B6joUdncVGCUq66DbIYrXTslw/vMXVK62fc=
X-Received: by 2002:a05:6871:7419:b0:270:2879:e349 with SMTP id
 586e51a60fabf-273e6552ce8mr11105378fac.23.1724688929326; Mon, 26 Aug 2024
 09:15:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop> <87mskzcnmf.ffs@tglx>
In-Reply-To: <87mskzcnmf.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 18:15:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
Message-ID: <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller support
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sunil V L <sunilvl@ventanamicro.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Robert Moore <robert.moore@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 5:25=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Mon, Aug 12 2024 at 06:37, Sunil V. L. wrote:
> > On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> >> This series adds support for the below ECR approved by ASWG.
> >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIK=
ia7zR/view?usp=3Dsharing
> >>
> >> The series primarily enables irqchip drivers for RISC-V ACPI based
> >> platforms.
> >
> > This series has spent quite a bit of time now on the list. As you are
> > aware, few clarifications like _PIC codes are also done now. There is
> > no major change after you had agreed for the design. So, can this be
> > considered for the next release please?
>
> Rafael, if you want to take it through the ACPI tree, then for the
> irqchip parts please add:
>
>   Acked-by: Thomas Gleixner <tglx@linutronix.de>

Yes, I'm going ro do this.

Thank you!

