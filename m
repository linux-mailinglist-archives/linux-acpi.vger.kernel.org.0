Return-Path: <linux-acpi+bounces-2543-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC1818E78
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 18:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F01E81F232D7
	for <lists+linux-acpi@lfdr.de>; Tue, 19 Dec 2023 17:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F4C37D04;
	Tue, 19 Dec 2023 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="h4nQxSg7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6CE37894
	for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3b8184a84so12625215ad.1
        for <linux-acpi@vger.kernel.org>; Tue, 19 Dec 2023 09:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1703007941; x=1703612741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTCmyL8q1x2NekUk0mD7VzWJPBPZf/tU9IYpoiSJ7Kg=;
        b=h4nQxSg7gnMMOiJFn/C/dZXUV0d2eQHSj7ghMsXkHR7XubRmJsxAJXk+sRYeB+icY2
         vfvtCG4BMPk9F8OGsyABCfE/T/7HZzOddm7uv9fF7NgcEVIi1Z5z3qGxOzZoO1+qcD4J
         6D6mJnd1nw2sceKa1eRO/1sCqVKEqKU1U2yckMSahGed7np7iohLuxUZBY1Owc5JF2M9
         Ua6Q7UZd6mPQSx6+WyUJJxdZp5GpvPW2VGvcBLA1j4tIYlov+e3Q4WY0DPPTtc3W+1NS
         K29X/kxUXw+HpnQaBOZiH4GtSk5Xq64YQB4oFuF0D0NSbbhBJSbObctxVidiWDebKkJy
         PliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703007941; x=1703612741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTCmyL8q1x2NekUk0mD7VzWJPBPZf/tU9IYpoiSJ7Kg=;
        b=jM+IGWGGkGxfsTfpK2QDvgE70PaXhCE8jD9YuTNQkLcSFMJHWq2tB0WwbrHj2rpXmn
         Wtsv1t2mMJ9wPE5KBbjLuKJf29Es8VTJZds+PEn64hM9LvpolnzJBKB1gomZ9DJhi+GG
         O8aCUe72+/qW8DqwdZ2xCbBXVXv9XGFgfaTeXfV1M9Jn7JuZzMmIQnEmyNHtJ83UDPZ8
         eClFzdoQG5OVghPiHSPWa3162xFRJptEk7qhtkoK+tg61LPDN5xQM6xm7+R+/vidyA1a
         7EwRaFrBTECKzl30e+Ic1Csouqw51wcX2ZrrjWRkqX3n/SJh+iDAiMiyFmTHL9rumIw5
         Dw/w==
X-Gm-Message-State: AOJu0Yw1bYF5MBoHIlRjEEe33lHMq/RiVtQARWn7qz5r1skZoxVcnzMW
	nG1NmzunazEx0tOxyxqgkeNgcQ==
X-Google-Smtp-Source: AGHT+IELnIzuBGe8+RpsYfu1MC+dDMJxMjOPO9pnKrkvwFqAtmLHYJqz6ZK2d+FJftV0n02FxckgOg==
X-Received: by 2002:a17:902:ea03:b0:1d3:c08d:ba9b with SMTP id s3-20020a170902ea0300b001d3c08dba9bmr2802604plg.13.1703007941143;
        Tue, 19 Dec 2023 09:45:41 -0800 (PST)
Received: from sunil-pc.Dlink ([106.51.188.200])
        by smtp.gmail.com with ESMTPSA id n16-20020a170903111000b001d3320f6143sm14453015plh.269.2023.12.19.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 09:45:40 -0800 (PST)
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
Subject: [RFC PATCH v3 01/17] arm64: PCI: Migrate ACPI related functions to pci-acpi.c
Date: Tue, 19 Dec 2023 23:15:10 +0530
Message-Id: <20231219174526.2235150-2-sunilvl@ventanamicro.com>
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

The functions defined in arm64 for ACPI support are required
for RISC-V also. To avoid duplication, move these functions
to common location.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/arm64/kernel/pci.c | 191 ----------------------------------------
 drivers/pci/pci-acpi.c  | 182 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 182 insertions(+), 191 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index f872c57e9909..fd9a7bed83ce 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -6,28 +6,7 @@
  * Copyright (C) 2014 ARM Ltd.
  */
 
