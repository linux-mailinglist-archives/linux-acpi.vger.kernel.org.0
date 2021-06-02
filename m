Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E30B398F5F
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jun 2021 17:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbhFBP5I (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Jun 2021 11:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhFBP5G (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jun 2021 11:57:06 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76DFC061574
        for <linux-acpi@vger.kernel.org>; Wed,  2 Jun 2021 08:55:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k7so4536264ejv.12
        for <linux-acpi@vger.kernel.org>; Wed, 02 Jun 2021 08:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcZqp7kiQKPtioIYYmePxJZ8jRjqdm9ovqpRz8DAQNM=;
        b=GGijrFXc+HpSE9WoeOpBAm3mX9yf2YsAm4HFWzomjBMECg8vMuWrBnJJuRwkgjGdOz
         rmerVt4RbeC+7JFC6zNSMASgwdGIgq/FdKsDNaNzekPpg7V2o/iDiWEVS4u0Kbh2mz1o
         TjFNsrCBiz0dezcDqyzlOQ1roB0s4vk35pO1BuFCvrC4bsNRVUHlJRPBOCvnfvlqJUTc
         FRqFUdZBXUSueL8CNsyLB9eD9AP64x6+irapuCeyhxmMmDnTtrpNRFpIoKFwH8vbzRu4
         llijmwWT0wmotHWX5Z8aP+AbRPYIXeuKCk/l8/gTBE/xpGyQ6/6pdx6TiIzUxIYcKpB/
         Jn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcZqp7kiQKPtioIYYmePxJZ8jRjqdm9ovqpRz8DAQNM=;
        b=URoOEFa0ssUAxJamTwZrFF2X1LniLCpgiTlZa2TbrRm/f3HYTXGsHglSDzcxv2lDvf
         Z/Jt4l5Dhp6dUxZIZkbc3ItaTFk3QzTRmEhWsdWdNFlMQj6upFy3KMsxZOr3y+wYTg52
         FLIVNqbFGHZAKA2a5TJLPjxyNo1/u/UoUror4+4uv0UxDNLCWHmmJMmCfU5aCTWqoCjW
         f6ZGNJdcTCIkNwaRq6oFpYvfUP5Ej5L4BQtU3x/iUs3jrS7rSBUgc6QbpnLN5KBpIACw
         70cQYL6bb4AZ2ZTQ03943l5HGKtu/sIFbxTW5ugSKZ2rO8altpWd2ienwI6H9bHZuWQn
         RA8Q==
X-Gm-Message-State: AOAM531gWypnUaWaF/3FrpPm7nAwsLJW5wKnoHrD6LMYbdaIhgoQweZl
        pporHgCOdFeAQ71K7rNxw02pQA==
X-Google-Smtp-Source: ABdhPJy9yrHMoYAwjXHc3cT1Wq2Q/FnFuA9YZgVp+llXF3Hw5P/BD8qlnDLkBD9n8fAe6XzHgk0LkQ==
X-Received: by 2002:a17:906:4e95:: with SMTP id v21mr20387922eju.434.1622649308415;
        Wed, 02 Jun 2021 08:55:08 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id d24sm174249edr.95.2021.06.02.08.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 08:55:07 -0700 (PDT)
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
Subject: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Date:   Wed,  2 Jun 2021 17:44:42 +0200
Message-Id: <20210602154444.1077006-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602154444.1077006-1-jean-philippe@linaro.org>
References: <20210602154444.1077006-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Extract the code that sets up the IOMMU infrastructure from IORT, since
it can be reused by VIOT. Move it one level up into a new
acpi_iommu_configure_id() function, which calls the IORT parsing
function which in turn calls the acpi_iommu_fwspec_init() helper.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 include/acpi/acpi_bus.h   |  3 ++
 include/linux/acpi_iort.h |  8 ++---
 drivers/acpi/arm64/iort.c | 75 +++++----------------------------------
 drivers/acpi/scan.c       | 55 +++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a82faac5767..41f092a269f6 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -588,6 +588,9 @@ struct acpi_pci_root {
 
 bool acpi_dma_supported(struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
+int acpi_iommu_fwspec_init(struct device *dev, u32 id,
+			   struct fwnode_handle *fwnode,
+			   const struct iommu_ops *ops);
 int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 		       u64 *size);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index f7f054833afd..f1f0842a2cb2 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -35,8 +35,7 @@ void acpi_configure_pmsi_domain(struct device *dev);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *id_in);
+int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
@@ -50,9 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-static inline const struct iommu_ops *iort_iommu_configure_id(
-				      struct device *dev, const u32 *id_in)
-{ return NULL; }
+static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
+{ return -ENODEV; }
 static inline
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index a940be1cf2af..b5b021e064b6 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -806,23 +806,6 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
 	return NULL;
 }
 
-static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
-}
-
-static inline int iort_add_device_replay(struct device *dev)
-{
-	int err = 0;
-
-	if (dev->bus && !device_iommu_mapped(dev))
-		err = iommu_probe_device(dev);
-
-	return err;
-}
-
 /**
  * iort_iommu_msi_get_resv_regions - Reserved region driver helper
  * @dev: Device from iommu_get_resv_regions()
@@ -900,18 +883,6 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 	}
 }
 
-static int arm_smmu_iort_xlate(struct device *dev, u32 streamid,
-			       struct fwnode_handle *fwnode,
-			       const struct iommu_ops *ops)
-{
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
-
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &streamid, 1);
-
-	return ret;
-}
-
 static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 {
 	struct acpi_iort_root_complex *pci_rc;
@@ -946,7 +917,7 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return iort_iommu_driver_enabled(node->type) ?
 		       -EPROBE_DEFER : -ENODEV;
 
-	return arm_smmu_iort_xlate(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
 }
 
 struct iort_pci_alias_info {
@@ -1020,24 +991,14 @@ static int iort_nc_iommu_map_id(struct device *dev,
  * @dev: device to configure
  * @id_in: optional input id const value pointer
  *
- * Returns: iommu_ops pointer on configuration success
- *          NULL on configuration failure
+ * Returns: 0 on success, <0 on failure
  */
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *id_in)
+int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	struct acpi_iort_node *node;
-	const struct iommu_ops *ops;
+	const struct iommu_ops *ops = NULL;
 	int err = -ENODEV;
 
