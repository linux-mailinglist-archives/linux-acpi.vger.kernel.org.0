Return-Path: <linux-acpi+bounces-7834-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CF295F80E
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 19:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB531F23674
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Aug 2024 17:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6454C198A02;
	Mon, 26 Aug 2024 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDUPpN3j"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD5B193430;
	Mon, 26 Aug 2024 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693235; cv=none; b=Ct7CTQGDr7+DweHUuMUtrdtAtI/xQt8RHpXriWG5ZP6xK+mtYizvmlFPsKLBTIikxczc1tStwh2Zl+G6fpGGRoOEteCblatQnCs7Y9q2OVlgZrUGcK8iumVlHO08VvcfvNVewCQniZ9h+gxGqhAETL1r6Ud6HDbdDmy7ecpAAmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693235; c=relaxed/simple;
	bh=jluxAjnMBBxT+jQgOmGR1cISEr6+r0Kq9+uePRXDtFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsEpZBRb9sWJgJGVmSg33qXPlc9g0aQ8ABIyzt+Dg1scY/6tZuC5XHrOXU1TMWN4EYtJQtFFB8D80DCHIGuc0kWaiAUKWJsP05h1YcPvNzr8LNsc2FivGdh71Bbx+k+D8AMrtYhstamL5Nx0FjZF/Ccc+CfGlS4XGjdcchlqO9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDUPpN3j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D38C8B7AB;
	Mon, 26 Aug 2024 17:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724693234;
	bh=jluxAjnMBBxT+jQgOmGR1cISEr6+r0Kq9+uePRXDtFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kDUPpN3jbrXyowCZOOalinPlXVxqPjn8erHl96z9m/AtdMy0zk0CdwQ9zOr2VHyLV
	 CiGYJAHOUTSoaSnELXg2u9Aur53kpzjab2wkHbCRom4xNmlcX6S5Q3pNS4tA8Sd/ke
	 5QH+6KxT1l8y0lbT5D45PC1Y0c26eCSWD0zlt1lAba23MJ30bikwrMb5xMK2+9gHue
	 Te0/UytCXEEbpyqLfF51lNNs21wM+da+8NHUXxmYwi4tC7KL+JiO9TJAPQ6MzZm837
	 3PJULN79YXkBPOOCpwkJE/lsE2k4nzqT0TeArdq5/um04uCBercBoYuYJ4tsMvsWVH
	 yUe0SvyHYu+qQ==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-70949118d26so4561966a34.0;
        Mon, 26 Aug 2024 10:27:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUfQrysJ26iw6HkpGOYtMfY2UMZSAVnWQR937wMvWHJupcrzZdr9kBy0+EyBKXY0+XalBNl2n72zw64@vger.kernel.org, AJvYcCWTBY72DeKlG8bvEY+aSgeTPg+iLMzBI+jE0WZUFxhOth/fKKFNop/s0AA3yr9KXAma7FAf8gDmR6EffDOz@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZFwCpqRKYHJW/WM1htNcvsgz9YhFWftrF3+fv9fIEBEYGndg
	LM/5jCL94oYVYGLNwAyilyYUPS6XH2imphrgifnNFLrZ9ofCn67+cTX15xwJozGUO0eLpSYzeth
	U3T2An3fhewjufK7Lv+gwbXCVMWw=
X-Google-Smtp-Source: AGHT+IGabP5rUQeDMaKstGBTtOtjVR0sHISWc8glBPAEMT0KYqPbrLLqofcN1Sv1vQiJRcY5fD1HAp0JPlQiNF5N92o=
X-Received: by 2002:a05:6870:1592:b0:261:7af:719c with SMTP id
 586e51a60fabf-2775a03604bmr460351fac.35.1724693234145; Mon, 26 Aug 2024
 10:27:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop> <87mskzcnmf.ffs@tglx> <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop>
In-Reply-To: <Zsy3o_N8hvc6GfTp@sunil-laptop>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Aug 2024 19:27:03 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
Message-ID: <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
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

On Mon, Aug 26, 2024 at 7:22=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.com=
> wrote:
>
> On Mon, Aug 26, 2024 at 06:15:18PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 26, 2024 at 5:25=E2=80=AFPM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
> > >
> > > On Mon, Aug 12 2024 at 06:37, Sunil V. L. wrote:
> > > > On Mon, Aug 12, 2024 at 06:29:12AM +0530, Sunil V L wrote:
> > > >> This series adds support for the below ECR approved by ASWG.
> > > >> 1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-V=
KsIKia7zR/view?usp=3Dsharing
> > > >>
> > > >> The series primarily enables irqchip drivers for RISC-V ACPI based
> > > >> platforms.
> > > >
> > > > This series has spent quite a bit of time now on the list. As you a=
re
> > > > aware, few clarifications like _PIC codes are also done now. There =
is
> > > > no major change after you had agreed for the design. So, can this b=
e
> > > > considered for the next release please?
> > >
> > > Rafael, if you want to take it through the ACPI tree, then for the
> > > irqchip parts please add:
> > >
> > >   Acked-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > Yes, I'm going ro do this.
> >
> > Thank you!
> Thanks!
>
> There will be a conflict in PLIC irqchip driver due to a recent patch [1]=
.
> This patch is not in latest RC5 release but in linux-next. I usually base=
 the
> series on latest RC release. Should I rebase to linux-next in this case
> and send the next revision of the series resolving the conflict?

No, please don't.

That will be resolved at the merge time.

> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git=
/commit/?id=3D4d936f10ff80274841537a26d1fbfe9984de0ef9

Thanks!