-#include <linux/acpi.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/pci-acpi.h>
-#include <linux/pci-ecam.h>
-#include <linux/slab.h>
-
-#ifdef CONFIG_ACPI
-/*
- * Try to assign the IRQ number when probing a new device
- */
-int pcibios_alloc_irq(struct pci_dev *dev)
-{
-	if (!acpi_disabled)
-		acpi_pci_irq_enable(dev);
-
-	return 0;
-}
-#endif
 
 /*
  * raw_pci_read/write - Platform-specific PCI config space access.
@@ -61,173 +40,3 @@ int pcibus_to_node(struct pci_bus *bus)
 EXPORT_SYMBOL(pcibus_to_node);
 
 #endif
-
-#ifdef CONFIG_ACPI
-
-struct acpi_pci_generic_root_info {
-	struct acpi_pci_root_info	common;
-	struct pci_config_window	*cfg;	/* config space mapping */
-};
-
-int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
-{
-	struct pci_config_window *cfg = bus->sysdata;
-	struct acpi_device *adev = to_acpi_device(cfg->parent);
-	struct acpi_pci_root *root = acpi_driver_data(adev);
-
-	return root->segment;
-}
-
-int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
-{
-	struct pci_config_window *cfg;
-	struct acpi_device *adev;
-	struct device *bus_dev;
-
-	if (acpi_disabled)
-		return 0;
-
-	cfg = bridge->bus->sysdata;
-
-	/*
-	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
-	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
-	 * NULL in this case because there is no proper ACPI device.
-	 */
-	if (!cfg->parent)
-		adev = NULL;
-	else
-		adev = to_acpi_device(cfg->parent);
-
-	bus_dev = &bridge->bus->dev;
-
-	ACPI_COMPANION_SET(&bridge->dev, adev);
-	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
-
-	return 0;
-}
-
-static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
-{
-	struct resource_entry *entry, *tmp;
-	int status;
-
-	status = acpi_pci_probe_root_resources(ci);
-	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
-		if (!(entry->res->flags & IORESOURCE_WINDOW))
-			resource_list_destroy_entry(entry);
-	}
-	return status;
-}
-
-/*
- * Lookup the bus range for the domain in MCFG, and set up config space
- * mapping.
- */
-static struct pci_config_window *
-pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
-{
-	struct device *dev = &root->device->dev;
-	struct resource *bus_res = &root->secondary;
-	u16 seg = root->segment;
-	const struct pci_ecam_ops *ecam_ops;
-	struct resource cfgres;
-	struct acpi_device *adev;
-	struct pci_config_window *cfg;
-	int ret;
-
-	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
-	if (ret) {
-		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
-		return NULL;
-	}
-
-	adev = acpi_resource_consumer(&cfgres);
-	if (adev)
-		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
-			 dev_name(&adev->dev));
-	else
-		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
-			 &cfgres);
-
-	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
-	if (IS_ERR(cfg)) {
-		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
-			PTR_ERR(cfg));
-		return NULL;
-	}
-
-	return cfg;
-}
-
-/* release_info: free resources allocated by init_info */
-static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
-{
-	struct acpi_pci_generic_root_info *ri;
-
-	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
-	pci_ecam_free(ri->cfg);
-	kfree(ci->ops);
-	kfree(ri);
-}
-
-/* Interface called from ACPI code to setup PCI host controller */
-struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
-{
-	struct acpi_pci_generic_root_info *ri;
-	struct pci_bus *bus, *child;
-	struct acpi_pci_root_ops *root_ops;
-	struct pci_host_bridge *host;
-
-	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
-	if (!ri)
-		return NULL;
-
-	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
-	if (!root_ops) {
-		kfree(ri);
-		return NULL;
-	}
-
-	ri->cfg = pci_acpi_setup_ecam_mapping(root);
-	if (!ri->cfg) {
-		kfree(ri);
-		kfree(root_ops);
-		return NULL;
-	}
-
-	root_ops->release_info = pci_acpi_generic_release_info;
-	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
-	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
-	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
-	if (!bus)
-		return NULL;
-
-	/* If we must preserve the resource configuration, claim now */
-	host = pci_find_host_bridge(bus);
-	if (host->preserve_config)
-		pci_bus_claim_resources(bus);
-
-	/*
-	 * Assign whatever was left unassigned. If we didn't claim above,
-	 * this will reassign everything.
-	 */
-	pci_assign_unassigned_root_bus_resources(bus);
-
-	list_for_each_entry(child, &bus->children, node)
-		pcie_bus_configure_settings(child);
-
-	return bus;
-}
-
-void pcibios_add_bus(struct pci_bus *bus)
-{
-	acpi_pci_add_bus(bus);
-}
-
-void pcibios_remove_bus(struct pci_bus *bus)
-{
-	acpi_pci_remove_bus(bus);
-}
-
-#endif
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a05350a4e49c..58497b25d2ab 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -15,6 +15,7 @@
 #include <linux/pci_hotplug.h>
 #include <linux/module.h>
 #include <linux/pci-acpi.h>
+#include <linux/pci-ecam.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/rwsem.h>
@@ -1518,3 +1519,184 @@ static int __init acpi_pci_init(void)
 	return 0;
 }
 arch_initcall(acpi_pci_init);
