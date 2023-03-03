Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4336A9889
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 14:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCCNhF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 08:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjCCNhF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 08:37:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2DD3E083
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 05:36:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id y2so2517882pjg.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 05:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1677850615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lcRdKQgaZO87kSxaTq3dQQhph83hzwyCoWioxxpX9w=;
        b=dQBPMBgEvKNCNE3n3JA50GRZRNcDTSbAoYkOIGsdDouI+sJ2krhDk1znB/I3CLBufm
         cZiURslj26CEnsUlN+iBBdPHXcpzagybSVOPiEOZIzxQErkMEXqjxFtJ5XZEy+aoAyJ2
         dhXitSLGZNgIW8dqGxNMJNRzdAOJLOKd15Z28jbsXnQbOtp0BHG99JQVTveM5BQR/Lkk
         Oz/Jd7W5F7I2Z112XWVyysA2snle3N9zlm33gw6329hjoUcTZbCgS7AXe+9WlidHtOHE
         WwaQLjJsn8RfLVwCrDZw9HNBhBtk0y+orDkDm8WnrCUt1CE2wACMJbuEQNToI0ROF/IP
         LRWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677850615;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0lcRdKQgaZO87kSxaTq3dQQhph83hzwyCoWioxxpX9w=;
        b=gH/LhfZEL+jwwhcN8Uj6ghPlEgfPnnERZyDapEiq2HCdEwt96oPxh0tzztCJW7/7pl
         vgDAp5p++MepUjqmaCyaShbravbI3cM7wmIF+7W1ufzspM51gigXfA/8xzL5nbFcOjjU
         rBDyTzG840vs8utwdupTXic81KDNScovXGQWtjWoIYCyClxwXzFKsE7MVfP6q955knpX
         T8cLZwRyXG5wZQXJZ9pfJEnZzpUnTtZZF/Q9pxiVtgjh8bZ8UKWkBeA0f4nT1j5Sujww
         mDA24F1H7ukeFaJCVXFv3tMi4Ipd21+e3C2EwY7w8fmj2BOCn3pkaltId2ONq9HSosv8
         vFMw==
X-Gm-Message-State: AO0yUKUa+ifnv6R0WQEbpBRjRV2/z7GQfjCpAUzRva7BBz3v1vZXSn8i
        fiUH98mZFhxKRQJGhEVr6bF2aQ==
X-Google-Smtp-Source: AK7set8an551CnhvNkEz3XpDl39Ncgs6Yopsd9JY5sqGN3Ly/d177jbxuWStV6HcSgxyLsh8Y3BKuA==
X-Received: by 2002:a17:90a:fe17:b0:234:9303:2801 with SMTP id ck23-20020a17090afe1700b0023493032801mr1734761pjb.20.1677850614912;
        Fri, 03 Mar 2023 05:36:54 -0800 (PST)
Received: from localhost.localdomain ([49.206.14.226])
        by smtp.gmail.com with ESMTPSA id m9-20020a170902768900b0019ac5d3ee9dsm1533125pll.157.2023.03.03.05.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:36:54 -0800 (PST)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V3 00/20] Add basic ACPI support for RISC-V
Date:   Fri,  3 Mar 2023 19:06:27 +0530
Message-Id: <20230303133647.845095-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series enables the basic ACPI infrastructure for RISC-V.
Supporting external interrupt controllers is in progress and hence it is
tested using poll based HVC SBI console and RAM disk.

The first patch in this series is one of the patch from Jisheng's
series [1] which is not merged yet. This patch is required to support
ACPI since efi_init() which gets called before sbi_init() can enable
static branches and hits a panic.

Patch 2 and 3 are ACPICA patches which are not merged into acpica yet
but a PR is raised already.

Below are two ECRs approved by ASWG.
RINTC - https://drive.google.com/file/d/1R6k4MshhN3WTT-hwqAquu5nX6xSEqK2l/view
RHCT - https://drive.google.com/file/d/1nP3nFiH4jkPMp6COOxP6123DCZKR-tia/view

The series depends on Anup's IPI improvement series [2].

[1] https://lore.kernel.org/all/20220821140918.3613-1-jszhang@kernel.org/
[2] https://lore.kernel.org/lkml/20230103141221.772261-7-apatel@ventanamicro.com/T/

Changes since V2:
	1) Dropped ACPI_PROCESSOR patch.
	2) Added new patch to print debug info of RISC-V INTC in MADT
	3) Addressed other comments from Drew.
	4) Rebased and updated tags

