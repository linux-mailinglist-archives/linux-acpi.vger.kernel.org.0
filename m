Return-Path: <linux-acpi+bounces-6728-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAED0923C98
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7AD1F24EB2
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5C115B98E;
	Tue,  2 Jul 2024 11:41:07 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB81715B14B;
	Tue,  2 Jul 2024 11:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920467; cv=none; b=q/O9n5yGsqRp/9unb1AgVQ5gEj4d8XlV1Ek6m+cnb/cCWoUjXXbHAB+by8xEoywECwmB7LEeyS4P95NYBTT+64fI3smS62tRJ5a+/0TM1sOonYanMuMwms05trf6xbzEULEKGp6K4nVNIu5OPCQ9+j6g5nI9iVfCkyJnN5bbRyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920467; c=relaxed/simple;
	bh=hfEJs1gkeEQdyNaK+wqqCw79vNaQY4ElX5/JIOzLXT4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiAxtp9ycuKY1t7jFXZq4t0LszjUm8GyMEp/ZfjGyMx+YUhGTE4ZBTLk2d+6juQGnguNKtazaQj2H1vQyWCGp/8BOJFbCj/WPVlxz48oHZayUozMsJr0noRopeWI3CdWu7fgQciAg4AMeH/X1ng9dLJdXJk3HHmTIHMKJcpyn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A086367;
	Tue,  2 Jul 2024 04:41:30 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9FE5A3F762;
	Tue,  2 Jul 2024 04:41:02 -0700 (PDT)
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
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 1/5] iommu/mediatek-v1: Clean up redundant fwspec checks
Date: Tue,  2 Jul 2024 12:40:47 +0100
Message-Id: <7d6ebec135483f889af00eb376aa31c012efc3b2.1719919669.git.robin.murphy@arm.com>
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

The driver explicitly clears any existing fwspec before calling
mtk_iommu_v1_create_mapping(), but even if it didn't, the checks it's
doing there duplicate what iommu_fwspec_init() would do anyway. Clean
them up.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407020415.KKnhPTUj-lkp@intel.com/
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/mtk_iommu_v1.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index d6e4002200bd..2b64ea46318f 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -401,7 +401,6 @@ static const struct iommu_ops mtk_iommu_v1_ops;
 static int mtk_iommu_v1_create_mapping(struct device *dev,
 				       const struct of_phandle_args *args)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct mtk_iommu_v1_data *data;
 	struct platform_device *m4updev;
 	struct dma_iommu_mapping *mtk_mapping;
@@ -413,14 +412,9 @@ static int mtk_iommu_v1_create_mapping(struct device *dev,
 		return -EINVAL;
 	}
 
-	if (!fwspec) {
-		ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
-		if (ret)
-			return ret;
-		fwspec = dev_iommu_fwspec_get(dev);
-	} else if (dev_iommu_fwspec_get(dev)->ops != &mtk_iommu_v1_ops) {
-		return -EINVAL;
-	}
+	ret = iommu_fwspec_init(dev, &args->np->fwnode, &mtk_iommu_v1_ops);
+	if (ret)
+		return ret;
 
 	if (!dev_iommu_priv_get(dev)) {
 		/* Get the m4u device */
-- 
2.39.2.101.g768bb238c484.dirty


