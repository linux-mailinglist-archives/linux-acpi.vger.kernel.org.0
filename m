Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499D320B578
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Jun 2020 17:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgFZP6n (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Jun 2020 11:58:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFZP6n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 26 Jun 2020 11:58:43 -0400
Received: from dogfood.home (lfbn-nic-1-188-42.w2-15.abo.wanadoo.fr [2.15.37.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44682207FC;
        Fri, 26 Jun 2020 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593187123;
        bh=CLa/KzjkFuVB29ckXD65Yi/MPGSAfUM7uGj3uLRMd8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KvkqltL7W8QSPKTPhvffxK28GoCuvQLjCChN2Ds1Eul/Ijdz/A4oA+ajy5pKuK7Y8
         94WMZjajjI56YrQyBi5rSRaIHerNWXXrIqyvkRgXalg3TIe97DBCQy1h6HDSOvm81N
         VK9Lnps++4YE0cPVnQn+7mDc69oGPUt/SuJo6i/s=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-acpi@vger.kernel.org, will@kernel.org,
        catalin.marinas@arm.com, lorenzo.pieralisi@arm.com,
        sudeep.holla@arm.com, kernel-hardening@lists.openwall.com,
        Ard Biesheuvel <ardb@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v3 1/2] arm64/acpi: disallow AML memory opregions to access kernel memory
Date:   Fri, 26 Jun 2020 17:58:31 +0200
Message-Id: <20200626155832.2323789-2-ardb@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626155832.2323789-1-ardb@kernel.org>
References: <20200626155832.2323789-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

AML uses SystemMemory opregions to allow AML handlers to access MMIO
registers of, e.g., GPIO controllers, or access reserved regions of
memory that are owned by the firmware.

Currently, we also allow AML access to memory that is owned by the
kernel and mapped via the linear region, which does not seem to be
supported by a valid use case, and exposes the kernel's internal
state to AML methods that may be buggy and exploitable.

On arm64, ACPI support requires booting in EFI mode, and so we can cross
reference the requested region against the EFI memory map, rather than
just do a minimal check on the first page. So let's only permit regions
to be remapped by the ACPI core if
- they don't appear in the EFI memory map at all (which is the case for
  most MMIO), or
- they are covered by a single region in the EFI memory map, which is not
  of a type that describes memory that is given to the kernel at boot.

Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/acpi.h | 15 +----
 arch/arm64/kernel/acpi.c      | 66 ++++++++++++++++++++
 2 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index a45366c3909b..bd68e1b7f29f 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -47,20 +47,7 @@
 pgprot_t __acpi_get_mem_attribute(phys_addr_t addr);
 
 /* ACPI table mapping after acpi_permanent_mmap is set */
-static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
-					    acpi_size size)
-{
-	/* For normal memory we already have a cacheable mapping. */
-	if (memblock_is_map_memory(phys))
-		return (void __iomem *)__phys_to_virt(phys);
-
-	/*
-	 * We should still honor the memory's attribute here because
-	 * crash dump kernel possibly excludes some ACPI (reclaim)
-	 * regions from memblock list.
-	 */
-	return __ioremap(phys, size, __acpi_get_mem_attribute(phys));
-}
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
 
 typedef u64 phys_cpuid_t;
diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index a7586a4db142..01b861e225b0 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -261,6 +261,72 @@ pgprot_t __acpi_get_mem_attribute(phys_addr_t addr)
 	return __pgprot(PROT_DEVICE_nGnRnE);
 }
 
+void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
+{
+	efi_memory_desc_t *md, *region = NULL;
+	pgprot_t prot;
+
+	if (WARN_ON_ONCE(!efi_enabled(EFI_MEMMAP)))
+		return NULL;
+
+	for_each_efi_memory_desc(md) {
+		u64 end = md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT);
+
+		if (phys < md->phys_addr || phys >= end)
+			continue;
+
+		if (phys + size > end) {
+			pr_warn(FW_BUG "requested region covers multiple EFI memory regions\n");
+			return NULL;
+		}
+		region = md;
+		break;
+	}
+
+	/*
+	 * It is fine for AML to remap regions that are not represented in the
+	 * EFI memory map at all, as it only describes normal memory, and MMIO
+	 * regions that require a virtual mapping to make them accessible to
+	 * the EFI runtime services.
+	 */
+	prot = __pgprot(PROT_DEVICE_nGnRnE);
+	if (region) {
+		switch (region->type) {
+		case EFI_LOADER_CODE:
+		case EFI_LOADER_DATA:
+		case EFI_BOOT_SERVICES_CODE:
+		case EFI_BOOT_SERVICES_DATA:
+		case EFI_CONVENTIONAL_MEMORY:
+		case EFI_PERSISTENT_MEMORY:
+			pr_warn(FW_BUG "requested region covers kernel memory @ %pa\n", &phys);
+			return NULL;
+
+		case EFI_ACPI_RECLAIM_MEMORY:
+			/*
+			 * ACPI reclaim memory is used to pass firmware tables
+			 * and other data that is intended for consumption by
+			 * the OS only, which may decide it wants to reclaim
+			 * that memory and use it for something else. We never
+			 * do that, but we usually add it to the linear map
+			 * anyway, in which case we should use the existing
+			 * mapping.
+			 */
+			if (memblock_is_map_memory(phys))
+				return (void __iomem *)__phys_to_virt(phys);
+			/* fall through */
+
+		default:
+			if (region->attribute & EFI_MEMORY_WB)
+				prot = PAGE_KERNEL;
+			else if (region->attribute & EFI_MEMORY_WT)
+				prot = __pgprot(PROT_NORMAL_WT);
+			else if (region->attribute & EFI_MEMORY_WC)
+				prot = __pgprot(PROT_NORMAL_NC);
+		}
+	}
+	return __ioremap(phys, size, prot);
+}
+
 /*
  * Claim Synchronous External Aborts as a firmware first notification.
  *
-- 
2.27.0

