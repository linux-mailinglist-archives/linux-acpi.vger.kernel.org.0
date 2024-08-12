Return-Path: <linux-acpi+bounces-7505-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D14094E441
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 02:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6731F21BC5
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 00:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889546B8;
	Mon, 12 Aug 2024 00:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="dNeTuGyK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com [209.85.210.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0904A1D
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424384; cv=none; b=koZ1PD8g+f1ZkbiEe/wCtpH4sRL4TOcUxLxGzBeIRnj6pRocjUpdsxnaCelJwCc8UEG7x46UP40W8iixmUvDcZFchZ2SGV24lBlL31mQt+UGzX1dECD1HyLEDtPFC2X9kp5ZVI4wZOFDQSdtGPB0A0R9oIMoKi7Yr+eIYNOl9WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424384; c=relaxed/simple;
	bh=JGKUKC6ddll/HQbcX29Sm7QYBwZDAAanOpcgaEl4Qts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fhJloONCCtt0kWaPDANCwymcmgV9Gqj4DRt022+hQxXEn1Ean8J0Oe5gIbVUMl6jbjXBrcmXju2Oim88O3ZlfQtYSHUTmtxm7ocRNaYO8QT4/T2xWf9FOsIdXtPswBmEwknyor9L0a1ZHqdgNVKJX2NdHSbXevzNkeuGYgWHcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=dNeTuGyK; arc=none smtp.client-ip=209.85.210.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ot1-f65.google.com with SMTP id 46e09a7af769-709428a9469so2520369a34.3
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 17:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424382; x=1724029182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1t+DOBtWVw6p1QzV6tpA79/Z/soEYYlKfO1cj75JM4=;
        b=dNeTuGyK5kX14qG9KNXzzrtPy7+fevMHTlV487CwixLUx/6B+DWOBCyn9qQc8YnVRp
         BaKUZvcRQmIvwxGDGNPJhzgchnVhufKIKSzgs6ft5FmHJfPhcQ+FA83snh53ZTZawyFN
         uIwyrws8GfhcEvfM0/rRQA8VwVrak/E4C2uWTnPlgZ3jBAEV6XRf035t5NslY56w6lTC
         kiLrrA38K4UIBjmqdeB3QLLOApZKnDzqqJyPzfzh+VPoVYKgThcGx/FoPOkq0bqxeKPH
         xtixTKR1iR5zx4EMA7kTZDFavA2fmY4YJzyV1me26ikoypIp5yD6MBbAUqgAmeCYDt4s
         msKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424382; x=1724029182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u1t+DOBtWVw6p1QzV6tpA79/Z/soEYYlKfO1cj75JM4=;
        b=WW+gDvgWxVjkjOvzDKqIdBZ9Uvgd0c9CdS2s1MLcJa00ShpK8u0YU1F0l01Q/mwS3f
         3JQDw1A0isx83CD7PlVtwKTIZiDVp5quoPgSUDfrFgyTc7fXBP/uNlqdzzHcz/OBt/Hy
         +/MJ0s02xlqmHwUHAB8OmloX+6yOajaK2C324+alcv2MjiQwKHacC/jW+8HENgXUe3Za
         dpWX/GlenNRE6hWD0sXDwkzHR9/IOf1Cn03P8pcHdmwJM6a0dkdOlD6O2TP39JQlJyNF
         lfJDQgLFqwElQUc/ol6vpSJyIYyZx3Gy4VFbTUVnvnh/KDEK8oSZMkSlhwqwnog6w677
         L3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyz+fqjENwajPxvaikGZGazUYfKJTc/+U/ETqWvMvgcKzPLZCUDFHqoNGdV24QaioiBfaioLybWAXE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZyKc/mLs4hctMfUkH/BGRhrNOQzp/0jdPNh1y8OKYigUZpTrd
	PdgpNN8PjhPg2SlGL0sPfeePU9L4999omrMkqdavsJq11QZUjeAE3wqGqGNzRB8=
X-Google-Smtp-Source: AGHT+IFvFD40j/75g0OMKTR99Jntdlb7KnjOCvOc/WzAwYbyCYwYB5yIZakN6YXoCdPddNyZ+Lnt1Q==
X-Received: by 2002:a05:6830:6f04:b0:709:488f:b632 with SMTP id 46e09a7af769-70b74862b47mr12731861a34.25.1723424381262;
        Sun, 11 Aug 2024 17:59:41 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.17.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 17:59:40 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
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
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v8 00/17] RISC-V: ACPI: Add external interrupt controller support
Date: Mon, 12 Aug 2024 06:29:12 +0530
Message-ID: <20240812005929.113499-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

