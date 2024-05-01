Return-Path: <linux-acpi+bounces-5564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA688B89C1
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 14:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8381F222FF
	for <lists+linux-acpi@lfdr.de>; Wed,  1 May 2024 12:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA2612E1C9;
	Wed,  1 May 2024 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ShWYyazf"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63BF12E1C4
	for <linux-acpi@vger.kernel.org>; Wed,  1 May 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565948; cv=none; b=dQ9B+szIVNzNmVrVwBPtwWXjv+eoNspSVL51Ku/92kM/sIzse58RxDC9BgH8SQwS9DnD1Z4btcUQesPupu16PTijzkK+i1Ov+oHSTW5HASrDK6UVEcmuS1hAaqqlsms6P+xBHtWG+EEONxvlf2n1vWRjTk8oU+ujnLSVdio+3uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565948; c=relaxed/simple;
	bh=nLWDIfQeIOjbntOKuF1sgqsUGviHan2c0T12uuyd8vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCaUJwKiSldGr3+nxqZOpEjGTcBA4aiehYjHEvuqi5pVsAhtRXj6HetpNGETV/qsltr1HLsXqwf8sv0ErxgOKFQ7LlljC2nk2rwJ/HWo0D8jRwQVZSBYhltyaz0GswukaPmuoVSErESFzMqt1gtgdJ+B0cczZZ31Y5b/YYoZ4eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=ShWYyazf; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e9ffd3f96eso54542225ad.3
        for <linux-acpi@vger.kernel.org>; Wed, 01 May 2024 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1714565946; x=1715170746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38bWUcD6VJHgu2OT2TKY+rPPpBYSs9fss+ITqZ/SBFM=;
        b=ShWYyazf9u62scetDjspdRKnK+3QCXpS3eOR1JhA3IH9CQ+Abdh9Ahm8+tUAsytsjr
         +q73oJ+qCq+rjPPo7eV+DjDzmHHXT7EnzNG6OYPAmyGdU8Oz1ZWgiZkizvAfxseDRWto
         yhX2U4bxpmX6AAljJ5JcYFIoP2a/BYr5NI3R42/KXdXS0V2OmnMasDJ+5ft1+x1O3wNr
         ZmeQUeUrNWv5labCDfACCwpqCpdV322tS/zSVUcLGBcRq/RJa7qb9aTfmw0YJ6Uq5ntg
         2upKtczKCgAABdZRA2q3CjmLfxVB6veBo/1bXLQXL8BYBdqFpwpeJwIeOiuET8jteMEW
         cILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714565946; x=1715170746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38bWUcD6VJHgu2OT2TKY+rPPpBYSs9fss+ITqZ/SBFM=;
        b=URsHztbq5vZLM+h3CHPwA6OTUGU+3N/4Yf/YxqX9il9Z1cohntNbD9dAhh8h+jIsBs
         0HrU0DZdJme90P1gmZAhSgZFwlnGNsCSjqeGQyHPcN0WODV/JttM/qaxl+PZLFlZ79GG
         7M0Kmhd8UWfa3Mqn9ohhxGuz24quWG0OL0F+fj/RfvUNTqj5r24VlG2QrLByZFpPUeM5
         g8WqT5FHDaQ8AqIofIT7SwqlQfXJvCUulBZ8fF8mBFg9DSbY9asiLDPq6lxD+NoomPuE
         aLBYGLqC48c9qjZjsALjGQc2QbhhuExKc9uB0tLqA+C/p5NXBeUT3mkAKRRbv1k5hp8d
         9IJQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3LViRxJcJdLWZquZnKKlMV4JQvU8OhJNRJ0yQ5fkYq2Wuxz++aIDEC3Yskke+vOth2HipXT2WVnWXzMd6KJLQi638y6ShvjPy5A==
X-Gm-Message-State: AOJu0YwjvhT+CgKY29/F1tRxUG6nD0ibNefQr/AZymW1SlmDSlgyPOA/
	8/OWfqomrzhC/B0Z3XrDerben4UfUDfFzn4DgXaDpRBrVfxQdfCPrIMYmmq1N1c=
X-Google-Smtp-Source: AGHT+IGXC7NkAjACd9P5pWtq+Fm60ySdE8zHPZMKCP8HvEhNdRXNAHHqpbDgXk2ZkzDTp6OP1jYRcw==
X-Received: by 2002:a17:903:2591:b0:1de:f93f:4410 with SMTP id jb17-20020a170903259100b001def93f4410mr1645679plb.8.1714565945995;
        Wed, 01 May 2024 05:19:05 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.188.106])
        by smtp.gmail.com with ESMTPSA id im15-20020a170902bb0f00b001ec8888b22esm1336900plb.65.2024.05.01.05.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 05:19:05 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Marc Zyngier <maz@kernel.org>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Andrei Warkentin <andrei.warkentin@intel.com>,
	Haibo1 Xu <haibo1.xu@intel.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v5 08/17] ACPI: pci_link: Clear the dependencies after probe
Date: Wed,  1 May 2024 17:47:33 +0530
Message-Id: <20240501121742.1215792-9-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
References: <20240501121742.1215792-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V platforms need to use dependencies between PCI host bridge, Link
devices and the interrupt controllers to ensure probe order. The
dependency is like below.

Interrupt controller <-- Link Device <-- PCI Host bridge.

If there is no dependency added between Link device and PCI Host Bridge,
then the PCI end points can get probed prior to link device, unable to
get mapping for INTx.

So, add the link device's HID to dependency honor list and also clear it
after its probe.

Since this is required only for architectures like RISC-V, enable this
code under a new config option and set this only in RISC-V.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/Kconfig      | 1 +
 drivers/acpi/Kconfig    | 3 +++
 drivers/acpi/pci_link.c | 3 +++
 drivers/acpi/scan.c     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index f961449ca077..f7a36d79ff1a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -14,6 +14,7 @@ config RISCV
 	def_bool y
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+	select ARCH_ACPI_DEFERRED_GSI if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index e3a7c2aedd5f..ebec1707f662 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -587,6 +587,9 @@ config ACPI_PRMT
 	  substantially increase computational overhead related to the
 	  initialization of some server systems.
 
+config ARCH_ACPI_DEFERRED_GSI
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index aa1038b8aec4..48cdcedafad6 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -748,6 +748,9 @@ static int acpi_pci_link_add(struct acpi_device *device,
 	if (result)
 		kfree(link);
 
+	if (IS_ENABLED(CONFIG_ARCH_ACPI_DEFERRED_GSI))
+		acpi_dev_clear_dependencies(device);
+
 	return result < 0 ? result : 1;
 }
 
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 3eeb4ce39fcc..67677a6ff8e3 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -834,6 +834,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"INTC10CF", /* IVSC (MTL) driver must be loaded to allow i2c access to camera sensors */
 	"RSCV0001", /* RISC-V PLIC */
 	"RSCV0002", /* RISC-V APLIC */
+	"PNP0C0F",  /* PCI Link Device */
 	NULL
 };
 
-- 
2.40.1


