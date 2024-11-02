Return-Path: <linux-acpi+bounces-9259-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 629B79B9C85
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 04:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCE351F21D16
	for <lists+linux-acpi@lfdr.de>; Sat,  2 Nov 2024 03:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4E54738;
	Sat,  2 Nov 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iaj0x7uy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C94F1DFE4;
	Sat,  2 Nov 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730517845; cv=none; b=aoOVamDBN6uYmbf4T0+bBGqeeIngkRo44gJ9xDPIP43PF/yEu+fxPIY+I9B8wNSom9g/uoDGW1/87c82ht7um7U9Amqfzasc9M2IDNcs6xj5/jB99nWs4lvxPBT+ShH1vkB2+U70F2T7OQu9iUQ215nQbJGL5k/r3cPnOAP1/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730517845; c=relaxed/simple;
	bh=n8Vv+Z6+NIqGCZw5suI3S/XCZD0NN/HIjS04JYWvY3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdIAHhle18tn8ZFREpVuE+TVmmEfCS+odIWZ3mkDiHt0NGKhk4gwTbpTqLn594JISX6BlRfdrw2OIL3Tenv9evdCn7AFfDW7rx8N5r3AdlXTsNJkYwjHCJoByzmGJ0nWUKbSSb+DAN9gsp6SiOo1lqT97M2Fb5fp3kBZBeO8INo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iaj0x7uy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5985EC4CEC3;
	Sat,  2 Nov 2024 03:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730517844;
	bh=n8Vv+Z6+NIqGCZw5suI3S/XCZD0NN/HIjS04JYWvY3g=;
	h=From:To:Cc:Subject:Date:From;
	b=iaj0x7uy2+inhHIfFx43iqUx1d0sMjniYkb855EyYPYcfPIWGo9G22gysbaGNPIH/
	 niWmdsEvYw7a2cw9Xg8UH6LK8izbSoAeilyyWYZ7OHS7eBWmxUSp/si1pT9XKNMr5C
	 ydo17CWaRPo4DZ2xTf5ClLSvdV5f/fxYUIq1ubIF9ZY0CZBXZJGjuuMxTeHOt/Qscb
	 nKnAmTXD8YtckIaxJXLNu99nGlQCcZt8BvpFbzlSibnGBZRGi/6eLs5FwZ4thjenbl
	 ObOrlpw4KLJOjjooAPjVEjLmrOYcV1QVX25aRQDDoplqpzIZVd79XnTFsqLAmlHS7j
	 HMi5yWhLCVBSA==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H . Peter Anvin" <hpa@zytor.com>,
	Len Brown <lenb@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	Ivan Shapovalov <intelfx@intelfx.name>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v2] ACPI: processor: Move arch_init_invariance_cppc() call later
Date: Fri,  1 Nov 2024 22:23:53 -0500
Message-ID: <20241102032353.2372544-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

arch_init_invariance_cppc() is called at the end of
acpi_cppc_processor_probe() in order to configure frequency invariance
based upon the values from _CPC.

This however doesn't work on AMD CPPC shared memory designs that have
AMD preferred cores enabled because _CPC needs to be analyzed from all
cores to judge if preferred cores are enabled.

This issue manifests to users as a warning since commit 21fb59ab4b97
("ACPI: CPPC: Adjust debug messages in amd_set_max_freq_ratio() to warn"):
```
Could not retrieve highest performance (-19)
```

However the warning isn't the cause of this, it was actually
commit 279f838a61f9 ("x86/amd: Detect preferred cores in
amd_get_boost_ratio_numerator()") which exposed the issue.

To fix this problem, push the call to the arch_init_invariance_cppc()
macro to the end of acpi_processor_driver_init().

Fixes: 279f838a61f9 ("x86/amd: Detect preferred cores in amd_get_boost_ratio_numerator()")
Reported-by: Ivan Shapovalov <intelfx@intelfx.name>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219431
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Fix LKP robot issue when CONFIG_ACPI_CPPC_LIB not defined
---
 arch/x86/include/asm/topology.h | 2 ++
 drivers/acpi/cppc_acpi.c        | 6 ------
 drivers/acpi/processor_driver.c | 1 +
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index abe3a8f22cbd..b04c5db7e945 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -295,6 +295,8 @@ extern void arch_scale_freq_tick(void);
 #ifdef CONFIG_ACPI_CPPC_LIB
 void init_freq_invariance_cppc(void);
 #define arch_init_invariance_cppc init_freq_invariance_cppc
+#else
+static inline void arch_init_invariance_cppc(void) { }
 #endif
 
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index ed91dfd4fdca..9d48cd706659 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -671,10 +671,6 @@ static int pcc_data_alloc(int pcc_ss_id)
  *  )
  */
 
-#ifndef arch_init_invariance_cppc
-static inline void arch_init_invariance_cppc(void) { }
-#endif
-
 /**
  * acpi_cppc_processor_probe - Search for per CPU _CPC objects.
  * @pr: Ptr to acpi_processor containing this CPU's logical ID.
@@ -905,8 +901,6 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 		goto out_free;
 	}
 
-	arch_init_invariance_cppc();
-
 	kfree(output.pointer);
 	return 0;
 
diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_driver.c
index cb52dd000b95..59620e7bc664 100644
--- a/drivers/acpi/processor_driver.c
+++ b/drivers/acpi/processor_driver.c
@@ -270,6 +270,7 @@ static int __init acpi_processor_driver_init(void)
 				  NULL, acpi_soft_cpu_dead);
 
 	acpi_processor_throttling_init();
+	arch_init_invariance_cppc();
 	return 0;
 err:
 	driver_unregister(&acpi_processor_driver);
-- 
2.43.0


