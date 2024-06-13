Return-Path: <linux-acpi+bounces-6367-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD04D90671C
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 10:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6A431C228FB
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jun 2024 08:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FD213DDCF;
	Thu, 13 Jun 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="neI5qqYc"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598C613DBBD;
	Thu, 13 Jun 2024 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267851; cv=none; b=lh1NBrNIxxuPFlx9saVR1wJc7nsmml96ozZTSCprICSoF/9F0iIIO1i7AIanZ3yAQENeWZ3OmKqBJdYq2nVQJrKkCKysePC5NtMU3uF4o5wQ0JWwmcYOclSz1A7aUlkjyEqhspeQONq6h+DUMbfFU4qOPShd1nL2mbCLmX5Hq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267851; c=relaxed/simple;
	bh=N5aRoQ5a+tTTGwEUeHzYzKK2fG6O4xqUyQUF3EVDF0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bvkNmV/GFztsMk+dOuvtJSWbpCcEhbqNSUVEjklcg3dgC+Q0Saq4ffBWoDLSABWClhZw0WyiiybjN+3qfcSt43470cGO8SJrGVtD6Yn3XhPX+5i3Ik864EDS42DmIwNwauHNLO/bSTTVZxpmuK/sC1HimzWJzKRBqojvJKZgtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=neI5qqYc; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718267850; x=1749803850;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N5aRoQ5a+tTTGwEUeHzYzKK2fG6O4xqUyQUF3EVDF0I=;
  b=neI5qqYcucQg+BOfZ/68MCYY3LVcFZ19iTu6lrepfmAcPC1AdC3z4qfl
   /AoSgfj2OAvANzqV5axXZKj0BwQ6/AtyheqLGYYo9YaQQVaVYEXRkFLaX
   QR7CnI+QYmyjwMr/yEftvzUbjl7jlJTZ+frfcaNgBJhaKQaWQzqF2sZUg
   rSnZRmfSfhdzAO3vPNQd6PJJBu5xexpfuHbb3ROavN+twSGVIf9fiyx4R
   J6kxZYLYqp31D3rEiBcyo7rAJAGBwlvwQII7mrqEhXHfm29XhooIhQn5V
   luqI3SbHqA1tnaO5v+wbgHPuCvIMsZnRFZatWM8ab2l+7ZEwKATWY9sAM
   w==;
X-CSE-ConnectionGUID: MUA7Cw6ZRreXAngDZH330w==
X-CSE-MsgGUID: a447bo4DRmCuqdezAcN6Pw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25749228"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25749228"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:37:28 -0700
X-CSE-ConnectionGUID: xEtIyw0CTh+EBzaSslP7dg==
X-CSE-MsgGUID: puLY93RPS1CngwiVDwzSwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40033803"
Received: from unknown (HELO haibo-OptiPlex-7090.sh.intel.com) ([10.239.159.132])
  by fmviesa008.fm.intel.com with ESMTP; 13 Jun 2024 01:37:19 -0700
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
	Baoquan He <bhe@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Evan Green <evan@rivosinc.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Zong Li <zong.li@sifive.com>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Chen Jiahao <chenjiahao16@huawei.com>,
	James Morse <james.morse@arm.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Zhao Ke <ke.zhao@shingroup.cn>,
	Andy Chiu <andy.chiu@sifive.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v4 3/4] ACPI: NUMA: change the ACPI_NUMA to a hidden option
Date: Thu, 13 Jun 2024 16:54:35 +0800
Message-Id: <f1f96377b8ecd6e3183f28abf5c9ac21cb9855ea.1718268003.git.haibo1.xu@intel.com>
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

x86/arm64/loongarch would select ACPI_NUMA by default and riscv
would do the same thing, so change it to a hidden option and the
select statements except for the X86_64_ACPI_NUMA can also go away.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Sunil V L <sunilvl@ventanamicro.com>
Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/arm64/Kconfig        | 1 -
 arch/loongarch/Kconfig    | 1 -
 drivers/acpi/numa/Kconfig | 5 +----
 3 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d91259ee7b5..5079ad4e21a5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1484,7 +1484,6 @@ config HOTPLUG_CPU
 config NUMA
 	bool "NUMA Memory Allocation and Scheduler Support"
 	select GENERIC_ARCH_NUMA
-	select ACPI_NUMA if ACPI
 	select OF_NUMA
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e38139c576ee..8d9e06e4ad84 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -470,7 +470,6 @@ config NR_CPUS
 config NUMA
 	bool "NUMA Support"
 	select SMP
-	select ACPI_NUMA if ACPI
 	help
 	  Say Y to compile the kernel with NUMA (Non-Uniform Memory Access)
 	  support.  This option improves performance on systems with more
diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..f33194d1e43f 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -1,9 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 config ACPI_NUMA
-	bool "NUMA support"
-	depends on NUMA
-	depends on (X86 || ARM64 || LOONGARCH)
-	default y if ARM64
+	def_bool NUMA && !X86
 
 config ACPI_HMAT
 	bool "ACPI Heterogeneous Memory Attribute Table Support"
-- 
2.34.1


