Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA83483B4
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 22:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238412AbhCXVbH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 17:31:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:36788 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238397AbhCXVay (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 17:30:54 -0400
IronPort-SDR: g6z1wfcDIxXbYlbJhwxSVOLbDcfEZk/8BPcPeSBRQ3vgAP2SzRRwrwRjp9t4YrDG/CBCxB+hQQ
 s/Pg9R0nhW0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177908498"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="177908498"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:52 -0700
IronPort-SDR: GMOa2NS/5Me06ORI3sXXdVpVm477rMl82Bqg0bE5dTxrg5FLVB7uJcJzhYkvHk4yuTiTBcaQLR
 h88jc2Uukbfw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="436182162"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:51 -0700
Subject: [PATCH 5/8] cxl/acpi: Introduce ACPI0017 driver and cxl_root
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:30:51 -0700
Message-ID: <161662145142.1723715.9512671878498463861.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

While CXL builds upon the PCI software model for dynamic enumeration and
control, a static platform component is required to bootstrap the CXL
memory layout. In addition to identifying the host bridges ACPI is
responsible for enumerating the CXL memory space that can be addressed
by decoders. This is similar to the requirement for ACPI to publish
resources reported by _CRS for PCI host bridges.

Introduce the cxl_root object as an abstract "port" into the CXL.mem
address space described by HDM decoders identified by the ACPI
CEDT.CHBS.

For now just establish the initial boilerplate and sysfs attributes, to
be followed by enumeration of the ports within the host bridge.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig  |   14 ++
 drivers/cxl/Makefile |    2 
 drivers/cxl/acpi.c   |   39 +++++++
 drivers/cxl/core.c   |  285 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h    |   64 +++++++++++
 5 files changed, 404 insertions(+)
 create mode 100644 drivers/cxl/acpi.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..fb282af84afd 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -50,4 +50,18 @@ config CXL_MEM_RAW_COMMANDS
 	  potential impact to memory currently in use by the kernel.
 
 	  If developing CXL hardware or the driver say Y, otherwise say N.
+
+config CXL_ACPI
+	tristate "CXL ACPI: Platform Support"
+	depends on ACPI
+	help
+	  Enable support for host managed device memory (HDM) resources
+	  published by a platform's ACPI CXL memory layout description.
+	  See Chapter 9.14.1 CXL Early Discovery Table (CEDT) in the CXL
+	  2.0 specification. The CXL core consumes these resource to
+	  publish port and address_space objects used to map regions
+	  that represent System RAM, or Persistent Memory regions to be
+	  managed by LIBNVDIMM.
+
+	  If unsure say 'm'.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 3808e39dd31f..f429ca6b59d9 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_core-y := core.o
 cxl_mem-y := mem.o
+cxl_acpi-y := acpi.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
new file mode 100644
index 000000000000..d54c2d5de730
--- /dev/null
+++ b/drivers/cxl/acpi.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/acpi.h>
+#include "cxl.h"
+
+static int cxl_acpi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_root *cxl_root;
+
+	cxl_root = devm_cxl_add_root(dev, NULL, 0);
+	if (IS_ERR(cxl_root))
+		return PTR_ERR(cxl_root);
+	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));
+
+	return 0;
+}
+
+static const struct acpi_device_id cxl_acpi_ids[] = {
+	{ "ACPI0017", 0 },
+	{ "", 0 },
+};
+MODULE_DEVICE_TABLE(acpi, cxl_acpi_ids);
+
+static struct platform_driver cxl_acpi_driver = {
+	.probe = cxl_acpi_probe,
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.acpi_match_table = cxl_acpi_ids,
+	},
+};
+
+module_platform_driver(cxl_acpi_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 2ab467ef9909..07b58cfda392 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -2,6 +2,8 @@
 /* Copyright(c) 2020-2021 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
 #include "cxl.h"
 
 /**
@@ -11,6 +13,289 @@
  * point for cross-device interleave coordination through cxl ports.
  */
 
+static DEFINE_IDA(cxl_port_ida);
+
+static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
+			    char *buf)
+{
+	return sysfs_emit(buf, "%s\n", dev->type->name);
+}
+static DEVICE_ATTR_RO(devtype);
+
+static struct attribute *cxl_base_attributes[] = {
+	&dev_attr_devtype.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_base_attribute_group = {
+	.attrs = cxl_base_attributes,
+};
+
+static struct cxl_address_space *dev_to_address_space(struct device *dev)
+{
+	struct cxl_address_space_dev *cxl_asd = to_cxl_address_space(dev);
+
+	return cxl_asd->address_space;
+}
+
+static ssize_t start_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct cxl_address_space *space = dev_to_address_space(dev);
+
+	return sysfs_emit(buf, "%#llx\n", space->range.start);
+}
+static DEVICE_ATTR_RO(start);
+
+static ssize_t end_show(struct device *dev, struct device_attribute *attr,
+			char *buf)
+{
+	struct cxl_address_space *space = dev_to_address_space(dev);
+
+	return sysfs_emit(buf, "%#llx\n", space->range.end);
+}
+static DEVICE_ATTR_RO(end);
+
+#define CXL_ATTR_SUPPORTS(name, flag)                                  \
+static ssize_t supports_##name##_show(                                 \
+	struct device *dev, struct device_attribute *attr, char *buf)  \
+{                                                                      \
+	struct cxl_address_space *space = dev_to_address_space(dev);   \
+                                                                       \
+	return sysfs_emit(buf, "%s\n",                                 \
+			  (space->flags & (flag)) ? "1" : "0");        \
+}                                                                      \
+static DEVICE_ATTR_RO(supports_##name)
+
+CXL_ATTR_SUPPORTS(pmem, CXL_ADDRSPACE_PMEM);
+CXL_ATTR_SUPPORTS(ram, CXL_ADDRSPACE_RAM);
+CXL_ATTR_SUPPORTS(type2, CXL_ADDRSPACE_TYPE2);
+CXL_ATTR_SUPPORTS(type3, CXL_ADDRSPACE_TYPE3);
+
+static struct attribute *cxl_address_space_attributes[] = {
+	&dev_attr_start.attr,
+	&dev_attr_end.attr,
+	&dev_attr_supports_pmem.attr,
+	&dev_attr_supports_ram.attr,
+	&dev_attr_supports_type2.attr,
+	&dev_attr_supports_type3.attr,
+	NULL,
+};
+
+static umode_t cxl_address_space_visible(struct kobject *kobj,
+					 struct attribute *a, int n)
+{
+	struct device *dev = container_of(kobj, struct device, kobj);
+	struct cxl_address_space *space = dev_to_address_space(dev);
+
+	if (a == &dev_attr_supports_pmem.attr &&
+	    !(space->flags & CXL_ADDRSPACE_PMEM))
+		return 0;
+
+	if (a == &dev_attr_supports_ram.attr &&
+	    !(space->flags & CXL_ADDRSPACE_RAM))
+		return 0;
+
+	if (a == &dev_attr_supports_type2.attr &&
+	    !(space->flags & CXL_ADDRSPACE_TYPE2))
+		return 0;
+
+	if (a == &dev_attr_supports_type3.attr &&
+	    !(space->flags & CXL_ADDRSPACE_TYPE3))
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute_group cxl_address_space_attribute_group = {
+	.attrs = cxl_address_space_attributes,
+	.is_visible = cxl_address_space_visible,
+};
+
+static const struct attribute_group *cxl_address_space_attribute_groups[] = {
+	&cxl_address_space_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+static void cxl_address_space_release(struct device *dev)
+{
+	struct cxl_address_space_dev *cxl_asd = to_cxl_address_space(dev);
+
+	remove_resource(&cxl_asd->res);
+	kfree(cxl_asd);
+}
+
+static const struct device_type cxl_address_space_type = {
+	.name = "cxl_address_space",
+	.release = cxl_address_space_release,
+	.groups = cxl_address_space_attribute_groups,
+};
+
+struct cxl_address_space_dev *to_cxl_address_space(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_address_space_type,
+			  "not a cxl_address_space device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_address_space_dev, dev);
+}
+
+static void cxl_root_release(struct device *dev)
+{
+	struct cxl_root *cxl_root = to_cxl_root(dev);
+
+	ida_free(&cxl_port_ida, cxl_root->port.id);
+	kfree(cxl_root);
+}
+
+static ssize_t target_id_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_port *cxl_port = to_cxl_port(dev);
+
+	return sysfs_emit(buf, "%d\n", cxl_port->target_id);
+}
+static DEVICE_ATTR_RO(target_id);
+
+static struct attribute *cxl_port_attributes[] = {
+	&dev_attr_target_id.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_port_attribute_group = {
+	.attrs = cxl_port_attributes,
+};
+
+static const struct attribute_group *cxl_port_attribute_groups[] = {
+	&cxl_port_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
+static const struct device_type cxl_root_type = {
+	.name = "cxl_root",
+	.release = cxl_root_release,
+	.groups = cxl_port_attribute_groups,
+};
+
+struct cxl_root *to_cxl_root(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
+			  "not a cxl_root device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_root, port.dev);
+}
+
+struct cxl_port *to_cxl_port(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
+			  "not a cxl_port device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_port, dev);
+}
+
+static void unregister_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+struct cxl_root *devm_cxl_add_root(struct device *parent,
+				   struct cxl_address_space *cxl_space,
+				   int nr_spaces)
+{
+	struct cxl_root *cxl_root;
+	struct cxl_port *port;
+	struct device *dev;
+	int i, rc;
+
+	cxl_root = kzalloc(struct_size(cxl_root, address_space, nr_spaces),
+			   GFP_KERNEL);
+	if (!cxl_root)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(cxl_root->address_space, cxl_space,
+	       flex_array_size(cxl_root, address_space, nr_spaces));
+	cxl_root->nr_spaces = nr_spaces;
+
+	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
+	if (rc < 0) {
+		kfree(cxl_root);
+		return ERR_PTR(rc);
+	}
+	port = &cxl_root->port;
+	port->id = rc;
+
+	dev = &port->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = parent;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_root_type;
+
+	rc = dev_set_name(dev, "root%d", port->id);
+	if (rc == 0)
+		rc = device_add(dev);
+
+	if (rc) {
+		put_device(dev);
+		return ERR_PTR(rc);
+	}
+
+	rc = devm_add_action_or_reset(parent, unregister_dev, dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	for (i = 0; i < nr_spaces; i++) {
+		struct cxl_address_space *space = &cxl_root->address_space[i];
+		struct cxl_address_space_dev *cxl_asd;
+		struct resource *res;
+
+		if (!range_len(&space->range))
+			continue;
+
+		cxl_asd = kzalloc(sizeof(*cxl_asd), GFP_KERNEL);
+		if (!cxl_asd)
+			return ERR_PTR(-ENOMEM);
+
+		res = &cxl_asd->res;
+		res->name = "CXL Address Space";
+		res->start = space->range.start;
+		res->end = space->range.end;
+		res->flags = IORESOURCE_MEM;
+
+		rc = insert_resource(&iomem_resource, res);
+		if (rc) {
+			kfree(cxl_asd);
+			return ERR_PTR(rc);
+		}
+
+		cxl_asd->address_space = space;
+		dev = &cxl_asd->dev;
+		device_initialize(dev);
+		device_set_pm_not_required(dev);
+		dev->parent = &port->dev;
+		dev->type = &cxl_address_space_type;
+
+		rc = dev_set_name(dev, "address_space%d", i);
+		if (rc == 0)
+			rc = device_add(dev);
+
+		if (rc) {
+			put_device(dev);
+			return ERR_PTR(rc);
+		}
+		dev_dbg(parent, "%s: register %s\n", dev_name(&port->dev),
+			dev_name(dev));
+
+		rc = devm_add_action_or_reset(parent, unregister_dev, dev);
+		if (rc)
+			return ERR_PTR(rc);
+	}
+
+	return cxl_root;
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_root);
+
 /*
  * cxl_setup_device_regs() - Detect CXL Device register blocks
  * @dev: Host device of the @base mapping
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cbd29650c4e2..f1a2271cfbb5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -70,5 +70,69 @@ struct cxl_regs {
 void cxl_setup_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_regs *regs);
 
+/*
+ * Address space properties derived from:
+ * CXL 2.0 8.2.5.12.7 CXL HDM Decoder 0 Control Register
+ */
+#define CXL_ADDRSPACE_RAM   BIT(0)
+#define CXL_ADDRSPACE_PMEM  BIT(1)
+#define CXL_ADDRSPACE_TYPE2 BIT(2)
+#define CXL_ADDRSPACE_TYPE3 BIT(3)
+#define CXL_ADDRSPACE_MASK  GENMASK(3, 0)
+
+struct cxl_address_space {
+	struct range range;
+	int interleave_size;
+	unsigned long flags;
+	unsigned long targets;
+};
+
+struct cxl_address_space_dev {
+	struct device dev;
+	struct resource res;
+	struct cxl_address_space *address_space;
+};
+
+/**
+ * struct cxl_port - object representing a root, upstream, or downstream port
+ * @dev: this port's device
+ * @port_dev: PCI or platform device host of the CXL capability
+ * @id: id for port device-name
+ * @target_id: this port's HDM decoder id in the parent port
+ * @regs: hardware registers
+ */
+struct cxl_port {
+	struct device dev;
+	struct device *port_dev;
+	int id;
+	int target_id;
+	struct cxl_regs *regs;
+};
+
+/*
+ * struct cxl_root - platform object parent of CXL host bridges
+ *
+ * A cxl_root object represents a set of address spaces that are
+ * interleaved across a set of child host bridges, but never interleaved
+ * to another cxl_root object. It contains a cxl_port that is a special
+ * case in that it does not have a parent port and related HDMs, instead
+ * its decode is derived from the root (platform firmware defined)
+ * address space description. Not to be confused with CXL Root Ports
+ * that are the PCIE Root Ports within PCIE Host Bridges that are
+ * flagged by platform firmware (ACPI0016 on ACPI platforms) as having
+ * CXL capabilities.
+ */
+struct cxl_root {
+	struct cxl_port port;
+	int nr_spaces;
+	struct cxl_address_space address_space[];
+};
+
+struct cxl_root *to_cxl_root(struct device *dev);
+struct cxl_port *to_cxl_port(struct device *dev);
+struct cxl_address_space_dev *to_cxl_address_space(struct device *dev);
+struct cxl_root *devm_cxl_add_root(struct device *parent,
+				   struct cxl_address_space *cxl_space,
+				   int nr_spaces);
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */

