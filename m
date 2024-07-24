Return-Path: <linux-acpi+bounces-7048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B697A93B33B
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 16:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1251C20C0B
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Jul 2024 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F8F159583;
	Wed, 24 Jul 2024 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCtTa+/u"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962E1158A19;
	Wed, 24 Jul 2024 14:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721832981; cv=none; b=dSUFMA2bPCZUcRwLy2f9ca+TfrFE3u7P1l4JmE1itmuw4WWJPZrGQqqfbvOaf7WKsZssyACS3ORtAjnsyTwn2Ld7oz223ZxIuY+wKcrfhAj4k5l0+6aqPQEMVqHQD7NYrl0/wkCQyuWe9ot5GZWOk50LyBdn296l4LBv/NFQHWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721832981; c=relaxed/simple;
	bh=wEc4sfYdM/LDlf6d8P9ptAilQ8A+tzuEnx1XZqff1v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7p7SDyafegHEYlyeJVC4TmKW1y98cBmcn6WxMKsGEMgTigeni2RYBRkyxI47MVC4b7Bpmb5cAYrhdIdpyfKcePGjkcwAB12/b7HyAA0XeDoNMegz76RkOm6aJ0cGwbXIb3FWrXoE6s5TeuOLx0kqlYEawrqS0uJNaoa6vAyRQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XCtTa+/u; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52efba36802so5697839e87.2;
        Wed, 24 Jul 2024 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721832978; x=1722437778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+VhvI5u25K1G3SguH2FXDNPUbfkufH9rbAjCZBWkOc=;
        b=XCtTa+/uszkt7drLOZXlgBky+MZ58MHNEcUd2UmISG53NXRr4C+EyOMdEy+v6FaD8m
         NwAMoW91Na3R+13h/f/lm54lriV3ilh1yhgY223ZrAYOlFPC05OaV/02RxZgjzcHhbVu
         nZ/Dn2j+9adOg5TzeW9lTjpExqqpxNFuulzyxCcT6naFBvIrUsc4SnBifQy725ojP04/
         Qe8R9+/eP2gO/K6WF/GQVkUXJqpdluOQNhU9axqoAJZoVaCLmE8cqKVMb0If1biy/nTt
         jXKF7T2AKoUDIw772FuY98mV2+wbd5J6BPJqTbsRvvaBBBzHaesubmnfDjZGsMah0Kl7
         tUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721832978; x=1722437778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+VhvI5u25K1G3SguH2FXDNPUbfkufH9rbAjCZBWkOc=;
        b=ocEJXpWBoM2ciL5H6erRYIp1yBqWy8H0kzM2L8tfhrtYAyuP4Y0eWQWBs/xTFjQnSA
         Jr4u7ZCV24EgSqYF8BOhm1Omg5OFF5NEhvMs3V7N+lraWirKXttOndNci3NWDLB4jOmU
         +X9TO/9ixtkGg3DUx0gWIEN4z4CMKHnamameb4ROsmvrW5Q3gXeRksUHgLijHTrembpx
         uhafjiHVY4g68HmI1rRyH4KP1P0zNe3wVPFd4uHZiThghm6lEbJSH8WIHDmN6JSV8ZLv
         uRpBOfGBrRdxManNJFyRUS5onwaXPZ8wGVHJag3BwsTSCxPeltfeZUGWTVZH5rDe+Osi
         CPNA==
X-Forwarded-Encrypted: i=1; AJvYcCXXBczSc+ORi2CFvsfsRljg1ioygeI0nAH/De7mFThtHg11Do7PHn0QkmpqQDdVGW+5cBJzHeE6pMST6lfFbx+q4pW9FIXsineNnzloKkwcm4zQyA4c6HUcntVsybnXTKf4XFrRI8oNSg==
X-Gm-Message-State: AOJu0YxVxWKgUp7qNEjYgfylgEANiX+F4jB7uOMBboAljQGNv5AYrr4w
	dk/OnEQx2MSk2xoF0H6is0NZq11TDYr9GDz1vjnnyrPmM3ZNhxCXbMh2QOjMjZRYHhNMPWw6JIP
	sk63wIzCz86AoWE/wIacj8nqBoe8=
X-Google-Smtp-Source: AGHT+IEyt9/jKgY9GG2CTk2DQKwL+zQsHX8gmCjTh3r6yrd9E+GdYPop3MLBHAvwRY0udPYlhm2AykNPFdpZ5YxlgWA=
X-Received: by 2002:a05:6512:1114:b0:52e:91ff:4709 with SMTP id
 2adb3069b0e04-52efb63f078mr9627053e87.21.1721832976976; Wed, 24 Jul 2024
 07:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718268003.git.haibo1.xu@intel.com> <mhng-e0773c11-559a-4f64-a1ad-4a234993ccfc@palmer-ri-x1c9>
