Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601ED369190
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhDWL5k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhDWL5f (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224A8C061574
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h4so39078517wrt.12
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gl+wT+HXO1EmX33ux5rHV8ewc8i/fb8Q84CtH/7aE+s=;
        b=u5H1CF5in2pW8E0mjMU7DWgoW2RuVlaM98/7Qrfv+WG9vinU51jIe6Fe6m7WGVM5em
         9UEq4ESUZI5V5c+VI7vRC4Y27YrhLWItK4QNRCe5hOrzRLxbAh++t0lX3gwZQwW+VV2B
         16a17hfs0QzC+aIqFRsi4uBf3Wvyvydnl+fMIaIfSMcFUSSjPX4+laIN/z3EAK3C2Cvo
         Ktj11/vWXlDSloSwOJABdD87VDpPVEu462ALHYz/epj4/S7oMqin8IQnKrd4Mb5TnZUd
         xI+ClGFXavzTmBsiY886MNraXqWrWn8ZXlud/t02OuOFydyDENidi1EVjrnq0iX/41Br
         2S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gl+wT+HXO1EmX33ux5rHV8ewc8i/fb8Q84CtH/7aE+s=;
        b=UIUeZXTYI8R6a1XbXXGBC30pfMt1tkZmxg/4E2oY//noebXA2FUXWwsIJ3pbT2HxHK
         ZT8RTaw4hZFc32F54zk/hcYKJwC25PqUuP+C7/edzdjSdeP9svY1LVOjT08nR1hOgjX4
         WMeGhhgSs8AARhfjMX/URRcUg2QbivcP1GYIVsALmSxZM9JoaxApKPhScBth5C4iPBNH
         F36hIcS8Y7LuYZO3va12CQp7gmg2njncZv6ooZwTRCx8kNmEJzHEB8w1tr1ncSz8yxOU
         kykzu9NfMW3eOHRJyhd1DZxA4lc26KbW0bA4603kRRvktvm7oCw93CHCnRhoGxlh6EKL
         2ySA==
X-Gm-Message-State: AOAM530DHIz28TbdP3UGR1+reR0XbSaMc18nI2SYtecJsKnVBVJIISUG
        Mv8O0V9Zz2Z1Sqb042HIvjfmmw==
X-Google-Smtp-Source: ABdhPJxQ6WJ/X0Z99RttgqNXaiTlSXokX/3gGTygldN2OIGipkCY1zgOrvFvxDE0Y2iqQA/hkN7NeQ==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr4310705wrt.132.1619179016822;
        Fri, 23 Apr 2021 04:56:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:56 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     rjw@rjwysocki.net, lenb@kernel.org, joro@8bytes.org, mst@redhat.com
Cc:     will@kernel.org, catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com,
        sebastien.boeuf@intel.com, robin.murphy@arm.com,
        kevin.tian@intel.com, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com,
        jean-philippe@linaro.org
Subject: [PATCH v2 3/6] ACPI: Add driver for the VIOT table
Date:   Fri, 23 Apr 2021 13:38:34 +0200
Message-Id: <20210423113836.3974972-4-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The ACPI Virtual I/O Translation Table describes topology of
para-virtual platforms, similarly to vendor tables DMAR, IVRS and IORT.
For now it describes the relation between virtio-iommu and the endpoints
it manages.

Three steps are needed to configure DMA of endpoints:

(1) acpi_viot_init(): parse the VIOT table, find or create the fwnode
    associated to each vIOMMU device.

(2) When probing the vIOMMU device, the driver registers its IOMMU ops
    within the IOMMU subsystem. This step doesn't require any
    intervention from the VIOT driver.

(3) viot_iommu_configure(): before binding the endpoint to a driver,
    find the associated IOMMU ops. Register them, along with the
    endpoint ID, into the device's iommu_fwspec.

If step (3) happens before step (2), it is deferred until the IOMMU is
initialized, then retried.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 drivers/acpi/Kconfig      |   3 +
 drivers/iommu/Kconfig     |   1 +
 drivers/acpi/Makefile     |   2 +
 include/linux/acpi_viot.h |  19 +++
 drivers/acpi/bus.c        |   2 +
 drivers/acpi/scan.c       |   3 +
 drivers/acpi/viot.c       | 350 ++++++++++++++++++++++++++++++++++++++
 MAINTAINERS               |   8 +
 8 files changed, 388 insertions(+)
 create mode 100644 include/linux/acpi_viot.h
 create mode 100644 drivers/acpi/viot.c

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index eedec61e3476..3758c6940ed7 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -526,6 +526,9 @@ endif
 
 source "drivers/acpi/pmic/Kconfig"
 
+config ACPI_VIOT
+	bool
+
 endif	# ACPI
 
 config X86_PM_TIMER
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1f111b399bca..aff8a4830dd1 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -403,6 +403,7 @@ config VIRTIO_IOMMU
 	depends on ARM64
 	select IOMMU_API
 	select INTERVAL_TREE
+	select ACPI_VIOT if ACPI
 	help
 	  Para-virtualised IOMMU driver with virtio.
 
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 700b41adf2db..a6e644c48987 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -118,3 +118,5 @@ video-objs			+= acpi_video.o video_detect.o
 obj-y				+= dptf/
 
 obj-$(CONFIG_ARM64)		+= arm64/
+
+obj-$(CONFIG_ACPI_VIOT)		+= viot.o
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
new file mode 100644
index 000000000000..1eb8ee5b0e5f
--- /dev/null
+++ b/include/linux/acpi_viot.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ACPI_VIOT_H__
+#define __ACPI_VIOT_H__
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_VIOT
+void __init acpi_viot_init(void);
+int viot_iommu_configure(struct device *dev);
+#else
+static inline void acpi_viot_init(void) {}
+static inline int viot_iommu_configure(struct device *dev)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* __ACPI_VIOT_H__ */
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index be7da23fad76..b835ca702ff0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -27,6 +27,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
 #include <linux/pci.h>
 #include <acpi/apei.h>
 #include <linux/suspend.h>
@@ -1339,6 +1340,7 @@ static int __init acpi_init(void)
 	pci_mmcfg_late_init();
 	acpi_iort_init();
 	acpi_scan_init();
+	acpi_viot_init();
 	acpi_ec_init();
 	acpi_debugfs_init();
 	acpi_sleep_proc_init();
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5924421075f6..4db43c822ee7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/acpi_viot.h>
 #include <linux/iommu.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
@@ -1554,6 +1555,8 @@ static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
 		return ops;
 
 	err = iort_iommu_configure_id(dev, id_in);
+	if (err && err != -EPROBE_DEFER)
+		err = viot_iommu_configure(dev);
 
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
new file mode 100644
index 000000000000..710e5a5eac70
--- /dev/null
+++ b/drivers/acpi/viot.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual I/O topology
+ */
+#define pr_fmt(fmt) "ACPI: VIOT: " fmt
+
+#include <linux/acpi_viot.h>
+#include <linux/dma-iommu.h>
+#include <linux/fwnode.h>
+#include <linux/iommu.h>
+#include <linux/list.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+struct viot_iommu {
+	/* Node offset within the table */
+	unsigned int			offset;
+	struct fwnode_handle		*fwnode;
+	struct list_head		list;
+};
+
+struct viot_endpoint {
+	union {
+		/* PCI range */
+		struct {
+			u16		segment_start;
+			u16		segment_end;
+			u16		bdf_start;
+			u16		bdf_end;
+		};
+		/* MMIO */
+		u64			address;
+	};
+	u32				endpoint_id;
+	struct viot_iommu		*viommu;
+	struct list_head		list;
+};
+
+static struct acpi_table_viot *viot;
+static LIST_HEAD(viot_iommus);
+static LIST_HEAD(viot_pci_ranges);
+static LIST_HEAD(viot_mmio_endpoints);
+
+static int __init viot_check_bounds(const struct acpi_viot_header *hdr)
+{
+	struct acpi_viot_header *start, *end, *hdr_end;
+
+	start = ACPI_ADD_PTR(struct acpi_viot_header, viot,
+			     max_t(size_t, sizeof(*viot), viot->node_offset));
+	end = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->header.length);
+	hdr_end = ACPI_ADD_PTR(struct acpi_viot_header, hdr, sizeof(*hdr));
+
+	if (hdr < start || hdr_end > end) {
+		pr_err(FW_BUG "Node pointer overflows\n");
+		return -EOVERFLOW;
+	}
+	if (hdr->length < sizeof(*hdr)) {
+		pr_err(FW_BUG "Empty node\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
+					    u16 segment, u16 bdf)
+{
+	struct pci_dev *pdev;
+	struct fwnode_handle *fwnode;
+
+	pdev = pci_get_domain_bus_and_slot(segment, PCI_BUS_NUM(bdf),
+					   bdf & 0xff);
+	if (!pdev) {
+		pr_err("Could not find PCI IOMMU\n");
+		return -ENODEV;
+	}
+
+	fwnode = pdev->dev.fwnode;
+	if (!fwnode) {
+		/*
+		 * PCI devices aren't necessarily described by ACPI. Create a
+		 * fwnode so the IOMMU subsystem can identify this device.
+		 */
+		fwnode = acpi_alloc_fwnode_static();
+		if (!fwnode) {
+			pci_dev_put(pdev);
+			return -ENOMEM;
+		}
+		set_primary_fwnode(&pdev->dev, fwnode);
+	}
+	viommu->fwnode = pdev->dev.fwnode;
+	pci_dev_put(pdev);
+	return 0;
+}
+
+static int __init viot_get_mmio_iommu_fwnode(struct viot_iommu *viommu,
+					     u64 address)
+{
+	struct acpi_device *adev;
+	struct resource res = {
+		.start	= address,
+		.end	= address,
+		.flags	= IORESOURCE_MEM,
+	};
+
+	adev = acpi_resource_consumer(&res);
+	if (!adev) {
+		pr_err("Could not find MMIO IOMMU\n");
+		return -EINVAL;
+	}
+	viommu->fwnode = &adev->fwnode;
+	return 0;
+}
+
+static struct viot_iommu * __init viot_get_iommu(unsigned int offset)
+{
+	int ret;
+	struct viot_iommu *viommu;
+	struct acpi_viot_header *hdr = ACPI_ADD_PTR(struct acpi_viot_header,
+						    viot, offset);
+	union {
+		struct acpi_viot_virtio_iommu_pci pci;
+		struct acpi_viot_virtio_iommu_mmio mmio;
+	} *node = (void *)hdr;
+
+	list_for_each_entry(viommu, &viot_iommus, list)
+		if (viommu->offset == offset)
+			return viommu;
+
+	if (viot_check_bounds(hdr))
+		return NULL;
+
+	viommu = kzalloc(sizeof(*viommu), GFP_KERNEL);
+	if (!viommu)
+		return NULL;
+
+	viommu->offset = offset;
+	switch (hdr->type) {
+	case ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI:
+		if (hdr->length < sizeof(node->pci))
+			goto err_free;
+
+		ret = viot_get_pci_iommu_fwnode(viommu, node->pci.segment,
+						node->pci.bdf);
+		break;
+	case ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO:
+		if (hdr->length < sizeof(node->mmio))
+			goto err_free;
+
+		ret = viot_get_mmio_iommu_fwnode(viommu,
+						 node->mmio.base_address);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+	if (ret)
+		goto err_free;
+
+	list_add(&viommu->list, &viot_iommus);
+	return viommu;
+
+err_free:
+	kfree(viommu);
+	return NULL;
+}
+
+static int __init viot_parse_node(const struct acpi_viot_header *hdr)
+{
+	int ret = -EINVAL;
+	struct list_head *list;
+	struct viot_endpoint *ep;
+	union {
+		struct acpi_viot_mmio mmio;
+		struct acpi_viot_pci_range pci;
+	} *node = (void *)hdr;
+
+	if (viot_check_bounds(hdr))
+		return -EINVAL;
+
+	if (hdr->type == ACPI_VIOT_NODE_VIRTIO_IOMMU_PCI ||
+	    hdr->type == ACPI_VIOT_NODE_VIRTIO_IOMMU_MMIO)
+		return 0;
+
+	ep = kzalloc(sizeof(*ep), GFP_KERNEL);
+	if (!ep)
+		return -ENOMEM;
+
+	switch (hdr->type) {
+	case ACPI_VIOT_NODE_PCI_RANGE:
+		if (hdr->length < sizeof(node->pci)) {
+			pr_err(FW_BUG "Invalid PCI node size\n");
+			goto err_free;
+		}
+
+		ep->segment_start = node->pci.segment_start;
+		ep->segment_end = node->pci.segment_end;
+		ep->bdf_start = node->pci.bdf_start;
+		ep->bdf_end = node->pci.bdf_end;
+		ep->endpoint_id = node->pci.endpoint_start;
+		ep->viommu = viot_get_iommu(node->pci.output_node);
+		list = &viot_pci_ranges;
+		break;
+	case ACPI_VIOT_NODE_MMIO:
+		if (hdr->length < sizeof(node->mmio)) {
+			pr_err(FW_BUG "Invalid MMIO node size\n");
+			goto err_free;
+		}
+
+		ep->address = node->mmio.base_address;
+		ep->endpoint_id = node->mmio.endpoint;
+		ep->viommu = viot_get_iommu(node->mmio.output_node);
+		list = &viot_mmio_endpoints;
+		break;
+	default:
+		pr_warn("Unsupported node %x\n", hdr->type);
+		ret = 0;
+		goto err_free;
+	}
+
+	/*
+	 * To be compatible with future versions of the table which may include
+	 * other node types, keep parsing.
+	 */
+	if (!ep->viommu) {
+		pr_warn("No IOMMU node found\n");
+		ret = 0;
+		goto err_free;
+	}
+
+	list_add(&ep->list, list);
+	return 0;
+
+err_free:
+	kfree(ep);
+	return ret;
+}
+
+/**
+ * acpi_viot_init - Parse the VIOT table
+ *
+ * Parse the VIOT table, prepare the list of endpoints to be used during DMA
+ * setup of devices.
+ */
+void __init acpi_viot_init(void)
+{
+	int i;
+	acpi_status status;
+	struct acpi_table_header *hdr;
+	struct acpi_viot_header *node;
+
+	status = acpi_get_table(ACPI_SIG_VIOT, 0, &hdr);
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get table, %s\n", msg);
+		}
+		return;
+	}
+
+	viot = (void *)hdr;
+
+	node = ACPI_ADD_PTR(struct acpi_viot_header, viot, viot->node_offset);
+	for (i = 0; i < viot->node_count; i++) {
+		if (viot_parse_node(node))
+			return;
+
+		node = ACPI_ADD_PTR(struct acpi_viot_header, node,
+				    node->length);
+	}
+}
+
+static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
+			       u32 epid)
+{
+	const struct iommu_ops *ops;
+
+	if (!viommu)
+		return -ENODEV;
+
+	/* We're not translating ourself */
+	if (viommu->fwnode == dev->fwnode)
+		return -EINVAL;
+
+	ops = iommu_ops_from_fwnode(viommu->fwnode);
+	if (!ops)
+		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
+			-EPROBE_DEFER : -ENODEV;
+
+	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
+}
+
+static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
+{
+	u32 epid;
+	struct viot_endpoint *ep;
+	u32 domain_nr = pci_domain_nr(pdev->bus);
+
+	list_for_each_entry(ep, &viot_pci_ranges, list) {
+		if (domain_nr >= ep->segment_start &&
+		    domain_nr <= ep->segment_end &&
+		    dev_id >= ep->bdf_start &&
+		    dev_id <= ep->bdf_end) {
+			epid = ((domain_nr - ep->segment_start) << 16) +
+				dev_id - ep->bdf_start + ep->endpoint_id;
+
+			/*
+			 * If we found a PCI range managed by the viommu, we're
+			 * the one that has to request ACS.
+			 */
+			pci_request_acs();
+
+			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+						   epid);
+		}
+	}
+	return -ENODEV;
+}
+
+static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
+{
+	struct resource *mem;
+	struct viot_endpoint *ep;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!mem)
+		return -ENODEV;
+
+	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
+		if (ep->address == mem->start)
+			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
+						   ep->endpoint_id);
+	}
+	return -ENODEV;
+}
+
+/**
+ * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
+ * @dev: the endpoint
+ *
+ * Return: 0 on success, <0 on failure
+ */
+int viot_iommu_configure(struct device *dev)
+{
+	if (dev_is_pci(dev))
+		return pci_for_each_dma_alias(to_pci_dev(dev),
+					      viot_pci_dev_iommu_init, NULL);
+	else if (dev_is_platform(dev))
+		return viot_mmio_dev_iommu_init(to_platform_device(dev));
+	return -ENODEV;
+}
diff --git a/MAINTAINERS b/MAINTAINERS
index 6b1560c45e2a..1a018afff162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -431,6 +431,14 @@ W:	https://01.org/linux-acpi
 B:	https://bugzilla.kernel.org
 F:	drivers/acpi/acpi_video.c
 
+ACPI VIOT DRIVER
+M:	Jean-Philippe Brucker <jean-philippe@linaro.org>
+L:	linux-acpi@vger.kernel.org
+L:	iommu@lists.linux-foundation.org
+S:	Maintained
+F:	drivers/acpi/viot.c
+F:	include/linux/acpi_viot.h
+
 ACPI WMI DRIVER
 L:	platform-driver-x86@vger.kernel.org
 S:	Orphan
-- 
2.31.1

