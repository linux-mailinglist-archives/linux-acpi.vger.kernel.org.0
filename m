Return-Path: <linux-acpi+bounces-985-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA977D75C0
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 22:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191A41C20B2B
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01234188
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Oct 2023 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="KDBnVad/"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903841DA5B
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 20:24:12 +0000 (UTC)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F088123
	for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:09 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5b837dc2855so109336a12.0
        for <linux-acpi@vger.kernel.org>; Wed, 25 Oct 2023 13:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698265449; x=1698870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9/pedB262IMNHEh1PUtoWlFeNdn65+nq0ZZR6F2re8=;
        b=KDBnVad/L98ks9dD6PFiobWlP+Y3q+9Zm0vjzN3/+4omI65ozoSxrD30/6HzY+mbQM
         H6IwEnthNvfRwxUvup1anEfy2bOrqPYRKxmyXL8n7RErVvzVMLkMSVCO7hpfrjYtH967
         DjN2SsObKv5oVudbtz50lcuB4ySHSDcD6Wh6SOMfo2yD3D+YqW0nTUr0e5GspcQSN1RR
         0SQngTgKrPvDXXIV4axCjPlx5lK03PX8xn98jaouG9PAq2gCBMUUmhBYWJdAC6qDUJ0p
         LWmZI7tMzbAE30w6Pfmzr9D5j2bPqBiUqkDxoC4PhCl3ovTi17+Z+lXxmFwU3u+0FhpL
         rZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698265449; x=1698870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9/pedB262IMNHEh1PUtoWlFeNdn65+nq0ZZR6F2re8=;
        b=luHMw4ri1y7wlCORrYJov/ZtkYu7isE8Dj+oTAhRfOJ5A4fyRDr8PGH9rfbNs11E2M
         BPfsBo14Mqr4P5b/OwKZ0P/BpVuLN/4hTzEOQRs1wmsiMhwS42ry1SiY6nUxWe1dx4+O
         +0YBJY2DKjOuUILxOfK309F0FOwmNNHxSi5uHFRSRVYf7fX55z8zJiYNoQa8XbOWCS9E
         7KOABSTF1oXk9wlwmUPD4AfEmngSAevV/38UHftDwTdV6TiAziKbJnI5GIln5+DBNAdk
         ENR0RFdF2OQcwh3Krv+8DMM9pLCjDTJAxZj1v8Ydz37eBSSlRoQQ/3Olpc4JYC4GhhV4
         MdJw==
X-Gm-Message-State: AOJu0YxAnWDlBS0m89O9Sr93C51MEu4CJzf9v/K9vS5ljHm1m6S4a4vI
	Cltx4071eL1sNydMlNSFXdpVbNv9Y6NwOeWI4581vw==
X-Google-Smtp-Source: AGHT+IEV4o/13i3hZesUJvr2asiwuxud0jha6gl4OJB79xQ7DR2BCPeSNSC6qZTwPjauiylzsIcCjw==
X-Received: by 2002:a05:6a20:8e12:b0:14e:2208:d62f with SMTP id y18-20020a056a208e1200b0014e2208d62fmr801359pzj.22.1698265448502;
        Wed, 25 Oct 2023 13:24:08 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b006b84ed9371esm10079590pfo.177.2023.10.25.13.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 13:24:08 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v2 00/21] RISC-V: ACPI: Add external interrupt controller support 
Date: Thu, 26 Oct 2023 01:53:23 +0530
Message-Id: <20231025202344.581132-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: *

This series adds support for the below ECR approved by ASWG.
1) MADT - https://drive.google.com/file/d/1oMGPyOD58JaPgMl1pKasT-VKsIKia7zR/view?usp=sharing

The series primarily enables irqchip drivers for RISC-V ACPI based
platforms.

In addition, PCI ACPI related functions are migrated from arm64 to
common file so that we don't need to duplicate them for RISC-V.

On RISC-V platforms, apart from root irqchips which provide local
interrupts and IPI, all other interrupt controllers are probed late
during boot. Hence, the drivers for the devices connected to these
interrupt controllers which are probed late, should also support
deferred probe. While ACPI platform devices/drivers seem to support
deferred probe since they use acpi_irq_get(), the PNP devices and the
PCI INTx expect GSIs are registered early. So, patches are required
to enable few essential drivers to support deferred probe. To minimize
the impact, a new CONFIG option is introduced which can be enabled only
by the architecture like RISC-V which supports deferred irqchip probe.

This series is based on Anup's AIA v11 series. Since Anup's AIA v11 is
not merged yet and first time introducing deferred probe, this series is
still kept as RFC. Looking forward for the feedback!

