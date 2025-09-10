Return-Path: <linux-acpi+bounces-16560-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E95B5128E
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551CF4612F4
	for <lists+linux-acpi@lfdr.de>; Wed, 10 Sep 2025 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7408B31282D;
	Wed, 10 Sep 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pUlEO+NC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62973081A0;
	Wed, 10 Sep 2025 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496843; cv=none; b=bsA4xOxe2Xj403og2kJNrsc0nJKt3otGDKnh6BGJ214QzUUVNA3UavqTKA262N8EgcJuLevbiDRPuNVrr2R3yf4HIr0bT03aHlbaMhXDWWE109++5UCyFvWzJSlur1m6qmCA/vxudp7WHzkoWHTt/JwOoSnu+XmFxOgiyPfKUT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496843; c=relaxed/simple;
	bh=W0kJHMJPyXLBD9AsLRJEuzaG4BOBAaE1iErjmIi/gbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PtsGMS8hGk9DrmtTq2tHg4VC3YIZMLymVb/GgaKBd4Lv56RTGqWGbtGWe8DzvJzttWfIB7pOJzK9lu6HvW443M4opHO9HBnuXHuFysefW4jmI20B+dXzg7iXXzV2bMn8uQkCh7sKHgOGcgLCAehxh2alhXZRreMkDU9uSl3h7a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pUlEO+NC; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757496836; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CkbLKay4KW6gGBpr5vlMMMrvH8ODs320iGf0xAuSytA=;
	b=pUlEO+NC9Qf5fV4RpDucAS4o6cIMdxsU34kTlWsq/ZUnV2nfhjDIxIXJ6Z8oIBDzREZG++uokHqrm3oIqaY3pa3MU9Fg4qVQPi5fUWooMdbyvVXYCCkra/TFae+befS25K4hOk5EUSGxOHZyjAGcTr9qaIghhfw83yFz70dv9+I=
Received: from localhost(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0WnhhBo9_1757496834 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 10 Sep 2025 17:33:56 +0800
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
Subject: [RFC PATCH 1/5] riscv: Define ioremap_cache for RISC-V
Date: Wed, 10 Sep 2025 17:33:43 +0800
Message-Id: <20250910093347.75822-2-tianruidong@linux.alibaba.com>
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

bert and einj drivers use ioremap_cache for mapping entries
but ioremap_cache is not defined for RISC-V.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 arch/riscv/include/asm/io.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index a0e51840b9db..56eca6b3031f 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -30,6 +30,9 @@
 #define PCI_IOBASE		((void __iomem *)PCI_IO_START)
 #endif /* CONFIG_MMU */
 
+#define ioremap_cache(addr, size)					\
+	((__force void *)ioremap_prot((addr), (size), __pgprot(_PAGE_KERNEL)))
+
 /*
  * Emulation routines for the port-mapped IO space used by some PCI drivers.
  * These are defined as being "fully synchronous", but also "not guaranteed to
-- 
2.43.7


