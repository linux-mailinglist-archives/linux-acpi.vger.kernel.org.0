Return-Path: <linux-acpi+bounces-2557-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCD818EB9
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F7C1C24DB6
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF33FE24;
	Tue, 19 Dec 2023 17:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="WsgdaWQA"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35950405EF
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d3165ac96bso1777545b3a.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703008019; x=1703612819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMG56uSWd/ufo/nc8FBDk9fzkMf+1BzSryO0Av4W69w=;
        b=WsgdaWQAUfzZZJcTIlfK1SZGlqDw3AjZkU2fQx/GMWXGj7NfWyp/x5DLjA86c3P/wE
         mOsAc597URWmWVAK8mXf+mbcJYCKKCEnaTeUCWbipxcDyHPpkLJsyQ2JHb847+2rvpmi
         r3LZZDvES8rvq4nzd+Af7ypJ+eBDL68yFM80EMnB5uQCCIgI7YiBdgzUGlYndHvhpTPb
         k4d8o1IRVZ9QjrgOP8CL5jyMinjpf7mKfgpJk6iW8IPw9Cf5U8HFurn3bz2ledXMtBh0
         aPgXgVqIlnNgMIpKfdiHwjFCDM+lKiZ2pvhUYcUCn0tFmUAOLWXlL8TjDukDd33ay1yd
         zPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703008019; x=1703612819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMG56uSWd/ufo/nc8FBDk9fzkMf+1BzSryO0Av4W69w=;
        b=vx6/59JzvZC7BZpLAfBYcTqITXu+Gb7fFzC3ZA7f8Dg1ImSK4cpJgPu0ezO7p7ChHS
         kLx7GMb6k9E14urlH15waXU1f1EcO6PjE2ClC0EEnUOWGSOsqppYiffxlT4HSuRLEUTh
         jSsA08gtYuN8+r2bU/cfiHytPkWPfrxxEE20LhaeHdCO9jpJbQBWgnbI2/xoqhIxUcxu
         4KqDMTbhap0rlOSqi9xEchOhCjABeLllDeSGWfGkY5nL/1q3CuFCwl1D7M4SWw+CFGD8
         9b/bY7EXKhrAUC7ZShpw/SWcRcfo54uZnbZ/Gn7LhjKFsfLRYhflslmYMV/Qoj34mJKt
         0duA==
X-Gm-Message-State: AOJu0Yzt3fas1XDfMhb5R6mKwA7v65q2GhqV0UtGknTLSKy+m+A+L9Q8
	6O2HupV+Y4P3/MmI3MFDDUOgyg==
X-Google-Smtp-Source: AGHT+IHXM72nArT21GjLZtiiN3K06SzkiamqR5ZRviUGxMyVpE460cqqru+VtpRXXtaDP8/IywYfuQ==
X-Received: by 2002:a17:902:eb8a:b0:1d3:da07:5731 with SMTP id q10-20020a170902eb8a00b001d3da075731mr1397869plg.22.1703008019566;
        Tue, 19 Dec 2023 09:46:59 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:46:59 -0800 (PST)
