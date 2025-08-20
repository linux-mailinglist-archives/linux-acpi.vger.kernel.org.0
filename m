Return-Path: <linux-acpi+bounces-15875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE7DB2E5D3
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 21:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 214F5A28785
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70908285CB5;
	Wed, 20 Aug 2025 19:47:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51205285CAE;
	Wed, 20 Aug 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755719274; cv=none; b=X5L7gpFjwSDZUoZItRxYYjAiUq1RCTTV7/KrRzd3d1yQWZZgwHF+XSv1fi456pwio8+jYHufWootGGQMSnmBfVxhAjlBEOAN6BLGGB3jxVKuqNlCfMHB0a+5udyKdxXTPOI8vi3gCh5ghrFB52NQcxozIvM+fFEunY5P0JpXTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755719274; c=relaxed/simple;
	bh=/DQq03KGSTjhQvFJPs2txX2xLrZURgkekgphV6n/h6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhz2IpRPkNbAjDi4N/QDuG6Lzxe5uPG1TLRKFektQJNqsjg+mP5bvm7ZdBVEaaDA6w666S04iZuD8x2vMTm3jiq0nmMBK7jC/UujRlfHhnfU2M5oGHiMQO+auuutBSVmdDXWKJdZDXXDGo42/6Q3E0y4rpZ4Ur5r7skEpYyj1fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A7DC4CEE7;
	Wed, 20 Aug 2025 19:47:52 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	marc.herbert@linux.intel.com,
	akpm@linux-foundation.org,
	david@redhat.com
Subject: [PATCH v2 4/4] acpi/hmat: Remove now unused hmat_update_target_coordinates()
Date: Wed, 20 Aug 2025 12:47:04 -0700
Message-ID: <20250820194704.4130565-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820194704.4130565-1-dave.jiang@intel.com>
References: <20250820194704.4130565-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove deadcode since CXL no longer calls hmat_update_target_coordinates().

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/acpi/numa/hmat.c | 28 ----------------------------
 drivers/cxl/core/cdat.c  |  6 ------
 drivers/cxl/core/core.h  |  2 --
 include/linux/acpi.h     | 12 ------------
 4 files changed, 48 deletions(-)

diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
index 5d32490dc4ab..5a36d57289b4 100644
--- a/drivers/acpi/numa/hmat.c
+++ b/drivers/acpi/numa/hmat.c
@@ -367,34 +367,6 @@ static void hmat_update_target_access(struct memory_target *target,
 	}
 }
 
-int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
-				   enum access_coordinate_class access)
-{
-	struct memory_target *target;
-	int pxm;
-
-	if (nid == NUMA_NO_NODE)
-		return -EINVAL;
-
-	pxm = node_to_pxm(nid);
-	guard(mutex)(&target_lock);
-	target = find_mem_target(pxm);
-	if (!target)
-		return -ENODEV;
-
-	hmat_update_target_access(target, ACPI_HMAT_READ_LATENCY,
-				  coord->read_latency, access);
-	hmat_update_target_access(target, ACPI_HMAT_WRITE_LATENCY,
-				  coord->write_latency, access);
-	hmat_update_target_access(target, ACPI_HMAT_READ_BANDWIDTH,
-				  coord->read_bandwidth, access);
-	hmat_update_target_access(target, ACPI_HMAT_WRITE_BANDWIDTH,
-				  coord->write_bandwidth, access);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(hmat_update_target_coordinates);
-
 static __init void hmat_add_locality(struct acpi_hmat_locality *hmat_loc)
 {
 	struct memory_locality *loc;
diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index c891fd618cfd..bca1ec279651 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -1075,9 +1075,3 @@ void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
 		cxlr->coord[i].write_bandwidth += perf->coord[i].write_bandwidth;
 	}
 }
-
-int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
-				       enum access_coordinate_class access)
-{
-	return hmat_update_target_coordinates(nid, &cxlr->coord[access], access);
-}
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a253d308f3c9..0476c3b648de 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -137,8 +137,6 @@ enum cxl_poison_trace_type {
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
 int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
-int cxl_update_hmat_access_coordinates(int nid, struct cxl_region *cxlr,
-				       enum access_coordinate_class access);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 1c5bb1e887cd..5ff5d99f6ead 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1595,18 +1595,6 @@ static inline void acpi_use_parent_companion(struct device *dev)
 	ACPI_COMPANION_SET(dev, ACPI_COMPANION(dev->parent));
 }
 
-#ifdef CONFIG_ACPI_HMAT
-int hmat_update_target_coordinates(int nid, struct access_coordinate *coord,
-				   enum access_coordinate_class access);
-#else
-static inline int hmat_update_target_coordinates(int nid,
-						 struct access_coordinate *coord,
-						 enum access_coordinate_class access)
-{
-	return -EOPNOTSUPP;
-}
-#endif
-
 #ifdef CONFIG_ACPI_NUMA
 bool acpi_node_backed_by_real_pxm(int nid);
 #else
-- 
2.50.1


