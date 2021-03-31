Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 937493483B5
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 22:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238423AbhCXVbI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 17:31:08 -0400
Received: from mga06.intel.com ([134.134.136.31]:35731 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238399AbhCXVbD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 17:31:03 -0400
IronPort-SDR: ZL4m04X/Y51SvsVroCXLNGeHTnRoFqbOYBRt9IhwGgIkZ52B08c8t7BbSqXPd15AbVwt16U/xy
 47dxH4ScMOKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="252146498"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="252146498"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:31:02 -0700
IronPort-SDR: M0x7YoPRBksPNhcybLLelnfn3KcoO+idoiHk8Uvh0GolKH5PCtJLCAkph6bVqGxqF0lx+YWvJo
 6K3R/Ag1RbWw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="413917200"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:31:02 -0700
Subject: [PATCH 7/8] cxl/port: Introduce cxl_port objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:31:02 -0700
Message-ID: <161662146204.1723715.10320163818266200224.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Once the cxl_root is established then other ports in the hierarchy can
be attached. The cxl_port object, unlike cxl_root that is associated
with host bridges, is associated with PCIE Root Ports or PCIE Switch
Ports. Add cxl_port instances for all PCIE Root Ports in an ACPI0016
host bridge. The cxl_port instances for PCIE Switch Ports are not
included here as those are to be modeled as another service device
registered on the pcie_port_bus_type.

A sample sysfs topology for a single-host-bridge with
single-PCIE/CXL-root-port:

/sys/bus/cxl/devices/root0
├── address_space0
│   ├── devtype
│   ├── end
│   ├── start
│   ├── supports_ram
│   ├── supports_type2
│   ├── supports_type3
│   └── uevent
├── address_space1
│   ├── devtype
│   ├── end
│   ├── start
│   ├── supports_pmem
│   ├── supports_type2
│   ├── supports_type3
│   └── uevent
├── devtype
├── port1
│   ├── devtype
│   ├── host -> ../../../../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
│   ├── port2
│   │   ├── devtype
│   │   ├── host -> ../../../../../pci0000:34/0000:34:00.0
│   │   ├── subsystem -> ../../../../../../bus/cxl
│   │   ├── target_id
│   │   └── uevent
│   ├── subsystem -> ../../../../../bus/cxl
│   ├── target_id
│   └── uevent
├── subsystem -> ../../../../bus/cxl
├── target_id
└── uevent

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h  |    5 +++
 3 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d54c2d5de730..bc2a35ae880b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -5,18 +5,117 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include "cxl.h"
 
+static int match_ACPI0016(struct device *dev, const void *host)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	const char *hid = acpi_device_hid(adev);
+
+	return strcmp(hid, "ACPI0016") == 0;
+}
+
+struct cxl_walk_context {
+	struct device *dev;
+	struct pci_bus *root;
+	struct cxl_port *port;
+	int error;
+	int count;
+};
+
+static int match_add_root_ports(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	struct pci_bus *root_bus = ctx->root;
+	struct cxl_port *port = ctx->port;
+	int type = pci_pcie_type(pdev);
+	struct device *dev = ctx->dev;
+	resource_size_t cxl_regs_phys;
+	int target_id = ctx->count;
+
+	if (pdev->bus != root_bus)
+		return 0;
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
+	ctx->count++;
+
+	/* TODO walk DVSEC to find component register base */
+	cxl_regs_phys = -1;
+
+	port = devm_cxl_add_port(dev, port, &pdev->dev, target_id,
+				 cxl_regs_phys);
+	if (IS_ERR(port)) {
+		ctx->error = PTR_ERR(port);
+		return ctx->error;
+	}
+
+	dev_dbg(dev, "%s: register: %s\n", dev_name(&pdev->dev),
+		dev_name(&port->dev));
+
+	return 0;
+}
+
+/*
+ * A host bridge may contain one or more root ports.  Register each port
+ * as a child of the cxl_root.
+ */
+static int cxl_acpi_register_ports(struct device *dev, struct acpi_device *root,
+				   struct cxl_port *port, int idx)
+{
+	struct acpi_pci_root *pci_root = acpi_pci_find_root(root->handle);
+	struct cxl_walk_context ctx;
+
+	if (!pci_root)
+		return -ENXIO;
+
+	/* TODO: fold in CEDT.CHBS retrieval */
+	port = devm_cxl_add_port(dev, port, &root->dev, idx, ~0ULL);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+	dev_dbg(dev, "%s: register: %s\n", dev_name(&root->dev),
+		dev_name(&port->dev));
+
+	ctx = (struct cxl_walk_context) {
+		.dev = dev,
+		.root = pci_root->bus,
+		.port = port,
+	};
+	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
+
+	if (ctx.count == 0)
+		return -ENODEV;
+	return ctx.error;
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct device *bridge = NULL;
 	struct cxl_root *cxl_root;
+	int rc, i = 0;
 
 	cxl_root = devm_cxl_add_root(dev, NULL, 0);
 	if (IS_ERR(cxl_root))
 		return PTR_ERR(cxl_root);
 	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));
 
