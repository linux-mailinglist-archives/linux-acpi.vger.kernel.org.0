Return-Path: <linux-acpi+bounces-14892-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66608AF0A37
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 07:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DD973A2D38
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 05:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092C11F30BB;
	Wed,  2 Jul 2025 05:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TDJiqJsO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACC11E411C
	for <linux-acpi@vger.kernel.org>; Wed,  2 Jul 2025 05:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433248; cv=none; b=cl+NYnGlW/EHl2fdbP/s2sJs8I54wI0aWg9VmwDOCGpAmkxkg4C7DY+E0fB//CvrP3CVI4au8862ozX1niOVYfZqIuq8c1YFDmMuR5UPIG/rAm3X1kJJcb6Hc7WtcFFerBX86yWd4zAWzEdogyJxD7NQBwz0uEKLy3B4FdmcNOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433248; c=relaxed/simple;
	bh=a2WJWowGcMHBLQiR5kj5b6W9L1PKYZNFF0whylrfpYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJ4Y0hyPeIAQejcnh8KNFmqCcwbyewYgu/0uuNHHR+Ht8fiE7zT7sNpI+COI+gI+Y/u3JALEFoVw/fsT0gxlg0Yb1TMnHcJs2BywowKDG2UesVeMddnoLzzIMc6k0p3vbXEsgvlc3olXdv2VSmMMWJU75aEzm42zs85p/G0JqSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TDJiqJsO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234bfe37cccso77537575ad.0
        for <linux-acpi@vger.kernel.org>; Tue, 01 Jul 2025 22:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1751433247; x=1752038047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8hqFeEl/7NL4uSioSfMgKyMg7ju7Ht2YhO9WBTP7uto=;
        b=TDJiqJsO8t/yY/gOD9tTdPGgKp3gWtEUTj35c9ledeUGeHR7aXO6T7U9HKJHU6l5K3
         R0JZVMsQIx6lQ2KCZuLC31Y8udVrGh4FMkWvYY//3iQB+3QRimGzYa+0Mm4GaWu+qYVt
         J/MJmQUF2ublzXVQn2XuvOv1sj+M+aOy6mcKuDAabQD8geLAUigeo42KvCjZBr/8+4cT
         4L1QiRh8CjZyoa/oxwyZCx7ht9Z+JIgD2398Weexm5nkOvobsQDgB2/g7tf88ml1+LSV
         jmeNbKlzK5xPb8mb7gfKzykDifDXPfbxHL5oLmJoQCWESS4zAa+dIxTvWKE3AUkwBmgp
         tTMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433247; x=1752038047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8hqFeEl/7NL4uSioSfMgKyMg7ju7Ht2YhO9WBTP7uto=;
        b=fub1YnaD1s9Rlta1r5wuX9gvlfbyXXzIfKxWaPu+DkaclT69F+sEbZ8tt1J2rBgAKO
         ra6dKFsSMaH3saInv5NHBob9cRO6OylJefKq3Gvkc5A95k37/l8roHUkb7dGb9qt3YhE
         Zsi9Y+6MIMmtSuN+sr/8lHYBdwNwiAxIUESzsj+qkNWAxC0yD6DA42dPvbl/7RSdBRSo
         qkt/Z8SzJl/eJceX7OrUqv7ehC6xdRi/34be71nkUvUbldpqlfGnPM3L4iFfhWrFeZAo
         moPxgc2qqyvEMcQP4ZW9drp7xXecYcEjOLDSsRBpKKpa00/e1LzyUA+UHXeN3gx5IbLE
         WqNg==
X-Forwarded-Encrypted: i=1; AJvYcCXv09WXEfTduSc9SkRvCTZogG+99B6gEDblnG/8qDf3ggkLodXMvVoh0fB7lJVpHkoTneimP9649YOj@vger.kernel.org
X-Gm-Message-State: AOJu0YyyDs7YuqX+uaD5gpIlenBHBR2NydwYPo3y+ZjwoEBTSZp2VS9M
	cqiitxfZKrqnF/sRSFKCBZNGbiSlWu4nBH7yvgoTOtn0mDqWDiexiD0jBrhlbTc/4Fc=
