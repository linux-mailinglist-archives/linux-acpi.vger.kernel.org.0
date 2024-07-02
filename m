Return-Path: <linux-acpi+bounces-6731-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7BB923CA4
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191971F258BD
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 11:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBF16DECF;
	Tue,  2 Jul 2024 11:41:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE77316DC1E;
	Tue,  2 Jul 2024 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920477; cv=none; b=LvSyri0IbFRGXAxP1dRxZWEtT3f47HYbNPEV4BNG+dSFs58gpiDJmnm+RooJAYJTKyikEs7C4ME4LIsB5Y/i5UeX8ESVDUzdleKlpRvdIli0tn1Xgx+CyGUjZGouz+Bfb61hnTGw2lzdRJjoHJzlPWbW7nI1NsRKHLpdqDYbmr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920477; c=relaxed/simple;
	bh=hyZKLLFuqAMmpR6FtUIJzwsePdqKy/SUf0lqZExA6Kw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+FLEuEA02rEfoIqU/L6S+uOiUuHdyHOIqAPnBUKynJmkuk8Ac+KMabUXKOsNNvCWahKlpkjcX/jvUOjDJZ2dUxhIEqjhyBMT/4IG1mYiAwltNYKnJxrQqnygbuiBoH5ss8KIQZLhKCRGdnXnS043S0PCX96IWKThSVuIyzuCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84F341655;
	Tue,  2 Jul 2024 04:41:40 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8A113F762;
	Tue,  2 Jul 2024 04:41:12 -0700 (PDT)
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
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Yong Wu <yong.wu@mediatek.com>
Subject: [PATCH v3 4/5] OF: Simplify of_iommu_configure()
Date: Tue,  2 Jul 2024 12:40:50 +0100
Message-Id: <61972f88e31a6eda8bf5852f0853951164279a3c.1719919669.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1719919669.git.robin.murphy@arm.com>
References: <cover.1719919669.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We no longer have a notion of partially-initialised fwspecs existing,
and we also no longer need to use an iommu_ops pointer to return status
to of_dma_configure(). Clean up the remains of those, which lends itself
to clarifying the logic around the dma_range_map allocation as well.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/of_iommu.c | 29 ++++++++++-------------------
 drivers/of/device.c      | 30 +++++++++++-------------------
 2 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 08c523ad55ad..c946521a5906 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -108,7 +108,6 @@ static int of_iommu_configure_device(struct device_node *master_np,
 int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		       const u32 *id)
 {
-	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
@@ -116,14 +115,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec) {
-		if (fwspec->ops) {
-			mutex_unlock(&iommu_probe_device_lock);
-			return 0;
-		}
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
+	if (dev_iommu_fwspec_get(dev)) {
+		mutex_unlock(&iommu_probe_device_lock);
+		return 0;
 	}
 
 	/*
@@ -143,20 +137,17 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 	} else {
 		err = of_iommu_configure_device(master_np, dev, id);
 	}
+
+	if (err)
+		iommu_fwspec_free(dev);
 	mutex_unlock(&iommu_probe_device_lock);
 
-	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		goto err_log;
+	if (!err && dev->bus)
+		err = iommu_probe_device(dev);
 
-	err = iommu_probe_device(dev);
-	if (err)
-		goto err_log;
-	return 0;
+	if (err && err != -EPROBE_DEFER)
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 
-err_log:
-	dev_dbg(dev, "Adding to IOMMU failed: %pe\n", ERR_PTR(err));
 	return err;
 }
 
diff --git a/drivers/of/device.c b/drivers/of/device.c
index 312c63361211..edf3be197265 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -96,8 +96,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	const struct bus_dma_region *map = NULL;
 	struct device_node *bus_np;
 	u64 mask, end = 0;
-	bool coherent;
-	int iommu_ret;
+	bool coherent, set_map = false;
 	int ret;
 
 	if (np == dev->of_node)
@@ -118,6 +117,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	} else {
 		/* Determine the overall bounds of all DMA regions */
 		end = dma_range_map_max(map);
+		set_map = true;
 	}
 
 	/*
@@ -144,7 +144,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 	/* ...but only set bus limit and range map if we found valid dma-ranges earlier */
-	if (!ret) {
+	if (set_map) {
 		dev->bus_dma_limit = end;
 		dev->dma_range_map = map;
 	}
@@ -153,29 +153,21 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
-	iommu_ret = of_iommu_configure(dev, np, id);
-	if (iommu_ret == -EPROBE_DEFER) {
+	ret = of_iommu_configure(dev, np, id);
+	if (ret == -EPROBE_DEFER) {
 		/* Don't touch range map if it wasn't set from a valid dma-ranges */
-		if (!ret)
+		if (set_map)
 			dev->dma_range_map = NULL;
 		kfree(map);
 		return -EPROBE_DEFER;
-	} else if (iommu_ret == -ENODEV) {
-		dev_dbg(dev, "device is not behind an iommu\n");
-	} else if (iommu_ret) {
-		dev_err(dev, "iommu configuration for device failed with %pe\n",
-			ERR_PTR(iommu_ret));
-
-		/*
-		 * Historically this routine doesn't fail driver probing
-		 * due to errors in of_iommu_configure()
-		 */
-	} else
-		dev_dbg(dev, "device is behind an iommu\n");
+	}
+	/* Take all other IOMMU errors to mean we'll just carry on without it */
+	dev_dbg(dev, "device is%sbehind an iommu\n",
+		!ret ? " " : " not ");
 
 	arch_setup_dma_ops(dev, coherent);
 
-	if (iommu_ret)
+	if (ret)
 		of_dma_set_restricted_buffer(dev, np);
 
 	return 0;
-- 
2.39.2.101.g768bb238c484.dirty


