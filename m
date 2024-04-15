Return-Path: <linux-acpi+bounces-5027-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028028A5859
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79465B20D85
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711788289B;
	Mon, 15 Apr 2024 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="b22mihX2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86582862
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200486; cv=none; b=sSi+nq9NL6CQIIoNycnnrWDQ//AEA5t3YnXyhFnt4+FewijqXvxDCZEm3+HWRtJY1VPrCybn6op+T0QAnzi8eduiXRNrXaK4pcxNpe5jNF7UWYif5+aYU62wwUwQjruTShN5c+OCbpLBNEDa1PK743/PYHV6j5AuRMCQ6xELHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200486; c=relaxed/simple;
	bh=7lHC5xJ2vTJLbnQv7GLzUK6SG2A6vOhK+oNuADq/XBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OPwc5AoSS0CtFhQ0hYey5M64Byx7b8B3MaN7sP5ZCzCh04gt2xGXr02T50RDIORBm+ozPkMYj9+75IQ90So459uiesVw0uZjJysarCket4gU3W22T508WA2XM/1ySV+Exlvh49hmBf1WGcXPBgKMEXlUhAtcCpuyGild3etBOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=b22mihX2; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso2822449b3a.1
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200483; x=1713805283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=afQUKb3+bReZJJVzkqw/D/pAyQK9zbCbxN1Z3zQxUCM=;
        b=b22mihX2WScfzVsCGOHVG3gU289tgmXuabT2gtqWlRpgnM+FvKOrTFYXU6XtKIIv4y
         m820HHbUcgiJ2+/FkbBwXVIHoyhbcJ1zPKfzRDu0PunZMuYROsUJv8adwCEsJX4v6oMo
         xQm5fdld3Cm/VVHHEaCrzcUUsw3+Z79g8N/H88w77NgmWgsTfibOsQ2/IvN5I+QWfASh
         5F2M7tNAb0El1BmPBfCp/80PlC5kIfmoDHBkdahK+fZdZ5LVeWcqDGCiPif80bj8upxw
         GKKLyeI5ph1kvIyYxa7YWALX+M39HUypt313yVEYcfguij8zoomcUq8nXg9AQGqjoWwQ
         MmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200483; x=1713805283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afQUKb3+bReZJJVzkqw/D/pAyQK9zbCbxN1Z3zQxUCM=;
        b=ajGUiYsyPek01c+GtvAytqRmkNpzF+ik+pJfY4kOmTAfR2g8J0wY0Tpzte0yIUZOih
         R/jRSO1VmKoSnHS+A4Yg61srruTeSnxB1czpipo4pC5E9FSrwYoiVuDAYDLTHJSRFYpV
         NvLJyz7H/Grudxw4YGA9Foxqb/A13uzukR0NHCyogDQ/fwcK9TKtSslkAaDlZBvq0N9w
         XAMlnS78jJYDegSG7iQeFjU7BUcDs7WrK2lTcLTaz3J1za+e5svxjD9oCQ9739fLRGLE
         vZTdLBFST72IHJrKuyW9k4qTLIkwYLAhOpGWcucALYthq2JsKLd9EYOM0oz0UgdLRx2j
         4EJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJppuUfGahYg6uX3WDhHcaWf75N9EXpxLiAkmtf1XBUlhqpnX9QQd4dBK9YkRspsNZcauPxPTGjIb+hiNuNgJWDgsHqlSB7IxNzQ==
X-Gm-Message-State: AOJu0YwNaddfRZU2Mxr7ouzvmYB8VFa6MDQcwXrYV8u1GuVOR97x/5Dk
	xTjyqqcfwaJeABey0u4t/xmAVK1KJ9W+SGrEKran1nlZJgMWtMd3HMi/NU0LtSU=
X-Google-Smtp-Source: AGHT+IGvUtNPBJtUrZHBRqgCeSvMfTaswoxNkmXpQMc4XGFfcLCC2fGcj6PbI0z7193t2XQ0TXdwYw==
X-Received: by 2002:a05:6a20:4e29:b0:1a3:a8da:918b with SMTP id gk41-20020a056a204e2900b001a3a8da918bmr7760997pzb.47.1713200483351;
        Mon, 15 Apr 2024 10:01:23 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:22 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 00/20] RISC-V: ACPI: Add external interrupt controller support
Date: Mon, 15 Apr 2024 22:30:53 +0530
Message-Id: <20240415170113.662318-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

The series can be broadly categorized like below. 

1) PCI ACPI related functions are migrated from arm64 to common file so
that we don't need to duplicate them for RISC-V.

