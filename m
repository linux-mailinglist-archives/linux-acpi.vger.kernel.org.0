Return-Path: <linux-acpi+bounces-6730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F273923CA1
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254C5B22CB0
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 11:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0CA16B732;
	Tue,  2 Jul 2024 11:41:14 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40E016728E;
	Tue,  2 Jul 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920474; cv=none; b=e6ezl1+BVs5mhaTFuN8ioYk6ep+q8Gk6ZZAkPFZLzfmR2QuKiJ4vgTco/7AAmYR2PZuCiF+lBbVQqUotLEFQuFin4Yx2pEKm9z0wpxT8NMrvaPW3RuGSshjAn5caxA+dukZY+jK3eqtQqQKVvCfUQ3cJwkpfEOsw+Zqc8Vq/Gi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920474; c=relaxed/simple;
	bh=KLI7RwevKToSjonuk0SjrUo2aHU+EbF6Srl8Ej/aGIc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h7X3MSzAIomDLGtVTGOJlkGLlWhczteq+AOqOnvWP+KFknEr5r+EGC4CSJP7yA7FstKQelG50zHhecmA6wl0yEoZW+5v94eScrQzdYyFDxQYwP43Hdt4CpTp22chjQR/cE1aBbcgXEHFE7P2cvtxQToPuHhuSFv1RH6zlQ3kZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36B7B1515;
	Tue,  2 Jul 2024 04:41:37 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7454F3F762;
	Tue,  2 Jul 2024 04:41:09 -0700 (PDT)
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
	Yong Wu <yong.wu@mediatek.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v3 3/5] ACPI: Retire acpi_iommu_fwspec_ops()
Date: Tue,  2 Jul 2024 12:40:49 +0100
Message-Id: <011e39e275aba3ad451c5a1965ca8ddf20ed36c2.1719919669.git.robin.murphy@arm.com>
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

Now that iommu_fwspec_init() can signal for probe deferral directly,
acpi_iommu_fwspec_ops() is unneeded and can be cleaned up.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/acpi/scan.c | 28 +++++-----------------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8d5a589db141..2cfbb365c4ab 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1588,26 +1588,14 @@ int acpi_iommu_fwspec_init(struct device *dev, u32 id,
 	return iommu_fwspec_add_ids(dev, &id, 1);
 }
 
-static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->ops : NULL;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
-	const struct iommu_ops *ops;
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
 	mutex_lock(&iommu_probe_device_lock);
-	/*
-	 * If we already translated the fwspec there is nothing left to do,
-	 * return the iommu_ops.
-	 */
-	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops) {
+	/* If we already translated the fwspec there is nothing left to do */
+	if (dev_iommu_fwspec_get(dev)) {
 		mutex_unlock(&iommu_probe_device_lock);
 		return 0;
 	}
@@ -1624,15 +1612,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	if (!err && dev->bus)
 		err = iommu_probe_device(dev);
 
-	if (err == -EPROBE_DEFER)
-		return err;
-	if (err) {
-		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
-		return err;
-	}
-	if (!acpi_iommu_fwspec_ops(dev))
-		return -ENODEV;
-	return 0;
+	return err;
 }
 
 #else /* !CONFIG_IOMMU_API */
@@ -1672,6 +1652,8 @@ int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 	ret = acpi_iommu_configure_id(dev, input_id);
 	if (ret == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
+	if (ret)
+		dev_dbg(dev, "Adding to IOMMU failed: %d\n", ret);
 
 	arch_setup_dma_ops(dev, attr == DEV_DMA_COHERENT);
 
-- 
2.39.2.101.g768bb238c484.dirty


