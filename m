Return-Path: <linux-acpi+bounces-7895-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C3D96160F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5B51F2227F
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 17:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF04126F1E;
	Tue, 27 Aug 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r7WCloVo"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271511D0DC6;
	Tue, 27 Aug 2024 17:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724781425; cv=none; b=dv6mcDT0VvpPjZM49F/f8M0k1fSiXHkq6eROuyvTm0Ht00AMqFlAAA/ymqYrcq46EgA0ltGubIluRLtlNBL8xdDHm0pfOmTMULGXWjpPu+LuHTO65DfhNojy373Lz/eUhHeKU089VsUxV5WGdbFvYfcm5zt7W4MEZ9xn7NuGe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724781425; c=relaxed/simple;
	bh=OptW6RUfILHvbgx1GROy+YCtAO9VnTyYH8If/uUZl9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnSNKayBQITvYcg22c3yGSAqxTRC60L+FWXxQGuzRaWhR8oFHCGKPAM/vdPNuqMr6/ORyqtq5+auC5DuX9oJCI0/xz9wW52XZ2eunXoTA2IWHsAleN6VsPHalszU5TABmZTkBJvCSNy8sA55LGsQWynAqGPlQ8VO3UzrApiNfaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r7WCloVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF24C8B7A5;
	Tue, 27 Aug 2024 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724781424;
	bh=OptW6RUfILHvbgx1GROy+YCtAO9VnTyYH8If/uUZl9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=r7WCloVoYuM9ww7zwA6zTDGNcuy2DT8wtpbwHYllBDwTb6TZBn9p4VtQAlU6UTzBX
	 dW898KLVdBEgG2AVYmb7Er91/fY4QbZkovmDakzhgCmpfUV3YP3xabc2nu2Ow9gDUq
	 g3VaoXbrMKfi0haM9wwvX/8halYF+J/nHZL1qIL6CNYqajCWG4YeSJZP4wztnKjrhr
	 M94cDGWhNfq6VHdxaKrQPZLz3zxij104USu/epHOJfPf5u8IDq3GL4j7VTlSc6bZ4x
	 sVb/xh5HBqToIzLyzloDJbL3bVF/tJ+6b2VL8yZZ4Y1xtCxkN4dNv8qEKxT2fU5Hbp
	 Zkr3kPcF/m4rA==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-268eec6c7c1so4049308fac.3;
        Tue, 27 Aug 2024 10:57:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOcWTuBVZDr7UUO5LbFW9EcPTZrQMII8x1t0bdmBfEcb/nyOt4d7A1ixi4+vYCuZjRht4GAN4FJJRR@vger.kernel.org, AJvYcCXEMq/GZQ99aQwJBMjMqJ28DBGX7EeeVu1bh3nZPuSrmwKAujPpoi67aDbdyxoqsBdxUe2Z6w9icBz3Bsxo@vger.kernel.org
X-Gm-Message-State: AOJu0YxZSehoWyGItfrAB6mQBdtxuw0Q1hMHwHo0lgmVvc7JqWrQ4f6y
	1xtQKbN1pheAYnRhTAmYOPJHg2GOCkjlJu6kz2uGF5sz9vV00UCHFvw7eFwaUO0chdozGc1ZVh7
	dDj3cPCSii6gCNBaY1zBykCo7Klk=
X-Google-Smtp-Source: AGHT+IFu6T80cIoH2IuG57YoKLSfrmXhE5E+Qf/cSlYkLOAMDpJFXXRx8jvbWvu1aUtvkEAiMaN8kHOwbvIrkBuQYBM=
X-Received: by 2002:a05:6870:b252:b0:270:6ec0:c00 with SMTP id
 586e51a60fabf-273e64b5c7dmr15986972fac.12.1724781423743; Tue, 27 Aug 2024
 10:57:03 -0700 (PDT)
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
 <Zs4HCZH3M9nRXUvu@sunil-laptop> <CAJZ5v0i-8N8VG-D4FRh0qFxt44Ax4TKY_CiFhZxLCzkhQrt0=Q@mail.gmail.com>
 <Zs4NcmM79kMUc7Ol@sunil-laptop>
In-Reply-To: <Zs4NcmM79kMUc7Ol@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 19:56:52 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>
Message-ID: <CAJZ5v0hRWxNSrx9XPBdsU-mQpDurRJAUmzHtHNkyCTf0Hz1TgQ@mail.gmail.com>
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

On Tue, Aug 27, 2024 at 7:31=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Tue, Aug 27, 2024 at 07:12:11PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Aug 27, 2024 at 7:04=E2=80=AFPM Sunil V L <sunilvl@ventanamicro=
.com> wrote:
> > >
> > > On Tue, Aug 27, 2024 at 06:20:24PM +0200, Rafael J. Wysocki wrote:
> > > > On Mon, Aug 26, 2024 at 11:22=E2=80=AFPM Thomas Gleixner <tglx@linu=
tronix.de> wrote:
> > > > >
> > > > > On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > > > > > On Mon, Aug 26, 2024 at 7:22=E2=80=AFPM Sunil V L <sunilvl@vent=
anamicro.com> wrote:
> > > > > >> There will be a conflict in PLIC irqchip driver due to a recen=
t patch [1].
> > > > > >> This patch is not in latest RC5 release but in linux-next. I u=
sually base the
> > > > > >> series on latest RC release. Should I rebase to linux-next in =
this case
> > > > > >> and send the next revision of the series resolving the conflic=
t?
> > > > > >
> > > > > > No, please don't.
> > > > > >
> > > > > > That will be resolved at the merge time.
> > > > >
> > > > > Alternatively you can pull
> > > > >
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-u=
rgent-2024-08-25
> > > > >
> > > > > which I'm about to send to Linus latest tomorrow morning. That co=
ntains
> > > > > the conflicting change.
> > > >
> > > > So I've applied the series on top of the above.
> > > >
> > > Thanks!
> > >
> > > > This included a full-swing rebase of the last patch, which I hope I=
've
> > > > done correctly, but Sunil please see
> > > >
> > > Yeah, sorry about that. You have resolved most of the conflicts but f=
ew
> > > are missing (which were not obvious anyway). Could you please take be=
low
> > > commit and squash?
> > >
> > > https://github.com/vlsunil/linux/commit/c85f9d0dc31c0e77916ecdbb45774=
8c05cf4e75a
> >
> > Can you please send me a diff?
> >
> Hi Rafael,
>
> I have sent the diff to you. Hope that is fine.

Squashed and pushed out, please see

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D9153fdae30867fe5d71f6a15b8a1974d7e801f39

Thanks!

