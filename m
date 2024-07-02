Return-Path: <linux-acpi+bounces-6732-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF5D923CA6
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 13:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC2E21F25AD9
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Jul 2024 11:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7587916F84F;
	Tue,  2 Jul 2024 11:41:21 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9CB16F26E;
	Tue,  2 Jul 2024 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920481; cv=none; b=tTY+M2vyjLSj2wJBoX+QtMgslqZzGCAYFd6aRQSo8OgXmjM6Jgzh6M6z676xZ/7yrA+288zVQvx/DkPg1yIOmg91lz4YfvYnoOH6njnmw+ibQxnBfvDe0Uooao0mLXymKVCQelWnuZrs3ldPIE0ZGouWxvPrV4F68KiKG379BMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920481; c=relaxed/simple;
	bh=BsZMpiJ3PnNUi15MSPgknU5OYD2lbSBlecjuX9Xi5EY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FCh2Doh4ryW0IXKA/C7d6alr1fNdFuo5YQNsokq6FNwcB5I15QFcHc4Deo7dj2XMQR5m0YrJK/DolUp36AOGIsVbuurNXgaRB7ZCELNhq8ZQDn8S8M8Ti1GDZY2VXs5TYqIr7Yss9thfQKtHEQi2gjsU27x50FEh8VTJRQ41Ff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88B4F1684;
	Tue,  2 Jul 2024 04:41:44 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0EB403F762;
	Tue,  2 Jul 2024 04:41:16 -0700 (PDT)
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
Subject: [PATCH v3 5/5] iommu: Remove iommu_fwspec ops
Date: Tue,  2 Jul 2024 12:40:51 +0100
Message-Id: <55c1410b2cd09531eab4f8e2f18f92a0faa0ea75.1719919669.git.robin.murphy@arm.com>
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

The ops in iommu_fwspec are only needed for the early configuration and
probe process, and by now are easy enough to derive on-demand in those
couple of places which need them, so remove the redundant stored copy.

Tested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu-priv.h |  5 +++++
 drivers/iommu/iommu.c      | 11 ++---------
 drivers/iommu/of_iommu.c   |  4 +++-
 include/linux/iommu.h      |  2 --
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 078cafcf49b4..a34efed2884b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -19,6 +19,11 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
+static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
+{
+	return iommu_ops_from_fwnode(fwspec ? fwspec->iommu_fwnode : NULL);
+}
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 7618c4285cf9..e15ae1dd494b 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,7 +510,6 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops;
-	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
@@ -523,12 +522,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * be present, and that any of their registered instances has suitable
 	 * ops for probing, and thus cheekily co-opt the same mechanism.
 	 */
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops)
-		ops = fwspec->ops;
-	else
-		ops = iommu_ops_from_fwnode(NULL);
-
+	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
 	if (!ops)
 		return -ENODEV;
 	/*
@@ -2831,7 +2825,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return ops == fwspec->ops ? 0 : -EINVAL;
+		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
@@ -2843,7 +2837,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 
 	fwnode_handle_get(iommu_fwnode);
 	fwspec->iommu_fwnode = iommu_fwnode;
-	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
 	return 0;
 }
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index c946521a5906..559c5db78edb 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
+#include "iommu-priv.h"
+
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
@@ -32,7 +34,7 @@ static int of_iommu_xlate(struct device *dev,
 	if (ret)
 		return ret;
 
-	ops = dev_iommu_fwspec_get(dev)->ops;
+	ops = iommu_ops_from_fwnode(&iommu_spec->np->fwnode);
 	if (!ops->of_xlate || !try_module_get(ops->owner))
 		return -ENODEV;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 81893aad9ee4..11ae1750cb1d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -968,7 +968,6 @@ extern struct iommu_group *generic_single_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
  * @num_ids: number of associated device IDs
@@ -979,7 +978,6 @@ extern struct iommu_group *generic_single_device_group(struct device *dev);
  * consumers.
  */
 struct iommu_fwspec {
-	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
 	unsigned int		num_ids;
-- 
2.39.2.101.g768bb238c484.dirty


