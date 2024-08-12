Return-Path: <linux-acpi+bounces-7520-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6223694E461
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 03:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3232809C6
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Aug 2024 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D441C6A7;
	Mon, 12 Aug 2024 01:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NNcz9afl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DF31C698
	for <linux-acpi@vger.kernel.org>; Mon, 12 Aug 2024 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723424478; cv=none; b=lT0q79CBTL7QvSrYxMAzpDFxmw9NhP9WSNtOThlI05iNmU1JCDN/BLuvlEj1shC94XkYDMsxm/WXSC/swkZ9ndKLttSm01MK3NHV4U+8HuPFxM3xoQmzHU8MlNOf6u9o3RX+lF4YHNAmdNOZHSkMvXq94ZV7fl4TEwA1xS++JzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723424478; c=relaxed/simple;
	bh=ReE9Srz82C0Zy/dKBRvUMOTV4htH2pkWtd/lD8GxrkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdnOd/Qc8cdFoCjdNTHNF9vXSuOkhY3c0BPoR0qL+gigbT88YLbsIVPIh7/1I+HOwat/46s+HzK9udvIipxuaKTfs4f/GXey5EsrUgo8/afQQyPldVd8owwKQyjcFdMBIRW27enW/SrJ+Ilr++YkhUBJXTxugH0KLQzeajZdK/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NNcz9afl; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3db157cb959so2760642b6e.0
        for <linux-acpi@vger.kernel.org>; Sun, 11 Aug 2024 18:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1723424476; x=1724029276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35RSvSvW6RgLqSoNwuCiOaL227s0j7qgYbyMMYQ5H7Y=;
        b=NNcz9aflSYL/BBb1Iu4U7E3ZV2leds3OzAQnPE7PnChAiJzPrtJqcpTPUF8gSu5y2s
         /9WCMjNCJGNC87lLZST1jk5UW9NdHkIutq6/WgGhYOi4evcH7t3+/VOMdDQI3NkbM/iS
         eV14jDFBJ8gtrxaHHsg+gRXXK5kCDRXvr8QlqPo4kVwgaDt0OwuPhCllkZc4yPmUy4q/
         wr33oPz7RskNuPwmZjPuQ5scUYeKQg72SPKyfr8jGqF6mFhCI5mIgrSdAp+7b6qy/5pb
         CiVyiwWdaq78e3UCUKj9DvoUla+KpwHCNi2xODidTn1X3TRLC6TNI+/4dtT2luvy3vsb
         I36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723424476; x=1724029276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35RSvSvW6RgLqSoNwuCiOaL227s0j7qgYbyMMYQ5H7Y=;
        b=a8BefRo7xMy1nR0w3ZH7L6nZGNcMpwOxGsZhezOm7hVeZgSVNRGMjqItt4L7LTZteE
         i4OJsZUDnl78Y22JjGjBUk6oj/jZdmKeudI7N2pUuBZqdZAUN8Vft1jIP6OfxMK657eD
         tNQ/NmzBCf1vugQQAo9b8fXZE8r9MnbqQlR0BD73KI68WTiWFhi0e4Oz/emHyoPE+Hr8
         3kOnvC2YckKqTSfgGCnKeThLrquC3ZlQ8wYp+FkBaJXXVoS0Rxb1KyHTm2zLHLSHpG3L
         wgTi73mmjOSaXO5WvCD6w4S3CyBqVB7yetxeRzYNOwSlo2JtL2ZC7e+dk8we2A/xeXzg
         LZKA==
X-Forwarded-Encrypted: i=1; AJvYcCXnQgvX6Yog7RwLPgQ1tUGdXxxas0iLZp5fP6xppK77mjAulslymSkcnxs65Ao9sQCpKu0i9laHmE+Kimue/gjH4BdF93skIR7pCQ==
X-Gm-Message-State: AOJu0YzaRLcZh4OQqe3d4K9AFqNYsWsph0d6o682avEwOLjbOhjgIA2a
	21fXTJv4v1mcIhLrh1jX1GPP0cPjxpwg/ZWPL47Y3U/RS31ws1CDZQwhX/iijNs=