+
+#if defined(CONFIG_ARM64)
+
+/*
+ * Try to assign the IRQ number when probing a new device
+ */
+int pcibios_alloc_irq(struct pci_dev *dev)
+{
+	if (!acpi_disabled)
+		acpi_pci_irq_enable(dev);
+
+	return 0;
+}
+
+struct acpi_pci_generic_root_info {
+	struct acpi_pci_root_info	common;
+	struct pci_config_window	*cfg;	/* config space mapping */
+};
+
+int acpi_pci_bus_find_domain_nr(struct pci_bus *bus)
+{
+	struct pci_config_window *cfg = bus->sysdata;
+	struct acpi_device *adev = to_acpi_device(cfg->parent);
+	struct acpi_pci_root *root = acpi_driver_data(adev);
+
+	return root->segment;
+}
+
+int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	struct pci_config_window *cfg;
+	struct acpi_device *adev;
+	struct device *bus_dev;
+
+	if (acpi_disabled)
+		return 0;
+
+	cfg = bridge->bus->sysdata;
+
+	/*
+	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
+	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
+	 * NULL in this case because there is no proper ACPI device.
+	 */
+	if (!cfg->parent)
+		adev = NULL;
+	else
+		adev = to_acpi_device(cfg->parent);
+
+	bus_dev = &bridge->bus->dev;
+
+	ACPI_COMPANION_SET(&bridge->dev, adev);
+	set_dev_node(bus_dev, acpi_get_node(acpi_device_handle(adev)));
+
+	return 0;
+}
+
+static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
+{
+	struct resource_entry *entry, *tmp;
+	int status;
+
+	status = acpi_pci_probe_root_resources(ci);
+	resource_list_for_each_entry_safe(entry, tmp, &ci->resources) {
+		if (!(entry->res->flags & IORESOURCE_WINDOW))
+			resource_list_destroy_entry(entry);
+	}
+	return status;
+}
+
+/*
+ * Lookup the bus range for the domain in MCFG, and set up config space
+ * mapping.
+ */
+static struct pci_config_window *
+pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
+{
+	struct device *dev = &root->device->dev;
+	struct resource *bus_res = &root->secondary;
+	u16 seg = root->segment;
+	const struct pci_ecam_ops *ecam_ops;
+	struct resource cfgres;
+	struct acpi_device *adev;
+	struct pci_config_window *cfg;
+	int ret;
+
+	ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
+	if (ret) {
+		dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
+		return NULL;
+	}
+
+	adev = acpi_resource_consumer(&cfgres);
+	if (adev)
+		dev_info(dev, "ECAM area %pR reserved by %s\n", &cfgres,
+			 dev_name(&adev->dev));
+	else
+		dev_warn(dev, FW_BUG "ECAM area %pR not reserved in ACPI namespace\n",
+			 &cfgres);
+
+	cfg = pci_ecam_create(dev, &cfgres, bus_res, ecam_ops);
+	if (IS_ERR(cfg)) {
+		dev_err(dev, "%04x:%pR error %ld mapping ECAM\n", seg, bus_res,
+			PTR_ERR(cfg));
+		return NULL;
+	}
+
+	return cfg;
+}
+
+/* release_info: free resources allocated by init_info */
+static void pci_acpi_generic_release_info(struct acpi_pci_root_info *ci)
+{
+	struct acpi_pci_generic_root_info *ri;
+
+	ri = container_of(ci, struct acpi_pci_generic_root_info, common);
+	pci_ecam_free(ri->cfg);
+	kfree(ci->ops);
+	kfree(ri);
+}
+
+/* Interface called from ACPI code to setup PCI host controller */
+struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
+{
+	struct acpi_pci_generic_root_info *ri;
+	struct pci_bus *bus, *child;
+	struct acpi_pci_root_ops *root_ops;
+	struct pci_host_bridge *host;
+
+	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
+	if (!ri)
+		return NULL;
+
+	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
+	if (!root_ops) {
+		kfree(ri);
+		return NULL;
+	}
+
+	ri->cfg = pci_acpi_setup_ecam_mapping(root);
+	if (!ri->cfg) {
+		kfree(ri);
+		kfree(root_ops);
+		return NULL;
+	}
+
+	root_ops->release_info = pci_acpi_generic_release_info;
+	root_ops->prepare_resources = pci_acpi_root_prepare_resources;
+	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
+	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
+	if (!bus)
+		return NULL;
+
+	/* If we must preserve the resource configuration, claim now */
+	host = pci_find_host_bridge(bus);
+	if (host->preserve_config)
+		pci_bus_claim_resources(bus);
+
+	/*
+	 * Assign whatever was left unassigned. If we didn't claim above,
+	 * this will reassign everything.
+	 */
+	pci_assign_unassigned_root_bus_resources(bus);
+
+	list_for_each_entry(child, &bus->children, node)
+		pcie_bus_configure_settings(child);
+
+	return bus;
+}
+
+void pcibios_add_bus(struct pci_bus *bus)
+{
+	acpi_pci_add_bus(bus);
+}
+
+void pcibios_remove_bus(struct pci_bus *bus)
+{
+	acpi_pci_remove_bus(bus);
+}
+
+#endif
-- 
2.39.2


