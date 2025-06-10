Return-Path: <linux-acpi+bounces-14258-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BD2AD3404
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 12:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B601624D8
	for <lists+linux-acpi@lfdr.de>; Tue, 10 Jun 2025 10:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A528D84D;
	Tue, 10 Jun 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="FhstGigp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C29284B33
	for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749552420; cv=none; b=WPVNx5cW5G5Ppr0jgS3IUpFV2bF+tC9koXLcvMY9zvZN3gCJY0JGeTlq8pIg4FxX1Ekngt7YMeYCjGq9/H9lOGdIvwgbeGBjsYvAcPpgT+0VQU3EW0QZSLqYgE8+rD/cOvwE3lSnFzIGL4P94OOAUpT4Wqt49GtqyCCqWB2P5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749552420; c=relaxed/simple;
	bh=AbeUa7oMgcWWxhKR5HdiZpOtxTepX/NHaXq0Go8csdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMQnoDS/r0L4ab2ppx0uM5ZB73CD9ngm+Bembg4l/j3LPRetRHYqg0D7g5pbgivy/02DWo27ny9vRKHTZnYNiImCYEi+QKUNQh9x9TDxJyNLRr6ReyvtdItsneGwAra5kmaWOk8Gdz3PmqUmjt5pW2sF1KCRiF9iA/8N6vawMN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=FhstGigp; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so3961114b3a.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jun 2025 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1749552417; x=1750157217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJadeZsf91vMZzGM1aZzFqytc9WcYBPIOZfEwjMnhPs=;
        b=FhstGigpyVcs2RkAkO10g1BMmfaArPkaVB7HUV1+DjtNsGJ6tdDvCyeZfhUlO0E+AO
         v1ppg87feUwlMLWoeKKAVLsqI5EPhyJGPw6WTTbi1Dg5Dy79AWGK/A4MHWioohPG19QY
         8Ix/W+4plN2fnW8lD8PP1TY89w9uUTY63F5YkessbHnltwV6VTQ9bZmNNk7ZL+f/fCzZ
         ajAyuZN3tq9RDpzIiiYHStxpuzHbMeHC8RAmCmexASDqMYALMovDP7hQMM8Iv2QjG19G
         IW48uZoUeGQ5Lon7vda6oX1NGn6Wo51r8mIqkbN7qVIMKVnqolDjD+i7qURj+EMu279F
         eRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749552417; x=1750157217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJadeZsf91vMZzGM1aZzFqytc9WcYBPIOZfEwjMnhPs=;
        b=HtSCaxHPk1JdZdaAHVNAZdftjDzB/EZPHvub0gv+YGB/CQjzkM80NpYHMPjqDhFOaO
         cJB4pjrZqLJ+Zg8h6CVrjj4iPYLi5Vm9UvBB6yyJM1XcdbzKEW+uZiahymwNaxgFD2Lh
         syCcIVXXh4+b4E+O9mzW0uxaN01Xt7oNTWUWhYsOLKVGEfesZC90foSwuw678c/9KjYM
         yh35JSSqra1MUZq2U3oKIW+FTQa6TvYW5AFUJBgJaCYSaZwhqPryqtUrH80NUk9I4vKR
         xvfrK/xFtnyc6u6zsOBI9aJx+asTsmZnWzvFzIh26ZIQAJqrGbZjLsG3F1pHyDHeycS9
         KX7A==
X-Forwarded-Encrypted: i=1; AJvYcCUaN+N21+HVgj+PZ/MvnfD7QicGGXBT2XI/joH7jFK/Y8I82Qt4obB1+2UX9QG+dXRhgwsqp1n5m5SI@vger.kernel.org
X-Gm-Message-State: AOJu0YwC8AUQUAJNYFP4R4z7//p5TWZDRK/3/bVynQ5BtFsD/v6FWCQ7
	i1uFdHyj/IhUdfR0bkJkv0eyBkIMcmVdKCRBc7OeQ1qylNnl4XbNp6BK6nMGTtg/5I8=