In-Reply-To: <mhng-e0773c11-559a-4f64-a1ad-4a234993ccfc@palmer-ri-x1c9>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Wed, 24 Jul 2024 22:56:05 +0800
Message-ID: <CAJve8omqqpLLPz7QEuC1s+jai9YeisTKgeTMZfRnAN+=WdhhbA@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add ACPI NUMA support for RISC-V
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: haibo1.xu@intel.com, Sunil V L <sunilvl@ventanamicro.com>, 
	Arnd Bergmann <arnd@arndb.de>, ajones@ventanamicro.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, chenhuacai@kernel.org, 
	kernel@xen0n.name, Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, 
	rafael@kernel.org, lenb@kernel.org, Greg KH <gregkh@linuxfoundation.org>, 
	Conor Dooley <conor.dooley@microchip.com>, akpm@linux-foundation.org, 
	Charlie Jenkins <charlie@rivosinc.com>, bhe@redhat.com, Evan Green <evan@rivosinc.com>, 
	cleger@rivosinc.com, zong.li@sifive.com, samitolvanen@google.com, 
	alexghiti@rivosinc.com, samuel.holland@sifive.com, chenjiahao16@huawei.com, 
	rmk+kernel@armlinux.org.uk, jszhang@kernel.org, james.morse@arm.com, 
	andy.chiu@sifive.com, Marc Zyngier <maz@kernel.org>, tglx@linutronix.de, 
	tony.luck@intel.com, Ard Biesheuvel <ardb@kernel.org>, dan.j.williams@intel.com, 
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com, rrichter@amd.com, 
	ytcoode@gmail.com, dave.jiang@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 10:50=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com=
> wrote:
>
> On Thu, 13 Jun 2024 01:54:32 PDT (-0700), haibo1.xu@intel.com wrote:
> > This patch series enable RISC-V ACPI NUMA support which was based on
> > the recently approved ACPI ECR[1].
> >
> > Patch 1/4 add RISC-V specific acpi_numa.c file to parse NUMA informatio=
n
> > from SRAT and SLIT ACPI tables.
> > Patch 2/4 add the common SRAT RINTC affinity structure handler.
> > Patch 3/4 change the ACPI_NUMA to a hidden option since it would be sel=
ected
> > by default on all supported platform.
> > Patch 4/4 replace pr_info with pr_debug in arch_acpi_numa_init() to avo=
id
> > potential boot noise on ACPI platforms that are not NUMA.
> >
> > Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
>
> No big deal, but that's not actually my repo.  Looks like it's just
> mirroring something, I use the kernel.org git stuff these days.  I
> dropped it from the cover letter for the merge, it's not super useful
> anyway because it's a branch so nobody will know what it means later.
>
> Aside from that things look good, I've got this queued up for the
> tester.
>

Thanks!

> >
> > [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/v=
iew?usp=3Dsharing
> >
> > Testing:
> > Since the ACPI AIA/PLIC support patch set is still under upstream revie=
w,
> > hence it is tested using the poll based HVC SBI console and RAM disk.
> > 1) Build latest Qemu with the following patch backported
> >    https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee4=
06d8a1269b0
> >
> > 2) Build latest EDK-II
> >    https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/READ=
ME.md
> >
> > 3) Build Linux with the following configs enabled
> >    CONFIG_RISCV_SBI_V01=3Dy
> >    CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
> >    CONFIG_NONPORTABLE=3Dy
> >    CONFIG_HVC_RISCV_SBI=3Dy
> >    CONFIG_NUMA=3Dy
> >    CONFIG_ACPI_NUMA=3Dy
> >
> > 4) Build buildroot rootfs.cpio
> >
> > 5) Launch the Qemu machine
> >    qemu-system-riscv64 -nographic \
> >    -machine virt,pflash0=3Dpflash0,pflash1=3Dpflash1 -smp 4 -m 8G \
> >    -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=
=3DRISCV_VIRT_CODE.fd \
> >    -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VA=
RS.fd \
> >    -object memory-backend-ram,size=3D4G,id=3Dm0 \
> >    -object memory-backend-ram,size=3D4G,id=3Dm1 \
> >    -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
> >    -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
> >    -numa dist,src=3D0,dst=3D1,val=3D30 \
> >    -kernel linux/arch/riscv/boot/Image \
> >    -initrd buildroot/output/images/rootfs.cpio \
> >    -append "root=3D/dev/ram ro console=3Dhvc0 earlycon=3Dsbi"
> >
> > [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
> > [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
> > [    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
> > ...
> > [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
> > [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
> > [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
> > [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1
> >
> > ---
> > Changes since v3
> >   - Rebase to linux-riscv/for-next(Linux 6.10-rc1)
> >   - Remove original patch 1/6 since it had been merged through
> >     ACPICA pull(commit fe1c408d50604f)
> >   - Remove original patch 4/6 since the related changes was
> >     introduced in commit 3a785e19f43267
> >
> > Haibo Xu (4):
> >   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
> >   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
> >   ACPI: NUMA: change the ACPI_NUMA to a hidden option
> >   ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
> >
> >  arch/arm64/Kconfig            |   1 -
> >  arch/loongarch/Kconfig        |   1 -
> >  arch/riscv/include/asm/acpi.h |  15 +++-
> >  arch/riscv/kernel/Makefile    |   1 +
> >  arch/riscv/kernel/acpi.c      |   5 --
> >  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/setup.c     |   4 +-
> >  arch/riscv/kernel/smpboot.c   |   2 -
> >  drivers/acpi/numa/Kconfig     |   5 +-
> >  drivers/acpi/numa/srat.c      |  32 ++++++++-
> >  drivers/base/arch_numa.c      |   2 +-
> >  include/linux/acpi.h          |   6 ++
> >  12 files changed, 187 insertions(+), 18 deletions(-)
> >  create mode 100644 arch/riscv/kernel/acpi_numa.c