X-Google-Smtp-Source: AGHT+IHYcMx/Kelfyx+/kqYvp7mnCuHmz6lHSvmrk3Q0WFeD+E3yWJz8Mmv6EPhZaFQCiBxUacTGNQ==
X-Received: by 2002:a05:6808:3209:b0:3d9:26d6:c6ed with SMTP id 5614622812f47-3dc41670fb1mr10153205b6e.3.1723424475694;
        Sun, 11 Aug 2024 18:01:15 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.198.16])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c3dbe8cbdcsm3074062a12.61.2024.08.11.18.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 18:01:15 -0700 (PDT)
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
Subject: [PATCH v8 15/17] irqchip/riscv-imsic: Add ACPI support
Date: Mon, 12 Aug 2024 06:29:27 +0530
Message-ID: <20240812005929.113499-16-sunilvl@ventanamicro.com>
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

RISC-V IMSIC interrupt controller provides IPI and MSI support.
Currently, DT based drivers setup the IPI feature early during boot but
defer setting up the MSI functionality. However, in ACPI systems, PCI
subsystem is probed early and assume MSI controller is already setup.
Hence, both IPI and MSI features need to be initialized early itself.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Björn Töpel <bjorn@rivosinc.com>
---
 drivers/irqchip/irq-riscv-imsic-early.c    | 64 +++++++++++++++++++++-
 drivers/irqchip/irq-riscv-imsic-platform.c | 32 +++++++++--
 drivers/irqchip/irq-riscv-imsic-state.c    | 57 +++++++++++--------
 drivers/irqchip/irq-riscv-imsic-state.h    |  2 +-
 include/linux/irqchip/riscv-imsic.h        |  9 +++
 5 files changed, 134 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-riscv-imsic-early.c b/drivers/irqchip/irq-riscv-imsic-early.c
index 4fbb37074d29..c5c2e6929a2f 100644
--- a/drivers/irqchip/irq-riscv-imsic-early.c
+++ b/drivers/irqchip/irq-riscv-imsic-early.c
@@ -5,13 +5,16 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/riscv-imsic.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
@@ -182,7 +185,7 @@ static int __init imsic_early_dt_init(struct device_node *node, struct device_no
 	int rc;
 
 	/* Setup IMSIC state */
-	rc = imsic_setup_state(fwnode);
+	rc = imsic_setup_state(fwnode, NULL);
 	if (rc) {
 		pr_err("%pfwP: failed to setup state (error %d)\n", fwnode, rc);
 		return rc;
@@ -199,3 +202,62 @@ static int __init imsic_early_dt_init(struct device_node *node, struct device_no
 }
 
 IRQCHIP_DECLARE(riscv_imsic, "riscv,imsics", imsic_early_dt_init);
+
+#ifdef CONFIG_ACPI
+
+static struct fwnode_handle *imsic_acpi_fwnode;
+
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev)
+{
+	return imsic_acpi_fwnode;
+}
+
+static int __init imsic_early_acpi_init(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)header;
+	int rc;
+
+	imsic_acpi_fwnode = irq_domain_alloc_named_fwnode("imsic");
+	if (!imsic_acpi_fwnode) {
+		pr_err("unable to allocate IMSIC FW node\n");
+		return -ENOMEM;
+	}
+
+	/* Setup IMSIC state */
+	rc = imsic_setup_state(imsic_acpi_fwnode, imsic);
+	if (rc) {
+		pr_err("%pfwP: failed to setup state (error %d)\n", imsic_acpi_fwnode, rc);
+		return rc;
+	}
+
+	/* Do early setup of IMSIC state and IPIs */
+	rc = imsic_early_probe(imsic_acpi_fwnode);
+	if (rc) {
+		irq_domain_free_fwnode(imsic_acpi_fwnode);
+		imsic_acpi_fwnode = NULL;
+		return rc;
+	}
+
+	rc = imsic_platform_acpi_probe(imsic_acpi_fwnode);
+
+#ifdef CONFIG_PCI
+	if (!rc)
+		pci_msi_register_fwnode_provider(&imsic_acpi_get_fwnode);
+#endif
+
+	if (rc)
+		pr_err("%pfwP: failed to register IMSIC for MSI functionality (error %d)\n",
+		       imsic_acpi_fwnode, rc);
+
+	/*
+	 * Even if imsic_platform_acpi_probe() fails, the IPI part of IMSIC can
+	 * continue to work. So, no need to return failure. This is similar to
+	 * DT where IPI works but MSI probe fails for some reason.
+	 */
+	return 0;
+}
+
+IRQCHIP_ACPI_DECLARE(riscv_imsic, ACPI_MADT_TYPE_IMSIC, NULL,
+		     1, imsic_early_acpi_init);
+#endif
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index 11723a763c10..64905e6f52d7 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/cpu.h>
 #include <linux/interrupt.h>
