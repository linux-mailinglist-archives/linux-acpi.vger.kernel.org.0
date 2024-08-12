Return-Path: <linux-acpi+bounces-7514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248AA94E454
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A44131F21F4A
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3976AB9;
	Mon, 12 Aug 2024 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ba++SpCK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288929405
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424440; cv=none; b=LtBJaiTXlHoNNFnZ2CXdytWpzI8ZSJ9S8JHdR+fJlFC1kWAmfriTLL+DD06jl9bweboq8E5XHVR9K8ZH9IN1QOVmXs7XkBZwJXwbdce78NokeKW8vaze441pkgixyZYR9frtYOAR5dUX2wss/mxVrmcpq3OXXaYaVziX3mUd8Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424440; c=relaxed/simple;
	bh=GWjuZw4Eu5cTg7uGwWvYjxpFMMpJ9eJlTAedDtcBMYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjKcjkLdua3AGDrOMz7T7jnNb5joJxsNGBUweYDqKneND6lwbYrFrFthxqIWb/1aG3yNt0c0BPxVx6dbcc7NJ9WPD+57mPTVLaUjG9MyltF7JjRqYhLX/KDr7PqmUdHrRJHSf3y5e2G+J68nXxeV5vcVcUs9PqVWaBTxjY+kFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ba++SpCK; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3db157d3bb9so2319135b6e.2
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424438; x=1724029238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yHv4RQ+8m8uuAieiHb/ndAopbPkfvfPnrF/+OTZxeU=;
        b=ba++SpCKmiXWz+t6oreV3+r1Yv514f1QoSyXJIEvGhiYEVSgAE8WP6gW2Z7/uRdI4C
         gOIX8Z2amimpRMGWMaPyTS7mjWzlTkeJRCQBDjM1jH3jn+3rvT0yKmh8QUkLsax1Gthx
         JJJxJISdY7mN9w6Hk4tONGV4U059vKScGXTTDwJGtx1u9gZanka5mBnLowXecAKqM6+e
         q0Meo2EiLDhTimytoIu9glbtULudDMCD3xcXGK9O2Vqnvq7Rs3SjYqrOX8TXAnFzk08j
         YTDRXRh7UWF63w5vZOd537+UsMZDNUpoheOEvmkBNU5mEHerplLNgtElMcvQhkROwr7e
         ajEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424438; x=1724029238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3yHv4RQ+8m8uuAieiHb/ndAopbPkfvfPnrF/+OTZxeU=;
        b=OmgEMekpCbOQVMf8qGSPdRWQKdhT8zpBxnk8b0NpedL0Kqq4S4k5DNZFpZLYa8RVCl
         iN/F/TInSlajh4y8RMRB/O6h4xlqqTYFhwQC+JO5spH2o8JlCDE1cJaUoYN4Dd0eiAbX
         wAd9hrm/nNuweIp9KoUaFvh4ZC02zzWtRinTr8ULzggnzL3W5j/VQzSWJX323+DzTGkv
         j7DJgMDWak3ivOg1jSorwhDq1Z23+sGJrEEupiKEZGnBUukYEvbU0IirAo65ew/3c3QG
         LDPeZeLBTslflZVv4LNYMeSkZk5kTQNqBZpua1SZ5CLSDsqVgXh4wimhOyhjmyBTiw8O
         bRpw==
X-Forwarded-Encrypted: i=1; AJvYcCVBcGfLsGQ5qoJ2IjtpJrH5baeg6LQ5GoxSlL5erkbngOBw9dbrEc+F5kyjs92n3plKjF6E7X6fn29j@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4IcLLk4kyQ+aWKvdLUdRVXvb5GJz5cz4sexKwq52ohCUcKs35
	tk54vv4vRGtZLnN9yh2hxs27unMewIROwEs0jBnbY2XITvEMO/KhFs4HiKa1oHQ=
X-Google-Smtp-Source: AGHT+IFun0gorfvtl1RVjdN/jm32amrHRkag2ROgDMVcRhqDHKcAfRdwMw49PRBtm4+7+S1MCEJ11g==
X-Received: by 2002:a05:6808:16a0:b0:3db:fe8:f74c with SMTP id 5614622812f47-3dc41689574mr7836368b6e.24.1723424437728;
        Sun, 11 Aug 2024 18:00:37 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:00:37 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Drew Fustini <dfustini@tenstorrent.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v8 09/17] ACPI: RISC-V: Implement PCI related functionality
Date: Mon, 12 Aug 2024 06:29:21 +0530
Message-ID: <20240812005929.113499-10-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812005929.113499-1-sunilvl@ventanamicro.com>
References: <20240812005929.113499-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=cp1252
Content-Transfer-Encoding: 8bit

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 33 +++++++++++++++------------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0f3cd7c3a436..a269e577284e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_SPCR_TABLE if ACPI
@@ -188,6 +189,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index ba957aaca5cb..6e0d333f57e5 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -311,29 +311,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
 #ifdef CONFIG_PCI
 
 /*
- * These interfaces are defined just to enable building ACPI core.
- * TODO: Update it with actual implementation when external interrupt
- * controller support is added in RISC-V ACPI.
+ * raw_pci_read/write - Platform-specific PCI config space access.
  */
-int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
-		 int reg, int len, u32 *val)
+int raw_pci_read(unsigned int domain, unsigned int bus,
+		 unsigned int devfn, int reg, int len, u32 *val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	struct pci_bus *b = pci_find_bus(domain, bus);
+
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	return -1;
-}
-
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
-}
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 8ed81a373bd7..af370628e583 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1543,7 +1543,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.43.0


