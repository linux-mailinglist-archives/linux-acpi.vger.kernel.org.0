Return-Path: <linux-acpi+bounces-904-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3787D58B6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FB1DB207C8
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F803A28B
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vWxJVtsg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065C31A78;
	Tue, 24 Oct 2023 15:17:37 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BA4199A;
	Tue, 24 Oct 2023 08:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CjScRbjimPWolEjPv1iNmcYG5tuVKE74LVx0kYeqVqg=; b=vWxJVtsg7WAxV+31eW086kiVVz
	+Nfq4GNnO/goU36WX82JXeCpyz1NRsTtPu+wCbSUfXCIxDEs8V2oWVRggK16YBGzFFxeQ+OnMmZJx
	SKduHKqxOYaitZ5qSYpjaCC0mvbjdemJ7HST9R8ycAJWqs8qXQ/6cjIBtkPQnUeXcUewNThjp+aOB
	3aqMMgcdALK6mkVwT0lgVBdBJKtVLR6yPuBhyST5VM/0eclmOmMma1u7G/bGi/oWtm9qAcpwTa/tA
	rxS9YGk4y0z9idXXB4mRIJ5H2iWjMlEX9mJu2motC/v1mbTTHrodN2WdAL7T9Y+SC/cMdxPfwyp5P
	9dxgHRjw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34774 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJ9o-0004Pd-3B;
	Tue, 24 Oct 2023 16:17:25 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJ9q-00AqQI-F8; Tue, 24 Oct 2023 16:17:26 +0100
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Subject: [PATCH 15/39] LoongArch: Switch over to GENERIC_CPU_DEVICES
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ9q-00AqQI-F8@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:17:26 +0100

From: James Morse <james.morse@arm.com>

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

This allows topology_init() to be removed.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This is a subtle change. Originally:
- on boot, topology_init() would have marked present CPUs that
  io_master() is true for as hotplug-incapable.
- if a CPU is hotplugged that is an io_master(), it can later be
  hot-unplugged.

The new behaviour is that any CPU that io_master() is true for will
now always be marked as hotplug-incapable, thus even if it was
hotplugged, it can no longer be hot-unplugged.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Explain the change in behaviour in the patch description
   (highlighted by Jonathan Cameron - thanks.) Add note about
   initialisation order change.
---
 arch/loongarch/Kconfig           |  1 +
 arch/loongarch/kernel/topology.c | 29 ++---------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2bddd202470e..5bed51adc68c 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -72,6 +72,7 @@ config LOONGARCH
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_IOREMAP if !ARCH_IOREMAP
diff --git a/arch/loongarch/kernel/topology.c b/arch/loongarch/kernel/topology.c
index 3fd166006698..bf58351beac1 100644
--- a/arch/loongarch/kernel/topology.c
+++ b/arch/loongarch/kernel/topology.c
@@ -10,20 +10,13 @@
 
 #include <acpi/processor.h>
 
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
-
 #ifdef CONFIG_HOTPLUG_CPU
 int arch_register_cpu(int cpu)
 {
-	int ret;
 	struct cpu *c = &per_cpu(cpu_devices, cpu);
 
-	c->hotpluggable = 1;
-	ret = register_cpu(c, cpu);
-	if (ret < 0)
-		pr_warn("register_cpu %d failed (%d)\n", cpu, ret);
-
-	return ret;
+	c->hotpluggable = !io_master(cpu);
+	return register_cpu(c, cpu);
 }
 EXPORT_SYMBOL(arch_register_cpu);
 
@@ -36,21 +29,3 @@ void arch_unregister_cpu(int cpu)
 }
 EXPORT_SYMBOL(arch_unregister_cpu);
 #endif
-
-static int __init topology_init(void)
-{
-	int i, ret;
-
-	for_each_present_cpu(i) {
-		struct cpu *c = &per_cpu(cpu_devices, i);
-
-		c->hotpluggable = !io_master(i);
-		ret = register_cpu(c, i);
-		if (ret < 0)
-			pr_warn("topology_init: register_cpu %d failed (%d)\n", i, ret);
-	}
-
-	return 0;
-}
-
-subsys_initcall(topology_init);
-- 
2.30.2


