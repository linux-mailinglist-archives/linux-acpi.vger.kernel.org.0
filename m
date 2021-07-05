Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823633BBCF2
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbhGEMoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 08:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGEMoE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 08:44:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE42B613B1;
        Mon,  5 Jul 2021 12:41:24 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Jianmin Lv <lvjianmin@loongson.cn>
Subject: [PATCH 0/3] ACPI: Add LoongArch-related definitions
Date:   Mon,  5 Jul 2021 20:42:03 +0800
Message-Id: <20210705124206.1228958-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

This patchset are preparing to add LoongArch support in mainline kernel,
we can see a snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

Huacai Chen and Jianmin Lv(3):
 ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA.
 ACPICA: MADT: Add LoongArch APICs support.
 ACPICA: Events: Support fixed pcie wake event.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Jianmin Lv <lvjianmin@loongson.cn> 
---
 drivers/acpi/Kconfig           |   4 +-
 drivers/acpi/acpica/evevent.c  |  17 ++++--
 drivers/acpi/acpica/hwsleep.c  |  12 ++++
 drivers/acpi/acpica/utglobal.c |   4 ++
 drivers/acpi/numa/Kconfig      |   2 +-
 drivers/acpi/numa/srat.c       |   2 +-
 drivers/acpi/tables.c          |  10 ++++
 include/acpi/actbl2.h          | 123 ++++++++++++++++++++++++++++++++++++++++-
 include/acpi/actypes.h         |   3 +-
 include/linux/acpi.h           |   2 +-
 10 files changed, 166 insertions(+), 13 deletions(-)
--
2.27.0