X-Gm-Gg: ASbGncsyZlcCFq/FpqRV9g4zauO1zJIvvAQ/p8gEq3RwEawGNl3PEyAUGFTmxX8f4c+
	71HrJ0GfoZHlyjKpMThIu32fTEXLU4dCCUmJRoDKtz4bFqvRZHiUcrYYFopGgSgdgS9bjrqr32F
	Zh36MWvuU5kvVSmJHEX57oOrfjsmvYCTz0bPRMNGxHYtARSxSJRMllNlT0epiPGs+CBFaMHFb8a
	eVKEtPqC8seIqo+f2+O48BbEQYi3bTjuVOUkKbftmTtz1Ft8AbR1MR3dxeY/kIhkVp1sbTio0w3
	C4uOlCF4Yj2LNqidtZPy0gtrRzCRjP6yteEs/OArNwAtYa3jomA8qyz3DcGnDEOQDf+NRqf37VV
	AStKUbYutnubFVfGi
X-Google-Smtp-Source: AGHT+IGW+J2fIwWH6X6LAl11sgYIddpz+sYlzP/sydbYfpxcjR3h6x4hBGMJ4IBq+mSGYIGFTj/LWw==
X-Received: by 2002:a17:903:ac8:b0:234:f6ba:e681 with SMTP id d9443c01a7336-23c6e561235mr21283135ad.5.1751433246527;
        Tue, 01 Jul 2025 22:14:06 -0700 (PDT)