@@ -348,18 +349,37 @@ int imsic_irqdomain_init(void)
 	return 0;
 }
 
-static int imsic_platform_probe(struct platform_device *pdev)
+static int imsic_platform_probe_common(struct fwnode_handle *fwnode)
 {
-	struct device *dev = &pdev->dev;
-
-	if (imsic && imsic->fwnode != dev->fwnode) {
-		dev_err(dev, "fwnode mismatch\n");
+	if (imsic && imsic->fwnode != fwnode) {
+		pr_err("%pfwP: fwnode mismatch\n", fwnode);
 		return -ENODEV;
 	}
 
 	return imsic_irqdomain_init();
 }
 
+static int imsic_platform_dt_probe(struct platform_device *pdev)
+{
+	return imsic_platform_probe_common(pdev->dev.fwnode);
+}
+
+#ifdef CONFIG_ACPI
+
+/*
+ *  On ACPI based systems, PCI enumeration happens early during boot in
+ *  acpi_scan_init(). PCI enumeration expects MSI domain setup before
+ *  it calls pci_set_msi_domain(). Hence, unlike in DT where
+ *  imsic-platform drive probe happens late during boot, ACPI based
+ *  systems need to setup the MSI domain early.
+ */
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode)
+{
+	return imsic_platform_probe_common(fwnode);
+}
+
+#endif
+
 static const struct of_device_id imsic_platform_match[] = {
 	{ .compatible = "riscv,imsics" },
 	{}
@@ -370,6 +390,6 @@ static struct platform_driver imsic_platform_driver = {
 		.name		= "riscv-imsic",
 		.of_match_table	= imsic_platform_match,
 	},
-	.probe = imsic_platform_probe,
+	.probe = imsic_platform_dt_probe,
 };
 builtin_platform_driver(imsic_platform_driver);
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index f9e70832863a..b97e6cd89ed7 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -5,6 +5,7 @@
  */
 
 #define pr_fmt(fmt) "riscv-imsic: " fmt
+#include <linux/acpi.h>
 #include <linux/cpu.h>
 #include <linux/bitmap.h>
 #include <linux/interrupt.h>
@@ -564,18 +565,36 @@ static int __init imsic_populate_global_dt(struct fwnode_handle *fwnode,
 	return 0;
 }
 
+static int __init imsic_populate_global_acpi(struct fwnode_handle *fwnode,
+					     struct imsic_global_config *global,
+					     u32 *nr_parent_irqs, void *opaque)
+{
+	struct acpi_madt_imsic *imsic = (struct acpi_madt_imsic *)opaque;
+
+	global->guest_index_bits = imsic->guest_index_bits;
+	global->hart_index_bits = imsic->hart_index_bits;
+	global->group_index_bits = imsic->group_index_bits;
+	global->group_index_shift = imsic->group_index_shift;
+	global->nr_ids = imsic->num_ids;
+	global->nr_guest_ids = imsic->num_guest_ids;
+	return 0;
+}
+
 static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 					  u32 index, unsigned long *hartid)
 {
 	struct of_phandle_args parent;
 	int rc;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(fwnode))