+	while (true) {
+		bridge = bus_find_device(adev->dev.bus, bridge, dev,
+					 match_ACPI0016);
+		if (!bridge)
+			break;
+
+		rc = cxl_acpi_register_ports(dev, to_acpi_device(bridge),
+					     &cxl_root->port, i++);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 07b58cfda392..9beb6855e7f6 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -148,6 +148,15 @@ static void cxl_root_release(struct device *dev)
 	kfree(cxl_root);
 }
 
+static void cxl_port_release(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+
+	ida_free(&cxl_port_ida, port->id);
+	put_device(port->port_dev);
+	kfree(port);
+}
+
 static ssize_t target_id_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -178,6 +187,12 @@ static const struct device_type cxl_root_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+static const struct device_type cxl_port_type = {
+	.name = "cxl_port",
+	.release = cxl_port_release,
+	.groups = cxl_port_attribute_groups,
+};
+
 struct cxl_root *to_cxl_root(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
@@ -188,7 +203,9 @@ struct cxl_root *to_cxl_root(struct device *dev)
 
 struct cxl_port *to_cxl_port(struct device *dev)
 {
-	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
+	if (dev_WARN_ONCE(dev,
+			  dev->type != &cxl_root_type &&
+			  dev->type != &cxl_port_type,
 			  "not a cxl_port device\n"))
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
@@ -296,6 +313,87 @@ struct cxl_root *devm_cxl_add_root(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_root);
 
+static void cxl_unlink_port(void *_port)
+{
+	struct cxl_port *port = _port;
+
+	sysfs_remove_link(&port->dev.kobj, "host");
+}
+
+static int devm_cxl_link_port(struct device *dev, struct cxl_port *port)
+{
+	int rc;
+
+	rc = sysfs_create_link(&port->dev.kobj, &port->port_dev->kobj, "host");
+	if (rc)
+		return rc;
+	return devm_add_action_or_reset(dev, cxl_unlink_port, port);
+}
+
+/**
+ * devm_cxl_add_port() - add a cxl_port to the topology
+ * @parent: devm context / discovery agent
+ * @upstream_port: port parent
+ * @port_dev: device hosting this port
+ * @target_id: if there are port siblings, local id
+ * @cxl_regs_phys: CXL component register base address
+ */
+struct cxl_port *devm_cxl_add_port(struct device *parent,
+				   struct cxl_port *upstream_port,
+				   struct device *port_dev, int target_id,
+				   resource_size_t cxl_regs_phys)
+{
+	struct cxl_port *port;
+	struct device *dev;
+	int rc;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err_id;
+	port->id = rc;
+
+	port->port_dev = get_device(port_dev);
+	if (!port->port_dev)
+		goto err_port_dev;
+
+	dev = &port->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &upstream_port->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_port_type;
+
+	rc = dev_set_name(dev, "port%d", port->id);
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
+	rc = devm_cxl_link_port(parent, port);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return port;
+
+err_port_dev:
+	ida_free(&cxl_port_ida, port->id);
+err_id:
+	kfree(port);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_port);
+
 /*
  * cxl_setup_device_regs() - Detect CXL Device register blocks
  * @dev: Host device of the @base mapping
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f1a2271cfbb5..14e64b87baba 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -134,5 +134,10 @@ struct cxl_address_space_dev *to_cxl_address_space(struct device *dev);
 struct cxl_root *devm_cxl_add_root(struct device *parent,
 				   struct cxl_address_space *cxl_space,
 				   int nr_spaces);
+struct cxl_port *devm_cxl_add_port(struct device *parent,
+				   struct cxl_port *upstream_port,
+				   struct device *port_dev, int target_id,
+				   resource_size_t cxl_regs_phys);
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */

