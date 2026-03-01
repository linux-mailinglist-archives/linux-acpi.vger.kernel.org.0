Return-Path: <linux-acpi+bounces-21284-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG8rGTzJo2nCMwUAu9opvQ
	(envelope-from <linux-acpi+bounces-21284-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 06:06:04 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 019CD1CE8B4
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 06:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20C2D3028350
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 05:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2872E2DB7AA;
	Sun,  1 Mar 2026 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Uu1Jqflt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AE430B85;
	Sun,  1 Mar 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772341527; cv=none; b=sc4q8B8bSC1eR7tqhacQlVFQh3e1rLS2GdlV75+LZaJ2Z5a7OUKP2o9VY/Z2UOgjJOJOqFpqfuIfWo3Yhb2+qhgPfjA2j8QjTylFrqvIyXwP4Vvf5Ugeu/E1A4Q22WgKmWyKNpLKecBvAeEbcO2CQdMWi1EaRq13Yl5BZ6o3+20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772341527; c=relaxed/simple;
	bh=rvHrP6Di0kQksEvkqN9Eoa/hcq+PP3brdbNAyb3Yrko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoxzQULMgKMTNovOAoS8tBQGgc+2cjLRPhc9f5oP194gNi4lOkX8I0H6Fov0sQwoD4Jctt8dPYckkzSGOi8oCGkZckNj5H+JfblyAXvj6huEJtQpcvmt2ihCbOUOWAzCYHll3HWmUZOO5GjDZdljiwq9v5d8nmFWwLX3ua6ouoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Uu1Jqflt; arc=none smtp.client-ip=115.124.28.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1772341513; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SFpcUIXx01ZGlwnpBVQVkRWDa9Cd9NU6zqr8TW1EqPE=;
	b=Uu1JqfltM7uYisLLR6Kew+FYcImGXwJEnef1DX5G2sWvHoZe0ipfId3q6FM9qhWGw2dYbcZkYS+VI3NyluBUD9vtJkuLYXnHLjoUfk3gQ/QCBuF2Myy1T3gc195nT36LTZorpizHASjzjBUeYTzfFPlSz8H/Tr/hbFF+0ee+85E=
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.ghlarAT_1772341512 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 01 Mar 2026 13:05:13 +0800
From: Hou Wenlong <houwenlong.hwl@antgroup.com>
To: linux-kernel@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-acpi@vger.kernel.org
Subject: [PATCH 2/2] ACPI, x86/boot: Remove {set|get}_root_pointer() ACPI callbacks
Date: Sun,  1 Mar 2026 13:04:53 +0800
Message-Id: <b5d7f0734005eb08f31e7b9b72e253efcd2614ab.1772282441.git.houwenlong.hwl@antgroup.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <76675c4d49d3a8f72252076812ef8f22276230c2.1772282441.git.houwenlong.hwl@antgroup.com>
References: <76675c4d49d3a8f72252076812ef8f22276230c2.1772282441.git.houwenlong.hwl@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[antgroup.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[antgroup.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21284-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houwenlong.hwl@antgroup.com,linux-acpi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[antgroup.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[antgroup.com:mid,antgroup.com:dkim,antgroup.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 019CD1CE8B4
X-Rspamd-Action: no action

After removing pvh_get_root_pointer(), the only get_root_pointer() ACPI
callback is x86_default_get_root_pointer(). Move the implementation
directly into acpi_arch_get_root_pointer() and remove the
get_root_pointer() ACPI callback. Since the set_root_pointer() ACPI
callback is also only x86_default_set_root_pointer(), remove it as well.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
---
 arch/x86/include/asm/acpi.h     | 15 +++------------
 arch/x86/include/asm/x86_init.h |  4 ----
 arch/x86/kernel/acpi/boot.c     | 10 ----------
 arch/x86/kernel/x86_init.c      |  2 --
 4 files changed, 3 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..1286e044c623 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -17,6 +17,7 @@
 #include <asm/cpufeature.h>
 #include <asm/irq_vectors.h>
 #include <asm/xen/hypervisor.h>
+#include <asm/setup.h>
 
 #include <xen/xen.h>
 
@@ -160,20 +161,17 @@ static inline bool acpi_has_cpu_in_madt(void)
 #define ACPI_HAVE_ARCH_SET_ROOT_POINTER
 static __always_inline void acpi_arch_set_root_pointer(u64 addr)
 {
-	x86_init.acpi.set_root_pointer(addr);
+	boot_params.acpi_rsdp_addr = addr;
 }
 
 #define ACPI_HAVE_ARCH_GET_ROOT_POINTER
 static __always_inline u64 acpi_arch_get_root_pointer(void)
 {
-	return x86_init.acpi.get_root_pointer();
+	return boot_params.acpi_rsdp_addr;
 }
 
 void acpi_generic_reduced_hw_init(void);
 
-void x86_default_set_root_pointer(u64 addr);
-u64 x86_default_get_root_pointer(void);
-
 #ifdef CONFIG_XEN_PV
 /* A Xen PV domain needs a special acpi_os_ioremap() handling. */
 extern void __iomem * (*acpi_os_ioremap)(acpi_physical_address phys,
@@ -193,13 +191,6 @@ static inline void disable_acpi(void) { }
 
 static inline void acpi_generic_reduced_hw_init(void) { }
 
-static inline void x86_default_set_root_pointer(u64 addr) { }
-
-static inline u64 x86_default_get_root_pointer(void)
-{
-	return 0;
-}
-
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6c8a6ead84f6..254221eec395 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -132,13 +132,9 @@ struct x86_hyper_init {
 
 /**
  * struct x86_init_acpi - x86 ACPI init functions
- * @set_root_pointer:		set RSDP address
- * @get_root_pointer:		get RSDP address
  * @reduced_hw_early_init:	hardware reduced platform early init
  */
 struct x86_init_acpi {
-	void (*set_root_pointer)(u64 addr);
-	u64 (*get_root_pointer)(void);
 	void (*reduced_hw_early_init)(void);
 };
 
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index a3f2fb1fea1b..6365a75d9e1c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1828,16 +1828,6 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__update_table_print();
 }
 
-void x86_default_set_root_pointer(u64 addr)
-{
-	boot_params.acpi_rsdp_addr = addr;
-}
-
-u64 x86_default_get_root_pointer(void)
-{
-	return boot_params.acpi_rsdp_addr;
-}
-
 #ifdef CONFIG_XEN_PV
 void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 {
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ebefb77c37bb..4a1a70366b71 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -121,8 +121,6 @@ struct x86_init_ops x86_init __initdata = {
 	},
 
 	.acpi = {
-		.set_root_pointer	= x86_default_set_root_pointer,
-		.get_root_pointer	= x86_default_get_root_pointer,
 		.reduced_hw_early_init	= acpi_generic_reduced_hw_init,
 	},
 };
-- 
2.31.1


