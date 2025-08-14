Return-Path: <linux-acpi+bounces-15708-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 119C5B26D67
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 19:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745A81CE2EC0
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Aug 2025 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD467233722;
	Thu, 14 Aug 2025 17:17:49 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DB1FDA89;
	Thu, 14 Aug 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191869; cv=none; b=Mn1a5Qd1U3ZB4RYQZVg0r9i7v7HyXr983Pge0adD602i+aJwMHumQRHWStF+NWk06ZwdXfLuA90SCNspdxpL33xTrvuFXZ771z8ZeSLS4ToJU+ljOTQSeLobg9dSm63/H8iNsM4A0sFfRYrsHi6+94l0V5bu5kWtJo+WWzyfQhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191869; c=relaxed/simple;
	bh=15XAYO+sq/kHK8xcSoxAlV9cVyAFymsUoB4bUTPGo4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGBg9aGbN2t4DfrY08lYufFhkou0ZqFS10eHNPm83A8u8UMyJo+E3GlnHIbjeFyk+7n1HTbnHc9juHr9RB8xOxX23OKluDmrCluh1OUDFmf3amYsMIv2rjpL/bNm6zXKmChazHctXZoC6FNMQbK+b+t+TNdBjzeF5o8NM7/VhFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896C0C4CEED;
	Thu, 14 Aug 2025 17:17:48 +0000 (UTC)
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
Subject: [PATCH 4/4] acpi/hmat: Remove now unused hmat_update_target_coordinates()
Date: Thu, 14 Aug 2025 10:16:50 -0700
Message-ID: <20250814171650.3002930-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814171650.3002930-1-dave.jiang@intel.com>
References: <20250814171650.3002930-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove deadcode since CXL no longer calls hmat_update_target_coordinates().

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


