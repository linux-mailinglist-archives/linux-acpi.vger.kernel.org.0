Return-Path: <linux-acpi+bounces-7888-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5479A9613DC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B9828484E
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Aug 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC6B1C93B6;
	Tue, 27 Aug 2024 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMTKuI5r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79E2E62C;
	Tue, 27 Aug 2024 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724775637; cv=none; b=GZxhrO6O4B3HQc5neJXD3ZIhGFrAUpMUv7N7P2CyQRGszyYa0AldIjpWpaOSXd5/cpM1vPz5Ov9PHKSovF/0ozhfurTHVvXqmlduU9dzGqE2+t8kNKoTH4j5tPlCWAaZqCmOCpfeogLYNmNeoP1pkHxxaovyM11F+XOKkLJej1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724775637; c=relaxed/simple;
	bh=Nq+N2JRm3qs/YfyiIeI6nh9WFZTDcrLh7AvXtVujdoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REAu5QdJibJAnuWAPKUxz2xwVDl6BGXttgLQ+sybbqU1SlchzHMvkoPrqYKHJWsOefVth2U7RdfA8m8ef9qBJSwr2jF9155cqfby1y5Xb054o9OOCuJO0u28GghGfcQaLka3Kh2RvrhzZ/pO+L9np1TQgutKB3KZ//FJhJoAXBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMTKuI5r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAB4C5818E;
	Tue, 27 Aug 2024 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724775636;
	bh=Nq+N2JRm3qs/YfyiIeI6nh9WFZTDcrLh7AvXtVujdoc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kMTKuI5rfdZ7S/J978dFx/vEVmxDYHpINBaSPMCrIlVb15gdSLENBvbIDc1bqVGMv
	 uhev6qlAyNA+RqfXkZihFS4wf63LI0MZUMP8yRL0V+0Uyf108AmHRyh4PwP3GGT2lP
	 qGviXwLk9n1XV20/5uupk7bLBAkB+aW3maMGy7KDuu1dIxSfRQLVtu5XOXIMJc04Lg
	 yItklsEHDP+v6nftf63HtbRXg5qaQB1wXMTiGFwWEGoOMjni3xbOLgQCpx5mygys64
	 KyJDBEuKGeloEihQul1Db2k6hAG0kNAGzxEFhYqz4e6DnntH46T1yhq5l5aFAJKoQl
	 XR7hIjmWVQruw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-270263932d5so4031620fac.2;
        Tue, 27 Aug 2024 09:20:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbH8jf079KnUi5wrbLHsHERFOO7jd8mvOfOuzQfyHICoMQ5IgruaBgJehUMN7EYXOBtHwq92sn3aqrVY5Z@vger.kernel.org, AJvYcCWyT0sWSNzjwe0mxpyb1oTYBYmqiXIyE3rvxCoSdIziGBAXKgM6SKu7j6f7IkEFy6HjHJiGlD14Go4h@vger.kernel.org
X-Gm-Message-State: AOJu0YzN7U4lGHglrK2x5PrTiX5v8rxjSGfLnK+8nFTcZhsVdyiGCkwF
	UJJeSH1HOuqWkYl/n3BMT3KyR7qIhe5hzvzb/YKZ3bgvLN7npb/ecn9iUScWz+MdPXkblGXgCAv
	ToqJoiq4hmjVIiK4Z8gLuCxgzErs=
X-Google-Smtp-Source: AGHT+IEcevmf56HaHFi76opfMbCV8B1aBMG9slI81zTpqBsgMvZDsrfuxYvsyZ6B/GpsYTnUSrI2yl5r0i6NGyBQDqc=
X-Received: by 2002:a05:6870:82a1:b0:270:735:96e with SMTP id
 586e51a60fabf-273e6465ed4mr15637051fac.12.1724775635797; Tue, 27 Aug 2024
 09:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
 <ZrlgVUXC_dCW9ISM@sunil-laptop> <87mskzcnmf.ffs@tglx> <CAJZ5v0imJcU4cwDuZKEvGf93fZm4ea4s2Ocp3Cnfb3+nBQ0-Gg@mail.gmail.com>
 <Zsy3o_N8hvc6GfTp@sunil-laptop> <CAJZ5v0hxoT9tBjm3xRPU4fHx3MgHfYAx_Vyf4oe2toa3GWAN+Q@mail.gmail.com>
 <87jzg3c7bz.ffs@tglx>
In-Reply-To: <87jzg3c7bz.ffs@tglx>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Aug 2024 18:20:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
Message-ID: <CAJZ5v0iMpaxBevgPWmD2Ym_JG1ChkjzVFf22fV7Xw8-ssg9+Ag@mail.gmail.com>
Subject: Re: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller support
To: Thomas Gleixner <tglx@linutronix.de>, Sunil V L <sunilvl@ventanamicro.com>
Cc: Will Deacon <will@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
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

On Mon, Aug 26, 2024 at 11:22=E2=80=AFPM Thomas Gleixner <tglx@linutronix.d=
e> wrote:
>
> On Mon, Aug 26 2024 at 19:27, Rafael J. Wysocki wrote:
> > On Mon, Aug 26, 2024 at 7:22=E2=80=AFPM Sunil V L <sunilvl@ventanamicro=
.com> wrote:
> >> There will be a conflict in PLIC irqchip driver due to a recent patch =
[1].
> >> This patch is not in latest RC5 release but in linux-next. I usually b=
ase the
> >> series on latest RC release. Should I rebase to linux-next in this cas=
e
> >> and send the next revision of the series resolving the conflict?
> >
> > No, please don't.
> >
> > That will be resolved at the merge time.
>
> Alternatively you can pull
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-20=
24-08-25
>
> which I'm about to send to Linus latest tomorrow morning. That contains
> the conflicting change.

So I've applied the series on top of the above.

This included a full-swing rebase of the last patch, which I hope I've
done correctly, but Sunil please see

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?h=3Dbleeding-edge&id=3D5d1b549883c1bba331c419e491fda9bb934ea202

and let me know.

Thanks!

