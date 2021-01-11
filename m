Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 059B42F23BF
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 01:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390805AbhALAZ7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 19:25:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:57927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390885AbhAKXCK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:02:10 -0500
IronPort-SDR: 07n8lxNEf+HxYVMJF1dy7+dimb7DNfv3kYEgvR30iQDZ8mzwPlBAALtKmQpsTtDZCVKlZxfa4Q
 6cZBTlI5WOow==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="196564888"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="196564888"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:15 -0800
IronPort-SDR: 53Qftlc8PM8owRGvHrJMkZtGGHDL4bqJNdAqNbGQD55Q4/zD4A5rix+Wbhb0k4zV1MyYL//nk0
 rkzYnH90Dshw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="381181196"
Received: from yyang31-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.142.71])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 15:01:15 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Mailbox Transport; Mon, 11 Jan 2021 14:51:33 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Jan 2021 14:51:32 -0800
Received: from fmsmga008.fm.intel.com (10.253.24.58) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Jan 2021 14:51:32 -0800
IronPort-SDR: u/pYsBqHZwkELUf0+YDhzxQQE1UBrsmog5L/HjntD/YKgNifUJOGVbPmfJ3h4XdDiO/R7juq7M
 KCyjPH0M+53A==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352777941"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:31 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: [RFC PATCH v3 04/16] cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
Date:   Mon, 11 Jan 2021 14:51:08 -0800
Message-ID: <20210111225121.820014-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
Content-Transfer-Encoding: 7BIT
X-MS-Exchange-Organization-Network-Message-Id: 97028c45-776b-4082-19d6-08d8b683713e
Content-Type:   text/plain; charset=US-ASCII
X-MS-Exchange-Organization-AVStamp-Enterprise: 1.0
X-MS-Exchange-Organization-SCL: -1
X-MS-Exchange-Organization-AuthSource: ORSMSX608.amr.corp.intel.com
X-MS-Exchange-Organization-AuthAs: Anonymous
X-MS-Exchange-Transport-EndToEndLatency: 00:00:00.8682483
X-MS-Exchange-Processed-By-BccFoldering: 15.01.1713.001
MIME-Version: 1.0
X-TUID: ZtHqsBLNe6tE
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The CXL.mem protocol allows a device to act as a provider of "System
RAM" and/or "Persistent Memory" that is fully coherent as if the memory
was attached to the typical CPU memory controller.

With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
device interface and give the operating system control over "Host
Managed Device Memory". See section 2.3 Type 3 CXL Device.

The memory range exported by the device may optionally be described by
the platform firmware memory map, or by infrastructure like LIBNVDIMM to
provision persistent memory capacity from one, or more, CXL.mem devices.

A pre-requisite for Linux-managed memory-capacity provisioning is this
cxl_mem driver that can speak the mailbox protocol defined in section
8.2.8.4 Mailbox Registers.

For now just land the driver boiler-plate and fill it in with
functionality in subsequent commits.

Link: https://www.computeexpresslink.org/download-the-specification
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/cxl/memory-devices.rst |  9 ++++
 drivers/cxl/Kconfig                  | 22 +++++++++
 drivers/cxl/Makefile                 |  2 +
 drivers/cxl/mem.c                    | 69 ++++++++++++++++++++++++++++
 drivers/cxl/pci.h                    | 20 ++++++++
 5 files changed, 122 insertions(+)
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h

diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
index 6ce88f9d5f4f..134c9b6b4ff4 100644
--- a/Documentation/cxl/memory-devices.rst
+++ b/Documentation/cxl/memory-devices.rst
@@ -23,6 +23,15 @@ ACPI CXL
 .. kernel-doc:: drivers/cxl/acpi.c
    :internal:
 
+CXL Memory Device
+-----------------
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :internal:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 68da926ba5b1..0ac5080cd6e0 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -33,4 +33,26 @@ config CXL_ACPI
 	  specification.
 
 	  If unsure say 'm'
+
+config CXL_MEM
+        tristate "CXL.mem: Endpoint Support"
+        depends on PCI && CXL_BUS_PROVIDER
+        default CXL_BUS_PROVIDER
+        help
+          The CXL.mem protocol allows a device to act as a provider of
+          "System RAM" and/or "Persistent Memory" that is fully coherent
+          as if the memory was attached to the typical CPU memory
+          controller.
+
+	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
+	  a module) that will attach to CXL.mem devices for
+	  configuration, provisioning, and health monitoring. This
+	  driver is required for dynamic provisioning of CXL.mem
+	  attached memory which is a pre-requisite for persistent memory
+	  support. Typically volatile memory is mapped by platform
+	  firmware and included in the platform memory map, but in some
+	  cases the OS is responsible for mapping that memory. See
+	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
+
+          If unsure say 'm'.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d38cd34a2582..97fdffb00f2d 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_acpi-y := acpi.o
+cxl_mem-y := mem.o
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..005404888942
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include "acpi.h"
+#include "pci.h"
+
+static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 vendor, id;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
+				     &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+
+static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	int rc, regloc;
+
+	rc = cxl_bus_acquire(pdev);
+	if (rc != 0) {
+		dev_err(dev, "failed to acquire interface\n");
+		return rc;
+	}
+
+	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
+	if (!regloc) {
+		dev_err(dev, "register location dvsec not found\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static const struct pci_device_id cxl_mem_pci_tbl[] = {
+	/* PCI class code for CXL.mem Type-3 Devices */
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
+	{ /* terminate list */ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
+
+static struct pci_driver cxl_mem_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= cxl_mem_pci_tbl,
+	.probe			= cxl_mem_probe,
+};
+
+MODULE_LICENSE("GPL v2");
+module_pci_driver(cxl_mem_driver);
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
new file mode 100644
index 000000000000..a8a9935fa90b
--- /dev/null
+++ b/drivers/cxl/pci.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#ifndef __CXL_PCI_H__
+#define __CXL_PCI_H__
+
+#define PCI_CLASS_MEMORY_CXL	0x050210
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification
+ */
+#define PCI_EXT_CAP_ID_DVSEC		0x23
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
+#define PCI_DVSEC_VENDOR_ID_OFFSET	0x4
+#define PCI_DVSEC_ID_CXL		0x0
+#define PCI_DVSEC_ID_OFFSET		0x8
+
+#define PCI_DVSEC_ID_CXL_REGLOC		0x8
+
+#endif /* __CXL_PCI_H__ */
-- 
2.30.0

