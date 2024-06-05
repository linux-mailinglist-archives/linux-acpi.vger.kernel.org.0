Return-Path: <linux-acpi+bounces-6199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391638FCF89
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 15:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7853D28DF73
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jun 2024 13:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A711953A6;
	Wed,  5 Jun 2024 13:15:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0B6195398
	for <linux-acpi@vger.kernel.org>; Wed,  5 Jun 2024 13:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717593306; cv=none; b=hBpDJ8CxYFbqOsuWxpYz9ytWw++Un/G/kE2jB24YFOYKrHcCEyfk4PBbQ0/eMmWSrcD50L266SezjCJbJQ4J1Hoo6Wsbziw5AWdjUR3NqKl5aq7oDebrIBGTYpOmrZsXA2MezcPk5BpVGS1F66i+mN0IrgNTA1dDn8R8lhGXrQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717593306; c=relaxed/simple;
	bh=142wZHmhE6JHoNfDIx8Ya5UC8dYp9/ml6HPYR2HM7uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gQSJn++A9JZ1K/AQImiXRBoZtFwFi6WfwrxSFccTy1AIyC2fpyxZSw685rNTwAcNomwFn0pdcNIY+TxKZaWKpBZp0GLdwAJ1F4DC8q0wOU6mFdImAw2+wACDfmO36G4aqB50oLJjc5DGRhk0xjwf7ADLrgj1h0M2MfkjV81ngWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDFCC1063;
	Wed,  5 Jun 2024 06:15:28 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8D6A83F792;
	Wed,  5 Jun 2024 06:15:03 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH 2/3] arm64: cpuidle: Move ACPI specific code into drivers/acpi/arm64/
Date: Wed,  5 Jun 2024 14:14:57 +0100
Message-ID: <20240605131458.3341095-3-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605131458.3341095-1-sudeep.holla@arm.com>
References: <20240605131458.3341095-1-sudeep.holla@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI cpuidle LPI FFH code can be moved out of arm64 arch code as
it just uses SMCCC. Move all the ACPI cpuidle LPI FFH code into
drivers/acpi/arm64/cpuidle.c

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/Makefile                          | 1 -
 drivers/acpi/arm64/Makefile                         | 1 +
 {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c | 4 ----
 3 files changed, 1 insertion(+), 5 deletions(-)
 rename {arch/arm64/kernel => drivers/acpi/arm64}/cpuidle.c (97%)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 763824963ed1..2b112f3b7510 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
-obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
 obj-$(CONFIG_JUMP_LABEL)		+= jump_label.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
 obj-$(CONFIG_EFI)			+= efi.o efi-rt-wrapper.o
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 7d7fd6512bca..2efee23f00b4 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
+obj-$(CONFIG_ACPI_PROCESSOR_IDLE) += cpuidle.o
 obj-$(CONFIG_ARM_AMBA)		+= amba.o
 obj-y				+= dma.o init.o
 obj-y				+= thermal_cpufreq.o
diff --git a/arch/arm64/kernel/cpuidle.c b/drivers/acpi/arm64/cpuidle.c
similarity index 97%
rename from arch/arm64/kernel/cpuidle.c
rename to drivers/acpi/arm64/cpuidle.c
index f372295207fb..801f9c450142 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/drivers/acpi/arm64/cpuidle.c
@@ -10,9 +10,6 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu_pm.h>
 #include <linux/psci.h>
-
-#ifdef CONFIG_ACPI_PROCESSOR_IDLE
-
 #include <acpi/processor.h>
 
 #define ARM64_LPI_IS_RETENTION_STATE(arch_flags) (!(arch_flags))
@@ -71,4 +68,3 @@ __cpuidle int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 		return CPU_PM_CPU_IDLE_ENTER_PARAM_RCU(psci_cpu_suspend_enter,
 					     lpi->index, state);
 }
-#endif
-- 
2.45.2


