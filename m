Return-Path: <linux-acpi+bounces-901-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B007D58AF
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E535B207C8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA8B30FB3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rS8lQO9r"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E039230FB7;
	Tue, 24 Oct 2023 15:17:19 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417D1712;
	Tue, 24 Oct 2023 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BN0vsLWemtYAq9+Im9GUXPxMyA6YabHvnG3SH5iIqk8=; b=rS8lQO9r3WZ09VV1OqVNusV9SL
	ujSkNet/X+0I6cmL0TrLgnv50krvNgaY0VFGFzWKKsT7K4lkz2nbe3mn+Z21r5lB2O7fhEVrZIVqD
	8z6Vm12X48ckRwNT7PMCI3rtIBOk77rgMbNIJHZ7eefPEFSCLBCq3d8D5AwacGvNgfe54OEzJq0tn
	fCXc1xPO0Cx7BZYefjESxgu39c05XNiF0G6e6rfeFr0/yzeoK1Tf3NX07gWPgzXXn87qujSy6F+wy
	OAFNitwQxJCxc0/dB7FAN7KK2BEA9IlijizK8vfcAgb3AvrY+mbRsXierpJduNKYbKmZlvvb+NjMW
	5wO4nCeg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:40922 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJ9b-0004Og-0J;
	Tue, 24 Oct 2023 16:17:11 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJ9b-00AqPz-1E; Tue, 24 Oct 2023 16:17:11 +0100
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
	 James Morse <james.morse@arm.com>
Subject: [PATCH 12/39] ia64/topology: Switch over to GENERIC_CPU_DEVICES
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ9b-00AqPz-1E@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:17:11 +0100

From: James Morse <james.morse@arm.com>

ia64 has its own arch specific data structure for cpus: struct ia64_cpu.
This has one member, making ia64's cpu_devices the same as that
provided be GENERIC_CPU_DEVICES.
ia64 craetes a percpu struct ia64_cpu called cpu_devices, which has no
users. Instead it uses the struct ia64_cpu named sysfs_cpus allocated at
boot.

Remove the arch specific structure allocation and initialisation.
ia64's arch_register_cpu() now overrides the weak version from
GENERIC_CPU_DEVICES, and uses the percpu cpu_devices defined by
core code.

All uses of sysfs_cpus are changed to use the percpu cpu_devices.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add note about initialisation order change.
---
 arch/ia64/Kconfig           |  1 +
 arch/ia64/include/asm/cpu.h |  6 ------
 arch/ia64/kernel/topology.c | 35 +++++------------------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index a3bfd42467ab..06692e1c7c62 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -42,6 +42,7 @@ config IA64
 	select HAVE_FUNCTION_DESCRIPTORS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HUGETLB_PAGE_SIZE_VARIABLE if HUGETLB_PAGE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_IRQ_PROBE
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_IRQ_SHOW
diff --git a/arch/ia64/include/asm/cpu.h b/arch/ia64/include/asm/cpu.h
index 642d71675ddb..3b36c6a382bb 100644
--- a/arch/ia64/include/asm/cpu.h
+++ b/arch/ia64/include/asm/cpu.h
@@ -7,12 +7,6 @@
 #include <linux/topology.h>
 #include <linux/percpu.h>
 
-struct ia64_cpu {
-	struct cpu cpu;
-};
-
-DECLARE_PER_CPU(struct ia64_cpu, cpu_devices);
-
 DECLARE_PER_CPU(int, cpu_state);
 
 #endif /* _ASM_IA64_CPU_H_ */
diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 741863a187a6..8f5cafde2bc9 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -26,8 +26,6 @@
 #include <asm/numa.h>
 #include <asm/cpu.h>
 
-static struct ia64_cpu *sysfs_cpus;
-
 void arch_fix_phys_package_id(int num, u32 slot)
 {
 #ifdef CONFIG_SMP
@@ -41,50 +39,27 @@ EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);
 #ifdef CONFIG_HOTPLUG_CPU
 int __ref arch_register_cpu(int num)
 {
+	struct cpu *cpu = &per_cpu(cpu_devices, num);
+
 	/*
 	 * If CPEI can be re-targeted or if this is not
 	 * CPEI target, then it is hotpluggable
 	 */
 	if (can_cpei_retarget() || !is_cpu_cpei_target(num))
-		sysfs_cpus[num].cpu.hotpluggable = 1;
+		cpu->hotpluggable = 1;
 	map_cpu_to_node(num, node_cpuid[num].nid);
-	return register_cpu(&sysfs_cpus[num].cpu, num);
+	return register_cpu(cpu, num);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
 void __ref arch_unregister_cpu(int num)
 {
-	unregister_cpu(&sysfs_cpus[num].cpu);
+	unregister_cpu(&per_cpu(cpu_devices, num));
 	unmap_cpu_from_node(num, cpu_to_node(num));
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
-#else
-int __init arch_register_cpu(int num)
-{
-	return register_cpu(&sysfs_cpus[num].cpu, num);
-}
 #endif /*CONFIG_HOTPLUG_CPU*/
 
-
-static int __init topology_init(void)
-{
-	int i, err = 0;
-
-	sysfs_cpus = kcalloc(NR_CPUS, sizeof(struct ia64_cpu), GFP_KERNEL);
-	if (!sysfs_cpus)
-		panic("kzalloc in topology_init failed - NR_CPUS too big?");
-
-	for_each_present_cpu(i) {
-		if((err = arch_register_cpu(i)))
-			goto out;
-	}
-out:
-	return err;
-}
-
-subsys_initcall(topology_init);
-
-
 /*
  * Export cpu cache information through sysfs
  */
-- 
2.30.2


