Return-Path: <linux-acpi+bounces-105-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 825907ADD3A
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 337EC281E5D
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8FF1D691
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Sep 2023 16:32:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889A5219FA
	for <linux-acpi@vger.kernel.org>; Mon, 25 Sep 2023 16:28:49 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7989AFC;
	Mon, 25 Sep 2023 09:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qjYxvP0mrwNQum3AINuFgWcLiPmukjSCAlOcMPWNC70=; b=H7LRzpeszu/NjlEcIS+36zsQZ6
	1B2GjUbmFECUohpWGtvulUpk25WC7XKYTRHHT/Eml4mDxX0AMEEVJ060wH21PeS3gfykNAY0NM0X4
	+GWdzx+YKVVo1kbovXqnfBMQBs1dqZfTnGZ7fo2JV+E0m3nna6kCsI5T89nijgI58vuJn5P29+V4C
	TXReirRZWjAEDIygIzmuA0o2B8fguAE2q+5Iicf9b35Wzovei5lcs3hzooqVcv2w+BQzFB8kmlAql
	ls3/NA9AIJUS/9j4ONw4bjJEaiyshFeUbtMhnMk82oY4iHK+oHm6dodVie7aPbYAkW55ITbJCUDoG
	wexoGNlg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56656 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qkoRq-0001Ke-1k;
	Mon, 25 Sep 2023 17:28:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qkoRr-0088Q8-Da; Mon, 25 Sep 2023 17:28:39 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org, James Morse <james.morse@arm.com>,
	loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	jianyong.wu@arm.com, justin.he@arm.com,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Salil Mehta <salil.mehta@huawei.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-ia64@vger.kernel.org
Subject: [PATCH] cpu-hotplug: provide prototypes for arch CPU registration
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qkoRr-0088Q8-Da@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Mon, 25 Sep 2023 17:28:39 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Provide common prototypes for arch_register_cpu() and
arch_unregister_cpu(). These are called by acpi_processor.c, with
weak versions, so the prototype for this is already set. It is
generally not necessary for function prototypes to be conditional
on preprocessor macros.

Some architectures (e.g. Loongarch) are missing the prototype for this,
and rather than add it to Loongarch's asm/cpu.h, lets do the job once
for everyone.

Since this covers everyone, remove the now unnecessary prototypes in
asm/cpu.h, and we also need to remove the 'static' from one of ia64's
arch_register_cpu() definitions.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC v2:
 - drop ia64 changes, as ia64 has already been removed.

 arch/x86/include/asm/cpu.h  | 2 --
 arch/x86/kernel/topology.c  | 2 +-
 include/linux/cpu.h         | 2 ++
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 3a233ebff712..25050d953eee 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -28,8 +28,6 @@ struct x86_cpu {
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
-extern int arch_register_cpu(int num);
-extern void arch_unregister_cpu(int);
 extern void soft_restart_cpu(void);
 #endif
 
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index ca004e2e4469..0bab03130033 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -54,7 +54,7 @@ void arch_unregister_cpu(int num)
 EXPORT_SYMBOL(arch_unregister_cpu);
 #else /* CONFIG_HOTPLUG_CPU */
 
-static int __init arch_register_cpu(int num)
+int __init arch_register_cpu(int num)
 {
 	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
 }
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 0abd60a7987b..eb768a866fe3 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -80,6 +80,8 @@ extern __printf(4, 5)
 struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
+extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
-- 
2.30.2


