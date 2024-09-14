Return-Path: <linux-acpi+bounces-8292-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A1F978E86
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 195E21C226D7
	for <lists+linux-acpi@lfdr.de>; Sat, 14 Sep 2024 06:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FEB1CCEFD;
	Sat, 14 Sep 2024 06:53:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FA41CCEFC;
	Sat, 14 Sep 2024 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726296806; cv=none; b=jbITXLrzikxjakEkZtA90WXh4iRem+A1y5NF53Z6G5Hw/Lvg8iz/WFlrPfDlyWecdtIhh3aHgR5q+j2KflogjItU3Zb+0oz62N99UKtQY4/wNlpqD8P2N1fXij1TNl5cwuRimC5j17DRwl+Xsec6+rMblAJaPH7kFVs8ZbgvpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726296806; c=relaxed/simple;
	bh=l+/346QSa7QIjAv6+GoFPf58pN0bicn9uc/P6Cd3Y/E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Igo3pMwueBMjFGanqKF/9hFfObaMPvxaL9JwJeKrr+OSW7Q1aDwGylLQVkyUdrXtql87/cmInkhT7D4/V6J1rcWq2muyJruJGcMVhF316Mh8C8l6gPn8yoygK+zizVt9CuhEBhX95olCDs517kGPV+IqdT64GwXJ5VOhC/khGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxjerhMuVmF8gHAA--.18491S3;
	Sat, 14 Sep 2024 14:53:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMAxSebfMuVmy50GAA--.37863S2;
	Sat, 14 Sep 2024 14:53:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] LoongArch: Enable ACPI BGRT handling
Date: Sat, 14 Sep 2024 14:53:18 +0800
Message-Id: <20240914065318.2099448-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxSebfMuVmy50GAA--.37863S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add ACPI BGRT support on LoongArch so it can display image provied by
acpi table at boot stage and switch to graphical UI smoothly.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409102056.DNqh6zzA-lkp@intel.com/
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
v1 ... v2:
  1. Solve compile warning issue reported from lkp, return type of
     function early_memunmap() is void *, that of function early_ioremap()
     is void __iomem *, force type conversion is added.
---
 arch/loongarch/include/asm/io.h | 4 +---
 arch/loongarch/kernel/acpi.c    | 8 ++++++--
 arch/loongarch/mm/ioremap.c     | 9 +++++++++
 drivers/acpi/Kconfig            | 2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm/io.h
index 5e95a60df180..3049bccec693 100644
--- a/arch/loongarch/include/asm/io.h
+++ b/arch/loongarch/include/asm/io.h
@@ -10,6 +10,7 @@
 
 #include <asm/addrspace.h>
 #include <asm/cpu.h>
+#include <asm/early_ioremap.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
 #include <asm/string.h>
@@ -17,9 +18,6 @@
 extern void __init __iomem *early_ioremap(u64 phys_addr, unsigned long size);
 extern void __init early_iounmap(void __iomem *addr, unsigned long size);
 
-#define early_memremap early_ioremap
-#define early_memunmap early_iounmap
-
 #ifdef CONFIG_ARCH_IOREMAP
 
 static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index 929a497c987e..2993d7921198 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -9,6 +9,7 @@
 
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/efi-bgrt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/memblock.h>
@@ -39,14 +40,14 @@ void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
 	if (!phys || !size)
 		return NULL;
 
-	return early_memremap(phys, size);
+	return (void __iomem *)early_memremap(phys, size);
 }
 void __init __acpi_unmap_table(void __iomem *map, unsigned long size)
 {
 	if (!map || !size)
 		return;
 
-	early_memunmap(map, size);
+	early_memunmap((void *)map, size);
 }
 
 void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
@@ -212,6 +213,9 @@ void __init acpi_boot_table_init(void)
 	/* Do not enable ACPI SPCR console by default */
 	acpi_parse_spcr(earlycon_acpi_spcr_enable, false);
 
+	if (IS_ENABLED(CONFIG_ACPI_BGRT))
+		acpi_table_parse(ACPI_SIG_BGRT, acpi_parse_bgrt);
+
 	return;
 
 fdt_earlycon:
diff --git a/arch/loongarch/mm/ioremap.c b/arch/loongarch/mm/ioremap.c
index 70ca73019811..28562ac510c8 100644
--- a/arch/loongarch/mm/ioremap.c
+++ b/arch/loongarch/mm/ioremap.c
@@ -16,6 +16,15 @@ void __init early_iounmap(void __iomem *addr, unsigned long size)
 
 }
 
+void __init *early_memremap(resource_size_t phys_addr, unsigned long size)
+{
+	return (__force void *)early_ioremap(phys_addr, size);
+}
+
+void __init early_memunmap(void *addr, unsigned long size)
+{
+}
+
 void *early_memremap_ro(resource_size_t phys_addr, unsigned long size)
 {
 	return early_memremap(phys_addr, size);
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e3a7c2aedd5f..d67f63d93b2a 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -451,7 +451,7 @@ config ACPI_HED
 
 config ACPI_BGRT
 	bool "Boottime Graphics Resource Table support"
-	depends on EFI && (X86 || ARM64)
+	depends on EFI && (X86 || ARM64 || LOONGARCH)
 	help
 	  This driver adds support for exposing the ACPI Boottime Graphics
 	  Resource Table, which allows the operating system to obtain

base-commit: 196145c606d0f816fd3926483cb1ff87e09c2c0b
-- 
2.39.3


