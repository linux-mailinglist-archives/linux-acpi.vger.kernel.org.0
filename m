Return-Path: <linux-acpi+bounces-5029-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2486A8A5866
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 19:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4CAC1F21B63
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Apr 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33D84DF8;
	Mon, 15 Apr 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Ibq4yvZ8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62883CBE
	for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 17:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200503; cv=none; b=DKuIY8vY2EGy4Jns71KYttSaY88GtYzMc6ldRbnLmhRiRkpYLUcy0CYQ4G/Tg4oGMC7lJH8OS0bbESlmnD/q3Wf+DiHm63nheqo0YT3hWzljeg18LWh8WlIKTR3jczI1sbUN/HiQ3z/S6dHLoiEacMoXO95NOMJ2BG/ToHnzTII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200503; c=relaxed/simple;
	bh=d//fcv46H4LzOYIR8kFfFqlYP6RASRxKKzQCgxhHvNk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WrHWUQDsNetYesFBiaIc/B5vFNQuuoyYqA/n2DK1Sf53DSP1MSZ/SfIIvv+pbSMaxAI85WNvwjO3+mgZbWjaR/pK3YZvGCV/J9VE0jwqLfLszgZ9SrBt7csrwZ8jfSxTWkqYItm3plwli/EN4xoobsz8/RBBkZMyJgyv7rQpzKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Ibq4yvZ8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf1bb7f38so3169609b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 15 Apr 2024 10:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1713200497; x=1713805297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=Ibq4yvZ87GnCiGAJGBbAJR9dv9TRo9Rs12iETGjNcPzQimPMrc5TlCaQ7lB+7BSAT2
         59mR0vmElr3Ia3cVyJmE5qExu3hurKvsCfUpWNitAQzsJw++lmOsDWE9pVriuN94FXv7
         fqfGS74DHSI/7izzpM3KGQ1/gtQBqnErbC2OiIM0kymWAaspNrIUHxTDYOxzbpf5Y54H
         w6tp7f5DW0/UOSNWL8/vz/dhjCsMgwIcD7OpTvdfghNzTash//dXxcocXthNDyTMzvzy
         sLCjsxufKwSp/m25mRYjEI4/pUUSWZX5rXvJM/Kc8ljjWNt6yaevgG8QWabAZl5gx1zi
         Vy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713200497; x=1713805297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFAtcNyUPfmOo+WuzK4Rac+GFz0TbHOwinmWYmcFrxc=;
        b=ugCBW6hcuIebPWOmLnNvn5Tw7yyNZ2lp4nELA9nbIwjAAfeiQugAf74KQaMjgmB6zT
         PvHzvYqKclO33E9qLu5E//1lKJcGZjk5Y8eHM8ZSwos3eXH7jeJQqSdnn7n25KsugRs8
         /ErVXoB159EsYFdw39dNufQh7WwHEsTEBkZWlgTbQIEXeXWLyCK58FDY51e3ajy2RWAY
         86cQyPG66iirfX4WlUZLaPkc6CBBZIzX9WHM6Wv/Y7/7/IhEM10ckKWJeQ9VkfM6o/yf
         yYLaj9YTuQX6NG80eK54TyB/nZKm4Mo1l+inhFyErjYPtQoQACeR0ChxWXQwyl+X3gq2
         q88A==
X-Forwarded-Encrypted: i=1; AJvYcCXEXMgwFLPl79EGKbc/HDpE1ZZejgfQVvaFy30wMeiYRfCK//HomPRy3uJqt73mu6HHMuAuvhtefQoHk3m7mh3/78eS9G9uHxK2wg==
X-Gm-Message-State: AOJu0YwaxuRTqEecImKu5TgWaqLcPvzBlmpwWJsPxjw0oY+OueSoJWz/
	FyRayLHgdTjmo596bZk1ROUODWk0Y2XdLyDaF+zT2QnYlMFb4+GJ0p7UCc7uPvg=
X-Google-Smtp-Source: AGHT+IGqYjIa76YfWohzDrF4RGeNhNZq2I7mTi99zpcmd5VEKjXE94y5JlYL9p7qJRGZUYYL3web8A==
X-Received: by 2002:a05:6a00:22cf:b0:6eb:2b:43b4 with SMTP id f15-20020a056a0022cf00b006eb002b43b4mr11021959pfj.27.1713200496609;
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.230])
        by smtp.gmail.com with ESMTPSA id 1-20020a056a00072100b006ed045e3a70sm7433158pfm.25.2024.04.15.10.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 10:01:36 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
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
	Haibo1 Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Marc Zyngier <maz@kernel.org>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v4 02/20] RISC-V: ACPI: Implement PCI related functionality
Date: Mon, 15 Apr 2024 22:30:55 +0530
Message-Id: <20240415170113.662318-3-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240415170113.662318-1-sunilvl@ventanamicro.com>
References: <20240415170113.662318-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the dummy implementation for PCI related functions with actual
implementation. This needs ECAM and MCFG CONFIG options to be enabled
for RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig       |  2 ++
 arch/riscv/kernel/acpi.c | 31 ++++++++++++++-----------------
 drivers/pci/pci-acpi.c   |  2 +-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6d64888134ba..69cc0509a19a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -13,6 +13,7 @@ config 32BIT
 config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
@@ -173,6 +174,7 @@ config RISCV
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
 	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_ECAM if (ACPI && PCI)
 	select PCI_MSI if PCI
 	select RISCV_ALTERNATIVE if !XIP_KERNEL
 	select RISCV_APLIC
diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index e619edc8b0cc..41aa77c8484b 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -306,29 +306,26 @@ void __iomem *acpi_os_ioremap(acpi_physical_address phys, acpi_size size)
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
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
-		  int reg, int len, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->read(b, devfn, reg, len, val);
 }
 
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+int raw_pci_write(unsigned int domain, unsigned int bus,
+		  unsigned int devfn, int reg, int len, u32 val)
 {
-	return -1;
-}
+	struct pci_bus *b = pci_find_bus(domain, bus);
 
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	return NULL;
+	if (!b)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	return b->ops->write(b, devfn, reg, len, val);
 }
+
 #endif	/* CONFIG_PCI */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index e8d84fa435da..b5892d0fa68c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1521,7 +1521,7 @@ static int __init acpi_pci_init(void)
 }
 arch_initcall(acpi_pci_init);
 
-#if defined(CONFIG_ARM64)
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 
 /*
  * Try to assign the IRQ number when probing a new device
-- 
2.40.1


