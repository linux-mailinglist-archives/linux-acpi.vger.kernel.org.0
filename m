Return-Path: <linux-acpi+bounces-5905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA838CA7AF
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30771F22478
	for <lists+linux-acpi@lfdr.de>; Tue, 21 May 2024 05:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90894500C;
	Tue, 21 May 2024 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBJogKyF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA30C433DF;
	Tue, 21 May 2024 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716269821; cv=none; b=A+Tkm6Ckf/ehKhuADia+0HD9hm6ysdCU33kECzGSgiPws2RcGL3lrvAkm0oBUjG0cB3xolpqFeZJksTeoRon6L7np/Y3NHvmoo0ZtudNIh7kTRsEtYYTXfH4TvH5RAkM3V85oL9shzMDcPq+HCRmQBEHPOLGeX/Is9auILIyh3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716269821; c=relaxed/simple;
	bh=2VN2vCstMEu8dehVEzX+E54KclIkWatdqyR0czDkOX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyEepvskZEJpwxwbKizXRxel+31K2ittMKnWnYGwBpNIrgrpVhOeLKE8CKcOCNJLE0xP2VLNUyCzlf54ZhYBt5botiel8CJlHuBofv/gCe5JQg+a+zQ9I8zCcTz4X/paI3LQGXJskmopsB6vBYNm1hoG3dYHNobI8ja7+b5w3DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBJogKyF; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e271acb015so64119081fa.1;
        Mon, 20 May 2024 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716269818; x=1716874618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8X0+eNlzU7aWSFgffzqQI3ZbOHv/ydP087P5MpUwWWY=;
        b=JBJogKyFJGNqz8obvT4svsNc8IryJ1ACOZUAgJiVeLbPwnF/mA6rQxSekesfChBZR2
         TaBH+kqhYcMa7rvvIg7SSNJw7Rfw0klMDUwepwgsjAH1q+UlFvWgxMd/W4dZXxuaUwYa
         2IcYVNtf4OkC/SWSZA05NFeR/hVOeLYEXE54djwy9JzKFuJWQaRR0WyP/sARuJeGU6Sf
         KTIf2gJbYTOJL8TUTeltvt9AI+bqt4KKlsjGc+TfFtwqVT61XZgsd+sUhd6hldKuveb9
         2AB/F2j0w5Ok8p9HqT0KElr2tuzTb48OesyTuaGX/au4/JLGAmhEJ1j6lA3hQPemWSyp
         Lhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716269818; x=1716874618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8X0+eNlzU7aWSFgffzqQI3ZbOHv/ydP087P5MpUwWWY=;
        b=fmdJuksy170XZOx45/LkPFG5mgxPYf+FmoqIW92m4UUtoVbrXhQHkYGTxmrzAhjSr5
         7EE5u85UyIErVZnUmUevmXA3iKCQ6nBC0ttB4iNefdR/kvOjs5wPPbvcnqQld+3+unJv
         ZQ++nU+H887zPAnUnPVUdA6bN6HXIYylntSPVzYfpyHLj4I7PazaVLuRS6E/butkxhsE
         qEKG9u9ta2D+flAnYbDE0FQxOGt8TdchW3g7J1xXUO1U41h2N9iyRQtwrJGKRqWMzrR7
         2bbLPzu4kLR9oqgvJ8D8VRrO1tpAajIg38Q30UXYZ8aNTE/a5CYDhamaTShlbHn0bpOS
         410Q==
X-Forwarded-Encrypted: i=1; AJvYcCVdmCHVlSrn7QmFxiNXP68GQKzu9C+ErzenM6w5kHeNRcwc9RuS/STPk7qI2kC6Ulk93rHefO1i5R5XEO2RYqGEyz03icp00mICAsXyaRsoC/WYY0ULzlIRZzQQXg54hIfPrLUhs+an+g==
X-Gm-Message-State: AOJu0YwtFve55QGEKXXegjPvVAJr8bSOjPfApVYdQJ68GAz+iy52VsYS
	T0sNSjAkli3DJusJgYuNN5KFIYH1Wo8voafEGtdM4HUG+jD8Lv+qVTv6Wes8HLSEpELARyL9NaP
	JJR6k+nwzoD45fODK1p0xBNNCzWaYsOeC
X-Google-Smtp-Source: AGHT+IEOuv6uBHGuy1kBgi3wLpvrtw9/MW5oRqRPcExCcQ7Flo7D93su7CrKiOr9ufpnZQ1Q1Cg69UJkVd4x5Efr5wk=
X-Received: by 2002:a2e:86cc:0:b0:2d8:67a0:61b2 with SMTP id
 38308e7fff4ca-2e51fe54024mr192133171fa.20.1716269817806; Mon, 20 May 2024
 22:36:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713778236.git.haibo1.xu@intel.com>
In-Reply-To: <cover.1713778236.git.haibo1.xu@intel.com>
From: Haibo Xu <xiaobo55x@gmail.com>
Date: Tue, 21 May 2024 13:36:46 +0800
Message-ID: <CAJve8o=bdE_g6ji78+ddjMp22_7iWtX54idmhr5OvtO8U8biHQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add ACPI NUMA support for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, arnd@arndb.de, ajones@ventanamicro.com, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Guo Ren <guoren@kernel.org>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Baoquan He <bhe@redhat.com>, 
	Greentime Hu <greentime.hu@sifive.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Zong Li <zong.li@sifive.com>, Sami Tolvanen <samitolvanen@google.com>, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Chen Jiahao <chenjiahao16@huawei.com>, 
	Jisheng Zhang <jszhang@kernel.org>, James Morse <james.morse@arm.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Evan Green <evan@rivosinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ard Biesheuvel <ardb@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	Yuntao Wang <ytcoode@gmail.com>, Alison Schofield <alison.schofield@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Sunil V L