-	/*
-	 * If we already translated the fwspec there
-	 * is nothing left to do, return the iommu_ops.
-	 */
-	ops = iort_fwspec_iommu_ops(dev);
-	if (ops)
-		return ops;
-
 	if (dev_is_pci(dev)) {
 		struct iommu_fwspec *fwspec;
 		struct pci_bus *bus = to_pci_dev(dev)->bus;
@@ -1046,7 +1007,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
 				      iort_match_node_callback, &bus->dev);
 		if (!node)
-			return NULL;
+			return -ENODEV;
 
 		info.node = node;
 		err = pci_for_each_dma_alias(to_pci_dev(dev),
@@ -1059,7 +1020,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 				      iort_match_node_callback, dev);
 		if (!node)
-			return NULL;
+			return -ENODEV;
 
 		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
 			      iort_nc_iommu_map(dev, node);
@@ -1068,32 +1029,14 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
 			iort_named_component_init(dev, node);
 	}
 
-	/*
-	 * If we have reason to believe the IOMMU driver missed the initial
-	 * add_device callback for dev, replay it to get things in order.
-	 */
-	if (!err) {
-		ops = iort_fwspec_iommu_ops(dev);
-		err = iort_add_device_replay(dev);
-	}
-
-	/* Ignore all other errors apart from EPROBE_DEFER */
-	if (err == -EPROBE_DEFER) {
-		ops = ERR_PTR(err);
-	} else if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		ops = NULL;
-	}
-
-	return ops;
+	return err;
 }
 
 #else
 int iort_iommu_msi_get_resv_regions(struct device *dev, struct list_head *head)
 { return 0; }
-const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
-						const u32 *input_id)
-{ return NULL; }
+int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
+{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index ea613df8f913..696b81432ae7 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
+#include <linux/iommu.h>
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
@@ -1520,6 +1521,58 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
 	return ret >= 0 ? 0 : ret;
 }
 
+int acpi_iommu_fwspec_init(struct device *dev, u32 id,
+			   struct fwnode_handle *fwnode,
+			   const struct iommu_ops *ops)
+{
+	int ret = iommu_fwspec_init(dev, fwnode, ops);
+
+	if (!ret)
+		ret = iommu_fwspec_add_ids(dev, &id, 1);
+
+	return ret;
+}
+
+static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
+{
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+
+	return fwspec ? fwspec->ops : NULL;
+}
+
+static const struct iommu_ops *acpi_iommu_configure_id(struct device *dev,
+						       const u32 *id_in)
+{
+	int err;
+	const struct iommu_ops *ops;
+
+	/*
+	 * If we already translated the fwspec there is nothing left to do,
+	 * return the iommu_ops.
+	 */
+	ops = acpi_iommu_fwspec_ops(dev);
+	if (ops)
+		return ops;
+
+	err = iort_iommu_configure_id(dev, id_in);
+
+	/*
+	 * If we have reason to believe the IOMMU driver missed the initial
+	 * add_device callback for dev, replay it to get things in order.
+	 */
+	if (!err && dev->bus && !device_iommu_mapped(dev))
+		err = iommu_probe_device(dev);
+
+	/* Ignore all other errors apart from EPROBE_DEFER */
+	if (err == -EPROBE_DEFER) {
+		return ERR_PTR(err);
+	} else if (err) {
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
+		return NULL;
+	}
+	return acpi_iommu_fwspec_ops(dev);
+}
+
 /**
  * acpi_dma_configure_id - Set-up DMA configuration for the device.
  * @dev: The pointer to the device
@@ -1539,7 +1592,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev, &dma_addr, &size);
 
-	iommu = iort_iommu_configure_id(dev, input_id);
+	iommu = acpi_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-- 
2.31.1

