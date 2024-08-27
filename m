Return-Path: <linux-acpi+bounces-7893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2EB961535
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76A91F24818
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95A41CCB34;
	Tue, 27 Aug 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhBvK4Sb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13DE54767;
	Tue, 27 Aug 2024 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724778743; cv=none; b=NqxYOitobcVX2VwzdcYX206Bf7HPI7qxuRx90A916KY5kSS1tZmYqysqG29+dZZ/mxsjEIR1VqC0GHF3TA2wYqxWFTTNAx+RQ1yakbN2Pgk5EYRsAfXnNpSbN2iqrLyiavobYUo5yKZrAZp1LZK9CFzY+G3ILpHKuM6FX1Rtb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724778743; c=relaxed/simple;
	bh=089Q0VO8GXMKA5GhUHPQu2rPCYw84zh09Ml5OYxdz68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JirzE7Cne3u2HgNvXCSYWfpDayXxa8KBbtbnEip9qmYQIU7BjqcGvxbnMI2TRqRobJS/VDivsp+D7katSy2z2QpYFSTn4c/IwHLCriiCZ1buPJkHxh0SxxHqMoS2JIwOn9uCUtAvqMuNWLRBV4ohrqkcwfQrKms9MDX1b8i7Dx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhBvK4Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A55AC4DE11;
	Tue, 27 Aug 2024 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724778743;
	bh=089Q0VO8GXMKA5GhUHPQu2rPCYw84zh09Ml5OYxdz68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dhBvK4Sb/o23wrZW7Mrt5iWQIiEn+jadXQTYu1Rk2n915iNQ4gZQbkEf5G1TaOk7k
	 PXLr7c8PZZV1AozzrJTnD9lppGB1j7AurrJpQEYkX3yCKSlNwYVynRBYhX5tKCFZ8B
	 OKLZQ69zPJNqNiNMEm4ga0zi4UZ3JAp2WdLtGwr6Gcalhao+7BrSIoffhar+yV5LIt
	 jf29LRVcJnQKEliVHu1M6h0jmyrljxMxwXhkOJ4J33kQ23gByKi2hwFl37Nq+VBsrH
	 4MVdD6TI4zcjK683eaexn+32y2m7Jh8M+8lkUmj6q3t+g3AStgAYMIDaUKirQLlNsQ
	 wuBExyyLxjDJw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27046394c9bso3374151fac.2;
        Tue, 27 Aug 2024 10:12:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWUNBkAWitpOtD7ou1SbaVRGD6vTbYp1woPgGj5vmBkkmllO1RMdvvKSUVuS3veRF3v7eqqpVEE+Qa6@vger.kernel.org, AJvYcCWeHMTSNeUpXRmTDK3KG4KWsMWDsyp2YDxIWgY3JkpthH0t/7fztpRHSkJj3FlfGf1b8A2TCBOldnuiBGPw@vger.kernel.org
X-Gm-Message-State: AOJu0YwgK9lnoinvtm+b57MvMZNQTWDuIBvfU61NFriQIUWytYyzLaz6
	dUd08OfNP1x+jSZJR0gPDNVQY7/RR819RPBdgLNP9UdjtFFf4xzUt0+gMDh3XsvceDLyfPR08Yn
	MrTEJb8dOauTFsXAmvgIOoq2DJtc=
X-Google-Smtp-Source: AGHT+IEi+8s9/sVzsiTVwscNVREvFCPTsaKYFoVZmsBGqFAgUmBmznctQE6RetdHOf6mO/SZ096Q9h8qJmnqUy0gcrs=
X-Received: by 2002:a05:6870:210a:b0:270:6bae:5573 with SMTP id
 586e51a60fabf-27759e7bb0fmr4006576fac.28.1724778742659; Tue, 27 Aug 2024
 10:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop> <87mskzcnmf.ffs@tglx> <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop> <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx> <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
 <Zs4HCZH3M9nRXUvu@sunil-laptop>
In-Reply-To: <Zs4HCZH3M9nRXUvu@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 19:12:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
Message-ID: <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller support
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Anup Patel <anup@brainfault.org>, 
	Samuel Holland <samuel.holland@sifive.com>, Robert Moore <robert.moore@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Kumar Patra <atishp@rivosinc.com>, 
	Drew Fustini <dfustini@tenstorrent.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 7:04=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 26, 2024 at 11:22=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
> > >
> > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > On Mon, Aug 26, 2024 at 7:22=E2=80=AFPM Sunil V L <sunilvl@ventanam=
icro.com> wrote:
> > > >> There will be a conflict in PLIC irqchip driver due to a recent pa=
tch [1].
> > > >> This patch is not in latest RC5 release but in linux-next. I usual=
ly base the
> > > >> series on latest RC release. Should I rebase to linux-next in this=
 case
> > > >> and send the next revision of the series resolving the conflict?
> > > >
> > > > No, please don't.
> > > >
> > > > That will be resolved at the merge time.
> > >
> > > Alternatively you can pull
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgen=
t-2024-08-25
> > >
> > > which I'm about to send to Linus latest tomorrow morning. That contai=
ns
> > > the conflicting change.
> >
> > So I've applied the series on top of the above.
> >
> Thanks!
>
> > This included a full-swing rebase of the last patch, which I hope I've
> > done correctly, but Sunil please see
> >
> Yeah, sorry about that. You have resolved most of the conflicts but few
> are missing (which were not obvious anyway). Could you please take below
> commit and squash?
>
> https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb457748c05=
cf4e75a

Can you please send me a diff?

