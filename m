Return-Path: <linux-acpi+bounces-16565-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9707B51298
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91739465790
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A8314A7C;
	Wed, 10 Sep 2025 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ehgkz+qQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED062313547;
	Wed, 10 Sep 2025 09:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496860; cv=none; b=LERKrxqJRC52MpuinMpDAGqeS/g1LyWdvsyYwL9xHRjv5gKu8UbeWfguX0f1sDSPjflFLwoMa+qHHpDwRMPirZX6DzQiopRDHY4/b8jrIDkPUERCf3ktSytaPXWG6sOoIw0gbBYPt3CsTg6dyJfYEJ4FtqZUUm/usH67PpmtFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496860; c=relaxed/simple;
	bh=vb7ysZHJXr577SA49vAnSzIHlezKX5EJr+tN8E4GHQk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSqt2aUuv5XUIcrq0kYEc6Gcgf/sz4n+6AzfaxBKhtXyzkFCRF6wUdUaMZXZkd2n/KRObxQdT+RAM4+ZzaEjvKgjovScl3u9+pGl0vQ0qlZhpRQ3LjgvWLZYAaHP4vyeTyISTU7QoZbNFAi9XMNDnk2CqPOGOX/nyxD7yR9rPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ehgkz+qQ; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5iaWrlk2P/qazoj+ucrjuJcazBZzpbTMnF2UzUvRWzk=;
	b=ehgkz+qQ5zGXoB2Nb0SoBssgqv9IidQV8HS+xmYyLDrI3LMzXxyzTnvHmaFKIBy7qfrJNrCsn7qRKYrA1z15cC29ePYkYZqRLayQJHizvvNzhefPQ7J4pj3SGAgj4w/iUY5BiqN/DSpPhwoLi/Qj4rZ9Zea6bOQ8G2PJ09u6mOo=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnhXsbO_1757496846 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:34:08 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: xueshuai@linux.alibaba.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: james.morse@arm.com,
	tony.luck@intel.com,
	cleger@rivosinc.com,
	hchauhan@ventanamicro.com,
	tianruidong@linux.alibaba.com
