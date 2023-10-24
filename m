Return-Path: <linux-acpi+bounces-922-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB407D58E2
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68E2FB20B73
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9D13B284
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HXBUATQV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBB434CF6;
	Tue, 24 Oct 2023 15:19:08 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99DB2700;
	Tue, 24 Oct 2023 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IvdCyZ69JqjCqU2UCE2N7kgvodoHzzbAeaFJb32wt6M=; b=HXBUATQVBdjMZPY0yc6gM7kPy3
	G3hrUbLBAVOLWAfhp7RSpQyTDo7kR93WiMzdV7a87uv35WPsIqru3D1uZ6uAi2zfLpa6dfU3h5pv8
	vzi3dl9isG3GGh3n5k2W4XJe0ogrjaGhQ5L55rpGmsONgDHpsUuhQ355rEY2hf+9Lg9SqilZSMfZX
	Ye7Y/qNvdVEdWIgCGh36o2wQflsQPjVxaUPt/A2I4YhimpoM+vFFnMib/ZXWdF85xUHJuFLIFlF3S
	e8ajQ1VQuoclimJYrm4GDa0mWAJKt6BniECMV5SPpDQwXY0VqweTrf/JA0Zs+Jbxda2NjqyCiiVCk
	CdBVe8Jw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46022 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJBJ-0004Vr-2J;
	Tue, 24 Oct 2023 16:18:57 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJBL-00AqS2-3S; Tue, 24 Oct 2023 16:18:59 +0100
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
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH 33/39] irqchip/gic-v3: Add support for ACPI's disabled but
 'online capable' CPUs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJBL-00AqS2-3S@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:18:59 +0100

From: James Morse <james.morse@arm.com>

To support virtual CPU hotplug, ACPI has added an 'online capable' bit
to the MADT GICC entries. This indicates a disabled CPU entry may not
be possible to online via PSCI until firmware has set enabled bit in
_STA.

What about the redistributor in the GICC entry? ACPI doesn't want to say.
Assume the worst: When a redistributor is described in the GICC entry,
but the entry is marked as disabled at boot, assume the redistributor
is inaccessible.

The GICv3 driver doesn't support late online of redistributors, so this
means the corresponding CPU can't be brought online either. Clear the
possible and present bits.

Systems that want CPU hotplug in a VM can ensure their redistributors
are always-on, and describe them that way with a GICR entry in the MADT.

When mapping redistributors found via GICC entries, handle the case
where the arch code believes the CPU is present and possible, but it
does not have an accessible redistributor. Print a warning and clear
the present and possible bits.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
----
Disabled but online-capable CPUs cause this message to be printed
if their redistributors are described via GICC:
| GICv3: CPU 3's redistributor is inaccessible: this CPU can't be brought online

If ACPI's _STA tries to make the cpu present later, this message is printed:
| Changing CPU present bit is not supported

Changes since RFC v2:
 * use gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE)
---
 drivers/irqchip/irq-gic-v3.c | 14 ++++++++++++++
 include/linux/acpi.h         |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e787e7bbb5a2..8a89b853a5b9 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2378,11 +2378,25 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 				(struct acpi_madt_generic_interrupt *)header;
 	u32 reg = readl_relaxed(acpi_data.dist_base + GICD_PIDR2) & GIC_PIDR2_ARCH_MASK;
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
+	int cpu = get_cpu_for_acpi_id(gicc->uid);
 	void __iomem *redist_base;
 
 	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
+	/*
+	 * Capable but disabled CPUs can be brought online later. What about
+	 * the redistributor? ACPI doesn't want to say!
+	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
+	 * Otherwise, prevent such CPUs from being brought online.
+	 */
+	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
+		pr_warn_once("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
+		set_cpu_present(cpu, false);
+		set_cpu_possible(cpu, false);
+		return 0;
+	}
+
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
 		return -ENOMEM;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 3672312e15eb..ed1ef5d8687f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -258,7 +258,7 @@ void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
 static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
 {
-	return gicc->flags & ACPI_MADT_ENABLED;
+	return gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_CPU_CAPABLE);
 }
 
 /* the following numa functions are architecture-dependent */
-- 
2.30.2


