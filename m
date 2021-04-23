Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF318369189
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 13:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbhDWL5f (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhDWL5d (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 07:57:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEC9C06174A
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h4so39078459wrt.12
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ie4nU0t6j2jprvM9FCKa2FLyckkjG0nBrisc3oCcJ1E=;
        b=sU0Q7m9tGwOgNNpYZsyMA4AWC/G9d1n7reOR5ld1HR77B1kAaSWUx097X6V2NQF2DS
         ws+AhvuXIcq5mlYDgb8obdVEtJoJPZyl7okZnsmFYsPiceTtk0Gsj4S2/IUV3D1ShI87
         3fqK4uGwNKKzw03o/1dnK9BC+Ic5DC/2BIiU5jKBvE3Vxeaf4GdZWOJFxcjG11SBZptl
         J49tJE6QbcEYU5iCC655gLoIeED2grAAyvjCTkIQ9PJhzZscxl0R73Vv+LixfuXit4cq
         lb61A3kHz+x421dW3pFjO+lr3/oEOBJiy9246tp6bR4oJRIZpWjFRpYuEGB00nFTtQC5
         ofTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ie4nU0t6j2jprvM9FCKa2FLyckkjG0nBrisc3oCcJ1E=;
        b=G/wUKPNQl2hMZnkLuZlCT4Qxkp6cdcuE9yPZPXl0d72tpHTUHlzBAz5qnIb+tnpLua
         af+ykwAv2xCxf5ybd5k5zIKBhECmt1X8XTp+G8tM3SFOYFqVEIF065gBgPXzzsyATm4A
         Ozcaa4EdT76t/33fHz8FlbzDMNBdbu1zYNyNUI1lpECx4w0lYdHmp29cZ7ly+1C4KN3U
         eTZFaTevhmGkIXbMQxoDlBZwFZXH0n4X/+BQinJLfXXinm/zia93WloK5F24rTtyiDt4
         JVrU6g/pSsA+Nga8Df0NY7RV4uAt0EGRURMxmrIoiAEf2XBxsgKTsQvRMBJ/Jhpc7r7e
         nbBA==
X-Gm-Message-State: AOAM533Z0hBXRkDJ3iEylsdl7lOxL+L7GSVWHXKyVFwMUHRVjnn0IFKw
        iBWl/we0yxhMPtAZ7gFg1VTtbw==
X-Google-Smtp-Source: ABdhPJyQkR9m00EDkp3Rh2Xq1RE8rUtI+3n89qfQVHyycvwuqU1MdsadQRK9RFCCdEV8AMOZfs65Ag==
X-Received: by 2002:a5d:6a84:: with SMTP id s4mr4338553wru.92.1619179015909;
        Fri, 23 Apr 2021 04:56:55 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id g9sm7485195wmh.21.2021.04.23.04.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:56:55 -0700 (PDT)
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
Subject: [PATCH v2 2/6] ACPI: Move IOMMU setup code out of IORT
Date:   Fri, 23 Apr 2021 13:38:33 +0200
Message-Id: <20210423113836.3974972-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423113836.3974972-1-jean-philippe@linaro.org>
References: <20210423113836.3974972-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Some of the IOMMU setup code in IORT is fairly generic and can be reused
by VIOT. Extract it from IORT.

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
index e166916eb9db..5924421075f6 100644
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
@@ -1519,6 +1520,58 @@ int acpi_dma_get_range(struct device *dev, u64 *dma_addr, u64 *offset,
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
@@ -1538,7 +1591,7 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 
 	acpi_arch_dma_setup(dev, &dma_addr, &size);
 
-	iommu = iort_iommu_configure_id(dev, input_id);
+	iommu = acpi_iommu_configure_id(dev, input_id);
 	if (PTR_ERR(iommu) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
-- 
2.31.1