4) ACPI support added in RISC-V interrupt controller drivers.

Changes since v7:
	1) Updated commit messages as per feedback from Bjorn on patches 2, 3 and 8.
	2) Addressed Anup Patel's comments.
	3) Added Tested-by tag from Björn Töpe which I missed to add in previous version.
	4) Rebased to 6.11-rc3 and updated the RB tags from Anup.

Changes since v6:
	1) Update to commit message/code comments as per feedback from Bjorn.
	2) Rebased to 6.11-rc1.

Changes since v5:
	1) Addressed feedback from Thomas.
	2) Created separate patch for refactoring DT code in IMSIC
	3) Separated a fix in riscv-intc irqchip driver and sent
	   separately. This series depends on that patch [1].
	4) Dropped serial driver patch since it depends on Andy's
	   refactoring series [2]. RISC-V patches will be sent
	   separately later once Andy series get accepted.
	5) Rebased to v6.10-rc1 which has AIA DT patches.
	6) Updated tags.

Changes since RFC v4:
	1) Removed RFC tag as the RFCv4 design looked reasonable.
	2) Dropped PCI patch needed to avoid warning when there is no MSI
	   controller. This will be sent later separately after the
	   current series.
	3) Dropped PNP handling of _DEP since there is new ACPI ID for
	   generic 16550 UART. Added the serial driver patch instead.
	4) Rebased to latest linux-next.
	5) Reordered/squashed patches in the series

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

1) qemu should be built using the latest master branch.

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

NOTE: One should be able to use u-boot as well as per instructions from Björn.
https://lore.kernel.org/lkml/87a5lqsrvh.fsf@all.your.base.are.belong.to.us/

3) Build Linux using this series (+ serial driver patches which are already in linux-next).
aia_b2_v8 branch in https://github.com/vlsunil/linux.git all these patches.

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
 -append "root=/dev/ram ro console=ttyS0 rootwait earlycon=sbi"

To boot with APLIC only, use aia=aplic.
To boot with PLIC, remove aia= option.

Sunil V L (17):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  ACPI: scan: Add a weak arch_sort_irqchip_probe() to order the IRQCHIP
    probe
  ACPI: bus: Add acpi_riscv_init() function
  ACPI: scan: Refactor dependency creation
  ACPI: scan: Add RISC-V interrupt controllers to honor list
  ACPI: scan: Define weak function to populate dependencies
  ACPI: bus: Add RINTC IRQ model for RISC-V
  ACPI: pci_link: Clear the dependencies after probe
  ACPI: RISC-V: Implement PCI related functionality
  ACPI: RISC-V: Implement function to reorder irqchip probe entries
  ACPI: RISC-V: Initialize GSI mapping structures
  ACPI: RISC-V: Implement function to add implicit dependencies
  irqchip/riscv-intc: Add ACPI support for AIA
  irqchip/riscv-imsic-state: Create separate function for DT
  irqchip/riscv-imsic: Add ACPI support
  irqchip/riscv-aplic: Add ACPI support
  irqchip/sifive-plic: Add ACPI support

 arch/arm64/kernel/pci.c                    | 191 ------------
 arch/riscv/Kconfig                         |   2 +
 arch/riscv/include/asm/irq.h               |  55 ++++
 arch/riscv/kernel/acpi.c                   |  33 +-
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/pci_link.c                    |   2 +
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  13 +
 drivers/acpi/riscv/init.h                  |   4 +
 drivers/acpi/riscv/irq.c                   | 335 +++++++++++++++++++++
 drivers/acpi/scan.c                        | 103 ++++---
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 +-
 drivers/irqchip/irq-riscv-aplic-main.c     |  69 +++--
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |   9 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  64 +++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  32 +-
 drivers/irqchip/irq-riscv-imsic-state.c    | 160 +++++-----
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           |  90 ++++++
 drivers/irqchip/irq-sifive-plic.c          |  95 ++++--
 drivers/pci/pci-acpi.c                     | 182 +++++++++++
 include/acpi/acpi_bus.h                    |   2 +
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |   9 +
 25 files changed, 1113 insertions(+), 377 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.43.0