Changes since RFC v1:
	1) Abandoned swnode approach as per Marc's feedback.
	2) To cope up with AIA series changes which changed irqchip driver
	   probe from core_initcall() to platform_driver, added patches
	   to support deferred probing.
	3) Rebased on top of Anup's AIA v11 and added tags.

To test the series,

1) Qemu should be built using the riscv_acpi_b2_v4 branch at
https://github.com/vlsunil/qemu.git

2) EDK2 should be built using the instructions at:
https://github.com/tianocore/edk2/blob/master/OvmfPkg/RiscVVirt/README.md

3) Build Linux using this series on top of Anup's AIA v11 series.

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

This series is also available in acpi_b2_v2_riscv_aia_v11 branch at
https://github.com/vlsunil/linux.git

Based-on: 20231023172800.315343-1-apatel@ventanamicro.com
(https://lore.kernel.org/lkml/20231023172800.315343-1-apatel@ventanamicro.com/)

Sunil V L (21):
  arm64: PCI: Migrate ACPI related functions to pci-acpi.c
  RISC-V: ACPI: Implement PCI related functionality
  ACPI: Kconfig: Introduce new option to support deferred GSI probe
  ACPI: irq: Add support for deferred probe in acpi_register_gsi()
  pnp.h: Return -EPROBE_DEFER for disabled IRQ resource in pnp_irq()
  RISC-V: Kconfig: Select deferred GSI probe for ACPI systems
  serial: 8250_pnp: Add support for deferred probe
  ACPI: pci_irq: Avoid warning for deferred probe in
    acpi_pci_irq_enable()
  ACPI: scan.c: Add weak arch specific function to reorder the IRQCHIP
    probe
  ACPI: RISC-V: Implement arch function to reorder irqchip probe entries
  PCI: MSI: Add helper function to set system wide MSI support
  PCI: pci-acpi.c: Return correct value from pcibios_alloc_irq()
  irqchip: riscv-intc: Add ACPI support for AIA
  irqchip: riscv-imsic: Add ACPI support
  irqchip: riscv-aplic: Add ACPI support
  irqchip: irq-sifive-plic: Add ACPI support
  ACPI: bus: Add RINTC IRQ model for RISC-V
  irqchip: riscv-intc: Set ACPI irqmodel
  ACPI: bus: Add acpi_riscv_init function
  ACPI: RISC-V: Create APLIC platform device
  ACPI: RISC-V: Create PLIC platform device

 arch/arm64/kernel/pci.c                    | 191 ---------------------
 arch/riscv/Kconfig                         |   3 +
 arch/riscv/include/asm/irq.h               |  31 ++++
 arch/riscv/kernel/acpi.c                   |  31 ++--
 drivers/acpi/Kconfig                       |   3 +
 drivers/acpi/bus.c                         |   4 +
 drivers/acpi/irq.c                         |  12 +-
 drivers/acpi/pci_irq.c                     |   7 +-
 drivers/acpi/riscv/Makefile                |   2 +-
 drivers/acpi/riscv/init.c                  |  15 ++
 drivers/acpi/riscv/init.h                  |   6 +
 drivers/acpi/riscv/irq.c                   | 120 +++++++++++++
 drivers/acpi/scan.c                        |   3 +
 drivers/irqchip/irq-riscv-aplic-direct.c   |  22 ++-
 drivers/irqchip/irq-riscv-aplic-main.c     | 105 ++++++++---
 drivers/irqchip/irq-riscv-aplic-main.h     |   1 +
 drivers/irqchip/irq-riscv-aplic-msi.c      |  10 +-
 drivers/irqchip/irq-riscv-imsic-early.c    |  52 +++++-
 drivers/irqchip/irq-riscv-imsic-platform.c |  51 ++++--
 drivers/irqchip/irq-riscv-imsic-state.c    | 128 +++++++-------
 drivers/irqchip/irq-riscv-imsic-state.h    |   2 +-
 drivers/irqchip/irq-riscv-intc.c           | 114 +++++++++++-
 drivers/irqchip/irq-sifive-plic.c          | 113 ++++++++++--
 drivers/pci/msi/msi.c                      |   5 +
 drivers/pci/pci-acpi.c                     | 182 ++++++++++++++++++++
 drivers/pci/pci.h                          |   2 +
 drivers/tty/serial/8250/8250_pnp.c         |  18 +-
 include/linux/acpi.h                       |   9 +
 include/linux/irqchip/riscv-imsic.h        |  10 ++
 include/linux/pnp.h                        |  10 +-
 30 files changed, 906 insertions(+), 356 deletions(-)
 create mode 100644 drivers/acpi/riscv/init.c
 create mode 100644 drivers/acpi/riscv/init.h
 create mode 100644 drivers/acpi/riscv/irq.c

-- 
2.39.2


