Return-Path: <linux-acpi+bounces-15759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20484B297C5
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 06:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8584189D27B
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Aug 2025 04:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101D260592;
	Mon, 18 Aug 2025 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="J6GAS9Ey"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3425E25FA05
	for <linux-acpi@vger.kernel.org>; Mon, 18 Aug 2025 04:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490208; cv=none; b=PMo5OIcutvJ2G7w97Cwf3sbAuJH8NMXbTYFjZ6R4otpQ5oy3IPiF9NN9kavzJiqgZF1yuz61xzVtAV1pAEMlQAjoCg3+ksX232+n8PrdUDPG7Hmm4LcveUqlUksJ8TSOZiQMdTYoi/AEnjcoNZZvAyKhLvLvRlQXX4jDH14QFp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490208; c=relaxed/simple;
	bh=TXDyftgxADRir5Rw8lnDgwPcIi7k3g2YvzBfuToFjVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Svsb+YMFv+GlrH9ENhBsdWtOQEa/xzsIQzbopw6qaQH49xpiH/lKo+YOvla32ONPUr4d6iwSfquIIFeEfryuJROqTlTQAEbTYsH6T4nhn3NS/o4far5cGcV8kW5ZF5NnjMcH5fXQ9Esx/qJfEa5P8QQqVtfeXJRHwKhuVIJas9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=J6GAS9Ey; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323267bc0a8so4746228a91.1
        for <linux-acpi@vger.kernel.org>; Sun, 17 Aug 2025 21:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755490205; x=1756095005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iKYOLGunQqKMdXF6qm/SZHKTrDdQ8k/yLLtlmUN6IDM=;
        b=J6GAS9Ey0mzLetMq9TG5MQdy/sc9VsSy7l5kzD3UIk7MqT+WAVMBb9xTfe0bu0DJFH
         tvo2KOy323pJ6KocGse67Sm4hfdEjticYgA1djtSEmF9Bl5RmKRL3Htu/Yvt3HqA0U/y
         buM+yZou9lDDIhgQoSfiC0KJmv0UGUwDce4Z7E3j5GATjG3EdDObIQ9IOUyAjPW0vzW+
         qZSU8xK5vXAaf+QCYXfwUmjRTK9WRbn5X+VYveD20fVS4X1G2l4svx8PRGQMPs/r1lZQ
         IAJ2I86FxSEdng9bjM/W7LPhCIPjtQ+os2zQnTxKWC/mVjPcSfLHnw2jCvyh4vnIkkBB
         nOYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755490205; x=1756095005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iKYOLGunQqKMdXF6qm/SZHKTrDdQ8k/yLLtlmUN6IDM=;
        b=RxzyYjTkHuY4QUr2snzLSg2zLgom8kW18IpLWB4Ca0ACPAl3xHo9iAyyhVDzgaG+fz
         PxatcVL7EVXyxY3t8s8+zjBw/M7CEI0ONlEnlYxKCuCLe6h6HaW7c5MMxS1FSbjXpaM7
         +nAnP4mIF44ME+Sw2rdxc5m8/qsC93pd7v75utHDoaumkUYs7gj1YVkHmd/fOXDZJVju
         0O4er6M25F1fx20pt6NYWKy1iZDveHaQC/oHi2A82/gB2FvqLD6r9FhLGqw9Re7tuoHT
         xloVOHbquj+W6Wrv2ZtDkz3PXUKRqofqHJQVvM1z481auBjJv4plG1RESg7YehhxGY+j
         o6eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJiLUsd1CbA2hye+xPIV/PVFkDO10D/NkVp40F4+WLwDj333hEIjb3hpibkuWm65fJC2aAGlBqzf3s@vger.kernel.org
X-Gm-Message-State: AOJu0YytdDeOFKwo9zWf/37gSyUzjzwL31rVa1ovHQglahKq/YlSXdQE
	LT0K9TYKm4RefFencBCyVFkBnjzbm9kfsl4EvkyrYdAMbdd7eTkm18Y0GFGwh6O5xSU=
X-Gm-Gg: ASbGncu716c1gi6PXySLHTQfgm5i+G//XI2pJkW+JhCC9IN6xFP8cgP4DibmwFbPcEl
	cdaJHpO2fkTDB6KHFKDFF6pb8Oq/qyIy89wJf0x+9lguKErRF87UZjwl/1l/cX4k1bJJ8pZapWd
	WK9qGa6ZB2e/DwhPL0n5FXULv6+m5YwjmUlVE0LWtfpYBi7aeDHLGy31k+kI5EBa4rVIZJwyLEY
	LeBvvFfj1GTvfwHy/R/YsM1mKSTqI3BOQRRKg7uO9+r3byTeTerr1W64w7f55TEMWhZjXVaQTtc
	OFU8w5IC4fIDN1gN/lBkoPAgWI2xB8MmFj6gCgkCwMyFWfFh2LzIq5sWCziL4+wjiWfcEDPl8Io
	dhPuCS8dffpYv9b5DDuZE5zFzqw7RktLF6/M2ji158CKk6XoU3shPuw==