-		return -EINVAL;
+	if (!is_of_node(fwnode)) {
+		if (hartid)
+			*hartid = acpi_rintc_index_to_hartid(index);
+
+		if (!hartid || (*hartid == INVALID_HARTID))
+			return -EINVAL;
+
+		return 0;
+	}
 
 	rc = of_irq_parse_one(to_of_node(fwnode), index, &parent);
 	if (rc)
@@ -594,12 +613,8 @@ static int __init imsic_get_parent_hartid(struct fwnode_handle *fwnode,
 static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 					  u32 index, struct resource *res)
 {
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
 	if (!is_of_node(fwnode))
-		return -EINVAL;
+		return acpi_rintc_get_imsic_mmio_info(index, res);
 
 	return of_address_to_resource(to_of_node(fwnode), index, res);
 }
@@ -607,20 +622,14 @@ static int __init imsic_get_mmio_resource(struct fwnode_handle *fwnode,
 static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 				     struct imsic_global_config *global,
 				     u32 *nr_parent_irqs,
-				     u32 *nr_mmios)
+				     u32 *nr_mmios,
+				     void *opaque)
 {
 	unsigned long hartid;
 	struct resource res;
 	int rc;
 	u32 i;
 
-	/*
-	 * Currently, only OF fwnode is supported so extend this
-	 * function for ACPI support.
-	 */
-	if (!is_of_node(fwnode))
-		return -EINVAL;
-
 	*nr_parent_irqs = 0;
 	*nr_mmios = 0;
 
@@ -632,7 +641,11 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 		return -EINVAL;
 	}
 
-	rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
+	if (is_of_node(fwnode))
+		rc = imsic_populate_global_dt(fwnode, global, nr_parent_irqs);
+	else
+		rc = imsic_populate_global_acpi(fwnode, global, nr_parent_irqs, opaque);
+
 	if (rc)
 		return rc;
 
@@ -701,7 +714,7 @@ static int __init imsic_parse_fwnode(struct fwnode_handle *fwnode,
 	return 0;
 }
 
-int __init imsic_setup_state(struct fwnode_handle *fwnode)
+int __init imsic_setup_state(struct fwnode_handle *fwnode, void *opaque)
 {
 	u32 i, j, index, nr_parent_irqs, nr_mmios, nr_handlers = 0;
 	struct imsic_global_config *global;
@@ -742,7 +755,7 @@ int __init imsic_setup_state(struct fwnode_handle *fwnode)
 	}
 
 	/* Parse IMSIC fwnode */
-	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios);
+	rc = imsic_parse_fwnode(fwnode, global, &nr_parent_irqs, &nr_mmios, opaque);
 	if (rc)
 		goto out_free_local;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.h b/drivers/irqchip/irq-riscv-imsic-state.h
index 5ae2f69b035b..391e44280827 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.h
+++ b/drivers/irqchip/irq-riscv-imsic-state.h
@@ -102,7 +102,7 @@ void imsic_vector_debug_show_summary(struct seq_file *m, int ind);
 
 void imsic_state_online(void);
 void imsic_state_offline(void);
-int imsic_setup_state(struct fwnode_handle *fwnode);
+int imsic_setup_state(struct fwnode_handle *fwnode, void *opaque);
 int imsic_irqdomain_init(void);
 
 #endif
diff --git a/include/linux/irqchip/riscv-imsic.h b/include/linux/irqchip/riscv-imsic.h
index faf0b800b1b0..7494952c5518 100644
--- a/include/linux/irqchip/riscv-imsic.h
+++ b/include/linux/irqchip/riscv-imsic.h
@@ -8,6 +8,8 @@
 
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/fwnode.h>
 #include <asm/csr.h>
 
 #define IMSIC_MMIO_PAGE_SHIFT		12
@@ -84,4 +86,11 @@ static inline const struct imsic_global_config *imsic_get_global_config(void)
 
 #endif
 
+#ifdef CONFIG_ACPI
+int imsic_platform_acpi_probe(struct fwnode_handle *fwnode);
+struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev);
+#else
+static inline struct fwnode_handle *imsic_acpi_get_fwnode(struct device *dev) { return NULL; }
+#endif
+
 #endif
-- 
2.43.0


