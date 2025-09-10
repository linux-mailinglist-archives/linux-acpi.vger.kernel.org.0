Return-Path: <linux-acpi+bounces-16562-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E473B51291
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4EA01C27AC5
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269463148B4;
	Wed, 10 Sep 2025 09:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="PgcvKRnv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CB3128A4;
	Wed, 10 Sep 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496846; cv=none; b=pphwZZ7IOCjOL5Lmc5LXKlPD/0u2KzRJC1m/xU0+IKErfqi0vjq05Z2vIvBpiE449B2pgppOWmFfThKKtHe5IYXTLZTY3wuvdBSn2YQi6ZSvwikot2vr0rudRfsncHB+cRaObg61TqVrSz6fBCj7bwhvPn98522QzM/+y7kH8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496846; c=relaxed/simple;
	bh=jp6L8c0EHB1gymGU5flE9AdnVKMkvLGb58m6qWm61n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S8cw/6gZJ+o76i0TbEbr9e69FsIiCoGwbevLQYN3yaepm/9jmMLrhIxxADCYWvEKTqDQ6CVWzvOkgGFfemKv90/1cZX8U78WCxlUd2QI0cQLW2Pkp0X1a+XxQxisSmVkDhXSBMxufDR9nSk+g4Icqilyi7qassndW/rHkc+2nz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=PgcvKRnv; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496841; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=H6tZbk8xd14arH4x+y5nLcp4ATXMokGEomrYYieeMvA=;
	b=PgcvKRnv7G0jJod/J1p6ua68GW2fdQHDao40/aPR1UNAPS5YTnmF49hU6krqCh0CcbhQkGZ7m7eCSgmXHIPE1dHi6iT9skEfXEEa61J4XUq2kte7UD28IiqXwWhw4j3gXCt3ce/HXl+PagimR4TK8/ph/jNNMkXG+Oa3q3Ev9Zo=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnhhBon_1757496838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:34:00 +0800
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
Subject: [RFC PATCH 2/5] riscv: Define arch_apei_get_mem_attribute for RISC-V
Date: Wed, 10 Sep 2025 17:33:44 +0800
Message-Id: <20250910093347.75822-3-tianruidong@linux.alibaba.com>
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

From: Himanshu Chauhan <hchauhan@ventanamicro.com>

ghes_map function uses arch_apei_get_mem_attribute to get the
protection bits for a given physical address. These protection
bits are then used to map the physical address.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 6e13695120bc..0c599452ef48 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -27,6 +27,26 @@ extern int acpi_disabled;
 extern int acpi_noirq;
 extern int acpi_pci_disabled;
 
+#ifdef	CONFIG_ACPI_APEI
+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode
+ * with a kernel command line parameter "acpi=nocmcoff". But we don't
+ * have this IA-32 specific feature on ARM64, this definition is only
+ * for compatibility.
+ */
+#define acpi_disable_cmcff 1
+static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
+{
+	/*
+	 * Until we have a way to look for EFI memory attributes.
+	 */
+	return PAGE_KERNEL;
+}
+#else /* CONFIG_ACPI_APEI */
+#define acpi_disable_cmcff 0
+#endif /* !CONFIG_ACPI_APEI */
+
 static inline void disable_acpi(void)
 {
 	acpi_disabled = 1;
-- 
2.43.7