X-Google-Smtp-Source: AGHT+IGdmiB7+Cb5/hqIGlVOwluhJy7QNe0bpoiDKTDYPYAg4O4TLUdcaJ5Rvz0B2g2NDnT1eIGDqA==
X-Received: by 2002:a17:90b:390f:b0:321:2407:3cef with SMTP id 98e67ed59e1d1-32342107d3emr12083892a91.32.1755490205226;
        Sun, 17 Aug 2025 21:10:05 -0700 (PDT)
Received: from localhost.localdomain ([122.171.17.53])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32343c70356sm6560972a91.25.2025.08.17.21.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 21:10:04 -0700 (PDT)
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
Subject: [PATCH v10 00/24] Linux SBI MPXY and RPMI drivers
Date: Mon, 18 Aug 2025 09:38:56 +0530
Message-ID: <20250818040920.272664-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SBI v3.0 (MPXY extension) [1] and RPMI v1.0 [2] specifications
are ratified by the RISC-V International.

Currently, most of the RPMI and MPXY drivers are in OpenSBI whereas
Linux only has SBI MPXY mailbox controller driver, RPMI clock driver
and RPMI system MSI driver This series also includes ACPI support
for SBI MPXY mailbox controller and RPMI system MSI drivers.

These patches can be found in the riscv_sbi_mpxy_mailbox_v10 branch
at: https://github.com/avpatel/linux.git

To test these patches, boot Linux on "virt,rpmi=on,aia=aplic-imsic"
machine with OpenSBI and QEMU from the dev-upstream branch at:
https://github.com/ventanamicro/opensbi.git
https://github.com/ventanamicro/qemu.git

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/releases
[2] https://github.com/riscv-non-isa/riscv-rpmi/releases

Changes since v9:
 - Rebased on Linux-6.17-rc2
 - Dropped make_u32_from_two_u16() and make_u64_from_two_u32() macros
   and their use from PATCH3, PATCH4, and PATCH10 as-per comments from
   Linus Torvalds (Refer, https://lkml.org/lkml/2025/8/9/76).

Changes since v8:
 - Added Jassi's Acked-by in mailbox related patches
 - Renamed "clock-controller" DT node to "clock-service" DT node
   in PATCH8 as suggested by Stephen Boyd

Changes since v7:
 - Addressed enum related nits in PATCH3
   (Refer, https://lore.kernel.org/all/CAK9=C2VxhC6soxHtmacedbeCU=rFi84Br1RvN2uPcBKoLhRaJw@mail.gmail.com/)
 - Addressed comments in PATCH7 as follows:
   - Added minmax.h to includes
   - Removed "rc" variable from mpxy_mbox_send_rpmi_data()
   - Removed alignment and other checks from mpxy_mbox_peek_rpmi_data()
   - Created separate function to restrict scope of channel_ids used in mpxy_mbox_probe()
   (Refer, https://lore.kernel.org/all/CAK9=C2Ume2CmBYHYob7HSJHu=ZdfdWM+4JYPgFJ9Hir5Oi8cOg@mail.gmail.com/)
 - Improved comments for struct rpmi_clk_rates in PATCH10
   (Refer, https://lore.kernel.org/all/CAK9=C2VfvsbFTjecQm0OSsssXbff7wC4fqWf3CTmnpWSiaLcBw@mail.gmail.com/)
 - Improved refactoring of acpi_fwnode_get_reference_args() in PATCH14
   (Refer, https://lore.kernel.org/all/20250702051345.1460497-15-apatel@ventanamicro.com/)
 - Improve nargs_count parsing in acpi_fwnode_get_reference_args() for PATCH15
   (Refer, https://lore.kernel.org/all/20250702051345.1460497-16-apatel@ventanamicro.com/)
 - Added more comments describing why need to explicitly set device MSI domain in PATCH21
   (Refer, https://lore.kernel.org/all/aGaUmpw1pVWNAmpb@smile.fi.intel.com/)

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
  ACPI: property: Refactor acpi_fwnode_get_reference_args() to support
    nargs_prop
  ACPI: Add support for nargs_prop in acpi_fwnode_get_reference_args()
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
 arch/riscv/include/asm/sbi.h                  |   62 +
 drivers/acpi/property.c                       |  128 ++-
 drivers/acpi/riscv/irq.c                      |   75 +-
 drivers/acpi/scan.c                           |    2 +
 drivers/base/property.c                       |    2 +-
 drivers/clk/Kconfig                           |    8 +
 drivers/clk/Makefile                          |    1 +
 drivers/clk/clk-rpmi.c                        |  616 ++++++++++
 drivers/irqchip/Kconfig                       |    7 +
 drivers/irqchip/Makefile                      |    1 +
 drivers/irqchip/irq-riscv-imsic-early.c       |    2 +
 drivers/irqchip/irq-riscv-rpmi-sysmsi.c       |  328 ++++++
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/mailbox.c                     |   65 +-
 drivers/mailbox/riscv-sbi-mpxy-mbox.c         | 1019 +++++++++++++++++
 include/linux/byteorder/generic.h             |   16 +
 include/linux/mailbox/riscv-rpmi-message.h    |  243 ++++
 include/linux/mailbox_controller.h            |    3 +
 28 files changed, 2975 insertions(+), 83 deletions(-)
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


