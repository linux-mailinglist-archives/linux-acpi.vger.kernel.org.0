Return-Path: <linux-acpi+bounces-9191-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B359B7999
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 12:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4818A1C21651
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Oct 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1594819C54F;
	Thu, 31 Oct 2024 11:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OEfhFKXb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5919B586
	for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 11:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730373666; cv=none; b=tP2M5cfcvV3nkeCNR2atdcPuWjAW8e6qhWrSlLXlKZ4IsiF04gCk6qYsqe7BfE/58Wpsu/OgFfqclx2+W7GuWXOMJpMowGeP0gZPccrh0djSuLFCWOMMUx34vqw5ofp5AvGAx9bnaZ5cY8eqbcfwxpf+K+W5xhK262TiN4nWcV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730373666; c=relaxed/simple;
	bh=Bs6tqblL7e2KLhnwDDEV072pjAp0SU1jfjcJDBlSE4A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EYebGlNCoUPY9/6dG10qlishjDmMo2Rsjg8wehZLbUHkqdOrth37C08OLFk8NGD4glGCV5n+eejF/WqWF94p3ezR/cr5Jls/h8BMmGX4YgbCkk8YG2uxCnRxU+gERZKcI/djZ44gxsJCqjA2xm8STnTJNj05NIv75lBtYxIcgHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OEfhFKXb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20b5affde14so6649245ad.3
        for <linux-acpi@vger.kernel.org>; Thu, 31 Oct 2024 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730373663; x=1730978463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SgD3pKPtdFzcz4t1a0u04lcW4uB7d9j6oqT5niate0A=;
        b=OEfhFKXbpBEDhBEE0uLRjHKVolvNJE6q+zzkGhIZZKlDvIKtUEbXbNqunDyorCdA9g
         gNCqvDBFRVYcQVITogA6Urt2wUXVAMCW+8ptAIUNP2b4I8/ymNhOxT5WkpUlEWbOV4My
         R1bAKgtDFnh4Vk6Y6NZ+LL5YN8Chv4R4QGAcQrOs45UCN8NIGbApXWpPaGQtmqAgTPEJ
         h9Ue4t82eVZW0RPceCFtiCG8VOj8FUgm7kxE6PZNcThfDJs3jevWo7OvjzAhnfE6DmvC
         e2brnRkKgIOFf6+sVs9Kc0h6W+w9HHtUjogEcA3OYnRXitXfY0bQggVCG39Loq25bnDJ
         b4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730373663; x=1730978463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SgD3pKPtdFzcz4t1a0u04lcW4uB7d9j6oqT5niate0A=;
        b=TGJHIEY8NySv5XZOP8UtEAe3c4rKOkyScrAFsGC4xjG8RoX0BAqpGJjBlsgDdTGJ58
         BvTkwng68isNB3kh82iO0IiPNO9DhTIq/lWjfeNIYd8FeeRJrZ8Kd+hUek1oE5umN6uX
         eneMIeNEdletKNwkP8Vx94CjGlvfmwaIeUeOwoTO6Z5taey9ko/LzhYY8QV1azMvSmdC
         3BbjKJeaSlxeNRlSKgvsnV7hu9JVf7ThR9cxu3szCDx3bIajWfK8zwdISGvGtrw6A09r
         MlR+SmMJa0LKJD9nF5QZRA7LqFvX9MLqLs3z8c3qj/VbY0FEdAIQPubSoYbpAiFmp893
         Ee4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4GTU/HYHKPv6fafPd5hnRX1acSCMjkmOEVU/7+OGB0UTS33TyUx39gl12Dt08kvmZMWr5bY9OFJhT@vger.kernel.org
X-Gm-Message-State: AOJu0YxE8BSmE2aUCX8o2IOhqPq83OPAgMjtCnPHAmo67hbWzzanaEhA
	QRY208X3/RTrihgFnidc+sEoD7uhmmv61RurPuGTwufds69R5Hi1ZX37vx90qNc=
