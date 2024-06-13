Return-Path: <linux-acpi+bounces-6368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA1190671F
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DF51F21872
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD713D89C;
	Thu, 13 Jun 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F6Mcol+M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0A813D88D;
	Thu, 13 Jun 2024 08:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267870; cv=none; b=Avlpods+50apZBOAxOxMmTx5pBWmpn2rbYoLx6R7j6jax4ylXrvhgwLzRLwggFYUDLasLLSguCW7tb2UBSkT/0Hu9fTh8GvRmfTdOq0tvWSlOgNdUFKvgOQFLI9rglfzOKt6aI5SFATByhk2CpkKJkcRnkzZLZXMIP+gbZhbbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267870; c=relaxed/simple;
	bh=ex1BfUqwBKGcn6bmqOhnx0hqarbIcWjP42s/m1fBXKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VHmWcsXDR3jLa2MgTViWRJcC1bm65ZVo18rDkcAtq1L8rve61zkIQTd6kH/5fZztUqFAacVA3RARF+mH/DOgAIw5M1RXbGG1ZdME1suEOQumjggpHUPCraaU2ea9M9kFxFreUtYaYZsIJ4ugns3fTXcOHKouwBjZdJPrHd3wBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F6Mcol+M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718267868; x=1749803868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ex1BfUqwBKGcn6bmqOhnx0hqarbIcWjP42s/m1fBXKk=;
  b=F6Mcol+Mf98mG1lU3NY66ovG0avOWsIf+PchjUeipeuKGvLy4QpZoFXA
   US4AqVBct/15sXjrp8QH8nqXcFac5/vo/38rU+GonHo9X+K5kfZ8P+hfT
   pgMB0Rto70FzmFAFNnkmlRDVsn0qDJ2RXAd1lEqm8hBUYbI9KN/DbGu59
   7k4JLWgsL4nmGws7ybiSE9InDAm2IaafWYWFF069oI8HdzCRvV1j8iIxp
   TzN1DLT7H/qj3/keqiOIUundjyBm0fw8u7QkqlyGJM9fd4Wgq4kY1NZdK
   rxQAFuAzzTk56drDRSoJKQUrj/6CWi0sBwpfJu6ivffHMDfA3FSgBKLNM
   g==;
X-CSE-ConnectionGUID: yMLOk7s5TKuKYwmLQvtHiA==
X-CSE-MsgGUID: IVxGmJ8iSpOhX4tqAcozKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25749297"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25749297"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:37:47 -0700
X-CSE-ConnectionGUID: 1gvnnVjqQ6yZUNEZ9djjdQ==
X-CSE-MsgGUID: sHA/Q8m2T2yX18P2Q81yoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40033851"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jun 2024 01:37:38 -0700
From: Haibo Xu <haibo1.xu@intel.com>
To: sunilvl@ventanamicro.com,
	arnd@arndb.de
Cc: xiaobo55x@gmail.com,
	ajones@ventanamicro.com,
	Haibo Xu <haibo1.xu@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Baoquan He <bhe@redhat.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Evan Green <evan@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Yang Li <yang.lee@linux.alibaba.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	Yuntao Wang <ytcoode@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v4 4/4] ACPI: NUMA: replace pr_info with pr_debug in arch_acpi_numa_init
Date: Thu, 13 Jun 2024 16:54:36 +0800
Message-Id: <109354315a02cd22145d2effa4a8c571b69d3e56.1718268003.git.haibo1.xu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718268003.git.haibo1.xu@intel.com>
References: <cover.1718268003.git.haibo1.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are lots of ACPI enabled systems that aren't NUMA and If the
firmware didn't provide the SRAT/SLIT, then there will be a message
"Failed to initialise from firmware" from arch_acpi_numa_init() which
adding noise to the boot on all of those kind of systems. Replace the
pr_info with pr_debug in arch_acpi_numa_init() to avoid it.

Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/base/arch_numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/arch_numa.c b/drivers/base/arch_numa.c
index 5b59d133b6af..555aee3ee8e7 100644
--- a/drivers/base/arch_numa.c
+++ b/drivers/base/arch_numa.c
@@ -445,7 +445,7 @@ static int __init arch_acpi_numa_init(void)
 
 	ret = acpi_numa_init();
 	if (ret) {
-		pr_info("Failed to initialise from firmware\n");
+		pr_debug("Failed to initialise from firmware\n");
 		return ret;
 	}
 
-- 
2.34.1