X-Gm-Gg: ASbGncsJupjW07pteJnfNTsMguFfqPLmRBFL9TQw6KiEJkmBFZ/mmTnRPIAAcSithup
	c4GWXyW8hWj3eV57SzSEhwOrsppsU9F562KFV7lVoqgMaDVYPDQXnv1L5zn+uHN2LhsBeqFBru6
	61K7SzKVqbcPOB1AEIcnvfioMTUnRSYotqbhYzdfUUgv2RoL/2KuvwxiUovs5Ww9yO7UaziQx8Q
	WpVc1FdwQW7WSutaU5cvNhUs29AKfgTM2RpdTfcZe/fxks+VogUjZ0Pfisk8LpLGRSOLsklw8Bg
	eejiyM5gC/SRXPCMNScWxRxH+utsB4fQdgSNPcTMYvX2sstjBGP6cK34fK1m0fSbVP6DSby0
X-Google-Smtp-Source: AGHT+IETvDNywdOafWDEP4hN5G1n2p50ILLYrsZVTynCDylV47c9oRWac3LLkA3rE5vdN9xdcrH6zQ==
X-Received: by 2002:a05:6a00:3a1b:b0:742:aed4:3e1 with SMTP id d2e1a72fcca58-7485ea28acfmr3458654b3a.2.1749552417314;
        Tue, 10 Jun 2025 03:46:57 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.196.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482b0842c0sm7152448b3a.73.2025.06.10.03.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 03:46:56 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	iommu@lists.linux.dev
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tomasz Jeznach <tjeznach@rivosinc.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 1/3] ACPI: RISC-V: Add support for RIMT
Date: Tue, 10 Jun 2025 16:16:39 +0530
Message-ID: <20250610104641.700940-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250610104641.700940-1-sunilvl@ventanamicro.com>
References: <20250610104641.700940-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V IO Mapping Table (RIMT) is a static ACPI table to communicate
IOMMU information to the OS. The spec is available at [1].

The changes at high level are,
	a) Initialize data structures required for IOMMU/device
	   configuration using the data from RIMT. Provide APIs required
	   for device configuration.
	b) Provide an API for IOMMU drivers to register the
	   fwnode with RIMT data structures. This API will create a
	   fwnode for PCIe IOMMU.

[1] - https://github.com/riscv-non-isa/riscv-acpi-rimt

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Link: https://lore.kernel.org/r/20250514055723.1328557-3-sunilvl@ventanamicro.com
Signed-off-by: Anup Patel <anup@brainfault.org>
---
 MAINTAINERS                 |   1 +
 arch/riscv/Kconfig          |   1 +
 drivers/acpi/Kconfig        |   4 +
 drivers/acpi/riscv/Kconfig  |   7 +
 drivers/acpi/riscv/Makefile |   1 +
 drivers/acpi/riscv/init.c   |   2 +
 drivers/acpi/riscv/init.h   |   1 +
 drivers/acpi/riscv/rimt.c   | 523 ++++++++++++++++++++++++++++++++++++
 include/linux/acpi_rimt.h   |  26 ++
 9 files changed, 566 insertions(+)
 create mode 100644 drivers/acpi/riscv/Kconfig
 create mode 100644 drivers/acpi/riscv/rimt.c
 create mode 100644 include/linux/acpi_rimt.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a92290fffa16..9d36ad744af5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -345,6 +345,7 @@ L:	linux-acpi@vger.kernel.org
 L:	linux-riscv@lists.infradead.org
 S:	Maintained
 F:	drivers/acpi/riscv/
+F:	include/linux/acpi_rimt.h
 
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@arm.com>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..96d64e0a7b97 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -16,6 +16,7 @@ config RISCV
 	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_PPTT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
+        select ACPI_RIMT if ACPI
 	select ACPI_SPCR_TABLE if ACPI
 	select ARCH_DMA_DEFAULT_COHERENT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 7bc40c2735ac..4381803c308c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -546,6 +546,10 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+if RISCV
+source "drivers/acpi/riscv/Kconfig"
+endif
+
 config ACPI_PPTT
 	bool
 
diff --git a/drivers/acpi/riscv/Kconfig b/drivers/acpi/riscv/Kconfig
new file mode 100644
index 000000000000..046296a18d00
--- /dev/null
+++ b/drivers/acpi/riscv/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ACPI Configuration for RISC-V
+#
+
+config ACPI_RIMT
+	bool
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index a96fdf1e2cb8..1284a076fa88 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -2,3 +2,4 @@
 obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
+obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 673e4d5dd752..7c00f7995e86 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -10,4 +10,6 @@
 void __init acpi_arch_init(void)
 {
 	riscv_acpi_init_gsi_mapping();
+	if (IS_ENABLED(CONFIG_ACPI_RIMT))
+		riscv_acpi_rimt_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 0b9a07e4031f..1680aa2aaf23 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -2,3 +2,4 @@
 #include <linux/init.h>
 
 void __init riscv_acpi_init_gsi_mapping(void);
+void __init riscv_acpi_rimt_init(void);
diff --git a/drivers/acpi/riscv/rimt.c b/drivers/acpi/riscv/rimt.c
new file mode 100644
index 000000000000..8cb6f5cf39e2
--- /dev/null
+++ b/drivers/acpi/riscv/rimt.c
@@ -0,0 +1,523 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024-2025, Ventana Micro Systems Inc
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ *
+ */
+
+#include <linux/acpi.h>
+#include <linux/acpi_rimt.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include "init.h"
+
+struct rimt_fwnode {
+	struct list_head list;
+	struct acpi_rimt_node *rimt_node;
+	struct fwnode_handle *fwnode;
+};
+
+static LIST_HEAD(rimt_fwnode_list);
+static DEFINE_SPINLOCK(rimt_fwnode_lock);
+
+#define RIMT_TYPE_MASK(type)	(1 << (type))
+#define RIMT_IOMMU_TYPE		BIT(0)
+
+/* Root pointer to the mapped RIMT table */
+static struct acpi_table_header *rimt_table;
+
+/**
+ * rimt_set_fwnode() - Create rimt_fwnode and use it to register
+ *		       iommu data in the rimt_fwnode_list
+ *
+ * @rimt_node: RIMT table node associated with the IOMMU
+ * @fwnode: fwnode associated with the RIMT node
+ *
+ * Returns: 0 on success
+ *          <0 on failure
+ */
+static inline int rimt_set_fwnode(struct acpi_rimt_node *rimt_node,
+				  struct fwnode_handle *fwnode)
+{
+	struct rimt_fwnode *np;
+
+	np = kzalloc(sizeof(*np), GFP_ATOMIC);
+
+	if (WARN_ON(!np))
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&np->list);
+	np->rimt_node = rimt_node;
+	np->fwnode = fwnode;
+
+	spin_lock(&rimt_fwnode_lock);
+	list_add_tail(&np->list, &rimt_fwnode_list);
+	spin_unlock(&rimt_fwnode_lock);
+
+	return 0;
+}
+
+/**
+ * rimt_get_fwnode() - Retrieve fwnode associated with an RIMT node
+ *
+ * @node: RIMT table node to be looked-up
+ *
+ * Returns: fwnode_handle pointer on success, NULL on failure
+ */
+static inline struct fwnode_handle *rimt_get_fwnode(struct acpi_rimt_node *node)
+{
+	struct rimt_fwnode *curr;
+	struct fwnode_handle *fwnode = NULL;
+
+	spin_lock(&rimt_fwnode_lock);
+	list_for_each_entry(curr, &rimt_fwnode_list, list) {
+		if (curr->rimt_node == node) {
+			fwnode = curr->fwnode;
+			break;
+		}
+	}
+	spin_unlock(&rimt_fwnode_lock);
+
+	return fwnode;
+}
+
+static acpi_status rimt_match_node_callback(struct acpi_rimt_node *node,
+					    void *context)
+{
+	struct device *dev = context;
+	acpi_status status = AE_NOT_FOUND;
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_IOMMU) {
+		struct acpi_rimt_iommu *iommu_node = (struct acpi_rimt_iommu *)&node->node_data;
+
+		if (dev_is_pci(dev)) {
+			struct pci_dev *pdev;
+			u16 bdf;
+
+			pdev = to_pci_dev(dev);
+			bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
+			if ((pci_domain_nr(pdev->bus) == iommu_node->pcie_segment_number) &&
+			    bdf == iommu_node->pcie_bdf) {
+				status = AE_OK;
+			} else {
+				status = AE_NOT_FOUND;
+			}
+		} else {
+			struct platform_device *pdev = to_platform_device(dev);
+			struct resource *res;
+
+			res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+			if (res && res->start == iommu_node->base_address)
+				status = AE_OK;
+			else
+				status = AE_NOT_FOUND;
+		}
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		struct acpi_rimt_pcie_rc *pci_rc;
+		struct pci_bus *bus;
+
+		bus = to_pci_bus(dev);
+		pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
+
+		/*
+		 * It is assumed that PCI segment numbers maps one-to-one
+		 * with root complexes. Each segment number can represent only
+		 * one root complex.
+		 */
+		status = pci_rc->pcie_segment_number == pci_domain_nr(bus) ?
+							AE_OK : AE_NOT_FOUND;
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+		struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+		struct acpi_device *adev;
+		struct acpi_rimt_platform_device *ncomp;
+		struct device *plat_dev = dev;
+
+		/*
+		 * Walk the device tree to find a device with an
+		 * ACPI companion; there is no point in scanning
+		 * RIMT for a device matching a platform device if
+		 * the device does not have an ACPI companion to
+		 * start with.
+		 */
+		do {
+			adev = ACPI_COMPANION(plat_dev);
+			if (adev)
+				break;
+
+			plat_dev = plat_dev->parent;
+		} while (plat_dev);
+
+		if (!adev)
+			return status;
+
+		status = acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
+		if (ACPI_FAILURE(status)) {
+			dev_warn(plat_dev, "Can't get device full path name\n");
+			return status;
+		}
+
+		ncomp = (struct acpi_rimt_platform_device *)node->node_data;
+		status = !strcmp(ncomp->device_name, buf.pointer) ?
+							AE_OK : AE_NOT_FOUND;
+		acpi_os_free(buf.pointer);
+	}
+
+	return status;
+}
+
+static struct acpi_rimt_node *rimt_scan_node(enum acpi_rimt_node_type type,
+					     void *context)
+{
+	struct acpi_rimt_node *rimt_node, *rimt_end;
+	struct acpi_table_rimt *rimt;
+	int i;
+
+	if (!rimt_table)
+		return NULL;
+
+	/* Get the first RIMT node */
+	rimt = (struct acpi_table_rimt *)rimt_table;
+	rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt,
+				 rimt->node_offset);
+	rimt_end = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				rimt_table->length);
+
+	for (i = 0; i < rimt->num_nodes; i++) {
+		if (WARN_TAINT(rimt_node >= rimt_end, TAINT_FIRMWARE_WORKAROUND,
+			       "RIMT node pointer overflows, bad table!\n"))
+			return NULL;
+
+		if (rimt_node->type == type &&
+		    ACPI_SUCCESS(rimt_match_node_callback(rimt_node, context)))
+			return rimt_node;
+
+		rimt_node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_node,
+					 rimt_node->length);
+	}
+
+	return NULL;
+}
+
+static bool rimt_pcie_rc_supports_ats(struct acpi_rimt_node *node)
+{
+	struct acpi_rimt_pcie_rc *pci_rc;
+
+	pci_rc = (struct acpi_rimt_pcie_rc *)node->node_data;
+	return pci_rc->flags & ACPI_RIMT_PCIE_ATS_SUPPORTED;
+}
+
+static int rimt_iommu_xlate(struct device *dev, struct acpi_rimt_node *node, u32 deviceid)
+{
+	struct fwnode_handle *rimt_fwnode;
+
+	if (!node)
+		return -ENODEV;
+
+	rimt_fwnode = rimt_get_fwnode(node);
+
+	/*
+	 * The IOMMU drivers may not be probed yet.
+	 * Defer the IOMMU configuration
+	 */
+	if (!rimt_fwnode)
+		return -EPROBE_DEFER;
+
+	return acpi_iommu_fwspec_init(dev, deviceid, rimt_fwnode);
+}
+
+struct rimt_pci_alias_info {
+	struct device *dev;
+	struct acpi_rimt_node *node;
+	const struct iommu_ops *ops;
+};
+
+static int rimt_id_map(struct acpi_rimt_id_mapping *map, u8 type, u32 rid_in, u32 *rid_out)
+{
+	if (rid_in < map->source_id_base ||
+	    (rid_in > map->source_id_base + map->num_ids))
+		return -ENXIO;
+
+	*rid_out = map->dest_id_base + (rid_in - map->source_id_base);
+	return 0;
+}
+
+static struct acpi_rimt_node *rimt_node_get_id(struct acpi_rimt_node *node,
+					       u32 *id_out, int index)
+{
+	struct acpi_rimt_platform_device *plat_node;
+	struct acpi_rimt_pcie_rc *pci_node;
+	u32 id_mapping_offset, num_id_mapping;
+	struct acpi_rimt_id_mapping *map;
+	struct acpi_rimt_node *parent;
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
+		id_mapping_offset = pci_node->id_mapping_offset;
+		num_id_mapping = pci_node->num_id_mappings;
+	} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+		plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
+		id_mapping_offset = plat_node->id_mapping_offset;
+		num_id_mapping = plat_node->num_id_mappings;
+	} else {
+		return NULL;
+	}
+
+	if (!id_mapping_offset || !num_id_mapping || index >= num_id_mapping)
+		return NULL;
+
+	map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
+			   id_mapping_offset + index * sizeof(*map));
+
+	/* Firmware bug! */
+	if (!map->dest_offset) {
+		pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+		       node, node->type);
+		return NULL;
+	}
+
+	parent = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table, map->dest_offset);
+
+	if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE ||
+	    node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+		*id_out = map->dest_offset;
+		return parent;
+	}
+
+	return NULL;
+}
+
+static struct acpi_rimt_node *rimt_node_map_id(struct acpi_rimt_node *node,
+					       u32 id_in, u32 *id_out,
+					       u8 type_mask)
+{
+	struct acpi_rimt_pcie_rc *pci_node;
+	struct acpi_rimt_platform_device *plat_node;
+	u32 id = id_in;
+	u32 id_mapping_offset, num_id_mapping;
+
+	/* Parse the ID mapping tree to find specified node type */
+	while (node) {
+		struct acpi_rimt_id_mapping *map;
+		int i, rc = 0;
+		u32 map_id = id;
+
+		if (RIMT_TYPE_MASK(node->type) & type_mask) {
+			if (id_out)
+				*id_out = id;
+			return node;
+		}
+
+		if (node->type == ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX) {
+			pci_node = (struct acpi_rimt_pcie_rc *)&node->node_data;
+			id_mapping_offset = pci_node->id_mapping_offset;
+			num_id_mapping = pci_node->num_id_mappings;
+		} else if (node->type == ACPI_RIMT_NODE_TYPE_PLAT_DEVICE) {
+			plat_node = (struct acpi_rimt_platform_device *)&node->node_data;
+			id_mapping_offset = plat_node->id_mapping_offset;
+			num_id_mapping = plat_node->num_id_mappings;
+		} else {
+			goto fail_map;
+		}
+
+		if (!id_mapping_offset || !num_id_mapping)
+			goto fail_map;
+
+		map = ACPI_ADD_PTR(struct acpi_rimt_id_mapping, node,
+				   id_mapping_offset);
+
+		/* Firmware bug! */
+		if (!map->dest_offset) {
+			pr_err(FW_BUG "[node %p type %d] ID map has NULL parent reference\n",
+			       node, node->type);
+			goto fail_map;
+		}
+
+		/* Do the ID translation */
+		for (i = 0; i < num_id_mapping; i++, map++) {
+			rc = rimt_id_map(map, node->type, map_id, &id);
+			if (!rc)
+				break;
+		}
+
+		if (i == num_id_mapping)
+			goto fail_map;
+
+		node = ACPI_ADD_PTR(struct acpi_rimt_node, rimt_table,
+				    rc ? 0 : map->dest_offset);
+	}
+
+fail_map:
+	/* Map input ID to output ID unchanged on mapping failure */
+	if (id_out)
+		*id_out = id_in;
+
+	return NULL;
+}
+
+static struct acpi_rimt_node *rimt_node_map_platform_id(struct acpi_rimt_node *node, u32 *id_out,
+							u8 type_mask, int index)
+{
+	struct acpi_rimt_node *parent;
+	u32 id;
+
+	parent = rimt_node_get_id(node, &id, index);
+	if (!parent)
+		return NULL;
+
+	if (!(RIMT_TYPE_MASK(parent->type) & type_mask))
+		parent = rimt_node_map_id(parent, id, id_out, type_mask);
+	else
+		if (id_out)
+			*id_out = id;
+
+	return parent;
+}
+
+static int rimt_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+{
+	struct rimt_pci_alias_info *info = data;
+	struct acpi_rimt_node *parent;
+	u32 deviceid;
+
+	parent = rimt_node_map_id(info->node, alias, &deviceid, RIMT_IOMMU_TYPE);
+	return rimt_iommu_xlate(info->dev, parent, deviceid);
+}
+
+/*
+ * RISC-V supports IOMMU as a PCI device or a platform device.
+ * When it is a platform device, there should be a namespace device as
+ * well along with RIMT. To create the link between RIMT information and
+ * the platform device, the IOMMU driver should register itself with the
+ * RIMT module. This is true for PCI based IOMMU as well.
+ */
+int rimt_iommu_register(struct device *dev)
+{
+	struct fwnode_handle *rimt_fwnode;
+	struct acpi_rimt_node *node;
+
+	node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_IOMMU, dev);
+	if (!node) {
+		pr_err("Could not find IOMMU node in RIMT\n");
+		return -ENODEV;
+	}
+
+	if (dev_is_pci(dev)) {
+		rimt_fwnode = acpi_alloc_fwnode_static();
+		if (!rimt_fwnode)
+			return -ENOMEM;
+
+		rimt_fwnode->dev = dev;
+		if (!dev->fwnode)
+			dev->fwnode = rimt_fwnode;
+
+		rimt_set_fwnode(node, rimt_fwnode);
+	} else {
+		rimt_set_fwnode(node, dev->fwnode);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_IOMMU_API
+
+static int rimt_plat_iommu_map(struct device *dev, struct acpi_rimt_node *node)
+{
+	struct acpi_rimt_node *parent;
+	int err = -ENODEV, i = 0;
+	u32 deviceid = 0;
+
+	do {
+		parent = rimt_node_map_platform_id(node, &deviceid,
+						   RIMT_IOMMU_TYPE,
+						   i++);
+
+		if (parent)
+			err = rimt_iommu_xlate(dev, parent, deviceid);
+	} while (parent && !err);
+
+	return err;
+}
+
+static int rimt_plat_iommu_map_id(struct device *dev,
+				  struct acpi_rimt_node *node,
+				  const u32 *in_id)
+{
+	struct acpi_rimt_node *parent;
+	u32 deviceid;
+
+	parent = rimt_node_map_id(node, *in_id, &deviceid, RIMT_IOMMU_TYPE);
+	if (parent)
+		return rimt_iommu_xlate(dev, parent, deviceid);
+
+	return -ENODEV;
+}
+
+/**
+ * rimt_iommu_configure_id - Set-up IOMMU configuration for a device.
+ *
+ * @dev: device to configure
+ * @id_in: optional input id const value pointer
+ *
+ * Returns: 0 on success, <0 on failure
+ */
+int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	struct acpi_rimt_node *node;
+	int err = -ENODEV;
+
+	if (dev_is_pci(dev)) {
+		struct iommu_fwspec *fwspec;
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		struct rimt_pci_alias_info info = { .dev = dev };
+
+		node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_PCIE_ROOT_COMPLEX, &bus->dev);
+		if (!node)
+			return -ENODEV;
+
+		info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     rimt_pci_iommu_init, &info);
+
+		fwspec = dev_iommu_fwspec_get(dev);
+		if (fwspec && rimt_pcie_rc_supports_ats(node))
+			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
+	} else {
+		node = rimt_scan_node(ACPI_RIMT_NODE_TYPE_PLAT_DEVICE, dev);
+		if (!node)
+			return -ENODEV;
+
+		err = id_in ? rimt_plat_iommu_map_id(dev, node, id_in) :
+			      rimt_plat_iommu_map(dev, node);
+	}
+
+	return err;
+}
+
+#else
+int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	return -ENODEV;
+}
+#endif
+
+void __init riscv_acpi_rimt_init(void)
+{
+	acpi_status status;
+
+	/* rimt_table will be used at runtime after the rimt init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the RIMT table mapping.
+	 */
+	status = acpi_get_table(ACPI_SIG_RIMT, 0, &rimt_table);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get table, %s\n", msg);
+		}
+
+		return;
+	}
+}
diff --git a/include/linux/acpi_rimt.h b/include/linux/acpi_rimt.h
new file mode 100644
index 000000000000..ce4d136d4f81
--- /dev/null
+++ b/include/linux/acpi_rimt.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  Copyright (C) 2024-2025, Ventana Micro Systems Inc.
+ *	Author: Sunil V L <sunilvl@ventanamicro.com>
+ */
+
+#ifndef _ACPI_RIMT_H
+#define _ACPI_RIMT_H
+
+#ifdef CONFIG_ACPI_RIMT
+int rimt_iommu_configure_id(struct device *dev, const u32 *id_in);
+
+int rimt_iommu_register(struct device *dev);
+#else
+static inline int rimt_iommu_register(struct device *dev)
+{
+	return -ENODEV;
+}
+
+static inline int rimt_iommu_configure_id(struct device *dev, const u32 *id_in)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* _ACPI_RIMT_H */
-- 
2.43.0