Subject: [RFC PATCH 4/5] riscv: Introduce HEST HEE notification handlers for APEI
Date: Wed, 10 Sep 2025 17:33:46 +0800
Message-Id: <20250910093347.75822-5-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
References: <20250910093347.75822-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to register a ghes entry with HEE, allowing the OS
to receive hardware error notifications from firmware through
standardized ACPI interfaces.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 arch/riscv/Kconfig              |  1 +
 arch/riscv/include/asm/fixmap.h |  6 ++++
 drivers/acpi/apei/Kconfig       | 12 +++++++
 drivers/acpi/apei/ghes.c        | 58 +++++++++++++++++++++++++++++++++
 include/acpi/ghes.h             |  6 ++++
 5 files changed, 83 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a0659e..b085e172b355 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+	select HAVE_ACPI_APEI if (ACPI && EFI)
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 0a55099bb734..07421edc9daa 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -38,6 +38,12 @@ enum fixed_addresses {
 	FIX_TEXT_POKE0,
 	FIX_EARLYCON_MEM_BASE,
 
+#ifdef CONFIG_ACPI_APEI_HEE
+	/* Used for GHES mapping from assorted contexts */
+	FIX_APEI_GHES_IRQ,
+	FIX_APEI_GHES_HEE,
+#endif /* CONFIG_ACPI_APEI_GHES */
+
 	__end_of_permanent_fixed_addresses,
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index 070c07d68dfb..d54a295cfc8d 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -46,6 +46,18 @@ config ACPI_APEI_SEA
 	depends on ARM64 && ACPI_APEI_GHES
 	default y
 
+config ACPI_APEI_HEE
+	bool "APEI Hardware Error Exception support"
+	depends on RISCV && ACPI_APEI_GHES
+	default y
+	help
+	  Enable support for RISC-V Hardware Error Exception (HEE) notification
+	  in ACPI Platform Error Interface (APEI). This allows firmware
+	  to report hardware errors through RISC-V exception mechanism.
+
+	  Say Y if you want to support firmware-first error handling
+	  on RISC-V platforms with ACPI.
+
 config ACPI_APEI_MEMORY_FAILURE
 	bool "APEI memory error recovering support"
 	depends on ACPI_APEI && MEMORY_FAILURE
diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a0d54993edb3..1011e28091dc 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -97,6 +97,11 @@
 #define FIX_APEI_GHES_SDEI_CRITICAL	__end_of_fixed_addresses
 #endif
 
+#if !defined(CONFIG_X86) && !defined(CONFIG_ARM64)
+#define FIX_APEI_GHES_NMI		__end_of_fixed_addresses
+#define FIX_APEI_GHES_SEA		__end_of_fixed_addresses
+#endif
+
 static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
 
 static inline bool is_hest_type_generic_v2(struct ghes *ghes)
@@ -1415,6 +1420,45 @@ static inline void ghes_sea_add(struct ghes *ghes) { }
 static inline void ghes_sea_remove(struct ghes *ghes) { }
 #endif /* CONFIG_ACPI_APEI_SEA */
 
+#ifdef CONFIG_ACPI_APEI_HEE
+static LIST_HEAD(ghes_hee);
+
+/*
+ * Return 0 only if one of the HEE error sources successfully reported an error
+ * record sent from the firmware.
+ */
+int ghes_notify_hee(void)
+{
+	static DEFINE_RAW_SPINLOCK(ghes_notify_lock_hee);
+	int rv;
+
+	raw_spin_lock(&ghes_notify_lock_hee);
+	rv = ghes_in_nmi_spool_from_list(&ghes_hee, FIX_APEI_GHES_HEE);
+	raw_spin_unlock(&ghes_notify_lock_hee);
+
+	return rv;
+}
+EXPORT_SYMBOL_GPL(ghes_notify_hee);
+
+static void ghes_hee_add(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_add_rcu(&ghes->list, &ghes_hee);
+	mutex_unlock(&ghes_list_mutex);
+}
+
+static void ghes_hee_remove(struct ghes *ghes)
+{
+	mutex_lock(&ghes_list_mutex);
+	list_del_rcu(&ghes->list);
+	mutex_unlock(&ghes_list_mutex);
+	synchronize_rcu();
+}
+#else /* CONFIG_ACPI_APEI_HEE */
+static inline void ghes_hee_add(struct ghes *ghes) { }
+static inline void ghes_hee_remove(struct ghes *ghes) { }
+#endif /* CONFIG_ACPI_APEI_HEE */
+
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 /*
  * NMI may be triggered on any CPU, so ghes_in_nmi is used for
@@ -1558,6 +1602,14 @@ static int ghes_probe(struct platform_device *ghes_dev)
 			goto err;
 		}
 		break;
+	case ACPI_HEST_NOTIFY_HEE:
+		if (!IS_ENABLED(CONFIG_ACPI_APEI_HEE)) {
+			pr_warn(GHES_PFX "Generic hardware error source: %d notified via HEE is not supported\n",
+				generic->header.source_id);
+			rc = -ENOTSUPP;
+			goto err;
+		}
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
 			pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
@@ -1631,6 +1683,9 @@ static int ghes_probe(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_SEA:
 		ghes_sea_add(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_HEE:
+		ghes_hee_add(ghes);
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_add(ghes);
 		break;
@@ -1698,6 +1753,9 @@ static void ghes_remove(struct platform_device *ghes_dev)
 	case ACPI_HEST_NOTIFY_SEA:
 		ghes_sea_remove(ghes);
 		break;
+	case ACPI_HEST_NOTIFY_HEE:
+		ghes_hee_remove(ghes);
+		break;
 	case ACPI_HEST_NOTIFY_NMI:
 		ghes_nmi_remove(ghes);
 		break;
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index ebd21b05fe6e..8046e1b30c21 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -127,6 +127,12 @@ int ghes_notify_sea(void);
 static inline int ghes_notify_sea(void) { return -ENOENT; }
 #endif
 
+#ifdef CONFIG_ACPI_APEI_HEE
+int ghes_notify_hee(void);
+#else
+static inline int ghes_notify_hee(void) { return -ENOENT; }
+#endif
+
 struct notifier_block;
 extern void ghes_register_report_chain(struct notifier_block *nb);
 extern void ghes_unregister_report_chain(struct notifier_block *nb);
-- 
2.43.7