X-Google-Smtp-Source: AGHT+IF6rCp8uA7CIfzXSTYHLrzQK+lu+COWzmT52riKYUQh7Yt9+TYvl4AYGhI2GgQcWukgSatRcQ==
X-Received: by 2002:a17:902:da82:b0:20c:cccd:17a3 with SMTP id d9443c01a7336-210c6c346a9mr224734955ad.46.1730373662606;
        Thu, 31 Oct 2024 04:21:02 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056efd01sm7513455ad.52.2024.10.31.04.20.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 31 Oct 2024 04:21:02 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: punit.agrawal@bytedance.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	rafael@kernel.org,
	lenb@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	sudeep.holla@arm.com,
	guohanjun@huawei.com,
	prarit@redhat.com,
	gshan@redhat.com,
	cuiyunhui@bytedance.com,
	dwmw@amazon.co.uk,
	Jonathan.Cameron@huawei.com,
	liuwei09@cestc.cn,
	maobibo@loongson.cn,
	sunilvl@ventanamicro.com,
	alexghiti@rivosinc.com,
	haibo1.xu@intel.com,
	jeeheng.sia@starfivetech.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: fix the warning reported by the sparse
Date: Thu, 31 Oct 2024 19:20:30 +0800
Message-Id: <20241031112030.72647-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All architectures use early_memremap() instead of early_ioremap().
Therefore, to solve the warning detected by sparse:
../arch/riscv/kernel/acpi.c:213:30: warning: incorrect type in return expression (different address spaces)
../arch/riscv/kernel/acpi.c:213:30:    expected void [noderef] __iomem *
../arch/riscv/kernel/acpi.c:213:30:    got void *
../arch/riscv/kernel/acpi.c:221:24: warning: incorrect type in argument 1 (different address spaces)
../arch/riscv/kernel/acpi.c:221:24:    expected void *addr
../arch/riscv/kernel/acpi.c:221:24:    got void [noderef] __iomem *map
The __iomem attribute of __acpi_map_table() is removed.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/kernel/acpi.c     | 6 +++---
 arch/loongarch/kernel/acpi.c | 2 +-
 arch/riscv/kernel/acpi.c     | 6 +++---
 arch/x86/kernel/acpi/boot.c  | 2 +-
 drivers/acpi/osl.c           | 2 +-
 include/linux/acpi.h         | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index e6f66491fbe9..69017dadb82d 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -88,10 +88,10 @@ static bool __init dt_is_stub(void)
 }
 
 /*
- * __acpi_map_table() will be called before page_init(), so early_ioremap()
- * or early_memremap() should be called here to for ACPI table mapping.
+ * __acpi_map_table() will be called before page_init(), so early_memremap()
+ * should be called here to for ACPI table mapping.
  */
-void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+void __init *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 	if (!size)
 		return NULL;
diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index f1a74b80f22c..a29c1d86e274 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -34,7 +34,7 @@ u64 acpi_saved_sp;
 
 struct acpi_madt_core_pic acpi_core_pic[MAX_CORE_PIC];
 
-void __init __iomem * __acpi_map_table(unsigned long phys, unsigned long size)
+void __init *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 
 	if (!phys || !size)
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index 2fd29695a788..861ab56962a2 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -202,10 +202,10 @@ struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
 }
 
 /*
- * __acpi_map_table() will be called before paging_init(), so early_ioremap()
- * or early_memremap() should be called here to for ACPI table mapping.
+ * __acpi_map_table() will be called before paging_init(), so early_memremap()
+ * should be called here to for ACPI table mapping.
  */
-void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+void __init *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 	if (!size)
 		return NULL;
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3a44a9dc3fb7..e1ed297552e7 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -105,7 +105,7 @@ static u32 isa_irq_to_gsi[NR_IRQS_LEGACY] __read_mostly = {
  * This is just a simple wrapper around early_memremap(),
  * with sanity checks for phys == 0 and size == 0.
  */
-void __init __iomem *__acpi_map_table(unsigned long phys, unsigned long size)
+void __init *__acpi_map_table(unsigned long phys, unsigned long size)
 {
 
 	if (!phys || !size)
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 70af3fbbebe5..a36486b59bca 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -334,7 +334,7 @@ void __iomem __ref
 	}
 
 	if (!acpi_permanent_mmap)
-		return __acpi_map_table((unsigned long)phys, size);
+		return (void __iomem __force *)__acpi_map_table((unsigned long)phys, size);
 
 	mutex_lock(&acpi_ioremap_lock);
 	/* Check if there's a suitable mapping already. */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d5ee84c468b..d4627d96c13b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -207,7 +207,7 @@ static inline int acpi_debugger_notify_command_complete(void)
 		(!entry) || (unsigned long)entry + sizeof(*entry) > end ||  \
 		((struct acpi_subtable_header *)entry)->length < sizeof(*entry))
 
-void __iomem *__acpi_map_table(unsigned long phys, unsigned long size);
+void *__acpi_map_table(unsigned long phys, unsigned long size);
 void __acpi_unmap_table(void __iomem *map, unsigned long size);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
-- 
2.39.2


