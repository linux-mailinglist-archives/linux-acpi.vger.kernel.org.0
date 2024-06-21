Return-Path: <linux-acpi+bounces-6577-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BD912D71
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 20:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AF51F24CFC
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Jun 2024 18:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E23617BB2C;
	Fri, 21 Jun 2024 18:47:06 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B517BB1A;
	Fri, 21 Jun 2024 18:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718995625; cv=none; b=B+yeaMi7VFDR9ejC9mcjUCYcP0C3cX1f3VBwuBUSdqv94n90Dec+yFk7AEh/4iw4fsb+0GhYz0Z7KYacASkBIV3/0dUggd+0zImBj5pryNBv+bVix5FW3rRK5GdlRYUAMgWO1tRrvdH/8bo+dyBekrX7MVFQVYXenj0gxVNxS2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718995625; c=relaxed/simple;
	bh=x+b3UscLqk9o/RdFPBrNQaRZiMic6ySvuoOc3mZdwaQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LxmA6QlVo33W/OLxuP5bKDTlzOSniOZR3pPny6tKBQw/3FJvJQ0beKmQpdtQ1D19hnEktf1G1jrrP6b6oUnxVnrcY2L6Aori1BkLxD/Ejdbad3DapfXwwSQGKKU7tXye9KgJxJeg4QaypwVPd1biCyt1eLrCGxS2OfuW+X4qzeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50CF6139F;
	Fri, 21 Jun 2024 11:47:27 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A74B3F6A8;
	Fri, 21 Jun 2024 11:46:59 -0700 (PDT)
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
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/4] ACPI: Retire acpi_iommu_fwspec_ops()
Date: Fri, 21 Jun 2024 19:46:37 +0100
Message-Id: <ca290d932dd7ef29269422dbda1d366e3c494b78.1718994350.git.robin.murphy@arm.com>
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

Now that iommu_fwspec_init() can signal for probe deferral directly,
acpi_iommu_fwspec_ops() is unneeded and can be cleaned up.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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


