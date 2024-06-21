Return-Path: <linux-acpi+bounces-6576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AB7912D6E
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 539B11F2570B
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 18:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E34A17B50A;
	Fri, 21 Jun 2024 18:47:01 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075EC5BAF0;
	Fri, 21 Jun 2024 18:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995621; cv=none; b=KNTMrS2IrDvfxj8NKX/Q12Zg8t/EgilvQ5Ry4IHpvKTmjDCpREybvGBVvkRq74EVQatGmnoET9gVvRVhlN1RsG/a+KdRVN/ue1zPWWNo7CLPGMjAId3aAEgptT+qrdO5sd0zxiGuzsjuussso4D82zxG2IDa+57HR8yMfDxMbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995621; c=relaxed/simple;
	bh=5bLhRNR6IImmCpLF1sNhGc4DbUNSvS2DFxOTvHpxS+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=abuFxKW3UPFauFeX0m37zMkY/nHm7e05xaF+Ejf2UEIMkCc1GLvp0b69dArZF4l1Nq0zJ7djTJAr+oUGcdyPTu2q9cT3IXcT9otlUtEDPsKaJa5IqnEVhh0QrFr85mh9gYOWFgjWteExhqkD73F/jBdoMkFYzMfjT+xDfmWrWx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11EE9FEC;
	Fri, 21 Jun 2024 11:47:23 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E2B713F6A8;
	Fri, 21 Jun 2024 11:46:55 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/4] iommu: Resolve fwspec ops automatically
Date: Fri, 21 Jun 2024 19:46:36 +0100
Message-Id: <62d6810f0e8658ffecfabeb74bbdcd1ad080d4ce.1718994350.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1718994350.git.robin.murphy@arm.com>
References: <cover.1718994350.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no real need for callers to resolve ops from a fwnode in order
to then pass both to iommu_fwspec_init() - it's simpler and more sensible
for that to resolve the ops itself. This in turn means we can centralise
the notion of checking for a present driver, and enforce that fwspecs
aren't allocated unless and until we know they will be usable.

Also use this opportunity to modernise with some "new" helpers that
arrived shortly after this code was first written; the generic
fwnode_handle_get() clears up that ugly get/put mismatch, while
of_fwnode_handle() can now abstract those open-coded dereferences.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
v2: Add of_fwnode_handle() cleanup as well
---
 drivers/acpi/arm64/iort.c             | 19 +++++--------------
 drivers/acpi/scan.c                   |  8 +++-----
 drivers/acpi/viot.c                   | 11 ++---------
 drivers/iommu/arm/arm-smmu/arm-smmu.c |  3 +--
 drivers/iommu/iommu-priv.h            |  2 ++
 drivers/iommu/iommu.c                 |  9 ++++++---
 drivers/iommu/mtk_iommu_v1.c          |  2 +-
 drivers/iommu/of_iommu.c              | 19 ++++++-------------
 drivers/iommu/tegra-smmu.c            |  2 +-
 include/acpi/acpi_bus.h               |  3 +--
 include/linux/iommu.h                 | 13 ++-----------
 11 files changed, 30 insertions(+), 61 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index c0b1c2c19444..1b39e9ae7ac1 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1221,10 +1221,10 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 			    u32 streamid)
 {
-	const struct iommu_ops *ops;
 	struct fwnode_handle *iort_fwnode;
 
-	if (!node)
+	/* If there's no SMMU driver at all, give up now */
+	if (!node || !iort_iommu_driver_enabled(node->type))
 		return -ENODEV;
 
 	iort_fwnode = iort_get_fwnode(node);
@@ -1232,19 +1232,10 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 		return -ENODEV;
 
 	/*
-	 * If the ops look-up fails, this means that either
-	 * the SMMU drivers have not been probed yet or that
-	 * the SMMU drivers are not built in the kernel;
-	 * Depending on whether the SMMU drivers are built-in
-	 * in the kernel or not, defer the IOMMU configuration
-	 * or just abort it.
+	 * If the SMMU drivers are enabled but not loaded/probed
+	 * yet, this will defer.
 	 */
-	ops = iommu_ops_from_fwnode(iort_fwnode);
-	if (!ops)
-		return iort_iommu_driver_enabled(node->type) ?
-		       -EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode);
 }
 
 struct iort_pci_alias_info {
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 503773707e01..8d5a589db141 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1577,12 +1577,11 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 
 #ifdef CONFIG_IOMMU_API
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
+			   struct fwnode_handle *fwnode)
 {
 	int ret;
 
-	ret = iommu_fwspec_init(dev, fwnode, ops);
+	ret = iommu_fwspec_init(dev, fwnode);
 	if (ret)
 		return ret;
 
@@ -1639,8 +1638,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 #else /* !CONFIG_IOMMU_API */
 
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
+			   struct fwnode_handle *fwnode)
 {
 	return -ENODEV;
 }
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index c8025921c129..2aa69a2fba73 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -307,21 +307,14 @@ void __init acpi_viot_init(void)
 static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 			       u32 epid)
 {
-	const struct iommu_ops *ops;
-
-	if (!viommu)
+	if (!viommu || !IS_ENABLED(CONFIG_VIRTIO_IOMMU))
 		return -ENODEV;
 
 	/* We're not translating ourself */
 	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
-	ops = iommu_ops_from_fwnode(viommu->fwnode);
-	if (!ops)
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
-			-EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode);
 }
 
 static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 87c81f75cf84..c200e6d3aed5 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -178,8 +178,7 @@ static int arm_smmu_register_legacy_master(struct device *dev,
 		it.cur_count = 1;
 	}
 
