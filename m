Return-Path: <linux-acpi+bounces-905-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCA87D58B7
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 18:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 074A9280FA3
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55F53A279
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ajV8p/zu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EE30CE1;
	Tue, 24 Oct 2023 15:17:39 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242B319AC;
	Tue, 24 Oct 2023 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dh+jsR2oRY9sfsyFdktS9+0lX1Q0KghWkOaQMlI8IM4=; b=ajV8p/zuaO4aFqKEKamK+Dmcjd
	D8dgFtK5CysBQTIRIT+StQp57SggyUn6aHwE8gxkjqbOVv2DN7V+g6cCBb29f49yYcE2sSNMAvdlM
	lBfEOjlCvUAw/SSFrfSvOcE/nkNhteQW47quKJAt3Q2ppKyJhebTCChzAMw1BvjIz/uqr9Me7rc6C
	OXbLGj8ibVTQmatNPB3Pj0XCQXtsSPFsSR63KTKTYkIvrHYeZfaV06kJmK7coNq0IKdUkZZ9Flhzu
	FDbmwzv2Tao+LIqjKL5NSNWP/h8P1jDEEMa+HsaduZXnnZ48PYBjuJMF0bkglF5/HJPcoZr36Qlq8
	jFJGEFKA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:34776 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qvJ9w-0004Q6-3B;
	Tue, 24 Oct 2023 16:17:33 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qvJ9v-00AqQO-K9; Tue, 24 Oct 2023 16:17:31 +0100
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
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH 16/39] riscv: Switch over to GENERIC_CPU_DEVICES
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ9v-00AqQO-K9@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Oct 2023 16:17:31 +0100

From: James Morse <james.morse@arm.com>

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

This allows topology_init() to be removed.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 * Add note about initialisation order change.
---
 arch/riscv/Kconfig        |  1 +
 arch/riscv/kernel/setup.c | 19 ++++---------------
 2 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d607ab0f7c6d..eeb80fb55acc 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -69,6 +69,7 @@ config RISCV
 	select GENERIC_ARCH_TOPOLOGY
 	select GENERIC_ATOMIC64 if !64BIT
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select GENERIC_CPU_DEVICES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
 	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index aac853ae4eb7..311e99741cf8 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -62,7 +62,6 @@ atomic_t hart_lottery __section(".sdata")
 #endif
 ;
 unsigned long boot_cpu_hartid;
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
 /*
  * Place kernel memory regions on the resource tree so that
@@ -307,23 +306,13 @@ void __init setup_arch(char **cmdline_p)
 	riscv_set_dma_cache_alignment();
 }
 
-static int __init topology_init(void)
+int arch_register_cpu(int cpu)
 {
-	int i, ret;
+	struct cpu *c = &per_cpu(cpu_devices, cpu);
 
-	for_each_possible_cpu(i) {
-		struct cpu *cpu = &per_cpu(cpu_devices, i);
-
-		cpu->hotpluggable = cpu_has_hotplug(i);
-		ret = register_cpu(cpu, i);
-		if (unlikely(ret))
-			pr_warn("Warning: %s: register_cpu %d failed (%d)\n",
-			       __func__, i, ret);
-	}
-
-	return 0;
+	c->hotpluggable = cpu_has_hotplug(cpu);
+	return register_cpu(c, cpu);
 }
-subsys_initcall(topology_init);
 
 void free_initmem(void)
 {
-- 
2.30.2