Received: from localhost.localdomain ([14.141.91.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c6fe31933sm4719595ad.220.2025.07.01.22.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:14:06 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v7 00/24] Linux SBI MPXY and RPMI drivers
Date: Wed,  2 Jul 2025 10:43:21 +0530
Message-ID: <20250702051345.1460497-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
are frozen and in public review at the RISC-V International.

Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
and RPMI system MSI driver This series also includes ACPI support
for SBI MPXY mailbox controller and RPMI system MSI drivers.

These patches can be found in the riscv_sbi_mpxy_mailbox_v7 branch
at: https://github.com/avpatel/linux.git

To test these patches, boot Linux on "virt,rpmi=on,aia=aplic-imsic"
machine with OpenSBI and QEMU from the dev-upstream branch at:
https://github.com/ventanamicro/opensbi.git
https://github.com/ventanamicro/qemu.git

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
[2] https://github.com/riscv-non-isa/riscv-rpmi/releases

Changes since v6:
 - Rebased the series on Linux-6.16-rc4
 - Added Stephen's Reviewed-by in appropriate patches
 - Addressed Andy's comments on PATCH5, PATCH6, PATCH9, and PATCH14
 - New PATCH6 in this series which is factored-out from PATCH7

Changes since v5:
 - Rebased the series on Linux-6.16-rc2
 - Added Conor's Reviewed-by in all DT binding patches
 - Addressed Andy's comments on PATCH5
 - Addressed Tglx's comments on PATCH12 and PATCH21

Changes since v4:
 - Rebased the series on Linux-6.16-rc1
 - Dropped PATCH1 since a similar change is already merged
   https://lore.kernel.org/linux-riscv/20250523101932.1594077-4-cleger@rivosinc.com/
 - Addressed Andy's comments on PATCH4, PATCH5, PATCH6, PATCH7,
   PATCH13, and PATCH17
 - Addressed Atish's comments on PATCH11 and PATCH12
 - Addressed Conor's comments on PATCH9

Changes since v3:
 - Rebased the series on Linux-6.15-rc7
 - Updated PATCH2 DT bindings as-per Rob's suggestion
 - Improved request_threaded_irq() usage in PATCH7
 - Updated PATCH10 clk-rpmi driver as-per commments from Andy
 - Updated PATCH13 irq-riscv-rpmi-sysmsi driver as-per comments
   from Andy and Tglx
 - Addressed ACPI related comments in PATCH14, PATCH15, PATCH18,
   PATCH20 and PATCH21

Changes since v2:
 - Dropped the "RFC" tag from series since the SBI v3.0 and
   RPMI v1.0 specifications are now frozen
 - Rebased the series on Linux-6.15-rc5
 - Split PATCH8 of v2 into two patches adding separate DT
   bindings for "riscv,rpmi-mpxy-clock" and "riscv,rpmi-clock"
 - Split PATCH10 of v2 into two patches adding separate DT
   bindings for "riscv,rpmi-mpxy-system-msi" and
   "riscv,rpmi-system-msi"
 - Addressed comments from TGLX on PATCH11 of v2 adding irqchip
   driver for RPMI system MSI
 - Addressed ACPI related comments in PATCH15 and PATCH16 of v2
 - New PATCH17 and PATCH18 in this series

Changes since v1:
 - Addressed DT bindings related comments in PATCH2, PATCH3, and
   PATCH7 of v1 series
 - Addressed comments in PATCH6 and PATCH8 of v1 series
 - New PATCH6 in v2 series to allow fwnode based mailbox channel
   request
 - New PATCH10 and PATCH11 to add RPMI system MSI based interrupt
   controller driver
 - New PATCH12 to PATCH16 which adds ACPI support in SBI MPXY
   mailbox driver and RPMI system MSI driver
 - New PATCH17 to enable required kconfig option to allow graceful
   shutdown on QEMU virt machine

Anup Patel (14):
  dt-bindings: mailbox: Add bindings for RPMI shared memory transport
  dt-bindings: mailbox: Add bindings for RISC-V SBI MPXY extension
  RISC-V: Add defines for the SBI message proxy extension
  mailbox: Add common header for RPMI messages sent via mailbox
  mailbox: Allow controller specific mapping using fwnode
  byteorder: Add memcpy_to_le32() and memcpy_from_le32()
  mailbox: Add RISC-V SBI message proxy (MPXY) based mailbox driver
  dt-bindings: clock: Add RPMI clock service message proxy bindings
  dt-bindings: clock: Add RPMI clock service controller bindings
  dt-bindings: Add RPMI system MSI message proxy bindings
  dt-bindings: Add RPMI system MSI interrupt controller bindings
  irqchip: Add driver for the RPMI system MSI service group
  RISC-V: Enable GPIO keyboard and event device in RV64 defconfig
  MAINTAINERS: Add entry for RISC-V RPMI and MPXY drivers

Rahul Pathak (1):
  clk: Add clock driver for the RISC-V RPMI clock service group

Sunil V L (9):
  ACPI: property: Refactor acpi_fwnode_get_reference_args()
  ACPI: property: Add support for cells property
  ACPI: scan: Update honor list for RPMI System MSI
  ACPI: RISC-V: Create interrupt controller list in sorted order
  ACPI: RISC-V: Add support to update gsi range
  ACPI: RISC-V: Add RPMI System MSI to GSI mapping
  irqchip/irq-riscv-imsic-early: Export imsic_acpi_get_fwnode()
  mailbox/riscv-sbi-mpxy: Add ACPI support
  irqchip/riscv-rpmi-sysmsi: Add ACPI support

 .../bindings/clock/riscv,rpmi-clock.yaml      |   64 ++
 .../bindings/clock/riscv,rpmi-mpxy-clock.yaml |   64 ++
 .../riscv,rpmi-mpxy-system-msi.yaml           |   67 ++
 .../riscv,rpmi-system-msi.yaml                |   74 ++
 .../mailbox/riscv,rpmi-shmem-mbox.yaml        |  124 ++
 .../bindings/mailbox/riscv,sbi-mpxy-mbox.yaml |   51 +
 MAINTAINERS                                   |   15 +
 arch/riscv/configs/defconfig                  |    2 +
 arch/riscv/include/asm/irq.h                  |    6 +
 arch/riscv/include/asm/sbi.h                  |   63 +
 drivers/acpi/property.c                       |  119 +-
 drivers/acpi/riscv/irq.c                      |   75 +-
 drivers/acpi/scan.c                           |    2 +
 drivers/base/property.c                       |    2 +-
 drivers/clk/Kconfig                           |    8 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rpmi.c                        |  616 ++++++++++
 drivers/irqchip/Kconfig                       |    7 +
 drivers/irqchip/Makefile                      |    1 +
 drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  324 ++++++
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/mailbox.c                     |   65 +-
 drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1012 +++++++++++++++++
 include/linux/byteorder/generic.h             |   16 +
 include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
 include/linux/mailbox_controller.h            |    3 +
 include/linux/wordpart.h                      |   16 +
 29 files changed, 2973 insertions(+), 82 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/riscv,rpmi-mpxy-clock.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-mpxy-system-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,rpmi-system-msi.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,rpmi-shmem-mbox.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/riscv,sbi-mpxy-mbox.yaml
 create mode 100644 drivers/clk/clk-rpmi.c
 create mode 100644 drivers/irqchip/irq-riscv-rpmi-sysmsi.c
 create mode 100644 drivers/mailbox/riscv-sbi-mpxy-mbox.c
 create mode 100644 include/linux/mailbox/riscv-rpmi-message.h

-- 
2.43.0