Changes since V1:
	1) Dropped PCI changes and instead added dummy interfaces just to enable
	   building ACPI core when CONFIG_PCI is enabled. Actual PCI changes will
	   be added in future along with external interrupt controller support
	   in ACPI.
	2) Squashed couple of patches so that new code added gets built in each
	   commit.
	3) Fixed the missing wake_cpu code in timer refactor patch as pointed by
	   Conor
	4) Fixed an issue with SMP disabled.
	5) Addressed other comments from Conor.
	6) Updated documentation patch as per feedback from Sanjaya.
	7) Fixed W=1 and checkpatch --strict issues.
	8) Added ACK/RB tags

These changes are available at
https://github.com/vlsunil/linux/commits/acpi_b1_us_review_ipi17_V3

Testing:
1) Build Qemu with ACPI support using below branch
https://github.com/vlsunil/qemu/tree/acpi_b1_us_review_V5

2) Build EDK2 as per instructions in
https://github.com/vlsunil/riscv-uefi-edk2-docs/wiki/RISC-V-Qemu-Virt-support

3) Build Linux after enabling SBI HVC and SBI earlycon
CONFIG_RISCV_SBI_V01=y
CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
CONFIG_HVC_RISCV_SBI=y

4) Build buildroot.

Run with below command.
qemu-system-riscv64   -nographic \
-drive file=Build/RiscVVirtQemu/RELEASE_GCC5/FV/RISCV_VIRT.fd,if=pflash,format=raw,unit=1 \
-machine virt -smp 16 -m 2G \
-kernel arch/riscv/boot/Image \
-initrd buildroot/output/images/rootfs.cpio \
-append "root=/dev/ram ro console=hvc0 earlycon=sbi"


Jisheng Zhang (1):
  riscv: move sbi_init() earlier before jump_label_init()

Sunil V L (19):
  ACPICA: MADT: Add RISC-V INTC interrupt controller
  ACPICA: Add structure definitions for RISC-V RHCT
  ACPI: tables: Print RINTC information when MADT is parsed
  ACPI: OSL: Make should_use_kmap() 0 for RISC-V
  RISC-V: Add support to build the ACPI core
  ACPI: processor_core: RISC-V: Enable mapping processor to the hartid
  drivers/acpi: RISC-V: Add RHCT related code
  RISC-V: smpboot: Create wrapper smp_setup()
  RISC-V: smpboot: Add ACPI support in smp_setup()
  RISC-V: ACPI: Cache and retrieve the RINTC structure
  RISC-V: cpufeature: Add ACPI support in riscv_fill_hwcap()
  RISC-V: cpu: Enable cpuinfo for ACPI systems
  irqchip/riscv-intc: Add ACPI support
  clocksource/timer-riscv: Refactor riscv_timer_init_dt()
  clocksource/timer-riscv: Add ACPI support
  RISC-V: time.c: Add ACPI support for time_init()
  RISC-V: Add ACPI initialization in setup_arch()
  RISC-V: Enable ACPI in defconfig
  MAINTAINERS: Add entry for drivers/acpi/riscv

 .../admin-guide/kernel-parameters.txt         |   8 +-
 MAINTAINERS                                   |   8 +
 arch/riscv/Kconfig                            |   5 +
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/include/asm/acenv.h                |  11 +
 arch/riscv/include/asm/acpi.h                 |  82 ++++++
 arch/riscv/include/asm/cpu.h                  |   8 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/acpi.c                      | 262 ++++++++++++++++++
 arch/riscv/kernel/cpu.c                       |  27 +-
 arch/riscv/kernel/cpufeature.c                |  41 ++-
 arch/riscv/kernel/setup.c                     |  27 +-
 arch/riscv/kernel/smpboot.c                   |  77 ++++-
 arch/riscv/kernel/time.c                      |  23 +-
 drivers/acpi/Makefile                         |   2 +
 drivers/acpi/osl.c                            |   2 +-
 drivers/acpi/processor_core.c                 |  29 ++
 drivers/acpi/riscv/Makefile                   |   2 +
 drivers/acpi/riscv/rhct.c                     |  82 ++++++
 drivers/acpi/tables.c                         |  10 +
 drivers/clocksource/timer-riscv.c             |  92 +++---
 drivers/irqchip/irq-riscv-intc.c              |  77 ++++-
 include/acpi/actbl2.h                         |  68 ++++-
 23 files changed, 854 insertions(+), 92 deletions(-)
 create mode 100644 arch/riscv/include/asm/acenv.h
 create mode 100644 arch/riscv/include/asm/acpi.h
 create mode 100644 arch/riscv/include/asm/cpu.h
 create mode 100644 arch/riscv/kernel/acpi.c
 create mode 100644 drivers/acpi/riscv/Makefile
 create mode 100644 drivers/acpi/riscv/rhct.c

-- 
2.34.1

