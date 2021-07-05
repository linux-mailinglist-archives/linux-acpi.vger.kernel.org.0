Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E063BBCF3
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jul 2021 14:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhGEMoK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 5 Jul 2021 08:44:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhGEMoJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 5 Jul 2021 08:44:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D679A61220;
        Mon,  5 Jul 2021 12:41:30 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH 1/3] ACPI: Add LoongArch support for ACPI_PROCESSOR/ACPI_NUMA
Date:   Mon,  5 Jul 2021 20:42:04 +0800
Message-Id: <20210705124206.1228958-2-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210705124206.1228958-1-chenhuacai@loongson.cn>
References: <20210705124206.1228958-1-chenhuacai@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

We are preparing to add new Loongson (based on LoongArch, not MIPS)
support. LoongArch use ACPI other than DT as its boot protocol, so
add its support for ACPI_PROCESSOR/ACPI_NUMA.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/acpi/Kconfig      | 4 ++--
 drivers/acpi/numa/Kconfig | 2 +-
 drivers/acpi/numa/srat.c  | 2 +-
 include/linux/acpi.h      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index fe0bb6277e4d..90afa44efcba 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -280,9 +280,9 @@ config ACPI_CPPC_LIB
 
 config ACPI_PROCESSOR
 	tristate "Processor"
-	depends on X86 || IA64 || ARM64
+	depends on X86 || IA64 || ARM64 || LOONGARCH
 	select ACPI_PROCESSOR_IDLE
-	select ACPI_CPU_FREQ_PSS if X86 || IA64
+	select ACPI_CPU_FREQ_PSS if X86 || IA64 || LOONGARCH
 	default y
 	help
 	  This driver adds support for the ACPI Processor package. It is required
diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index fcf2e556d69d..39b1f34c21df 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -2,7 +2,7 @@
 config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
-	depends on (X86 || IA64 || ARM64)
+	depends on (X86 || IA64 || ARM64 || LOONGARCH)
 	default y if IA64 || ARM64
 
 config ACPI_HMAT
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 6021a1013442..b8795fc49097 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -206,7 +206,7 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6bb36fd6ba31..3ba8511cbede 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -249,7 +249,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 
-#if defined(CONFIG_X86) || defined(CONFIG_IA64)
+#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(CONFIG_LOONGARCH)
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
 #else
 static inline void
-- 
2.27.0