-	err = iommu_fwspec_init(dev, &smmu_dev->of_node->fwnode,
-				&arm_smmu_ops);
+	err = iommu_fwspec_init(dev, NULL);
 	if (err)
 		return err;
 
diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 5f731d994803..078cafcf49b4 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -17,6 +17,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 	return dev->iommu->iommu_dev->ops;
 }
 
+const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 9df7cc75c1bc..7618c4285cf9 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2822,11 +2822,14 @@ const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode
 	return ops;
 }
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops)
+int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 {
+	const struct iommu_ops *ops = iommu_ops_from_fwnode(iommu_fwnode);
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
+	if (!ops)
+		return -EPROBE_DEFER;
+
 	if (fwspec)
 		return ops == fwspec->ops ? 0 : -EINVAL;
 
@@ -2838,7 +2841,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 	if (!fwspec)
 		return -ENOMEM;
 
-	of_node_get(to_of_node(iommu_fwnode));
+	fwnode_handle_get(iommu_fwnode);
 	fwspec->iommu_fwnode = iommu_fwnode;
 	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index d6e4002200bd..9814c7d09497 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -414,7 +414,7 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 	}
 
 	if (!fwspec) {
-		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
+		ret = iommu_fwspec_init(dev, of_fwnode_handle(args->np));
 		if (ret)
 			return ret;
 		fwspec = dev_iommu_fwspec_get(dev);
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 3afe0b48a48d..08c523ad55ad 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -21,26 +21,19 @@ static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
 	const struct iommu_ops *ops;
-	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
 
-	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
+	if (!of_device_is_available(iommu_spec->np))
 		return -ENODEV;
 
-	ret = iommu_fwspec_init(dev, fwnode, ops);
+	ret = iommu_fwspec_init(dev, of_fwnode_handle(iommu_spec->np));
+	if (ret == -EPROBE_DEFER)
+		return driver_deferred_probe_check_state(dev);
 	if (ret)
 		return ret;
-	/*
-	 * The otherwise-empty fwspec handily serves to indicate the specific
-	 * IOMMU device we're waiting for, which will be useful if we ever get
-	 * a proper probe-ordering dependency mechanism in future.
-	 */
-	if (!ops)
-		return driver_deferred_probe_check_state(dev);
 
-	if (!try_module_get(ops->owner))
+	ops = dev_iommu_fwspec_get(dev)->ops;
+	if (!ops->of_xlate || !try_module_get(ops->owner))
 		return -ENODEV;
 
 	ret = ops->of_xlate(dev, iommu_spec);
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index f86c7ae91814..4365d9936e68 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -837,7 +837,7 @@ static int tegra_smmu_configure(struct tegra_smmu *smmu, struct device *dev,
 	const struct iommu_ops *ops = smmu->iommu.ops;
 	int err;
 
-	err = iommu_fwspec_init(dev, &dev->of_node->fwnode, ops);
+	err = iommu_fwspec_init(dev, of_fwnode_handle(dev->of_node));
 	if (err < 0) {
 		dev_err(dev, "failed to initialize fwspec: %d\n", err);
 		return err;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 1a4dfd7a1c4a..9d815837e297 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -736,8 +736,7 @@ struct iommu_ops;
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
 int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops);
+			   struct fwnode_handle *fwnode);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 17b3f36ad843..81893aad9ee4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1005,11 +1005,9 @@ struct iommu_mm_data {
 	struct list_head	sva_handles;
 };
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops);
+int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids);
-const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
@@ -1315,8 +1313,7 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
 }
 
 static inline int iommu_fwspec_init(struct device *dev,
-				    struct fwnode_handle *iommu_fwnode,
-				    const struct iommu_ops *ops)
+				    struct fwnode_handle *iommu_fwnode)
 {
 	return -ENODEV;
 }
@@ -1331,12 +1328,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline
-const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.39.2.101.g768bb238c484.dirty