From: Sunil V L <sunilvl@ventanamicro.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Haibo Xu <haibo1.xu@intel.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>
Subject: [RFC PATCH v3 15/17] ACPI: RISC-V: Create APLIC platform device
Date: Tue, 19 Dec 2023 23:15:24 +0530
Message-Id: <20231219174526.2235150-16-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
References: <20231219174526.2235150-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since APLIC needs to be a platform device, probe the MADT and create
platform devices for each APLIC in the system.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/acpi/riscv/init.c |   2 +
 drivers/acpi/riscv/init.h |   5 ++
 drivers/acpi/riscv/irq.c  | 118 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/acpi/riscv/init.h

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index b5807bbdb171..e7eff7ab1474 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -6,7 +6,9 @@
  */
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_riscv_init(void)
 {
+	riscv_acpi_aplic_platform_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
new file mode 100644
index 000000000000..17bcf0baaadb
--- /dev/null
+++ b/drivers/acpi/riscv/init.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init riscv_acpi_imsic_platform_init(void);
+void __init riscv_acpi_aplic_platform_init(void);
diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
index 36e0525b3235..d08a851ab6dc 100644
--- a/drivers/acpi/riscv/irq.c
+++ b/drivers/acpi/riscv/irq.c
@@ -6,7 +6,36 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/platform_device.h>
 #include <linux/sort.h>
+#include "init.h"
+
+static LIST_HEAD(ext_intc_list);
+
+struct ext_intc_fwnode_list {
+	struct fwnode_handle *fwnode;
+	u32 gsi_base;
+	u32 nr_irqs;
+	struct list_head list;
+};
+
+struct fwnode_handle *ext_entc_get_gsi_domain_id(u32 gsi)
+{
+	struct ext_intc_fwnode_list *ext_intc_element;
+	struct list_head *i, *tmp;
+
+	/* Find the External Interrupt controller that manages this GSI. */
+	list_for_each_safe(i, tmp, &ext_intc_list) {
+		ext_intc_element = list_entry(i, struct ext_intc_fwnode_list, list);
+		if (gsi >= ext_intc_element->gsi_base &&
+		    gsi < (ext_intc_element->gsi_base + ext_intc_element->nr_irqs))
+			return ext_intc_element->fwnode;
+	}
+
+	return NULL;
+}
 
 static int irqchip_cmp_func(const void *in0, const void *in1)
 {
@@ -30,3 +59,92 @@ void arch_sort_irqchip_probe(struct acpi_probe_entry *ap_head, int nr)
 		return;
 	sort(ape, nr, sizeof(*ape), irqchip_cmp_func, NULL);
 }
+
+static int __init irqchip_add_platform_device(char *irqchip_name, u32 irqchip_id,
+					      resource_size_t iomem_res_start,
+					      resource_size_t iomem_res_size,
+					      u32 gsi_base,
+					      u32 nr_irqs,
+					      union acpi_subtable_headers *header)
+{
+	struct ext_intc_fwnode_list *ext_intc_element;
+	struct platform_device *pdev;
+	struct fwnode_handle *fn;
+	struct resource *res;
+	int ret;
+
+	fn = irq_domain_alloc_named_id_fwnode(irqchip_name, irqchip_id);
+	if (!fn)
+		return -ENOMEM;
+
+	pdev = platform_device_alloc(irqchip_name, irqchip_id);
+	if (!pdev) {
+		irq_domain_free_fwnode(fn);
+		return -ENOMEM;
+	}
+
+	res = kcalloc(1, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return -ENOMEM;
+	}
+
+	ext_intc_element = kcalloc(1, sizeof(*ext_intc_element), GFP_KERNEL);
+	if (!ext_intc_element)
+		return -ENOMEM;
+
+	ext_intc_element->fwnode = fn;
+	ext_intc_element->gsi_base = gsi_base;
+	ext_intc_element->nr_irqs = nr_irqs;
+	list_add_tail(&ext_intc_element->list, &ext_intc_list);
+
+	res->start = iomem_res_start;
+	res->end = res->start + iomem_res_size - 1;
+	res->flags = IORESOURCE_MEM;
+	ret = platform_device_add_resources(pdev, res, 1);
+	/*
+	 * Resources are duplicated in platform_device_add_resources,
+	 * free their allocated memory
+	 */
+	kfree(res);
+
+	/*
+	 * Add copy of aplic pointer so that platform driver get aplic details.
+	 */
+	ret = platform_device_add_data(pdev, &header, sizeof(header));
+	if (ret) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	pdev->dev.fwnode = fn;
+	ret = platform_device_add(pdev);
+	if (ret) {
+		irq_domain_free_fwnode(fn);
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __init aplic_parse_madt(union acpi_subtable_headers *header,
+				   const unsigned long end)
+{
+	struct acpi_madt_aplic *aplic = (struct acpi_madt_aplic *)header;
+
+	return irqchip_add_platform_device("riscv-aplic",
+					   aplic->id,
+					   aplic->base_addr,
+					   aplic->size,
+					   aplic->gsi_base,
+					   aplic->num_sources,
+					   header);
+}
+
+void __init riscv_acpi_aplic_platform_init(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_APLIC, aplic_parse_madt, 0);
+}
-- 
2.39.2