2) Added support for re-ordering the probe of interrupt controllers when
IRQCHIP_ACPI_DECLARE is used.

3) To ensure probe order between interrupt controllers and devices,
implicit dependency is created similar to when _DEP is present.

4) When PNP devices like Generic 16550A UART, have the dependency on the
interrupt controller, they will not be added to PNP data structures. So,
added second phase of pnpacpi_init to handle this.

5) ACPI support added in RISC-V interrupt controller drivers.

This series is still kept as RFC to seek feedback on above design
changes. Looking forward for the feedback!

Changes since RFC v3:
	1) Moved to _DEP method instead of fw_devlink.
	2) PLIC/APLIC driver probe using namespace devices.
	3) Handling PNP devices as part of clearing dependency.
	4) Rebased to latest linux-next to get AIA DT drivers.

Changes since RFC v2:
	1) Introduced fw_devlink for ACPI nodes for IRQ dependency.
	2) Dropped patches in drivers which are not required due to
	   fw_devlink support.
	3) Dropped pci_set_msi() patch and added a patch in
	   pci_create_root_bus().
	4) Updated pnp_irq() patch so that none of the actual PNP
	   drivers need to change.

Changes since RFC v1:
	1) Abandoned swnode approach as per Marc's feedback.
	2) To cope up with AIA series changes which changed irqchip driver
	   probe from core_initcall() to platform_driver, added patches
	   to support deferred probing.
	3) Rebased on top of Anup's AIA v11 and added tags.

To test the series,

1) Qemu should be built using the riscv_acpi_namespace_v1 branch at
https://github.com/vlsunil/qemu.git

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux using this series.

Run Qemu:
qemu-system-riscv64 \
 -M virt,pflash0=pflash0,pflash1=pflash1,aia=aplic-imsic \
 -m 2G -smp 8 \
 -serial mon:stdio \
 -device virtio-gpu-pci -full-screen \
 -device qemu-xhci \
 -device usb-kbd \
 -blockdev node-name=pflash0,driver=file,read-only=on,filename=RISCV_VIRT_CODE.fd \
 -blockdev node-name=pflash1,driver=file,filename=RISCV_VIRT_VARS.fd \
 -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
 -kernel arch/riscv/boot/Image \
 -initrd rootfs.cpio \
 -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=uart8250,mmio,0x10000000"

To boot with APLIC only, use aia=aplic.
To boot with PLIC, remove aia= option.

This series is also available in acpi_b2_v4_autodep_v1 branch at
https://github.com/vlsunil/linux.git

Based-on: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tag/?h=next-20240415

Sunil V L (20):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  RISC-V: ACPI: Implement PCI related functionality
  PCI: Make pci_create_root_bus() declare its reliance on MSI domains
  ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
    probe
  ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
  ACPI: bus: Add acpi_riscv_init function
  RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
  ACPI: scan: Refactor dependency creation
  drivers/acpi/scan.c: Update _DEP honor list
  RISC-V: ACPI: Initialize GSI mapping structures
  ACPI: scan.c: Define weak function to populate dependencies
  RISC-V: ACPI: Implement function to add implicit dependencies
  ACPI/PNP: Initialize PNP devices skipped due to _DEP
  irqchip: riscv-intc: Add ACPI support for AIA
  irqchip: riscv-imsic: Add ACPI support
  irqchip: riscv-aplic: Add ACPI support
  irqchip: irq-sifive-plic: Add ACPI support
  ACPI: bus: Add RINTC IRQ model for RISC-V
  irqchip: riscv-intc: Set ACPI irqmodel
  ACPI: pci_link: Clear the dependencies after probe

 arch/arm64/kernel/pci.c                    | 191 ------------
 arch/riscv/Kconfig                         |   3 +
 arch/riscv/include/asm/irq.h               |  57 ++++
 arch/riscv/kernel/acpi.c                   |  31 +-
 drivers/acpi/Kconfig                       |   3 +
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/pci_link.c                    |   3 +
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  14 +
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 323 +++++++++++++++++++++
 drivers/acpi/scan.c                        |  69 +++--
 drivers/irqchip/irq-riscv-aplic-direct.c   |  20 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  70 +++--
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 115 ++++----
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           | 102 ++++++-
 drivers/irqchip/irq-sifive-plic.c          |  89 ++++--
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++
 drivers/pci/probe.c                        |   3 +
 drivers/pnp/pnpacpi/core.c                 |  24 +-
 drivers/pnp/pnpacpi/rsparser.c             |  63 ++--
 include/acpi/acpi_bus.h                    |   2 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |  10 +
 include/linux/pnp.h                        |   7 +
 30 files changed, 1108 insertions(+), 388 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.40.1