Could you help have a review on this patch set?

Thanks,
Haibo

On Wed, Apr 24, 2024 at 1:29=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> This patch series enable RISC-V ACPI NUMA support which was based on
> the recently approved ACPI ECR[1].
>
> Patch 1/6 is generated from the acpica PR[2] and should be merged through
> the acpica project. Due to this dependency, other 5 patches can only be
> merged after the corresponding ACPICA patch was pulled into linux.
>
> Patch 2/6 add RISC-V specific acpi_numa.c file to parse NUMA information
> from SRAT and SLIT ACPI tables.
> Patch 3/6 add the common SRAT RINTC affinity structure handler.
> Patch 4/6 remove the '#if defined(CONFIG_ARCH)' condition to make some NU=
MA
> related parse functions common for all current architectures that support
> ACPI_NUMA.
> Patch 5/6 change the ACPI_NUMA to a hidden option since it would be selec=
ted
> by default on all supported platform.
> Patch 6/6 replace pr_info with pr_debug in arch_acpi_numa_init() to avoid
> potential boot noise on ACPI platforms that are not NUMA.
>
> Based-on: https://github.com/linux-riscv/linux-riscv/tree/for-next
>
> [1] https://drive.google.com/file/d/1YTdDx2IPm5IeZjAW932EYU-tUtgS08tX/vie=
w?usp=3Dsharing
> [2] https://github.com/acpica/acpica/pull/926
>
> Testing:
> Since the ACPI AIA/PLIC support patch set is still under upstream review,
> hence it is tested using the poll based HVC SBI console and RAM disk.
> 1) Build latest Qemu with the following patch backported
>    https://github.com/vlsunil/qemu/commit/42bd4eeefd5d4410a68f02d54fee406=
d8a1269b0
>
> 2) Build latest EDK-II
>    https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README=
.md
>
> 3) Build Linux with the following configs enabled
>    CONFIG_RISCV_SBI_V01=3Dy
>    CONFIG_SERIAL_EARLYCON_RISCV_SBI=3Dy
>    CONFIG_NONPORTABLE=3Dy
>    CONFIG_HVC_RISCV_SBI=3Dy
>    CONFIG_NUMA=3Dy
>    CONFIG_ACPI_NUMA=3Dy
>
> 4) Build buildroot rootfs.cpio
>
> 5) Launch the Qemu machine
>    qemu-system-riscv64 -nographic \
>    -machine virt,pflash0=3Dpflash0,pflash1=3Dpflash1 -smp 4 -m 8G \
>    -blockdev node-name=3Dpflash0,driver=3Dfile,read-only=3Don,filename=3D=
RISCV_VIRT_CODE.fd \
>    -blockdev node-name=3Dpflash1,driver=3Dfile,filename=3DRISCV_VIRT_VARS=
.fd \
>    -object memory-backend-ram,size=3D4G,id=3Dm0 \
>    -object memory-backend-ram,size=3D4G,id=3Dm1 \
>    -numa node,memdev=3Dm0,cpus=3D0-1,nodeid=3D0 \
>    -numa node,memdev=3Dm1,cpus=3D2-3,nodeid=3D1 \
>    -numa dist,src=3D0,dst=3D1,val=3D30 \
>    -kernel linux/arch/riscv/boot/Image \
>    -initrd buildroot/output/images/rootfs.cpio \
>    -append "root=3D/dev/ram ro console=3Dhvc0 earlycon=3Dsbi"
>
> [    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000-0x17fffffff]
> [    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x180000000-0x27fffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fe3bc40-0x17fe3cfff]
> [    0.000000] NUMA: NODE_DATA [mem 0x27fff4c40-0x27fff5fff]
> ...
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x0 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 0 -> HARTID 0x1 -> Node 0
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x2 -> Node 1
> [    0.000000] ACPI: NUMA: SRAT: PXM 1 -> HARTID 0x3 -> Node 1
>
> ---
> Changes since v2
>   - Rebase to Linux 6.9-rc1
>   - changed ACPI_NUMA to a hidden option in patch 5/6 per Arnd's suggesti=
on
>   - Removed original 6/6 which was not needed with changes in patch 5/6
>   - Added a new patch 6/6 to replace pr_info to pr_debug in arch_acpi_num=
a_init
>
> Haibo Xu (6):
>   ACPICA: SRAT: Add RISC-V RINTC affinity structure
>   ACPI: RISCV: Add NUMA support based on SRAT and SLIT
>   ACPI: NUMA: Add handler for SRAT RINTC affinity structure
>   ACPI: NUMA: Make some NUMA related parse functions common
>   ACPI: NUMA: change the ACPI_NUMA to a hidden option
>   ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
>
>  arch/arm64/Kconfig            |   1 -
>  arch/loongarch/Kconfig        |   1 -
>  arch/riscv/include/asm/acpi.h |  15 +++-
>  arch/riscv/kernel/Makefile    |   1 +
>  arch/riscv/kernel/acpi.c      |   5 --
>  arch/riscv/kernel/acpi_numa.c | 131 ++++++++++++++++++++++++++++++++++
>  arch/riscv/kernel/setup.c     |   4 +-
>  arch/riscv/kernel/smpboot.c   |   2 -
>  drivers/acpi/numa/Kconfig     |   5 +-
>  drivers/acpi/numa/srat.c      |  40 ++++++++---
>  drivers/base/arch_numa.c      |   2 +-
>  include/acpi/actbl3.h         |  18 ++++-
>  include/linux/acpi.h          |   6 ++
>  13 files changed, 204 insertions(+), 27 deletions(-)
>  create mode 100644 arch/riscv/kernel/acpi_numa.c
>
> --
> 2.34.1
>

