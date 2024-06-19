Return-Path: <linux-acpi+bounces-6512-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D1990E19E
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 04:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABC0F1F225D5
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Jun 2024 02:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296854B5A6;
	Wed, 19 Jun 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvluqBkJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2540224DD;
	Wed, 19 Jun 2024 02:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718763880; cv=none; b=O8MpPEYwtZ4yj332U0+1iEth5YRXyEw5BpNy7s+GwBfNoisucAXJB1GRpL4BNX4Jqs+GlE91fK4TixEQiNQ4kF451YJZox4BcvIutXt7Ld157SM+/xBTtV1dPgA153dCxi0VhoRphhgg6ByGNmIWtx0QdI0++pp5FsN985LzXWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718763880; c=relaxed/simple;
	bh=YdTiG/CZB3kW5hJZRirxPSwhHLjUr7Zwx1Rs51gKz1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYY3m/azaxRwJdZD1yPk9Jt6BMzTP9CPqQU5t0ND05iPoTdB1wosgdODJ8rg6fJ67q00TiJbl9VwdgNmebgJi9u5Nmi0zj5dTcBnft6dpxZHL0ToHrZiZeVL+/7vbXrFiOvn+fXtI9ARLdSQEbYnz+adQ/Pt86vibc1zshnpdaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvluqBkJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C27C4AF48;
	Wed, 19 Jun 2024 02:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718763879;
	bh=YdTiG/CZB3kW5hJZRirxPSwhHLjUr7Zwx1Rs51gKz1Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=OvluqBkJzPPPIIgHv9DmTCULgSEsCFZT9e/9wAJkmufU1GmWwfkHPkwQLGl43GwKV
	 C3f4gs+NOOoJGVKBXbcZXqC1HzpCD3KgotUGAvKTQ9umefwIxKlWksRiV4dDV4mlPY
	 SRlhqWB/XOrzZoqeOoeFJxTDuv1ID+QP3cuV2Tg0dpD/1/YNKOPIfmAos0yE7BPXJ5
	 18RyX9IWhRn8BZHlodnqVgcOy3soSjA4ZfYk90hfFJWaiAG9zdXxtekvFWy+qe/IIE
	 61HJR6kXnwFcEigJQIjp/rlUsHwKR8SEcmXyre65taJwys5gIxSSaxRfbMmnbFffSG
	 UrN3xGe8GuMNg==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363826fbcdeso112710f8f.0;
        Tue, 18 Jun 2024 19:24:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG7eq8Hd9Lvo0AKWSZ677SxZ/cbL3NljDxwAphueB5mCr/EZSlZ0bZThnMDoRBM+8Ju58MJGAN6mGTaorZLyViZQjS+DYwOXZzum9KNWEU111DiPuqhESdRK9KcOLDK0dZR6FITf5Djw==
X-Gm-Message-State: AOJu0YzEgMR0hfkInQ7Np/zS5Mf7yVPrBrvXJAbKRNcIIINA/4uZyL+1
	nAeWzn0mV0SkTSazbCFkc6Hrfi+phSSE4jqShZnPaqGbmEvPbQ6kc9VN4N/5PIh7Rqj9FpfM4K7
	WBjI8XTLxG2mLnqeiK6N2IIsSV5M=
X-Google-Smtp-Source: AGHT+IEQ6lBqSF/SAuTEXT3/C0b8JrIn+1+eVBZa2U4YKfxPYRohzHDTALEnDx9kkLU3Jijf3mBE/Na4m9dHAT/8Vqo=
X-Received: by 2002:a50:c35a:0:b0:57c:4db6:c0fc with SMTP id
 4fb4d7f45d1cf-57d07e7acdbmr508589a12.10.1718763857174; Tue, 18 Jun 2024
 19:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
 <CAJve8o=8thBhU3NyTaS6sE9rQ1VR_Qf4O8FkAxpmp1q8P-6VaQ@mail.gmail.com>
 <20240618151820.GA2354@willie-the-truck> <CAJve8o=-bZhQS289jwxG=Aq2BOXk5OzdgPKT=nFE9yw_HYYnQQ@mail.gmail.com>
In-Reply-To: <CAJve8o=-bZhQS289jwxG=Aq2BOXk5OzdgPKT=nFE9yw_HYYnQQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 19 Jun 2024 10:24:05 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6qLrQMVEtGgy7VM_cOh+2HytQEZ-9aZc4Gist-rhNZ0Q@mail.gmail.com>
Message-ID: <CAAhV-H6qLrQMVEtGgy7VM_cOh+2HytQEZ-9aZc4Gist-rhNZ0Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden option
To: Haibo Xu <xiaobo55x@gmail.com>
Cc: Will Deacon <will@kernel.org>, Haibo Xu <haibo1.xu@intel.com>, sunilvl@ventanamicro.com, 
	arnd@arndb.de, ajones@ventanamicro.com, 
	Catalin Marinas <catalin.marinas@arm.com>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Conor Dooley <conor.dooley@microchip.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Evan Green <evan@rivosinc.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Zong Li <zong.li@sifive.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Chen Jiahao <chenjiahao16@huawei.com>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Zhao Ke <ke.zhao@shingroup.cn>, 
	Andy Chiu <andy.chiu@sifive.com>, Marc Zyngier <maz@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Tony Luck <tony.luck@intel.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Robert Richter <rrichter@amd.com>, Yuntao Wang <ytcoode@gmail.com>, Dave Jiang <dave.jiang@intel.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 9:18=E2=80=AFAM Haibo Xu <xiaobo55x@gmail.com> wrot=
e:
>
> On Tue, Jun 18, 2024 at 11:18=E2=80=AFPM Will Deacon <will@kernel.org> wr=
ote:
> >
> > On Mon, Jun 17, 2024 at 09:34:18PM +0800, Haibo Xu wrote:
> > > @Catalin Marinas @Huacai Chen
> > >
> > > Could you please have a look at this patch for the ACPI_NUMA config o=
n
> > > ARM64 and LOONGARCH respectively.
> > >
> > > Thanks!
> > >
> > > On Thu, Jun 13, 2024 at 4:37=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com=
> wrote:
> > > >
> > > > x86/arm64/loongarch would select ACPI_NUMA by default and riscv
> > > > would do the same thing, so change it to a hidden option and the
> > > > select statements except for the X86_64_ACPI_NUMA can also go away.
> > > >
> > > > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > > > Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> > > > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > > > ---
> > > >  arch/arm64/Kconfig        | 1 -
> > > >  arch/loongarch/Kconfig    | 1 -
> > > >  drivers/acpi/numa/Kconfig | 5 +----
> > > >  3 files changed, 1 insertion(+), 6 deletions(-)
> >
> > This looks fine from an arm64 perspective:
> >
> > Acked-by: Will Deacon <will@kernel.org>
Looks fine for LoongArch:

Acked-by: Huacai Chen <chenhuacai@loongson.cn>
> >
>
> Thank you, Will!
>
> > Will

