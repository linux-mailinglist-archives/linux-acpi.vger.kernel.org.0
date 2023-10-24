Return-Path: <linux-acpi+bounces-893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 540B17D589D
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8975B2051F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573D63A276
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wib4BeGq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686512943B;
	Tue, 24 Oct 2023 15:16:42 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D281702;
	Tue, 24 Oct 2023 08:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DHFgwbhDAFhr0wm5LuIByPu//i1EC9G7tOAlX2nnyt8=; b=wib4BeGqtnB2TQL0sFubZZljQK
	cx0lk0h5QHzDGxyrSnfFhs+9mERI02DUT7/oPmyozwpuaIBy+fYTZ/6GEgW2mLT2iApGIWS3YL8NQ
	ArxTpXlTfw1XDmobEfS1K0th+Yfb6YVSsg6gZhWTahdfywyJC+RgtDVyvhJihui8wEpYLVGsfSALx
	zyFbbanap3eClxp1Vl2JYppAbQ2L5B7zorz9+/wiGMScDshB6X1S7eI/m1KWuRptXMdWDj8qOQvgu
	J25dkP2xH1U91JIfrTrrVv//Wwxho6CJktD5b/ApSLrsMW8zHzy9dHaKRzgvVjMpoz1yDvg4oQHFe
	G39A2Zag==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56258 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJ8u-0004M3-1K;
	Tue, 24 Oct 2023 16:16:28 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJ8v-00AqPA-S2; Tue, 24 Oct 2023 16:16:29 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 04/39] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled
 check into a helper
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ8v-00AqPA-S2@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:16:29 +0100

From: James Morse <james.morse@arm.com>

ACPI, irqchip and the architecture code all inspect the MADT
enabled bit for a GICC entry in the MADT.

The addition of an 'online capable' bit means all these sites need
updating.

Move the current checks behind a helper to make future updates easier.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Remove unnecessary parens
 * Moved earlier in series
---
 arch/arm64/kernel/smp.c       |  2 +-
 drivers/acpi/processor_core.c |  2 +-
 drivers/irqchip/irq-gic-v3.c  | 10 ++++------
 include/linux/acpi.h          |  5 +++++
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 960b98b43506..8c8f55721786 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -520,7 +520,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
-	if (!(processor->flags & ACPI_MADT_ENABLED)) {
+	if (!acpi_gicc_is_usable(processor)) {
 		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 7dd6dbaa98c3..b203cfe28550 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -90,7 +90,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
 
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return -ENODEV;
 
 	/* device_declaration means Device object in DSDT, in the
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index f59ac9586b7b..d50d9414f471 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2380,8 +2380,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
-	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	redist_base = ioremap(gicc->gicr_base_address, size);
@@ -2431,7 +2430,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
+	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
 		acpi_data.enabled_rdists++;
 		return 0;
 	}
@@ -2440,7 +2439,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * It's perfectly valid firmware can pass disabled GICC entry, driver
 	 * should not treat as errors, skip the entry instead of probe fail.
 	 */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	return -ENODEV;
@@ -2499,8 +2498,7 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
 	int maint_irq_mode;
 	static int first_madt = true;
 
-	/* Skip unusable CPUs */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..ebfea7bf663d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -256,6 +256,11 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
+static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
+{
+	return gicc->flags & ACPI_MADT_ENABLED;
+}
+
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 
-- 
2.30.2


